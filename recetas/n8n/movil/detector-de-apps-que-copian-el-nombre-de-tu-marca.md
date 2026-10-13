# Detector de apps que copian el nombre de tu marca…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Busca a diario en las tiendas apps con nombre parecido al tuyo y te avisa de posibles copias o suplantaciones antes de que te roben instalaciones.

## Qué es y qué hace

Receta de n8n que busca cada día tu nombre de marca en la App Store y, opcionalmente, en Google Play. Compara cada resultado con tu app por nombre parecido y por desarrollador, y avisa por Telegram cuando aparece una posible copia o suplantación, con enlace y datos para denunciar. Entrada: nombre de marca, trackId y nombre exacto del desarrollador. Salida: alertas y registro en una hoja. No constituye asesoramiento legal.

## Cómo usarla

1. Anota tu trackId y el nombre del desarrollador
2. Define la lista de palabras de marca
3. Revisa las alertas y denuncia por el formulario de la tienda
4. Que lo revise un profesional

## Cuándo usarla

Cuando tu app empieza a funcionar y aparecen clones o falsas versiones que confunden a tus usuarios y se llevan tus descargas y tu reputación.

## Cómo ganar dinero con ella

Un clon puede llevarse el 10-20% de tus búsquedas de marca. Denunciarlo pronto vale más que cualquier campaña, y aquí no pagas vigilancia de marca.

- Vigilancia de marca para una app de un comercio que empieza a crecer…
- Control de clones para un estudio que lanza apps con nombre propio…
- Registro de incidencias de suplantación para una marca registrada…

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada día busca tu nombre de marca en la App Store (y opcionalmente en Google Play) y compara cada resultado con tu app: si encuentra un nombre muy parecido o un desarrollador que no eres tú usando tu marca, te avisa con el enlace y los datos para denunciar. Para cualquier app con nombre propio que ya tenga algo de tracción.

## Lo que necesitas antes
- Tu nombre de marca, tu `trackId` de App Store y el nombre exacto de tu desarrollador (`artistName`) tal y como sale en la ficha.
- Hoja de Google Sheets `sospechosos` con: fecha, tienda, nombre, desarrollador, url, parecido, estado.
- Bot de Telegram con token y chat_id.
- Para Android, opcional: cuenta en SerpApi (plan gratuito de 100 búsquedas al mes) con el motor `google_play`, o hacer scraping directo asumiendo que se rompe de vez en cuando.
- Ten a mano los formularios de denuncia: en Apple, el «Content Dispute» de la App Store; en Google, el formulario de infracción de marca de Play. Guarda los enlaces en la propia hoja.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Days, Hour: 6.
2. **Code** (nombre: Términos a vigilar) — genera varias búsquedas: tu marca exacta, tu marca sin espacios, tu marca más «pro», «plus», «app», y errores tipográficos comunes (letras cambiadas).
3. **Split In Batches** — Batch Size: 1, con **Wait** de 2 segundos.
4. **HTTP Request** — GET `https://itunes.apple.com/search`, Query: `term` = `{{ $json.termino }}`, `country` = `es`, `entity` = `software`, `limit` = `25`.
5. **Code** (nombre: Comparar nombres) — calcula el parecido entre cada resultado y tu marca con distancia de Levenshtein y descarta tu propia app. Código abajo.
6. **Filter** — Number `{{ $json.parecido }}` «is larger than» 0.72.
7. **Google Sheets** — Get Row(s) de `sospechosos` filtrando por url, para no avisar dos veces del mismo.
8. **IF** — el resultado no está ya en la hoja.
9. **Google Sheets** — Append Row con todos los datos y estado `nuevo`.
10. **Telegram** — Send Message: `⚠️ Posible copia: {{$json.nombre}} de {{$json.desarrollador}} (parecido {{$json.parecido}})\n{{$json.url}}\nDenuncia: https://www.apple.com/legal/internet-services/itunes/appstorenotices/` más el enlace a la hoja.
11. Opcional Android, **HTTP Request** a `https://serpapi.com/search.json` con `engine=google_play`, `store=apps`, `q={{ $json.termino }}`, `gl=es`, `hl=es`, `api_key=TU_CLAVE`, y el mismo Code de comparación.

## El trozo de código (nodo Code «Comparar nombres»)
```javascript
const MI_MARCA = 'Tumarca';
const MI_TRACK_ID = 1234567890;
const MI_DEV = 'Tu Empresa SL';
function lev(a, b) {
  a = a.toLowerCase(); b = b.toLowerCase();
  const m = Array.from({ length: a.length + 1 }, (_, i) => [i, ...Array(b.length).fill(0)]);
  for (let j = 1; j <= b.length; j++) m[0][j] = j;
  for (let i = 1; i <= a.length; i++)
    for (let j = 1; j <= b.length; j++)
      m[i][j] = Math.min(m[i-1][j] + 1, m[i][j-1] + 1, m[i-1][j-1] + (a[i-1] === b[j-1] ? 0 : 1));
  return m[a.length][b.length];
}
const salida = [];
for (const r of ($input.first().json.results || [])) {
  if (r.trackId === MI_TRACK_ID) continue;
  const nombre = r.trackName || '';
  const dist = lev(MI_MARCA, nombre.split(/[:\-–]/)[0].trim());
  const parecido = 1 - dist / Math.max(MI_MARCA.length, nombre.length, 1);
  const usaMiMarca = nombre.toLowerCase().includes(MI_MARCA.toLowerCase());
  if (parecido > 0.6 || usaMiMarca) {
    salida.push({ json: {
      tienda: 'App Store',
      nombre,
      desarrollador: r.artistName,
      url: r.trackViewUrl,
      parecido: Number((usaMiMarca ? Math.max(parecido, 0.85) : parecido).toFixed(2)),
      mismoDev: r.artistName === MI_DEV,
      valoraciones: r.userRatingCount || 0
    }});
  }
}
return salida.filter(s => !s.json.mismoDev);
```

## Cómo probarla
- Ejecuta con tu marca: no debe salir tu propia app (si sale, revisa el trackId).
- Prueba con una marca muy conocida y genérica para ver cuántos falsos positivos salen y ajustar el umbral 0,72 arriba o abajo.
- Mete a mano en la hoja una url ya vista y comprueba que no vuelve a avisar.

## Qué puede salir mal
- **Falsos positivos** con marcas cortas o genéricas: si tu app se llama «Notas», esto te va a volver loco. Sube el umbral a 0,85 y confía más en la coincidencia literal del nombre.
- **Tu propia app en varias cuentas** (una empresa antigua, un cliente): mete todos tus `artistName` en una lista de exclusión.
- **SerpApi se agota**: 100 búsquedas gratis al mes se van en tres días si vigilas 5 términos. Vigila Android una vez por semana.
- **La denuncia es cosa tuya**: la automatización avisa, no reclama. Ten preparado un texto tipo y las capturas.
- **Cambios de país**: los clones suelen publicarse primero fuera de España. Duplica la llamada con `country=us` y `country=mx`.

## Cuánto cuesta
API de Apple gratis. Sheets y Telegram gratis. SerpApi: gratis 100 búsquedas al mes, luego desde 50 $/mes (evitable si vigilas solo iOS). n8n auto-alojado 0 €. Coste realista: 0 €.
