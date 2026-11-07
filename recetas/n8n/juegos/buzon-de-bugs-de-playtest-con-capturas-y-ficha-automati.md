# Buzón de bugs de playtest con capturas y ficha automáti…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Los jugadores rellenan un formulario con el bug, se crea la tarjeta en tu tablero con la versión y el hardware, se agrupan los reportes repetidos y te avisa por Discord si un bug se repite.

## Qué es y qué hace

Recibe reportes de un formulario de Tally con texto, versión, sistema y captura, crea una tarjeta en Trello con esos datos y agrupa los reportes repetidos. Si un bug llega a tres reportes, avisa en Discord. Entrada: formulario con webhook; salida: tarjetas de Trello y avisos. Se monta en n8n con Tally y Trello, y en Make o Zapier con el mismo esquema.

## Cómo usarla

1. Crear el formulario en Tally y el tablero de Trello
2. Conectar el webhook en n8n
3. Probar con tres reportes de prueba
4. Activar el aviso de Discord

## Cuándo usarla

Cuando tienes una demo o una beta y el feedback te llega desperdigado por Discord, Twitter y correo, y acabas perdiendo bugs importantes.

## Cómo ganar dinero con ella

Sustituye un rato diario de triaje manual y evita relanzar builds con bugs ya reportados que se te habían traspapelado.

- Preparar el buzón de feedback de una beta cerrada para un estudio, cobrando la configuración y el mantenimiento.
- Ofrecer a equipos de QA pequeños un triaje automático de los reportes de usuarios.
- Formar al equipo del estudio para leer y priorizar el tablero de bugs.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recibe los reportes de un formulario público, extrae versión, sistema y gravedad, crea una tarjeta en Trello con la captura adjunta, detecta reportes parecidos ya existentes y avisa en Discord cuando un bug pasa de 3 reportes. Para estudios que hacen playtest abierto o early access.

## Lo que necesitas antes
- Formulario en Tally (gratis, permite subir ficheros y mandar webhook). Campos: `¿Qué pasó?` (texto largo), `¿Cómo lo reproduces?` (texto largo), `Gravedad` (opción: bloqueante / molesto / cosmético), `Versión de la build` (opción), `Sistema` (opción: Windows / Mac / Steam Deck / Linux), `Captura o vídeo` (fichero), `Tu correo o Discord` (texto). En Tally: Integrations > Webhooks > pega la URL de n8n.
- Cuenta de Trello con un tablero `Bugs` y listas `Entrantes`, `Confirmados`, `Arreglados`. Clave y token en `trello.com/power-ups/admin` o `trello.com/app-key`.
- Webhook de Discord del canal privado del equipo.
- Google Sheet `bugs` con columnas: `id`, `fecha`, `resumen`, `firma`, `gravedad`, `version`, `sistema`, `reportes`, `card_url`.

## Los nodos, en orden
1. **Webhook** — POST, Path: `bug-playtest`, Respond: `Immediately`. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2. **Code** (`Normalizar reporte`) — Tally manda los campos dentro de `data.fields` como array; este código los convierte en un objeto plano y calcula una firma de texto para detectar duplicados. Código abajo.
3. **Google Sheets** (`Buscar parecidos`) — Get Row(s) con Filter: columna `firma` equals `{{ $json.firma }}`.
4. **IF** (`¿Ya existía?`) — Number, `{{ $items().length }}` mayor que `0`. Más fiable: usa un Code que compruebe `$input.all().length`.
5. **Rama nueva (no existía)** — **Trello** > Resource: `Card`, Operation: `Create`. List ID: el de `Entrantes`. Name: `[{{ $json.gravedad }}] {{ $json.resumen }}`. Description: el texto completo con pasos, versión y sistema. Labels: usa el ID de la etiqueta roja para bloqueantes.
6. **HTTP Request** (`Adjuntar captura`) — POST a `https://api.trello.com/1/cards/{{ $json.id }}/attachments`, Authentication: Predefined Credential Type > Trello API (la clave y el token van en esa credencial de n8n), Body Content Type `Form-Data`, campo `url` = la URL del fichero que Tally aloja. No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él.
7. **Google Sheets** (`Guardar bug`) — Append Row con `reportes` = 1 y el `card_url`.
8. **Rama existente** — **Google Sheets** > Update Row: `reportes` = `{{ $json.reportes + 1 }}`. Y **HTTP Request** a Trello para añadir un comentario: POST `https://api.trello.com/1/cards/{{ $json.card_id }}/actions/comments?text=Reporte%20adicional%20de%20{{ $json.contacto }}`, con la misma credencial Trello API. No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él.
9. **IF** (`¿Es grave o repetido?`) — condición OR: `gravedad` equals `bloqueante`, o `reportes` mayor o igual que `3`.
10. **HTTP Request** (`Discord`) — `{ "content": "🔴 **{{ $json.resumen }}**\nGravedad: {{ $json.gravedad }} · Reportes: {{ $json.reportes }} · Build {{ $json.version }} · {{ $json.sistema }}\n{{ $json.card_url }}" }`.
11. **Gmail** (opcional) — respuesta automática al jugador: «Gracias, lo hemos apuntado con el número {{ $json.id }}». Un jugador que recibe respuesta reporta más veces.

## El código de `Normalizar reporte`
```javascript
const campos = $input.first().json.body.data.fields || [];
const mapa = {};
for (const c of campos) {
  const clave = (c.label || '').toLowerCase();
  let valor = c.value;
  if (Array.isArray(valor) && valor.length && valor[0].url) valor = valor[0].url;
  if (Array.isArray(valor)) valor = valor.join(', ');
  if (c.options && typeof valor === 'string') {
    const op = c.options.find(o => o.id === valor);
    if (op) valor = op.text;
  }
  mapa[clave] = valor;
}
const texto = String(mapa['¿qué pasó?'] || '');
const palabras = texto.toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/[^a-z0-9 ]/g, ' ').split(/\s+/).filter(p => p.length > 4);
const firma = palabras.sort().slice(0, 6).join('-');
return [{ json: {
  id: 'BUG-' + Date.now().toString().slice(-6),
  fecha: $now.toFormat('yyyy-MM-dd HH:mm'),
  resumen: texto.slice(0, 90),
  detalle: texto,
  pasos: mapa['¿cómo lo reproduces?'] || '',
  gravedad: mapa['gravedad'] || 'molesto',
  version: mapa['versión de la build'] || 'desconocida',
  sistema: mapa['sistema'] || 'desconocido',
  captura: mapa['captura o vídeo'] || '',
  contacto: mapa['tu correo o discord'] || '',
  firma: firma
} }];
```

## Cómo probarla
- Rellena el formulario tú mismo tres veces con el mismo texto: la primera debe crear tarjeta, la segunda y la tercera solo sumar reportes, y la tercera además disparar el aviso de Discord.
- Rellénalo con un texto muy distinto y comprueba que crea tarjeta nueva.
- Mira en n8n el JSON crudo del Webhook la primera vez: Tally cambia de vez en cuando la estructura y quizá tengas que ajustar la ruta `body.data.fields`.

## Qué puede salir mal
- **La firma agrupa de más o de menos**: es una heurística tonta a propósito, para que la entiendas. Si agrupa bugs distintos, sube el filtro a palabras de más de 6 letras o baja a 4 palabras en la firma.
- **Capturas que caducan**: Tally aloja los ficheros, pero si borras la respuesta se pierde el enlace. Si el bug es importante, descarga el fichero y súbelo a Drive.
- **Spam**: un formulario público se llena de basura. Activa el captcha de Tally y añade un IF que descarte reportes de menos de 20 caracteres.
- **Límite de la API de Trello**: 300 peticiones cada 10 segundos por token; con reportes humanos ni te acercas.

## Cuánto cuesta
- Tally: gratis con formularios y respuestas ilimitadas; subida de ficheros incluida en el plan gratuito.
- Trello: gratis hasta 10 tableros. Discord y Sheets: gratis.
- n8n: gratis auto-alojado.
