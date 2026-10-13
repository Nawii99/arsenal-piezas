# Zapier: del blog a una cola de posts para redes…

**Tipo:** Receta de automatización · **Área:** Contenido · **Licencia:** CC BY 4.0

Un Zap de Zapier que lee tu blog por RSS, prepara en Google Sheets un texto base para cada entrada nueva y te avisa por Gmail para que lo apruebes antes de publicar.

## Qué es y qué hace

Zap de Zapier que lee el feed RSS de tu blog, prepara en Google Sheets una fila por cada entrada nueva con un texto base para cada red y te avisa por Gmail para que lo apruebes. Entran las entradas nuevas del feed; salen filas con textos base y un correo. No publica en redes: tú decides cuándo y con qué texto.

## Cómo usarla

1. Crea la hoja Cola redes con sus columnas
2. Pon la dirección del feed RSS de tu blog
3. Prueba con una entrada reciente
4. Revisa y aprueba cada texto antes de publicar

## Cuándo usarla

Cuando publicas en tu blog o boletín y luego se te olvida compartirlo en redes, o lo haces con prisa y sin plan.

## Cómo ganar dinero con ella

Móntala a gestores de redes o pymes con blog: [TU PRECIO] de montaje y [TU PRECIO] al mes por mantener la cola y ayudar con la revisión.

- Cola de redes para un blog de negocio que publica pocas veces y quiere compartir todo lo nuevo.
- Mantenimiento mensual del flujo con revisión de textos base para Instagram y LinkedIn.
- Plantillas de resumen por red para un gestor de redes que lleva varios blogs de clientes.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

RECETA DE ZAPIER: del blog a una cola de posts para redes
QUÉ HACE
Cada vez que publicas una entrada nueva en tu blog, el Zap la detecta y prepara una fila en una hoja con un texto base.
Te manda un correo para que la revises. Tú decides si se publica, cuándo y con qué texto.
El Zap no publica nada en redes.
Normalmente solo recoge las entradas nuevas desde que lo activas, no las antiguas.
QUÉ NECESITAS
Una cuenta de Zapier.
Un blog con feed RSS. En WordPress suele ser tublog.com/feed.
Una cuenta de Google con Google Sheets y Gmail.
Una hoja llamada Cola redes con las columnas Fecha, Título, Enlace, Resumen, Texto base, Texto Instagram, Texto LinkedIn, Estado y Fecha publicación.
PASOS (un Trigger y varias Action, en este orden)
Paso 1 · Trigger · RSS by Zapier · New Item in Feed
- Feed URL: la dirección del feed de tu blog.
- Pulsa Test trigger. Verás una entrada reciente de ejemplo.
- Mira en Test qué campo trae el texto de la entrada (por ejemplo Content o Description) y cuáles traen el título y el enlace.
Paso 2 · Action · Formatter by Zapier · Text
- Transform: Remove HTML Tags.
- Input: el campo con el texto de la entrada del Paso 1.
- Puede quedar algún símbolo raro, como &amp;. Corrígelo a mano al revisar.
Paso 3 · Action · Formatter by Zapier · Text
- Transform: Truncate.
- Input: el resultado del Paso 2. Maximum Length: 200 caracteres.
- Truncate corta por caracteres y puede dejar una palabra a medias. Es un borrador: lo arreglas al revisar.
Paso 4 · Action · Google Sheets · Create Spreadsheet Row
- Drive, Spreadsheet y Worksheet: tu hoja Cola redes.
- Fecha, Título y Enlace: sus campos del Paso 1.
- Resumen: el resultado del Paso 3.
- Texto base: escribe Nuevo en el blog, el título, el resumen y el enlace, cada uno con su campo.
- Texto Instagram y Texto LinkedIn: déjalos vacíos. Los rellenas tú, o con ayuda de Claude, Codex, Gemini o una IA local. Revisas el resultado antes de usarlo.
- Estado: escribe Borrador. Fecha publicación: déjalo vacío.
Paso 5 · Action · Gmail · Send Email
- To: tu correo.
- Subject: Post de redes pendiente de revisar.
- Body: el título, el texto base y el enlace a la hoja. Pega la dirección de tu hoja Cola redes.
CÓMO PROBARLA
Haz Test en cada paso con UNA entrada reciente de tu blog.
Paso 2: comprueba que no quedan etiquetas raras de HTML.
Paso 3: mira dónde corta el resumen y anota si hay que retocarlo.
Paso 4: mira la hoja. Debe haber UNA fila nueva en Estado Borrador.
Paso 5: comprueba que el enlace del correo abre la hoja.
Cambia el Estado de la fila de prueba a Descartado antes de activar el Zap.
CUÁNTO CUESTA
Mira en la web de Zapier si hay plan gratuito para probar, cuántas tareas incluye tu plan y qué pasos cuentan como tarea.
Cada entrada nueva ejecuta varios pasos. Calcula cuántas publicas al mes y compáralo con el límite de tu plan.
QUÉ NO HACER
No conectes este Zap a feeds ajenos para copiar sus textos. Los contenidos de otras personas tienen derechos.
No publiques sin leer. Un texto automático puede salir cortado o sin tono.
No pongas en los textos nombres, fotos o testimonios de clientes sin su permiso.
No des permisos de publicación de tus redes a una herramienta que no necesitas para esto.
Si usas una IA para redactar los textos de redes, no le pases datos de clientes.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que el feed es de TU blog.
Que el texto base suena a ti y no promete resultados.
Que las imágenes que acompañes tienen licencia para usarlas.
Que los textos de una IA no inventan datos, cifras ni citas. Una persona los comprueba.
Si el blog tiene autores invitados, que tienes su permiso para compartir sus textos.
Más adelante puedes montar un segundo Zap que lea solo las filas en Estado Aprobado. Hazlo solo después de un mes revisando a mano y ten claro quién aprueba cada texto.
