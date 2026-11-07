# Detector de reuploads y robos de tus vídeos…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Busca cada semana en YouTube los títulos de tus vídeos y te avisa si aparecen subidos por otro canal, para que puedas reclamar antes de que acumulen visitas.

## Qué es y qué hace

Recibe la lista de títulos de tus vídeos desde una hoja de Google Sheets, los busca cada semana con la API de YouTube y devuelve una hoja «Sospechas» con los vídeos de otros canales que copian el título, con su URL y sus visitas. Entrada: títulos y Channel ID; salida: hoja y email. Se monta en n8n con una clave de API guardada en una credencial de n8n, sin OAuth. Ejemplo: un tutorial tuyo aparece en un canal ajeno con 20.000 visitas y recibes el aviso el miércoles.

## Cómo usarla

1. Crea la clave de API de YouTube Data v3 y guárdala en una credencial de n8n
2. Rellena la hoja Vigilancia con tus títulos
3. Activa el aviso semanal de los miércoles
4. Que lo revise un profesional

## Cuándo usarla

Cuando tu contenido tiene valor (formación, casos, tutoriales) y ya has visto o temes que alguien lo reutilice sin permiso en su propio canal.

## Cómo ganar dinero con ella

Evita que un canal ajeno se lleve miles de visitas tuyas. Una reclamación a tiempo vale más que el rastreo manual, que nadie hace nunca.

- Vigilancia de copias de contenido para academias que venden cursos grabados en YouTube.
- Servicio mensual para creadores con revisión semanal de reuploads y borrador de reclamaciones.
- Auditoría única de un canal para detectar contenido copiado y las visitas que se pierden.

**Precio orientativo:** 25–60 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Toma la lista de tus vídeos, busca su título en YouTube y te avisa por email si aparece un vídeo con título muy parecido en un canal que no es el tuyo. Es para creadores, academias y negocios cuyo contenido se copia con facilidad.

## Lo que necesitas antes
- n8n (Cloud con su prueba gratuita temporal, o auto-alojado gratis).
- Proyecto en Google Cloud con **YouTube Data API v3** activada y una **clave de API** simple (APIs y servicios > Credenciales > Crear credenciales > Clave de API), que guardarás solo en una credencial de n8n. Aquí no hace falta OAuth porque solo consultas datos públicos.
- Tu Channel ID.
- Hoja de Google Sheets «Vigilancia» con dos pestañas: «Titulos» (columnas: videoId, titulo) y «Sospechas» (columnas: fecha, mi_titulo, canal_sospechoso, titulo_encontrado, url, visitas).

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 7 * * 3`, miércoles a las 7:00, zona Europe/Madrid.
2. **Google Sheets** — operación Get Row(s) sobre la pestaña «Titulos». Ahí tienes hasta 40 títulos (los que más te importa proteger).
3. **Split In Batches** — Batch Size 1, para no disparar la cuota de golpe.
4. **HTTP Request** («Buscar copia») — GET `https://www.googleapis.com/youtube/v3/search` con `part=snippet`, `q={{ encodeURIComponent($json.titulo) }}`, `type=video`, `maxResults=10`. Authentication: Generic Credential Type > Query Auth con una credencial (Name `key`, Value tu clave de API); no escribas la clave en el nodo ni en la URL, porque un flujo exportado se llevaría la clave. Activa Retry On Fail.
5. **Code** («Filtrar sospechosos») — descarta tu propio canal y compara parecido de títulos.
6. **IF** — `{{ $json.sospechoso }}` is true.
7. **HTTP Request** («Visitas del sospechoso») — GET `https://www.googleapis.com/youtube/v3/videos` con `part=statistics`, `id={{ $json.videoIdEncontrado }}`, con la misma credencial Query Auth.
8. **Google Sheets** — Append a «Sospechas», pero antes usa Append or Update con la columna `url` como clave para no duplicar avisos semana tras semana.
9. **Gmail** — Send Message a tu correo con el listado, asunto «Posibles copias de tus vídeos».
10. **Wait** — 2 segundos, y de vuelta al Split In Batches para la siguiente búsqueda.

## El código de «Filtrar sospechosos»
```js
const MI_CANAL = 'UCxxxxxxxxxxxxxxxxxxxxxx';
const miTitulo = $('Split In Batches').first().json.titulo.toLowerCase();
const palabras = miTitulo.split(/\s+/).filter(p => p.length > 4);
const salida = [];
for (const it of items[0].json.items || []) {
  const t = it.snippet.title.toLowerCase();
  const aciertos = palabras.filter(p => t.includes(p)).length;
  const parecido = palabras.length ? aciertos / palabras.length : 0;
  if (it.snippet.channelId !== MI_CANAL && parecido >= 0.7) {
    salida.push({ json: {
      sospechoso: true,
      mi_titulo: miTitulo,
      canal_sospechoso: it.snippet.channelTitle,
      titulo_encontrado: it.snippet.title,
      videoIdEncontrado: it.id.videoId,
      url: 'https://youtu.be/' + it.id.videoId
    }});
  }
}
return salida.length ? salida : [{ json: { sospechoso: false } }];
```

## Cómo probarla
- Mete en la pestaña «Titulos» un título muy genérico (por ejemplo el de un vídeo de un tema muy tratado): deberían salir coincidencias falsas. Eso te confirma que la búsqueda funciona.
- Sube el umbral de `parecido` a 0.8 si te llegan demasiados falsos positivos; bájalo a 0.6 si sospechas que se te escapan copias con título retocado.
- Revisa a mano las tres primeras sospechas antes de reclamar nada.

## Qué puede salir mal
- **Cuota**: cada búsqueda gasta 100 unidades de 10.000 diarias, así que el máximo real son 100 títulos al día. Con 40 títulos semanales vas holgado.
- **Falsos positivos** con títulos genéricos tipo «Cómo hacer una factura»: protege solo los títulos distintivos.
- **Vídeos privados o ya retirados**: el paso 7 devolverá `items: []`; activa Always Output Data para que no rompa el flujo.
- **Avisos repetidos**: usa Append or Update con la URL como clave, si no cada miércoles te llega lo mismo.
- Ojo: esto detecta, no reclama. La reclamación se hace en el formulario de retirada por copyright de YouTube, a mano.

## Cuánto cuesta
Cero euros: la clave de API de YouTube es gratuita (solo tiene cuota), Sheets y Gmail son gratis y n8n auto-alojado también. Solo pagarías n8n Cloud si quieres olvidarte del servidor.
