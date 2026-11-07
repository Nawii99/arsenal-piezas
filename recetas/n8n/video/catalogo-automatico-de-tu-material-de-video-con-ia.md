# Catálogo automático de tu material de vídeo con IA…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Cada clip nuevo se analiza solo: la IA mira un fotograma, describe qué se ve y lo etiqueta, y todo queda buscable en una hoja de cálculo.

## Qué es y qué hace

Vigila tu carpeta de material bruto en Drive y, por cada clip nuevo, extrae un fotograma, lo envía a un modelo de visión que describe sujeto, plano, luz y si es utilizable, y guarda todo en una hoja con enlace directo. Entran los clips y una clave de modelo de visión; sale una hoja buscable por contenido. Para videógrafos, agencias y creadores con mucho material de apoyo.

## Cómo usarla

1. Crea la carpeta B-ROLL en Drive
2. Pon la clave del modelo de visión en n8n
3. Procesa 10 clips de prueba
4. Revisa las etiquetas antes de usar el catálogo

## Cuándo usarla

Cuando tienes cientos de clips en discos y carpetas con nombres tipo DJI_0453.MP4 y acabas grabando otra vez algo que ya tenías.

## Cómo ganar dinero con ella

Buscar un plano concreto entre tu material cuesta 10-20 minutos cada vez. Con esto es una búsqueda de 5 segundos en una hoja.

- Catalogado de archivo de vídeo para productoras con búsqueda por tipo de plano…
- Biblioteca de material de apoyo para marcas que reutilizan imágenes en varias campañas…
- Organización de archivo de vídeo para estudios con etiquetado automático…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Vigila tu carpeta de material bruto en Drive y, por cada clip nuevo, extrae un fotograma representativo, se lo pasa a un modelo de visión que describe qué aparece (sujeto, escenario, tipo de plano, luz, si tiene gente, si es utilizable) y lo guarda todo en una hoja buscable con enlace directo al archivo. Para videógrafos, agencias y creadores con archivo grande de b-roll.

## Lo que necesitas antes
- n8n.
- Carpeta de Drive `B-ROLL` (con subcarpetas si quieres, el trigger puede vigilar solo una a la vez).
- Cuenta gratuita de Cloudinary con `Cloud name` y un upload preset `unsigned` llamado `broll`.
- Clave de OpenAI con modelo de visión.
- Hoja `Catalogo b-roll` con columnas: `fecha`, `archivo`, `enlace_drive`, `miniatura`, `descripcion`, `etiquetas`, `plano`, `luz`, `hay_gente`, `utilizable`, `duracion`.

## Los nodos, en orden
1. **Google Drive Trigger** — File Created en `B-ROLL`, Poll cada hora (el material bruto llega a rachas, no hace falta más).
2. **IF** — Solo sigue si el nombre acaba en `.mp4`, `.mov` o `.MP4`. Usa operación «matches regex» con `\.(mp4|mov|MP4|MOV)$`.
3. **Google Drive** — `Download`, Output Binary Field `data`.
4. **HTTP Request** — POST a `https://api.cloudinary.com/v1_1/TU_CLOUD/video/upload`, Form-Data con `file` (binario `data`), `upload_preset` = `broll`, `resource_type` = `video`.
5. **Code** — Construye la URL del fotograma del segundo 2 y guarda duración y `public_id`.
6. **HTTP Request1** — POST a `https://api.openai.com/v1/chat/completions` con el prompt de visión de abajo y `response_format` de tipo `json_object`.
7. **Code1** — Parsea la respuesta y aplana los campos.
8. **Google Sheets** — Append con todo, incluida la URL de la miniatura (en Sheets puedes verla poniendo en otra columna la fórmula `=IMAGE(D2)`).
9. **HTTP Request2** — DELETE a `https://api.cloudinary.com/v1_1/TU_CLOUD/video/destroy` con `public_id` y firma, o desde el panel borra la carpeta cada mes. Es importante para no agotar el plan gratuito.

## El código del nodo Code (paso 5)
```javascript
const cloud = 'TU_CLOUD';
const id = $json.public_id;
const dur = Math.round($json.duration || 0);
const punto = dur > 5 ? 2 : 1;
return { json: {
  public_id: id,
  duracion: dur,
  miniatura: 'https://res.cloudinary.com/' + cloud + '/video/upload/so_' + punto + ',w_800,q_auto/' + id + '.jpg',
  archivo: $('Google Drive Trigger').first().json.name,
  enlace_drive: 'https://drive.google.com/file/d/' + $('Google Drive Trigger').first().json.id + '/view'
}};
```

## El body del nodo HTTP Request1 (paso 6)
```json
{
  "model": "gpt-4.1-mini",
  "response_format": {"type": "json_object"},
  "messages": [
    {"role": "system", "content": "Eres ayudante de un videógrafo. Catalogas material de archivo. Español de España. Devuelves SOLO JSON."},
    {"role": "user", "content": [
      {"type": "text", "text": "Cataloga este fotograma. Devuelve {\"descripcion\":\"una frase de qué se ve\",\"etiquetas\":[\"6 a 10 palabras clave en español\"],\"plano\":\"general|medio|corto|detalle|aéreo\",\"luz\":\"día|noche|interior|hora dorada|artificial\",\"hay_gente\":true,\"utilizable\":\"si|dudoso|no\",\"motivo\":\"si no es utilizable, por qué: desenfoque, sobreexposición, encuadre torcido...\"}"},
      {"type": "image_url", "image_url": {"url": "{{ $json.miniatura }}"}}
    ]}
  ]
}
```

## El código del nodo Code1 (paso 7)
```javascript
const bruto = $json.choices[0].message.content;
const d = typeof bruto === 'string' ? JSON.parse(bruto) : bruto;
const prev = $('Code').first().json;
return { json: {
  fecha: new Date().toISOString().slice(0, 10),
  archivo: prev.archivo,
  enlace_drive: prev.enlace_drive,
  miniatura: prev.miniatura,
  duracion: prev.duracion,
  descripcion: d.descripcion,
  etiquetas: (d.etiquetas || []).join(', '),
  plano: d.plano,
  luz: d.luz,
  hay_gente: d.hay_gente ? 'si' : 'no',
  utilizable: d.utilizable + (d.motivo ? ' (' + d.motivo + ')' : '')
}};
```

## Cómo probarla
1. Mete cinco clips muy distintos (un plano aéreo, un detalle, una entrevista, uno movido y uno oscuro).
2. Comprueba que la IA marca como `dudoso` o `no` el movido y el oscuro. Si no, añade al prompt «sé estricto, es material profesional».
3. En la hoja, prueba a buscar con Ctrl+F una etiqueta como «playa» y ve si te lleva al clip correcto.

## Qué puede salir mal
- **Un fotograma no representa todo el clip**: para clips largos, genera tres fotogramas cambiando `so_` y manda los tres a la IA en el mismo mensaje.
- **Cloudinary gratis se llena rápido con vídeo**: el paso 9 de borrado no es opcional si vas a catalogar cientos de clips. Alternativa: si tienes n8n auto-alojado, usa un nodo **Execute Command** con `ffmpeg -ss 00:00:02 -i entrada.mp4 -frames:v 1 salida.jpg` y te ahorras Cloudinary del todo. Guarda antes el clip en disco con el ID de Drive como nombre (`/tmp/<ID>.mp4`), nunca con el nombre original.
- **Archivos enormes**: los brutos de 4K de varios GB no van a pasar por n8n cloud. Con auto-alojado y ffmpeg local sí.
- **Etiquetas en inglés**: si la IA se pasa al inglés, insiste en el system con «todas las etiquetas obligatoriamente en español».
- **Duplicados si mueves archivos entre carpetas de Drive**: el trigger `File Created` puede volver a dispararse. Añade un Lookup en Sheets por nombre de archivo antes del Append.
- **Nombre del clip en el comando**: un nombre como `a"; rm -rf ~; ".mp4` ejecutaría órdenes si entrase en ffmpeg; por eso en disco se usa solo el ID de Drive.

## Cuánto cuesta
Unos 0,01 € por clip con `gpt-4.1-mini`: catalogar 500 clips cuesta 5 €. Cloudinary gratis si borras lo procesado, o 0 € del todo si usas ffmpeg en n8n auto-alojado. Sheets y Drive, gratis.
