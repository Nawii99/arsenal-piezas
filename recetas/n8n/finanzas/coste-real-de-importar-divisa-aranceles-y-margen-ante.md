# Coste real de importar: divisa, aranceles y margen ante…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Vigila el tipo de cambio y te calcula el coste final en euros de una compra a proveedor extranjero incluyendo divisa, transporte, arancel e IVA de importación, y avisa si baja el margen.

## Qué es y qué hace

Cada día consulta el tipo de cambio oficial del BCE en la API gratuita de Frankfurter y recalcula en euros el coste desembarcado de cada producto importado: divisa, transporte, arancel e IVA de importación. Lo compara con tu precio de venta de Google Sheets y te avisa por Telegram si el margen baja del mínimo o si el cambio se mueve a tu favor.

## Cómo usarla

1. Preparar la hoja Importacion con Productos e Historico_cambio
2. Probar la URL de Frankfurter
3. Montar el cálculo diario en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando compras mercancía en dólares o yuanes y tu precio de venta se decide en euros meses antes de recibirla.

## Cómo ganar dinero con ella

Un 5 % de movimiento en el tipo de cambio se come el margen de un producto entero. Comprar el día bueno y saber tu coste real evita vender por debajo de coste.

- Calculadora de coste real de importación para tiendas que compran en Asia o EE. UU.
- Seguimiento semanal de margen en divisa para importadores con precios fijados en euros.
- Plantilla de coste desembarcado que el consultor de comercio exterior entrega a pequeños importadores.

**Precio orientativo:** 250–450 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada día consulta el tipo de cambio oficial del BCE, recalcula el coste desembarcado en euros de cada producto que compras fuera y compara con tu precio de venta para dar el margen actual.
Si el margen de algún producto cae por debajo del mínimo que has fijado, o si el cambio se mueve a tu favor más de un porcentaje, te avisa por Telegram. Para importadores, dropshipping y tiendas que compran en Asia o EE. UU.

## Lo que necesitas antes
No hace falta clave: la API de Frankfurter (`https://api.frankfurter.dev/v1/latest?base=EUR&symbols=USD,CNY`) publica los tipos oficiales del Banco Central Europeo, es gratis y sin registro.
Hoja de Google Sheets `Importacion` con pestaña `Productos`: `sku`, `nombre`, `moneda` (USD/CNY), `coste_unidad_divisa`, `unidades_por_caja`, `transporte_caja_eur`, `arancel_pct`, `pvp_eur`, `margen_minimo_pct`. Y pestaña `Historico_cambio`: `fecha`, `usd`, `cny`.
Los aranceles reales los miras una vez en la base TARIC de la Comisión Europea buscando tu código de mercancía, y los apuntas en la columna `arancel_pct`.
Bot de Telegram.

## Los nodos, en orden
**1. Schedule Trigger** — Cada día a las 16:30, `Europe/Madrid` (el BCE publica sobre las 16:00 CET).
**2. HTTP Request** (`Cambio`) — `GET` a `https://api.frankfurter.dev/v1/latest?base=EUR&symbols=USD,CNY`, sin autenticación.
**3. Google Sheets** (`Productos`) — `Get Row(s)`, pestaña `Productos`.
**4. Google Sheets** (`Historico`) — `Get Row(s)`, pestaña `Historico_cambio`.
**5. Code** (`Coste desembarcado`) — `Run Once for All Items`. Código abajo.
**6. Google Sheets** (`Guardar cambio`) — `Append`, pestaña `Historico_cambio`, con `fecha`, `usd`, `cny`.
**7. Filter** — `{{ $json.avisar }}` `is true`.
**8. Telegram** — `Send Message` con `={{ $json.mensaje }}`.

## El código del nodo Coste desembarcado
```javascript
const rates = $('Cambio').first().json.rates;
const hoy = new Date().toISOString().slice(0, 10);
const productos = $('Productos').all().map(i => i.json);
const hist = $('Historico').all().map(i => i.json).sort((a, b) => String(b.fecha).localeCompare(String(a.fecha)));
const previo = hist[0] || null;
const out = [];
for (const p of productos) {
  const tasa = rates[String(p.moneda).toUpperCase()];
  if (!tasa) continue;
  const costeEur = Number(p.coste_unidad_divisa) / tasa;
  const transporteUd = Number(p.transporte_caja_eur || 0) / Number(p.unidades_por_caja || 1);
  const arancel = costeEur * Number(p.arancel_pct || 0) / 100;
  const desembarcado = costeEur + transporteUd + arancel;
  const pvpSinIva = Number(p.pvp_eur) / 1.21;
  const margenPct = (1 - desembarcado / pvpSinIva) * 100;
  const minimo = Number(p.margen_minimo_pct || 25);
  const movCambio = previo && previo[String(p.moneda).toLowerCase()] ? (tasa / Number(previo[String(p.moneda).toLowerCase()]) - 1) * 100 : 0;
  const avisar = margenPct < minimo || Math.abs(movCambio) >= 1.5;
  const mensaje = `💱 ${p.nombre} (${p.sku})\nCambio EUR/${p.moneda}: ${tasa.toFixed(4)} (${movCambio >= 0 ? '+' : ''}${movCambio.toFixed(2)} % vs ayer)\nCoste desembarcado: ${desembarcado.toFixed(2)} €\nPVP sin IVA: ${pvpSinIva.toFixed(2)} €\nMargen: ${margenPct.toFixed(1)} % (mínimo ${minimo} %)${margenPct < minimo ? ' 🔴 POR DEBAJO' : ''}${movCambio > 1.5 ? '\n✅ El euro se ha fortalecido: buen momento para comprar.' : ''}`;
  out.push({ json: { sku: p.sku, coste_desembarcado: Number(desembarcado.toFixed(2)), margen_pct: Number(margenPct.toFixed(1)), avisar, mensaje, fecha: hoy, usd: rates.USD, cny: rates.CNY } });
}
return out;
```

## Cómo probarla
Ejecuta a mano con un producto real y comprueba el coste desembarcado con calculadora: coste en divisa dividido entre el tipo, más transporte por unidad, más arancel.
Baja el `margen_minimo_pct` de un producto a 90 para forzar el aviso y ver que Telegram funciona.

## Qué puede salir mal
El IVA de importación (21 %) lo pagas al despachar pero lo deduces después, por eso no entra en el coste: si estás en recargo de equivalencia sí es coste y tienes que sumarlo.
Frankfurter publica de lunes a viernes: en fin de semana devuelve el último día hábil, no es un error.
Aranceles: el porcentaje depende del código TARIC y del país de origen. No lo adivines, míralo una vez en la base TARIC y anótalo por producto.
El transporte por caja cambia con el flete marítimo: revísalo cada trimestre o el margen que ves será ficción.
Avisos diarios cansinos: si el umbral de 1,5 % te satura, súbelo a 3 % o pasa el flujo a ejecución semanal.

## Cuánto cuesta
API de Frankfurter: gratis y sin registro. Sheets, Telegram y n8n auto-alojado: gratis.
