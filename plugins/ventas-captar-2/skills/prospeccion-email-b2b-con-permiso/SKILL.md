---
name: prospeccion-email-b2b-con-permiso
description: Prepara una campaña de email a empresas que no te conocen (perfil de cliente, revisión de la lista, secuencia de 3 o 4 correos, respuestas modelo, bajas y comprobaciones de entrega) teniendo en cuenta las reglas españolas. Úsala antes del primer envío en frío.
---

# Prospección por email B2B con permiso y buena entrega

Esta skill prepara una campaña de emails a empresas: a quién escribir, qué decir, en qué orden, cómo responder y cómo evitar que tu dominio acabe en spam. Está pensada para herramientas de envío como Woodpecker, que programan secuencias y las paran cuando alguien contesta. Claude prepara el material. El envío lo lanzas tú desde la herramienta.

Cuando algo lo haces tú, pone «tú». Las órdenes sin sujeto son para Claude.

## Riesgo legal y de reputación, dicho claro

- En España, la LSSI (art. 21) prohíbe enviar publicidad por email que no se haya pedido o autorizado. Hay una excepción para clientes con relación previa y productos parecidos.
- Muchas empresas escriben a cargos de otras empresas apoyándose en el «interés legítimo» del RGPD. No es una zona clara, y menos si el destinatario es un autónomo (una persona física). Que un abogado o un gestor valide tu método antes del primer envío.
- La Agencia Española de Protección de Datos puede sancionar. Y antes de eso, tu dominio se quema: si muchos te marcan como spam, también tus correos normales empiezan a caer en la carpeta de spam.
- Google, Yahoo y Microsoft piden autenticación del dominio y baja sencilla a quien envía mucho. Cumplirlo desde el principio evita sorpresas.

## Antes de empezar, pregunta

No empieces sin respuesta a las preguntas 1 a 3.

1. ¿Qué vendes, a qué tipo de empresa (sector, tamaño, zona) y a qué cargo? ¿Qué problema concreto resuelves?
2. ¿Qué prueba real tienes? Un caso de cliente que te haya autorizado a citarlo, o un dato que se pueda comprobar. Si no hay, Claude no la inventa.
3. ¿De dónde salen los contactos? Web de la empresa, directorio profesional, tu base de clientes, una tarjeta recibida en un evento. Si la respuesta es «una lista comprada», se para aquí.
4. ¿Desde qué dominio y buzón vas a enviar? ¿Tiene SPF, DKIM y DMARC? Si no sabes qué es eso, pide a quien gestiona tu dominio que lo compruebe.
5. ¿Cuántos correos al día por buzón? Empieza bajo: [VOLUMEN DIARIO INICIAL].
6. ¿Qué quieres que haga quien lo lee? Lo mejor es una sola acción pequeña: contestar con un sí o un no, o aceptar una llamada corta.
7. ¿Quién contesta las respuestas y en cuánto tiempo?
8. ¿Qué datos de identificación llevan tus correos? Nombre, empresa, NIF y dirección. La ley pide que se sepa quién escribe.

## Paso a paso

1. Perfil de cliente en cinco líneas: sector, tamaño, cargo, señal de que tiene el problema y por qué ahora.
2. Revisión de la lista. Columnas mínimas: nombre, cargo, empresa, email, web, fuente y fecha en que conseguiste el dato. Se quitan duplicados, direcciones sin fuente, clientes actuales, personas que ya te dijeron que no y autónomos con email personal. Comprueba si te afecta alguna lista de exclusión publicitaria, como la Lista Robinson. Verifica las direcciones con una herramienta de verificación para reducir rebotes.
3. Aviso de origen. Cada primer correo dice quién eres, de dónde has sacado su dirección y cómo pedir que no le escribas más. El RGPD lo exige cuando los datos no vienen de la propia persona.
4. Secuencia de cuatro correos como máximo en dos semanas:
   - Correo 1 (día 0): quién eres, por qué escribes a esta persona (un dato real de su empresa), qué ofreces en una frase y una pregunta que se conteste con sí o no.
   - Correo 2 (día 3 o 4): algo útil, como un ejemplo o un dato. No repitas «te escribía por si viste mi correo».
   - Correo 3 (día 7 u 8): un caso breve, o una propuesta más pequeña.
   - Correo 4 (día 12 o 14): cierre amable. «No te escribo más, salvo que me digas».
5. Formato de cada correo: asunto corto, sin mayúsculas ni exclamaciones, texto casi sin formato, sin adjuntos, un enlace como mucho (ninguno en el primero) y lectura en menos de un minuto.
6. Personalización solo con datos que se pueden comprobar: su web, una noticia, una oferta de empleo. Si Claude no puede comprobar un dato, escribe [DATO A VERIFICAR] y no lo inventa.
7. Baja. Una línea al final: «Si no quieres más correos míos, responde BAJA y no te escribo más». Quien la pide se añade el mismo día a la lista de exclusión de la herramienta, para todas las campañas y para siempre.
8. Respuestas. Se clasifican en: interesado | más adelante | no soy yo, habla con otra persona | no | baja | ausencia automática | rebote. Claude prepara una respuesta modelo para cada una. Tú configuras la herramienta para que la secuencia pare en cuanto alguien responde.
9. Entrega. Antes del primer envío, comprueba SPF, DKIM y DMARC. Calienta el buzón con volumen bajo y creciente durante unas semanas. Para prospectar, usa un dominio secundario a tu nombre que redirija a tu web, y no el principal, que es el de tus correos con clientes. Nunca uno que imite el nombre de otra empresa.
10. Prueba. Tú mandas la secuencia a tres buzones tuyos (Gmail, Outlook y uno de empresa). Mira si caen en spam y cómo se ven en el móvil.
11. Lote piloto pequeño, por ejemplo 30 contactos. Espera una semana y mide rebotes, respuestas, bajas y quejas. Si los rebotes o las bajas salen altos para tu herramienta ([UMBRAL SEGÚN TU HERRAMIENTA]), para y revisa la lista antes de seguir.
12. Informe a los 14 días: qué funcionó, qué no y qué cambias.

## Qué devolver

1. Ficha del público objetivo.
2. Hoja de revisión de la lista: qué se descarta y por qué.
3. La secuencia completa: asunto y texto de cada correo, con las variables en el formato de tu herramienta ([FORMATO DE VARIABLES DE TU HERRAMIENTA]).
4. Respuestas modelo para cada tipo de contestación.
5. Lista técnica de entrega, con casillas: SPF, DKIM, DMARC, calentamiento y pruebas.
6. Plantilla de informe a los 14 días.

## Qué NO hacer

- No envíes ni programes envíos sin tu confirmación. Si hay conexión con la herramienta, solo lectura y borradores en pausa.
- No uses listas compradas ni direcciones sacadas con programas que rastrean webs o redes sociales.
- No automatices LinkedIn (invitaciones o mensajes con herramientas externas). LinkedIn lo prohíbe y puede cerrarte la cuenta.
- No pongas asuntos engañosos («Re:», «Factura pendiente») ni finjas una relación previa o una urgencia falsa.
- No inventes datos de la empresa, resultados, clientes ni testimonios.
- No ocultes quién eres: nada de remitentes falsos ni de nombres de otra persona.
- No uses el buzón principal del negocio para pruebas de envío masivo.
- No sigas escribiendo a quien ha dicho que no.
- No prometas resultados ni reuniones.
- No trates datos sensibles ni escribas a particulares.

## Qué revisa una persona antes del primer envío

- Un abogado o gestor: la base legal que usas para escribir a esas personas y el texto del aviso de privacidad que va en el primer correo.
- Tú: la lista final, fila por fila en una muestra grande, y los diez primeros correos leídos uno a uno.
- Si lo haces para un cliente: contrato de encargado del tratamiento (art. 28 del RGPD) y herramienta y dominio a nombre del cliente.
- Segunda opinión: pide a Claude Code que repase la secuencia como un revisor desconfiado (puede hacerlo con un subagente) y que liste dudas. No sustituye a la persona.
