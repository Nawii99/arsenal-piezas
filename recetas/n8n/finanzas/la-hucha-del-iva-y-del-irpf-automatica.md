# La hucha del IVA y del IRPF automática…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Calcula cada semana cuánto IVA e IRPF llevas acumulado del trimestre y te dice el importe exacto que deberías apartar a una cuenta aparte para no llevarte el susto en el modelo 303.

## Qué es y qué hace

Cada lunes suma las facturas emitidas y los gastos deducibles del trimestre en curso desde dos pestañas de Google Sheets, calcula el IVA repercutido menos el soportado y la retención de IRPF acumulada, y te dice por Telegram cuánto apartar. Asume IVA general trimestral y estimación directa; si tu régimen es otro, hay que cambiar las fórmulas.

## Cómo usarla

1. Preparar la hoja Impuestos con Emitidas y Gastos
2. Crear el bot de Telegram y el chat_id
3. Montar el cálculo semanal en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando llega el día 20 de enero, abril, julio u octubre y descubres que el dinero de Hacienda ya te lo habías gastado.

## Cómo ganar dinero con ella

Evita recargos del 1 al 15 % por aplazamientos y pagos fuera de plazo, y te quita la sensación de tener más dinero del que realmente tienes.

- Cálculo semanal de provisión de IVA e IRPF para autónomos que no quieren sorpresas en el modelo 303.
- Revisión trimestral de la reserva fiscal con el asesor antes de presentar los modelos.
- Plantilla de control fiscal de tesorería para micro-SL en régimen general de IVA.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Suma las facturas emitidas y los gastos deducibles del trimestre en curso, calcula IVA repercutido menos soportado y la retención de IRPF acumulada, y te dice cuánto llevas debiendo a Hacienda a día de hoy.
Cada lunes te manda el número y, si quieres, la diferencia con la semana pasada: eso es lo que tienes que mover a tu cuenta de impuestos. Para autónomos y micro-SL en España.

## Lo que necesitas antes
Hoja de Google Sheets `Impuestos` con dos pestañas. `Emitidas`: `fecha`, `cliente`, `base`, `tipo_iva` (21/10/4/0), `retencion_irpf` (0 o 15 o 7), `total`. `Gastos`: `fecha`, `proveedor`, `base`, `tipo_iva`, `deducible_pct` (100, 50, 0).
Bot de Telegram (token de @BotFather y tu `chat_id`).
Tener claro tu régimen: este flujo asume IVA general trimestral y estimación directa. Si estás en recargo de equivalencia o módulos, cambia las fórmulas del Code.

## Los nodos, en orden
**1. Schedule Trigger** — `Weeks`, lunes, 09:00, zona horaria `Europe/Madrid`.
**2. Google Sheets** (`Emitidas`) — `Get Row(s)`, pestaña `Emitidas`.
**3. Google Sheets** (`Gastos`) — `Get Row(s)`, pestaña `Gastos`.
**4. Code** (`Calcular trimestre`) — `Run Once for All Items`. Código abajo.
**5. Google Sheets** (`Historico hucha`) — `Append`, pestaña `Hucha`, columnas `fecha`, `trimestre`, `iva_a_pagar`, `irpf_retenido`, `total_apartar`.
**6. Telegram** — `Send Message` con `={{ $json.mensaje }}`.
**7. IF** opcional — Si `{{ $json.dias_para_plazo }}` `is less than` `10`, manda un segundo aviso más insistente con el recordatorio de presentar el 303 y el 130.

## El código del nodo Calcular trimestre
```javascript
const emitidas = $('Emitidas').all().map(i => i.json);
const gastos = $('Gastos').all().map(i => i.json);
const hoy = new Date();
const q = Math.floor(hoy.getMonth() / 3);
const desde = new Date(hoy.getFullYear(), q * 3, 1);
const dentro = f => { const d = new Date(f); return d >= desde && d <= hoy; };
let ivaRep = 0, ivaSop = 0, irpf = 0, baseIng = 0, baseGas = 0;
for (const e of emitidas) {
  if (!dentro(e.fecha)) continue;
  const base = Number(e.base || 0);
  baseIng += base;
  ivaRep += base * Number(e.tipo_iva || 0) / 100;
  irpf += base * Number(e.retencion_irpf || 0) / 100;
}
for (const g of gastos) {
  if (!dentro(g.fecha)) continue;
  const base = Number(g.base || 0);
  const pct = Number(g.deducible_pct ?? 100) / 100;
  baseGas += base * pct;
  ivaSop += base * Number(g.tipo_iva || 0) / 100 * pct;
}
const ivaPagar = Math.max(0, ivaRep - ivaSop);
const beneficio = baseIng - baseGas;
const pagoFraccionado = Math.max(0, beneficio * 0.20 - irpf);
const finQ = new Date(hoy.getFullYear(), q * 3 + 3, 20);
const dias = Math.ceil((finQ - hoy) / 86400000);
const mensaje = `🏦 Hucha de impuestos (T${q + 1})\nIVA a pagar: ${ivaPagar.toFixed(2)} €\nPago fraccionado IRPF (mod. 130): ${pagoFraccionado.toFixed(2)} €\nTOTAL a apartar hoy: ${(ivaPagar + pagoFraccionado).toFixed(2)} €\nQuedan ${dias} días para el día 20.`;
return [{ json: { trimestre: `T${q + 1}`, iva_a_pagar: Number(ivaPagar.toFixed(2)), irpf_retenido: Number(irpf.toFixed(2)), total_apartar: Number((ivaPagar + pagoFraccionado).toFixed(2)), dias_para_plazo: dias, mensaje, fecha: hoy.toISOString().slice(0, 10) } }];
```

## Cómo probarla
Mete dos facturas emitidas del trimestre actual y un gasto, ejecuta a mano y comprueba el IVA con una calculadora. Con base 1000 al 21 % el IVA repercutido debe salir 210.
Prueba una factura con retención del 15 % para ver que el pago fraccionado baja.

## Qué puede salir mal
Facturas con varias líneas y tipos distintos: divídelas en varias filas en la hoja, una por tipo de IVA.
Fechas mal formateadas: guarda `fecha` como texto `yyyy-mm-dd`. Si Sheets te las convierte, formatea la columna como texto antes de escribir.
Este cálculo es una estimación de gestión, no una liquidación oficial: intracomunitarias, inversión del sujeto pasivo y bienes de inversión no están contemplados. Enséñaselo a tu asesoría antes de fiarte del número.
Si un trimestre te sale IVA a compensar, el flujo lo pone a 0 y no lo arrastra al siguiente. Añade una fila manual en `Gastos` para arrastrarlo si te pasa.

## Cuánto cuesta
Gratis entero: Sheets, Telegram y n8n auto-alojado.
