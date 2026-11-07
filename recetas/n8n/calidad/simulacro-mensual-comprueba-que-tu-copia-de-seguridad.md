# Simulacro mensual: comprueba que tu copia de seguridad…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Una vez al mes verifica que existe una copia reciente, que no está vacía ni corrupta, y te manda el guion de restauración para que lo pruebes de verdad en 20 minutos.

## Qué es y qué hace

Una vez al mes busca en Google Drive el archivo de copia más reciente de tu web y comprueba que tiene menos de una semana, que su tamaño es razonable y que su formato es real (ZIP, GZIP o volcado SQL). Después envía un acta y una lista para probar la restauración a mano en un entorno de pruebas. Entrada: carpeta de copias en Drive; salida: acta. Se monta en n8n.

## Cómo usarla

1. Anota el ID de la carpeta de copias en Drive
2. Crea la hoja actas_backup
3. Prepara un subdominio de pruebas y restaura a mano
4. Que lo revise un profesional

## Cuándo usarla

Úsalo si tienes copias automáticas de la web o de la base de datos y nunca has intentado restaurarlas. Una copia sin probar no es una copia.

## Cómo ganar dinero con ella

Recuperar una web sin copia válida cuesta entre 500 y 3.000 € y días de parón. Este control es gratis.

- Control mensual de copias para una tienda online con plugin de backup.
- Simulacro de restauración para una web de autónomo con datos de clientes.
- Auditoría de copias para una agencia que mantiene varias webs.

**Precio orientativo:** 80–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Busca el archivo de copia de seguridad más reciente, comprueba que es de hace menos de una semana, que pesa lo que debe y que su cabecera corresponde a un ZIP, un GZIP o un volcado SQL de verdad. Después te envía el acta y la checklist de restauración para que hagas la parte manual.
Para cualquier negocio cuya web, tienda o base de clientes viva en un servidor.

## Lo que necesitas antes
- n8n.
- Que tus copias acaben en una carpeta de Google Drive (la mayoría de plugins de backup como UpdraftPlus o Duplicator lo permiten). Anota el ID de la carpeta: está en la URL cuando la abres en Drive.
- Credenciales de Google Drive, Gmail y Google Sheets en n8n.
- Una hoja `actas_backup` con columnas: `fecha`, `archivo`, `tamano_mb`, `antiguedad_dias`, `formato`, `veredicto`, `restauracion_probada`.
- Un sitio donde restaurar de prueba: un subdominio tipo `pruebas.tudominio.com` o un entorno local. Esto se monta una vez.

## Los nodos, en orden
1. **Schedule Trigger**. Cron `0 9 1 * *` (día 1 de cada mes a las 9).
2. **Google Drive**. Operación `Search Files and Folders`. En Filters, Folder: el ID de tu carpeta de copias. En Options > Order By: `modifiedTime desc`. Limit `5`. Activa que devuelva los campos `size` y `modifiedTime`.
3. **Code** (elige la más reciente y revisa fecha y tamaño):
```javascript
const archivos = $input.all().map(i => i.json).filter(f => !f.mimeType.includes('folder'));
if (archivos.length === 0) return [{ json: { veredicto: 'CRITICO', motivo: 'No hay ningun archivo de copia en la carpeta' } }];
const f = archivos[0];
const dias = Math.round((Date.now() - new Date(f.modifiedTime)) / 86400000);
const mb = Math.round((Number(f.size || 0) / 1048576) * 10) / 10;
const fallos = [];
if (dias > 7) fallos.push('La copia mas reciente tiene ' + dias + ' dias');
if (mb < 1) fallos.push('Pesa solo ' + mb + ' MB: sospechosamente pequena');
return [{ json: { id: f.id, nombre: f.name, mb, dias, fallos } }];
```
4. **Google Drive**. Operación `Download` del archivo `{{ $json.id }}`. Si tus copias pesan mucho, en Options limita la descarga o usa la operación `Get` para leer solo los metadatos y sáltate el paso 5.
5. **Code** (mira la cabecera real del archivo):
```javascript
const bin = $input.first().binary.data;
const buf = Buffer.from(bin.data, 'base64');
const cabecera = buf.slice(0, 4).toString('hex');
const inicio = buf.slice(0, 800).toString('utf8');
const esZip = cabecera.startsWith('504b');
const esGzip = cabecera.startsWith('1f8b');
const esSql = /CREATE TABLE|MySQL dump|PostgreSQL database dump/i.test(inicio);
const previo = $('Code').first().json;
const fallos = [...(previo.fallos || [])];
if (!esZip && !esGzip && !esSql) fallos.push('Formato no reconocido (cabecera ' + cabecera + '): puede estar corrupta o ser un HTML de error');
return [{ json: { ...previo, formato: esZip ? 'ZIP' : esGzip ? 'GZIP' : esSql ? 'SQL' : 'DESCONOCIDO', fallos, veredicto: fallos.length === 0 ? 'OK' : 'REVISAR' } }];
```
6. **Google Sheets** `Append Row` en `actas_backup`.
7. **Gmail** `Send`. Asunto: `Simulacro de copia de seguridad: {{ $json.veredicto }}`. En el cuerpo, además del resultado, incluye siempre esta checklist manual, que es la parte que de verdad demuestra que funciona:
8. Checklist del correo: 1) Descarga la copia. 2) Restáurala en `pruebas.tudominio.com`. 3) Entra al panel con tu usuario. 4) Comprueba que aparecen los 5 últimos pedidos o clientes. 5) Abre una página con imágenes y comprueba que se ven. 6) Cronometra cuánto has tardado y anótalo. 7) Marca `restauracion_probada` = `si` en la hoja.

## Cómo probarla
- Sube a la carpeta un archivo de texto renombrado a `.zip` y ejecuta: debe salir `DESCONOCIDO` y `REVISAR`.
- Renombra temporalmente la copia buena para que la más reciente sea antigua: debe avisar por antigüedad.
- Haz la restauración manual completa la primera vez. Si tardas más de una hora, ya sabes que tu plan de recuperación no vale.

## Qué puede salir mal
- **Copias enormes**: descargar 5 GB dentro de n8n puede tumbar el servidor. Si tu copia pasa de 500 MB, salta el paso de descarga y valida solo fecha y tamaño; la comprobación de cabecera hazla en la restauración manual.
- **Copias cifradas**: si tu plugin cifra el ZIP, la cabecera será distinta. Ajusta el Code o valida solo tamaño y fecha.
- **Copia que existe pero está vacía por dentro**: por eso el paso manual mira pedidos reales. Un ZIP de 200 MB puede contener solo caché.
- **La copia y la web en el mismo servidor**: eso no es copia de seguridad. Asegúrate de que sale a Drive o a otro proveedor.
- **Zona horaria**: `modifiedTime` viene en UTC; el cálculo por días lo absorbe sin problema.

## Cuánto cuesta
0 €. Google Drive gratis hasta 15 GB; a partir de ahí, Google One desde 1,99 €/mes por 100 GB. n8n autoalojado (Community Edition), Gmail y Sheets, gratis (n8n Cloud: prueba gratuita temporal y después de pago).
