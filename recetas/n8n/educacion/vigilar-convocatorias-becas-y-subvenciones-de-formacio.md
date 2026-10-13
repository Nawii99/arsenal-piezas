# Vigilar convocatorias, becas y subvenciones de formació…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Rastrea cada día las webs y boletines oficiales que te interesan, detecta convocatorias nuevas de formación o becas, las resume y te avisa con el plazo.

## Qué es y qué hace

Flujo de n8n que cada día consulta las fuentes oficiales que indiques, como el sumario del BOE o boletines autonómicos, detecta convocatorias nuevas de formación o becas y las resume con un modelo de IA con su plazo. Entra la lista de fuentes y palabras clave; sale un resumen diario con las convocatorias encontradas.

## Cómo usarla

1. Lista las fuentes oficiales con API o RSS
2. Define palabras clave de formación y becas
3. Conecta el resumen con Claude, Codex, Gemini o una IA local
4. Que lo revise un profesional (requisitos y plazos legales)

## Cuándo usarla

Cuando vives de formación bonificada, subvenciones o becas y siempre te enteras tarde de las convocatorias.

## Cómo ganar dinero con ella

Una sola convocatoria pillada a tiempo puede valer miles de euros. Sustituye media hora diaria de revisar webs oficiales.

- Vigilancia de subvenciones para centros de formación que viven de la formación bonificada.
- Búsqueda de becas y ayudas para academias y formadores autónomos que quieren crecer.
- Boletín de convocatorias para gestorías que tramitan ayudas para sus clientes.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Consulta a diario las fuentes que le indiques (BOE, boletín de tu comunidad, la web de la Fundae, portales de becas y ayudas), detecta lo que no habías visto, filtra lo que tiene que ver con formación y te manda un resumen con el plazo de solicitud.
Es para academias, centros de formación, formadores autónomos y orientadores que trabajan con ayudas públicas.

## Lo que necesitas antes
n8n.
La lista de fuentes. Muchas tienen API o RSS abierto: el BOE ofrece el sumario diario en `https://www.boe.es/datosabiertos/api/boe/sumario/AAAAMMDD` en JSON, y casi todos los boletines autonómicos publican RSS.
Hoja «Convocatorias» con: fecha_deteccion, fuente, titulo, resumen, plazo, enlace, relevancia, avisado.
API key de OpenAI para el filtrado y el resumen.
Bot de Telegram (@BotFather) y tu chat_id (escribe al bot y consulta `https://api.telegram.org/botTU_TOKEN/getUpdates`).

## Los nodos, en orden
**1. Schedule Trigger**. Cron: `0 8 * * 1-5` (de lunes a viernes a las 8:00).
**2. Set** «Fuentes». Crea un array con las URLs a consultar. Alternativa más ordenada: una hoja «Fuentes» con nombre, tipo (json, rss, html) y url, y un **Google Sheets** que la lea.
**3. Loop Over Items** (Split In Batches). Tamaño 1, para consultar las fuentes una a una y no saturar.
**4. HTTP Request**. Method: GET, URL: `{{ $json.url }}`. En Options activa «Response > Never Error» para que una fuente caída no tumbe el flujo, y pon un User-Agent normal en Headers.
**5. Switch** por tipo de fuente. Para RSS usa el nodo **RSS Read** en lugar del HTTP. Para HTML, un nodo **HTML** con operación «Extract HTML Content» y un selector CSS de los títulos (lo sacas con clic derecho > Inspeccionar en la web).
**6. Code** «Normalizar y quedarse con lo nuevo». Deja cada resultado como titulo, enlace y texto, y calcula un hash para identificarlo (código abajo).
**7. Google Sheets** «Ya vistos». Get Row(s) de «Convocatorias» para comparar hashes.
**8. Filter**. Solo pasan los hashes que no están en la hoja.
**9. OpenAI** «Message a Model». Model: `gpt-4o-mini`. Sistema: «Eres el ayudante de un centro de formación. Dado el título y el texto de una publicación oficial, responde con un JSON: relevante (true/false, true solo si trata de ayudas, becas, subvenciones, convocatorias o normativa de formación, empleo o educación), resumen (máximo 40 palabras, español llano), plazo (la fecha límite si aparece, o 'no indicado'), a_quien (a quién va dirigida). No inventes fechas.» Usuario: el título más los primeros 3.000 caracteres del texto.
**10. Filter**. Condición: `{{ $json.relevante }}` es true.
**11. Google Sheets** «Guardar». Append Row con todos los campos y `avisado` = `si`.
**12. Telegram** «Avisar». Send Message a tu chat_id con formato: título en negrita, resumen, a quién va dirigida, plazo y enlace. Usa Parse Mode `HTML`.
**13. Schedule Trigger** aparte, cron `0 9 * * 1`: lee la hoja y te manda por Telegram las convocatorias cuyo plazo vence en los próximos 7 días. Este es el aviso que de verdad evita perder oportunidades.

## El trozo de código
Nodo **Code** número 6, modo «Run Once for All Items»:
```javascript
const crypto = require('crypto');
const fuente = $('Fuentes').first().json.nombre || 'fuente';
const salida = [];
for (const item of $input.all()) {
  const j = item.json;
  const titulo = (j.titulo || j.title || '').trim();
  if (!titulo) continue;
  const enlace = j.enlace || j.link || j.url || '';
  const texto = (j.texto || j.contentSnippet || j.description || '').slice(0, 3000);
  const hash = crypto.createHash('md5').update(titulo + enlace).digest('hex').slice(0, 12);
  salida.push({ json: { hash, fuente, titulo, enlace, texto, fecha_deteccion: new Date().toISOString().slice(0, 10) } });
}
return salida;
```

## Cómo probarla
Empieza con una sola fuente, la que más te interese, y ejecuta el flujo a mano. Mira lo que devuelve el HTTP Request antes de conectar la IA.
Deja el filtro de relevancia desactivado el primer día y revisa a mano qué habría descartado: así calibras el prompt.
Comprueba el aviso de plazos metiendo a mano una fila con plazo dentro de 3 días.

## Qué puede salir mal
Las webs oficiales cambian el HTML sin avisar y el selector CSS deja de funcionar. Añade un **IF** que, si una fuente devuelve 0 resultados dos días seguidos, te avise por Telegram.
Algunas sedes bloquean peticiones automáticas: usa las APIs y los RSS oficiales siempre que existan, que además son estables.
El sumario del BOE es enorme; filtra por secciones (III Otras disposiciones, V Anuncios) antes de pasarlo a la IA o te costará dinero de más.
Los plazos que extrae la IA pueden estar mal: el aviso siempre incluye el enlace, y la decisión de presentarte se toma leyendo el original.
Telegram limita a 30 mensajes por segundo; con un **Wait** de 1 segundo entre avisos vas sobrado.

## Cuánto cuesta
n8n auto-alojado, Telegram y Sheets: 0 €.
OpenAI: unos 0,001 € por publicación analizada. Filtrando bien antes, 20-40 publicaciones al día salen por 1-2 € al mes.
Si quieres coste cero, sustituye la IA por un filtro de palabras clave en el nodo Code (formación, beca, subvención, ayuda, curso, empleo) y acepta más ruido.
