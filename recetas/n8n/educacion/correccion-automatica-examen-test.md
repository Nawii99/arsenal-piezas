# Corrección automática de examen tipo test…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Workflow de n8n que corrige exámenes tipo test recogidos con Google Forms y envía la nota por email.

## Qué es y qué hace

Flujo de n8n que corrige un examen tipo test recogido en Google Forms. Cada fila nueva de la hoja de respuestas se compara con una pestaña Clave con la respuesta correcta, un nodo Code en JavaScript calcula la nota y Gmail envía a cada alumno su resultado. Requiere cuentas de Google y de n8n; n8n Cloud solo tiene una prueba gratuita temporal y después es de pago; autoalojado es gratis.

## Cómo usarla

1. Crea el formulario y la hoja Clave
2. Configura el disparador de Google Sheets
3. Ajusta el nodo Code a tus preguntas y prueba con una fila
4. Que lo revise un profesional antes de dar las notas

## Cuándo usarla

Tus alumnos hacen un examen tipo test en un Google Form y quieres que cada uno reciba su nota por email sin corregir a mano.

## Cómo ganar dinero con ella

Ofrece a academias y formadores montarles este sistema de corrección, cobrando la instalación y una cuota de mantenimiento ([TU PRECIO]). El docente revisa las notas antes de darlas por definitivas.

- Instalación de corrección automática de test para academias que usan Google Forms.
- Mantenimiento mensual del flujo de notas para formadores online.
- Informe de resultados por pregunta para profesores que quieren detectar fallos del grupo.

**Precio orientativo:** 150–400 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Qué necesitas antes de montarlo:
- Una cuenta de Google (gratis): para el Formulario, la hoja de respuestas y el envío de emails con Gmail.
- Una cuenta de n8n, self-hosted (gratis, Community Edition) o en la nube (n8n Cloud solo tiene una prueba gratuita temporal y después es de pago; revisa el plan vigente antes de usarlo con muchos alumnos).
- Un Google Form con las preguntas del examen, conectado a una hoja de cálculo de respuestas.
- Una segunda pestaña en esa hoja, llamada Clave, con la respuesta correcta de cada pregunta.

Nodo por nodo:
1. Disparador: nodo Google Sheets Trigger, evento 'On row added', apuntando a la hoja de Respuestas del formulario. Revisa cada minuto si hay una fila nueva.
2. Nodo Google Sheets (Read), lee la pestaña Clave con las respuestas correctas. Solo hace falta leerla una vez por ejecución.
3. Nodo Code (JavaScript), compara respuesta por respuesta la fila nueva del alumno contra la Clave y calcula la nota sobre el total de preguntas.
4. Nodo Google Sheets (Update), escribe la nota calculada en una columna nueva de la misma hoja de Respuestas, en la fila del alumno.
5. Nodo IF, comprueba si la nota es igual o mayor al aprobado que tú definas.
6. Nodo Gmail (Send Email), rama de aprobado: envía al alumno su nota y un mensaje de enhorabuena.
7. Nodo Gmail (Send Email), rama de suspenso: envía al alumno su nota y un aviso de que puede repasar el tema antes de la recuperación.

Cómo probarla sin liarla:
- Antes de activar el workflow, rellena tú mismo el Google Form dos veces, una con todas las respuestas correctas y otra con todas mal, para ver que la nota calculada y el email que llega son correctos.
- Pon tu propio correo como destinatario de prueba en el nodo Gmail antes de dar acceso al formulario a los alumnos.
- Ten en cuenta que Gmail tiene un límite diario de envíos en cuentas gratuitas (en torno a 500 al día); si tienes muchos alumnos y varios exámenes el mismo día, puedes llegar a ese límite y que se corten los envíos.
