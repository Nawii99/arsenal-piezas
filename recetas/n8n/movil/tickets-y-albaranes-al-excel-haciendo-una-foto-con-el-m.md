# Tickets y albaranes al Excel haciendo una foto con el m…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Mandas la foto de un ticket o un albarán a un bot de Telegram desde el móvil y en diez segundos la fila está en tu Google Sheets con fecha, proveedor, base e IVA.

## Qué es y qué hace

Receta de n8n que convierte un bot de Telegram en escáner de tickets. Mandas la foto de un ticket o albarán, un modelo de visión lee fecha, proveedor, base, IVA y total, te devuelve un mensaje para confirmar y guarda la fila en Google Sheets y la imagen en Drive. Entrada: foto del ticket. Salida: fila con datos fiscales básicos. Sirve a autónomos que llevan su contabilidad o se la pasan al gestor.

## Cómo usarla

1. Crea el bot con BotFather y conecta Sheets y Drive
2. Haz una foto de prueba y confirma los datos
3. Pasa el Excel a tu gestor cada trimestre
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando acumulas tickets en la cartera y los metes todos de golpe el día antes del trimestre, o cuando pagas a alguien para que teclee facturas.

## Cómo ganar dinero con ella

Cinco minutos por ticket a cero. Con 60 tickets al mes son cinco horas. Y no pierdes IVA deducible por tickets que se traspapelan.

- Organización de tickets para un autónomo que factura poco…
- Digitalización de albaranes para una pequeña empresa de reparto…
- Puesta en marcha de un escáner de gastos para una gestoría pequeña…

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Creas un bot de Telegram que es tu escáner de gastos de bolsillo. Le mandas la foto del ticket, la IA lee los datos, te devuelve un mensaje para confirmar y guarda la fila en la hoja y la imagen en Drive.
Es para autónomos y negocios pequeños que hacen la contabilidad ellos o se la mandan al gestor en Excel.

## Lo que necesitas antes
n8n.
Bot de Telegram creado con @BotFather. Guarda el token. Añade el bot a un grupo si queréis usarlo varias personas.
Clave de OpenAI (usaremos gpt-4o-mini con visión, que lee imágenes).
Una hoja de Google Sheets «gastos» con columnas: fecha, proveedor, concepto, base, iva, total, categoria, enlace_foto, quien.
Una carpeta en Google Drive llamada «Tickets».

## Los nodos, en orden
1. «Telegram Trigger». Updates: message. Activa «Download Image» en Options para que te baje el fichero.
2. «IF». Condición: {{ $json.message.photo }} existe. Si no hay foto, responde «Mándame la foto del ticket» y fin.
3. «Google Drive» (Upload File). Carpeta Tickets, nombre ticket-{{ $now.format('yyyyMMdd-HHmmss') }}.jpg, datos binarios del trigger.
4. «OpenAI» (Analyze Image). Modelo gpt-4o-mini. Input Type: Binary. Prompt: «Lee este ticket o factura española. Devuelve solo JSON con: fecha (AAAA-MM-DD), proveedor, cif, concepto (máx 6 palabras), base (número con punto decimal), iva (número), total (número), categoria (una de: material, dietas, transporte, software, suministros, otros). Si un dato no aparece pon cadena vacía».
5. «Code» (limpiar y validar). Código completo:
```js
let t = $input.first().json.content || '{}';
t = t.replace(/```json/g, '').replace(/```/g, '').trim();
let d = {};
try { d = JSON.parse(t); } catch (e) { d = { error: 'no se pudo leer' }; }
const n = (x) => { const v = Number(String(x).replace(',', '.')); return isNaN(v) ? 0 : v; };
d.base = n(d.base); d.iva = n(d.iva); d.total = n(d.total);
if (d.total === 0 && d.base > 0) d.total = Math.round((d.base + d.iva) * 100) / 100;
d.cuadra = Math.abs((d.base + d.iva) - d.total) < 0.05;
return [{ json: d }];
```
6. «Google Sheets» (Append) con todos los campos, el enlace de Drive y el nombre de quien lo mandó ({{ $('Telegram Trigger').item.json.message.from.first_name }}).
7. «Telegram» (Send Message) de confirmación: «✅ {{ $json.proveedor }} · {{ $json.total }} € · {{ $json.categoria }}. {{ $json.cuadra ? '' : '⚠️ Revisa: base + IVA no cuadra con el total' }}».

## Cómo probarla
Haz una foto a tres tickets muy distintos: uno de gasolinera con letra pequeña, uno de bar arrugado y una factura A4. Comprueba lo que te devuelve.
Si un dato falla mucho (el CIF suele ser el peor), añade en el prompt un ejemplo del formato español: «el CIF tiene letra y 8 cifras, o 8 cifras y letra».

## Qué puede salir mal
Fotos torcidas o con sombras: pide que la foto se haga sobre superficie lisa. La IA aguanta bastante, pero no milagros.
Tickets térmicos borrados por el calor: no hay solución, fotografíalos el mismo día.
Si mandas la foto como «archivo» en vez de como «foto», Telegram la manda en $json.message.document y el IF no la coge. Añade una rama para documentos.
Números con coma española: el Code ya los convierte, pero revisa que Sheets no te los guarde como texto. Formatea las columnas base, iva y total como número.
Un ticket puede subir dos veces si reenvías el mensaje. Añade una columna con el file_id de Telegram y un Lookup previo si te preocupa.

## Cuánto cuesta
Telegram, Sheets y Drive: gratis. n8n autoalojado: gratis (n8n Cloud solo tiene una prueba gratuita temporal y después es de pago). OpenAI con gpt-4o-mini y visión: alrededor de 0,003 € por ticket, es decir menos de 20 céntimos al mes con 60 tickets.
