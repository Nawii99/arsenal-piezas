# Registro de autoría: huella digital de cada foto…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Cada foto que subes a Drive queda registrada con su huella SHA-256, fecha y hora exacta en una hoja de cálculo, como prueba de que la hiciste tú primero.

## Qué es y qué hace

Vigila una carpeta de Drive y, por cada foto nueva, calcula su huella SHA-256, un código de 64 caracteres que cambia si se altera un solo píxel, y la anota en una hoja con fecha y hora, nombre, identificador y enlace. Entran archivos originales y salen registros con sello de tiempo, como prueba de autoría. Para fotógrafos que ceden o publican imágenes, con n8n. No sustituye a un registro oficial de propiedad intelectual.

## Cómo usarla

1. Crea la carpeta ORIGINALES y la hoja de registro
2. Conecta Drive y Sheets en n8n
3. Sube siempre los archivos originales de la cámara
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando vendas o cedas fotos y quieras poder demostrar autoría si alguien te copia, o antes de mandar material a una marca, una agencia o un banco de imágenes.

## Cómo ganar dinero con ella

Un peritaje de autoría cuesta desde 300 € y una reclamación sin pruebas suele acabar en nada. Esto te da el registro gratis y automático, foto a foto.

- Implantación de registro de autoría para fotógrafos que ceden imágenes, cobrado por puesta en marcha.
- Registro mensual de originales y verificación de huellas para estudios y agencias pequeñas, por cuota.
- Plantilla de registro de autoría vendida a creadores que comparten material con marcas.

**Precio orientativo:** 150–300 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta de Google Drive y, cada vez que aparece una foto nueva, calcula su huella digital SHA-256 (un código único de 64 caracteres que cambia si alguien toca un solo píxel) y la apunta en una hoja con la fecha y hora exactas.
Es para fotógrafos que ceden imágenes a clientes o las publican en redes y quieren un registro propio, con sello de tiempo, por si algún día tienen que reclamar la autoría.

## Lo que necesitas antes
- Cuenta de Google (gratis) con una carpeta en Drive llamada por ejemplo `ORIGINALES` donde subas siempre los archivos tal cual salen de la cámara.
- Una hoja de cálculo en Google Sheets con estas columnas en la fila 1: `fecha_registro`, `nombre_archivo`, `id_drive`, `sha256`, `tamano_bytes`, `enlace`.
- Credencial de Google en n8n: en n8n vas a Credentials, «Google Drive OAuth2 API», pulsas «Sign in with Google» y aceptas. Repite para «Google Sheets OAuth2 API». Si te pide crear un proyecto, se hace en console.cloud.google.com, gratis, activando las APIs «Google Drive API» y «Google Sheets API».
- Si usas n8n auto-alojado y quieres usar `require('crypto')`, añade la variable de entorno `NODE_FUNCTION_ALLOW_BUILTIN=crypto`. Con el código que te doy abajo NO hace falta: usa el `crypto` global de Node 18, que ya viene activo.

## Los nodos, en orden
1. **Google Drive Trigger** — Resource: `File`, Event: `File Created`, Poll Times: cada 5 minutos, Watch Folder: tu carpeta `ORIGINALES`. Ojo: vigila solo esa carpeta, no las subcarpetas.
2. **IF** — para descartar lo que no sea imagen. Condición String: valor 1 `{{ $json.mimeType }}`, operación `contains`, valor 2 `image/`. La rama `true` sigue; la `false` no se conecta a nada.
3. **Google Drive** — Resource: `File`, Operation: `Download`, File ID: `{{ $json.id }}`. En Options activa «Put Output File in Field» con el valor `data`.
4. **Code** — Mode: `Run Once for Each Item`. Aquí se calcula la huella (código completo abajo).
5. **Google Sheets** — Resource: `Sheet Within Document`, Operation: `Append Row`. Eliges tu documento y la hoja. Mapea las columnas: `fecha_registro` = `{{ $json.fecha_registro }}`, `nombre_archivo` = `{{ $json.nombre_archivo }}`, `id_drive` = `{{ $json.id_drive }}`, `sha256` = `{{ $json.sha256 }}`, `tamano_bytes` = `{{ $json.tamano_bytes }}`, `enlace` = `{{ $json.enlace }}`.

## El código del nodo Code
```javascript
const buffer = await this.helpers.getBinaryDataBuffer(0, 'data');
const hashBuffer = await crypto.subtle.digest('SHA-256', buffer);
const sha256 = Array.from(new Uint8Array(hashBuffer)).map(b => b.toString(16).padStart(2, '0')).join('');
const meta = $('Google Drive Trigger').item.json;
return {
  json: {
    fecha_registro: new Date().toISOString(),
    nombre_archivo: meta.name,
    id_drive: meta.id,
    sha256: sha256,
    tamano_bytes: buffer.length,
    enlace: 'https://drive.google.com/file/d/' + meta.id + '/view'
  }
};
```

## Cómo probarla
- Sube UNA foto a la carpeta y pulsa «Test workflow» en n8n. Comprueba que aparece una fila nueva en la hoja.
- Verifica la huella por tu cuenta: en tu ordenador, en el terminal, `shasum -a 256 foto.jpg` (Mac/Linux) o `certutil -hashfile foto.jpg SHA256` (Windows). Tiene que salir exactamente el mismo código.
- Vuelve a subir la MISMA foto con otro nombre: la huella debe ser idéntica. Abre la foto, guárdala de nuevo desde el editor y súbela: la huella cambiará. Eso es lo que demuestra que el archivo no está tocado.

## Qué puede salir mal
- **El disparador no salta**: el Google Drive Trigger solo mira archivos creados desde que activaste el flujo, y en «modo test» solo mira mientras la ventana está abierta. Actívalo con el interruptor «Active».
- **Fotos muy grandes**: un RAW de 60 MB se carga entero en memoria. Si n8n se queda sin RAM, activa el almacenamiento binario en disco (`N8N_DEFAULT_BINARY_DATA_MODE=filesystem`) o registra solo los JPG de entrega.
- **Duplicados**: si subes lotes grandes, el disparador puede repetir un archivo. Añade en la hoja un formato condicional sobre la columna `sha256` para ver repetidos, o filtra con un nodo **Google Sheets** de lectura antes de escribir.
- **Zona horaria**: `toISOString()` da hora UTC. Para una prueba legal es lo correcto (es un patrón universal), pero anótalo en la cabecera de la hoja para no confundirte en verano.
- **Valor legal**: esto es una prueba propia, fuerte pero no oficial. Si la foto vale mucho dinero, complementa mandándote a ti mismo un burofax o un email con la lista de huellas del mes: el sello del proveedor añade fecha cierta.

## Cuánto cuesta
- n8n auto-alojado: gratis. n8n Cloud plan de inicio: unas 20 € al mes, y este flujo consume 1 ejecución por foto.
- Google Drive y Sheets: gratis hasta 15 GB. Los RAW se comen ese espacio rápido; con 2 TB (Google One) son unos 10 € al mes.
- Coste total realista si ya tienes Drive y montas n8n en tu ordenador o en un VPS de 5 €: 0 a 5 € al mes.
