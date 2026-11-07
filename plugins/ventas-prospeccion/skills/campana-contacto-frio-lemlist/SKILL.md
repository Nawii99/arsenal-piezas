---
name: campana-contacto-frio-lemlist
description: Prepara una campaña de contacto en frío para Lemlist (email, pasos de LinkedIn hechos a mano y SMS solo con permiso) con público, textos, calendario y comprobaciones previas. Se activa cuando pides montar una secuencia de prospección o escribir a leads por varios canales.
---
# Campaña de contacto en frío con Lemlist
Lemlist envía secuencias de mensajes a prospectos. Esta skill prepara la campaña entera (a quién, qué decir y cuándo) y la deja en borrador. No la lanza. Eso lo haces tú en Lemlist, después de revisarla.
Para instalarla, guarda este archivo como .claude/skills/campana-contacto-frio-lemlist/SKILL.md dentro de tu proyecto.
## Riesgos que debes conocer antes de empezar
- Email. En España la LSSI (artículo 21) prohíbe en general enviar comunicaciones comerciales por email sin permiso previo del destinatario. Hay excepciones, por ejemplo clientes tuyos a los que ofreces productos parecidos. Que el destinatario sea una empresa no te exime, y el RGPD protege los nombres y los emails de personas. Confirma tu caso con un abogado o con tu gestor.
- LinkedIn. Sus condiciones prohíben automatizar acciones en tu cuenta con herramientas externas. Pueden limitarla o cerrarla, y es tu perfil profesional. Por eso esta skill deja los pasos de LinkedIn como tareas que haces tú a mano, de una en una.
- SMS y WhatsApp. Solo a quien te lo haya permitido por escrito para ese canal (o sea cliente tuyo, si tu gestor o tu abogado confirma que puedes). A un contacto en frío, no.
- Reputación del dominio. Si muchos correos rebotan o se marcan como spam, tus emails normales (facturas, clientes) pueden dejar de llegar. Valora enviar desde un dominio secundario y empieza con pocos envíos al día.
## Cómo se conecta
- Es la vía con menos riesgo: la IA (Claude, Codex, Gemini o una IA local) te da los textos y un CSV (un archivo de hoja de cálculo sencillo), y los subes tú a Lemlist.
- Con la clave de la API de Lemlist (un código de acceso de tu cuenta) o un conector MCP (un enlace que deja a la IA usar tu cuenta), la IA podría crear la campaña. Úsalo solo para dejarla en borrador o pausada. La clave va en la configuración, nunca en el chat.
## Qué preguntar antes de empezar
- ¿A quién escribes? Sector, cargo, tamaño de empresa y zona, en una frase.
- ¿Qué ofreces, qué problema concreto resuelves y qué quieres que pase (una respuesta, una llamada corta, una demo)?
- ¿De dónde salen los contactos? Si son comprados o de origen dudoso, para y avisa.
- ¿Con qué base legal les escribes y quién la ha validado? Si no hay ninguna, no sigues (mira el paso 1).
- ¿Tienes permiso por escrito para enviar SMS a cada contacto? Si no, la secuencia no lleva SMS.
- ¿Desde qué dominio y buzón envías? ¿Están hechas las tres comprobaciones técnicas del correo (SPF, DKIM y DMARC)? Si no sabes qué son, pregunta a quien gestiona tu dominio.
- ¿Cuántos emails al día aguanta ese buzón? [CONSULTA EL LÍMITE EN LA AYUDA DE LEMLIST]
- Idioma, tono y datos de tu empresa para el pie del mensaje (nombre o razón social y cómo darse de baja).
## Paso a paso
1. Antes de nada, comprueba la base legal. Este paso es una parada obligatoria: si no se cumple, el resto no se hace.
   - PARADA OBLIGATORIA. Si no hay permiso previo ni una excepción confirmada por un gestor o abogado, no sigas con los textos ni con la lista. No redactes la secuencia, no personalices nada y no prepares el CSV. Ofrece solo alternativas sin envío masivo: un formulario de contacto, publicidad o una llamada a quien lo pidió.
   - Si no tienes claro si hay permiso o excepción, trátalo como si no lo hubiera. Para y pregunta a tu gestor o abogado antes de seguir.
   - Si la hay, revisa la lista. Quita duplicados, emails sin verificar y personas que estén en tu lista de bajas. Los emails adivinados rebotan, así que verifícalos antes con una herramienta de verificación. Di cuántos contactos quedan.
2. Divide la lista en dos o tres grupos por cargo o sector. Cada grupo lleva su propio enfoque.
3. Para cada grupo define el motivo por el que escribes ahora, basado en algo comprobable (su web, una oferta de empleo, un producto nuevo). Sin motivo no hay mensaje.
4. Diseña una secuencia corta de 3 o 4 contactos en 2 o 3 semanas, más un SMS opcional.
   - Día 1, email breve con una idea y una pregunta, sin adjuntos.
   - Día 3 a 5, paso en LinkedIn a mano (mirar el perfil o enviar una solicitud con nota corta).
   - Día 7 a 9, email que aporta algo nuevo (un dato, un ejemplo real tuyo), no un «¿viste mi correo?».
   - Día 10 a 12, SMS OPCIONAL, solo para contactos con permiso por escrito para SMS. Texto corto que dice quién eres y cómo darse de baja. Si no hay permiso, se salta este paso.
   - Día 14, email de cierre amable que ofrece dejar de escribir.
   - La secuencia se para cuando la persona responde, se da de baja o el email rebota.
5. Personaliza con una columna por cada dato y otra columna «fuente» con el enlace de donde sale. Sin fuente, esa línea no se usa. Nada de halagos genéricos.
6. Cada email dice quién eres, de qué empresa, por qué escribes a esa persona y cómo darse de baja con una frase clara.
7. Prepara la prueba. Envía la secuencia a dos buzones tuyos de proveedores distintos (por ejemplo Gmail y Outlook) y comprueba si llega a bandeja o a spam, si los enlaces funcionan y si la baja funciona.
8. Entrega la campaña en borrador. Empieza con un grupo pequeño de prueba [TAMAÑO QUE DECIDAS] y no con toda la lista.
9. Cuando lleguen respuestas, clasifícalas en interesado, ahora no, no es mi área, baja, fuera de la oficina y rebote. Redacta borradores de respuesta. Las bajas se anotan el mismo día en tu lista de «no contactar» y se quitan de todas las campañas.
## Qué devolver
1. Resumen con público, oferta, objetivo, contactos útiles tras limpiar y canales usados.
2. Tabla de la secuencia con paso, día, canal, asunto, texto y condición de parada.
3. Columnas del CSV a importar, con el nombre de cada columna y para qué sirve.
4. Lista de comprobación previa al lanzamiento, con casillas.
5. Riesgos pendientes y lo que debe revisar una persona.
Si el paso 1 se detiene, devuelve solo esto: el motivo de la parada, las alternativas sin envío masivo y qué debe confirmar tu gestor o abogado.
## Qué NO hacer
- No lances, programes ni actives la campaña.
- No sigas con la lista ni con los textos si no hay base legal confirmada.
- No compres ni uses listas de origen dudoso.
- No uses herramientas que entren en tu LinkedIn para enviar invitaciones o mensajes en masa.
- No envíes SMS ni WhatsApp a quien no te lo haya permitido por escrito.
- No inventes datos de la persona o de su empresa ni finjas una conversación previa (nada de «Re:» ni de «como hablamos»).
- No ocultes quién eres ni uses asuntos engañosos.
- No prometas resultados ni cites porcentajes de respuesta que no sean tuyos.
- No subas el volumen de golpe ni envíes desde tu buzón principal.
- No sigas escribiendo a quien pidió parar.
## Qué revisa una persona
- La base legal y el origen de la lista, con tu gestor o un abogado, antes del primer envío. Sin base legal, la campaña no sigue.
- Los permisos por escrito para SMS, si los hay.
- Todos los textos y las 10 primeras líneas personalizadas.
- El resultado de la prueba de spam.
- Los rebotes y las quejas después de cada envío.
- Si la campaña es para un cliente, el contrato de encargado de tratamiento (RGPD) y el origen de la lista por escrito.
