# De encargo entregado a factura cobrada, para freelance…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cuando marcas un encargo como entregado, se genera la factura en PDF con tu numeración, se manda al cliente y, si no paga, le llegan recordatorios cada vez más firmes.

## Qué es y qué hace

Cuando marcas un encargo como entregado en una hoja, n8n rellena una plantilla de Google Docs con los datos del cliente y las partidas, la convierte en PDF, la envía por correo y programa recordatorios a los 15, 30 y 45 días si no cobras. Entrada: fila de encargo; salida: factura en PDF y avisos de cobro. La numeración y los impuestos los defines tú con tu asesor.

## Cómo usarla

1. Preparar la hoja encargos y la plantilla de factura
2. Conectar Sheets, Docs y Gmail en n8n
3. Probar con un encargo de prueba
4. Que lo revise un profesional

## Cuándo usarla

Cuando haces modelados, animaciones o renders por encargo y siempre se te acumulan facturas por emitir y cobros por reclamar.

## Cómo ganar dinero con ella

Ahorra 2-3 horas al mes de papeleo y acorta el plazo medio de cobro: la mayoría de retrasos se arreglan solos con un recordatorio automático al día 15.

- Configurar la facturación automática para autónomos de animación y modelado, cobrando una instalación única.
- Mantener las plantillas y los recordatorios de cobro de un pequeño estudio con una cuota mensual.
- Montar un panel de cobros pendientes para un equipo de freelances 3D.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una hoja de encargos; cuando uno pasa a `entregado`, rellena una plantilla de factura en Google Docs con los datos del cliente y las partidas, la convierte en PDF, la envía por correo y programa recordatorios a los 15, 30 y 45 días si sigue sin cobrar. Para artistas 3D, animadores y modeladores autónomos en España.

## Lo que necesitas antes
- Google Sheet `encargos` con columnas: `id`, `cliente`, `nif`, `direccion`, `email`, `concepto`, `horas`, `precio_hora`, `base`, `irpf_pct`, `iva_pct`, `estado`, `num_factura`, `fecha_factura`, `pdf_url`, `fecha_cobro`.
- Una segunda pestaña `contador` con una sola celda que guarde el último número de factura emitido.
- Una plantilla en Google Docs con marcadores literales: `{{NUM}}`, `{{FECHA}}`, `{{CLIENTE}}`, `{{NIF}}`, `{{DIRECCION}}`, `{{CONCEPTO}}`, `{{BASE}}`, `{{IRPF}}`, `{{IVA}}`, `{{TOTAL}}`, más tus propios datos fiscales fijos.
- Credenciales de Google (Sheets, Docs, Drive, Gmail) en n8n.
- Tus datos: NIF, dirección, número de cuenta y el IRPF que aplicas (normalmente 15 %, o 7 % los tres primeros años de actividad).

## Los nodos, en orden
1. **Schedule Trigger** — Cron: `0 9 * * *`, todos los días a las 9.
2. **Google Sheets** (`Encargos entregados`) — Get Row(s), Filter: `estado` equals `entregado` (es decir, entregado pero aún sin factura).
3. **Google Sheets** (`Leer contador`) — lee la pestaña `contador`.
4. **Code** (`Calcular factura`) — calcula base, IRPF, IVA, total y el número correlativo. Código abajo.
5. **Google Drive** (`Copiar plantilla`) — Operation: `Copy File`. File: tu plantilla. Name: `Factura {{ $json.num_factura }} - {{ $json.cliente }}`. Folder: `facturas-emitidas`.
6. **Google Docs** (`Rellenar`) — Operation: `Update a Document`. Doc ID: `{{ $json.id }}` del paso anterior. Actions: una acción `Replace All Text` por cada marcador, por ejemplo Search `{{CLIENTE}}` / Replace `{{ $('Calcular factura').item.json.cliente }}`.
7. **HTTP Request** (`Exportar PDF`) — GET `https://www.googleapis.com/drive/v3/files/{{ $json.documentId }}/export?mimeType=application/pdf`, con la credencial predefinida de Google Drive OAuth2 y Response Format: `File`, Output Field: `data`.
8. **Google Drive** (`Guardar PDF`) — Upload, nombre `{{ $json.num_factura }}.pdf`, carpeta `facturas-emitidas`.
9. **Gmail** — Send. To: `{{ $json.email }}`. Subject: `Factura {{ $json.num_factura }} — {{ $json.concepto }}`. Message: texto breve con el importe, la forma de pago y el vencimiento. Attachments: el binario `data`.
10. **Google Sheets** (`Marcar facturado`) — Update Row: `estado` = `facturado`, `num_factura`, `fecha_factura`, `pdf_url`. Y actualiza también la pestaña `contador`.
11. **Segunda rama del mismo Schedule** — **Google Sheets** con Filter `estado` equals `facturado`, y un **Code** que calcule los días transcurridos desde `fecha_factura`.
12. **Switch** — salida 1 si días = 15, salida 2 si días = 30, salida 3 si días = 45.
13. **Gmail** x3 — tres textos distintos: el de 15 días amable («por si se te ha traspapelado»), el de 30 firme (recordando el vencimiento acordado) y el de 45 formal, mencionando que a partir de ahí aplicas los intereses de demora de la Ley 3/2004 de morosidad.

## El código de `Calcular factura`
```javascript
const contador = Number($('Leer contador').first().json.ultimo) || 0;
const salida = [];
let n = contador;
const año = $now.toFormat('yyyy');
for (const item of $input.all()) {
  const e = item.json;
  n = n + 1;
  const base = Number(e.base) || (Number(e.horas) * Number(e.precio_hora));
  const irpfPct = Number(e.irpf_pct ?? 15);
  const ivaPct = Number(e.iva_pct ?? 21);
  const irpf = Math.round(base * irpfPct) / 100;
  const iva = Math.round(base * ivaPct) / 100;
  const total = Math.round((base + iva - irpf) * 100) / 100;
  const eur = v => v.toFixed(2).replace('.', ',') + ' €';
  salida.push({ json: {
    id: e.id,
    cliente: e.cliente,
    nif: e.nif,
    direccion: e.direccion,
    email: e.email,
    concepto: e.concepto,
    num_factura: año + '-' + String(n).padStart(3, '0'),
    fecha: $now.toFormat('dd/MM/yyyy'),
    base_txt: eur(base),
    irpf_txt: '-' + eur(irpf) + ' (' + irpfPct + ' %)',
    iva_txt: eur(iva) + ' (' + ivaPct + ' %)',
    total_txt: eur(total),
    total: total,
    ultimo: n
  } });
}
return salida;
```

## Cómo probarla
- Crea un encargo falso con tu propio correo como cliente y ejecuta a mano. Abre el PDF: comprueba que no queda ningún `{{MARCADOR}}` sin sustituir y que los importes cuadran con una calculadora.
- Prueba con dos encargos a la vez: la numeración debe salir correlativa, sin repetir. Si repite, es que el contador se actualiza fuera del bucle.
- Para probar los recordatorios, pon a mano una `fecha_factura` de hace 15 días en una fila de prueba.

## Qué puede salir mal
- **Numeración con huecos o repetida**: es lo más grave, porque Hacienda exige numeración correlativa sin saltos. Actualiza el contador en el mismo paso en que emites, y no borres nunca una factura ya emitida: si te equivocas, emite una rectificativa.
- **IRPF donde no toca**: si tu cliente es una empresa extranjera, no se retiene IRPF; si es un particular español, tampoco. Deja la columna `irpf_pct` por encargo y ponla a 0 en esos casos.
- **IVA en ventas intracomunitarias**: a una empresa de la UE con VIES válido facturas sin IVA con la mención de inversión del sujeto pasivo. Añade una columna `tipo_cliente` y una variante de plantilla.
- **Gmail marca tus recordatorios como spam** si mandas muchos: no pasa con volúmenes de freelance, pero escribe siempre desde tu dominio si lo tienes.
- **Esto no sustituye a tu gestor**: genera el documento, no presenta el modelo 303 ni el 130. Guarda los PDF ordenados y pásaselos.

## Cuánto cuesta
- Google Sheets, Docs, Drive y Gmail: **gratis** con cuenta personal.
- n8n auto-alojado: gratis. n8n Cloud desde ~20 €/mes.
- Comparado con un programa de facturación (de 10 a 25 €/mes), te ahorras la cuota; a cambio, tú mantienes la plantilla. Ojo con la normativa española de facturación electrónica y Verifactu: si te aplica, revisa con tu gestor antes de usar esto como sistema principal.
