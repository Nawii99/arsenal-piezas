# Corrección automática de exámenes con n8n…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Formulario -> IA corrige con tu rúbrica -> nota en hoja -> email con feedback, sin tu intervención.

## Qué es y qué hace

Flujo de n8n que recoge las entregas de un formulario, pide a una IA que las corrija con tu rúbrica, anota la nota en una hoja de cálculo y envía el feedback por email al alumno. Entra la respuesta del formulario y la rúbrica; sale nota, comentario y un registro en Google Sheets. Necesita cuentas de Google y de n8n, y una clave de API de pago por uso de Anthropic u OpenAI.

## Cómo usarla

1. Conecta el formulario a la hoja
2. Escribe la rúbrica en el nodo de IA
3. Prueba con tres entregas
4. Que lo revise un profesional antes de dar las notas

## Cuándo usarla

Los alumnos entregan por un formulario y no quieres corregir uno a uno ni escribir el feedback a mano. Encaja en cursos con muchas entregas parecidas.

## Cómo ganar dinero con ella

Ofrécela a academias o profesores online como montaje y mantenimiento del flujo, con una cuota de instalación y otra mensual [TU PRECIO]. La nota final la valida el profesor.

- Montaje de corrección automática de entregas para academias online.
- Cuota mensual de mantenimiento y revisión del flujo para profesores online.
- Informe semanal de notas por grupo para centros de formación.

**Precio orientativo:** 200–500 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Corrección automática de exámenes con n8n

## Para qué sirve
Cuando un alumno entrega un examen o ejercicio por un formulario online, este flujo lo corrige con IA usando tu rúbrica, apunta la nota en una hoja de cálculo y le manda el feedback por email. Tú solo revisas de vez en cuando.

## Cuentas que hacen falta
- Cuenta de Google (Gmail y Google Sheets, gratis)
- Cuenta de n8n (self-hosted gratis; n8n Cloud tiene un plan gratuito limitado a un número de ejecuciones al mes, revisa el límite actual antes de usarlo con muchos alumnos)
- Cuenta en Anthropic o OpenAI con clave de API (de pago por uso, revisa el precio por token antes de lanzarlo a muchos alumnos, no hay plan gratuito ilimitado)

## Nodos, en orden
1. **Google Sheets Trigger**: se dispara cuando llega una fila nueva en la hoja donde caen las respuestas del formulario (el Google Form debe estar conectado a esa hoja).
2. **Edit Fields (Set)**: recoge el nombre del alumno, el enunciado y la respuesta de la fila nueva, y los deja en variables limpias.
3. **Nodo de IA (Anthropic o OpenAI)**: le pasas la rúbrica en JSON (usa la pieza "Rúbrica de corrección estructurada para IA") junto con el enunciado y la respuesta del alumno, y le pides que devuelva la corrección en JSON.
4. **Function / Edit Fields**: separa el JSON que ha devuelto la IA en campos sueltos: nota, comentario para el alumno, comentario para el profesor.
5. **Google Sheets (Update row)**: escribe la nota y el comentario del profesor en la misma fila del alumno.
6. **Gmail (Send email)**: envía al alumno su nota y su comentario en un email con tono amable.
7. **Opcional: Telegram o Slack**: te avisa cuando se ha corregido un examen, por si quieres revisarlo antes de que llegue al alumno.

## Antes de activarlo en serio
- Los exámenes de alumnos, sobre todo si son menores de edad, son datos personales: revisa que enviarlos a una IA externa cumple la normativa de protección de datos de tu centro o academia, y pide permiso si hace falta.
- Gmail gratuito tiene un límite de envíos diarios (alrededor de 500 emails), no lo montes para cientos de alumnos sin plantearte un proveedor de correo transaccional.
- Antes de conectarlo a un formulario real, prueba con una fila falsa en la hoja de cálculo y comprueba que la nota y el email salen bien.
- Añade la revisión manual (el paso de Telegram o Slack) las primeras semanas, hasta que confíes en cómo corrige la IA.
