# Miniaturas de YouTube: fotograma y 5 títulos propuestos…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

De cada vídeo saca automáticamente tres fotogramas candidatos a miniatura y la IA te propone cinco títulos y el texto grande que debe llevar la portada.

## Qué es y qué hace

Cuando dejas un vídeo en Drive, lo sube a Cloudinary, extrae tres fotogramas en distintos momentos y los envía a un modelo con visión que propone cinco títulos, el texto corto para la miniatura y cuál fotograma funciona mejor. Entran el vídeo y las claves de Cloudinary y del modelo; sale un informe con fotogramas y propuestas. Para creadores de YouTube sin diseñador.

## Cómo usarla

1. Crea una cuenta gratuita de Cloudinary y un preset de subida
2. Pon la clave del modelo en n8n
3. Deja un vídeo de prueba en la carpeta
4. Elige la miniatura tú mismo y guarda el resultado

## Cuándo usarla

Cuando el vídeo está listo pero te atascas media hora eligiendo miniatura y título, o cuando notas que tus vídeos tienen buen contenido y poco clic.

## Cómo ganar dinero con ella

Ahorra 30-40 minutos por vídeo de decisiones y pruebas, y mejorar el clic un punto vale más que cualquier otra optimización del canal.

- Propuestas de miniatura y título para canales de creadores, con revisión incluida…
- Pack de portadas de vídeo para negocios que publican en YouTube sin diseñador…
- Análisis de miniaturas para mejorar clics en canales con buen contenido y poca visibilidad…

**Precio orientativo:** 15–40 € por vídeo. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Cuando dejas un vídeo en Drive, lo sube a Cloudinary, extrae tres fotogramas (segundo 3, mitad y último tercio) como imágenes JPG, se los enseña a la IA con visión y te devuelve cinco propuestas de título, el texto corto que debería ir sobre la miniatura y cuál de los tres fotogramas funciona mejor. Para cualquiera que publique en YouTube y no tenga diseñador.

## Lo que necesitas antes
- n8n.
- Cuenta gratuita de Cloudinary (cloudinary.com): en el Dashboard tienes `Cloud name`, `API Key` y `API Secret`. Crea además un «upload preset» sin firmar en Settings → Upload → Add upload preset, modo `Unsigned`, nombre `miniaturas`.
- Clave de OpenAI con acceso a un modelo con visión (`gpt-4.1-mini` sirve).
- Carpeta de Drive `VIDEOS-MINIATURA` y una hoja `Miniaturas` con columnas `fecha`, `video`, `frame_1`, `frame_2`, `frame_3`, `mejor_frame`, `titulos`, `texto_portada`.

## Los nodos, en orden
1. **Google Drive Trigger** — File Created en `VIDEOS-MINIATURA`, cada 15 minutos.
2. **Google Drive** — `Download`, Output Binary Field `data`.
3. **HTTP Request** (subir a Cloudinary) — POST a `https://api.cloudinary.com/v1_1/TU_CLOUD_NAME/video/upload`. Body Content Type: `Form-Data`. Parámetros: `file` tipo n8n Binary File campo `data`; `upload_preset` = `miniaturas`; `resource_type` = `video`.
4. **Code** — Con el `public_id` y la `duration` que devuelve Cloudinary construye las tres URLs de fotograma usando la transformación `so_` (segundo de origen).
5. **HTTP Request1** — POST a `https://api.openai.com/v1/chat/completions`. Header Auth con tu clave. Body JSON con el modelo, el prompt de abajo y las tres imágenes por URL.
6. **Code1** — Parsea la respuesta JSON de la IA.
7. **Google Sheets** — Append con los tres enlaces de fotograma, la elección y los títulos.
8. **Gmail** — Correo con las tres imágenes incrustadas (`<img src=...>`) y las propuestas, para que decidas en 30 segundos desde el móvil.

## El código del nodo Code (paso 4)
```javascript
const cloud = 'TU_CLOUD_NAME';
const id = $json.public_id;
const dur = Math.max(6, Math.floor($json.duration || 60));
const segundos = [3, Math.floor(dur / 2), Math.floor(dur * 0.75)];
const frames = segundos.map(s => 'https://res.cloudinary.com/' + cloud + '/video/upload/so_' + s + ',w_1280,h_720,c_fill,q_auto/' + id + '.jpg');
return { json: { frames, public_id: id, duracion: dur, nombre: $('Google Drive Trigger').first().json.name } };
```

## El body del nodo HTTP Request1 (paso 5)
```json
{
  "model": "gpt-4.1-mini",
  "response_format": {"type": "json_object"},
  "messages": [
    {"role": "system", "content": "Eres experto en miniaturas y títulos de YouTube en español de España. Devuelves SOLO JSON."},
    {"role": "user", "content": [
      {"type": "text", "text": "Estos son tres fotogramas del vídeo llamado '{{ $json.nombre }}'. Devuelve {\"mejor_frame\":1|2|3,\"por_que\":\"...\",\"titulos\":[\"...\",\"...\",\"...\",\"...\",\"...\"],\"texto_portada\":\"...\"}. Los títulos, máximo 60 caracteres, sin clickbait mentiroso, con un beneficio o una tensión clara. El texto de portada, máximo 4 palabras en mayúsculas."},
      {"type": "image_url", "image_url": {"url": "{{ $json.frames[0] }}"}},
      {"type": "image_url", "image_url": {"url": "{{ $json.frames[1] }}"}},
      {"type": "image_url", "image_url": {"url": "{{ $json.frames[2] }}"}}
    ]}
  ]
}
```

## Cómo probarla
1. Sube a mano un vídeo corto y ejecuta hasta el nodo 4. Abre las tres URLs en el navegador: deben mostrar fotogramas distintos.
2. Si salen todos iguales, el vídeo dura menos de 6 segundos o Cloudinary aún lo está procesando: añade un **Wait** de 30 segundos entre el 3 y el 4.
3. Comprueba que la IA no propone títulos de más de 60 caracteres; si se pasa, añade «cuenta los caracteres» al prompt.

## Qué puede salir mal
- **Cloudinary gratis limita los vídeos a 100 MB** por archivo. Para vídeos largos sube solo un recorte, o usa la versión comprimida.
- **Las URLs de fotograma tardan la primera vez**: Cloudinary las genera bajo demanda, la primera carga puede tardar unos segundos.
- **La IA elige siempre el frame 1**: pon en el prompt «no elijas por orden, elige por expresión facial, contraste y claridad».
- **Créditos de Cloudinary**: el plan gratuito da 25 créditos mensuales y el vídeo consume más que la imagen. Borra los vídeos de Cloudinary tras generar los fotogramas con una llamada `DELETE` al endpoint de destroy.
- **Miniaturas ilegibles en móvil**: el texto de portada nunca más de 4 palabras, esa regla está en el prompt por algo.

## Cuánto cuesta
OpenAI con visión: unos 0,01-0,02 € por vídeo. Cloudinary gratis hasta 25 créditos al mes (unos 20-30 vídeos cortos), luego desde 89 $/mes, así que borra los vídeos al terminar. n8n autoalojado (Community Edition) y Drive, gratis (n8n Cloud: prueba gratuita temporal y después de pago).
