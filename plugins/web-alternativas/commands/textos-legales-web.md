---
name: textos-legales-web
description: Redacta el borrador de aviso legal, política de privacidad y política de cookies para una web publicada en España. Se activa cuando el usuario pide textos legales para su web o dice que va a publicarla y no tiene nada.
---

## Qué hace

Redacta tres documentos en español de España, adaptados a la LSSI, el RGPD y la LOPDGDD, con los datos reales del usuario. Son borradores: sirven para no publicar la web vacía de textos, no sustituyen a un abogado.

## Qué preguntar antes de empezar

Pregunta todo de una vez, en una sola lista, y no empieces a redactar hasta tener respuesta:

1. Titular de la web: nombre completo o razón social, NIF/CIF, dirección postal completa, email de contacto.
2. Si es sociedad: datos de inscripción en el Registro Mercantil (tomo, folio, hoja). Si es autónomo, no hace falta.
3. Si ejerce profesión colegiada (abogado, médico, arquitecto...): colegio profesional, número de colegiado y titulación. La LSSI obliga a indicarlo.
4. Dominio de la web.
5. Qué datos se recogen y para qué: formulario de contacto, newsletter, registro, compra, comentarios. Para cada uno, qué campos pide.
6. Herramientas de terceros que traten datos: hosting (proveedor y país), email marketing, analítica, pasarela de pago, chat, CRM.
7. Cookies que usa la web. Si el usuario no lo sabe, indícale que abra la web en una ventana de incógnito, pulse F12, pestaña Aplicación (o Almacenamiento) y copie los nombres de las cookies que ve. Si no puede, deja la lista [PENDIENTE DE COMPLETAR].
8. Si vende online: sí o no. Si vende, avisa de que además necesita condiciones de contratación y este comando no las hace.
9. Si hay menores de 14 años como público objetivo.

## Paso a paso

1. Con las respuestas, redacta `aviso-legal.md`. Contenido mínimo obligatorio por el artículo 10 de la LSSI: identificación del titular (nombre, NIF, dirección, email), datos registrales si procede, datos colegiales si procede, propiedad intelectual, exclusión de responsabilidad, ley aplicable y jurisdicción (España).
2. Redacta `politica-privacidad.md` con la estructura que exige el RGPD (artículos 13 y 14): responsable del tratamiento, finalidades separadas por cada formulario, base legal de cada una (consentimiento, ejecución de contrato, interés legítimo), plazo de conservación, destinatarios (los terceros del punto 6), transferencias internacionales si algún proveedor está fuera de la UE, derechos (acceso, rectificación, supresión, oposición, limitación, portabilidad), cómo ejercerlos y derecho a reclamar ante la AEPD.
3. Redacta `politica-cookies.md`: qué son, tabla con cada cookie (nombre, quién la pone, finalidad, duración, tipo: técnica, analítica, publicitaria), cómo cambiar el consentimiento y cómo borrarlas en los navegadores más usados. Si la lista de cookies está pendiente, deja la tabla con una fila de ejemplo y el marcador [PENDIENTE DE COMPLETAR].
4. En los tres documentos, cualquier dato que el usuario no haya dado va [ENTRE CORCHETES Y EN MAYÚSCULAS]. Nunca lo inventes.
5. Añade al final de cada documento la fecha de última actualización.
6. Genera un cuarto archivo, `pendiente-revision.md`, con la lista de todo lo que ha quedado entre corchetes y los puntos que conviene que revise un profesional: bases legales elegidas, transferencias internacionales, plazos de conservación.

## Qué devolver

Los cuatro archivos en la carpeta `legal/` del proyecto, en Markdown, con títulos H1 y H2 para que se puedan pegar en cualquier gestor de contenidos. Y un resumen en el chat de cinco líneas: qué se ha creado, qué falta por rellenar, y el aviso de que son borradores.

## Qué NO hacer

- No inventes NIF, direcciones, datos registrales ni nombres de cookies. Si falta, corchetes.
- No redactes condiciones de venta ni de contratación. Es otro documento y depende de la Ley de Consumidores; avisa y para.
- No copies textos de generadores o webs de terceros. Redacta desde los datos del usuario.
- No digas que los textos cumplen la ley. Di que son borradores adaptados a la normativa y que necesitan revisión.
- No pongas cláusulas de consentimiento marcadas por defecto ni frases del tipo "al usar esta web aceptas". El RGPD no permite el consentimiento tácito.
- No añadas una política de accesibilidad si el usuario no la ha pedido: no es obligatoria para toda web y no es este comando.
