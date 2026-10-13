# Capítulos automáticos escritos en la descripción de You…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Genera los capítulos con marcas de tiempo a partir de la transcripción del vídeo y los escribe solo en la descripción, sin que toques YouTube Studio.

## Qué es y qué hace

Toma la transcripción automática de un vídeo ya publicado en YouTube, pide a una IA de texto una lista de capítulos con formato mm:ss y añade esa lista al principio de la descripción mediante la API. Entrada: ID del vídeo; salida: descripción actualizada con capítulos. Se monta en n8n con el nodo de IA que prefieras, y el coste ronda los céntimos por vídeo. Sirve para canales de formación, entrevistas o tutoriales largos.

## Cómo usarla

1. Conecta YouTube con OAuth y permiso de escritura
2. Elige tu modelo (Claude, Codex, Gemini o una IA local)
3. Prueba con un vídeo antes del lote
4. Revisa los capítulos generados

## Cuándo usarla

Cuando publicas vídeos de más de 8 minutos y los capítulos se te quedan siempre pendientes, perdiendo retención y posiciones en la búsqueda de YouTube.

## Cómo ganar dinero con ella

Diez minutos menos por vídeo y capítulos en todos, no solo en los que te apetece. Coste por vídeo: unos 0,02 € de IA.

- Optimización de vídeos largos para canales de formación: capítulos y descripciones en lote.
- Paquete mensual para creadores que publican entrevistas o tutoriales de más de 8 minutos.
- Entrega única de capítulos para los 100 vídeos antiguos de un canal.

**Precio orientativo:** 60–200 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Coge la transcripción automática de un vídeo tuyo ya publicado, pide a la IA una lista de capítulos con formato mm:ss y actualiza la descripción del vídeo añadiéndolos al principio. Es para canales de formación, entrevistas o tutoriales largos.

## Lo que necesitas antes
- n8n con credencial «YouTube OAuth2 API» y permisos `youtube.force-ssl` (hace falta para escribir en el vídeo) y `youtube.readonly`.
- Clave de API de OpenAI.
- Una hoja «Capítulos» con columnas: videoId, titulo, estado, capitulos.
- Importante: la API de YouTube **no** te da la transcripción. Descarga el SRT desde YouTube Studio > Subtítulos > Descargar, o usa el flujo de Whisper de otra receta. Aquí partimos de que pegas el texto del SRT en la columna «transcripcion» de la hoja.

## Los nodos, en orden
1. **Google Sheets Trigger** — evento Row Added, hoja «Capítulos», poll cada 5 minutos. Añades una fila con videoId, título y transcripción y arranca solo.
2. **IF** — comprueba que `{{ $json.estado }}` equals `pendiente`.
3. **Code** («Limpiar SRT») — convierte el SRT en líneas «segundos: texto».
4. **HTTP Request** («Pedir capítulos») — POST a `https://api.openai.com/v1/chat/completions`. Header Auth `Authorization: Bearer TU_CLAVE`. Body JSON: modelo `gpt-4o-mini`, temperatura 0.3, y este mensaje: «A partir de esta transcripción con segundos, devuelve entre 5 y 10 capítulos de YouTube. Reglas: el primero siempre 00:00, mínimo 10 segundos entre capítulos, formato exacto `mm:ss Título corto` (o `h:mm:ss` si pasa de la hora), una línea por capítulo, sin numerar y sin texto extra. Transcripción: {{ $json.texto }}».
5. **HTTP Request** («Leer vídeo») — GET `https://www.googleapis.com/youtube/v3/videos` con `part=snippet`, `id={{ $('Google Sheets Trigger').item.json.videoId }}`, credencial YouTube OAuth2.
6. **Code** («Montar snippet») — junta capítulos + descripción antigua y reconstruye el snippet **completo**.
7. **HTTP Request** («Actualizar vídeo») — PUT a `https://www.googleapis.com/youtube/v3/videos?part=snippet`, credencial YouTube OAuth2, Body Content Type JSON con `{{ JSON.stringify($json.body) }}` en modo Raw.
8. **Google Sheets** — Update de la fila: estado = `hecho`, capitulos = el texto generado.

## El código de «Limpiar SRT»
```js
const srt = items[0].json.transcripcion || '';
const bloques = srt.split(/\n\s*\n/);
let texto = '';
for (const b of bloques) {
  const m = b.match(/(\d{2}):(\d{2}):(\d{2})[,.]\d+\s*-->/);
  if (!m) continue;
  const seg = (+m[1]) * 3600 + (+m[2]) * 60 + (+m[3]);
  const frase = b.split('\n').slice(2).join(' ').trim();
  if (frase) texto += `[${seg}] ${frase}\n`;
}
return [{ json: { texto: texto.slice(0, 60000) } }];
```

## El código de «Montar snippet»
```js
const v = items[0].json.items[0];
const caps = $('Pedir capítulos').first().json.choices[0].message.content.trim();
if (!/^0?0:00/.test(caps)) throw new Error('El primer capítulo no es 00:00');
const desc = v.snippet.description || '';
const limpia = desc.replace(/^CAPÍTULOS[\s\S]*?\n\n/, '');
const nueva = `CAPÍTULOS\n${caps}\n\n${limpia}`;
return [{ json: { body: {
  id: v.id,
  snippet: {
    title: v.snippet.title,
    description: nueva.slice(0, 4900),
    categoryId: v.snippet.categoryId,
    tags: v.snippet.tags || [],
    defaultLanguage: v.snippet.defaultLanguage || 'es'
  }
}}}];
```

## Cómo probarla
- Prueba primero con un vídeo tuyo puesto en **oculto**. Ejecuta el flujo y mira la descripción en YouTube Studio.
- Comprueba que el reproductor pinta la barra por segmentos: si no aparece, casi siempre es porque falta el 00:00 o hay menos de tres capítulos.
- Copia la descripción original a un bloc de notas antes de la primera prueba, por si acaso.

## Qué puede salir mal
- **Te borra el título o la categoría**: la API sustituye el snippet entero. Si mandas solo `description`, pierdes lo demás. Por eso el código reenvía title, categoryId y tags.
- **La IA se inventa minutos**: pásale la transcripción con los segundos delante (lo hace el paso 3) y temperatura baja.
- **Descripción de más de 5.000 caracteres**: el error es 400 invalidValue. El código recorta a 4.900.
- **Error 403 forbidden**: falta el permiso `youtube.force-ssl`; recrea la credencial.
- **Ejecutarlo dos veces**: el `replace` del bloque CAPÍTULOS evita que se acumulen.

## Cuánto cuesta
Gratis salvo la IA: gpt-4o-mini sale por menos de 0,02 € por vídeo largo. La API de YouTube no cobra (un update gasta 50 unidades de 10.000 diarias, así que puedes actualizar hasta 200 vídeos al día).
