---
name: plano-chatbot-web-atencion-contactos
description: Diseña el guion completo de un chatbot para web, con atención de dudas básicas y captación de contactos, más la guía de montaje en Landbot y un plan de pruebas. Úsala antes de montar el bot.
---

# Guion y plano de un chatbot para web con captación de contactos

## Qué hace
Landbot es una herramienta para montar chatbots sin programar, arrastrando bloques. El editor es visual, así que Claude no lo monta por ti. Lo que hace es lo difícil de pensar.
Te deja por escrito el objetivo, el árbol de la conversación, los textos exactos, las respuestas a las preguntas frecuentes, las reglas para pasar a una persona, los textos legales y un plan de pruebas. Montarlo después es copiar y pegar.
Mira en landbot.io qué incluye tu plan, qué integraciones tiene y cuántos chats permite [no te doy cifras porque cambian].

## Qué preguntar antes de empezar
1. Qué quieres que haga el bot. Resolver dudas, recoger contactos, reservar citas. Escoge uno como principal.
2. Las 10 o 15 preguntas que más te hacen los clientes, con la respuesta correcta de cada una. Si no las tienes, pega textos de tu web o emails antiguos para sacarlas de ahí.
3. Horario y quién atiende cuando el bot no puede. Por qué canal. Email, teléfono, WhatsApp.
4. Qué datos mínimos pedir. Nombre y email. El teléfono solo si lo vas a usar.
5. Dónde van los contactos. Un CRM, una hoja, un email.
6. Datos legales. Razón social, enlace a la política de privacidad y contacto de privacidad.
7. Tono. Cercano, formal.

## Paso a paso
1. Fija un único objetivo y un número para medirlo. Por ejemplo, contactos válidos por semana. Con dos objetivos principales, el bot se lía.
2. Mensaje de apertura. Dice que es un bot, qué sabe hacer y ofrece tres o cuatro botones. El aviso de que se habla con una máquina es obligatorio en la UE para estos sistemas [comprueba fechas y alcance del Reglamento europeo de IA con tu asesor].
3. Dibuja el árbol en texto. Inicio, botones, respuesta, «¿te ha servido?» y después contacto o persona. Tres niveles como máximo.
4. Cada respuesta, de tres frases como máximo y solo con la información aprobada. Si el dato no está, como un precio o un plazo, el bot dice que eso lo confirma una persona y ofrece el contacto. No se inventa nada.
5. Captación. Pide el contacto después de dar algo útil, no antes. Con casilla de consentimiento sin marcar, enlace a la política de privacidad y la finalidad clara. No pidas más de lo necesario.
6. Paso a persona. Cuando el bot no entiende dos veces seguidas, cuando aparezcan palabras como queja, reclamación, urgente, devolución o factura, y en temas de salud, legales o de dinero. Con un botón visible de «hablar con una persona» siempre. Fuera de horario, di un plazo de respuesta real [PLAZO].
7. Textos de fallo. «No te he entendido» y vuelta al menú.
8. Plan de pruebas con 20 conversaciones. Diez normales, cinco con faltas y mensajes raros, tres con un cliente enfadado y dos que intentan sacar datos, como pedir el email de otro cliente. Tabla con el resultado esperado de cada una.
9. Guía de montaje. Crear el bot, poner los bloques, guardar las respuestas del usuario, enviar el contacto a su destino, avisar a quien lo atienda, probar en el móvil y publicar en la web. Los nombres exactos de los bloques de Landbot [compruébalos en su ayuda]. Revisa también tu aviso de cookies si el bot carga scripts externos.
10. A las dos semanas, revisa conversaciones reales y añade lo que el bot no supo contestar.

## Qué devolver
Un documento en Markdown con siete secciones. Objetivo, árbol de conversación, textos, preguntas frecuentes, reglas de paso a persona, textos legales y plan de pruebas. Y al final la guía de montaje.

## Qué NO hacer
- No hagas pasar al bot por una persona.
- No des consejos médicos, legales, fiscales ni de inversión.
- No prometas precios, plazos ni descuentos que no estén en la lista aprobada.
- No pidas DNI, tarjetas, contraseñas ni datos de salud.
- No dejes al usuario sin salida a una persona.
- No actives respuestas libres de IA sin límites. Si tu plan de Landbot incluye IA [compruébalo], restríngela a tus preguntas frecuentes y pruébala antes. Una IA sin límites puede inventar condiciones que luego te reclamen.
- No guardes conversaciones para siempre. Decide cuánto tiempo y bórralas.
- No publiques sin haberlo probado en el móvil.

## Qué revisa una persona antes de publicar
- Alguien de tu empresa lee todas las respuestas, sobre todo precios, plazos, garantías y devoluciones.
- Un abogado o tu gestoría, el texto de consentimiento y la política de privacidad. El RGPD y la LSSI aplican a lo que recoges y a lo que envías después.
- Quien atienda el paso a persona confirma que de verdad verá los avisos y en qué plazo.
- Si tu empresa es grande, pregunta si la normativa de atención a la clientela te obliga a ofrecer atención humana [compruébalo con tu asesor].

## Dónde guardarla
Guarda este texto como SKILL.md dentro de la carpeta .claude/skills/plano-chatbot-web-atencion-contactos/ de tu proyecto. Claude Code la usará cuando le pidas diseñar un chatbot, o puedes llamarla escribiendo /plano-chatbot-web-atencion-contactos.
