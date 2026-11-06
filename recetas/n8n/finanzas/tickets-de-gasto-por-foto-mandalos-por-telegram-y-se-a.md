# Tickets de gasto por foto: mándalos por Telegram y se a…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Haces una foto al ticket del bar, la gasolina o la ferretería, se la mandas a un bot de Telegram y en segundos está guardada en Drive y apuntada en tu hoja con importe, IVA y categoría.

## Qué es y qué hace

Envías la foto de un ticket a un bot privado de Telegram; un modelo con visión lee comercio, fecha, base, IVA y total, lo clasifica en una categoría, guarda la imagen en Drive y añade la fila a tu hoja de gastos. El bot te responde en el chat para que corrijas si se ha equivocado. Se monta con n8n, Make o Zapier.

## Cómo usarla

1. Crea el bot con BotFather y guarda el token
2. Crea la carpeta Tickets y la hoja Gastos
3. Añade la clave de Claude, Codex, Gemini o una IA local
4. Envía un ticket de prueba y revisa la fila
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando acumulas tickets en la cartera, en la guantera y en el bolsillo del abrigo, y la mitad se pierden antes de llegar al gestor.

## Cómo ganar dinero con ella

Un autónomo pierde de media 40-80 € al mes de IVA y gasto deducible por tickets extraviados. Son 500-960 € al año que dejas de perder.

- Captura de gastos por foto para comerciales y técnicos que viajan…
- Registro de tickets para autónomos que pierden justificantes…
- Configuración de gastos deducibles para instaladores y servicios a domicilio…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Montas un bot de Telegram privado. Cada vez que le mandas la foto de un ticket, el flujo la descarga, se la pasa a la IA para que lea comercio, fecha, base, IVA y total, la clasifica en una categoría de gasto, guarda la imagen en Drive y añade la fila a tu hoja.
Te contesta en el mismo chat con lo que ha entendido, para que corrijas al momento si se ha equivocado.
Para autónomos, comerciales, instaladores y cualquiera que gaste fuera de la oficina.

## Lo que necesitas antes
Bot de Telegram: @BotFather, `/newbot`, guarda el token. Si quieres que solo tú puedas usarlo, apunta tu chat ID desde `https://api.telegram.org/bot<TOKEN>/getUpdates`.
Clave de API de Claude en console.anthropic.com (modelo con visión, se usa `claude-sonnet-5-5`).
Carpeta en Drive «Tickets» y hoja «Gastos» con columnas: Fecha, Proveedor, NIF, Categoria, Base, IVA, Total, EnlaceFoto, Notas.
Credencial de Google en n8n con Drive y Sheets.

## Los nodos, en orden
**Telegram Trigger**: Updates «message». Additional Fields > Download Images activado.
**IF** (seguridad): `={{ $json.message.chat.id }}` igual a tu chat ID (número). Solo la rama true continúa; así nadie que descubra tu bot te mete gastos falsos.
**Telegram** (renombra a `Bajar foto`): Resource «File», Operation «Get», File ID `={{ $json.message.photo[$json.message.photo.length - 1].file_id }}` (la última posición es la de mayor resolución). Activa «Download».
**Extract from File**: Operation «Move Binary Data» hacia base64. Alternativa más simple: usa un **Code** con `Buffer.from($input.item.binary.data.data, 'base64')`. En n8n moderno basta con referenciar `$binary.data.data`, que ya viene en base64.
**HTTP Request** (la IA lee el ticket): POST a `https://api.anthropic.com/v1/messages`, Header Auth `x-api-key` más `anthropic-version: 2023-06-01`. Body JSON con expresión:
`={{ JSON.stringify({ model: "claude-sonnet-5-5", max_tokens: 600, messages: [{ role: "user", content: [ { type: "image", source: { type: "base64", media_type: "image/jpeg", data: $binary.data.data } }, { type: "text", text: "Lee este ticket español y devuelve SOLO un JSON con: proveedor, nif, fecha (AAAA-MM-DD), base, iva, total, categoria. La categoria debe ser una de: combustible, dietas, material, software, transporte, suministros, formacion, otros. Números con punto decimal. Si el ticket no separa base e IVA, calcula base = total/1.21 e iva = total - base, salvo que veas otro tipo. Si algo no se lee, pon null." } ] }] }) }}`
**Code** (limpia y prepara la fila): modo «Run Once for Each Item».
```javascript
const bruto = $input.item.json.content[0].text.replace(/```json/g,'').replace(/```/g,'').trim();
let d;
try { d = JSON.parse(bruto); } catch(e) { d = {}; }
const num = (v) => v == null ? 0 : (Number(String(v).replace(',', '.')) || 0);
let base = num(d.base), iva = num(d.iva), total = num(d.total);
if (!total && base) total = base + iva;
if (!base && total) { base = total / 1.21; iva = total - base; }
const cat = ['combustible','dietas','material','software','transporte','suministros','formacion','otros'].includes(d.categoria) ? d.categoria : 'otros';
const dudoso = (!d.proveedor || !total) ? 'REVISAR' : '';
return { json: { Fecha: d.fecha || new Date().toISOString().slice(0,10), Proveedor: d.proveedor || 'desconocido', NIF: d.nif || '', Categoria: cat, Base: base.toFixed(2), IVA: iva.toFixed(2), Total: total.toFixed(2), Notas: dudoso, chatId: $('Telegram Trigger').item.json.message.chat.id } };
```
**Google Drive**: Upload File, Input Data Field `data`, File Name `={{ $json.Fecha }}_{{ $json.Proveedor.replace(/[^a-zA-Z0-9]/g,'_') }}.jpg`, carpeta «Tickets».
**Google Sheets**: Append Row en «Gastos». En EnlaceFoto pon `={{ $('Google Drive').item.json.webViewLink }}`.
**Telegram**: Send Message. Chat ID `={{ $('Code').item.json.chatId }}`. Text: `=Ticket guardado ✅\n{{ $('Code').item.json.Proveedor }}\nFecha: {{ $('Code').item.json.Fecha }}\nBase: {{ $('Code').item.json.Base }} € | IVA: {{ $('Code').item.json.IVA }} € | Total: {{ $('Code').item.json.Total }} €\nCategoría: {{ $('Code').item.json.Categoria }}\n{{ $('Code').item.json.Notas ? '⚠️ Revísalo, no lo he leído bien del todo.' : '' }}`

## Cómo probarla
Manda cinco tickets distintos: uno de gasolinera, uno de bar, uno de supermercado, uno arrugado y uno con poca luz.
Compara lo que apunta la hoja con lo que pone el papel. Con tickets legibles el acierto es muy alto; con arrugados verás el aviso de REVISAR.
Prueba a mandar un texto en vez de una foto: el flujo debe no romperse (añade un IF que compruebe que existe `message.photo`).

## Qué puede salir mal
Fotos borrosas o con reflejo: la IA se inventa cifras. Por eso está la marca REVISAR y el mensaje de vuelta, que es tu control de calidad.
Tickets de restaurante con 10% de IVA: el prompt asume 21% solo si no encuentra el desglose. Revisa las dietas.
Un ticket no siempre es factura deducible: para deducir el IVA necesitas factura con tu NIF. Guarda el ticket igual, pero coméntalo con tu asesor.
Telegram limita las fotos a 20 MB por descarga de bot; las del móvil no llegan ni de lejos.
Si otra persona encuentra tu bot puede escribirle: el IF del chat ID es obligatorio, no te lo saltes.
Coste de la IA con imagen: alrededor de 0,01 € por ticket. Con 100 tickets al mes, un euro.

## Cuánto cuesta
Telegram, Drive y Sheets: gratis.
Claude: alrededor de 1 € al mes con uso normal.
n8n autoalojado: gratis.
