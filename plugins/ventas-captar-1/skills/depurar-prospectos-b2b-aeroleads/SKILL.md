---
name: depurar-prospectos-b2b-aeroleads
description: Limpia, filtra y puntúa una lista de prospectos B2B exportada de Aeroleads y prepara borradores de primer mensaje para que los revises tú, dejando constancia del origen de cada dato. Úsala cuando tengas contactos profesionales sin ordenar y quieras decidir a quién escribir primero, con las reglas de protección de datos delante.
---
# Depurador de prospectos B2B para Aeroleads
Qué hace: coge el archivo de contactos que has sacado de Aeroleads (herramienta para buscar datos de contacto profesionales) y lo convierte en una lista corta, ordenada y limpia, con una razón escrita para cada prospecto y un borrador de primer mensaje.
Qué no hace: no envía nada, no contacta con nadie, no busca datos por su cuenta y no decide si puedes escribir a esas personas. Eso último lo decide una persona con conocimiento legal.
Aviso importante: los datos de una persona, aunque sean de su trabajo, son datos personales (RGPD). El correo comercial no solicitado está regulado en España (LSSI, art. 21) y las llamadas comerciales también tienen reglas (ley de telecomunicaciones). Antes de lanzar una campaña en frío, consulta a un abogado o a tu delegado de protección de datos.
## Pregunta esto antes de empezar
1. ¿Qué vendes y a quién? Sector, tamaño de empresa, cargo que decide, provincia o país.
2. ¿A quién hay que excluir? Clientes actuales, competidores y personas que ya pidieron no recibir mensajes. Pide esa lista de bajas: se respeta siempre.
3. ¿De dónde viene el archivo y cuándo lo exportaste? Si tienes un conector de Aeroleads instalado (MCP) puede leerlo de ahí; si no, pasa el CSV. Apunta fecha y fuente: sirven para responder si alguien te pregunta de dónde sacaste su dato.
4. ¿Para qué se usará? Email, llamada o contacto manual. Cada canal tiene reglas distintas.
5. ¿Qué base legal has decidido con tu asesor (por ejemplo interés legítimo, valorado y por escrito)? Si no hay ninguna decidida, para y dilo.
6. ¿Cuántos contactos como máximo en esta tanda? Propón empezar pequeño, por ejemplo 20.
## Paso a paso
1. Resume el perfil de cliente ideal en cinco líneas y espera confirmación.
2. Lee el archivo. Informa de cuántas filas hay, qué columnas trae y cuáles tienen huecos.
3. Limpia: quita duplicados (mismo email, o mismo nombre y empresa). Marca los emails de dominios gratuitos (gmail, hotmail...) como «personal, no usar en frío sin revisar». Marca los emails genéricos de empresa (info@, contacto@) como «genérico».
4. Excluye: cruza con la lista del punto 2 de las preguntas y con los países que no vas a cubrir. Anota cuántos quitas y por qué.
5. Puntúa de 0 a 3 el encaje con el cliente ideal y escribe en una frase por qué. Nada de puntuaciones sin razón.
6. Recomienda pasar los emails por una herramienta de verificación antes de usarlos: los rebotes dañan la reputación del dominio desde el que envías.
7. Para los de puntuación más alta, redacta un primer mensaje de cuatro o cinco líneas. Usa solo datos que estén en la ficha o que el usuario aporte de una fuente pública. Si dudas de un dato, escribe [COMPROBAR: dato]. El mensaje debe decir quién escribe, por qué le escribes a esa persona, de dónde has sacado su dato y cómo pedir que no se le escriba más.
8. Prepara la tabla final para pegar en tu CRM o en una hoja de cálculo.
## Qué devolver, en este orden
1. Resumen: filas de entrada, filas descartadas por cada motivo y filas que quedan.
2. Tabla con columnas: nombre, cargo, empresa, web, email, país, fuente, fecha de obtención, puntuación, motivo y estado (pendiente de revisión).
3. Borradores de mensaje solo para los de puntuación más alta, cada uno marcado «sin enviar».
4. Lista «para que decida una persona»: dudas legales, emails personales y datos sin comprobar.
## Qué NO hacer
- No envíes mensajes, correos ni invitaciones. Todo queda en borrador.
- No automatices LinkedIn: ni invitaciones, ni mensajes, ni recogida de perfiles. Va contra sus condiciones y puede costarte la cuenta.
- No adivines emails con patrones (nombre.apellido@empresa). Rebotan y son datos inventados.
- No uses datos de particulares ni de categorías sensibles (salud, ideología, religión...).
- No mezcles listas de clientes distintos ni guardes datos más tiempo del necesario.
- No inventes cargos, cifras de la empresa ni noticias. Lo que no conste va entre [CORCHETES].
- No prometas tasas de respuesta ni ventas.
- Coste: según tu plan, cada contacto exportado o verificado puede gastar créditos. Mira tu saldo antes de exportar listas grandes. Esta skill no lo controla.
## Qué revisa una persona antes de usar el resultado
- Un abogado o tu delegado de protección de datos: base legal, deber de informar a la persona en el primer contacto, cómo se atiende una baja o una petición de borrado, y si el canal elegido (email, llamada) está permitido.
- Tú: cada mensaje, uno a uno, antes de enviarlo desde tu cuenta.
## Probarla sin liarla
Pásale primero un archivo de 20 filas, mejor inventado o ya anonimizado. Comprueba que los descartes tienen sentido antes de darle la lista completa.
## Instalación (una sola vez)
Guarda este texto en un archivo llamado SKILL.md dentro de la carpeta .claude/skills/depurar-prospectos-b2b-aeroleads/ de tu proyecto, o en ~/.claude/skills/depurar-prospectos-b2b-aeroleads/ para tenerla en todos tus proyectos. Normalmente también puedes lanzarla escribiendo / y ese nombre.
