# Presupuesto de sesión fotográfica automático…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Un formulario recoge lo que quiere el cliente y en dos minutos le llega un presupuesto en PDF con precio, condiciones y un botón para reservar.

## Qué es y qué hace

Un formulario público recoge tipo de sesión, personas, horas, ciudad, fotos retocadas y extras. Al enviarlo, n8n calcula el precio con tus reglas, genera un PDF con tus condiciones, lo manda al cliente y te avisa con el resumen. Entran respuestas de formulario y salen presupuestos en PDF y avisos. Para fotógrafos, videógrafos y estudios que dan precios a medida, con n8n, Tally y un servicio de PDF.

## Cómo usarla

1. Define tus reglas de precio en una tabla
2. Crea el formulario en Tally
3. Genera la plantilla de PDF
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando pierdes clientes porque tardas dos días en pasar el presupuesto, o cuando repites el mismo Word cambiando cuatro números.

## Cómo ganar dinero con ella

Responder en minutos en vez de en días multiplica por 2-3 la conversión de presupuestos. Y ahorras 30 minutos por cada uno.

- Implantación de presupuestos automáticos para fotógrafos que dan precios a medida, cobrada por puesta en marcha.
- Gestión mensual de presupuestos y seguimiento para estudios con mucha demanda, por cuota.
- Plantilla de presupuesto vendida a videógrafos y organizadores de eventos.

**Precio orientativo:** 150–300 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un formulario público pregunta tipo de sesión, número de personas, duración, desplazamiento, número de fotos retocadas y extras. Al enviarlo, el flujo calcula el precio con tus reglas, genera un PDF con tu diseño y tus condiciones, se lo manda al cliente y te avisa a ti con el resumen.
Para fotógrafos, videógrafos y estudios que dan precios a medida y quieren dejar de escribir el mismo correo.

## Lo que necesitas antes
- Formulario en tally.so (gratis) o Typeform. Campos: nombre, email, teléfono, tipo de sesión (selección), personas (número), horas (número), ciudad, fotos retocadas (número), extras (casillas: álbum, maquillaje, segunda localización), fecha deseada.
- En Tally: Integrations > Webhooks > pega la URL que te dará n8n.
- Cuenta en pdfshift.io: 50 PDF al mes gratis. Copia la `API key`. Alternativa gratis del todo: usa un nodo **HTML** y manda el presupuesto como email en HTML, sin PDF.
- Hoja `Presupuestos` con columnas: `fecha`, `nombre`, `email`, `tipo`, `total`, `estado`, `enlace_pdf`.

## Los nodos, en orden
1. **Webhook** — HTTP Method `POST`, Path `presupuesto-foto`. Copia la Production URL y pégala en Tally. Respond: `Immediately`.
2. **Code** (`Calcular precio`) — aplica tu tarifa. Es el corazón de la receta; el código está abajo y lo tienes que tocar tú con tus precios.
3. **Code** (`Montar HTML`) — genera el documento. Puedes usar en su lugar un nodo **HTML** con la plantilla y expresiones.
4. **HTTP Request** (`Generar PDF`) — Method `POST`. URL `https://api.pdfshift.io/v3/convert/pdf`. Authentication `Basic Auth`: usuario `api`, contraseña tu clave. Body JSON: `{"source": "={{ $json.html }}", "landscape": false, "format": "A4"}`. Response Format `File`, campo `data`.
5. **Google Drive** — `Upload` a una carpeta `PRESUPUESTOS`, nombre `Presupuesto-{{ $json.nombre }}-{{ $json.fecha }}.pdf`. Y a continuación un **Google Drive** con Operation `Share`, Type `anyone`, Role `reader`, para tener enlace.
6. **Gmail** — al cliente. Asunto: `Tu presupuesto para la sesión de {{ $json.tipo }}`. Adjunta el PDF (Options > Attachments > campo binario `data`).
7. **Gmail** — a ti. Asunto: `NUEVO PRESUPUESTO {{ $json.total }} € — {{ $json.nombre }}`.
8. **Google Sheets** — `Append Row` en `Presupuestos`.
9. Opcional: **Wait** de 3 días y luego un **Gmail** de seguimiento si el estado sigue en `ENVIADO`.

## El código del nodo Calcular precio
```javascript
const d = $json.data?.fields ? Object.fromEntries($json.data.fields.map(f => [f.label, f.value])) : $json;
const TARIFAS = { 'Retrato': 180, 'Producto': 250, 'Evento': 400, 'Boda': 1400, 'Inmobiliaria': 150 };
const HORA_EXTRA = 90;
const FOTO_RETOCADA = 12;
const KM = 0.35;
const EXTRAS = { 'album': 220, 'maquillaje': 120, 'segunda localizacion': 150 };
const tipo = d['Tipo de sesion'] || d.tipo || 'Retrato';
let base = TARIFAS[tipo] || 200;
const horas = Number(d['Horas'] || d.horas || 1);
const horasExtra = Math.max(0, horas - 2);
const fotos = Number(d['Fotos retocadas'] || d.fotos || 10);
const fotosExtra = Math.max(0, fotos - 10);
const km = Number(d['Kilometros'] || d.km || 0);
const extrasElegidos = [].concat(d['Extras'] || d.extras || []).map(x => String(x).toLowerCase());
const lineas = [{ concepto: `Sesion de ${tipo} (2 h, 10 fotos retocadas)`, importe: base }];
if (horasExtra > 0) lineas.push({ concepto: `${horasExtra} h adicionales`, importe: horasExtra * HORA_EXTRA });
if (fotosExtra > 0) lineas.push({ concepto: `${fotosExtra} fotos retocadas extra`, importe: fotosExtra * FOTO_RETOCADA });
if (km > 20) lineas.push({ concepto: `Desplazamiento ${km} km`, importe: Math.round(km * KM) });
for (const e of extrasElegidos) { if (EXTRAS[e]) lineas.push({ concepto: e, importe: EXTRAS[e] }); }
const subtotal = lineas.reduce((s, l) => s + l.importe, 0);
const iva = Math.round(subtotal * 0.21);
return { json: {
  nombre: d['Nombre'] || d.nombre, email: d['Email'] || d.email, tipo,
  lineas, subtotal, iva, total: subtotal + iva,
  fecha: new Date().toLocaleDateString('es-ES'),
  validez: new Date(Date.now() + 15*86400000).toLocaleDateString('es-ES')
}};
```

## El código del nodo Montar HTML
```javascript
const d = $json;
const filas = d.lineas.map(l => `<tr><td style="padding:10px;border-bottom:1px solid #eee">${l.concepto}</td><td style="padding:10px;border-bottom:1px solid #eee;text-align:right">${l.importe} &euro;</td></tr>`).join('');
const html = `<html><body style="font-family:Helvetica,Arial,sans-serif;color:#222;padding:40px">
<h1 style="font-size:26px;margin:0">Presupuesto</h1>
<p style="color:#777">${d.fecha} &middot; Valido hasta el ${d.validez}</p>
<p><b>Cliente:</b> ${d.nombre}<br><b>Servicio:</b> ${d.tipo}</p>
<table style="width:100%;border-collapse:collapse;margin-top:20px">${filas}
<tr><td style="padding:10px;text-align:right">Subtotal</td><td style="padding:10px;text-align:right">${d.subtotal} &euro;</td></tr>
<tr><td style="padding:10px;text-align:right">IVA 21%</td><td style="padding:10px;text-align:right">${d.iva} &euro;</td></tr>
<tr><td style="padding:12px;text-align:right;font-size:18px"><b>TOTAL</b></td><td style="padding:12px;text-align:right;font-size:18px"><b>${d.total} &euro;</b></td></tr></table>
<h3>Condiciones</h3><ul><li>Reserva de fecha con el 30% por adelantado.</li><li>Entrega de la galeria en 15 dias habiles.</li><li>Cesion de uso para redes y web del cliente; usos publicitarios se presupuestan aparte.</li><li>Cancelacion con menos de 7 dias: se retiene la reserva.</li></ul>
</body></html>`;
return { json: { ...d, html } };
```

## Cómo probarla
- Rellena tú mismo el formulario con datos raros: 0 horas, 200 fotos, una ciudad lejísimos. Comprueba que el precio no sale absurdo ni negativo.
- Abre el PDF en el móvil: es donde lo va a leer el cliente.
- Manda el primero a un amigo y pregúntale si entiende qué incluye y qué no.

## Qué puede salir mal
- **El webhook no recibe nada.** Recuerda que la URL de test de n8n solo escucha mientras pulsas `Listen for test event`. La buena es la Production URL, y el workflow tiene que estar `Active`.
- **Los nombres de los campos de Tally no coinciden.** Ejecuta una vez, mira el JSON que llega en el nodo Webhook y ajusta las claves en el Code. Es el paso que más se atasca.
- **IVA.** Si estás en recargo de equivalencia o facturas fuera de España, cambia la línea del 21%. Y recuerda: un presupuesto no es una factura, no lo numeres como tal.
- **El PDF sale con tipografía rara.** PDFShift no carga fuentes externas por defecto; usa Helvetica, Arial o Georgia y no te compliques.

## Cuánto cuesta
- Tally: gratis con formularios ilimitados.
- PDFShift: 50 PDF/mes gratis, luego desde 9 $/mes. Si te quedas corto, manda el presupuesto como email HTML y ahorras el PDF.
- n8n auto-alojado, Gmail, Drive y Sheets: 0 €.
