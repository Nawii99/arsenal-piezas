# Simulacro mensual de restauración de tu copia de seguri…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Comprueba cada mes que la copia de seguridad existe, es reciente, pesa lo que debe y se puede abrir de verdad, y te obliga a hacer la prueba real cada trimestre.

## Qué es y qué hace

Flujo de n8n que cada mes comprueba en Google Drive que la copia de seguridad existe, es de esta semana, tiene un tamaño coherente y es un archivo válido. Además programa la prueba manual de restauración que hay que hacer cada trimestre. Entra la carpeta de copias y la hoja de historial; sale un informe con el estado de cada copia y un recordatorio.

## Cómo usarla

1. Sube las copias a una carpeta de Drive con nombre fijo
2. Crea la hoja Copias con tamaños mínimos
3. Programa el control mensual
4. Haz a mano la restauración real cada trimestre

## Cuándo usarla

Úsalo cuando tengas copias automáticas de tu web o tus datos y nunca hayas comprobado si sirven de algo, que es el caso del 90% de los negocios pequeños.

## Cómo ganar dinero con ella

Una copia que no restaura equivale a no tener copia: rehacer una web o un año de facturación cuesta miles de euros y semanas de trabajo.

- Verificación mensual de copias para tiendas online y webs de clientes sin técnico propio.
- Servicio trimestral de simulacro de restauración para despachos y gestorías.
- Configuración de backups automáticos en Drive con control de integridad para pymes.

**Precio orientativo:** 200–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**: verifica automáticamente lo verificable (que el archivo esté, sea de esta semana, no haya encogido de golpe y sea un archivo válido y no un error de texto disfrazado) y te programa el simulacro manual que sí hay que hacer con las manos. Para cualquiera que guarde copias en Drive, Dropbox o un FTP.
**Para quién no es**: si tus datos viven solo en SaaS con historial propio y firmado (aun así, exporta una vez al trimestre).

### Lo que necesitas antes
- **Que tus copias lleguen a una carpeta de Google Drive** con nombre predecible, por ejemplo `backup-tienda-2026-09-08.zip`. Casi todos los plugins de backup (UpdraftPlus, Duplicator, All-in-One WP Migration) y los paneles de hosting saben subir a Drive.
- **n8n** con credenciales de **Google Drive**, **Google Sheets** y **Gmail**.
- **Hoja «Copias»** con pestaña `historial`: `fecha`, `archivo`, `tamano_mb`, `antiguedad_horas`, `veredicto`, `nota`.
- **Un sitio donde restaurar de verdad**: un subdominio `pruebas.tudominio.com` o un WordPress local con LocalWP (gratis). Esto es para el simulacro trimestral.

### Los nodos, en orden
**1. Schedule Trigger** — Weeks, lunes a las 6:30. Timezone `Europe/Madrid`.
**2. Google Drive** («Buscar copia») — Resource: File/Folder, Operation: `Search`. Search Method: Advanced, Query String: `'ID_DE_TU_CARPETA' in parents and trashed = false`. En Options activa Fields y pide `id, name, size, createdTime, mimeType`. Sort: por fecha descendente si tu versión lo permite; si no, ordénalo en el Code.
**3. Code** («Evaluar copia»):
```js
const archivos = $input.all().map(i => i.json).filter(f => /\.(zip|sql|gz|tar|bak)$/i.test(f.name));
archivos.sort((a, b) => new Date(b.createdTime) - new Date(a.createdTime));
if (!archivos.length) return [{ json: { veredicto: 'FALLO', nota: 'No hay ninguna copia en la carpeta', archivo: '-', tamanoMb: 0, horas: 9999 } }];
const ult = archivos[0];
const tamanoMb = Math.round((Number(ult.size) || 0) / 1048576 * 10) / 10;
const horas = Math.round((Date.now() - new Date(ult.createdTime).getTime()) / 3600000);
const anteriores = archivos.slice(1, 4).map(f => (Number(f.size) || 0) / 1048576);
const media = anteriores.length ? anteriores.reduce((a, b) => a + b, 0) / anteriores.length : tamanoMb;
const notas = [];
if (horas > 30) notas.push('La ultima copia tiene ' + horas + ' horas, el backup diario no se esta ejecutando');
if (tamanoMb < 1) notas.push('La copia pesa ' + tamanoMb + ' MB, casi seguro esta vacia o es un error');
if (media && tamanoMb < media * 0.6) notas.push('La copia ha encogido un ' + Math.round((1 - tamanoMb / media) * 100) + '% respecto a la media, sospechoso');
if (archivos.length < 3) notas.push('Solo hay ' + archivos.length + ' copias guardadas, deberias conservar al menos 7');
return [{ json: { veredicto: notas.length ? 'FALLO' : 'OK', nota: notas.join(' | ') || 'Todo correcto', archivo: ult.name, id: ult.id, tamanoMb, horas } }];
```
**4. Google Drive** («Bajar cabecera») — Operation: `Download`, File ID `{{ $json.id }}`. Para no descargar 2 GB, en el nodo **HTTP Request** alternativo puedes usar la API con la cabecera `Range: bytes=0-1023`: URL `https://www.googleapis.com/drive/v3/files/{{ $json.id }}?alt=media`, autenticación con tu credencial de Google Drive OAuth2 (Predefined Credential Type), Headers: `Range` = `bytes=0-1023`, Response Format `File`.
**5. Code** («¿Es un archivo de verdad?») — comprueba la firma de los primeros bytes:
```js
const bin = $input.first().binary.data;
const b64 = bin.data.slice(0, 16);
const cabecera = Buffer.from(b64, 'base64').toString('hex').toUpperCase();
const esZip = cabecera.startsWith('504B0304');
const esGz = cabecera.startsWith('1F8B');
const esSql = Buffer.from(b64, 'base64').toString('utf8').toLowerCase().includes('sql') || Buffer.from(b64, 'base64').toString('utf8').includes('--');
return [{ json: { integridad: (esZip || esGz || esSql) ? 'OK' : 'FALLO: el archivo no parece un zip, gz ni sql; puede ser una pagina de error guardada con extension de copia' } }];
```
**6. Google Sheets** — Append Row en `historial` con todo.
**7. IF** — si el veredicto o la integridad contienen «FALLO», sigue.
**8. Gmail** — Subject: `🚨 Problema con tus copias de seguridad`. Mensaje con la nota concreta y qué hacer: revisar el plugin, revisar el espacio en Drive, revisar credenciales caducadas.
**9. Segundo Schedule Trigger** (otro workflow o el mismo con dos entradas) — Months, cada 3 meses, día 1. Manda un **Gmail** con el guion del simulacro real: 1) descarga la última copia, 2) créate un WordPress vacío en LocalWP o en `pruebas.tudominio.com`, 3) restáurala, 4) comprueba que entras al panel, que hay productos y que los pedidos de la última semana están, 5) apunta cuánto has tardado en la hoja `historial` con la nota «SIMULACRO: restaurada en X minutos». Ese número es tu tiempo real de recuperación, y saberlo cambia decisiones.

### Cómo probarla
- Sube a la carpeta un archivo `backup-falso.zip` de 100 KB: debe salir FALLO por tamaño.
- Renombra un `.txt` como `.zip` y súbelo: el nodo de integridad debe cazarlo.
- Borra temporalmente todos los archivos de la carpeta (a una subcarpeta) y ejecuta: debe avisar de que no hay copias.

### Qué puede salir mal
- **Google Drive tarda o corta descargas grandes**: por eso pedimos solo los primeros 1.024 bytes con la cabecera `Range`.
- **El plugin sube la copia troceada** en varios archivos (`.zip.001`): ajusta la expresión regular del Code y valora solo el primero.
- **Copia cifrada**: si tu backup va cifrado, la comprobación de firma fallará siempre. Cambia la regla por «pesa lo esperado y es reciente» y confía el resto al simulacro trimestral.
- **La copia está en el mismo servidor que la web**: entonces no es copia. Asegúrate de que hay al menos una fuera (regla 3-2-1: tres copias, dos soportes, una fuera de casa).

### Cuánto cuesta
- Google Drive: 15 GB gratis; 100 GB por 1,99 €/mes si te quedas corto.
- n8n auto-alojado, Sheets y Gmail: **0 €**. LocalWP para el simulacro: gratis.
