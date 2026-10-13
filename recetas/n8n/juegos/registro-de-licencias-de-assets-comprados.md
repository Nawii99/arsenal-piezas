# Registro de licencias de assets comprados…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cada factura de compra de assets que llega a tu correo se archiva sola, con su licencia, su importe y el archivo guardado en Drive, y te avisa antes de que caduque una suscripción.

## Qué es y qué hace

Revisa tu correo buscando facturas y confirmaciones de compra de tiendas de assets, saca proveedor, producto, importe y tipo de licencia si aparece, y guarda el PDF en Drive ordenado por año. Anota cada compra en una hoja y programa un aviso 10 días antes de cada renovación anual. Entrada: correos con facturas; salida: hoja de licencias, PDFs y avisos. Se monta en n8n con Gmail, Drive y Sheets.

## Cómo usarla

1. Crear la etiqueta y el filtro en Gmail
2. Conectar Gmail, Drive y Sheets en n8n
3. Revisar las diez primeras compras a mano
4. Que lo revise un profesional

## Cuándo usarla

Cuando compres modelos, texturas, sonidos o plugins en varias tiendas y no sepas qué licencia tiene cada cosa ni cuándo se renueva lo que pagas.

## Cómo ganar dinero con ella

Evita renovaciones automáticas no deseadas (fácilmente 200-600 €/año) y te ahorra el marrón de justificar licencias ante una editora o un cliente.

- Ordenar las licencias de assets de estudios que deben justificarlas ante una editora o un cliente.
- Montar el archivo de compras para un equipo de desarrollo con varias suscripciones.
- Ofrecer una revisión trimestral de renovaciones y licencias a freelances 3D.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila tu correo buscando facturas y confirmaciones de compra de las tiendas de assets que uses (Unity Asset Store, Fab, Blender Market, Humble, Quixel, itch.io, Adobe Stock, Envato...). De cada una saca proveedor, producto, importe, fecha y, si aparece, el tipo de licencia.
Guarda el PDF adjunto en una carpeta de Drive ordenada por año, apunta la fila en una hoja y, si detecta una suscripción anual, programa un aviso 10 días antes de la renovación. Para desarrolladores, artistas 3D y estudios pequeños que compran assets a menudo.

## Lo que necesitas antes
Cuenta de Gmail conectada en n8n por OAuth (con permiso de lectura y modificación de etiquetas).
Drive API y Sheets API activadas en el mismo proyecto de Google Cloud.
Una etiqueta en Gmail llamada «Assets-Facturas» y un filtro que la aplique a los remitentes habituales: en Gmail, Configuración → Filtros → Crear filtro con `from:(assetstore@unity3d.com OR noreply@blendermarket.com OR no-reply@itch.io OR store@fab.com OR noreply@humblebundle.com)` → aplicar etiqueta.
Hoja «Licencias assets» con columnas: fecha, proveedor, producto, importe, moneda, licencia, tipo_pago, renovacion, url_pdf, id_mensaje.
Bot de Telegram con token y chat_id para los avisos.

## Los nodos, en orden
**Gmail Trigger** — Event: Message Received, Filters → Label IDs: la etiqueta «Assets-Facturas», Poll Times: cada hora, Options → Download Attachments activado.
**Code** — extrae los datos del correo con expresiones regulares (abajo).
**IF** — `{{$binary.attachment_0}}` existe (¿trae PDF?).
**Google Drive** (rama true) — Operation: Upload, Input Binary Field: `attachment_0`, Parent Folder: la carpeta del año (`Facturas Assets/{{$now.format('yyyy')}}`), File Name: `{{$json.fecha}}_{{$json.proveedor}}_{{$json.importe}}.pdf`.
**Google Sheets** — Append Row en «Licencias assets», incluyendo `url_pdf` con `{{$json.webViewLink}}`.
**IF** — `{{$json.tipo_pago}}` igual a `suscripcion`.
**Google Calendar** (rama true) — Operation: Create Event, Start: la fecha de renovación menos 10 días, Summary: `Revisar renovación {{$json.proveedor}} ({{$json.importe}} {{$json.moneda}})`, All Day: activado.
**Telegram** — Send Message: `🧾 Nueva compra registrada: {{$json.proveedor}} — {{$json.producto}} — {{$json.importe}} {{$json.moneda}} — licencia: {{$json.licencia}}`.
**Gmail** — Operation: Add Label, etiqueta «Procesado», para no repetir.

## El nodo Code
```javascript
const asunto = $json.subject || '';
const cuerpo = ($json.textPlain || $json.snippet || '').replace(/\s+/g, ' ');
const remitente = ($json.from?.value?.[0]?.address || $json.from || '').toLowerCase();
const tiendas = { 'unity3d.com':'Unity Asset Store', 'blendermarket':'Blender Market', 'itch.io':'itch.io', 'fab.com':'Fab', 'humblebundle':'Humble', 'quixel':'Quixel', 'envato':'Envato', 'adobe':'Adobe Stock' };
let proveedor = 'Otro';
for (const [clave, nombre] of Object.entries(tiendas)) if (remitente.includes(clave)) proveedor = nombre;
const mImporte = cuerpo.match(/(?:EUR|€|USD|\$)\s?(\d+[.,]\d{2})|(\d+[.,]\d{2})\s?(?:EUR|€|USD|\$)/);
const importe = mImporte ? (mImporte[1] || mImporte[2]).replace(',', '.') : '0.00';
const moneda = /€|EUR/.test(cuerpo) ? 'EUR' : 'USD';
const mLic = cuerpo.match(/(single entity|multi entity|extended|royalty[- ]free|standard license|commercial|personal|CC0|CC-BY)/i);
const suscripcion = /(subscription|renew|renewal|suscripci|anual|monthly|yearly)/i.test(cuerpo + asunto);
const mProducto = asunto.replace(/^(re:|fwd:)\s*/i,'').slice(0, 90);
const renovacion = suscripcion ? new Date(Date.now() + 355*86400000).toISOString().slice(0,10) : '';
return { json: { fecha: new Date($json.date || Date.now()).toISOString().slice(0,10), proveedor, producto: mProducto, importe, moneda, licencia: mLic ? mLic[0] : 'revisar a mano', tipo_pago: suscripcion ? 'suscripcion' : 'unico', renovacion, id_mensaje: $json.id } };
```

## Cómo probarla
Reenvíate a ti mismo tres facturas antiguas de tiendas distintas, aplícales la etiqueta a mano y ejecuta el flujo en modo test.
Revisa qué campos salen mal: casi seguro tendrás que ajustar la expresión del importe según cómo formatee cada tienda. Es media hora de afinado y ya queda para siempre.
Comprueba que el PDF acaba en la carpeta correcta y que el enlace de la hoja abre bien.

## Qué puede salir mal
Los correos en HTML sin texto plano dejan el `textPlain` vacío: añade antes del Code un nodo **HTML** con Operation: Extract HTML Content para sacar el texto del cuerpo.
La licencia rara vez viene en el correo: la fila queda como «revisar a mano» a propósito, para que una vez al mes abras esas y las completes mirando la web del producto. No inventes licencias.
La fecha de renovación calculada a 355 días es una estimación: corrígela a mano cuando conozcas la real.
Si el mismo correo llega dos veces (respuestas, reenvíos), el `id_mensaje` en la hoja te permite detectarlo; añade un **Remove Duplicates** sobre ese campo.
Esta hoja es oro para tu asesoría: exporta el año entero en enero y te ahorras discusiones sobre gastos deducibles.

## Cuánto cuesta
Gmail, Drive, Sheets, Calendar y Telegram: gratis en cuenta personal de Google. n8n auto-alojado: gratis.
En n8n Cloud entra de sobra en el plan más barato porque son pocas ejecuciones al mes.
Lo que te ahorras: cualquier gestor de licencias de assets de pago, y sobre todo el susto de una renovación de 300 € que no viste venir.
