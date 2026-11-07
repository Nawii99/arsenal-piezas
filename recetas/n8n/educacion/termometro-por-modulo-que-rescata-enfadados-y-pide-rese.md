# Termómetro por módulo: rescata a los enfadados y pide reseña a todos…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Pregunta la satisfacción al terminar cada módulo, no al final del curso: la nota baja te llega a ti para llamar, y todos los alumnos, sea cual sea su nota, reciben la misma petición de reseña en Google.

## Qué es y qué hace

Al terminar cada módulo, el alumno recibe una encuesta de una pregunta (0-10) con campo opcional de texto, creada en Tally. La respuesta llega por webhook a n8n: las notas de 0 a 6 generan una alerta en Slack con una plantilla de respuesta, y a las 48 horas todos los alumnos, con cualquier nota, reciben la misma petición de reseña en Google. Entran respuestas y salen alertas, correos y registros. Para cursos por módulos, con n8n y una hoja NPS.

## Cómo usarla

1. Crea la encuesta en Tally con campos ocultos
2. Conecta el webhook a n8n
3. Escribe la plantilla de respuesta para notas bajas
4. Prueba los tres caminos con respuestas de prueba

## Cuándo usarla

Úsalo cuando te enteras de que un alumno estaba descontento solo cuando pide la devolución, o cuando das buen servicio pero tienes cuatro reseñas en Google.

## Cómo ganar dinero con ella

Cada devolución evitada es el precio del curso entero, y cada reseña nueva en Google ayuda a traer alumnos sin gastar en publicidad.

- Implantación de encuesta por módulo con alertas de nota baja para academias que quieren detectar descontentos a tiempo.
- Seguimiento mensual de satisfacción y reseñas para escuelas online, por cuota.
- Plantilla de encuesta por módulo vendida a formadores que quieren más reseñas en Google.

**Precio orientativo:** 150–350 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Al completar un módulo, el alumno recibe una encuesta de una sola pregunta (0-10) más un campo de texto opcional. La respuesta entra por webhook. Si la nota es 0-6 te salta una alerta en Slack con el texto y una plantilla de respuesta para que le escribas tú en menos de 24 horas. Sea cual sea la nota, a las 48 horas le llega el mismo email pidiéndole reseña en Google con el enlace directo (Google y las tiendas prohíben pedirla solo a quien está contento).

## Lo que necesitas antes
- n8n con webhook accesible desde internet.
- Formulario en **Tally** (gratis, ilimitado) o Typeform: pregunta `Del 0 al 10, ¿cuánto recomendarías este módulo?`, campo abierto `¿Qué cambiarías?`, y campos ocultos `email`, `nombre`, `modulo` que rellenas por URL.
- En Tally: Integrations > Webhooks > pega la URL de producción de tu nodo Webhook.
- Google Sheet `NPS` con: `fecha`, `email`, `nombre`, `modulo`, `nota`, `comentario`, `categoria`, `resena_pedida`.
- Workspace de Slack con una app y un Incoming Webhook (api.slack.com/apps > Incoming Webhooks > Add New Webhook to Workspace).
- Tu enlace de reseña de Google: busca tu ficha en Google, botón Compartir > Escribir una reseña, y copia esa URL.

## Los nodos, en orden
1. **Webhook** — método `POST`, path `nps`, Respond `Immediately`. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2. **Code** — normaliza los campos que manda Tally (vienen anidados en `data.fields`) y clasifica. Código abajo.
3. **Google Sheets** (`Append Row`) — hoja `NPS`.
4. **IF** — campo `{{ $json.categoria }}` igual a `detractor`. Solo la rama verdadera manda la alerta; no decide quién recibe la petición de reseña.
5. Rama verdadera (detractor): **HTTP Request** POST al webhook de Slack con body `{"text": "ALERTA NPS {{ $json.nota }} — {{ $json.nombre }} ({{ $json.email }}) en {{ $json.modulo }}. Dijo: {{ $json.comentario }}"}`.
6. Rama detractor (segundo nodo): **Gmail** a ti mismo con un borrador ya redactado para copiar y pegar al alumno.
7. Desde el nodo 3, en paralelo y para todas las notas: **Wait** de 48 horas.
8. **Gmail** (`Send`) — asunto `{{ $json.nombre }}, una cosita de 30 segundos`, mismo cuerpo para todos, con el agradecimiento y el enlace de reseña.
9. **Google Sheets** (`Update Row`) — marca `resena_pedida` para no volver a pedírsela en el módulo siguiente.

## El código del nodo Code
```javascript
const campos = ($json.data && $json.data.fields) || [];
const val = etiqueta => {
  const f = campos.find(c => (c.label || '').toLowerCase().includes(etiqueta));
  return f ? (Array.isArray(f.value) ? f.value.join(', ') : f.value) : '';
};
const nota = Number(val('recomendar')) ;
let categoria = 'pasivo';
if (nota <= 6) categoria = 'detractor';
if (nota >= 9) categoria = 'promotor';
return [{ json: {
  fecha: $now.format('yyyy-MM-dd HH:mm'),
  email: val('email'),
  nombre: val('nombre'),
  modulo: val('modulo'),
  comentario: val('cambiarias'),
  nota, categoria
} }];
```

## Cómo probarla
- Copia la URL de test del Webhook, ponla en Tally y manda tres respuestas: un 4, un 8 y un 10.
- Comprueba que solo el 4 dispara Slack y que el 4, el 8 y el 10 entran en la espera.
- Baja el Wait a 2 minutos para la prueba y devuélvelo a 48 horas después.
- Manda la URL de producción a Tally cuando actives el workflow: la de test solo funciona con el editor abierto.

## Qué puede salir mal
- **Las etiquetas de los campos**: si cambias el texto de una pregunta en Tally, el Code deja de encontrarla. Usa el `key` del campo en lugar del label si vas a tocar el formulario.
- **Insistir con la reseña**: revisa `resena_pedida` antes de volver a pedirla a un alumno que ya la recibió en un módulo anterior. La petición es la misma para todos, sea cual sea la nota.
- **Slack silencioso**: pon el canal de alertas con notificación de todos los mensajes, o el aviso no sirve de nada.
- **Reseñas incentivadas**: Google prohíbe pagar por reseñas. Pide, no regales nada a cambio.

## Cuánto cuesta
- Tally: gratis con respuestas ilimitadas.
- Slack: gratis (con historial limitado a 90 días).
- Gmail y Sheets: gratis. n8n auto-alojado: 0 euros.
