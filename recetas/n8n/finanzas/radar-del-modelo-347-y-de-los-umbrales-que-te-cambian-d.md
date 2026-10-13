# Radar del modelo 347 y de los umbrales que te cambian d…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Vigila todo el año qué clientes y proveedores superan los 3.005,06 € y cuánto llevas facturado frente a los límites que te obligan a cambiar de régimen fiscal o a llevar más contabilidad.

## Qué es y qué hace

Recorre cada mes tus facturas emitidas y recibidas, acumula por NIF el total del año natural y marca a los terceros que superan los 3.005,06 euros del modelo 347. Además vigila tu facturación frente a los umbrales que tú fijes y avisa al llegar al 80 %. Se monta con n8n, Make o Zapier y necesita las hojas de facturas y compras.

## Cómo usarla

1. Crea las hojas Facturas y Compras con NIF e importes
2. Define los umbrales en la pestaña Umbrales
3. Conecta Gmail
4. Revisa los límites vigentes con tu gestor cada enero
5. Que lo revise un profesional

## Cuándo usarla

Cuando en enero tu gestor te pide los datos del 347 y no los tienes. O cuando creces y no sabes si vas a cruzar un límite que te complique la vida el año que viene.

## Cómo ganar dinero con ella

Evita la sanción por 347 mal presentado (mínimo 300 €) y te deja planificar con meses de margen en vez de descubrirlo en enero.

- Control del modelo 347 como servicio anual para autónomos con muchos clientes…
- Alerta de umbrales fiscales para pymes que crecen…
- Preparación de datos para la declaración informativa con el gestor…

**Precio orientativo:** 60–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

**Qué hace y para quién**
Cada mes recorre tus facturas emitidas y recibidas, acumula por NIF el total del año natural y marca a quien ya supera los 3.005,06 € (el umbral de la declaración informativa anual de operaciones con terceros, el modelo 347). Además vigila tu facturación total contra los umbrales que te interesan y te avisa cuando llegas al 80 % de cualquiera de ellos.
Para autónomos y pequeñas sociedades que quieren llegar a enero con los deberes hechos.

**Lo que necesitas antes**
- Hoja `Facturas` (emitidas) y hoja `Compras` (recibidas) en Sheets, ambas con `nif`, `nombre`, `fecha`, `base`, `iva`, `total`.
- Una pestaña `Umbrales` donde defines los límites que quieres vigilar y su valor: por ejemplo `347_tercero` = 3005.06, `objetivo_facturacion` = 60000, `alerta_al_pct` = 80.
- Gmail conectado.
- Importante: los umbrales fiscales concretos cambian con las leyes de presupuestos. Confirma los vigentes con tu gestor y déjalos en la pestaña `Umbrales`, no dentro del código.

**Los nodos, en orden**
1. **Schedule Trigger** — día 5 de cada mes a las 9:00, y además el 5 de enero (que es el aviso importante, antes de la campaña de febrero).
2. **Google Sheets** (Emitidas) — `Get Row(s)` de `Facturas`.
3. **Google Sheets** (Recibidas) — `Get Row(s)` de `Compras`.
4. **Google Sheets** (Umbrales) — `Get Row(s)` de `Umbrales`.
5. **Code** — agrupa por NIF, acumula año natural y compara con umbrales (código abajo).
6. **IF** — `{{ $json.hay_avisos }}` es true.
7. **Google Sheets** — «Append or Update» en una pestaña `347_Preparado` con NIF, nombre, total emitido y total recibido, desglosado por trimestres (que es como lo pide el modelo).
8. **Gmail** — informe mensual con la lista de terceros que ya superan el umbral y el porcentaje de tu objetivo de facturación.

**El trozo de código (nodo Code)**
```javascript
const umbrales = {};
for (const u of $('Umbrales').all()) umbrales[String(u.json.clave)] = Number(String(u.json.valor).replace(',', '.'));
const limite347 = umbrales['347_tercero'] || 3005.06;
const objetivo = umbrales['objetivo_facturacion'] || 0;
const pctAviso = umbrales['alerta_al_pct'] || 80;
const anio = String(new Date().getFullYear());
const trim = f => 'T' + (Math.floor(new Date(f).getMonth() / 3) + 1);
const acc = {};
const sumar = (filas, tipo) => {
  for (const it of filas) {
    const f = it.json;
    if (String(f.fecha).slice(0, 4) !== anio) continue;
    const nif = String(f.nif || '').toUpperCase().trim();
    if (!nif) continue;
    acc[nif] = acc[nif] || { nif, nombre: f.nombre, emitido: 0, recibido: 0, T1: 0, T2: 0, T3: 0, T4: 0 };
    const total = Number(String(f.total).replace(',', '.')) || 0;
    acc[nif][tipo] += total;
    acc[nif][trim(f.fecha)] += total;
  }
};
sumar($('Emitidas').all(), 'emitido');
sumar($('Recibidas').all(), 'recibido');
const facturado = Object.values(acc).reduce((s, a) => s + a.emitido, 0);
const superan = Object.values(acc).filter(a => a.emitido > limite347 || a.recibido > limite347)
  .map(a => ({ ...a, emitido: a.emitido.toFixed(2), recibido: a.recibido.toFixed(2) }));
const pctObjetivo = objetivo ? (facturado / objetivo) * 100 : 0;
const avisoObjetivo = objetivo && pctObjetivo >= pctAviso;
return [{ json: {
  anio,
  facturado_total: facturado.toFixed(2),
  pct_objetivo: pctObjetivo.toFixed(1),
  aviso_objetivo: avisoObjetivo,
  terceros_347: superan.length,
  detalle: superan,
  hay_avisos: superan.length > 0 || avisoObjetivo
} }];
```

**Cómo probarla**
- Mete tres facturas al mismo NIF que sumen 3.500 € en el año actual: debe aparecer en la lista.
- Cambia el año de esas facturas al anterior: debe desaparecer (el 347 va por año natural).
- Pon `objetivo_facturacion` en un número que ya hayas superado y comprueba que salta el aviso de umbral.

**Qué puede salir mal**
- NIF vacíos o mal escritos: son la causa número uno de errores en el 347. Añade una validación en Sheets y un aviso en el informe con «X facturas sin NIF».
- Confundir base e IVA: el 347 se declara con IVA incluido. Usa la columna `total`, no la `base`.
- Operaciones que no van al 347 (importaciones, algunas exportaciones, operaciones con retención ya informadas en otros modelos): márcalas con una columna `excluir_347` y fíltralas.
- Esto es una ayuda para tener los datos ordenados, no sustituye a tu gestor: la presentación la hace él con los datos limpios que le das.

**Cuánto cuesta**
Gratis. Doce ejecuciones al año. Lo único que necesitas es la disciplina de apuntar el NIF en cada factura.
