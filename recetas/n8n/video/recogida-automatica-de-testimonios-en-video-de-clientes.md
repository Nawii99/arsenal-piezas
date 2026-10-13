# Recogida automática de testimonios en vídeo de clientes…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Envías un enlace al cliente, él graba y sube su vídeo desde el móvil, y tú recibes el archivo ordenado en Drive con su transcripción, la mejor frase y un aviso.

## Qué es y qué hace

Es una automatización de n8n con un formulario que recibe el vídeo de testimonio de un cliente junto a su nombre, empresa y permiso de uso; lo guarda en Drive con nombre normalizado, lo transcribe, extrae la frase más citable y te avisa por correo. Entra el formulario con el archivo y sale una fila en Sheets con la transcripción y la frase lista para tu web. Requiere un webhook accesible, Drive, Gmail y la clave de transcripción.

## Cómo usarla

1. Crea el formulario con subida de archivo y campo de permiso
2. Conecta Drive y Gmail
3. Prueba con un testimonio tuyo
4. Publica solo los testimonios con permiso
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando pidas testimonios y se te queden a medias porque el cliente no sabe dónde mandarlos, o cuando tengas vídeos sueltos por WhatsApp sin saber de quién es cada uno.

## Cómo ganar dinero con ella

Un testimonio en vídeo sube la conversión de una página de ventas de forma notable; automatizar la recogida convierte un 20% de peticiones en un 60%.

- Recogida de testimonios en vídeo para academias y clínicas que venden por confianza.
- Página de testimonios para negocios de servicios con poca reseña escrita.
- Gestión de permisos y archivos de testimonios para agencias con varios clientes.

**Precio orientativo:** 150–350 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un formulario con subida de archivo recibe el vídeo del cliente junto a su nombre, empresa y permiso de uso; el flujo lo guarda en Drive con nombre normalizado, lo transcribe, extrae la frase más citable y te avisa por correo con todo listo para usarlo en tu web.
Para servicios, formaciones, clínicas, agencias: cualquiera que venda por confianza.

## Lo que necesitas antes
- n8n con un webhook accesible desde internet (n8n Cloud lo da hecho; auto-alojado necesita un dominio o un túnel).
- Un formulario con subida de archivos: **Tally** (gratis, permite archivos) o el propio nodo **n8n Form Trigger**, que también admite ficheros.
- Credenciales Google Drive y Gmail, clave de OpenAI.
- Carpeta `Testimonios` en Drive y hoja `Testimonios` con: `fecha`, `nombre`, `empresa`, `permiso`, `url_video`, `transcripcion`, `frase`.

## Los nodos, en orden
1. **n8n Form Trigger** — Form Title: «Cuéntanos tu experiencia». Campos: `Nombre` (texto, obligatorio), `Empresa` (texto), `Email` (email), `Tu vídeo` (tipo File, acepta `.mp4,.mov`), `Autorizo a usar el vídeo en la web y redes` (dropdown Sí/No, obligatorio). En Options activa `Respond: Show Completion Screen` con un texto de agradecimiento.
2. **IF** — `{{ $json['Autorizo a usar el vídeo en la web y redes'] }}` *equals* `Sí`. Si es no, se guarda igual pero se marca en la hoja como no publicable.
3. **Code** (nombre de archivo limpio):
```javascript
const limpia = t => (t || '').normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/[^a-zA-Z0-9]+/g, '-').toLowerCase();
const fecha = new Date().toISOString().slice(0, 10);
return [{ json: { ...$json, archivo: `${fecha}_${limpia($json.Nombre)}_${limpia($json.Empresa)}.mp4` } }];
```
4. **Google Drive** (Upload File) — carpeta `Testimonios`, File Name `{{ $json.archivo }}`, Input Binary Field: el nombre que le dio el formulario (normalmente `Tu_vídeo` — míralo en la salida del trigger).
5. **HTTP Request** (transcribir) — POST `https://api.openai.com/v1/audio/transcriptions`, Header Auth con tu clave, multipart: `file` binario, `model` = `whisper-1`, `language` = `es`, `response_format` = `text`. Si el vídeo pasa de 25 MB, extrae el audio antes con **Execute Command** y ffmpeg (`-vn -ac 1 -ar 16000 -b:a 32k`).
6. **OpenAI** (Message a Model) — User: `De esta transcripción de un testimonio, devuelve JSON con: frase (la cita más potente, literal, máximo 200 caracteres), resultado (el beneficio concreto que menciona, o "no lo dice"), apto (sí/no según si se entiende bien y es publicable). Transcripción: {{ $json.data }}`.
7. **Google Sheets** (Append Row) — todos los datos, incluida la frase.
8. **Gmail** (Send Message) — a ti: asunto «Nuevo testimonio de {{ nombre }}», cuerpo con la frase, el enlace al archivo en Drive y si autorizó el uso.
9. **Gmail** (Send Message) — al cliente: agradecimiento y, si procede, un código de descuento. Es lo que hace que el siguiente también te grabe.

## Cómo probarla
- Grábate tú un vídeo de 20 segundos con el móvil y pásalo por el formulario completo. Comprueba que llega el archivo entero (no un enlace roto) y que el nombre no lleva tildes ni espacios.
- Prueba también un `.mov` de iPhone: es el formato que más te van a mandar.

## Qué puede salir mal
- **Tamaño de subida**: n8n limita el cuerpo de las peticiones; sube `N8N_PAYLOAD_SIZE_MAX=256` (en MB) y avisa en el formulario de que graben menos de 2 minutos.
- **Vídeos verticales de iPhone girados**: guarda el original y no lo reprocese nadie sin `-vf "scale=..,transpose"`; ffmpeg respeta la rotación si usas `-c copy`.
- **Permiso de imagen**: guarda siempre la respuesta del campo de autorización. Publicar la cara de alguien sin consentimiento es un problema legal, no un detalle.
- **Ficheros con el mismo nombre**: la fecha y el nombre del cliente lo evitan; si repite, añade `{{ $execution.id }}`.

## Cuánto cuesta
- Tally: gratis hasta cierto volumen de respuestas con archivos. El Form Trigger de n8n es gratis del todo.
- Transcripción: unos 0,01 € por testimonio de 90 segundos.
- Drive, Gmail y n8n auto-alojado: 0 €.
