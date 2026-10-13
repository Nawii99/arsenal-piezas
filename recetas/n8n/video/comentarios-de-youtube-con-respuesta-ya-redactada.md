# Comentarios de YouTube con respuesta ya redactada…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Revisa los comentarios nuevos de tu canal, la IA separa preguntas de spam y elogios, y te manda un correo diario con un borrador de respuesta para cada pregunta.

## Qué es y qué hace

Cada mañana recoge los comentarios de las últimas 24 horas en tu canal, la IA los clasifica en pregunta, elogio, crítica o spam y redacta una respuesta para cada pregunta con tu tono. Entran la API de comentarios y tu ID de canal; sale un correo diario con borradores listos para copiar. Para canales con más de 500 suscriptores o negocios que atienden por YouTube. Puede usar Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Activa YouTube Data API v3 en Google Cloud
2. Pon tu ID de canal y la clave del modelo en n8n
3. Define tu tono en el prompt
4. Revisa los primeros borradores antes de responder

## Cuándo usarla

Cuando tu canal crece, no llegas a responder y sabes que responder rápido sube el alcance, o cuando quieres delegar la respuesta a alguien sin darle acceso al canal.

## Cómo ganar dinero con ella

Evita 30-45 minutos diarios de leer y redactar. Y responder en las primeras horas mejora la posición del vídeo, que vale más que el tiempo.

- Atención a comentarios de YouTube para negocios con borrador diario y aprobación humana…
- Gestión de comunidad para creadores que delegan la respuesta sin dar acceso al canal…
- Informe semanal de preguntas del público para ajustar el contenido…

**Precio orientativo:** 80–200 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Cada mañana busca todos los comentarios nuevos de las últimas 24 horas en tu canal, la IA los clasifica en pregunta, elogio, crítica o spam, y te envía un único correo con las preguntas y una respuesta ya escrita con tu tono, lista para copiar y pegar. Para canales con más de 500 suscriptores y para negocios que usan YouTube como canal de atención.

## Lo que necesitas antes
- n8n.
- Credencial de Google OAuth con **YouTube Data API v3** activada (console.cloud.google.com → APIs y servicios → Biblioteca).
- Tu ID de canal (empieza por `UC`), en la configuración avanzada de YouTube Studio.
- Clave de OpenAI con saldo.
- Hoja de Sheets `Comentarios` con columnas: `fecha`, `video`, `autor`, `comentario`, `tipo`, `borrador`, `respondido`.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: `Days`, hora 08:00. En Settings del workflow pon Timezone `Europe/Madrid`.
2. **HTTP Request** — Method: GET. URL: `https://www.googleapis.com/youtube/v3/commentThreads`. Authentication: Predefined Credential Type → Google OAuth2 API (con el scope `youtube.force-ssl`). Query Parameters: `part` = `snippet`, `allThreadsRelatedToChannelId` = `TU_ID_CANAL`, `maxResults` = `100`, `order` = `time`.
3. **Code** — Filtra los de las últimas 24 horas y aplana los campos que interesan.
4. **IF** — Condición Number: `{{ $items().length }}` mayor que 0. Si no hay comentarios, el flujo termina sin mandar correo.
5. **Split In Batches** — Batch Size: 10. Así no mandas 80 comentarios en una sola llamada.
6. **OpenAI** — Model `gpt-4.1-mini`. System: `Eres el community manager de un canal de YouTube español. Contestas tuteando, en 2-3 frases, cercano y útil, sin emojis y sin prometer nada que no se diga en el vídeo. Devuelves SOLO JSON.` User: el prompt de abajo. Activa Output Content as JSON.
7. **Code1** — Convierte la respuesta en una fila por comentario.
8. **Google Sheets** — Append con todas las columnas.
9. **Split In Batches** (conectar la salida «loop» de vuelta al nodo 6 para procesar el siguiente lote; la salida «done» sigue al 10).
10. **Code2** — Monta el HTML del correo agrupando solo los comentarios de tipo `pregunta` y `critica`.
11. **Gmail** — Send. Asunto: `{{ $json.total }} comentarios que merecen respuesta`. Message: `{{ $json.html }}`, con Email Type = `HTML`.

## El prompt del nodo OpenAI (User)
```
Clasifica y responde estos comentarios de mi canal. Devuelve JSON: {"resultados":[{"id":"...","tipo":"pregunta|elogio|critica|spam","borrador":"..."}]}. Si el tipo es elogio o spam, el borrador va vacío. Si es crítica, responde sin ponerte a la defensiva y ofrece una solución concreta.

{{ JSON.stringify($json.lote) }}
```

## El código del nodo Code (paso 3)
```javascript
const ahora = Date.now();
const limite = ahora - 24 * 60 * 60 * 1000;
const salida = [];
for (const item of $input.all()) {
  for (const hilo of (item.json.items || [])) {
    const c = hilo.snippet.topLevelComment.snippet;
    if (new Date(c.publishedAt).getTime() < limite) continue;
    salida.push({ json: {
      id: hilo.id,
      autor: c.authorDisplayName,
      comentario: c.textOriginal,
      video: c.videoId,
      fecha: c.publishedAt
    }});
  }
}
return salida;
```

## Cómo probarla
1. Ejecuta a mano el nodo 2 y mira que devuelve comentarios reales de tu canal.
2. Amplía temporalmente el filtro de 24 horas a 30 días en el Code para tener material con el que probar la IA.
3. Comprueba que los tipos están bien puestos: si te marca preguntas como elogios, añade dos ejemplos al prompt.
4. Deja el flujo una semana solo enviando borradores; solo si te fías, añade después un nodo YouTube con Operation `Reply` para responder solo.

## Qué puede salir mal
- **Cuota de la API**: listar comentarios cuesta 1 unidad por llamada de las 10.000 diarias. Sin problema salvo que lo pongas cada 5 minutos.
- **Comentarios ocultos por spam de YouTube**: no aparecen en la API, es normal.
- **Duplicados**: si el flujo se ejecuta dos veces el mismo día, repite comentarios. Antes del Append añade un nodo **Google Sheets** con Operation `Lookup` sobre el `id` y un **IF** que descarte los que ya existan.
- **Responder automático sin revisar** es la vía rápida a un ridículo público. Empieza siempre en modo borrador.
- **Zona horaria**: si el Timezone del workflow no está en `Europe/Madrid`, el corte de 24 horas se desplaza.

## Cuánto cuesta
Gratis salvo OpenAI: unos 0,02 € al día con 50 comentarios. En un mes, menos de 1 €. Todo lo demás entra en las cuotas gratuitas.
