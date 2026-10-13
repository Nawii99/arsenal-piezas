---
name: privacidad-permisos-app
description: Prepares an app's privacy paperwork: Google Play Data Safety answers, Apple privacy labels, permission request strings, tracking consent and a GDPR-compliant privacy policy. Use when the user is submitting an app, is filling the data safety or privacy forms, was rejected over privacy, or asks what permissions to request.
---

# Privacidad y permisos de tu app

## Qué hace
Traduce lo que hace tu app a las respuestas exactas de los formularios de privacidad de Google Play y App Store, redacta la política de privacidad y los textos de los permisos.

## Cuándo se activa
Cuando el usuario va a publicar, menciona "seguridad de los datos", "etiquetas de privacidad", RGPD, permisos, ATT, cookies o un rechazo por privacidad.

## Qué preguntar si falta información
1. ¿Qué datos recoge la app? Enumera: correo, nombre, teléfono, ubicación, fotos, contactos, salud, pagos.
2. ¿Qué servicios de terceros usas? (analítica, publicidad, notificaciones, base de datos, pasarela de pago, chat de soporte)
3. ¿Los datos salen del dispositivo o se quedan dentro?
4. ¿Vendes o compartes datos con anunciantes?
5. ¿Quién es el responsable legal: tu nombre y NIF o el de una sociedad? ¿Dirección y correo de contacto?
6. ¿Hay menores de edad entre tus usuarios?

## Método
1. Haz el inventario real de datos, servicio por servicio. Casi nadie recuerda que la herramienta de analítica o el SDK de notificaciones recogen identificadores del dispositivo. Cada SDK cuenta como recogida de datos aunque tú no mires esos datos.
2. Por cada dato responde tres cosas, que es lo que preguntan las dos tiendas: para qué se usa, si se comparte con terceros y si está vinculado a la identidad del usuario.
3. Google Play, formulario de Seguridad de los datos: marca recogidos vs compartidos, finalidad, si es opcional, si se cifran en tránsito y si el usuario puede pedir el borrado. Si dices que puede borrarlos, tienes que ofrecer de verdad un modo de hacerlo, también desde fuera de la app.
4. App Store, etiquetas de privacidad: mismas categorías, más la distinción entre datos usados para seguimiento y datos no vinculados. Si usas el identificador de publicidad para seguimiento, necesitas el diálogo de App Tracking Transparency, y antes una pantalla propia que explique el intercambio.
5. Textos de permisos: cada permiso de iOS necesita su cadena de propósito (NSCameraUsageDescription y compañía). Escríbelas en primera persona del producto y concretas: "Usamos la cámara para que escanees el ticket y no lo teclees". Un texto genérico es motivo de rechazo directo.
6. Política de privacidad: obligatoria y con URL pública accesible sin login, enlazada en las dos consolas y dentro de la app. Contenido mínimo para España: identidad y NIF del responsable, datos que se tratan, finalidades, base legal, destinatarios y encargados, transferencias fuera de la UE, plazos de conservación, derechos (acceso, rectificación, supresión, oposición, portabilidad, limitación) y cómo ejercerlos, y mención a la Agencia Española de Protección de Datos.
7. Borrado de cuenta: las dos tiendas piden que si se puede crear cuenta desde la app, se pueda pedir el borrado desde la app y desde una web. Prepara ese flujo.
8. Menores: si tu app se dirige a niños hay requisitos extra en las dos tiendas; si no se dirige a niños, dilo así en la ficha y no uses imágenes infantiles.

## Formato exacto de la respuesta
- INVENTARIO DE DATOS: dato | de dónde sale | para qué | quién lo recibe | ¿se puede evitar?
- RESPUESTAS PLAY: tabla lista para copiar en el formulario de Seguridad de los datos
- ETIQUETAS APP STORE: tabla lista para App Store Connect
- CADENAS DE PERMISOS en español y en inglés
- PANTALLA PREVIA DE ATT si aplica: titular, dos frases y dos botones
- POLÍTICA DE PRIVACIDAD completa, lista para publicar, con los huecos marcados en MAYÚSCULAS
- FLUJO DE BORRADO DE CUENTA en pasos
- LISTA DE COSAS A ELIMINAR si quieres declarar menos datos

## Errores típicos
- Declarar "no recogemos datos" teniendo analítica o publicidad: es el rechazo más común y además es mentira.
- Copiar la política de privacidad de otra web con su nombre dentro.
- Pedir permisos que no usas "por si acaso": Apple pregunta dónde se usa cada uno.
- Poner la política de privacidad detrás de un login o en un PDF de Drive.
- Olvidar el borrado de cuenta.

## Avisos honestos
- Esto es ayuda práctica, no asesoramiento jurídico. Si tratas datos sensibles (salud, menores, biometría) consulta con un profesional.
- Los formularios de Apple y Google cambian de nombre y de casillas cada temporada: guíate por lo que veas en la consola.
- Cuantos menos datos recojas, menos papeleo y menos riesgo. Recoger menos es una decisión de producto válida.
