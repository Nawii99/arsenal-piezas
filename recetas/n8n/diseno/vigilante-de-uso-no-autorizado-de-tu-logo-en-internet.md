# Vigilante de uso no autorizado de tu logo en internet…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Busca cada semana tu logotipo por imagen en Google Lens, descarta los sitios tuyos y te avisa cuando aparece en una web ajena.

## Qué es y qué hace

Envía la URL pública de tu logo a Google Lens mediante SerpApi, recoge las páginas donde aparece, descarta tus dominios y los ya vistos, y avisa por Telegram de cada nueva aparición. Entrada: URL del logo; salida: hoja Vigilancia y avisos. Se monta en n8n. Un hallazgo no equivale a una infracción; la valoración legal la hace un profesional.

## Cómo usarla

1. Sube el logo a una URL pública estable
2. Crea la cuenta de SerpApi
3. Configura el bot de Telegram
4. Que lo revise un profesional

## Cuándo usarla

Cuando has registrado una marca o entregas identidades a clientes y quieres detectar copias, revendedores o proveedores que usan el logo sin permiso.

## Cómo ganar dinero con ella

Un servicio de vigilancia de marca cuesta 40-90 euros al mes; esto hace la parte visual por el coste de unas búsquedas de API.

- Vigilancia de uso de logo para marcas registradas frente a revendedores online.
- Servicio trimestral de búsqueda de copias para estudios que entregan identidades.
- Informe de apariciones de logo para negocios con franquicias o distribuidores.

**Precio orientativo:** 50–150 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Manda la URL pública de tu logo a la API de Google Lens (vía SerpApi), recoge las páginas donde aparece esa imagen, descarta tus propios dominios y los ya vistos, y te avisa por Telegram de los nuevos. Para marcas, estudios y autónomos que quieren defender su identidad sin pagar una suscripción de vigilancia.

## Lo que necesitas antes
- Cuenta de n8n.
- Tu logo subido a una URL pública y estable (por ejemplo en tu web: `https://tumarca.com/logo.png`). Que sea PNG o JPG de al menos 400 px de ancho.
- Cuenta en serpapi.com: registro gratuito, 250 búsquedas al mes. La clave está en el panel, apartado Your Account, campo `Private API Key`.
- Hoja de Google Sheets `Vigilancia` con columnas: `fecha`, `dominio`, `url`, `titulo`.
- Bot de Telegram: escribe a @BotFather, comando `/newbot`, te da un token. Escribe algo a tu bot y saca tu chat id en `https://api.telegram.org/bot<TOKEN>/getUpdates`.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Weeks, día Monday, hora 07:00, Timezone `Europe/Madrid`.
2. **HTTP Request** (`Buscar en Lens`) — Method: GET. URL: `https://serpapi.com/search.json`. Send Query Parameters: activado, con `engine` = `google_lens`, `url` = la URL de tu logo, `hl` = `es`, `country` = `es`, `api_key` = tu clave (mejor guárdala en Settings, Variables, o en una credencial Header Auth).
3. **Code** (`Extraer resultados`) — Mode: Run Once for All Items. Ver código abajo: aplana `visual_matches`, saca el dominio y filtra los tuyos.
4. **Google Sheets** — Operation: Get Row(s) sobre `Vigilancia`, para leer lo ya detectado.
5. **Code** (`Quitar repetidos`) — Mode: Run Once for All Items. `const vistos = new Set($('Google Sheets').all().map(i => i.json.url)); return $('Extraer resultados').all().filter(i => !vistos.has(i.json.url));`
6. **IF** — Condition: `{{ $json.url }}` is not empty. Rama true sigue.
7. **Google Sheets** — Operation: Append Row. Mapea `fecha` = `{{ $now.format('yyyy-MM-dd') }}`, `dominio`, `url`, `titulo`.
8. **Telegram** — Operation: Send Message. Chat ID: el tuyo. Text: `Posible uso de tu logo: {{ $json.titulo }} — {{ $json.url }}`.

## El trozo de código (nodo Code del paso 3)
```javascript
const MIOS = ['tumarca.com', 'instagram.com', 'facebook.com', 'linkedin.com', 'behance.net', 'pinterest.com'];
const r = $input.first().json;
const matches = r.visual_matches || [];
const out = [];
for (const m of matches) { const url = m.link || ''; if (!url) continue; let dominio = ''; try { dominio = new URL(url).hostname.replace('www.',''); } catch (e) { continue; } if (MIOS.some(d => dominio.endsWith(d))) continue; out.push({ json: { dominio, url, titulo: (m.title || '').slice(0, 120) } }); }
return out;
```

## Cómo probarla
- Ejecuta a mano el nodo HTTP Request y mira que la respuesta trae la clave `visual_matches`. Si viene `error`, la URL de la imagen no es accesible públicamente (pruébala en una ventana de incógnito).
- Añade temporalmente `pinterest.com` fuera de la lista MIOS para ver que el flujo detecta y avisa de algo real.
- Ejecuta dos veces seguidas: la segunda no debe mandar ningún mensaje, porque ya está en la hoja.

## Qué puede salir mal
- **Límite de SerpApi**: 250 búsquedas al mes gratis. Una ejecución semanal usa 4. No lo pongas diario si vigilas varios logos.
- **Falsos positivos**: agregadores y bancos de logos aparecerán siempre. Ve añadiendo esos dominios al array MIOS.
- **La hoja crece**: cada 6 meses borra filas de más de un año o el nodo Get Rows se vuelve lento.
- **Logo demasiado genérico**: si tu isotipo es un círculo, Lens te devolverá ruido. Usa la versión con el nombre incluido.

## Cuánto cuesta
- n8n auto-alojado: 0 euros.
- SerpApi: gratis hasta 250 búsquedas al mes; el siguiente plan son 75 dólares al mes (no lo necesitas para una marca).
- Telegram y Google Sheets: gratis.
- Coste real: 0 euros al mes.
