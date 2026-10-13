# Chequeo de si tus emails caen en spam (y por qué)

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Revisa cada semana si tus correos llegan a la bandeja o al spam de Gmail, Outlook y Yahoo, y comprueba que SPF, DKIM y DMARC de tu dominio siguen bien puestos.

## Qué es y qué hace

Flujo de n8n que cada semana envía un correo de prueba a buzones semilla de Gmail, Outlook y Yahoo y comprueba en cuál acaba en spam. Además consulta por DNS que los registros SPF, DKIM y DMARC de tu dominio existan. Entra tu credencial de envío y los tres buzones; sale un informe por proveedor con los registros que hay que revisar. Útil para email marketing o envío de facturas desde tu dominio.

## Cómo usarla

1. Crea los tres buzones semilla
2. Conecta Gmail, Outlook y el IMAP de Yahoo en n8n
3. Configura el envío semanal
4. Corrige SPF, DKIM o DMARC si el informe lo indica

## Cuándo usarla

Úsalo cuando mandes newsletters, presupuestos o facturas por email y notes que la gente «no recibe nada», o justo después de cambiar de hosting, de dominio o de herramienta de email.

## Cómo ganar dinero con ella

Una tasa de entrega que baja del 95% al 70% mata una campaña entera. Detectarlo antes evita rehacer envíos y perder clientes que creen que los ignoras.

- Chequeo semanal de entregabilidad para empresas que envían facturas y presupuestos por email.
- Diagnóstico de spam para newsletters de creadores o pequeños medios con lista propia.
- Puesta a punto de autenticación de correo para dominios tras migraciones de hosting.

**Precio orientativo:** 30–60 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**: manda un correo de prueba a buzones «semilla» tuyos en Gmail, Outlook y Yahoo, comprueba en cuál acabó en la carpeta de spam, y además consulta por DNS si tus registros SPF, DKIM y DMARC siguen existiendo. Para quien haga email marketing, envíe presupuestos o facturas desde su dominio.
**Para quién no es**: si solo usas Gmail personal para hablar con 5 clientes.

### Lo que necesitas antes
- **Tres buzones semilla gratuitos y tuyos**: uno de Gmail, uno de Outlook.com y uno de Yahoo. Créalos si no los tienes, tarda 10 minutos, y no los uses para nada más (un buzón limpio da lecturas fiables).
- **Conecta en n8n**: credencial «Gmail OAuth2» del buzón semilla de Gmail y credencial «Microsoft Outlook OAuth2» del de Outlook. Para Yahoo usa el nodo genérico **Email Read (IMAP)** con `imap.mail.yahoo.com`, puerto 993, y una **contraseña de aplicación** que se genera en la configuración de seguridad de Yahoo.
- **La herramienta con la que envías de verdad**: si usas Brevo, MailerLite, Mailchimp o SMTP propio, necesitas mandar el correo de prueba desde ahí, no desde n8n con Gmail, o no mides nada. Consigue la clave de API en el panel de tu herramienta (en Brevo: SMTP & API > API Keys).
- **Una hoja Google Sheets** «Entregabilidad» con columnas: `fecha`, `gmail`, `outlook`, `yahoo`, `spf`, `dkim`, `dmarc`, `nota`.

### Los nodos, en orden
**1. Schedule Trigger** — Weeks, lunes a las 9:00, Timezone `Europe/Madrid`.
**2. Code** («Preparar prueba»):
```js
const codigo = 'SEED-' + Date.now().toString(36).toUpperCase();
return [{ json: { codigo, asunto: 'Novedades de la semana ' + codigo } }];
```
**3. HTTP Request** («Enviar con tu herramienta real») — Ejemplo con Brevo: Method POST, URL `https://api.brevo.com/v3/smtp/email`, Headers: `api-key` con tu clave y `content-type: application/json`. Body (JSON): `{"sender":{"email":"hola@tudominio.com","name":"Tu Marca"},"to":[{"email":"semilla1@gmail.com"},{"email":"semilla2@outlook.com"},{"email":"semilla3@yahoo.com"}],"subject":"{{ $json.asunto }}","htmlContent":"<p>Hola, esta es la newsletter de prueba semanal. Codigo {{ $json.codigo }}.</p>"}`. Escribe el HTML pareciéndose a tus envíos reales: si tu newsletter tiene imágenes y enlaces, ponlos, o la prueba no vale.
**4. Wait** — 10 minutos.
**5. Gmail** («Ver si está en spam») — Operation: Get Many, Limit 5, Options > Search: `in:spam "{{ $('Preparar prueba').first().json.codigo }}"`. Always Output Data activado. Si devuelve algo, es que cayó en spam.
**6. Microsoft Outlook** — Resource: Message, Operation: Get Many, Filters > Folder: `JunkEmail`, Search: el código. Always Output Data activado.
**7. HTTP Request** («SPF») — GET `https://dns.google/resolve?name=tudominio.com&type=TXT`. Sin clave, gratis.
**8. HTTP Request** («DMARC») — GET `https://dns.google/resolve?name=_dmarc.tudominio.com&type=TXT`.
**9. HTTP Request** («DKIM») — GET `https://dns.google/resolve?name=SELECTOR._domainkey.tudominio.com&type=TXT`. El SELECTOR te lo da tu herramienta de envío (en Brevo suele ser `mail`, en Google Workspace `google`).
**10. Code** («Resumen») — junta todo:
```js
const spf = JSON.stringify($('SPF').first().json).includes('v=spf1');
const dmarc = JSON.stringify($('DMARC').first().json).includes('v=DMARC1');
const dkim = JSON.stringify($('DKIM').first().json).includes('DKIM1') || JSON.stringify($('DKIM').first().json).includes('p=');
const enSpamGmail = ($('Ver si está en spam').all() || []).some(i => i.json && i.json.id);
const enSpamOutlook = ($('Microsoft Outlook').all() || []).some(i => i.json && i.json.id);
const avisos = [];
if (!spf) avisos.push('Falta o esta mal el SPF');
if (!dkim) avisos.push('Falta el DKIM');
if (!dmarc) avisos.push('Falta el DMARC');
if (enSpamGmail) avisos.push('Gmail lo ha mandado a SPAM');
if (enSpamOutlook) avisos.push('Outlook lo ha mandado a SPAM');
return [{ json: { spf, dkim, dmarc, gmail: enSpamGmail ? 'SPAM' : 'Bandeja', outlook: enSpamOutlook ? 'SPAM' : 'Bandeja', nota: avisos.join(' | ') || 'Todo correcto', hayProblema: avisos.length > 0 } }];
```
**11. Google Sheets** — Append Row con todos los campos.
**12. IF** + **Gmail** — si `hayProblema` es true, mándate un correo a tu cuenta principal con la nota.

### Cómo probarla
- Lanza la primera ejecución y abre los tres buzones semilla a mano para confirmar que lo que dice el informe coincide con lo que ves.
- Prueba el detector de DNS poniendo un dominio inventado en el nodo SPF: debe marcar «Falta el SPF».
- Complementa una vez con **mail-tester.com**: mandas el correo a la dirección que te dan y te puntúa de 0 a 10. Es manual pero te dice exactamente qué falla la primera vez.

### Qué puede salir mal
- **Buzones semilla que se «entrenan»**: si abres y marcas «no es spam» a mano, falsearás las lecturas futuras. No toques los semilla.
- **Yahoo por IMAP falla**: casi siempre es que usaste tu contraseña normal en vez de una contraseña de aplicación.
- **Outlook no encuentra la carpeta**: el nombre interno es `JunkEmail`, no «Correo no deseado».
- **Todo en bandeja pero tus clientes no reciben**: mira también si tu dominio o IP está en listas negras; añade un HTTP Request a `https://api.spamhaus.org` o hazlo a mano en mxtoolbox.com.

### Cuánto cuesta
- n8n, Gmail, Outlook, Yahoo, DNS de Google y Sheets: **0 €**.
- Brevo permite 300 correos al día gratis; 4 correos de prueba al mes no rozan el límite.
- Servicios de asientos semilla profesionales (GlockApps, Mailtrap) cuestan desde 50 €/mes: con esta receta te ahorras eso.
