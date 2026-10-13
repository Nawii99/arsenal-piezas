# Encuesta de satisfacción que se convierte en reseñas y…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Al terminar el curso manda una encuesta corta, y según la nota pide reseña en Google, pide permiso para usar el testimonio o te avisa a ti para arreglarlo.

## Qué es y qué hace

Tres días después de terminar el curso, envía una encuesta de dos preguntas con Google Forms. Si la nota es 9 o 10, pide una reseña en Google con enlace directo; si es 7-8, pregunta qué falta; si es 6 o menos, avisa a la persona responsable para llamar. Entran respuestas de la encuesta y salen correos y avisos. Para academias y cursos online, con n8n, Sheets y Gmail.

## Cómo usarla

1. Crea el formulario de dos preguntas
2. Copia tu enlace de reseña desde el perfil de negocio
3. Programa los tres caminos según la nota
4. Revisa los correos antes de activarlo

## Cuándo usarla

Úsalo cuando tengas alumnos contentos pero cero reseñas online, o cuando te enteres de que alguien salió descontento semanas después, cuando ya no hay nada que hacer.

## Cómo ganar dinero con ella

Pasar de 12 a 60 reseñas en Google multiplica las matrículas que llegan solas. Y detectar un descontento a tiempo evita la reseña de una estrella.

- Montaje de encuesta y petición de reseñas para academias que quieren más opiniones en Google, con enlace directo.
- Gestión mensual de la reputación de cursos online, con avisos de nota baja y respuesta a alumnos, por cuota.
- Plantilla de encuesta post-curso vendida a formadores presenciales y escuelas de idiomas.

**Precio orientativo:** 150–300 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Tres días después de terminar el curso, envía una encuesta de dos preguntas. Si la nota es 9 o 10, pide reseña en Google con enlace directo y permiso para publicar su comentario. Si es 7-8, agradece y pregunta qué falta. Si es 6 o menos, te avisa al momento para que llames.
Para academias, escuelas de idiomas, formadores presenciales y cursos online.

## Lo que necesitas antes
- Una hoja «Finalizados» con: alumno | email | curso | fecha_fin | encuesta_enviada
- Un Google Form con dos preguntas: «Del 0 al 10, ¿nos recomendarías?» (escala) y «¿Qué es lo que más te ha servido?» (párrafo). Añade un campo oculto o pregunta corta «Email».
- Tu enlace corto de reseña de Google: entra en tu Perfil de Negocio, botón «Pedir reseñas», copia el enlace `g.page/r/...`.
- Credenciales de Google Sheets y Gmail. Opcional Slack.

## Los nodos, en orden
1) **Schedule Trigger**. Cron `0 10 * * *`.
2) **Google Sheets** (Get Row(s)) sobre «Finalizados».
3) **Code** que filtra a quien terminó hace exactamente 3 días y no tiene encuesta enviada:
```js
const hoy = new Date();
const d = f => Math.floor((hoy - new Date(f)) / 86400000);
return items.filter(i => i.json.email && !i.json.encuesta_enviada && d(i.json.fecha_fin) === 3)
  .map(i => ({ json: { ...i.json, nombre: String(i.json.alumno).split(' ')[0] } }));
```
4) **Gmail** (Send). Asunto: `{{ $json.nombre }}, dos preguntas y te dejo en paz`. Cuerpo con el enlace al formulario y el email precargado: `https://docs.google.com/forms/d/e/TU_ID/viewform?usp=pp_url&entry.123456={{ $json.email }}`. El número de `entry` lo sacas pulsando botón derecho > Inspeccionar sobre el campo, o desde «Obtener enlace prerrellenado» en Forms.
5) **Google Sheets** (Update Row) marcando `encuesta_enviada` con la fecha.
6) Segundo flujo: **Google Sheets Trigger** (Row Added) sobre la hoja de respuestas del formulario.
7) **Switch** en modo Rules sobre la nota `{{ Number($json['Del 0 al 10, ¿nos recomendarías?']) }}`: salida 0 si es mayor o igual que 9, salida 1 si está entre 7 y 8, salida 2 si es menor que 7.
8) Salida promotores: **Gmail** con asunto `¡Gracias! ¿Nos echas una mano en 30 segundos?`, el enlace `g.page/r/...` bien visible y una frase pidiendo permiso para publicar su comentario en la web. Después **Google Sheets** (Append Row) en una hoja «Testimonios» con el texto de la respuesta abierta.
9) Salida neutros: **Gmail** agradeciendo y preguntando «¿Qué habría hecho que nos pusieras un 10?». Nada de pedir reseña aquí.
10) Salida detractores: **Slack** (o Gmail a ti) con etiqueta URGENTE, nombre, curso, nota y el comentario. Añade un **Wait** de 1 día y un segundo aviso si no has marcado la fila como atendida.
11) Un **Schedule Trigger** mensual + **Code** que calcule tu NPS: `((promotores - detractores) / total) * 100`, y te lo mande por email.

## Cómo probarla
- Añade una fila con fecha_fin de hace 3 días y tu email; ejecuta el primer flujo.
- Rellena el formulario tres veces con nota 10, 8 y 4 y comprueba que cada una sale por su salida.
- Verifica que el enlace de reseña abre directamente el cuadro de escribir en Google.

## Qué puede salir mal
- **Pedir reseña a todo el mundo**: es el error clásico y te trae estrellas malas. Segmenta siempre por nota.
- **Comprar o incentivar reseñas**: va contra las normas de Google y te pueden tumbar la ficha. Pide, no regales.
- **El campo precargado no funciona**: usa «Obtener enlace prerrellenado» desde el propio Forms, no montes la URL a mano.
- **Nota como texto**: el Switch falla si la escala llega como cadena. Envuélvela en `Number()` como en el paso 7.
- **Testimonios sin permiso**: guarda en la hoja una columna con el consentimiento; en España lo necesitas para publicar nombre y foto.

## Cuánto cuesta
- Gratis del todo: Forms, Sheets, Gmail, Slack gratuito y n8n auto-alojado.
- Solo pagarías por SMS o WhatsApp si prefieres mandar la encuesta por ahí.
