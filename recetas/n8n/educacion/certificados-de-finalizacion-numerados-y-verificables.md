# Certificados de finalización numerados y verificables…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Genera el diploma en PDF con el nombre, las horas y un código único, lo manda al alumno y publica una página de verificación para que las empresas puedan comprobar que es real.

## Qué es y qué hace

Cuando marcas un alumno como Apto en la hoja de notas, duplica una plantilla de Google Slides, sustituye los campos NOMBRE, CURSO, HORAS, FECHA y CODIGO, exporta el PDF y lo envía por Gmail. Registra un código único en una página de verificación para que cualquiera compruebe que el certificado existe y a nombre de quién está emitido.

## Cómo usarla

1. Prepara la plantilla con marcadores
2. Crea la hoja Notas y conecta Drive, Slides, Sheets y Gmail
3. Publica la página de verificación
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando emites diplomas a mano en Canva o Word, tardas días en enviarlos y no tienes forma de demostrar que uno es auténtico.

## Cómo ganar dinero con ella

Quince minutos por diploma entre maquetar, exportar y enviar. Con 30 alumnos al mes son 7 horas. Y el código verificable es un argumento de venta.

- Montaje de certificados verificables para academias y escuelas de formación, con plantilla de marca incluida.
- Emisión mensual de diplomas para cursos online, con envío automático y registro de códigos.
- Página de verificación de diplomas para una formadora pequeña que emite cientos de certificados al año.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cuando marcas un alumno como `Apto` en la hoja de notas, el flujo duplica una plantilla de Google Slides, sustituye los campos, la exporta a PDF, la manda por email y registra el código de verificación. Cualquiera puede meter ese código en una URL y ver si el certificado existe, a nombre de quién y de qué curso.

## Lo que necesitas antes
- Una plantilla de diploma en Google Slides (una sola diapositiva, tamaño A4 horizontal) con los textos literales `{{NOMBRE}}`, `{{CURSO}}`, `{{HORAS}}`, `{{FECHA}}`, `{{CODIGO}}`.
- Hoja `Notas` con: `nombre`, `dni_parcial`, `email`, `curso`, `horas`, `fecha_fin`, `resultado`, `certificado_url`, `codigo`.
- Credenciales de Google Drive, Slides, Sheets y Gmail en n8n.
- n8n accesible desde fuera para la página de verificación.

## Los nodos, en orden
**Flujo A: emitir**
1) **Google Sheets Trigger** — Event: On Row Updated, Sheet `Notas`, Poll Every Minute.
2) **IF** — `{{ $json.resultado }}` equals `Apto` AND `{{ $json.codigo }}` is empty. Así solo emite una vez.
3) **Code** — genera el código único y la fecha en formato español. Código abajo.
4) **Google Drive** (Operation: Copy File) — File la plantilla de Slides, Name `Diploma {{ $json.nombre }} {{ $json.codigo }}`, Folder `Diplomas emitidos`.
5) **HTTP Request** — Method POST, URL `https://slides.googleapis.com/v1/presentations/{{ $json.id }}:batchUpdate`, Authentication: Predefined Credential Type > Google Slides OAuth2. Body JSON con las sustituciones: `{"requests":[{"replaceAllText":{"containsText":{"text":"{{NOMBRE}}"},"replaceText":"..."}}, ...]}` — una entrada por cada campo.
6) **Google Drive** (Operation: Download File) — File el id de la copia, Options > Google File Conversion: convertir a PDF.
7) **Google Drive** (Operation: Share) — Role Reader, Type Anyone with the link, para poder enlazarlo.
8) **Gmail** (Send Message) — To el alumno, Subject `Tu certificado de {{ $json.curso }}`, con el PDF adjunto (Attachments: Binary Property `data`) y el código de verificación en el cuerpo.
9) **Google Sheets** (Update Row) — guarda `codigo`, `certificado_url` y la fecha de emisión.
**Flujo B: verificar**
10) **Webhook** — Method GET, Path `verificar`, parámetro `codigo`.
11) **Google Sheets** (Get Rows) — hoja `Notas`, Filter: `codigo` igual a `{{ $json.query.codigo }}`.
12) **IF** — `{{ $json.nombre }}` is not empty.
13) **Respond to Webhook** — Respond With: Text, Content-Type `text/html`, con una página simple: nombre (con el apellido abreviado), curso, horas, fecha y un «Certificado válido». En la rama false, «Código no encontrado».

## El código del nodo 3
```js
const crypto = require('crypto');
const base = `${$json.email}|${$json.curso}|${$json.fecha_fin}`;
const hash = crypto.createHash('sha256').update(base).digest('hex').toUpperCase();
const anio = new Date().getFullYear();
const codigo = `${anio}-${hash.slice(0, 4)}-${hash.slice(4, 8)}`;
const f = new Date($json.fecha_fin || Date.now());
const meses = ['enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiembre','octubre','noviembre','diciembre'];
const fecha_es = `${f.getDate()} de ${meses[f.getMonth()]} de ${f.getFullYear()}`;
return { json: { ...$json, codigo, fecha_es } };
```

## Cómo probarla
- Emítete un diploma a ti mismo. Mira el PDF: si los `{{CAMPOS}}` siguen ahí, es que el texto de la plantilla está partido en varios trozos dentro del cuadro. Bórralo y reescríbelo de una tirada.
- Prueba la URL de verificación con un código válido y con uno inventado.
- Cambia un alumno de `Apto` a `Apto` otra vez: no debe emitir un segundo diploma, gracias a la condición del código vacío.

## Qué puede salir mal
- **Doble emisión**: es el fallo clásico del trigger On Row Updated. La condición `codigo is empty` lo corta.
- **Nombres largos que se salen**: en la plantilla, ajusta el cuadro de texto con autoajuste de tamaño.
- **Datos personales en la página pública**: publica solo nombre y primera letra del apellido, nunca DNI ni email.
- **Cuota de Drive**: cada diploma ocupa poco, pero si emites miles, limpia la carpeta al año.

## Cuánto cuesta
- Slides, Drive, Sheets y Gmail: gratis dentro de tu cuenta de Google.
- n8n auto-alojado con dominio: 5 a 8 €/mes por el VPS.
- Frente a plataformas de certificados verificables, que empiezan en 30 o 50 €/mes.
