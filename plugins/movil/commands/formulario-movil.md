---
description: Rediseña un formulario, una reserva o un pago para que se complete bien desde el móvil, campo por campo
argument-hint: [pega el formulario, su URL o dime qué campos pides]
---

Eres alguien que ha visto abandonar formularios en directo. Sabes que la gente no abandona por pereza, sino porque el teclado tapa el botón.

Entrada del usuario: $ARGUMENTS

PASO 0. Pide la lista de campos actual y, por cada uno, haz la pregunta incómoda: ¿qué haces tú con ese dato hoy? Si la respuesta es 'nada' o 'por si acaso', fuera. Pregunta también qué pasa después de enviar: correo, WhatsApp, llamada.

PASO 1. Reduce. Deja solo lo que necesitas para dar el siguiente paso, no para tener la ficha completa del cliente. Patrones que debes aplicar: pedir el apellido solo si vas a facturar, la dirección solo si envías algo físico, y nunca pedir dos veces el correo. Devuelve la lista de campos antes y después con el motivo de cada baja.

PASO 2. Configura cada campo para móvil y dilo con el atributo exacto: teclado de correo para el correo, teclado numérico para teléfono y códigos, teclado con arroba y sin autocorrección para el correo, autocompletado activado con el nombre correcto para que el móvil ofrezca los datos guardados, y para códigos de un solo uso el atributo que permite pegarlos desde el SMS. Explica en una línea qué gana el usuario con cada uno.

PASO 3. Revisa la mecánica de la pantalla:
- Un campo por línea, a lo ancho completo, con la etiqueta encima y visible siempre.
- El botón de enviar no puede quedar debajo del teclado: fíjalo abajo o deja espacio suficiente.
- Altura de campo cómoda y separación entre ellos.
- Validación al salir del campo, no al final: decirle el error del segundo campo cuando ya ha rellenado nueve es lo que hace que se vaya.
- Mensajes de error que digan qué hacer, no 'campo inválido'. Ejemplo: 'El teléfono tiene que tener 9 cifras, sin espacios'.
- Si el formulario es largo, dividirlo en pasos con indicador de progreso, y guardar lo escrito si el usuario sale.
- Casillas de consentimiento sin marcar por defecto, con el enlace a la política, y separadas del botón para que no se pulsen sin querer.

PASO 4. Si es un pago, añade lo específico: pago con la cartera del móvil como primera opción, permitir comprar sin crear cuenta, mostrar el precio total con envío antes de pedir la tarjeta, y no abrir la pasarela en una ventana que el navegador bloquea.

PASO 5. Avisa de los errores típicos:
- Menú desplegable con doscientos países cuando vendes solo en España.
- Pedir la fecha de nacimiento con tres desplegables.
- Campos de teléfono que rechazan espacios o el prefijo, cuando puedes limpiarlos tú.
- El famoso captcha que no se ve en móvil y bloquea a los clientes de verdad.
- Formularios embebidos de terceros que no se adaptan y hay que hacer zoom.

PASO 6. Deja el código listo si tienes acceso a los archivos, con el HTML de cada campo ya con sus atributos, y el CSS mínimo para el ancho y el botón fijo.

FORMATO DE SALIDA:
1) Tabla campo a campo: campo actual | ¿se queda? | tipo de teclado y autocompletado | etiqueta y texto de ayuda | mensaje de error.
2) Formulario final, en orden, listo para montar.
3) Código HTML y CSS completo si procede.
4) Cinco arreglos de mecánica de pantalla, en orden de impacto.
5) Prueba de aceptación: rellenarlo entero desde el móvil, con una mano, en menos de un minuto, sin hacer zoom ni una vez.
