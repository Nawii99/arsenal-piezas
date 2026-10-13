# Escalado de morosos por tramos con parada automática…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Reclama las facturas impagadas solo, subiendo el tono según los días de retraso (recordatorio suave, aviso formal, preaviso legal) y deja de reclamar en cuanto detecta el cobro.

## Qué es y qué hace

Cada mañana revisa las facturas de una hoja de Google Sheets, calcula los días de retraso y envía por Gmail el aviso del tramo que toca: 3, 15, 30 o 45 días. Antes de cada envío comprueba si la factura ya está cobrada y, pasados 45 días, para y te avisa por Telegram para que llames. Para autónomos y pymes que facturan a empresas.

## Cómo usarla

1. Preparar la hoja Cobros con estado y último aviso
2. Conectar Gmail y Telegram en n8n
3. Probar con facturas ficticias
4. Que lo revise un profesional

## Cuándo usarla

Cuando tienes facturas vencidas y te da pereza o vergüenza reclamar, así que acaban olvidadas.

## Cómo ganar dinero con ella

Reclamar de forma sistemática adelanta el cobro entre 10 y 25 días de media y recupera facturas que se habrían dado por perdidas.

- Gestión automática de impagados para una gestoría que reclama a los clientes de sus asesorados.
- Revisión mensual de la cartera de morosos con informe y recomendaciones de cobro para pymes.
- Plantilla de reclamación escalonada que el autónomo ofrece como servicio de seguimiento de cobros.

**Precio orientativo:** 200–400 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada mañana mira tus facturas pendientes, calcula los días de retraso y manda el email que toca según el tramo: 3 días (suave), 15 (firme), 30 (formal con intereses de demora), 45 (aviso previo a reclamación).
Antes de mandar nada comprueba si la factura ya está marcada como cobrada y, si el retraso pasa de 45 días, deja de mandar emails y te avisa a ti por Telegram para que llames. Para autónomos y pymes que facturan a empresas.

## Lo que necesitas antes
Hoja de Google Sheets `Cobros` con columnas: `numero`, `cliente`, `email`, `total`, `fecha_emision`, `fecha_vencimiento` (texto `yyyy-mm-dd`), `estado` (pendiente/cobrado), `ultimo_aviso` (vacío o número de tramo), `fecha_ultimo_aviso`.
Gmail conectado a n8n con credencial OAuth2 (Google Cloud Console > Credenciales > ID de cliente OAuth de tipo Aplicación web, activando la API de Gmail).
Bot de Telegram para tus avisos internos.
Saber el dato legal: la Ley 3/2004 permite reclamar intereses de demora y 40 euros de compensación por costes de cobro en operaciones entre empresas. Menciónalo solo en el tramo 3.

## Los nodos, en orden
**1. Schedule Trigger** — Cada día a las 10:00, `Europe/Madrid`. Evita fines de semana con un IF si quieres.
**2. Google Sheets** (`Pendientes`) — `Get Row(s)`, hoja `Cobros`, con `Filters`: columna `estado`, valor `pendiente`.
**3. Code** (`Decidir tramo`) — `Run Once for All Items`. Código abajo.
**4. Filter** — Condición: `{{ $json.enviar }}` `is true`.
**5. Switch** — Modo `Rules`, valor `={{ $json.tramo }}`, salidas 1, 2, 3 y 4.
**6. Gmail** (uno por salida 1, 2 y 3) — Operación `Send`, `To` = `={{ $json.email }}`, `Subject` = `={{ $json.asunto }}`, `Message` = `={{ $json.cuerpo }}`, tipo `HTML`.
**7. Telegram** (salida 4) — `Send Message`: `🚨 {{ $json.cliente }} lleva {{ $json.dias }} días con la factura {{ $json.numero }} ({{ $json.total }} €). Toca llamar o pasar a reclamación.`
**8. Google Sheets** (`Marcar aviso`) — `Append or Update`, columna de comparación `numero`, escribe `ultimo_aviso` = `={{ $json.tramo }}` y `fecha_ultimo_aviso` = `={{ $now.toFormat('yyyy-MM-dd') }}`. Conecta aquí todas las salidas.

## El código del nodo Decidir tramo
```javascript
const hoy = new Date(); hoy.setHours(0, 0, 0, 0);
const out = [];
for (const item of $input.all()) {
  const f = item.json;
  const venc = new Date(f.fecha_vencimiento);
  const dias = Math.floor((hoy - venc) / 86400000);
  let tramo = 0;
  if (dias >= 45) tramo = 4; else if (dias >= 30) tramo = 3; else if (dias >= 15) tramo = 2; else if (dias >= 3) tramo = 1;
  const ya = Number(f.ultimo_aviso || 0);
  const enviar = tramo > 0 && tramo > ya;
  const total = Number(f.total || 0);
  const interes = (total * 0.12 * dias / 365).toFixed(2);
  const textos = {
    1: { asunto: `Recordatorio: factura ${f.numero}`, cuerpo: `<p>Hola ${f.cliente},</p><p>Te escribo por la factura <b>${f.numero}</b> de ${total.toFixed(2)} €, que venció el ${f.fecha_vencimiento}. Igual se ha traspapelado.</p><p>Si ya la has pagado, dime y lo reviso. Gracias.</p>` },
    2: { asunto: `Factura ${f.numero} vencida hace ${dias} días`, cuerpo: `<p>Hola ${f.cliente},</p><p>La factura <b>${f.numero}</b> (${total.toFixed(2)} €) sigue pendiente ${dias} días después del vencimiento.</p><p>Te agradecería que me confirmes la fecha en la que la vas a abonar.</p>` },
    3: { asunto: `Reclamación formal factura ${f.numero}`, cuerpo: `<p>Hola ${f.cliente},</p><p>La factura <b>${f.numero}</b> por ${total.toFixed(2)} € acumula ${dias} días de retraso. Conforme a la Ley 3/2004 de morosidad, el importe devenga intereses de demora (aprox. ${interes} €) más 40 € de compensación por costes de cobro.</p><p>Te pido el pago en los próximos 7 días para no tener que aplicarlos.</p>` }
  };
  out.push({ json: { ...f, dias, tramo, enviar, asunto: textos[tramo]?.asunto || '', cuerpo: textos[tramo]?.cuerpo || '' } });
}
return out;
```

## Cómo probarla
Crea una factura de prueba con `fecha_vencimiento` de hace 4 días y tu propio email en `email`. Ejecuta a mano: debe llegarte el tramo 1 y la hoja marcar `ultimo_aviso` = 1.
Cambia la fecha a hace 20 días y vuelve a ejecutar: debe llegarte el tramo 2 y no repetir el 1.

## Qué puede salir mal
Duplicados: el control está en `ultimo_aviso`. Si el nodo Google Sheets de escritura falla, el siguiente día se repetirá el email. Activa en ese nodo `Settings > Retry On Fail` con 3 intentos.
Gmail gratuito limita a 500 destinatarios al día; con facturas normales no lo rozarás, pero no uses este flujo para envíos masivos o te bloquean la cuenta.
Si el cliente responde diciendo que paga el día X, marca su `ultimo_aviso` a 4 a mano para silenciarlo, o añade una columna `pausar_hasta` y fíltrala en el Code.
El tono importa: revisa los textos con tus palabras antes de activarlo. Un email frío puede perderte un cliente que solo iba tarde.
Zona horaria: el cálculo usa la fecha del servidor. Con `Europe/Madrid` en Settings del flujo va bien; en un servidor en UTC podrías adelantar un día el tramo.

## Cuánto cuesta
Gratis con Gmail, Sheets, Telegram y n8n auto-alojado.
