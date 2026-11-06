# Optimizador automático de modelos para web y AR…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cada GLB que sueltas en una carpeta sale comprimido con Draco y texturas KTX2, con un informe de cuánto ha adelgazado y aviso si pierde calidad. Para quien publica 3D en webs o AR.

## Qué es y qué hace

Vigila una carpeta con modelos .glb o .gltf, aplica compresión de geometría con Draco o Meshopt, reduce texturas y limpia nodos sin usar con gltf-transform. Guarda el archivo optimizado, anota el antes y el después en una hoja y avisa por Telegram si el resultado parece roto o el ahorro es muy pequeño. Entrada: modelos 3D; salida: archivos ligeros e informe. Necesita n8n auto-alojado con Node.js.

## Cómo usarla

1. Instalar gltf-transform y n8n auto-alojado
2. Crear las carpetas de entrada y salida
3. Probar con tres modelos
4. Configurar el aviso de Telegram

## Cuándo usarla

Cuando publiques modelos 3D en una web o configurador y los archivos de 40 MB estén tirando abajo la velocidad de carga y tu posicionamiento en Google.

## Cómo ganar dinero con ella

Reduce el peso de los modelos un 70-90 %, ahorra en ancho de banda y evita pagar a un técnico 200-400 € por optimizar cada tanda de modelos.

- Optimizar modelos para visores web de tiendas y configuradores, cobrando por lote.
- Dar mantenimiento mensual de modelos 3D a una agencia web que publica en realidad aumentada.
- Vender la automatización a artistas 3D que sirven assets a clientes finales.

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta con modelos .glb o .gltf, les aplica compresión de geometría (Draco o Meshopt), convierte las texturas a KTX2 y baja resolución si se pasan, y limpia nodos y materiales que no se usan.
Guarda el archivo optimizado en otra carpeta, apunta el antes y el después en una hoja y te avisa por Telegram si la reducción es sospechosamente pequeña o si el archivo ha quedado roto. Para diseñadores web, agencias y artistas 3D que publican en model-viewer, Three.js o AR.

## Lo que necesitas antes
n8n auto-alojado con Node.js y la herramienta `gltf-transform` instalada globalmente: `npm install -g @gltf-transform/cli`. Comprueba con `gltf-transform --help`.
Las herramientas KTX (`toktx` de KTX-Software) instaladas si quieres texturas KTX2; si no, usa solo la compresión de geometría y el redimensionado de texturas, que ya te da el grueso del ahorro.
Cuenta de Google con Drive API y Sheets API. Bot de Telegram: escribe a @BotFather, pulsa /newbot, copia el token y pega tu chat_id (lo sacas escribiendo a @userinfobot).
Dos carpetas de Drive: «3D-ORIGINALES» y «3D-WEB». Una hoja «Optimizaciones» con columnas: fecha, archivo, mb_antes, mb_despues, reduccion_pct, aviso.

## Los nodos, en orden
**Google Drive Trigger** — Event: File Created en «3D-ORIGINALES», Poll: cada 10 minutos.
**IF** — `{{$json.name}}` Regex Match `\.(glb|gltf)$`.
**Google Drive** — Download, Binary Property `data`.
**Read/Write Files from Disk** — Write, `/data/glb/{{$json.name}}`.
**Execute Command** — `gltf-transform optimize "/data/glb/{{ $('Google Drive Trigger').item.json.name }}" "/data/glb/opt_{{ $('Google Drive Trigger').item.json.name }}" --compress draco --texture-compress webp --texture-size 1024`. Timeout: 300 s.
**Execute Command** — `stat -c%s "/data/glb/{{ $('Google Drive Trigger').item.json.name }}" && stat -c%s "/data/glb/opt_{{ $('Google Drive Trigger').item.json.name }}"` para leer los dos tamaños.
**Code** — calcula porcentajes y decide si hay aviso (código abajo).
**Read/Write Files from Disk** — Read del archivo optimizado, propiedad binaria `opt`.
**Google Drive** — Upload a «3D-WEB», Input Binary Field: `opt`.
**Google Sheets** — Append Row en «Optimizaciones».
**IF** — `{{$json.aviso}}` no está vacío.
**Telegram** (rama true) — Operation: Send Message, Chat ID el tuyo, Text: `⚠️ {{$json.archivo}}: {{$json.aviso}} ({{$json.mb_antes}} MB → {{$json.mb_despues}} MB)`.

## El nodo Code
```javascript
const salida = $json.stdout.trim().split('\n');
const antes = Number(salida[0]) / 1048576;
const despues = Number(salida[1]) / 1048576;
const nombre = $('Google Drive Trigger').item.json.name;
const reduccion = antes > 0 ? Math.round((1 - despues / antes) * 100) : 0;
let aviso = '';
if (despues === 0 || isNaN(despues)) aviso = 'El archivo optimizado está vacío o falló la conversión';
else if (reduccion < 20) aviso = 'Reducción muy baja: revisa si el modelo ya venía comprimido';
else if (despues > 8) aviso = 'Sigue pesando más de 8 MB: baja las texturas a 512px o simplifica la malla';
return { json: { fecha: new Date().toISOString().slice(0,10), archivo: nombre, mb_antes: antes.toFixed(2), mb_despues: despues.toFixed(2), reduccion_pct: reduccion, aviso } };
```

## Cómo probarla
Prueba primero en terminal con un GLB de ejemplo y abre el resultado en https://modelviewer.dev/editor para ver que no se ha roto ni ha perdido materiales.
Ejecuta el flujo con un modelo grande (más de 20 MB) y comprueba el porcentaje de reducción en la hoja.
Prueba también con un GLB ya comprimido para ver que salta el aviso de «reducción muy baja».

## Qué puede salir mal
Draco rompe modelos con animaciones de esqueleto complejas: para esos usa `--compress meshopt` en vez de draco.
Si el visor web no muestra el modelo, casi siempre falta cargar el decodificador Draco en la web; en model-viewer va incluido, en Three.js hay que añadir DRACOLoader.
Las texturas con canal alfa mal convertidas se ven con bordes sucios: quita `--texture-compress webp` para ese modelo concreto.
gltf-transform puede tardar mucho con texturas de 4K; sube el timeout del nodo y procesa de uno en uno con **Split In Batches** (Batch Size 1) si te llegan tandas.

## Cuánto cuesta
gltf-transform, KTX-Software y n8n auto-alojado son gratis. Telegram es gratis.
Solo pagas el servidor donde corra n8n (5-6 €/mes) o nada si lo tienes en tu propio equipo.
Alternativa de pago que te ahorras: servicios de optimización 3D que cobran entre 1 y 5 € por modelo.
