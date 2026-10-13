# Espía de cambios en APIs de terceros…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Vigila las páginas de changelog y documentación de las APIs de las que depende tu producto y te avisa con un resumen en cuanto cambian algo.

## Qué es y qué hace

Descarga cada día una lista de URLs de changelogs y documentación, se queda con el texto, calcula una huella y la compara con la del día anterior. Si cambia, envía un resumen en castellano de lo que ha cambiado. Se monta con n8n, Make o Zapier y, para el resumen, necesita una clave de API de un modelo de IA.

## Cómo usarla

1. Crea la hoja Fuentes con nombre, URL y huella
2. Añade la clave de Claude, Codex, Gemini o una IA local
3. Conecta Gmail
4. Prueba con una página que cambies a mano

## Cuándo usarla

Cuando tu negocio depende de integraciones con Stripe, Meta, Google, un ERP o cualquier API que puede romperte sin avisarte a ti en concreto.

## Cómo ganar dinero con ella

Enterarte de una deprecación con semanas de margen evita el clásico fin de semana arreglando pagos rotos y las ventas perdidas mientras tanto.

- Vigilancia de APIs para negocios que dependen de integraciones de terceros…
- Resumen semanal de cambios técnicos para equipos de producto…
- Alertas de deprecación para tiendas con pagos y ERP conectados…

**Precio orientativo:** 60–150 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

### Qué hace y para quién
Descarga cada día una lista de URLs de changelogs, se queda con el texto, calcula una huella y compara con la del día anterior; si cambia, te manda por correo un resumen en castellano de lo que ha cambiado.
Para quien mantiene integraciones y no puede leer diez blogs técnicos a la semana.

### Lo que necesitas antes
- n8n.
- Hoja de Google Sheets «Fuentes» con columnas: `nombre`, `url`, `hash`, `ultimo_cambio`.
- Opcional pero recomendable: clave de API de OpenAI (platform.openai.com → API keys) para el resumen. Sin ella el correo llega con el fragmento crudo.
- Gmail con credencial OAuth2 en n8n.

### Los nodos, en orden
1. **Schedule Trigger** — `Every Day`, hora `8`, timezone `Europe/Madrid`.
2. **Google Sheets** — Operation `Get Row(s)` de la hoja «Fuentes».
3. **Split In Batches** — Batch Size `1` (así el resto del bucle es sencillo).
4. **HTTP Request** (nombre: «Bajar página») — `GET {{ $json.url }}`, Response Format `String`, header `User-Agent: Mozilla/5.0 (compatible; n8n)`. Settings: `Continue On Fail`, `Retry On Fail` 2 intentos.
5. **Code** (nombre: «Huella y extracto») — limpia el HTML, calcula un hash y guarda los primeros párrafos.
6. **IF** — Condition: String `{{ $json.hash }}` `not equals` `{{ $('Split In Batches').item.json.hash }}`.
7. **OpenAI** (rama true) — Resource `Text`, Operation `Message`, Model `gpt-4o-mini`, prompt: «Eres un ingeniero. Resume en 4 viñetas en español de España qué ha cambiado en este changelog y marca si algo rompe compatibilidad: {{ $json.extracto }}».
8. **Gmail** — Operation `Send`, Subject `Cambio en {{ $('Split In Batches').item.json.nombre }}`, cuerpo con el resumen y el enlace.
9. **Google Sheets** — Operation `Update Row`, actualiza `hash` y `ultimo_cambio` usando `nombre` como columna clave.
10. Reconecta la salida al **Split In Batches** para seguir con la fuente siguiente.

### El código del nodo «Huella y extracto»
```javascript
const crypto = require('crypto');
const html = String($input.first().json.data || '');
const texto = html
  .replace(/<script[\s\S]*?<\/script>/gi, ' ')
  .replace(/<style[\s\S]*?<\/style>/gi, ' ')
  .replace(/<[^>]+>/g, ' ')
  .replace(/&nbsp;/g, ' ')
  .replace(/\s+/g, ' ')
  .trim();
const recorte = texto.slice(0, 4000);
const hash = crypto.createHash('sha256').update(recorte).digest('hex').slice(0, 16);
return [{ json: { hash, extracto: recorte.slice(0, 2500) } }];
```

### Cómo probarla
- Empieza con dos fuentes: `https://docs.stripe.com/changelog` y el changelog de la API que más te preocupe.
- Ejecuta a mano dos veces seguidas: la primera guarda el hash, la segunda no debe mandar nada.
- Borra a mano el hash de una fila y vuelve a ejecutar: tiene que llegarte el correo con el resumen.

### Qué puede salir mal
- **Páginas que cambian solas** (fecha, contador de visitas, banner rotatorio): recortar a los primeros 4.000 caracteres ayuda, pero si sigue dando falsos positivos, filtra por una sección concreta con una expresión regular en el Code.
- **Webs que exigen JavaScript**: si el HTML llega casi vacío, busca la versión RSS o Atom del changelog; casi todos la tienen.
- **403 por bloqueo de bots**: cambia el `User-Agent` y baja la frecuencia a día alterno.
- **Coste del resumen**: `gpt-4o-mini` con 2.500 caracteres cuesta céntimos al mes; si quieres 0 €, quita el nodo OpenAI y manda el extracto tal cual.
- **Zona horaria**: si comparas con una web americana, sus cambios aparecen de madrugada hora española; ejecutar a las 8 va bien.

### Cuánto cuesta
- n8n auto-alojado y Google Sheets: 0 €.
- OpenAI: con 10 fuentes vigiladas y pocos cambios reales al mes, menos de 1 €/mes. Se puede quitar del todo.
- Gmail gratuito soporta de sobra este volumen de correos.
