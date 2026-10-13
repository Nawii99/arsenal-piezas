# Facturas del correo al Excel y a Drive, solas…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cada factura que llega a tu correo se guarda en una carpeta de Drive y se apunta sola en una hoja de cálculo con proveedor, fecha, base, IVA y total.

## Qué es y qué hace

Vigila tu bandeja de Gmail, detecta los correos con factura en PDF, guarda el archivo en Drive ordenado por trimestre y apunta proveedor, NIF, número, fecha, base, IVA y total en una hoja de cálculo. Sirve para llegar al cierre trimestral con todo recopilado. Se monta con n8n, Make o Zapier y necesita cuentas de Google.

## Cómo usarla

1. Crea la carpeta de facturas en Drive y la hoja de registro
2. Conecta Gmail, Drive y Sheets
3. Define el filtro de correos con factura
4. Revisa las primeras filas extraídas
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando recibes más de 10 facturas de proveedor al mes por correo y acabas el trimestre buscando PDFs a mano para tu gestor.

## Cómo ganar dinero con ella

Ahorra entre 3 y 5 horas cada trimestre de recopilar y teclear facturas, y evita perder IVA soportado por facturas traspapeladas (fácilmente 200-600 € al año).

- Recopilación trimestral de facturas para autónomos que cierran con gestor…
- Registro de IVA soportado como servicio mensual para pymes…
- Configuración inicial del archivo de facturas para negocios que empiezan…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Vigila tu bandeja de entrada, detecta los correos con factura adjunta en PDF, la sube a una carpeta de Google Drive ordenada por trimestre y apunta los datos (proveedor, NIF, número, fecha, base, IVA, total) en una hoja de cálculo.
Está pensada para el autónomo o la pyme que recibe facturas de proveedores por email y quiere llegar al trimestre con todo recopilado sin haber hecho nada.

## Lo que necesitas antes
Cuenta de Google (Gmail + Drive + Sheets), gratis.
n8n: o bien la nube de n8n (prueba gratuita y planes de pago) o autoalojado gratis con Docker: `docker run -it --rm -p 5678:5678 -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n`.
Credencial de Google en n8n: en n8n vas a Credentials > New > «Google OAuth2 API», y en console.cloud.google.com creas un proyecto, activas las APIs de Gmail, Drive y Sheets, y generas un ID de cliente OAuth de tipo «Aplicación web» con la URL de redirección que te muestra n8n.
Una clave de API de Claude en console.anthropic.com > API Keys (de pago por uso, unos céntimos al mes con este volumen). También sirve OpenAI cambiando la URL y el modelo.
Una carpeta en Drive llamada «Facturas recibidas» (copia su ID de la URL).
Una hoja de Google Sheets llamada «Gastos» con estas columnas en la fila 1: Fecha, Proveedor, NIF, NumFactura, Base, IVA, Total, EnlacePDF, IDCorreo.

## Los nodos, en orden
**Gmail Trigger**: Poll Times cada 15 minutos. Filters > Search: `has:attachment filename:pdf -label:procesada`. Activa «Download Attachments» y pon Attachment Prefix `attachment_`.
**IF**: condición String > el valor `{{ $binary.attachment_0.fileName }}` «ends with» `.pdf`. Rama true sigue, la false no hace nada.
**Google Drive**: Operation «Upload File». Input Data Field Name `attachment_0`. File Name: `{{ $json.date.slice(0,10) }}_{{ $json.from.value[0].address }}.pdf`. Parent Drive «My Drive», Parent Folder el ID de tu carpeta «Facturas recibidas».
**Extract from File**: Operation «PDF», Input Binary Field `attachment_0`. Esto saca el texto del PDF.
**HTTP Request** (aquí lee la IA): Method POST, URL `https://api.anthropic.com/v1/messages`. Authentication > Generic Credential Type > Header Auth, con nombre `x-api-key` y valor tu clave. Headers añade también `anthropic-version` con valor `2023-06-01`. Body Content Type JSON, y en Body usa esta expresión (activa el modo expresión con el `=`):
`={{ JSON.stringify({ model: "claude-sonnet-5-5", max_tokens: 500, messages: [{ role: "user", content: "Extrae de esta factura y devuelve SOLO un JSON con las claves proveedor, nif, numero, fecha (AAAA-MM-DD), base, iva, total. Los números en punto decimal, sin símbolo de euro. Texto de la factura: " + $json.text }] }) }}`
**Code** (limpia la respuesta): modo «Run Once for Each Item». Pega esto:
```javascript
const bruto = $input.item.json.content[0].text.trim();
const limpio = bruto.replace(/```json/g, '').replace(/```/g, '').trim();
let d;
try { d = JSON.parse(limpio); } catch (e) { d = { proveedor: 'REVISAR A MANO', nif: '', numero: '', fecha: '', base: 0, iva: 0, total: 0 }; }
const num = (v) => Number(String(v ?? 0).replace(',', '.')) || 0;
return { json: { Fecha: d.fecha || new Date().toISOString().slice(0,10), Proveedor: d.proveedor, NIF: d.nif, NumFactura: d.numero, Base: num(d.base), IVA: num(d.iva), Total: num(d.total), EnlacePDF: $('Google Drive').item.json.webViewLink, IDCorreo: $('Gmail Trigger').item.json.id } };
```
**Google Sheets**: Operation «Append Row», tu documento «Gastos», hoja «Hoja 1», Mapping Mode «Map Automatically» (los nombres de las columnas coinciden con los del Code).
**Gmail**: Operation «Add Label to Message», Message ID `={{ $('Gmail Trigger').item.json.id }}`, etiqueta `procesada` (créala antes en Gmail). Así nunca se repite.

## Cómo probarla
Mándate a ti mismo un correo con una factura real en PDF adjunta.
En n8n pulsa «Test workflow» y mira nodo a nodo: que el PDF aparezca en Drive, que el texto se extraiga y que el JSON del Code tenga números y no ceros.
Repite con tres facturas de proveedores distintos (una de Amazon, una de tu gestoría, una de tu proveedor habitual) antes de activarla.

## Qué puede salir mal
Facturas escaneadas como imagen: «Extract from File» devuelve texto vacío. Solución: en vez del texto, manda el PDF en base64 a Claude como documento, o filtra esas y trátalas a mano.
Correos con varios adjuntos: solo procesa el primero. Añade un nodo **Code** que recorra `attachment_0`, `attachment_1`... y devuelva un item por cada uno.
Duplicados si el trigger reprocesa: por eso está la etiqueta `procesada` y el filtro `-label:procesada`. No la quites.
Fechas con formato español (12/03/2026): el prompt ya pide AAAA-MM-DD, pero revisa las primeras semanas.
Cuota de Gmail API: 250 unidades por segundo, con este volumen es imposible pasarse.

## Cuánto cuesta
Google, Drive y Sheets: gratis con tu cuenta normal.
n8n autoalojado en tu ordenador o en un VPS de 5 €/mes: gratis el software. La nube de n8n arranca sobre 20 €/mes.
Claude: unos 0,003 € por factura. Con 100 facturas al mes, menos de 0,50 €.
