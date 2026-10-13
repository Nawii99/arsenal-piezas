# Automatización n8n: de CV escaneado a fila en Google Sheets…

**Tipo:** Receta de automatización · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Receta de n8n que vigila una carpeta de Google Drive, pasa cada CV nuevo por OCR, extrae los datos con una IA y los añade como fila en una hoja de Google Sheets.

## Qué es y qué hace

Receta de n8n que vigila una carpeta de Google Drive, pasa cada CV nuevo por OCR (Google Cloud Vision o Tesseract), extrae los datos con una API de IA y añade una fila a una hoja de Google Sheets. Entra el archivo escaneado; sale una fila con los datos del candidato. Ejemplo: un CV escaneado en Drive aparece en la hoja en dos minutos. Los costes de la API y del OCR no son gratuitos. Son datos personales: que lo revise un profesional.

## Cómo usarla

1. Crea la carpeta de CV entrantes en Drive
2. Configura el trigger, el OCR y el nodo de IA con esquema fijo
3. Añade la fila en Sheets
4. Que lo revise un profesional

## Cuándo usarla

Para quien recibe CVs por email o los va guardando en una carpeta de Drive y quiere tener automáticamente una hoja de cálculo con los candidatos, sin tocarlos uno a uno.

## Cómo ganar dinero con ella

n8n (self-hosted gratis, o plan cloud con límite de ejecuciones gratis), Google Drive, Google Sheets, OCR y una API de IA…

- Flujo de captura de CV para agencias de selección que reciben candidatos por email…
- Montaje de una hoja de candidatos automática para autónomos de RRHH…
- Mantenimiento mensual del flujo y revisión de errores de OCR para un cliente…

**Precio orientativo:** 150–350 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Cuentas necesarias antes de empezar:
- n8n: puedes usar la versión self-hosted (gratis, la instalas tú en un servidor o en tu ordenador) o el plan cloud gratuito de n8n, que tiene un límite de ejecuciones al mes, mira el límite vigente en su web antes de depender de esto para trabajo real.
- Cuenta de Google (Drive y Sheets), gratis.
- Un servicio de OCR: Google Cloud Vision tiene un nivel gratuito mensual limitado (revisa la cifra actual en su web, cambia con el tiempo), o puedes montar Tesseract OCR (gratis, open source) en un contenedor Docker si no quieres depender de una cuenta de pago.
- Una API de IA para estructurar el texto (OpenAI, Anthropic o similar): esto no es gratis, cobra por texto procesado, calcula el coste antes de dejarlo corriendo solo.

Nodos, en orden:
1. Disparador: nodo "Google Drive Trigger", evento "On file created", apuntando a la carpeta donde caen los CVs nuevos.
2. Nodo "Google Drive" (Download): descarga el archivo nuevo para poder procesarlo.
3. Nodo "IF": comprueba si el archivo es una imagen o un PDF escaneado (por tipo de archivo) o si ya es texto seleccionable, para decidir si hace falta OCR.
4. Rama con OCR: nodo "HTTP Request" contra la API de Google Cloud Vision (o contra tu Tesseract en Docker) para sacar el texto de la imagen.
5. Rama sin OCR: nodo "Extract from File" (opción PDF o DOCX) para sacar el texto directamente.
6. Nodo "Merge": junta las dos ramas en un único flujo con el texto del CV, venga de donde venga.
7. Nodo "OpenAI" (o "HTTP Request" a la API de tu IA preferida): le pasas el texto del CV con el jsonprompt de extracción de datos, pidiendo la respuesta en JSON con el esquema fijo (nombre, contacto, experiencia, formación, idiomas).
8. Nodo "Set" o "Code": aplana el JSON recibido a columnas simples (nombre, telefono, email, ciudad, ultimo_puesto, anios_experiencia) para que encajen en una hoja de cálculo.
9. Nodo "Google Sheets" (Append Row): añade una fila nueva con esos datos en tu hoja de candidatos.

Cómo probarla sin liarla:
- Antes de conectar el disparador automático, desactívalo y ejecuta el flujo a mano ("Execute workflow") con un único CV de prueba que no sea real, para ver que cada nodo saca lo que esperas.
- Revisa a mano la primera fila que se escriba en Sheets: compara con el CV original antes de dejar el flujo corriendo solo.
- Pon un límite bajo de ejecuciones o revisa el flujo cada pocos días al principio, así detectas errores de OCR o de la IA antes de que se acumulen cientos de filas mal extraídas.
- Recuerda que los CVs contienen datos personales: guarda la hoja de Sheets con acceso restringido, y borra los archivos originales de Drive cuando ya no los necesites, según tu política de conservación de datos.
