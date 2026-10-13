# Vigía de caducidades: SSL, dominio, claves y suscripcio…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Comprueba cada semana cuándo caducan tu certificado SSL, tu dominio, tus claves de API y tus licencias, y te avisa a 30, 14 y 3 días.

## Qué es y qué hace

Flujo de n8n que cada semana consulta la fecha de caducidad del certificado SSL y del dominio, y compara con una hoja de Google Sheets con tus claves de API, licencias y suscripciones. Entra la lista de dominios y las fechas manuales; sale un aviso a 30, 14 y 3 días del vencimiento. Evita caídas de la web y pérdidas de dominio por renovaciones fallidas.

## Cómo usarla

1. Lista dominios, claves y licencias en la hoja Caducidades
2. Configura la consulta semanal del certificado
3. Define los avisos a 30, 14 y 3 días
4. Que lo revise un profesional (seguridad y renovaciones)

## Cuándo usarla

Úsalo cuando alguna vez se te haya caído la web por un certificado caducado un domingo, o temas perder el dominio por un renovación fallida con la tarjeta antigua.

## Cómo ganar dinero con ella

Un dominio perdido puede costarte cientos o miles recomprarlo. Un SSL caducado espanta a todo el que entra ese día. Aquí te enteras con un mes de margen.

- Control de vencimientos para agencias que gestionan dominios y certificados de varios clientes.
- Mantenimiento mensual de webs de pymes con revisión de SSL, dominio y licencias.
- Auditoría de claves y suscripciones para negocios que pagan muchas herramientas digitales.

**Precio orientativo:** 30–50 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**: consulta el certificado del dominio, la fecha de expiración registral y una lista tuya de claves y licencias con fecha de caducidad, y te avisa antes de que reviente. Para cualquiera con web, tienda o herramientas de pago.
**Para quién no es**: si todo lo tienes en una plataforma cerrada que lo renueva sola (Shopify puro, por ejemplo), solo te sirve la parte de licencias y claves.

### Lo que necesitas antes
- **n8n** y una hoja **Google Sheets** «Caducidades» con dos pestañas.
- Pestaña `dominios`: columna `dominio` con tus dominios (uno por fila, sin https).
- Pestaña `manual`: columnas `concepto`, `proveedor`, `caduca` (formato `AAAA-MM-DD`), `coste_anual`, `responsable`. Aquí metes a mano las claves de API con caducidad, licencias de plugins, tarjetas asociadas a suscripciones, el certificado digital de la FNMT (¡ese caduca cada 2-4 años y te bloquea Hacienda!), el pasaporte del socio si viajáis, etc.
- **Credenciales** Google Sheets, Gmail y (opcional) Google Calendar.

### Los nodos, en orden
**1. Schedule Trigger** — Weeks, lunes a las 8:00, Timezone `Europe/Madrid`.
**2. Google Sheets** («Leer dominios») — Get Row(s), pestaña `dominios`.
**3. Loop Over Items** — Batch Size 1.
**4. HTTP Request** («SSL») — GET `https://api.ssllabs.com/api/v3/analyze?host={{ $json.dominio }}&fromCache=on&maxAge=24&all=done`. Sin clave y gratis. Options: Never Error, Timeout `60000`. Es lenta la primera vez, por eso `fromCache=on`.
**5. HTTP Request** («Dominio») — GET `https://rdap.org/domain/{{ $('Loop Over Items').first().json.dominio }}`. RDAP es el sustituto moderno del WHOIS: gratis, sin clave, responde JSON. Never Error activado.
**6. Code** («Calcular días») — Run Once for All Items:
```js
const dominio = $('Loop Over Items').first().json.dominio;
const ssl = $('SSL').first().json;
const rdap = $('Dominio').first().json;
let diasSsl = null;
try {
  const cert = ssl.endpoints[0].details.certChains[0];
  const notAfter = ssl.certs && ssl.certs[0] ? ssl.certs[0].notAfter : null;
  if (notAfter) diasSsl = Math.round((notAfter - Date.now()) / 86400000);
} catch (e) {}
let diasDominio = null;
try {
  const ev = (rdap.events || []).find(e => e.eventAction === 'expiration');
  if (ev) diasDominio = Math.round((new Date(ev.eventDate).getTime() - Date.now()) / 86400000);
} catch (e) {}
const avisos = [];
if (diasSsl !== null && diasSsl <= 30) avisos.push('El certificado SSL de ' + dominio + ' caduca en ' + diasSsl + ' dias');
if (diasDominio !== null && diasDominio <= 45) avisos.push('El dominio ' + dominio + ' caduca en ' + diasDominio + ' dias');
return [{ json: { dominio, diasSsl, diasDominio, avisos: avisos.join(' | '), hayAviso: avisos.length > 0 } }];
```
**7. Conecta de vuelta al Loop Over Items.** De la salida `done` sigue con la parte manual.
**8. Google Sheets** («Leer manual») — Get Row(s), pestaña `manual`.
**9. Filter** — Condition tipo DateTime: `{{ $json.caduca }}` is before `{{ $now.plus(30, 'days') }}`. Si el nodo Filter te da guerra con formatos, usa un **Code**: `return $input.all().filter(i => (new Date(i.json.caduca) - Date.now()) / 86400000 <= 30);`
**10. Google Calendar** (opcional) — Operation: Create Event. Start: `{{ $json.caduca }}` menos 15 días, Summary: `Renovar {{ $json.concepto }} ({{ $json.proveedor }})`. Así queda en tu agenda aunque no leas el email.
**11. Gmail** («Resumen») — Subject: `Caducidades a la vista - {{ $now.format('dd/MM/yyyy') }}`. Message: junta los avisos de dominios y los de la pestaña manual en un texto tipo `{{ $json.avisos }}` más la lista de conceptos.

### Cómo probarla
- Mete en la pestaña `manual` una fila falsa con `caduca` dentro de 10 días. Ejecuta: debe salir en el email.
- Comprueba el SSL con un dominio que sepas que caduca pronto, o mira que `diasSsl` te devuelva un número razonable (Let's Encrypt renueva cada 90 días, así que verás valores entre 1 y 89: pon el umbral en 12 días para no recibir avisos constantes).
- Si `diasSsl` sale `null`, mira la respuesta cruda de SSL Labs: puede estar aún en estado `IN_PROGRESS`. Vuelve a ejecutar en 3 minutos.

### Qué puede salir mal
- **SSL Labs tarda hasta 2 minutos** en un dominio nuevo y limita a un análisis cada 15 minutos por host. Con `fromCache=on&maxAge=24` no te pasas.
- **Let's Encrypt renueva solo**: no te alarmes con 20 días. Ajusta el umbral a 12 días para SSL y deja 45 días para el dominio.
- **Algunos dominios .es no responden por RDAP**: si `diasDominio` sale null para tu .es, mételo a mano en la pestaña `manual` con la fecha de renovación que te diga tu registrador.
- **Avisos que se repiten cada semana**: es lo que quieres. Añade una columna `renovado` con `si` y filtra por ella cuando ya lo hayas hecho.

### Cuánto cuesta
- SSL Labs, RDAP, Sheets, Gmail y Calendar: **0 €**.
- n8n auto-alojado: **0 €**. Total **0 €/mes**.
