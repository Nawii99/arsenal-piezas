# Subtítulos en tres idiomas subidos solos a YouTube…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Coge el SRT en español de un vídeo, lo traduce a inglés, francés y portugués respetando los tiempos, y sube cada pista de subtítulos al vídeo automáticamente.

## Qué es y qué hace

Toma el SRT en español de un vídeo, lo traduce a inglés, francés y portugués bloque a bloque conservando numeración y tiempos, y sube cada pista a YouTube con la API de subtítulos. Entran el SRT o el ID del vídeo y una clave de traducción como DeepL o un modelo de IA; sale una pista por idioma. Se monta con n8n para negocios que quieren alcance internacional.

## Cómo usarla

1. Consigue la clave de DeepL Free u otro traductor
2. Configura YouTube OAuth con force-ssl
3. Lanza el webhook con el ID del vídeo
4. Revisa una pista antes de subir las demás

## Cuándo usarla

Úsalo cuando tu contenido puede interesar fuera de España (formación, producto, turismo) y traducir a mano cada vídeo te frena.

## Cómo ganar dinero con ella

Un traductor de subtítulos cobra 3-6 € por minuto de vídeo. Esto lo deja en céntimos y abre tres mercados sin doblar.

- Subtitulado multilingüe de vídeos corporativos y de producto para empresas que venden fuera…
- Paquete de traducción de subtítulos para creadores con tarifa por vídeo…
- Localización de cursos online en tres idiomas con revisión humana incluida…

**Precio orientativo:** 15–40 € por vídeo. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Descarga la transcripción en español, la traduce bloque a bloque manteniendo la numeración y los tiempos del SRT, y usa `captions.insert` para dejar las tres pistas colgadas del vídeo. Para negocios y creadores que ya tienen contenido bueno y quieren alcance internacional sin volver a grabar.

## Lo que necesitas antes
- Credencial **YouTube OAuth2 API** con `youtube.force-ssl`.
- Cuenta gratis de DeepL API Free (500.000 caracteres al mes): deepl.com/pro-api → «Free» → copia la Authentication Key. Alternativa: tu clave de OpenAI.
- Carpeta de Drive «Subtitulos» para guardar copia de cada SRT.
- El vídeo debe tener ya subtítulos automáticos en español o un SRT tuyo.

## Los nodos, en orden
1. **Webhook** — método POST, ruta `/traducir-subs`. Le mandas `{"videoId":"xxxx"}` desde el móvil con un atajo o desde otro workflow. Alternativa: Schedule Trigger.
2. **HTTP Request** — GET .../youtube/v3/captions?part=snippet&videoId={{ $json.body.videoId }} y quédate con el id de la pista `es`.
3. **HTTP Request** — GET .../youtube/v3/captions/{{ $json.captionId }}?tfmt=srt, Response Format «String».
4. **Code** — parte el SRT en bloques y saca solo las líneas de texto (los tiempos no se tocan nunca).
5. **Split In Batches** — Batch Size 50 bloques.
6. **HTTP Request** a DeepL — POST https://api-free.deepl.com/v2/translate, header `Authorization: DeepL-Auth-Key TU_CLAVE`, body: text (array), target_lang EN / FR / PT-PT. Repite la rama para cada idioma o usa un **Item Lists** con los tres códigos.
7. **Code** — vuelve a montar el SRT con los tiempos originales y el texto traducido.
8. **Google Drive** (Upload) — guarda `videoId_en.srt` etc. en la carpeta «Subtitulos».
9. **HTTP Request** — POST https://www.googleapis.com/upload/youtube/v3/captions?part=snippet&uploadType=multipart, con el snippet `{videoId, language:'en', name:'English'}` y el archivo como binario. Credencial YouTube OAuth2.

## El código de los nodos 4 y 7
```js
// Nodo 4: separar
const srt = $json.data;
const bloques = srt.trim().split(/\r?\n\r?\n/).map(b => {
  const l = b.split(/\r?\n/);
  return { num: l[0], tiempo: l[1], texto: l.slice(2).join(' ') };
});
return bloques.map(b => ({ json: b }));
```
```js
// Nodo 7: recomponer
const t = $input.all();
const srt = t.map(i => `${i.json.num}\n${i.json.tiempo}\n${i.json.traducido}`).join('\n\n');
return [{ json: { srt }, binary: {} }];
```

## Cómo probarla
Prueba con un vídeo corto y no listado. Descarga el SRT generado y ábrelo en VLC junto al vídeo: si el texto se desfasa, es que el nodo 7 ha perdido el orden (revisa que Split In Batches no reordene). Sube primero solo el inglés.

## Qué puede salir mal
- **Subtítulos demasiado largos**: el inglés es más corto, el francés más largo. Pide a DeepL `formality=prefer_less` y no te preocupes por 2-3 caracteres de más.
- **Pista duplicada**: si vuelves a lanzar el workflow, `captions.insert` falla con «duplicate». Usa `captions.update` o borra la anterior antes.
- **Cuota**: cada insert cuesta 400 unidades de las 10.000 diarias: máximo unos 20 subtítulos al día.
- **Idioma mal detectado**: fuerza `source_lang=ES` en DeepL.

## Cuánto cuesta
DeepL Free cubre unos 60-80 vídeos de 10 minutos al mes en tres idiomas; a partir de ahí, 5,49 €/mes el plan Starter. YouTube y n8n, gratis.
