---
name: campanas-email-brevo-revisadas
description: Prepara, revisa y analiza campañas de email en Brevo (lista, asunto, texto, comprobación legal e informe posterior). Úsala al lanzar una newsletter o promoción, o al mirar los resultados de una campaña. Nunca envía sin confirmación escrita de la persona.
---

# Campañas de email en Brevo, revisadas antes de enviar

## Qué hace
Prepara una campaña en Brevo, la pasa por una lista de comprobación y lee sus resultados. Trabaja siempre en borrador: redacta, revisa y propone. Enviar, programar o tocar contactos lo decide la persona con un «sí» escrito.
Dónde guardarla: en .claude/skills/campanas-email-brevo-revisadas/SKILL.md dentro de tu proyecto, o en ~/.claude/skills/ para usarla en todos. Si no sabes hacerlo, pídele a Claude que la guarde por ti.

## Cómo se conecta (elige una)
- Exportación, la opción más segura: descargar de Brevo los contactos y las estadísticas en CSV y dejarlos en la carpeta del proyecto. Claude solo lee.
- Conector MCP: si hay uno de Brevo instalado (escribe /mcp para ver los tuyos), usarlo primero solo en lectura.
- Pegado a mano: para campañas pequeñas basta con pegar el texto y las cifras.
- La clave de acceso (API key) nunca se pega en el chat: va en la configuración del conector.
- Antes de dar una lista, quitar las columnas que sobran (DNI, fecha de nacimiento, notas internas). Esos datos salen de tu herramienta hacia un tercero y quien responde de ellos debe saberlo.

## Pregunta antes de empezar
1. Objetivo: ¿qué debe hacer quien lea el email? Una sola acción.
2. Destinatarios: ¿qué lista o segmento? ¿De dónde salieron esos contactos y cuándo dieron permiso?
3. Remitente, idioma y tono. Si la campaña es de un cliente: ¿hay visto bueno suyo por escrito?
4. Fecha prevista y qué cuenta como éxito (clics, ventas, respuestas).
5. ¿Cómo accede Claude a los datos: exportación, conector o pegado?
6. ¿Es un sector sensible (salud, finanzas, menores)? Si lo es, avisa de que una persona debe revisarlo antes de enviar.

## Paso a paso
1. Revisa la lista y da las cifras antes de seguir: total de contactos, duplicados, direcciones mal escritas (sin @, con espacios), contactos sin origen ni fecha de permiso, bajas y rebotes. Di cuántas filas has leído de cuántas hay.
2. Para si hay dudas de permiso. En España, mandar publicidad por email exige consentimiento previo (LSSI, art. 21, y RGPD). Excepción: clientes tuyos, para productos parecidos a los que ya compraron y con baja fácil en cada envío. Una lista comprada o sacada de internet no vale.
3. Redacta 3 asuntos distintos, un texto de previsualización, el cuerpo y un único botón o enlace principal. Frases cortas. Nada que no se pueda cumplir.
4. Pasa la comprobación previa: remitente identificable, enlace de baja que funciona, datos del titular (nombre o razón social, NIF, dirección), enlaces que abren, campos de personalización bien rellenados, texto alternativo en las imágenes y aspecto en móvil.
5. Si hay conector con permiso de escritura, crea la campaña como borrador y di su nombre exacto. Si no, entrega el texto listo para pegar.
6. Envío de prueba: solo a la dirección de la persona y solo tras su confirmación.
7. Envío real: únicamente tras un mensaje del tipo «sí, envía a [LISTA] el [FECHA]». Si es la primera vez con esa lista, propón empezar por un segmento pequeño.
8. A las 48 horas del envío, analiza los resultados. Las aperturas salen infladas porque algunos programas de correo (como Apple Mail con protección de privacidad) abren los mensajes solos. Fíate más de clics, respuestas, bajas y ventas.

## Qué devolver
- Resumen de 5 líneas como máximo.
- Tabla de la lista: total, válidos, dudosos, bajas y rebotes.
- Textos: 3 asuntos, previsualización y cuerpo.
- Comprobación previa, cada punto marcado como OK, FALTA o REVISAR.
- Tras el envío: tabla con enviados, entregados, rebotes, bajas, quejas de spam y clics. Compara solo con campañas anteriores de la misma cuenta, nunca con medias de internet. Cierra con UNA cosa para probar la próxima vez.

## Qué NO hacer
- No envíes, programes ni reactives nada sin un «sí» escrito en ese mismo mensaje.
- No uses listas compradas, alquiladas o sacadas de webs.
- No vuelvas a meter en una lista a quien se dio de baja, aunque sea solo esta vez.
- No borres contactos, listas ni plantillas: propón y decide la persona.
- No cambies el plan, la facturación ni el dominio de envío.
- No inventes datos, opiniones de clientes ni resultados. No prometas tasas de apertura ni de venta.
- No pegues ni pidas la clave de acceso en el chat.
- El plan gratuito tiene un tope de envíos al día y puede añadir el logotipo de Brevo [comprueba los límites vigentes en su página de precios]. Si la lista los supera, dilo; no repartas el envío en varios días a escondidas.

## Qué revisa una persona antes de usar el resultado
- Que cada contacto tiene permiso válido. Claude no puede saberlo: solo ve la lista.
- El texto legal (identificación, baja, política de privacidad), sobre todo si hay sorteos, salud, finanzas o menores.
- Que precios, ofertas y fechas del email son correctos.
- Ante dudas de protección de datos, consulta a tu gestoría o a un delegado de protección de datos. La AEPD puede sancionar el envío de publicidad sin permiso.

Normas y límites revisados en octubre de 2026. Comprueba que siguen vigentes antes de contar con ellos.
