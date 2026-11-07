# Fábrica de certificados con número correlativo y verifi…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Cuando un alumno termina, genera su certificado en PDF con un código único, lo guarda, lo envía y lo apunta en un registro público donde cualquiera puede comprobar que es real.

## Qué es y qué hace

Al marcar un alumno como finalizado, n8n coge una plantilla de Google Slides, rellena nombre, curso, horas y fecha, exporta un PDF, lo guarda en Drive, lo envía por correo y añade una fila al registro con un código tipo CERT-2026-0147. Entran filas de finalizados y salen PDF, correos y un registro consultable. Para academias y escuelas que quieren que sus certificados puedan comprobarse, con n8n.

## Cómo usarla

1. Prepara la plantilla con los marcadores
2. Crea la hoja de registro con códigos correlativos
3. Conecta Slides, Drive y Gmail en n8n
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando emitas diplomas a mano en Canva o Word y ya no sepas ni a quién se lo mandaste, o cuando una empresa te pida verificar el certificado de un empleado.

## Cómo ganar dinero con ella

Ahorra 10-15 minutos por diploma y te quita del medio el problema de los certificados falsificados o duplicados.

- Implantación de certificados numerados y verificables para academias, con registro consultable.
- Emisión mensual de certificados y mantenimiento del registro para formadores, cobrada por lote.
- Plantilla de certificado con código vendida a escuelas que quieren evitar certificados falsificados.

**Precio orientativo:** 200–450 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Al marcar un alumno como finalizado en tu hoja, coge una plantilla de Google Slides, sustituye nombre, curso, horas y fecha, exporta el resultado a PDF, lo guarda en Drive, lo envía por email y añade una fila al registro con un código de verificación tipo `CERT-2026-0147`. Cualquiera puede escribirte ese código y comprobarlo, o consultarlo en una hoja publicada.

## Lo que necesitas antes
- n8n instalado.
- Plantilla de certificado hecha en **Google Slides**, una sola diapositiva, con los textos literales `{{NOMBRE}}`, `{{CURSO}}`, `{{HORAS}}`, `{{FECHA}}`, `{{CODIGO}}` puestos como cajas de texto.
- Credenciales de Google Drive y Google Slides OAuth2 en n8n (activa Drive API, Slides API y Sheets API en Google Cloud Console).
- Hoja `Finalizados` con columnas: `nombre`, `email`, `curso`, `horas`, `fecha_fin`, `emitido`, `codigo`, `url_pdf`.
- Hoja `Registro` con columnas: `codigo`, `nombre`, `curso`, `fecha`. No la publiques: lleva datos personales. Para verificar un certificado no hace falta publicar nada: quien quiera comprobarlo te manda el código y le confirmas curso y fecha. Si prefieres una consulta pública, publica otra hoja solo con el código, el curso y la fecha, sin nombres.

## Los nodos, en orden
1. **Schedule Trigger** — `0 9 * * *`, timezone `Europe/Madrid`.
2. **Google Sheets** (`Get Row(s)`) — hoja `Finalizados`.
3. **Filter** — `{{ $json.emitido }}` *is empty*.
4. **Split In Batches** — Batch Size 1. Los certificados se generan de uno en uno o Drive se lía con los nombres.
5. **Google Sheets** (`Get Row(s)`) sobre `Registro` — solo para contar filas y calcular el siguiente correlativo.
6. **Code** — genera el código correlativo y la fecha en español. Código abajo.
7. **Google Drive** (operación `Copy File`) — File ID de tu plantilla de Slides, nombre de la copia `Certificado {{ $json.nombre }} {{ $json.codigo }}`, carpeta destino `Certificados`.
8. **HTTP Request** — método `POST`, URL `https://slides.googleapis.com/v1/presentations/{{ $json.id }}:batchUpdate`, autenticación `Predefined Credential Type` > `Google Slides OAuth2`. Body JSON con las cinco sustituciones (abajo).
9. **HTTP Request** (segundo) — método `GET`, URL `https://www.googleapis.com/drive/v3/files/{{ $('Google Drive').item.json.id }}/export?mimeType=application/pdf`, misma credencial de Google, Response Format `File`.
10. **Google Drive** (`Upload`) — sube el binario a la carpeta `Certificados PDF` con nombre `{{ $json.codigo }}.pdf`. Guarda el `webViewLink`.
11. **Google Sheets** (`Append Row`) sobre `Registro` y **Google Sheets** (`Update Row`) sobre `Finalizados` marcando `emitido` en `si`. Va antes del correo: así el número queda reservado aunque el envío falle y un segundo intento no repite el código. Ejecuta el flujo de uno en uno.
12. **Gmail** (`Send`) — al alumno, con el PDF adjunto y el código de verificación en el cuerpo.

## El código del nodo Code
```javascript
const registro = $('Google Sheets1').all();
const anio = new Date().getFullYear();
const delAnio = registro.filter(r => String(r.json.codigo || '').includes(`CERT-${anio}-`)).length;
const num = String(delAnio + 1).padStart(4, '0');
const meses = ['enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiembre','octubre','noviembre','diciembre'];
const d = new Date();
const fecha = `${d.getDate()} de ${meses[d.getMonth()]} de ${anio}`;
const a = $json;
return [{ json: { ...a, codigo: `CERT-${anio}-${num}`, fecha_texto: fecha } }];
```

## El body del batchUpdate de Slides
```json
{"requests":[
{"replaceAllText":{"containsText":{"text":"{{NOMBRE}}"},"replaceText":"={{ $json.nombre }}"}},
{"replaceAllText":{"containsText":{"text":"{{CURSO}}"},"replaceText":"={{ $json.curso }}"}},
{"replaceAllText":{"containsText":{"text":"{{HORAS}}"},"replaceText":"={{ $json.horas }}"}},
{"replaceAllText":{"containsText":{"text":"{{FECHA}}"},"replaceText":"={{ $json.fecha_texto }}"}},
{"replaceAllText":{"containsText":{"text":"{{CODIGO}}"},"replaceText":"={{ $json.codigo }}"}}]}
```

## Cómo probarla
- Mete una fila de prueba con tu nombre y tu email, con `emitido` vacío.
- Ejecuta a mano y abre el PDF: mira que no quede ningún `{{...}}` sin sustituir y que el acento del nombre salga bien.
- Comprueba que la fila aparece en `Registro` y que el correlativo avanza al segundo intento.

## Qué puede salir mal
- **Correlativos duplicados** si ejecutas dos veces a la vez. Con Split In Batches a 1 y una sola ejecución diaria no pasa; si emites muchos, guarda el contador en una celda fija y súmale 1 con `Update Row`.
- **Textos que no se sustituyen**: Slides parte la caja de texto si escribiste el marcador con formatos mezclados. Escribe los `{{NOMBRE}}` de una tirada, sin cambiar de negrita a mitad.
- **PDF vacío**: te has saltado el Response Format `File` en el export.
- **Nombres con tildes en el archivo**: Drive los admite, pero si luego los sirves por URL usa solo el código en el nombre.

## Cuánto cuesta
- Todo el flujo es gratis: Slides, Drive, Sheets y Gmail entran en la cuenta personal de Google (15 GB).
- Solo pagas n8n si eliges Cloud. Auto-alojado, 0 euros.
