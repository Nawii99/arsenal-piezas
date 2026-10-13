# Encargos de CV con formulario y borrador automático…

**Tipo:** Receta de automatización · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

El cliente rellena un formulario, tú recibes sus datos y un primer borrador del CV en tu correo para revisar antes de presupuestar.

## Qué es y qué hace

Automatización que recoge encargos de CV con un formulario de Google: al enviarse, registra los datos en una hoja, crea un primer borrador del contenido del CV y te lo manda por email para revisar. Nada sale hacia el cliente de forma automática, así se mantiene la calidad. Usa Google Forms, Sheets, Docs y Gmail con n8n o Make.

## Cómo usarla

1. Crea el formulario y la hoja de encargos
2. Conecta Google Forms, Docs y Gmail en n8n o Make
3. Prueba con un encargo de ejemplo
4. Que lo revise un profesional

## Cuándo usarla

Ya te llegan encargos de CV por WhatsApp o mensajes sueltos y pierdes media hora pidiendo los mismos datos a cada persona.

## Cómo ganar dinero con ella

Pones el formulario en tu web o en tus redes como entrada de tu servicio de CV y cobras cada currículum a [TU PRECIO]. Tú revisas el borrador y respondes al cliente; no sale nada automático hacia él.

- Entrada ordenada de encargos de CV para quien recibe pedidos por WhatsApp y correo.
- Servicio de CV con borrador previo y revisión humana, cobrado por currículum.
- Montaje del flujo para servicios de orientación laboral con muchos encargos al mes.

**Precio orientativo:** 100–200 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Qué consigue: cada vez que alguien rellena tu formulario de encargo de CV, recibes en tu correo sus datos ordenados y un primer borrador del contenido del CV. Tú revisas, lo montas en la plantilla y respondes con el presupuesto. El cliente nunca recibe nada automático: eso es a propósito, porque un borrador sin revisar puede llevar errores y aquí cobras por calidad.

Cuentas que necesitas:
- Google (gratis): un formulario de Google Forms con sus respuestas volcadas a una hoja de Google Sheets (se activa desde el propio formulario, pestaña Respuestas).
- n8n: gratis si lo tienes autoalojado; la versión en la nube de n8n es de pago tras la prueba, mira su precio actual en n8n.io.
- API de Anthropic: de pago por uso. Cada borrador te costará céntimos, pero configura un límite de gasto en la consola de Anthropic antes de activar nada.
- Gmail (gratis) para recibir el aviso.

Campos del formulario (créalos antes de tocar n8n): nombre, email, puesto al que aspira, experiencia resumida, formación, idiomas, para cuándo lo necesita y qué formato quiere (PDF, Word, Notion).

Nodos, en este orden:
1. Google Sheets Trigger. Conecta tu cuenta de Google, elige la hoja de respuestas del formulario y el evento 'Row Added'. Así el flujo arranca solo cuando entra un encargo nuevo.
2. Anthropic (o nodo HTTP Request a la API de Anthropic si tu versión de n8n no trae el nodo). En el prompt del mensaje escribe: 'Con estos datos de un cliente, redacta la materia prima de su CV: frases de experiencia empezando por verbo, formación ordenada de más reciente a más antigua, y una lista de huecos con lo que falte. No inventes nada.' Y debajo inserta los campos de la fila usando las expresiones de n8n (el icono de engranaje de cada campo te deja arrastrarlos).
3. Gmail, operación 'Send'. Destinatario: tu propio correo. Asunto: 'Nuevo encargo de CV: ' seguido del campo nombre. Cuerpo: primero los datos tal cual llegaron del formulario, después el borrador que devolvió el nodo anterior. Así lo tienes todo en un solo email.
4. (Opcional) Segundo nodo de Gmail para enviar al cliente SOLO un acuse de recibo fijo: 'He recibido tu solicitud, te respondo con presupuesto en 24-48 horas'. Sin borrador, sin precio. Si no lo quieres, sáltatelo.

Aviso legal que te toca a ti, no a n8n: en el formulario pon una línea diciendo que los datos se usan solo para preparar el CV y el presupuesto, y borra las filas de la hoja cuando cierres cada encargo. Son datos personales y aplica el RGPD aunque seas un autónomo con tres clientes.

Cómo probarla sin liarla: deja el flujo desactivado, rellena tú mismo el formulario con datos inventados y tu propio email, y usa 'Execute workflow' en n8n para lanzarlo una vez a mano. Comprueba que el email te llega, que el borrador no se ha inventado nada y que el acuse (si lo pusiste) suena bien. Solo entonces activa el flujo. Y borra la fila de prueba de la hoja para que no vuelva a dispararse.
