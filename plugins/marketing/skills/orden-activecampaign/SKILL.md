---
name: orden-activecampaign
description: Pone al día contactos, etiquetas, listas y automatizaciones en ActiveCampaign, con el permiso de envío comprobado y sin lanzar campañas por su cuenta. Úsala cuando la persona pida importar, segmentar, etiquetar o revisar contactos o flujos en ActiveCampaign.
---
# Orden en ActiveCampaign

Esta skill hace el trabajo de oficina de ActiveCampaign: altas, etiquetas, listas, campos y revisión de flujos. Propone, tú apruebas y luego aplica.
Lo que nunca hace sola es enviar. Un correo enviado no se puede recoger, y mandar sin permiso en España tiene consecuencias (mira «Qué NO hacer»).

## Antes de empezar, comprueba la conexión

- Hace falta una conexión a tu cuenta de ActiveCampaign. Puede ser un servidor MCP, si tu cuenta o un proveedor lo ofrece, o una receta de n8n, que tiene nodo para ActiveCampaign.
- También se puede usar la API con la URL y la clave de tu cuenta (en Ajustes, apartado Developer; el nombre puede cambiar).
- Esa clave da acceso total a tu cuenta. Trátala como una contraseña. No la pegues en el chat ni en un documento ni la subas a internet. Si no sabes guardarla bien, pide ayuda a una persona.
- Si no hay conexión, para y explícalo. No simules que has hecho cambios.
- Planes y precios cambian. Míralos en la web de ActiveCampaign. [PLAN QUE USAS]

## Qué preguntar (solo lo que falte)

1. ¿Qué quieres conseguir en concreto? Por ejemplo: importar una lista, etiquetar a quien compró, revisar un flujo.
2. ¿Qué lista o listas afecta?
3. ¿De dónde salen los contactos y cuándo y cómo aceptaron recibir tus correos? Necesito la prueba: formulario, fecha, texto que aceptaron.
4. ¿Ya tienes una forma de nombrar las etiquetas? Si no, propón una sencilla, por ejemplo origen-nombre y estado-nombre.
5. ¿Tienes un contacto de prueba con tu propio email?
6. ¿Cuántos contactos afecta? Por encima de [TAMAÑO DE TANDA, POR EJEMPLO 100] se trabaja por tandas.

## Paso a paso

1. Mira lo que hay: listas, etiquetas, campos personalizados y automatizaciones activas. No crees nada nuevo si ya hay algo parecido.
2. Escribe la acción en una frase y cuenta cuántos contactos toca.
3. Comprueba el permiso. Sin constancia de que aceptaron, no se suscriben como activos. Opciones: enviarles una confirmación (doble confirmación) o dejarlos sin suscribir.
4. Respeta las bajas. Quien se dio de baja no vuelve a suscribirse por una importación, aunque aparezca en la lista nueva. Sepáralos en una lista aparte para informar.
5. Prepara el plan en una tabla: acción, número de contactos, cinco ejemplos y qué se queda fuera. Espera el OK.
6. Prueba con uno a tres contactos de prueba. Comprueba estado (activo, sin confirmar, dado de baja o rebotado), etiquetas y campos.
7. Aplica por tandas y verifica después de cada una.
8. Automatizaciones: puedes revisar y proponer el diseño (disparador, condiciones, acciones). Déjalas en borrador. Activarlas lo hace la persona, después de probarlas con su propio email.
9. Revisa en cada flujo si hay bucles (una etiqueta que activa el flujo que vuelve a poner esa etiqueta), esperas mal puestas y correos que saldrían a destiempo.

## Qué devolver

Resumen en Markdown, máximo una página:

- Qué se ha cambiado: número de contactos, etiquetas añadidas o quitadas, listas afectadas.
- Quién se ha quedado fuera y por qué: sin permiso, de baja, sin email, dudoso.
- Estado de cada automatización tocada: borrador o activa, y quién debe activarla.
- Riesgos que ves y siguiente paso recomendado.

## Qué NO hacer

- No suscribas a nadie sin permiso. En España, la LSSI (art. 21) exige consentimiento previo para comunicaciones comerciales por email, con la excepción de clientes y productos similares, y cada mensaje debe permitir darse de baja fácilmente. La AEPD puede multar el envío sin permiso.
- No importes listas compradas ni sacadas de scraping.
- No reactives a quien se dio de baja.
- No envíes campañas, no actives automatizaciones y no cambies el remitente.
- No borres contactos, listas, campos ni automatizaciones. Si hay que borrar, que lo haga una persona a mano.
- No hagas cambios masivos sin plan aprobado.
- No metas datos de salud, ideología, religión u otros datos sensibles en campos ni etiquetas. Tampoco etiquetas con juicios («moroso», «pesado»).
- No prometas tasas de apertura ni de venta.
- Cuidado con la cuenta: muchas quejas o rebotes pueden hacer que ActiveCampaign limite o cierre la cuenta. Mira sus condiciones.

## Cuándo pedir a una persona

- ActiveCampaign es una empresa de EE. UU. Antes de meter datos de clientes europeos, revisa su acuerdo de tratamiento de datos y cómo gestiona las transferencias.
- Si gestionas la cuenta de otra persona o empresa, necesitas contrato de encargado de tratamiento (art. 28 del RGPD).
- Si no puedes demostrar el permiso de un grupo de contactos, que lo valore un asesor de protección de datos antes de enviarles nada.
