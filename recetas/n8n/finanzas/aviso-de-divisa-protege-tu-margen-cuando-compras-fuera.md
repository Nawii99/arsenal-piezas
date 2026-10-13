# Aviso de divisa: protege tu margen cuando compras fuera…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Vigila a diario el tipo de cambio de las monedas en las que compras o cobras y te avisa cuando se mueve lo suficiente como para tocar tus precios o adelantar una compra.

## Qué es y qué hace

Cada día laborable consulta el tipo de cambio oficial del BCE en la API gratuita de Frankfurter, lo guarda en una hoja y lo compara con la media de los últimos 30 días. Si la variación supera tu umbral, avisa por Telegram y calcula cuánto mueve tu margen. Se monta con n8n, Make o Zapier y no requiere claves.

## Cómo usarla

1. Crea la hoja Divisas y la pestaña Config
2. Fija tu par, tu volumen y tu umbral
3. Conecta Telegram
4. Revisa el cálculo de margen tras el primer aviso
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando compras a proveedores en dólares, libras o yuanes, o cobras a clientes de fuera de la zona euro, y el margen se te come el cambio sin que te enteres.

## Cómo ganar dinero con ella

Un movimiento del 5% en el dólar sobre 20.000 € de compras anuales son 1.000 €. Comprar en la semana buena en vez de en la mala vale ese dinero.

- Seguimiento de divisas para importadores pequeños con compras en dólares…
- Alerta de cambio para tiendas que compran a proveedores asiáticos…
- Modelo de precios con sensibilidad al tipo de cambio para freelancers…

**Precio orientativo:** 60–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada día laborable consulta el tipo de cambio oficial del Banco Central Europeo a través de la API gratuita y sin clave de Frankfurter, lo guarda en una hoja y lo compara con la media de los últimos 30 días.
Si la variación supera el umbral que tú marques, te avisa por Telegram diciéndote qué significa en euros para tu volumen de compra y cuánto se te mueve el margen.
Para importadores, tiendas que compran en Asia o EE. UU., y freelancers que facturan en dólares o libras.

## Lo que necesitas antes
Nada de claves: la API `https://api.frankfurter.dev/v1/latest` es pública y gratuita, con datos del BCE.
Una hoja «Divisas» con columnas: Fecha, Par, Tipo.
Una pestaña `Config` con: Par (por ejemplo USD), VolumenAnual (tu compra anual en esa moneda), UmbralPct (por ejemplo 2), CostePorUnidad (lo que te cuesta una unidad de producto en esa divisa), PVP (tu precio de venta en euros).
Bot de Telegram con token y chat ID.

## Los nodos, en orden
**Schedule Trigger**: cada día a las 17:00 (el BCE publica sobre las 16:00 CET), Europe/Madrid.
**Google Sheets** (renombra a `Config`): Get Row(s) de la pestaña Config.
**HTTP Request** (renombra a `Hoy`): GET a `=https://api.frankfurter.dev/v1/latest?base=EUR&symbols={{ $json.Par }}`.
**HTTP Request** (renombra a `Historico`): GET a `=https://api.frankfurter.dev/v1/{{ new Date(Date.now()-30*86400000).toISOString().slice(0,10) }}..?base=EUR&symbols={{ $('Config').first().json.Par }}`.
**Code**: modo «Run Once for All Items».
```javascript
const cfg = $('Config').first().json;
const par = cfg.Par;
const num = (v) => Number(String(v ?? '0').replace(',', '.')) || 0;
const hoy = $('Hoy').first().json;
const tipoHoy = hoy.rates[par];
const serie = $('Historico').first().json.rates;
const valores = Object.values(serie).map(r => r[par]).filter(Boolean);
const media = valores.reduce((a,b)=>a+b,0) / valores.length;
const variacion = ((tipoHoy - media) / media) * 100;
const umbral = num(cfg.UmbralPct || 2);
const volumen = num(cfg.VolumenAnual);
const impactoAnual = volumen / tipoHoy - volumen / media;
const coste = num(cfg.CostePorUnidad);
const pvp = num(cfg.PVP);
const costeEurHoy = coste / tipoHoy;
const margenHoy = pvp > 0 ? ((pvp - costeEurHoy) / pvp) * 100 : 0;
const costeEurMedia = coste / media;
const margenMedia = pvp > 0 ? ((pvp - costeEurMedia) / pvp) * 100 : 0;
const sube = variacion > 0;
const texto = `DIVISA EUR/${par}\n\nHoy: ${tipoHoy.toFixed(4)}\nMedia 30 días: ${media.toFixed(4)}\nVariación: ${variacion.toFixed(2)}%\n\n${sube ? 'El euro está más fuerte: comprar en ' + par + ' te sale MÁS BARATO.' : 'El euro está más débil: comprar en ' + par + ' te sale MÁS CARO.'}\n\nSobre tu volumen anual de ${volumen} ${par}: ${impactoAnual >= 0 ? 'ahorras' : 'te cuesta'} ${Math.abs(impactoAnual).toFixed(0)} € al año frente a la media.\n\nTu margen por unidad hoy: ${margenHoy.toFixed(1)}% (media del mes: ${margenMedia.toFixed(1)}%)`;
return [{ json: { Fecha: hoy.date, Par: par, Tipo: tipoHoy, avisar: Math.abs(variacion) >= umbral, texto } }];
```
**Google Sheets**: Append Row en «Divisas» con Fecha, Par y Tipo (histórico propio, por si algún día quieres gráficas).
**IF**: `={{ $json.avisar }}` es verdadero.
**Telegram** (rama true): Send Message con `={{ $json.texto }}`.

## Cómo probarla
Ejecuta a mano: aunque no se cumpla el umbral, mira el resultado del nodo Code y verifica el tipo contra lo que dice Google al buscar «euro dólar».
Baja UmbralPct a 0 durante un día para asegurarte de que el mensaje de Telegram llega y se lee bien.
Comprueba que el cálculo de margen te da lo mismo que tu Excel de costes; si no, revisa si tu CostePorUnidad está en divisa o ya en euros (aquí tiene que estar en divisa).

## Qué puede salir mal
El BCE no publica fines de semana ni festivos: la API devolverá el último día hábil, así que verás el mismo dato el sábado. No pasa nada, pero puedes saltarte esos días con un IF.
Confundir la dirección del cambio: la API da cuántos dólares vale un euro. Si el número sube, el euro está fuerte y comprar fuera es más barato.
Tu banco no te da el tipo del BCE: te cobra entre un 0,5% y un 3% de diferencial. Usa este aviso como señal, no como precio final.
Si además cambias divisa de verdad, mira comparadores como Wise antes de mover dinero.
Frankfurter no tiene límite duro documentado, pero una consulta al día es un uso perfectamente razonable.

## Cuánto cuesta
Gratis del todo: Frankfurter no cobra ni pide registro, y Sheets y Telegram tampoco.
