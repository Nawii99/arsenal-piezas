# Calculadora de licencias de uso desde tu web…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Un formulario en tu web calcula el precio de la cesión de derechos según uso, territorio y duración, y manda al cliente el presupuesto por email en un minuto.

## Qué es y qué hace

Recibe por formulario el tipo de uso, territorio, duración y número de imágenes, aplica tu tabla de multiplicadores y calcula un precio. Guarda la petición en una hoja y envía dos correos: el presupuesto al cliente y el aviso para ti. Entran datos del formulario y salen presupuestos de licencia y registros. Para fotógrafos que ceden derechos a marcas o editoriales, con n8n y Gmail.

## Cómo usarla

1. Define la tabla de multiplicadores por uso y territorio
2. Crea el formulario con n8n Form Trigger
3. Prepara la hoja de licencias
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando te pidan «cuánto por usar esta foto en una valla en Madrid seis meses» y tardes días en contestar, o cuando improvises precios y te dejes dinero.

## Cómo ganar dinero con ella

Contestar en minutos en vez de días sube el cierre de presupuestos notablemente, y tarificar por uso en vez de a ojo suele multiplicar por dos o tres la licencia.

- Implantación de calculadora de licencias para fotógrafos que venden uso comercial, cobrada por puesta en marcha.
- Gestión mensual de presupuestos de licencia y seguimiento de cierres, por cuota.
- Plantilla de tarifas por uso vendida a agencias pequeñas de imagen.

**Precio orientativo:** 150–300 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recibe los datos de un formulario (tipo de uso, territorio, duración, número de imágenes) mediante un webhook, aplica tu tabla de multiplicadores y devuelve un precio. Guarda la petición en una hoja y manda dos emails: el presupuesto al cliente y el aviso a ti.
Es para fotógrafos que licencian imágenes a marcas, editoriales o agencias y quieren dejar de tarificar de oído.

## Lo que necesitas antes
- Un formulario. Lo más fácil: usa el nodo **n8n Form Trigger** en vez de un webhook, que te genera la página del formulario sin tocar HTML. Si prefieres tu web, usa **Webhook** y apunta ahí tu formulario con `method="POST"`.
- Credencial de Gmail en n8n.
- Hoja de Google Sheets `licencias` con columnas: `fecha`, `nombre`, `email`, `empresa`, `uso`, `territorio`, `meses`, `imagenes`, `precio`.
- Tu tarifa base decidida. Ejemplo de partida en España para foto de producto: 250 € por imagen y uso, sobre el que se aplican los multiplicadores.

## Los nodos, en orden
1. **n8n Form Trigger** — Form Title: `Presupuesto de licencia de imagen`. Campos: `nombre` (texto, obligatorio), `email` (email, obligatorio), `empresa` (texto), `uso` (desplegable: `web-redes`, `catalogo-impreso`, `prensa`, `exterior-valla`, `packaging`, `campana-completa`), `territorio` (desplegable: `local`, `nacional`, `europa`, `mundial`), `meses` (número), `imagenes` (número), `notas` (texto largo).
2. **Code** — Mode: `Run Once for Each Item`. Calcula el precio (código abajo).
3. **Google Sheets** — Operation: `Append Row` sobre la pestaña `licencias`, mapeando todos los campos.
4. **Gmail** (renómbralo «Al cliente») — Operation: `Send`, To: `{{ $json.email }}`, Subject: `Presupuesto de licencia — {{ $json.imagenes }} imagen(es)`, Message (activa HTML): el texto con el desglose. Incluye siempre `Presupuesto válido 30 días. La cesión no es exclusiva salvo acuerdo aparte. IVA no incluido.`
5. **Gmail** (renómbralo «Aviso a mí») — To: tu correo, Subject: `Nueva petición de licencia de {{ $json.empresa }} — {{ $json.precio }} €`.

## El código del nodo Code
```javascript
const d = $json;
const BASE = 250; // tu tarifa base por imagen y uso, en euros
const usos = { 'web-redes': 1, 'catalogo-impreso': 1.4, 'prensa': 1.6, 'exterior-valla': 3, 'packaging': 3.5, 'campana-completa': 5 };
const territorios = { 'local': 1, 'nacional': 1.5, 'europa': 2.2, 'mundial': 3 };
const meses = Math.max(1, Number(d.meses) || 12);
const imagenes = Math.max(1, Number(d.imagenes) || 1);
const factorTiempo = meses <= 3 ? 0.6 : meses <= 12 ? 1 : meses <= 24 ? 1.6 : 2.2;
const mUso = usos[d.uso] || 1;
const mTerr = territorios[d.territorio] || 1;
// descuento por volumen: la 2a-5a imagen al 70%, de la 6a en adelante al 50%
let unidades = 0;
for (let i = 1; i <= imagenes; i++) unidades += i === 1 ? 1 : i <= 5 ? 0.7 : 0.5;
const bruto = BASE * mUso * mTerr * factorTiempo * unidades;
const precio = Math.round(bruto / 10) * 10;
const desglose = 'Base ' + BASE + ' € x uso ' + mUso + ' x territorio ' + mTerr + ' x duración ' + factorTiempo + ' x ' + unidades.toFixed(2) + ' unidades';
return { json: { ...d, fecha: new Date().toISOString().slice(0, 10), precio, desglose } };
```

## Cómo probarla
- Rellena el formulario tú mismo con el caso más caro (packaging, mundial, 36 meses, 10 imágenes) y con el más barato (web-redes, local, 3 meses, 1 imagen). Mira si los dos precios te parecen defendibles delante de un cliente. Si no, ajusta `BASE` y los multiplicadores; el código está para que los toques.
- Comprueba que el email llega a spam o no: manda una prueba a una dirección tuya que no sea de Gmail.
- Verifica que la fila se escribe en la hoja aunque el campo `notas` vaya vacío.

## Qué puede salir mal
- **Clientes que juegan con el formulario**: alguien meterá 999 imágenes. Pon en el campo un máximo, y añade un **IF** que, si el precio pasa de X, no mande el precio sino un «te llamo para afinarlo». Los encargos grandes se cierran hablando.
- **Precio publicado = techo**: al automatizar corres el riesgo de quedarte anclado a tu tarifa. Revisa `BASE` cada seis meses.
- **IVA y retención**: el email debe decir «IVA no incluido». Si facturas a empresas españolas siendo autónomo, además aplica retención de IRPF; no la metas en el cálculo, indícalo en las condiciones.
- **Duplicados**: si el cliente pulsa enviar dos veces recibirás dos filas. Añade un **Google Sheets** de lectura y un **IF** que descarte el mismo email en los últimos 10 minutos.
- **El webhook no responde**: si usas el nodo **Webhook** en vez del Form Trigger, recuerda añadir un **Respond to Webhook** al final o el formulario se quedará colgado.

## Cuánto cuesta
- n8n auto-alojado: gratis; el Form Trigger genera la página del formulario sin coste.
- Gmail: gratis (límite de 500 envíos al día en cuentas normales, de sobra).
- Total: 0 €, salvo el VPS si lo alojas fuera de casa (5 € al mes).
