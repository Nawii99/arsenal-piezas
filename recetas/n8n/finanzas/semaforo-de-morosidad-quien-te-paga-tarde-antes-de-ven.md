# Semáforo de morosidad: quién te paga tarde antes de ven…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Calcula cuántos días tarda de media en pagarte cada cliente y le pone una nota de riesgo. Antes de aceptar un pedido grande, te dice si ese cliente es de fiar.

## Qué es y qué hace

Analiza tu histórico de facturas y calcula por cliente el retraso medio en días, el peor retraso y el importe pendiente, y le asigna un semáforo verde, ámbar o rojo. Además, un webhook permite consultar a un cliente concreto desde el móvil antes de aceptar un encargo. Se monta con n8n, Make o Zapier y necesita una hoja de facturas.

## Cómo usarla

1. Crea la hoja Facturas con fechas de emisión, vencimiento y cobro
2. Define los umbrales de cada color
3. Conecta Gmail o Telegram
4. Prueba la consulta con un cliente conocido
5. Que lo revise un profesional

## Cuándo usarla

Cuando vas a dar crédito (trabajar y cobrar después) a un cliente y no recuerdas si el anterior encargo lo pagó a 30 o a 90 días.

## Cómo ganar dinero con ella

Pedir anticipo a los clientes de riesgo alto reduce impagos. Un impago de 2.000 € equivale a vender 10.000 € al 20 % de margen: esto lo previene.

- Análisis de riesgo de impago para proveedores que dan crédito a clientes B2B…
- Política de anticipos automática para talleres y agencias…
- Informe de morosidad mensual para negocios con pagos a 60-90 días…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

**Qué hace y para quién**
Analiza tu histórico de facturas, calcula por cliente el retraso medio en días (DSO), el peor retraso y el importe pendiente ahora mismo, y asigna un semáforo verde, ámbar o rojo. Además tienes un webhook para preguntar por un cliente concreto desde el móvil antes de firmar un presupuesto.
Para negocios B2B, agencias, talleres y proveedores que trabajan con pago aplazado.

**Lo que necesitas antes**
- Hoja `Facturas` en Google Sheets con: `cliente`, `numero`, `total`, `fecha_emision`, `fecha_vencimiento`, `fecha_cobro` (vacía si no cobrada).
- n8n y Gmail o Telegram.
- Definir tus umbrales: verde hasta 5 días de retraso medio, ámbar hasta 20, rojo por encima.

**Los nodos, en orden**
1. **Schedule Trigger** — día 1 de cada mes a las 8:00. Y un segundo disparador **Webhook** (método GET, ruta `riesgo`) para consultas puntuales desde el móvil.
2. **Google Sheets** — `Get Row(s)` de `Facturas`.
3. **Code** (Scoring) — calcula DSO, riesgo y pendiente por cliente (código abajo).
4. **IF** — si viene del Webhook (`{{ $execution.mode }}` o mejor: comprueba `{{ $json.consulta }}`), devuelve solo ese cliente.
5. **Respond to Webhook** — devuelve el texto del riesgo del cliente consultado.
6. **Filter** (rama mensual) — deja solo clientes con riesgo `ROJO` o `AMBAR`.
7. **Google Sheets** — «Append or Update» en una pestaña `Riesgo` para tener la ficha siempre a mano.
8. **Gmail** — informe mensual: top 5 clientes que peor pagan y cuánto dinero tienes atrapado en cada uno.

**El trozo de código (nodo Code)**
```javascript
const filas = $input.all().map(i => i.json);
const hoy = new Date();
const dias = (a, b) => Math.round((new Date(b) - new Date(a)) / 86400000);
const acc = {};
for (const f of filas) {
  const c = String(f.cliente || '').trim();
  if (!c) continue;
  acc[c] = acc[c] || { cliente: c, retrasos: [], pendiente: 0, facturas: 0, vencidas: 0 };
  acc[c].facturas++;
  const venc = f.fecha_vencimiento || f.fecha_emision;
  if (f.fecha_cobro) {
    acc[c].retrasos.push(Math.max(0, dias(venc, f.fecha_cobro)));
  } else {
    acc[c].pendiente += Number(String(f.total).replace(',', '.')) || 0;
    if (new Date(venc) < hoy) acc[c].vencidas++;
  }
}
const out = Object.values(acc).map(a => {
  const media = a.retrasos.length ? a.retrasos.reduce((x, y) => x + y, 0) / a.retrasos.length : 0;
  const peor = a.retrasos.length ? Math.max(...a.retrasos) : 0;
  let riesgo = 'VERDE';
  if (media > 20 || a.vencidas >= 2) riesgo = 'ROJO';
  else if (media > 5 || a.vencidas === 1) riesgo = 'AMBAR';
  const consejo = riesgo === 'ROJO' ? 'Pide 50% por adelantado o cobro contra entrega' : riesgo === 'AMBAR' ? 'Pon vencimiento a 15 dias y domiciliacion' : 'Condiciones normales';
  return { json: { cliente: a.cliente, retraso_medio: Math.round(media), peor_retraso: peor, facturas: a.facturas, pendiente: a.pendiente.toFixed(2), vencidas: a.vencidas, riesgo, consejo } };
});
out.sort((x, y) => y.json.retraso_medio - x.json.retraso_medio);
return out;
```

**Cómo probarla**
- Añade una factura falsa cobrada con 45 días de retraso a un cliente: debe pasar a ROJO.
- Llama al webhook desde el navegador: `https://tu-n8n/webhook/riesgo?cliente=Talleres%20Perez`. Debe devolverte la ficha.
- Comprueba que un cliente sin facturas cobradas y sin vencidas sale VERDE con retraso 0 (es correcto: no hay historial).

**Qué puede salir mal**
- Nombres de cliente escritos de tres formas distintas («Talleres Pérez», «TALLERES PEREZ SL»): normaliza con `.toUpperCase()` y quitando `SL`, `S.L.` y tildes, o mejor usa el NIF como clave.
- Fechas vacías o mal formateadas rompen el cálculo: formatea las columnas de fecha como texto `AAAA-MM-DD` en Sheets.
- Un cliente que paga por adelantado puede salir con retraso negativo: el `Math.max(0, ...)` ya lo corta.
- El webhook es público: añade en el nodo Webhook autenticación «Header Auth» con una clave tuya.

**Cuánto cuesta**
Gratis entero. Solo consume una ejecución al mes más las consultas puntuales del webhook.
