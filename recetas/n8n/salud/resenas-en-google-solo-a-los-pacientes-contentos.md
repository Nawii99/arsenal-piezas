# Encuesta de fin de tratamiento y petición de reseña en Google…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Manda una encuesta de una sola pregunta tras el alta y ofrece a todos el enlace directo a la reseña de Google, sea cual sea la nota; si la nota es baja, además avisa al responsable para que llame.

## Qué es y qué hace

Un día después de la última sesión envía un WhatsApp con una pregunta de 1 a 10. Con cualquier respuesta manda el enlace directo para dejar reseña en Google, y si la nota es 6 o menos avisa además al responsable para que llame. Entrada: respuesta del paciente; salida: enlace de reseña (siempre) y aviso interno (si la nota es baja). Se monta en n8n con la WhatsApp Cloud API y Google Sheets, con dos plantillas aprobadas.

## Cómo usarla

1. Aprobar las plantillas encuesta_nps y gracias_resena en Meta
2. Copiar el enlace de reseña de tu ficha
3. Probar con un número de prueba
4. Que lo revise un profesional

## Cuándo usarla

Cuando quieras subir en Google Maps pidiendo la reseña a todos tus pacientes por igual y enterarte tú antes de que alguien descontento lo escriba.

## Cómo ganar dinero con ella

Pasar de 20 a 80 reseñas multiplica las llamadas desde Maps. El equivalente en anuncios locales serían 200-400 € al mes.

- Montar la captación de reseñas para clínicas que quieren subir su nota en Google Maps.
- Ofrecer el sistema a gimnasios y centros de bienestar de barrio.
- Vender un informe mensual con la nota media y las incidencias detectadas.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Un día después de la última sesión, manda un WhatsApp con una pregunta: del 1 al 10, cuánto nos recomendarías. Con cualquier respuesta le llega el agradecimiento con el enlace directo para dejar la reseña en Google, sea cual sea la nota (Google y las tiendas prohíben pedir reseñas solo a quien está contento); si contesta 6 o menos, además salta un aviso interno al responsable para que le llame.
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
7. Flujo 2, el que recoge la respuesta: **Webhook** POST en `/nps`, puesto como Callback URL del webhook de WhatsApp en Meta. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
8. **Code**: extrae teléfono y texto del payload, y convierte el texto en un número. Código abajo.
9. **Google Sheets** (Update Row): busca por telefono y escribe la nota y el comentario.
10. Rama común, para todas las notas: **Wait** de 2 minutos, para que no parezca automático, y **WhatsApp** con la plantilla gracias_resena y el enlace g.page/r/... Lo recibe todo el que contesta, sea cual sea su nota: filtrar quién puede reseñar según su satisfacción está prohibido por Google y las tiendas.
11. Rama en paralelo, solo para el aviso interno: **IF** con `{{ $json.nota }}` menor o igual a 6. Si se cumple, **Gmail** al responsable con asunto `Paciente descontento: {{ $json.nombre }} ({{ $json.nota }}/10)` y el teléfono, para que llame ese mismo día. Que llame una persona; esa llamada sirve para mejorar y no condiciona el enlace de reseña.

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
4. Repite contestando 4 y comprueba que te llega el email de aviso interno y que el paciente recibe igualmente el enlace de reseña.
5. Prueba también contestando «gracias» para verificar que el IF descarta lo que no es un número.

## Qué puede salir mal
- **Google prohíbe pedir reseñas solo a los contentos**: el enlace va a todos los que contestan, sea cual sea su nota; tú puedes llamar a quien puntuó bajo para mejorar, pero sin condicionar el enlace. No ofrezcas regalos ni descuentos a cambio de reseña, eso sí incumple las normas de Google.
- **Ventana de 24 horas**: si el paciente contesta un día después, ya no puedes escribirle texto libre y necesitas otra plantilla. Por eso el mensaje de agradecimiento también es plantilla.
- **Números sueltos mal interpretados**: si alguien escribe «un 8 de 10», el regex coge el 8 correctamente porque busca la primera coincidencia. Compruébalo con casos raros.
- **Preguntar demasiado**: no mandes la encuesta a la misma persona más de dos veces al año. Filtra en la hoja por telefono y fecha.

## Cuánto cuesta
- n8n auto-alojado y Google: 0 €.
- WhatsApp: unos céntimos por conversación de servicio. Con 120 encuestas al mes, menos de 5 €.
- Total: entre 0 y 8 € al mes.
