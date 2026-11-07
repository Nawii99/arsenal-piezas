# Vigilante de subidas de precio de tus proveedores…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Lee las facturas de proveedor que te llegan por email, extrae el precio unitario de cada artículo y te avisa cuando un proveedor te sube el precio respecto a la última compra.

## Qué es y qué hace

Vigila una etiqueta de Gmail donde caen las facturas de proveedor en PDF, extrae con un modelo de IA (Claude, Codex, Gemini o una IA local) las líneas de artículo, cantidad y precio unitario, y las guarda en Google Sheets. Si el precio de un artículo sube más de un umbral respecto a la última compra, te manda un correo con el precio antiguo, el nuevo y el porcentaje. Para hostelería, tiendas y talleres.

## Cómo usarla

1. Crear la etiqueta y el filtro en Gmail
2. Preparar la hoja Compras
3. Configurar la clave de la IA que uses
4. Que lo revise un profesional

## Cuándo usarla

Cuando compras materia prima o mercancía a los mismos proveedores y las subidas se te cuelan sin que nadie te avise.

## Cómo ganar dinero con ella

Detectar una subida del 8 % en tu artículo más comprado te permite renegociar o cambiar de proveedor antes de tragarte tres meses de coste extra.

- Control de compras para restaurantes que reciben facturas de proveedor por correo.
- Revisión mensual de subidas de precio con propuesta de negociación para talleres y tiendas.
- Montaje de extracción de líneas de factura con IA para gestorías de pymes.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Vigila una etiqueta de Gmail donde caen las facturas de proveedor en PDF, extrae con IA las líneas (artículo, cantidad, precio unitario) y las compara con el histórico de esa referencia.
Si el precio unitario sube más de un umbral que tú fijas, te manda un email con el artículo, el precio antiguo, el nuevo y el porcentaje. Para hostelería, tiendas, talleres y cualquier negocio que compre repetidamente lo mismo.

## Lo que necesitas antes
Gmail conectado a n8n por OAuth2, y una etiqueta llamada `Facturas proveedor`. Crea un filtro en Gmail que aplique esa etiqueta a los remitentes de tus proveedores.
Una clave de la API de Anthropic (console.anthropic.com > API Keys). Es de pago por uso, muy barato: leer una factura cuesta céntimos.
Hoja de Google Sheets `Compras` con pestaña `Lineas`: `fecha`, `proveedor`, `articulo`, `cantidad`, `precio_unitario`, `factura`.

## Los nodos, en orden
**1. Gmail Trigger** — Evento `Message Received`, `Poll Times` cada hora, filtro `Label IDs` = `Facturas proveedor`, y en Options activa `Download Attachments` = true.
**2. Extract from File** — Operación `Extract From PDF`, campo binario `attachment_0`. Devuelve el texto en `text`.
**3. HTTP Request** (`Leer con IA`) — `POST` a `https://api.anthropic.com/v1/messages`. Headers: `x-api-key` desde una credencial de n8n (Generic Credential Type > Header Auth, Name `x-api-key`, Value tu clave; no la escribas en el nodo: un flujo exportado se la llevaría), `anthropic-version` = `2023-06-01`, `content-type` = `application/json`. Body JSON: `{"model":"claude-sonnet-5-5","max_tokens":2000,"messages":[{"role":"user","content":"Devuelve SOLO un JSON con esta forma {\"proveedor\":\"\",\"factura\":\"\",\"fecha\":\"yyyy-mm-dd\",\"lineas\":[{\"articulo\":\"\",\"cantidad\":0,\"precio_unitario\":0}]} para esta factura:\n\n{{ $json.text }}"}]}`.
**4. Google Sheets** (`Historico`) — `Get Row(s)`, pestaña `Lineas`.
**5. Code** (`Comparar precios`) — `Run Once for All Items`. Código abajo.
**6. Google Sheets** (`Guardar lineas`) — `Append`, pestaña `Lineas`.
**7. Filter** — `{{ $json.subida_pct }}` `is greater than` `3`.
**8. Gmail** — `Send` a tu correo, asunto `Subida de precio: {{ $json.articulo }}`, mensaje `={{ $json.aviso }}`.

## El código del nodo Comparar precios
```javascript
const bruto = $('Leer con IA').first().json.content[0].text;
const limpio = bruto.replace(/```json|```/g, '').trim();
let f;
try { f = JSON.parse(limpio); } catch (e) { return [{ json: { error: 'No se pudo leer la factura', bruto } }]; }
const hist = $('Historico').all().map(i => i.json);
const norm = s => String(s || '').toUpperCase().replace(/\s+/g, ' ').trim();
const out = [];
for (const l of f.lineas || []) {
  const art = norm(l.articulo);
  const previas = hist.filter(h => norm(h.articulo) === art && norm(h.proveedor) === norm(f.proveedor)).sort((a, b) => String(b.fecha).localeCompare(String(a.fecha)));
  const anterior = previas[0] ? Number(previas[0].precio_unitario) : null;
  const actual = Number(l.precio_unitario);
  const subida = anterior ? (actual / anterior - 1) * 100 : 0;
  out.push({ json: { fecha: f.fecha, proveedor: f.proveedor, factura: f.factura, articulo: l.articulo, cantidad: Number(l.cantidad), precio_unitario: actual, precio_anterior: anterior, subida_pct: Number(subida.toFixed(1)), aviso: anterior ? `${f.proveedor} sube ${l.articulo} de ${anterior.toFixed(2)} € a ${actual.toFixed(2)} € (+${subida.toFixed(1)} %). Factura ${f.factura} del ${f.fecha}. Con tu consumo habitual eso son unos ${(Math.abs(actual - anterior) * Number(l.cantidad) * 12).toFixed(0)} € al año si compras lo mismo cada mes.` : '' } });
}
return out;
```

## Cómo probarla
Reenvíate una factura antigua de un proveedor a la etiqueta y ejecuta el flujo a mano con `Fetch Test Event` en el Gmail Trigger. Revisa que el JSON que devuelve la IA tenga las líneas correctas.
Mete a mano en la hoja una línea del mismo artículo con precio más bajo y vuelve a lanzar: debe saltar el aviso.

## Qué puede salir mal
Facturas escaneadas como imagen: el nodo Extract from File no saca texto. Manda la imagen directamente a la API de Anthropic como contenido tipo `image` en base64, o pide al proveedor el PDF digital.
La IA puede inventarse un campo si la factura es rara: por eso el código envuelve el `JSON.parse` en try/catch. Revisa la hoja la primera semana.
Nombres de artículo que cambian entre facturas (`Aceite 5L` vs `ACEITE OLIVA 5 L`) rompen la comparación. Añade una pestaña de equivalencias o usa el código de artículo del proveedor si viene.
Facturas con varios adjuntos: el nodo solo lee `attachment_0`. Añade un **Loop Over Items** si tus proveedores mandan varias.

## Cuánto cuesta
Gmail, Sheets y n8n auto-alojado: gratis. La API de Anthropic se paga por uso: leer una factura de una página ronda 0,01-0,03 euros, así que con 100 facturas al mes hablas de 1-3 euros.
