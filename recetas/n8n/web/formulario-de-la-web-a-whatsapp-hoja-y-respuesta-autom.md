# Formulario de la web a WhatsApp, hoja y respuesta autom…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Recibe los envíos del formulario de tu web por webhook, filtra el spam, los guarda en una hoja, te avisa al móvil y manda al cliente un email de confirmación.

## Qué es y qué hace

Recibe por webhook los envíos del formulario de tu web en JSON, descarta el spam con una puntuación sencilla, guarda el contacto en Google Sheets, te manda un aviso al móvil y responde al cliente con un email de confirmación. Entrada: nombre, email, teléfono y mensaje. Salida: fila en la hoja, aviso y correo. Se monta en n8n y puede hacerse con el mismo esquema en Make o Zapier.

## Cómo usarla

1. Expón la URL del webhook y cambia el action del formulario
2. Configura Gmail y Telegram
3. Prueba con un envío real
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando los leads de tu web llegan a un correo que miras dos veces al día y pierdes contactos porque tardas horas en responder.

## Cómo ganar dinero con ella

Responder en menos de 5 minutos multiplica por varias veces las opciones de cerrar un lead; y te ahorra el plan de pago de un formulario tipo Typeform o Jotform.

- Captación de leads para reformas, clínicas o consultores que pierden contactos por tardar en responder.
- Automatización de formularios para agencias que gestionan la web de varios clientes.
- Mantenimiento mensual del flujo de leads con revisión de spam y resumen de contactos.

**Precio orientativo:** 120–300 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Tu formulario de contacto envía los datos a una URL de n8n. El flujo puntúa el mensaje para descartar spam, guarda el contacto en una hoja, te manda un aviso instantáneo al móvil y responde al cliente con un email de confirmación con tu nombre y tu teléfono.
Para cualquier negocio de servicios que capta clientes por su web: reformas, clínicas, abogados, consultores, agencias.

## Lo que necesitas antes
- n8n auto-alojado o en la nube (necesitas una URL pública para el webhook; si lo auto-alojas, con un dominio y HTTPS).
- Acceso al código de tu web para cambiar el `action` del formulario, o el plugin WPForms/Contact Form 7 si es WordPress (ambos permiten enviar a un webhook).
- Credenciales de Google Sheets y Gmail en n8n, y un bot de Telegram (@BotFather) con tu chat_id (@userinfobot).
- Hoja «Leads web» con columnas: `fecha`, `nombre`, `email`, `telefono`, `mensaje`, `origen`, `estado`.

## Los nodos, en orden
1. **Webhook** — Method `POST`, Path `formulario-web`, Respond `Using Respond to Webhook node`. Copia la Production URL. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2. **Code** — normaliza los campos y calcula la puntuación de spam (código abajo).
3. **IF** — condición: `{{ $json.spam }}` *is false*.
4. **Google Sheets** (*Append Row*) — hoja «Leads web».
5. **Telegram** (*Send Message*) — texto: `🔔 Nuevo lead: {{ $json.nombre }} — {{ $json.telefono }}\n{{ $json.mensaje }}`.
6. **Gmail** (*Send*) — To `={{ $json.email }}`, asunto `Hemos recibido tu mensaje`, cuerpo con tu firma y tu teléfono.
7. **Respond to Webhook** — Respond With `JSON`, cuerpo `{ "ok": true }`. Así tu web puede enseñar el «gracias».
8. En la rama false del IF, conecta directamente otro **Respond to Webhook** con `{ "ok": true }` (al spammer también le respondes ok, para que no sepa que le has filtrado).

## El nodo Code
```javascript
const b = $input.first().json.body || $input.first().json;
const nombre = (b.nombre || b.name || '').trim();
const email = (b.email || '').trim().toLowerCase();
const telefono = (b.telefono || b.phone || '').replace(/\s/g, '');
const mensaje = (b.mensaje || b.message || '').trim();
let puntos = 0;
const palabras = ['seo services','crypto','bitcoin','casino','viagra','backlinks','loan','investment opportunity'];
const texto = (mensaje + ' ' + nombre).toLowerCase();
for (const p of palabras) { if (texto.includes(p)) puntos += 3; }
if ((mensaje.match(/https?:\/\//g) || []).length >= 2) puntos += 3;
if (!/^[^@\s]+@[^@\s]+\.[a-z]{2,}$/.test(email)) puntos += 5;
if (mensaje.length < 15) puntos += 2;
if (b.website_hp) puntos += 10; // campo trampa oculto en el formulario
return [{ json: { fecha: new Date().toISOString(), nombre, email, telefono, mensaje, origen: b.origen || 'web', estado: 'nuevo', spam: puntos >= 5, puntos } }];
```

## El campo trampa en tu formulario
Añade en el HTML del formulario un campo oculto por CSS: `<input type="text" name="website_hp" style="position:absolute;left:-9999px" tabindex="-1" autocomplete="off">`. Los humanos no lo ven, los bots lo rellenan y quedan marcados como spam.

## Cómo probarla
- Con el workflow en modo *Listen for Test Event*, manda el formulario desde tu web. Verás el envío entrar en n8n con todos los campos.
- Prueba también con curl: `curl -X POST https://tu-n8n/webhook/formulario-web -H 'Content-Type: application/json' -d '{"nombre":"Prueba","email":"tu@correo.com","telefono":"600000000","mensaje":"Quiero presupuesto para una reforma de cocina"}'`.
- Manda uno con `website_hp` relleno y comprueba que NO aparece en la hoja.
- Activa el workflow y cambia la URL de test por la de producción en tu formulario (son distintas: `/webhook-test/` frente a `/webhook/`; este es el error número uno).

## Qué puede salir mal
- **Usar la URL de test en producción**: solo funciona mientras tienes n8n abierto escuchando. Usa siempre la Production URL.
- **CORS**: si envías desde JavaScript del navegador, añade en el Webhook, en Options, `Allowed Origins (CORS)` con tu dominio.
- **Emails de confirmación en spam**: manda desde tu dominio con Gmail/Google Workspace y ten SPF y DKIM configurados; si no, usa un servicio como Brevo (300 emails/día gratis).
- **Leads duplicados**: si el usuario hace doble clic, añade un **Google Sheets** de lectura y un **IF** que descarte si ya existe ese email en los últimos 10 minutos.
- **Límite de Gmail**: 500 envíos al día con cuenta gratuita, 2.000 con Workspace. De sobra para leads.

## Cuánto cuesta
- Todo gratis salvo el alojamiento de n8n (0 € en cloud durante la prueba, 4-6 €/mes en un VPS).
- Telegram, Sheets y Gmail: 0 €. Si prefieres WhatsApp en vez de Telegram necesitas WhatsApp Business API (unos 0,03-0,05 € por conversación iniciada), por eso aquí usamos Telegram.
