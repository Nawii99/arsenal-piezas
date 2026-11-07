# Un vídeo largo convertido en 8 piezas para redes…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Coge la transcripción de tu último vídeo de YouTube y la IA te devuelve hilo, carrusel, newsletter, 3 ganchos de Shorts y descripción, todo en una hoja de cálculo.

## Qué es y qué hace

Coge la transcripción automática de tu último vídeo de YouTube y la envía a un modelo de IA que devuelve ocho piezas: hilo, texto para LinkedIn, guion de carrusel, tres ganchos para Shorts, newsletter corta y descripción optimizada. Entran la transcripción y el ID del canal; sale una fila por pieza en Sheets y un aviso por correo. Puede usar Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Elige y configura tu modelo de IA en n8n
2. Pega el ID de canal y la hoja de salida
3. Prueba con un vídeo ya publicado
4. Revisa el tono antes de programar las piezas

## Cuándo usarla

Cuando grabas vídeos largos o podcast y no te da la vida para sacar contenido de redes de cada uno, y notas que el vídeo muere el día que lo publicas.

## Cómo ganar dinero con ella

Sustituye 2-3 horas de redactar de cada vídeo. A 30 €/hora son 60-90 € por vídeo, y el coste de IA es de unos 0,10 €.

- Reaprovechamiento de vídeos de formación para empresas en piezas de redes y newsletter…
- Pack mensual de contenido derivado para creadores que graban vídeo largo…
- Servicio de repurposing para podcasters, con entrega semanal de piezas revisadas…

**Precio orientativo:** 50–150 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Cada vez que publicas un vídeo en YouTube, el flujo coge su transcripción automática, se la pasa a la IA y genera 8 piezas de contenido derivadas (hilo de X, texto de LinkedIn, guion de carrusel, 3 ganchos para Shorts, newsletter corta y descripción optimizada). Lo deja todo en una hoja de Google Sheets y te avisa por correo. Para creadores, podcasters, formadores y negocios que ya hacen vídeo largo.

## Lo que necesitas antes
- n8n.
- Tu ID de canal de YouTube: entra en tu canal, en «Configuración → Configuración avanzada» aparece el «ID de canal» (empieza por `UC`).
- Clave de API de OpenAI (platform.openai.com → API keys) con saldo.
- Cuenta gratuita de Apify (apify.com) para sacar la transcripción: perfil → «Integrations» → copia tu API token. Usarás el actor `pintostudio~youtube-transcript-scraper`.
- Una hoja de Sheets `Reutilizar contenido` con columnas: `fecha`, `video`, `url`, `pieza`, `texto`, `usado`.

## Los nodos, en orden
1. **RSS Feed Trigger** — Feed URL: `https://www.youtube.com/feeds/videos.xml?channel_id=TU_ID_DE_CANAL`. Poll Times: cada hora. n8n ya evita repetir elementos ya vistos.
2. **HTTP Request** (transcripción) — Method: POST. URL: `https://api.apify.com/v2/acts/pintostudio~youtube-transcript-scraper/run-sync-get-dataset-items`. Authentication: Generic Credential Type > Query Auth, con una credencial de n8n (Name `token`, Value tu API token de Apify). No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él. Body JSON: `{"videoUrl":"{{ $json.link }}"}`. Timeout en Options: 120000.
3. **Code** — Junta todos los trozos de la transcripción en un texto único y lo recorta a 40.000 caracteres.
4. **OpenAI** — Resource: `Text`, Operation: `Message a Model`. Model: `gpt-4.1-mini`. Añade dos mensajes. System: `Eres un estratega de contenidos español. Escribes en español de España, tuteando, sin emojis, sin palabras de relleno. Devuelves SOLO JSON válido.` User: el prompt de abajo. En Options activa **Output Content as JSON**.
5. **Code1** — Convierte el JSON de la IA en una fila por pieza (8 items).
6. **Google Sheets** — Operation: `Append`. Mapea `fecha`, `video`, `url`, `pieza` y `texto`. Columna `usado` la dejas vacía para marcarla tú a mano.
7. **Gmail** — Send. Asunto: `8 piezas listas de: {{ $('RSS Feed Trigger').item.json.title }}`. Cuerpo con el enlace a la hoja.

## El prompt del nodo OpenAI (mensaje User)
```
Aquí tienes la transcripción de un vídeo titulado "{{ $('RSS Feed Trigger').item.json.title }}":

{{ $json.transcripcion }}

Devuelve un JSON con esta forma exacta: {"piezas":[{"tipo":"hilo_x","texto":"..."},{"tipo":"linkedin","texto":"..."},{"tipo":"carrusel","texto":"..."},{"tipo":"gancho_short_1","texto":"..."},{"tipo":"gancho_short_2","texto":"..."},{"tipo":"gancho_short_3","texto":"..."},{"tipo":"newsletter","texto":"..."},{"tipo":"descripcion_youtube","texto":"..."}]}
Reglas: el hilo, 6 tuits separados por saltos de línea. LinkedIn, 180 palabras con una idea fuerte al principio. Carrusel, 8 diapositivas numeradas. Cada gancho de Short, máximo 2 frases y un momento concreto del vídeo. Newsletter, 200 palabras. Descripción, 3 párrafos más 5 hashtags. Usa SOLO ideas que estén en la transcripción, no inventes datos ni cifras.
```

## El código del nodo Code (paso 3)
```javascript
const items = $input.all();
let texto = items.map(i => i.json.text || i.json.transcript || '').join(' ');
if (Array.isArray(items[0].json.data)) {
  texto = items[0].json.data.map(t => t.text).join(' ');
}
texto = texto.replace(/\s+/g, ' ').trim().slice(0, 40000);
if (texto.length < 200) { throw new Error('Sin transcripción: el vídeo puede no tener subtítulos automáticos todavía.'); }
return { json: { transcripcion: texto } };
```

## El código del nodo Code1 (paso 5)
```javascript
const datos = $json.message?.content || $json;
const piezas = (typeof datos === 'string' ? JSON.parse(datos) : datos).piezas;
const video = $('RSS Feed Trigger').first().json;
return piezas.map(p => ({ json: {
  fecha: new Date().toISOString().slice(0, 10),
  video: video.title,
  url: video.link,
  pieza: p.tipo,
  texto: p.texto
}}));
```

## Cómo probarla
1. Pega a mano en el nodo 2 la URL de un vídeo tuyo ya publicado y ejecuta desde ahí.
2. Revisa que la transcripción tiene sentido: si sale vacía, ese vídeo no tiene subtítulos automáticos aún (tardan de 10 a 60 minutos tras publicar).
3. Lee las 8 piezas. Si suenan a robot, endurece las reglas del prompt con ejemplos de tu forma de escribir.

## Qué puede salir mal
- **El vídeo aún no tiene transcripción**: mete un nodo **Wait** de 3600 segundos justo después del trigger.
- **La IA se inventa datos**: la regla «usa SOLO ideas de la transcripción» ayuda, pero revisa siempre cifras y nombres antes de publicar.
- **JSON roto**: si el nodo Code1 falla, activa «Output Content as JSON» en el nodo OpenAI y baja la temperatura a 0,4.
- **Vídeos de más de 2 horas**: pasan del límite de contexto. El recorte a 40.000 caracteres lo evita, pero pierdes el final; en ese caso divide en dos llamadas.
- **RSS de YouTube solo trae los 15 últimos vídeos**: no sirve para procesar el archivo antiguo, para eso ejecútalo a mano.

## Cuánto cuesta
Unos 0,08-0,15 € de OpenAI por vídeo con `gpt-4.1-mini`. Apify da 5 $ de crédito gratis al mes, suficiente para cientos de transcripciones. Sheets y Gmail, gratis. n8n autoalojado, gratis (n8n Cloud solo tiene una prueba gratuita temporal y después es de pago).
