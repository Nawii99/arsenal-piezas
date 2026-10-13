# Diplomas y certificados en PDF automáticos…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Cuando un alumno termina el curso, genera su diploma en PDF con su nombre, la fecha y un código de verificación, se lo envía por email y lo guarda en Drive.

## Qué es y qué hace

Cuando un alumno aparece como finalizado en la hoja, n8n duplica una plantilla de diploma en Google Slides, sustituye nombre, curso, horas y fecha, la exporta a PDF, la guarda en Drive y la envía por correo con un código de verificación. Entran filas de alumnos y salen PDF, correos y registro. Para academias, escuelas de idiomas y cursos internos que hoy los hacen a mano en Canva o Word.

## Cómo usarla

1. Crea la plantilla en Slides con los marcadores
2. Prepara la hoja de finalizados
3. Conecta Drive, Slides y Gmail en n8n
4. Prueba con un alumno de prueba

## Cuándo usarla

Úsalo cuando entregues certificados de asistencia o aprovechamiento y hoy los hagas uno a uno en Canva o Word, cambiando el nombre a mano.

## Cómo ganar dinero con ella

Cinco minutos por diploma que desaparecen.

- Montaje de diplomas automáticos para academias y escuelas de idiomas, con plantilla y prueba incluida.
- Emisión mensual de certificados para formadores que trabajan por convocatoria, cobrada por lote.
- Plantilla de diploma con código de verificación que se vende a departamentos de formación de empresas.

**Precio orientativo:** 200–400 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee la hoja de alumnos finalizados, duplica una plantilla de diploma en Google Slides, sustituye los huecos por los datos del alumno, la exporta a PDF, la guarda en Drive y la manda por email con un código único de verificación.
Para academias, formadores bonificados, escuelas de idiomas y cursos internos de empresa.

## Lo que necesitas antes
- Una plantilla de diploma en **Google Slides**, una sola diapositiva, con estos textos literales donde vayan los datos: `{{NOMBRE}}`, `{{CURSO}}`, `{{HORAS}}`, `{{FECHA}}`, `{{CODIGO}}`.
- Una hoja «Finalizados» con: nombre | email | curso | horas | fecha_fin | estado | codigo | pdf_url
- Una carpeta en Drive llamada «Diplomas».
- Credenciales de Google (Slides API, Drive API, Sheets API y Gmail API activadas en console.cloud.google.com).

## Los nodos, en orden
1) **Schedule Trigger**. Cron `0 8 * * *`, o **Google Sheets Trigger** si prefieres que salte al marcar «finalizado».
2) **Google Sheets** (Get Row(s)) sobre «Finalizados» con filtro columna `estado` igual a `finalizado`.
3) **IF**: `{{ $json.codigo }}` está vacío (operación String > Is Empty). Solo seguimos con los que aún no tienen diploma.
4) **Code** (Run Once for Each Item) para generar el código de verificación:
```js
const rnd = Math.random().toString(36).slice(2, 8).toUpperCase();
const anio = new Date().getFullYear();
$input.item.json.codigo = `CERT-${anio}-${rnd}`;
$input.item.json.fechaES = new Date($input.item.json.fecha_fin).toLocaleDateString('es-ES', { day:'numeric', month:'long', year:'numeric' });
return $input.item;
```
5) **Google Drive** (File > Copy). File: el ID de tu plantilla de Slides. Name: `Diploma - {{ $json.nombre }}`. Parent: carpeta «Diplomas».
6) **HTTP Request** (usa la credencial OAuth2 de Google que ya tienes, con scope presentations). Method: POST. URL: `https://slides.googleapis.com/v1/{{ $json.id }}:batchUpdate`. Body JSON:
```json
{"requests":[{"replaceAllText":{"containsText":{"text":"{{NOMBRE}}"},"replaceText":"{{ $('Code').item.json.nombre }}"}},{"replaceAllText":{"containsText":{"text":"{{CURSO}}"},"replaceText":"{{ $('Code').item.json.curso }}"}},{"replaceAllText":{"containsText":{"text":"{{HORAS}}"},"replaceText":"{{ $('Code').item.json.horas }}"}},{"replaceAllText":{"containsText":{"text":"{{FECHA}}"},"replaceText":"{{ $('Code').item.json.fechaES }}"}},{"replaceAllText":{"containsText":{"text":"{{CODIGO}}"},"replaceText":"{{ $('Code').item.json.codigo }}"}}]}
```
7) **HTTP Request** (Download). Method: GET. URL: `https://www.googleapis.com/drive/v3/files/{{ $('Google Drive').item.json.id }}/export?mimeType=application/pdf`. Response Format: File. Property Name: `data`.
8) **Google Drive** (File > Upload). Binary Property: `data`. Name: `{{ $('Code').item.json.codigo }}.pdf`. Parent: «Diplomas». Después un **Google Drive** (Share) con Permission «anyone», Role «reader» si quieres enlace público.
9) **Gmail** (Send). Para el alumno, con el PDF adjunto (activa «Attachments», Binary Property `data`). Texto: enhorabuena, código de verificación y una frase invitando a compartirlo en LinkedIn.
10) **Google Sheets** (Update Row) para guardar `codigo`, `pdf_url` y poner `estado` = `diploma_enviado`.
11) **Google Drive** (File > Delete) sobre la copia de Slides, para no llenar el Drive de borradores.

## Cómo probarla
- Marca una fila como `finalizado` con tu email.
- Ejecuta paso a paso y abre el PDF del nodo 7 desde el panel de datos: mira que no queden llaves `{{}}` sin sustituir.
- Comprueba que el email llega con el adjunto y que el código aparece en la hoja.

## Qué puede salir mal
- **Textos sin sustituir**: pasa cuando en Slides el marcador está partido por un salto de formato. Escribe `{{NOMBRE}}` de un tirón, sin cambiar de fuente a mitad.
- **Error 403 en Slides API**: no has activado Google Slides API en el proyecto de Google Cloud, o la credencial no tiene el scope. Vuelve a autorizar la credencial en n8n.
- **Acentos raros en el PDF**: usa una fuente estándar de Google Slides.
- **Duplicados**: el IF del paso 3 y el cambio de estado del paso 10 lo evitan.
- **Verificación**: si quieres que el código se pueda comprobar, publica la hoja «Finalizados» filtrada como página web y pon el enlace en el diploma.

## Cuánto cuesta
- Gratis: Slides, Drive, Sheets y Gmail entran en la cuenta de Google. n8n auto-alojado, gratis.
- Solo pagarías si necesitas más de 15 GB en Drive (2 € al mes por 100 GB) o si superas los 500 emails diarios.
