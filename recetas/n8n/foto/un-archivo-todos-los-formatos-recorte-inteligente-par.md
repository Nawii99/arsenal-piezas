# Un archivo, todos los formatos: recorte inteligente par…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Coge tu foto original y genera automáticamente las versiones cuadrada, vertical, historia y portada, recortando por donde está el sujeto y no por el centro.

## Qué es y qué hace

Cuando dejas una foto en la carpeta MAESTRAS de Drive, genera automáticamente seis versiones (1:1, 4:5, 9:16, 16:9, portada de blog y miniatura) con recorte inteligente centrado en el sujeto mediante g_auto de Cloudinary. Las optimiza en peso y las nombra por formato. Usa n8n con el disparador de Google Drive.

## Cómo usarla

1. Crea las carpetas MAESTRAS y FORMATOS con subcarpetas
2. Conecta Cloudinary y Drive en n8n
3. Prueba con tres fotos
4. Ajusta el recorte de los formatos clave

## Cuándo usarla

Cuando publicas la misma foto en Instagram, TikTok, la web y el newsletter y pierdes media mañana recortando y exportando a mano cada tamaño.

## Cómo ganar dinero con ella

Ahorra 10-15 minutos por foto: con 40 publicaciones al mes son unas 8 horas, y evita pagar a un diseñador por reencuadres mecánicos.

- Montaje de un flujo de formatos para creadores de contenido que publican en varias redes.
- Servicio mensual de reencuadre para tiendas online con catálogo que sube productos cada semana.
- Plantilla de flujo de formatos vendida a fotógrafos que quieren una sola foto para todos los canales.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Para creadores de contenido, tiendas y fotógrafos que publican en varios sitios: dejas una foto en una carpeta y aparecen automáticamente seis versiones (1:1, 4:5, 9:16, 16:9, portada de blog y miniatura) recortadas con detección automática del sujeto, optimizadas de peso y con el nombre de cada formato en el archivo.

## Lo que necesitas antes
- n8n (auto-alojado gratis; Cloud tiene prueba temporal y luego es de pago).
- Cloudinary gratuita: Cloud name, API Key, API Secret. El recorte inteligente usa `g_auto`, que está incluido en el plan gratuito.
- Credencial Google Drive OAuth2.
- Carpetas en Drive: `MAESTRAS` (entrada) y `FORMATOS` con subcarpetas `1x1`, `4x5`, `9x16`, `16x9`, `blog`, `mini`.
- Opcional: base de Airtable o una hoja de Sheets para llevar el registro de qué foto tiene ya sus formatos.

## Los nodos, en orden
1. **Google Drive Trigger** — Specific Folder `MAESTRAS`, Watch For: File Created, Poll cada 10 minutos.
2. **Google Drive** — Download, campo binario `data`.
3. **HTTP Request «Subir maestra»** — POST a `https://api.cloudinary.com/v1_1/TU_CLOUD/image/upload`, Basic Auth, Form-Data: `file` (binario `data`), `folder` = `maestras`, `use_filename` = `true`, `unique_filename` = `false`.
4. **Code «Generar los seis formatos»** — devuelve seis items, uno por formato (código abajo).
5. **Loop Over Items** — Batch Size: 1.
6. **HTTP Request «Descargar formato»** — GET a `={{ $json.url }}`, Response Format: File, Put Output in Field: `data`. En Settings activa Retry On Fail (3 intentos): la primera vez que se pide una transformación, Cloudinary la genera y puede tardar.
7. **Google Drive** — Upload. File Name `={{ $json.nombre_archivo }}`. Parent Folder Drive ID: `={{ $json.carpeta_id }}` (los IDs de las seis subcarpetas los pones en el propio Code).
8. Fuera del bucle: **Google Drive** — Operation: Move de la maestra a una carpeta `PROCESADAS`, para que el trigger no la vuelva a coger.
9. **Airtable** (o Google Sheets) — Create Record con nombre, fecha, y los seis enlaces de Drive.
10. **Gmail** o **Slack** — aviso opcional con el enlace a la carpeta.

## El trozo de código (nodo Code «Generar los seis formatos»)
```javascript
const CLOUD = 'TU_CLOUD_NAME';
const CARPETAS = {
  '1x1': 'ID_CARPETA_1X1',
  '4x5': 'ID_CARPETA_4X5',
  '9x16': 'ID_CARPETA_9X16',
  '16x9': 'ID_CARPETA_16X9',
  'blog': 'ID_CARPETA_BLOG',
  'mini': 'ID_CARPETA_MINI'
};
const FORMATOS = [
  { clave: '1x1',  t: 'c_fill,g_auto,w_1080,h_1080,q_auto:good,f_auto' },
  { clave: '4x5',  t: 'c_fill,g_auto,w_1080,h_1350,q_auto:good,f_auto' },
  { clave: '9x16', t: 'c_fill,g_auto,w_1080,h_1920,q_auto:good,f_auto' },
  { clave: '16x9', t: 'c_fill,g_auto,w_1920,h_1080,q_auto:good,f_auto' },
  { clave: 'blog', t: 'c_fill,g_auto,w_1200,h_630,q_auto:eco,f_auto' },
  { clave: 'mini', t: 'c_fill,g_auto:faces,w_400,h_400,q_auto:eco,f_auto' }
];
const d = $input.first().json;
const pid = d.public_id;
const base = (d.original_filename || pid.split('/').pop());
return FORMATOS.map(f => ({ json: {
  clave: f.clave,
  nombre_archivo: `${base}_${f.clave}.jpg`,
  carpeta_id: CARPETAS[f.clave],
  url: `https://res.cloudinary.com/${CLOUD}/image/upload/${f.t}/${pid}.jpg`
}}));
```

## Cómo probarla
- Sube una foto horizontal con el sujeto claramente a la izquierda.
- Abre la versión 9:16: el sujeto tiene que salir dentro del encuadre, no cortado. Si sale cortado, cambia `g_auto` por `g_auto:subject` o por `g_faces` en ese formato concreto.
- Comprueba el peso: una 1080x1350 con `q_auto:good` debería rondar 150-300 KB. Si pesa 2 MB, revisa que pusiste `q_auto` y `f_auto`.

## Qué puede salir mal
- **Recortes raros en fotos de grupo**: `g_auto` decide por saliencia. Para retratos usa `g_faces:center`; para producto sobre fondo liso, `g_auto:subject`.
- **El trigger se repite**: si no mueves la maestra a `PROCESADAS`, el flujo la reprocesará. El nodo Move es obligatorio.
- **Texto que se corta**: si tu foto lleva texto grabado, el recorte inteligente no lo respeta. Genera esas piezas en Canva o añade el texto después, sobre cada formato.
- **`f_auto` y Drive**: `f_auto` puede devolver WebP; si pides `.jpg` en la URL, Cloudinary respeta el jpg. Si prefieres WebP para la web, cambia la extensión y el nombre del archivo.
- **Créditos**: seis transformaciones por foto. Con 200 fotos al mes son 1.200 transformaciones, muy dentro del plan gratuito.

## Cuánto cuesta
n8n autoalojado (Community Edition), Drive y Airtable (plan gratuito): 0 €; n8n Cloud tiene una prueba gratuita temporal y después planes de pago. Cloudinary: 25 créditos/mes gratis, que dan de sobra para unos cuantos miles de transformaciones. Alternativa 100 % gratis y sin límite: hacerlo con ImageMagick en n8n auto-alojado, pero pierdes el recorte inteligente y tendrás que recortar por el centro.
