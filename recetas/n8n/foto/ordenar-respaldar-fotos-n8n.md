# Ordenar y respaldar fotos con n8n

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Fotos nuevas se renombran, copian a seguridad y quedan anotadas en una hoja, sin tocar.

## Qué es y qué hace

Es una receta de n8n que toma cada foto nueva de una carpeta de entrada, la renombra, la copia a una carpeta de seguridad y la anota en una hoja. El original no se toca ni se borra. Entran las fotos que sueltas en la carpeta de entrada; salen copias ordenadas y un registro con sus datos. Usa Google Drive, Google Sheets y un almacenamiento de copia como Backblaze B2 o Cloudflare R2.

## Cómo usarla

1. Crea las carpetas de entrada y de archivo
2. Monta el disparador y el renombrado en orden
3. Prueba con cinco fotos y revisa el registro

## Cuándo usarla

Cuando acumulas fotos sueltas en el movil y en el ordenador y nunca sabes cual es la buena ni donde esta la copia.

## Cómo ganar dinero con ella

Montaje del sistema para un fotografo o una tienda: 250-400 euros una vez, mas mantenimiento opcional de 30 euros al mes.

- Orden y copia de seguridad de las fotos de un fotógrafo que tiene archivos repartidos.
- Catálogo de imágenes para una tienda que necesita encontrar cada foto por proyecto.
- Mantenimiento mensual del sistema con revisión del espacio y de las copias.

**Precio orientativo:** 250–400 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Objetivo: cada foto que sueltes en una carpeta queda renombrada, copiada en un segundo sitio y anotada en una hoja, sin tocar el original.

CUENTAS QUE HACEN FALTA Y SUS LIMITES GRATUITOS
- n8n: gratis si lo instalas tu (Docker en un ordenador que este encendido). La version en la nube es de pago tras la prueba.
- Google Drive: 15 GB gratis compartidos con Gmail y Fotos. Las fotos los comen rapido.
- Backblaze B2 o Cloudflare R2 para la copia de seguridad: 10 GB gratis. Mas alla, se paga por GB.
- Google Sheets: gratis con la misma cuenta.
- Telegram: bot gratuito creado con @BotFather, para los avisos.

NODOS, EN ORDEN
1. Disparador: Google Drive Trigger, evento fichero creado, vigilando la carpeta ENTRADA. Frecuencia de comprobacion cada 5 minutos.
2. Filter, llamado exactamente «Filtrar solo imágenes» (otros nodos lo citan con ese nombre): sigue solo si el nombre (campo name) acaba en .jpg, .jpeg, .png, .heic o .dng (condiciones «termina en», unidas con O y sin distinguir mayúsculas). Lo demas se descarta ahi mismo.
3. Antes de descargar, hay que tener la subcarpeta del mes. Primero un nodo Google Drive que busque carpetas por nombre (solo carpetas, dentro de ORDENADAS, límite 1), llamado «Buscar subcarpeta año-mes», con el nombre {{ $now.toFormat('yyyy-LL') }}; en sus ajustes activa que siempre devuelva datos aunque no encuentre nada. Después un IF llamado «¿Existe la subcarpeta?» con la condición {{ !!$json.id }} verdadera: su salida «true» va directa a la descarga; la «false» pasa antes por un nodo Google Drive - Create Folder llamado «Crear subcarpeta año-mes», que crea en ORDENADAS una carpeta con ese mismo nombre y se conecta a la descarga. La descarga es Google Drive - Download File, llamado «Descargar original»: baja el fichero para poder trabajarlo, tomando su ID de {{ $('Filtrar solo imágenes').item.json.id }}.
4. Code (modo Run Once for Each Item), llamado exactamente «Construir nombre nuevo» (otros nodos lo citan con ese nombre): construye el nombre nuevo con fecha y contador, por ejemplo 2026-09-20_producto_0007. Guarda tambien el tamano y el tipo, el id de la carpeta de destino (carpetaId, que lee de «Crear subcarpeta año-mes» si se creó o, si no, de «Buscar subcarpeta año-mes») y la direccion de la copia de seguridad (urlCopia).
5. Google Drive - Upload File, llamado exactamente «Subir a ORDENADAS»: sube el fichero renombrado (nombre {{ $json.nombreNuevo }}, campo binario data) a la subcarpeta por ano y mes, usando como carpeta de destino {{ $json.carpetaId }}.
6. HTTP Request, llamado «Copia de seguridad (R2 o B2)» (metodo PUT a {{ $json.urlCopia }}, autenticacion con la credencial de tipo AWS/S3, cuerpo con el binario del campo data): envia el mismo fichero al almacen de copia de seguridad (B2 o R2). Se conecta, igual que el paso 5, a la salida del paso 4, de modo que los pasos 5 y 6 corren en paralelo. Esta es la copia que te salva.
7. Antes, un nodo Merge llamado «Juntar resultados», en modo combinar por posicion, recibe la salida del paso 5 (entrada 1) y la del paso 6 (entrada 2). Despues, Google Sheets - Append Row, llamado «Apuntar en la hoja» (hoja «Fotos»): apunta nombre nuevo, fecha, tamano, enlace de Drive, enlace de la copia y una columna vacia Publicada.
8. IF, llamado «¿Pesa más de 20 MB?», con la condicion {{ $('Construir nombre nuevo').item.json.tamanoBytes > 20 * 1024 * 1024 }} verdadera: si el fichero pesa mas de 20 MB, rama de aviso (salida «true»); si no, sale por la «false».
9. Telegram (Send Message), dos nodos, uno por cada foto procesada: «Aviso: foto grande» en la salida «true» del IF (nombre nuevo y tamano, avisando de que pesa mas de 20 MB) y «Resumen de lo procesado» en la «false» (foto procesada y respaldada, sin avisos).
10. Error Trigger en un flujo aparte (una segunda cadena dentro del mismo archivo, conectada a un Telegram llamado «Avisar del error» que envia el nombre del flujo, el nodo que fallo y el mensaje de error; en los ajustes del flujo principal elige ese flujo como Error workflow): te avisa si algo falla, para no enterarte tres semanas despues.

COMO PROBARLA SIN LIARLA
- Crea carpetas de prueba nuevas: ENTRADA-TEST y ORDENADAS-TEST. No apuntes al archivo real hasta que funcione.
- Empieza con 3 fotos que puedas perder. Ejecuta a mano con Execute Workflow y mira el resultado nodo a nodo.
- Desactiva o no pongas ningun nodo que borre o mueva el original. Este flujo copia, nunca borra.
- Cuando las 3 salgan bien, prueba con 30. Solo entonces cambia las carpetas por las buenas y activa el flujo.

LIMITES Y AVISOS
- Esto ordena y respalda, no edita ni revela. El criterio de que foto es buena sigue siendo tuyo.
- Si las fotos llevan caras de clientes o de menores, no las mandes a servicios de IA ni a galerias publicas sin permiso por escrito de esa persona, y de sus padres o tutores si es menor. Guarda ese permiso junto al encargo.
- Los metadatos de la foto llevan fecha y muchas veces coordenadas GPS. Antes de publicar en abierto, quitalos con ExifTool o con la opcion de exportar sin metadatos.
- Si alguna imagen esta generada o retocada con IA de modo que cambie lo que se ve, apuntalo en la hoja y avisalo al publicar.
- Una copia de seguridad no comprobada no existe: una vez al mes, baja un fichero al azar de la copia y abrelo.

CÓDIGO DE LOS NODOS (el mismo que lleva el flujo importable)

Nodo Code «Construir nombre nuevo»:
```js
// Ajusta estos tres valores
const PREFIJO = 'producto';
const COPIA_BASE = 'https://PON_AQUI_TU_ID_DE_CUENTA.r2.cloudflarestorage.com/PON_AQUI_TU_BUCKET';
const original = $('Filtrar solo imágenes').item.json;
const bin = $input.item.binary.data;
const ext = (original.name.match(/\.[^.]+$/) || [''])[0].toLowerCase();
const estatico = $getWorkflowStaticData('global');
estatico.contador = (estatico.contador || 0) + 1;
const fecha = $now.toFormat('yyyy-LL-dd');
const nuevo = fecha + '_' + PREFIJO + '_' + String(estatico.contador).padStart(4, '0') + ext;
let bytes = Number(original.size);
if (!Number.isFinite(bytes) || bytes <= 0) {
  const m = String(bin.fileSize || '').match(/([\d.,]+)\s*(bytes|kb|mb|gb)/i);
  const mult = { bytes: 1, kb: 1024, mb: 1024 ** 2, gb: 1024 ** 3 };
  bytes = m ? Math.round(parseFloat(m[1].replace(',', '.')) * mult[m[2].toLowerCase()]) : 0;
}
bin.fileName = nuevo;
let carpeta = '';
try { carpeta = $('Crear subcarpeta año-mes').item.json.id; } catch (e) {}
if (!carpeta) carpeta = $('Buscar subcarpeta año-mes').item.json.id;
const ym = $now.toFormat('yyyy/LL');
return {
  json: { nombreNuevo: nuevo, nombreOriginal: original.name, fecha, tamanoBytes: bytes, tamanoMb: Math.round(bytes / 10485.76) / 100, tipo: bin.mimeType, carpetaId: carpeta, urlCopia: COPIA_BASE + '/' + ym + '/' + nuevo },
  binary: $input.item.binary
};
```
