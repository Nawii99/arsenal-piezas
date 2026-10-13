---
name: entorno-de-pruebas
description: Reglas para probar herramientas de marketing (CRM, email, pagos, n8n, hojas) sin tocar clientes ni dinero reales. Úsala cuando el usuario vaya a ejecutar, importar, enviar o cobrar algo por primera vez, o diga que quiere probar un flujo, una secuencia o una integración.
---

# Entorno de pruebas seguro

## 1. La regla única
Nada se ejecuta contra datos reales hasta que ha funcionado una vez contra datos falsos. Si no hay entorno de pruebas, el primer paso es montarlo. Nunca se prueba en producción por prisa.

## 2. Qué preguntar antes de tocar nada
- ¿Qué herramientas intervienen? (CRM, email, pagos, hoja de cálculo, WhatsApp, n8n).
- ¿Alguna de ellas envía mensajes o cobra dinero? Esas son las peligrosas.
- ¿Existe ya una copia de prueba o vamos a montarla ahora?
- ¿Quién va a recibir los mensajes de prueba? Debe ser el propio usuario, nunca un cliente.

## 3. Cómo se monta, herramienta por herramienta
- Google Sheets o Airtable: duplica la hoja y ponle `PRUEBA -` delante del nombre. El flujo apunta a la copia. Cuando funcione, se cambia el enlace a la real y no se toca nada más.
- Brevo, Mailchimp, MailerLite y similares: crea una lista o audiencia llamada `PRUEBA` con 3 emails que sean tuyos (usa alias como tunombre+prueba1@tudominio.com si tu correo los admite). Las secuencias se prueban contra esa lista.
- HubSpot, Pipedrive, Zoho: no tienen sandbox gratis en los planes básicos. Alternativa: importa contactos falsos (comando `/datos-falsos`) con un campo o etiqueta `PRUEBA` para poder borrarlos todos de golpe con un filtro.
- Stripe: activa el modo de prueba (interruptor en el panel). Las claves empiezan por `sk_test_` y `pk_test_`. Tarjeta de prueba: 4242 4242 4242 4242, cualquier fecha futura y cualquier CVC. No se mueve dinero real.
- Shopify: crea un pedido de prueba con la pasarela ficticia (Bogus Gateway) desde la configuración de pagos, o usa una tienda de desarrollo si tienes cuenta de partner.
- WhatsApp Business API: solo envías a tu propio número hasta que el flujo esté cerrado. Los envíos masivos a números que no te han escrito antes pueden bloquear la cuenta.
- LinkedIn, Instagram, TikTok: no hay modo de prueba. Automatizar mensajes o acciones en estas redes puede costarte la cuenta. Si el flujo publica o escribe, prueba con un nodo que solo muestre el texto, y publica a mano.
- n8n: duplica el flujo y llama a la copia `PRUEBA - nombre`. Usa el botón de ejecutar paso a paso. Fija los datos de salida de un nodo (pin) para no volver a llamar a la API cada vez que pruebas el siguiente. Para la API que aún no quieres tocar, monta la receta `api-de-mentira-n8n`.

## 4. Datos que se usan
Solo datos inventados con emails `@example.com` y teléfonos con 555. Nunca un CSV exportado del CRM real aunque sea pequeño. Si el usuario ofrece datos reales para probar, se le dice que no y se generan falsos.

## 5. Checklist antes de pasar a real
1. El flujo ha funcionado de principio a fin al menos 3 veces con datos falsos, incluyendo un caso con un campo vacío y otro con un email mal escrito.
2. Se ha revisado a qué lista, hoja, tarjeta o cuenta apunta cada nodo. Uno por uno, en voz alta si hace falta.
3. Los datos de prueba se han borrado de la herramienta real o están marcados para borrarse.
4. El primer envío real se hace a un lote pequeño (5 o 10 contactos) y se espera a ver resultados antes de lanzar el resto.
5. Hay una forma de parar el flujo en 10 segundos: el usuario sabe dónde está el botón de desactivar.

## 6. Qué NO hacer
- No probar una secuencia de email enviándola a un solo cliente real porque es de confianza.
- No usar claves de Stripe reales en un flujo de n8n que todavía se está montando.
- No dejar los contactos falsos en el CRM real: contaminan las estadísticas y acaban en un envío.
- No dar por probado un flujo que solo se ha ejecutado con el caso bonito. Los fallos vienen de campos vacíos, acentos y duplicados.
- No prometer al cliente que el flujo no fallará nunca. Se promete que se ha probado con estos casos concretos, y se lista cuáles.
