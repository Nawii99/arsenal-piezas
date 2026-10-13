# Buzón de sugerencias dentro de la app, clasificado solo…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Recibe el feedback que la gente escribe dentro de tu app, lo clasifica en fallo, idea o queja con IA, lo ordena en una hoja y acusa recibo.

## Qué es y qué hace

Flujo de n8n que recibe por webhook el feedback que los usuarios escriben dentro de tu app, pide a una IA de texto (Claude, Codex, Gemini o una IA local) que lo etiquete como fallo, idea, queja o elogio con urgencia y resumen, lo guarda en la hoja Feedback y envía un acuse de recibo por correo. Entran el texto, la versión y el correo; sale una fila clasificada y el acuse. Requiere un POST con JSON desde la app.

## Cómo usarla

1. 1. Añade a la app el envío POST con el JSON acordado
2. 2. Crea la hoja Feedback y conecta la IA elegida
3. 3. Revisa las etiquetas de la primera semana
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tengas (o vayas a poner) un formulario de «Cuéntanos» dentro de la app y no quieras que ese feedback muera en un correo sin leer.

## Cómo ganar dinero con ella

Convierte el feedback disperso en una lista priorizada. Y contestar en el minuto uno evita muchas reseñas de una estrella, que cuestan descargas.

- Buzón de feedback clasificado para apps con usuarios que no dicen qué les falta hasta que se van.
- Acuses de recibo automáticos para apps que quieren responder en el minuto uno y frenar reseñas negativas.
- Priorización de sugerencias para equipos de producto que reciben ideas dispersas por correo y redes.

**Precio orientativo:** 150–350 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Tu app envía cada sugerencia a un webhook; la IA la etiqueta (fallo, idea, queja, elogio), le pone urgencia y un resumen de una línea, se guarda en una hoja y el usuario recibe un acuse de recibo escrito como una persona.
Para apps con usuarios que no sabes qué quieren y no tienes tiempo de leer correos sueltos.

## Lo que necesitas antes
n8n, Google Sheets y Gmail conectados, más una clave de la API de Anthropic (console.anthropic.com > API Keys) puesta en Credentials > Anthropic API.
Que tu app haga un POST al webhook con este JSON: `{"email":"","texto":"","version":"","plataforma":"iOS","id_usuario":""}`. Es media hora de trabajo para tu desarrollador; si no tienes app propia, sirve igual con un **n8n Form Trigger** enlazado desde los ajustes de la app.
Hoja `Feedback` con columnas: fecha, tipo, urgencia, resumen, texto, email, version, plataforma.
Bot de Telegram para lo urgente.

## Los nodos, en orden
1. **Webhook**: POST, Path `feedback-app`, Authentication = Header Auth con una clave larga que solo conozca tu app.
2. **Basic LLM Chain** con modelo Anthropic. Prompt del sistema: «Clasificas mensajes de usuarios de una app. Devuelve SOLO un JSON con las claves tipo (fallo|idea|queja|elogio|otro), urgencia (alta|media|baja) y resumen (máximo 90 caracteres, en español). Urgencia alta solo si impide usar la app o hay dinero de por medio.» Mensaje: `{{ $json.body.texto }}`.
3. **Code**: parsea la respuesta y la une con los datos originales. Código abajo.
4. **Google Sheets** (Append): hoja `Feedback`.
5. **IF**: String `{{ $json.urgencia }}` igual a `alta`.
6. **Telegram** (rama true): «URGENTE ({{ $json.tipo }}): {{ $json.resumen }} — v{{ $json.version }} {{ $json.plataforma }}».
7. **IF** segundo: que `{{ $json.email }}` no esté vacío.
8. **Gmail** (Send): acuse de recibo con el resumen que ha hecho la IA para que el usuario vea que le has entendido.

## El nodo Code
```javascript
const original = $('Webhook').first().json.body || {};
let bruto = $input.first().json.text || $input.first().json.output || '{}';
bruto = String(bruto).replace(/```json/g, '').replace(/```/g, '').trim();
let ia = { tipo: 'otro', urgencia: 'baja', resumen: '' };
try { ia = JSON.parse(bruto); } catch (e) { ia.resumen = bruto.slice(0, 90); }
return [{ json: {
  fecha: new Date().toISOString(),
  tipo: ia.tipo || 'otro',
  urgencia: ia.urgencia || 'baja',
  resumen: (ia.resumen || '').slice(0, 90),
  texto: (original.texto || '').slice(0, 2000),
  email: original.email || '',
  version: original.version || '',
  plataforma: original.plataforma || '',
  id_usuario: original.id_usuario || ''
}}];
```

## El acuse de recibo
«Hola: he leído lo que me cuentas sobre *{{ resumen }}*. Lo he anotado y, si es un fallo, lo miro esta semana. Si quieres contarme algo más, responde a este correo, que lo leo yo.» Firmado con tu nombre, no con «El equipo de soporte».

## Cómo probarla
Con el Webhook en modo test, manda una petición desde el terminal: `curl -X POST -H "Content-Type: application/json" -H "X-Clave: tuclave" -d '{"email":"tucorreo@ejemplo.com","texto":"La app se cierra al subir una foto","version":"2.1","plataforma":"iOS"}' TU_URL_WEBHOOK`.
Ese ejemplo debe salir como tipo fallo y urgencia alta. Prueba también con «me encanta la app» y comprueba que sale elogio y baja.

## Qué puede salir mal
Si el modelo devuelve texto alrededor del JSON, el `try/catch` del Code te salva; refuerza el prompt con «SOLO JSON, sin explicaciones».
Sin la autenticación por cabecera, cualquiera que descubra la URL puede llenarte la hoja de basura: no te la saltes.
Datos personales: guardas correos y comentarios, así que menciónalo en tu política de privacidad y no dejes la hoja compartida con enlace público.
Si te llega mucho volumen, cambia el Append de Sheets por una base de datos (Airtable o Postgres), que aguanta mejor.

## Cuánto cuesta
Clasificar un mensaje con Claude Haiku cuesta una fracción de céntimo: 1.000 sugerencias al mes se quedan por debajo de 1 €. Sheets, Gmail, Telegram y n8n auto-alojado, gratis.
