# Formulario web anti-spam directo a tu CRM…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Recibe los envíos de tu formulario, descarta bots y correos falsos, crea el contacto en el CRM, te avisa y responde al cliente en menos de un minuto.

## Qué es y qué hace

Recibe los envíos del formulario en n8n, descarta bots (dominios desechables, envíos rápidos, textos con enlaces), normaliza el teléfono español, crea o actualiza el contacto en HubSpot mediante su API, guarda una fila en Google Sheets, avisa por Telegram y envía un acuse personalizado. Para pequeñas agencias y freelances que pierden leads entre correos.

## Cómo usarla

1. Crear la App Token privada en HubSpot
2. Preparar la hoja Leads y la URL pública de n8n
3. Conectar Gmail y Telegram
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tu web recibe leads por formulario y ahora mismo acaban en un correo que copias a mano, mezclados con spam de agencias.

## Cómo ganar dinero con ella

Responder en menos de 5 minutos multiplica por 3-4 la posibilidad de cerrar. Sustituye plugins de formulario+CRM de 15-30 €/mes.

- Captación de leads sin spam para agencias y freelances con formulario web.
- Respuesta automática en minutos para pymes que pierden contactos por correo.
- Integración de formulario con CRM gratuito que el consultor monta para pequeños negocios.

**Precio orientativo:** 200–350 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién.** Tu formulario envía los datos a una URL de n8n. Allí se filtra el spam (campo trampa, dominios desechables, envíos demasiado rápidos, textos con enlaces), se normaliza el teléfono español, se crea o actualiza el contacto en HubSpot, se guarda una fila en Sheets, te llega un aviso y al cliente un acuse de recibo personalizado.
Para freelance o pequeña agencia que quiere dejar de perder leads entre correos.

**Lo que necesitas antes**
- n8n con una URL pública (si autoalojas en casa, usa un túnel de Cloudflare gratuito o el `n8n tunnel` para pruebas).
- Cuenta gratuita de HubSpot CRM y una App Token: HubSpot > Settings > Integrations > Private Apps > Create, permisos `crm.objects.contacts.write` y `.read`. Pégalo en n8n Credentials > HubSpot App Token.
- Gmail conectado en n8n.
- Hoja `Leads` en Sheets con columnas `fecha`, `nombre`, `email`, `telefono`, `mensaje`, `origen`, `estado`.
- En tu formulario HTML: un campo oculto trampa `<input type="text" name="web_site" style="display:none" tabindex="-1" autocomplete="off">` y un campo oculto `ts` con la marca de tiempo en milisegundos al cargar la página.

**Los nodos, en orden**
1. **Webhook** — HTTP Method POST, Path `contacto`, Respond: `Using Respond to Webhook node`. Copia la Production URL y ponla en el `action` de tu formulario (o en el `fetch` del JS).
2. **Code** (`Filtro antispam`) — Mode: Run Once for Each Item. Código abajo.
3. **IF** (`Es spam?`) — Boolean `{{ $json.spam }}` `is true`. Rama true va directa al nodo 9 (respuesta 200 falsa, para que el bot no reintente).
4. **HubSpot** — Resource: Contact, Operation: Create or Update. Email `{{ $json.email }}`, Additional Fields: First Name `{{ $json.nombre }}`, Phone `{{ $json.telefono }}`, y una propiedad personalizada `origen_web` `{{ $json.origen }}`.
5. **Google Sheets** — Append Row en `Leads`, `estado` = `nuevo`.
6. **Gmail** (`Avisarme`) — To: tú. Subject `Lead nuevo: {{ $json.nombre }}`. Message con todos los campos y el enlace al contacto de HubSpot.
7. **Gmail** (`Acuse al cliente`) — To `{{ $json.email }}`, Subject `Hemos recibido tu mensaje`, cuerpo corto tuteando con tu teléfono y tu plazo real de respuesta.
8. **Respond to Webhook** — Respond With: JSON, Body `{ "ok": true }`. Si tu formulario es HTML clásico, usa Respond With: Redirect a `https://tudominio.com/gracias`.
9. **Respond to Webhook** (rama spam) — Body `{ "ok": true }` igual, para no dar pistas al bot.

**El código del nodo `Filtro antispam`**
```js
const b = $json.body || $json;
const email = String(b.email || '').trim().toLowerCase();
const nombre = String(b.nombre || b.name || '').trim();
const mensaje = String(b.mensaje || b.message || '').trim();
let telefono = String(b.telefono || b.phone || '').replace(/[^0-9+]/g, '');
if (/^[67][0-9]{8}$/.test(telefono) || /^[89][0-9]{8}$/.test(telefono)) telefono = '+34' + telefono;
const desechables = ['mailinator.com','yopmail.com','tempmail','guerrillamail','10minutemail','trashmail'];
const dominio = email.split('@')[1] || '';
const formatoOk = /^[^@\s]+@[^@\s]+\.[a-z]{2,}$/.test(email);
const trampa = String(b.web_site || '').length > 0;
const ts = Number(b.ts || 0);
const demasiadoRapido = ts > 0 && (Date.now() - ts) < 3000;
const enlaces = (mensaje.match(/https?:\/\//g) || []).length;
const spam = trampa || demasiadoRapido || !formatoOk || desechables.some(d => dominio.includes(d)) || enlaces >= 2 || /seo services|backlinks|criptomoneda|posicionamiento garantizado/i.test(mensaje);
return { json: { nombre, email, telefono, mensaje, origen: b.origen || b.pagina || 'web', spam, motivo: trampa ? 'trampa' : demasiadoRapido ? 'rapido' : !formatoOk ? 'email' : 'contenido' } };
```

**Cómo probarla**
- Con el Webhook en modo Test, envía el formulario de verdad desde tu web y mira los datos que llegan; ajusta los nombres de campo si tu formulario usa otros.
- Rellena el campo trampa a mano desde el inspector del navegador y comprueba que se marca como spam y no llega a HubSpot.
- Envía con un email inventado sin `@` y comprueba el filtro.

**Qué puede salir mal**
- El Webhook tiene dos URLs: Test y Production. Si al activar el workflow deja de funcionar, es que tu formulario apunta a la de Test.
- CORS: si envías con `fetch` desde el navegador, añade en el nodo Respond to Webhook la cabecera `Access-Control-Allow-Origin: https://tudominio.com` y crea un segundo Webhook con método OPTIONS que responda 200.
- Duplicados: si el usuario pulsa dos veces, HubSpot con Create or Update no duplica, pero Sheets sí. Añade un IF que compare con la última fila del mismo email en los últimos 5 minutos.
- RGPD: guarda solo lo necesario, añade la casilla de consentimiento en el formulario y registra ese campo en Sheets; menciona en el acuse tu política de privacidad.
- Nunca pongas la URL del webhook en un repositorio público: cualquiera podría inundarte de envíos.

**Cuánto cuesta**
- HubSpot CRM: gratis hasta 1.000.000 de contactos en su nivel básico.
- Gmail, Sheets y n8n autoalojado: gratis. En n8n Cloud cada lead son 1-2 ejecuciones.
