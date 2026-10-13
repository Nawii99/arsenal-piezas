# Reseñas en Google solo a los pacientes contentos…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Manda una encuesta de una sola pregunta tras el alta y, si la nota es alta, ofrece el enlace directo a la reseña de Google; si es baja, avisa al responsable.

## Qué es y qué hace

Un día después de la última sesión envía un WhatsApp con una pregunta de 1 a 10. Si la respuesta es 9 o 10, manda el enlace directo para dejar reseña en Google; si es menor, responde con una disculpa y avisa al responsable. Entrada: respuesta del paciente; salida: enlace de reseña o aviso interno. Se monta en n8n con la WhatsApp Cloud API y Google Sheets, con dos plantillas aprobadas.

## Cómo usarla

1. Aprobar las plantillas encuesta_nps y gracias_resena en Meta
2. Copiar el enlace de reseña de tu ficha
3. Probar con un número de prueba
4. Que lo revise un profesional

## Cuándo usarla

Cuando quieras subir en Google Maps sin arriesgarte a pedir reseñas a quien salió descontento y prefieras enterarte tú antes de que lo escriba.

## Cómo ganar dinero con ella

Pasar de 20 a 80 reseñas con 4,8 estrellas multiplica las llamadas desde Maps. El equivalente en anuncios locales serían 200-400 € al mes.

- Montar la captación de reseñas para clínicas que quieren subir su nota en Google Maps.
- Ofrecer el sistema a gimnasios y centros de bienestar de barrio.
- Vender un informe mensual con la nota media y las incidencias detectadas.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Un día después de la última sesión, manda un WhatsApp con una pregunta: del 1 al 10, cuánto nos recomendarías. Si contesta 9 o 10, le llega el enlace directo para dejar la reseña en Google; si contesta menos, el mensaje cambia a una disculpa y salta un aviso interno al responsable.
Va bien para cualquier negocio de salud y bienestar que viva de la zona: fisioterapia, dental, óptica, podología, centros de estética o gimnasios de barrio.

## Lo que necesitas antes
- n8n, Google Sheets y WhatsApp Cloud API configurada (ver la receta de recordatorios para el alta en Meta).
- Dos plantillas aprobadas: encuesta_nps (variable: nombre) y gracias_resena (variables: nombre, enlace).
- El enlace corto de reseña de tu ficha: entra en tu Perfil de Empresa en Google, pulsa Pedir reseñas y copia la URL que empieza por g.page/r/.
- Una hoja de Google Sheets llamada Encuestas con columnas: fecha, nombre, telefono, nota, comentario, estado.
- Una hoja o agenda de donde salgan las altas: puede ser Google Calendar marcando la cita con la palabra ALTA en el título, o una columna alta_el en tu hoja de pacientes.

## Los nodos, en orden
1. **Schedule Trigger**: `0 18 * * 1-6`, todos los días laborables a las 18:00.
2. **Google Calendar** (Get Many Events): After = `{{ $now.minus(1, 'day').startOf('day').toISO() }}`, Before = `{{ $now.minus(1, 'day').endOf('day').toISO() }}`.
3. **Filter**: condición `{{ $json.summary }}` Contains `ALTA`. Solo se pregunta al terminar un tratamiento, no después de cada sesión.
4. **Code**: saca nombre y teléfono del evento, igual que en la receta de recordatorios.
5. **WhatsApp Business Cloud** (Send Template): plantilla encuesta_nps. El texto: «Hola {{1}}, soy de la clínica. En una escala del 1 al 10, ¿cuánto nos recomendarías a un amigo? Responde solo con el número, nos ayuda muchísimo.»
6. **Google Sheets** (Append): fila con fecha, nombre, telefono y estado = enviada.
7. Flujo 2, el que recoge la respuesta: **Webhook** POST en `/nps`, puesto como Callback URL del webhook de WhatsApp en Meta.
8. **Code**: extrae teléfono y texto del payload, y convierte el texto en un número. Código abajo.
9. **Google Sheets** (Update Row): busca por telefono y escribe la nota y el comentario.
10. **Switch** con tres salidas por `{{ $json.nota }}`: mayor o igual a 9, entre 7 y 8, menor o igual a 6.
11. Salida 9-10: **WhatsApp** con la plantilla gracias_resena y el enlace g.page/r/... Añade un **Wait** de 2 minutos antes, para que no parezca automático.
12. Salida 7-8: **WhatsApp** de agradecimiento simple, sin pedir nada.
13. Salida 1-6: **Gmail** al responsable con asunto `Paciente descontento: {{ $json.nombre }} ({{ $json.nota }}/10)` y el teléfono, para que llame ese mismo día. Nada de mensajes automáticos aquí; que llame una persona.

## El trozo de código del nodo 8
```javascript
const body = $input.first().json.body;
const msg = body?.entry?.[0]?.changes?.[0]?.value?.messages?.[0];
if (!msg) return [];
const texto = (msg.text?.body || '').trim();
const m = texto.match(/\b(10|[0-9])\b/);
const nota = m ? parseInt(m[1], 10) : null;
return [{ json: {
  telefono: msg.from,
  texto,
  nota,
  es_nota: nota !== null
} }];
```
Añade después un **IF** con `{{ $json.es_nota }}` Is True, para que un mensaje cualquiera no se cuele como nota.

## Cómo probarla
1. Crea una cita de ayer con el título `Prueba ALTA` y tu móvil en la descripción.
2. Ejecuta el flujo 1 a mano y comprueba que te llega la encuesta.
3. Contesta 10 y revisa que el flujo 2 te devuelve el enlace de reseña y que la hoja se actualiza.
4. Repite contestando 4 y comprueba que te llega el email de aviso interno y ningún mensaje al paciente.
5. Prueba también contestando «gracias» para verificar que el IF descarta lo que no es un número.

## Qué puede salir mal
- **Google prohíbe filtrar reseñas de forma engañosa**: lo que sí puedes hacer es pedirla a todos y facilitar el enlace a quien ya te ha dicho que está contento. No ofrezcas regalos ni descuentos a cambio de reseña, eso sí incumple las normas de Google.
- **Ventana de 24 horas**: si el paciente contesta un día después, ya no puedes escribirle texto libre y necesitas otra plantilla. Por eso el mensaje de agradecimiento también es plantilla.
- **Números sueltos mal interpretados**: si alguien escribe «un 8 de 10», el regex coge el 8 correctamente porque busca la primera coincidencia. Compruébalo con casos raros.
- **Preguntar demasiado**: no mandes la encuesta a la misma persona más de dos veces al año. Filtra en la hoja por telefono y fecha.

## Cuánto cuesta
- n8n auto-alojado y Google: 0 €.
- WhatsApp: unos céntimos por conversación de servicio. Con 120 encuestas al mes, menos de 5 €.
- Total: entre 0 y 8 € al mes.
