# Vigilante de certificados SSL y dominios…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Comprueba cada día cuándo caducan tus certificados HTTPS y tus dominios, y te avisa a 30, 14 y 3 días para que nunca se te caiga la web por un despiste.

## Qué es y qué hace

Lee una lista de dominios de una hoja de cálculo, consulta la fecha de caducidad del certificado TLS y la del registro del dominio, y lanza avisos escalonados por Slack o correo antes de que caduquen. Se monta con n8n, Make o Zapier y usa APIs públicas de consulta de certificados y de registro de dominios.

## Cómo usarla

1. Crea la hoja con dominio, cliente y responsable
2. Crea el webhook de Slack o conecta Gmail
3. Fija el cron diario
4. Prueba con un dominio que caduque pronto
5. Que lo revise un profesional

## Cuándo usarla

Cuando gestionas más de dos dominios o webs de clientes y las renovaciones no están todas en la misma cuenta.

## Cómo ganar dinero con ella

Un día de web caída con el navegador marcando «no es seguro» cuesta ventas y credibilidad; esta receta lo evita por 0 €.

- Vigilancia de dominios para freelancers que llevan webs de terceros…
- Renovaciones centralizadas como servicio para agencias con muchos clientes…
- Informe mensual de estado de certificados para empresas con varias webs…

**Precio orientativo:** 40–100 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

### Qué hace y para quién
Lee una lista de dominios de una hoja de cálculo, consulta la fecha de caducidad del certificado TLS y la del registro del dominio, y lanza avisos escalonados.
Para freelances y agencias pequeñas que llevan webs de terceros y no controlan todos los paneles de renovación.

### Lo que necesitas antes
- n8n.
- Una hoja de Google Sheets llamada «Dominios» con las columnas: `dominio`, `cliente`, `responsable`, `ultimo_aviso`.
- Credencial de Google OAuth2 en n8n (Google Cloud Console → APIs y servicios → Credenciales → ID de cliente OAuth, activando Sheets API).
- Un webhook entrante de Slack: api.slack.com/apps → Create New App → Incoming Webhooks → Add New Webhook to Workspace. Si no usas Slack, sustituye por Gmail.
- Las dos APIs de consulta son públicas y sin clave: `ssl-checker.io` y `rdap.org`.

### Los nodos, en orden
1. **Schedule Trigger** — `Every Day`, hora `9`, timezone `Europe/Madrid`.
2. **Google Sheets** — Operation `Get Row(s)`, documento «Dominios», hoja `Hoja 1`. Devuelve un item por dominio.
3. **Split In Batches** — Batch Size `5`.
4. **HTTP Request** (nombre: «Certificado») — `GET https://ssl-checker.io/api/v1/check/{{ $json.dominio }}`. Settings: `Continue On Fail` activado, `Retry On Fail` con 2 intentos.
5. **HTTP Request** (nombre: «Dominio») — `GET https://rdap.org/domain/{{ $json.dominio }}`, header `Accept: application/rdap+json`. También con `Continue On Fail`.
6. **Code** (nombre: «Días restantes») — Mode `Run Once for Each Item`; calcula los días de cada caducidad y decide si toca avisar.
7. **IF** — Condition: Boolean `{{ $json.avisar }}` `is true`.
8. **Slack** — Operation `Send Message` (o nodo `HTTP Request` POST al webhook con `{"text": "..."}`).
9. **Google Sheets** — Operation `Update Row`, columna `ultimo_aviso` con `{{$now.toISO()}}`, usando `dominio` como columna de búsqueda.

### El código del nodo «Días restantes»
```javascript
const dominio = $('Split In Batches').item.json.dominio;
const ssl = $('Certificado').item.json || {};
const rdap = $('Dominio').item.json || {};
const info = ssl.result || {};
const diasCert = typeof info.days_left === 'number' ? info.days_left : null;
let diasDom = null;
const ev = (rdap.events || []).find(e => e.eventAction === 'expiration');
if (ev) diasDom = Math.floor((new Date(ev.eventDate) - Date.now()) / 86400000);
const umbrales = [30, 14, 3];
const critico = Math.min(...[diasCert, diasDom].filter(v => v !== null).concat([9999]));
const avisar = umbrales.some(u => critico <= u);
const texto = `⚠️ ${dominio} → certificado: ${diasCert ?? 'no leído'} días · dominio: ${diasDom ?? 'no leído'} días`;
return { json: { dominio, diasCert, diasDom, critico, avisar, texto } };
```

### Cómo probarla
- Mete en la hoja un dominio conocido (por ejemplo el tuyo) y ejecuta a mano: debe devolver unos 60-90 días de certificado si usas Let's Encrypt.
- Cambia temporalmente los umbrales a `[400]` para forzar que salte el aviso y comprobar que Slack recibe el mensaje.
- Prueba con un dominio mal escrito: el `Continue On Fail` debe dejar seguir el flujo sin romper la ejecución.

### Qué puede salir mal
- **Dominios `.es`**: algunos registros nacionales no exponen la fecha de expiración por RDAP; en ese caso apunta la fecha a mano en una columna extra de la hoja y úsala como respaldo.
- **La API pública se pone lenta o limita**: baja el Batch Size a 3 y añade un `Wait` de 3 segundos dentro del bucle.
- **Avisos repetidos cada día**: usa la columna `ultimo_aviso` en un `IF` para no repetir dentro de las 48 horas siguientes.
- **Certificados detrás de Cloudflare**: verás el certificado de Cloudflare, no el de tu origen; para el origen usa un `Execute Command` con `openssl s_client` si tienes n8n auto-alojado, validando antes el dominio en un **Code** con una regex estricta: viene de la hoja y llegaría a la shell.
- **Subdominios**: añádelos como filas independientes, el certificado comodín no siempre cubre lo que crees.
- **Solo salía el primer dominio de cada lote**: con `.first()` el Code ignoraba los otros cuatro; ahora va item a item con `.item`.

### Cuánto cuesta
- 0 € en APIs: RDAP es el protocolo oficial de los registros y ssl-checker tiene uso libre razonable.
- Google Sheets y Slack, gratis en sus planes básicos.
- n8n auto-alojado 0 €; en n8n Cloud (de pago tras la prueba gratuita), 30 ejecuciones al mes de este flujo caben sin problema.
