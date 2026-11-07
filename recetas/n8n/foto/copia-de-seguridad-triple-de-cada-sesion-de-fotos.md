# Copia de seguridad triple de cada sesión de fotos…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Copia automáticamente las fotos que vuelcas de la tarjeta a una segunda nube, las apunta en una hoja de control y te avisa por Telegram si algo no ha llegado. Para fotógrafos.

## Qué es y qué hace

Vigila la carpeta de Google Drive donde vuelcas las tarjetas, replica cada archivo nuevo a Dropbox mediante su API y registra nombre, tamaño y hora en una hoja. Si algún archivo no llega, te avisa por Telegram. Se monta en n8n con las APIs de Drive, Sheets, Dropbox y Telegram, sin coste de licencia.

## Cómo usarla

1. Crea la app de Dropbox con permisos de lectura y escritura
2. Conecta Drive y Sheets
3. Crea el bot de Telegram
4. Prueba con una carpeta de prueba

## Cuándo usarla

Úsalo cuando disparas bodas, eventos o sesiones irrepetibles y hoy haces las copias de seguridad a mano (o no las haces).

## Cómo ganar dinero con ella

Perder una boda son 1.500-2.500 € de devolución y tu reputación. Además te quita 20-30 minutos de copias manuales por sesión.

- Puesta en marcha de copias automáticas para fotógrafos de bodas que hoy copian a mano.
- Servicio mensual de control de copias para estudios con varios fotógrafos y sesiones semanales.
- Plantilla de copia y registro vendida a fotógrafos que trabajan solos y no tienen sistema de backup.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila la carpeta de Google Drive donde vuelcas las tarjetas y replica cada archivo nuevo a Dropbox, dejando registro en una hoja con nombre, tamaño y hora.
Está pensado para el fotógrafo que trabaja solo y no tiene un sistema de copias formal: es el seguro de vida de tu material.

## Lo que necesitas antes
- n8n gratis: autoalojado con Docker (n8n Cloud solo tiene una prueba gratuita temporal y después es de pago) (`docker run -it -p 5678:5678 n8nio/n8n`).
- Cuenta de Google. En console.cloud.google.com creas un proyecto, activas Google Drive API y Google Sheets API, generas credenciales OAuth (tipo Aplicación web) y pones como URI de redirección la que te muestra n8n al crear la credencial.
- Cuenta de Dropbox. En dropbox.com/developers/apps: Create app, Scoped access, Full Dropbox, permisos files.content.write y files.content.read, y generas el token en la pestaña Settings; pégalo solo en una credencial «Dropbox» de n8n, nunca escrito en un nodo (un flujo exportado se llevaría la clave).
- Bot de Telegram: escribe a @BotFather, comando /newbot, te da el token, que va solo en una credencial «Telegram API» de n8n (nunca en un nodo ni en una URL). Para ver tu chat id, escribe algo a tu bot, pon un nodo **Telegram Trigger** temporal con esa credencial y lee `message.chat.id` en la ejecución de prueba (o escribe a @userinfobot).
- Una hoja de Google Sheets llamada Registro copias con columnas: Fecha, Sesion, Archivo, TamanoMB, DropboxOK.

## Los nodos, en orden
1) **Google Drive Trigger**. Resource: File. Event: File Created. Folder: 01_ENTRADA_TARJETAS. Poll Times: Every 5 Minutes.
2) **IF** (llámalo ¿Es foto?). Condición String > Contains: valor 1 `{{ $json.mimeType }}`, valor 2 `image`. Rama true sigue, rama false no se conecta a nada.
3) **Google Drive** (Download). Resource: File, Operation: Download. File ID: `{{ $json.id }}`. Esto mete el binario en la propiedad `data`.
4) **Dropbox**. Resource: File, Operation: Upload. Binary File: activado, Binary Property: `data`. Path: `/COPIAS/{{ $now.format('yyyy-MM') }}/{{ $('Google Drive Trigger').item.json.name }}`.
5) **Google Sheets**. Operation: Append Row. Documento: Registro copias. Columnas: Fecha `{{ $now.toISO() }}`, Sesion `{{ $('Google Drive Trigger').item.json.parents[0] }}`, Archivo `{{ $('Google Drive Trigger').item.json.name }}`, TamanoMB `{{ Math.round($('Google Drive Trigger').item.json.size / 1048576 * 10) / 10 }}`, DropboxOK `SI`.
6) **Telegram** (solo en la salida de error). Operation: Send Message. Chat ID: el tuyo. Text: `⚠️ Fallo copiando {{ $json.name }}. Revisa n8n.` Para conectarlo, en el nodo Dropbox abre Settings y activa Continue On Fail; añade detrás un IF que compruebe `{{ $json.error }}` y lleve al Telegram.

## Cómo probarla
Sube tres fotos de prueba a la carpeta de entrada y pulsa Test Workflow. Comprueba que aparecen en Dropbox con el mismo nombre y que la hoja tiene tres filas. Después activa el interruptor Active arriba a la derecha.
Prueba también el fallo: estropea a propósito la credencial de Dropbox en n8n (token inválido) y verifica que te llega el aviso de Telegram.

## Qué puede salir mal
- **Archivos enormes**: los RAW de 60 MB pueden agotar la memoria de n8n. En Settings del workflow sube el timeout y, si autoalojas, arranca con `NODE_OPTIONS=--max-old-space-size=2048`.
- **Duplicados**: si el trigger se dispara dos veces por el mismo archivo, Dropbox sobrescribe. Para evitar el susto, en Dropbox pon Mode: Add (renombra en vez de pisar).
- **Cuota de Drive**: la API limita a unas 1.000 peticiones cada 100 segundos. Si vuelcas 800 fotos de golpe, mete un nodo **Split In Batches** (Batch Size: 20) antes de la descarga y un **Wait** de 3 segundos al final del bucle.
- **Zona horaria**: en Settings del workflow pon Timezone: Europe/Madrid o las horas de la hoja saldrán con dos horas menos.

## Cuánto cuesta
n8n autoalojado: 0 €. n8n Cloud es de pago tras la prueba gratuita temporal. Google Drive incluye 15 GB gratis; a partir de ahí Google One 100 GB son 1,99 €/mes. Dropbox gratis son 2 GB, el plan Plus 2 TB unos 11,99 €/mes. Telegram es gratis siempre.
