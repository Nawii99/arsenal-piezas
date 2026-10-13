# Precio en riesgo: aviso cuando sube el coste de lo que…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Vigila el coste de tus materias primas o productos y calcula cómo queda tu margen con los precios de venta actuales. Te avisa cuando un producto empieza a perder dinero.

## Qué es y qué hace

Mantiene una tabla de productos con su coste actual y su precio de venta, y al actualizar un coste recalcula el margen. Si un producto baja de tu margen mínimo, indica cuánto subir el precio para recuperarlo. Puede leer la tarifa de un proveedor en CSV o un índice público. Se monta con n8n, Make o Zapier y necesita una hoja de catálogo.

## Cómo usarla

1. Crea la hoja Catalogo con sus columnas
2. Fija el margen mínimo de cada producto
3. Conecta la tarifa del proveedor si la tienes
4. Revisa los avisos la primera semana
5. Que lo revise un profesional

## Cuándo usarla

Cuando compras materiales o mercancía cuyo precio se mueve (alimentación, materiales de obra, energía, proveedores que suben tarifas) y no revisas los precios de venta hasta que ya duele.

## Cómo ganar dinero con ella

Detectar a tiempo que un producto ha pasado del 35 % al 12 % de margen. En un catálogo pequeño, ajustar tres precios recupera cientos de euros al mes.

- Control de márgenes para tiendas y obradores con muchos productos…
- Revisión de precios mensual como servicio para talleres y pequeños distribuidores…
- Actualización de tarifas por coste para negocios que compran materias primas…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

**Qué hace y para quién**
Mantiene una tabla de productos con su coste actual y su precio de venta, y cada vez que actualizas un coste (a mano, importando la tarifa del proveedor o leyendo un índice público) recalcula el margen. Si un producto cae por debajo de tu margen mínimo, te dice cuánto tendrías que subirlo para volver a estar donde querías.
Para tiendas, talleres, obradores, bares y cualquiera con lista de precios.

**Lo que necesitas antes**
- Hoja `Catalogo` en Sheets: `sku`, `nombre`, `coste_actual`, `coste_anterior`, `precio_venta`, `iva_pct`, `margen_minimo_pct`, `unidades_mes`.
- Opcional: URL de la tarifa del proveedor en CSV, o para energía la API pública de REE (`https://apidatos.ree.es`), gratis y sin clave.
- Gmail conectado.

**Los nodos, en orden**
1. **Schedule Trigger** — lunes a las 7:00. Añade también un **Google Sheets Trigger** «Row Updated» sobre `Catalogo` para que recalcule en cuanto cambies un coste a mano.
2. **HTTP Request** (opcional) — descarga la tarifa del proveedor en CSV: método GET a la URL, y detrás un **Extract from File** con operación «From CSV».
3. **Google Sheets** (Catálogo) — `Get Row(s)`.
4. **Merge** — modo «Combine» por la columna `sku` para pegar los costes nuevos al catálogo.
5. **Code** — calcula márgenes, variación y precio recomendado (código abajo).
6. **Filter** — deja solo los items con `alerta` distinto de vacío.
7. **Google Sheets** — «Update» de `coste_anterior` y de una columna `margen_actual_pct`.
8. **Sort** — por `impacto_mes` descendente, para que veas primero lo que más te duele.
9. **Gmail** — informe con tabla: producto, coste antes y ahora, margen antes y ahora, precio sugerido e impacto mensual en euros.

**El trozo de código (nodo Code)**
```javascript
const out = [];
for (const item of $input.all()) {
  const p = item.json;
  const num = v => Number(String(v ?? '').replace(',', '.')) || 0;
  const coste = num(p.coste_actual);
  const costeAnt = num(p.coste_anterior) || coste;
  const pvp = num(p.precio_venta);
  const ivaPct = num(p.iva_pct) || 21;
  const minimo = num(p.margen_minimo_pct) || 30;
  const uds = num(p.unidades_mes);
  if (!pvp || !coste) continue;
  const pvpSinIva = pvp / (1 + ivaPct / 100);
  const margenPct = ((pvpSinIva - coste) / pvpSinIva) * 100;
  const margenEuros = pvpSinIva - coste;
  const variacionCoste = costeAnt ? ((coste - costeAnt) / costeAnt) * 100 : 0;
  const pvpNecesarioSinIva = coste / (1 - minimo / 100);
  const pvpNecesario = pvpNecesarioSinIva * (1 + ivaPct / 100);
  let alerta = '';
  if (margenPct < 0) alerta = 'PIERDES DINERO';
  else if (margenPct < minimo) alerta = 'MARGEN BAJO';
  else if (variacionCoste > 10) alerta = 'COSTE SUBIENDO';
  out.push({ json: {
    sku: p.sku, nombre: p.nombre,
    coste_anterior: costeAnt.toFixed(2), coste_actual: coste.toFixed(2),
    variacion_coste_pct: variacionCoste.toFixed(1),
    precio_venta: pvp.toFixed(2),
    margen_actual_pct: margenPct.toFixed(1),
    margen_euros: margenEuros.toFixed(2),
    precio_sugerido: pvpNecesario.toFixed(2),
    subida_necesaria: (pvpNecesario - pvp).toFixed(2),
    impacto_mes: ((pvpNecesario - pvp) / (1 + ivaPct / 100) * uds).toFixed(2),
    alerta
  } });
}
return out;
```

**Cómo probarla**
- Coge un producto que vendas a 12,10 € con IVA (10 € sin IVA) y coste 7 €: el margen debe salir 30 %.
- Sube el coste a 9 € y vuelve a ejecutar: margen 10 %, alerta «MARGEN BAJO» y precio sugerido 15,57 € con IVA si tu mínimo es 30 %.
- Comprueba el `impacto_mes` con las unidades reales: es el número que de verdad te hace mover el precio.

**Qué puede salir mal**
- Mezclar precios con y sin IVA: es el error clásico. Deja claro en la cabecera de la hoja que `precio_venta` es con IVA y `coste_actual` sin IVA.
- Costes indirectos olvidados: el margen bruto no es el beneficio. Añade una columna de coste de mano de obra o portes si son relevantes.
- Subir precios de golpe: usa el informe para decidir, no para automatizar la subida. Sube escalonado y avisando.
- CSV del proveedor con separador punto y coma y decimales con coma: en el nodo «Extract from File» configura el delimitador correcto, si no te vendrán todos los costes a cero.

**Cuánto cuesta**
Gratis. Sheets, Gmail y n8n. Cuatro ejecuciones al mes más las que dispare el trigger de edición de la hoja.
