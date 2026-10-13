# Vigilante de gastos en dólares y sobrecoste por cambio…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Detecta los cargos en divisa extranjera, calcula el coste real con la comisión de tu banco y te dice cuánto te ha costado de más pagar en dólares en lugar de en euros.

## Qué es y qué hace

Detecta los cargos en divisa distinta del euro en tu banco, consulta el tipo oficial del BCE de ese día y compara con lo que el banco te cobró en euros. La diferencia es la comisión oculta, que se muestra por comercio en euros y en porcentaje. Se monta con n8n, Make o Zapier y usa GoCardless y la API de Frankfurter.

## Cómo usarla

1. Conecta tu cuenta o tarjeta con GoCardless
2. Crea la hoja Divisas
3. Ajusta la lista de comercios en divisa
4. Revisa el primer informe mensual
5. Que lo revise un profesional

## Cuándo usarla

Cuando pagas software, publicidad o proveedores en USD o GBP y no sabes cuánto te está costando realmente el tipo de cambio y las comisiones.

## Cómo ganar dinero con ella

La comisión típica de cambio de un banco tradicional es del 3 %. Sobre 800 €/mes en herramientas son 288 €/año que ahorras pasando a una tarjeta sin comisión de cambio.

- Auditoría de comisiones de cambio para negocios digitales que pagan software en dólares…
- Informe de costes de divisa para agencias con publicidad fuera de la zona euro…
- Análisis de tarjetas sin comisión de cambio como consultoría para autónomos…

**Precio orientativo:** 60–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

**Qué hace y para quién**
Cada mes localiza los movimientos en divisa distinta del euro, consulta el tipo oficial del Banco Central Europeo de ese día y compara con lo que realmente te cobró el banco. La diferencia es la comisión oculta. Te la enseña en euros y en porcentaje, por comercio.
Para negocios digitales, tiendas online y agencias que compran software y publicidad fuera de la zona euro.

**Lo que necesitas antes**
- n8n y GoCardless Bank Account Data conectado a la cuenta o tarjeta donde pagas esos servicios.
- Nada más: la API de tipos de cambio del BCE vía Frankfurter (`https://api.frankfurter.app`) es gratuita y sin clave.
- Hoja `Divisas` en Sheets.

**Los nodos, en orden**
1. **Schedule Trigger** — día 3 de cada mes a las 9:00.
2. **HTTP Request** (Token) — POST a `https://bankaccountdata.gocardless.com/api/v2/token/new/`.
3. **HTTP Request** (Movimientos) — GET `/api/v2/accounts/{ID}/transactions/?date_from={{ $now.minus(1,'months').startOf('month').toFormat('yyyy-MM-dd') }}&date_to={{ $now.minus(1,'months').endOf('month').toFormat('yyyy-MM-dd') }}`.
4. **Code** (Filtrar divisa) — se queda con los movimientos cuyo `currencyExchange` exista o cuyo concepto contenga `USD`, `GBP` o `CHF`.
5. **Split In Batches** — tamaño 1.
6. **HTTP Request** (Tipo BCE) — GET `https://api.frankfurter.app/{{ $json.fecha }}?from={{ $json.divisa }}&to=EUR`. Sin autenticación.
7. **Code** (Comparar) — calcula el coste teórico y el sobrecoste real (código abajo).
8. **Google Sheets** — «Append» a `Divisas`.
9. **Aggregate** + **Gmail** — resumen mensual: total pagado en divisa, sobrecoste total y el comercio donde más te clavan.

**El trozo de código (nodo Code de comparación)**
```javascript
const mov = $('Split In Batches').first().json;
const tipos = $json.rates;
const divisa = mov.divisa;
const importeDivisa = Math.abs(Number(mov.importe_divisa));
const cargadoEuros = Math.abs(Number(mov.importe_euros));
const tipoBCE = tipos && tipos.EUR ? tipos.EUR : null;
if (!tipoBCE) return [{ json: { error: 'Sin tipo BCE para ' + mov.fecha, comercio: mov.comercio } }];
const costeTeorico = importeDivisa * tipoBCE;
const sobrecoste = cargadoEuros - costeTeorico;
const pct = (sobrecoste / costeTeorico) * 100;
return [{ json: {
  fecha: mov.fecha,
  comercio: mov.comercio,
  divisa,
  importe_divisa: importeDivisa.toFixed(2),
  cargado_euros: cargadoEuros.toFixed(2),
  tipo_bce: tipoBCE,
  coste_teorico: costeTeorico.toFixed(2),
  sobrecoste: sobrecoste.toFixed(2),
  sobrecoste_pct: pct.toFixed(2),
  aviso: pct > 2 ? 'COMISION ALTA: cambia de tarjeta' : ''
} }];
```

**Cómo probarla**
- Llama a mano en el navegador a `https://api.frankfurter.app/2026-06-15?from=USD&to=EUR` y comprueba que devuelve un tipo.
- Coge un cargo real en dólares de tu extracto y haz la cuenta a mano: si el sobrecoste te sale entre el 0 y el 4 %, el cálculo está bien. Si sale 30 %, has mezclado divisas al revés.
- Prueba con un mes sin cargos en divisa: el flujo debe terminar sin enviar correo (pon un **IF** con «no hay items»).

**Qué puede salir mal**
- Frankfurter no tiene datos de fines de semana ni festivos: si la fecha cae en sábado devuelve el día hábil anterior automáticamente, pero comprueba el campo `date` de la respuesta.
- No todos los bancos devuelven el bloque `currencyExchange` en la API: si el tuyo no lo hace, extrae el importe en divisa del texto del concepto con una expresión regular tipo `/([0-9.,]+)\s?(USD|GBP)/`.
- El sobrecoste incluye a veces el margen del propio comercio (Google Ads factura en euros pero con su propio cambio): no lo confundas con la comisión del banco.
- Límite de peticiones de Frankfurter: es generoso, pero mete un **Wait** de 1 segundo en el bucle si tienes muchos movimientos.

**Cuánto cuesta**
Gratis del todo: Frankfurter no cobra ni pide clave, GoCardless es gratis para uso propio, y una ejecución al mes cabe en cualquier plan.
