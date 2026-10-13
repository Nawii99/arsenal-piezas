# Ordenar y respaldar fotos con n8n…

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

NODOS, EN ORDEN
1. Disparador: Google Drive Trigger, evento fichero creado, vigilando la carpeta ENTRADA. Frecuencia de comprobacion cada 5 minutos.
2. Filter: sigue solo si el nombre acaba en .jpg, .jpeg, .png, .heic o .dng. Lo demas se descarta ahi mismo.
3. Google Drive - Download File: baja el fichero para poder trabajarlo.
4. Code o Set: construye el nombre nuevo con fecha y contador, por ejemplo 2026-09-20_producto_0007. Guarda tambien el tamano y el tipo.
5. Google Drive - Upload File: sube el fichero renombrado a la carpeta ORDENADAS, en una subcarpeta por ano y mes.
6. HTTP Request o el nodo de S3: envia el mismo fichero al almacen de copia de seguridad (B2 o R2). Esta es la copia que te salva.
7. Google Sheets - Append Row: apunta nombre nuevo, fecha, tamano, enlace de Drive, enlace de la copia y una columna vacia Publicada.
8. IF: si el fichero pesa mas de 20 MB, rama de aviso.
9. Gmail o Telegram: mensaje corto con lo procesado y los avisos del dia.
10. Error Trigger en un flujo aparte: te avisa si algo falla, para no enterarte tres semanas despues.

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
