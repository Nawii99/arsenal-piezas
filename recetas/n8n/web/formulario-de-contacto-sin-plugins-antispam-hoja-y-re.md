# Formulario de contacto sin plugins: antispam, hoja y re…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Recoge los envíos del formulario de tu web en n8n, filtra el spam, los guarda en una hoja, te avisa al móvil y manda al cliente una respuesta inmediata.

## Qué es y qué hace

Tu formulario envía los datos a una URL de n8n, que filtra el spam (campo trampa, envíos demasiado rápidos, enlaces sospechosos), guarda los válidos en Google Sheets, te manda un aviso por Telegram con nombre y teléfono y envía al interesado una respuesta inmediata por Gmail. Sirve a webs estáticas o WordPress sin plugin de formularios.

## Cómo usarla

1. Preparar la hoja Leads web
2. Crear el bot de Telegram y la credencial de Gmail
3. Pegar el HTML del formulario en la web
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando el formulario de tu web te llegue por correo y se te pierda, cuando recibas spam a diario, o cuando quieras contestar en 30 segundos aunque estés en una obra o en una consulta.

## Cómo ganar dinero con ella

Sustituye plugins de formulario de pago (50-100 €/año) y un CRM básico.

- Formularios de contacto con filtro de spam para webs de clínicas, reformas y talleres.
- Gestión de leads con respuesta automática en minutos para agencias pequeñas.
- Mantenimiento mensual del formulario y revisión de spam para webs de clientes.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Tu formulario envía los datos a una URL secreta de n8n. Allí se comprueban campo por campo, se descarta el spam (campo trampa, envíos en menos de 3 segundos, palabras y enlaces sospechosos) y lo bueno se guarda en una hoja.
Además te llega un Telegram con el nombre y el teléfono para llamar en caliente, y al cliente le llega un correo tuyo de «te he recibido, te contesto hoy» con tus datos.

## Lo que necesitas antes
- n8n con URL pública accesible (n8n Cloud vale de sobra; si te auto-alojas, necesitas dominio y HTTPS).
- Hoja de Google «Leads web» con columnas: fecha, nombre, email, telefono, mensaje, origen, ip.
- Bot de Telegram (con @BotFather) y tu chat ID.
- Credencial Gmail OAuth2 para enviar la respuesta desde tu correo real.
- Acceso al HTML de tu web para pegar el formulario.

## El HTML del formulario (pégalo en tu página)
```html
<form id="f"><input name="nombre" required placeholder="Nombre"><input name="email" type="email" required placeholder="Email"><input name="telefono" placeholder="Teléfono"><textarea name="mensaje" required></textarea><input name="web_url" tabindex="-1" autocomplete="off" style="position:absolute;left:-9999px"><input type="hidden" name="t0" id="t0"><button>Enviar</button></form>
<script>document.getElementById('t0').value=Date.now();document.getElementById('f').addEventListener('submit',async e=>{e.preventDefault();const d=Object.fromEntries(new FormData(e.target));d.origen=location.href;await fetch('https://TU-N8N/webhook/contacto',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(d)});e.target.innerHTML='<p>¡Recibido! Te contesto hoy mismo.</p>';});</script>
```

## Los nodos, en orden
1. **Webhook** — HTTP Method: POST; Path: `contacto`; Authentication: None; Respond: `Using Respond to Webhook node`; Options > Allowed Origins (CORS): `https://tudominio.com`.
2. **Code** (renómbralo «Filtro antispam») — ver código.
3. **IF** — Boolean: `={{ $json.spam }}` is false.
4. **Google Sheets** (rama true) — Operation: Append Row; hoja «Leads web»; mapeo manual de todos los campos.
5. **Telegram** (rama true) — Text: `🟢 Nuevo contacto\n{{ $json.nombre }}\n📞 {{ $json.telefono }}\n✉️ {{ $json.email }}\n\n{{ $json.mensaje }}\nDesde: {{ $json.origen }}`.
6. **Gmail** (rama true) — To: `={{ $json.email }}`; Subject: `He recibido tu mensaje, {{ $json.nombre }}`; Message Type: HTML; texto tuyo con tu teléfono y horario.
7. **Google Sheets** (rama false, opcional) — a una pestaña `spam`, por si acaso filtras de más.
8. **Respond to Webhook** (al final de las dos ramas) — Respond With: JSON; Body: `{ "ok": true }`.

## El código del filtro antispam
```js
const d = $json.body || $json;
const ahora = Date.now();
const segundos = d.t0 ? (ahora - Number(d.t0)) / 1000 : 99;
const texto = `${d.nombre || ''} ${d.mensaje || ''}`.toLowerCase();
const enlaces = (d.mensaje || '').match(/https?:\/\//g) || [];
const palabras = ['seo services', 'crypto', 'casino', 'backlinks', 'viagra', 'guest post', 'кредит'];
const razones = [];
if (d.web_url) razones.push('campo trampa relleno');
if (segundos < 3) razones.push('enviado demasiado rápido');
if (enlaces.length >= 2) razones.push('demasiados enlaces');
if (palabras.some(p => texto.includes(p))) razones.push('palabra spam');
if (!/^[^@\s]+@[^@\s]+\.[a-z]{2,}$/i.test(d.email || '')) razones.push('email inválido');
if ((d.mensaje || '').length < 10) razones.push('mensaje vacío');
return [{ json: {
  spam: razones.length > 0,
  razones: razones.join(', '),
  fecha: new Date().toLocaleString('es-ES', { timeZone: 'Europe/Madrid' }),
  nombre: (d.nombre || '').slice(0, 100),
  email: (d.email || '').toLowerCase().trim(),
  telefono: (d.telefono || '').replace(/[^0-9+ ]/g, ''),
  mensaje: (d.mensaje || '').slice(0, 3000),
  origen: d.origen || '',
  ip: $json.headers?.['x-forwarded-for'] || ''
} }];
```

## Cómo probarla
- En el nodo Webhook pulsa «Listen for test event», rellena el formulario de tu web en otra pestaña y mira que llegan los datos.
- Prueba el spam: rellena el campo oculto con las herramientas de desarrollador o envía el formulario en menos de 3 segundos; no debe llegarte el Telegram.
- Cuando funcione, activa el flujo y cambia la URL del `fetch` de `/webhook-test/contacto` a `/webhook/contacto` (¡es el fallo número uno!).

## Qué puede salir mal
- **No llega nada y en la consola del navegador sale error de CORS**: pon tu dominio exacto (con https y sin barra final) en Allowed Origins del Webhook.
- **Sigue entrando spam**: añade Cloudflare Turnstile (gratis) y valida el token con un HTTP Request a `https://challenges.cloudflare.com/turnstile/v0/siteverify` antes del IF.
- **El correo automático cae en spam**: manda desde tu Gmail con dominio propio y ten SPF y DKIM configurados en tu dominio.
- **Pierdes leads si n8n está caído**: pon Retry en el `fetch` del formulario o guarda una copia en el `localStorage`; como red de seguridad, activa «Error Workflow» en los ajustes del flujo para que te avise.
- **RGPD**: añade una casilla de consentimiento obligatoria y guarda su valor en la hoja; es obligatorio en España.

## Cuánto cuesta
- Gratis: Sheets, Telegram, Gmail (500 envíos/día).
- n8n Cloud gratuito aguanta si recibes menos de unos cientos de contactos al mes; auto-alojado, sin límite.
- Cloudflare Turnstile, gratis y sin límite práctico.
