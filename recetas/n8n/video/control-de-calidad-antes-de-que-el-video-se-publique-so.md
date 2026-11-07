# Control de calidad antes de que el vídeo se publique so…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Revisa los vídeos que tienes programados en YouTube y te avisa si a alguno le falta miniatura, tarjeta final, tags, capítulos o tiene enlaces rotos en la descripción.

## Qué es y qué hace

Cada mañana lista tus vídeos programados o privados con fecha cercana y les pasa una lista de comprobación: miniatura personalizada, etiquetas, descripción de más de 200 caracteres, capítulos y enlaces que responden. Entra la API de YouTube con OAuth y tus criterios; sale un aviso solo si algo falla. Útil para canales que programan con antelación o trabajan varias personas.

## Cómo usarla

1. Configura YouTube OAuth en n8n
2. Escribe tus criterios de comprobación
3. Define la hora del aviso diario
4. Prueba con un vídeo privado que falle a propósito

## Cuándo usarla

Úsalo cuando programas vídeos con días de antelación y ya te ha pasado publicar uno con la miniatura por defecto o un enlace de afiliado caducado.

## Cómo ganar dinero con ella

Un vídeo publicado sin miniatura pierde la mitad de sus clics. Este chequeo cuesta cero y evita el error que más caro sale.

- Revisión técnica de vídeos programados para equipos de contenido de marcas…
- Checklist de publicación para creadores que delegan la subida en un editor…
- Auditoría de metadatos para canales con cientos de vídeos…

**Precio orientativo:** 30–90 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada mañana lista tus vídeos en estado «programado» o «privado» con fecha de publicación cercana y pasa una lista de comprobación técnica sobre cada uno, avisándote solo si falla algo. Para canales que programan con antelación y equipos donde sube el contenido más de una persona.

## Lo que necesitas antes
- Credencial **YouTube OAuth2 API** en n8n (necesitas OAuth, no basta la API key, porque los privados solo los ve el propietario).
- Bot de Telegram o tu correo.
- Tu lista de criterios: miniatura personalizada, mínimo 5 tags, descripción de más de 200 caracteres, al menos 3 capítulos, todos los enlaces respondiendo 200.

## Los nodos, en orden
1. **Schedule Trigger** — cada día a las 08:00, Europe/Madrid.
2. **HTTP Request** — GET https://www.googleapis.com/youtube/v3/search?part=snippet&forMine=true&type=video&maxResults=20&order=date, credencial YouTube OAuth2.
3. **HTTP Request** — GET .../youtube/v3/videos?part=snippet,status,contentDetails&id={{ ids separados por coma }}.
4. **Code** — filtra los que tengan `status.privacyStatus` privado o `publishAt` en los próximos 7 días, y aplica la lista de comprobación.
5. **Item Lists** o **Code** — saca cada URL encontrada en la descripción como item propio.
6. **HTTP Request** — HEAD a cada URL, con «Continue On Fail» activado y «Never Error» en Settings, para comprobar que responde.
7. **Code** — junta los fallos de formato y los enlaces rotos en un solo informe por vídeo.
8. **IF** — solo sigue si hay fallos.
9. **Telegram** (Send Message) — mensaje con emoji de aviso, título del vídeo, fecha de publicación y la lista de lo que falta.

## El código del nodo 4
```js
const out = [];
for (const it of $input.all()) {
  const v = it.json;
  const s = v.snippet, st = v.status;
  const fallos = [];
  if (!s.thumbnails || !s.thumbnails.maxres) fallos.push('sin miniatura personalizada en alta resolución');
  if (!s.tags || s.tags.length < 5) fallos.push('menos de 5 tags');
  if ((s.description || '').length < 200) fallos.push('descripción muy corta');
  const caps = (s.description || '').match(/^\d{1,2}:\d{2}/gm) || [];
  if (caps.length < 3) fallos.push('sin capítulos');
  if (!/00:00/.test(s.description || '')) fallos.push('los capítulos no empiezan en 00:00');
  const urls = (s.description || '').match(/https?:\/\/[^\s)]+/g) || [];
  if (fallos.length || urls.length) out.push({ json: { videoId: v.id, titulo: s.title, publishAt: st.publishAt, fallos, urls } });
}
return out;
```

## Cómo probarla
Sube un vídeo de prueba en privado, sin miniatura y sin tags, y lanza el workflow: debe cazarte los dos fallos. Luego arréglalo y vuelve a lanzar: no debe avisar. Mete un enlace inventado en la descripción para probar el paso 6.

## Qué puede salir mal
- **maxres no existe siempre**: YouTube tarda en generar la miniatura maxres. Comprueba mejor `thumbnails.high` contra el patrón de miniatura por defecto, o baja la exigencia.
- **HEAD bloqueado**: algunas webs rechazan HEAD. Cambia a GET con «Timeout» de 5 segundos.
- **search con forMine**: cuesta 100 unidades de cuota; una vez al día no molesta.
- **Falsos avisos con Shorts**: los Shorts no llevan capítulos. Filtra por duración menor de 70 segundos en contentDetails.

## Cuánto cuesta
Cero euros con n8n autoalojado (n8n Cloud solo tiene una prueba gratuita temporal y después es de pago); la API de YouTube y Telegram en su capa gratuita lo cubren de sobra.
