# Diplomas en PDF automáticos al terminar el curso…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Cuando un alumno completa el curso, se genera su diploma en PDF con su nombre, la fecha y un código de verificación, se guarda en Drive y se le envía por email.

## Qué es y qué hace

Flujo de n8n que detecta a los alumnos marcados como completados en una hoja, genera su diploma en PDF sustituyendo {{NOMBRE}}, {{CURSO}}, {{HORAS}}, {{FECHA}} y {{CODIGO}} en una plantilla de Google Slides. Guarda el PDF en Drive con un código de verificación y lo envía por email. Entra la hoja de alumnos y la plantilla; sale el diploma.

## Cómo usarla

1. Diseña la plantilla de una diapositiva con las llaves
2. Crea la carpeta de diplomas en Drive
3. Conecta Drive, Slides, Sheets y Gmail
4. Prueba con un alumno de prueba

## Cuándo usarla

Cuando emites certificados a mano en Canva o Word y tardas más en hacerlos que el alumno en pedirlos.

## Cómo ganar dinero con ella

Elimina 10-15 minutos por diploma y las erratas en los nombres. Con 60 diplomas al mes son 12 horas y una imagen mucho más seria.

- Emisión automática de certificados para academias que hoy los hacen a mano en Canva.
- Diplomas personalizados para empresas que organizan formación interna con certificado.
- Plantillas de certificación para escuelas de oficios y centros de formación profesional.

**Precio orientativo:** 200–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta a los alumnos marcados como «completado», genera su diploma personalizado en PDF a partir de una plantilla de Google Slides, lo guarda en una carpeta de Drive y se lo manda por correo con un código único de verificación.
Es para academias, formadores y empresas que dan formación bonificada o cursos con certificado.

## Lo que necesitas antes
n8n.
Hoja de Google «Alumnos» con columnas: nombre, apellidos, email, curso, horas, fecha_fin, estado, diploma_url, codigo.
Una plantilla en Google Slides de una sola diapositiva con el diseño del diploma. Dentro, escribe los textos que se sustituyen entre llaves dobles: {{NOMBRE}}, {{CURSO}}, {{HORAS}}, {{FECHA}}, {{CODIGO}}. Anota el ID de la presentación (está en la URL entre /d/ y /edit).
Una carpeta en Drive llamada «Diplomas emitidos» y su ID.
Credencial Google OAuth2 en n8n con permisos de Drive, Slides, Sheets y Gmail. Activa la API de Google Slides en tu proyecto de Google Cloud.

## Los nodos, en orden
**1. Schedule Trigger**. Cron: `0 9 * * *` (cada día a las 9:00).
**2. Google Sheets** «Buscar completados». Operación: «Get Row(s)», hoja «Alumnos», filtro: columna `estado` igual a `completado`.
**3. Filter**. Condición: `{{ $json.diploma_url }}` está vacío. Así no repites diplomas ya emitidos.
**4. Code** «Generar código». Crea un código de verificación único por alumno (código abajo).
**5. Google Drive** «Copiar plantilla». Operación: «Copy File». File ID: el ID de tu plantilla de Slides. Name: `Diploma - {{ $json.nombre }} {{ $json.apellidos }}`. Parent Folder: la carpeta «Diplomas emitidos».
**6. HTTP Request** «Rellenar plantilla». Method: POST. URL: `https://slides.googleapis.com/v1/presentations/{{ $json.id }}:batchUpdate`. Authentication: «Predefined Credential Type» > Google Slides OAuth2. Body (JSON): un array `requests` con un `replaceAllText` por cada marcador.
**7. HTTP Request** «Exportar a PDF». Method: GET. URL: `https://www.googleapis.com/drive/v3/files/{{ $('Copiar plantilla').item.json.id }}/export?mimeType=application/pdf`. Response Format: «File». Autenticación con la credencial de Google Drive.
**8. Google Drive** «Subir PDF». Operación: «Upload», Binary Property: `data`, nombre `Diploma-{{ $json.codigo }}.pdf`, carpeta «Diplomas emitidos». Después añade un nodo **Google Drive** «Share File» con permiso `reader` y tipo `anyone` para tener enlace público.
**9. Gmail** «Enviar diploma». To: `{{ $json.email }}`. Subject: `Tu diploma de {{ $json.curso }}`. Adjunta el binario `data` y añade en el cuerpo el código de verificación y una frase para que lo comparta en LinkedIn.
**10. Google Sheets** «Registrar». Update Row: `diploma_url` con el enlace del PDF, `codigo` con el código y `estado` = `diploma_enviado`.
**11. Google Drive** «Borrar copia de Slides». Operación: «Delete File» sobre la copia del paso 5, para no llenar Drive de presentaciones sueltas.

## El body del nodo 6
```json
{ "requests": [ { "replaceAllText": { "containsText": { "text": "{{NOMBRE}}", "matchCase": true }, "replaceText": "NOMBRE_ALUMNO" } }, { "replaceAllText": { "containsText": { "text": "{{CURSO}}", "matchCase": true }, "replaceText": "NOMBRE_CURSO" } } ] }
```
Sustituye NOMBRE_ALUMNO y NOMBRE_CURSO por las expresiones de n8n correspondientes, y repite el bloque para HORAS, FECHA y CODIGO.

## El trozo de código
Nodo **Code** número 4, modo «Run Once for Each Item»:
```javascript
const j = $input.item.json;
const semilla = (j.email + j.curso + j.fecha_fin).toLowerCase();
let hash = 0;
for (let i = 0; i < semilla.length; i++) { hash = (hash * 31 + semilla.charCodeAt(i)) % 99999999; }
const anio = new Date().getFullYear();
j.codigo = 'CERT-' + anio + '-' + String(hash).padStart(8, '0');
j.nombre_completo = (j.nombre + ' ' + j.apellidos).trim();
j.fecha_texto = new Date(j.fecha_fin).toLocaleDateString('es-ES', { day: 'numeric', month: 'long', year: 'numeric' });
return $input.item;
```

## Cómo probarla
Marca a un alumno de prueba (tú mismo) como `completado` y lanza el flujo a mano. Abre el PDF: comprueba tildes, la ñ y que no quede ningún {{MARCADOR}} sin sustituir.
Imprime uno en papel: los diplomas que se ven bien en pantalla a veces salen cortados.

## Qué puede salir mal
Si en el PDF aparecen las llaves sin sustituir, es que el texto de Slides está partido en varios trozos con formatos distintos: escribe el marcador de una tirada, sin negritas a medias.
Slides no sustituye texto dentro de imágenes: los marcadores tienen que ser cajas de texto.
La API de Slides falla si copias la plantilla y consultas demasiado rápido; añade un nodo **Wait** de 3 segundos entre el paso 5 y el 6.
Nombres con caracteres raros en el nombre de archivo: limpia con `.replace(/[\\/:*?"<>|]/g,'')`.
Para que el código de verificación sirva de algo, publica la hoja de códigos como página web de solo lectura o monta una página simple donde se pueda consultar.

## Cuánto cuesta
Todo el flujo es gratis: n8n auto-alojado, Google Slides, Drive, Sheets y Gmail entran en la cuenta gratuita.
Solo pagarías si superas los 15 GB de Drive o los 500 emails diarios de Gmail.
