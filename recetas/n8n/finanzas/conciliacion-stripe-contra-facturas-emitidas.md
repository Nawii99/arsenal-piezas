# Conciliación Stripe contra facturas emitidas…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cruza cada cobro que entra por Stripe con tus facturas emitidas y te saca dos listas: cobros sin factura y facturas sin cobrar. Todo en una hoja que puedes mandar a la asesoría.

## Qué es y qué hace

Cada lunes descarga los cobros de Stripe del mes con una clave restringida de solo lectura y los compara con la hoja de facturas emitidas en Google Sheets. Marca los descuadres en ambos sentidos y envía un correo con lo cobrado, lo facturado y la lista de lo que falta. Sirve a negocios que cobran online y facturan con otra herramienta.

## Cómo usarla

1. Crear la clave restringida de Stripe con permiso Read
2. Preparar la hoja Facturacion con Facturas y Descuadres
3. Montar el flujo semanal en n8n con envío por correo
4. Que lo revise un profesional

## Cuándo usarla

Cuando cobras online y facturas por otro lado (Holded, Excel, Word) y nunca sabes si están todas cuadradas.

## Cómo ganar dinero con ella

Evita sanciones por facturas que faltan y descubre cobros que nunca se facturaron. Sustituye 2-3 horas de cuadre manual al mes.

- Cuadre mensual de cobros Stripe y facturas para pymes que se lo pasan a la asesoría.
- Revisión periódica de descuadres para tiendas online con cobros por enlace de pago.
- Montaje de un informe de conciliación que el autónomo envía al gestor cada mes.

**Precio orientativo:** 200–400 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada lunes descarga los cobros de Stripe del mes en curso, los compara contra la hoja donde llevas tus facturas emitidas y marca los descuadres en las dos direcciones.
Te manda un email con el resumen: cuánto has cobrado, cuánto has facturado y la lista concreta de lo que falta. Para autónomos y pequeñas empresas que venden online o cobran servicios con enlace de pago.

## Lo que necesitas antes
Cuenta de Stripe y una clave secreta de solo lectura: panel de Stripe > Desarrolladores > Claves de API > `Crear clave restringida`, con permiso `Read` en `Charges` y `Balance transactions`. Empieza por `rk_live_`.
Una hoja de Google Sheets `Facturacion` con dos pestañas. Pestaña `Facturas` con columnas: `numero`, `fecha`, `cliente`, `email`, `base`, `iva`, `total`, `ref_cobro`. Pestaña `Descuadres` con: `tipo`, `fecha`, `referencia`, `cliente`, `importe`.
Costumbre imprescindible: cuando emitas la factura, pega en la columna `ref_cobro` el identificador del cobro de Stripe (`ch_...` o `pi_...`). Si no lo haces, el cruce se hace por importe y fecha, que es menos fiable.
Cuenta de Gmail conectada en n8n con credencial OAuth2 (Google Cloud Console > APIs y servicios > Credenciales > ID de cliente OAuth, tipo Aplicación web, y pegar la URL de callback que te da n8n).

## Los nodos, en orden
**1. Schedule Trigger** — Modo `Weeks`, lunes, 08:00, zona horaria `Europe/Madrid`.
**2. HTTP Request** (`Cobros Stripe`) — `GET` a `https://api.stripe.com/v1/charges`. Authentication: `Generic Credential Type` > `Header Auth`, nombre `Authorization`, valor `Bearer rk_live_TU_CLAVE`. Query Parameters: `limit` = `100`, `created[gte]` = `={{ Math.floor($now.startOf('month').toSeconds()) }}`.
**3. Google Sheets** (`Leer facturas`) — Operación `Get Row(s)`, documento `Facturacion`, hoja `Facturas`.
**4. Code** (`Cruzar`) — Modo `Run Once for All Items`. Código abajo. Conecta al Code tanto el nodo 2 como el 3 (el Code lee ambos con `$('nombre').all()`).
**5. Google Sheets** (`Volcar descuadres`) — Operación `Append or Update`, hoja `Descuadres`, columna de comparación `referencia`.
**6. Code** (`Resumen`) o directamente **Gmail** — Operación `Send`, a tu propio correo, asunto `Conciliación Stripe {{ $now.toFormat('dd/MM/yyyy') }}`, cuerpo en HTML con el resumen del Code.

## El código del nodo Cruzar
```javascript
const cobros = $('Cobros Stripe').first().json.data || [];
const facturas = $('Leer facturas').all().map(i => i.json);
const refsFactura = new Set(facturas.map(f => String(f.ref_cobro || '').trim()).filter(Boolean));
const out = [];
let totalCobrado = 0;
for (const c of cobros) {
  if (c.status !== 'succeeded' || c.refunded) continue;
  const importe = c.amount / 100;
  totalCobrado += importe;
  if (!refsFactura.has(c.id) && !refsFactura.has(c.payment_intent)) {
    out.push({ json: { tipo: 'COBRO SIN FACTURA', fecha: new Date(c.created * 1000).toISOString().slice(0, 10), referencia: c.id, cliente: c.billing_details?.email || c.receipt_email || '-', importe } });
  }
}
const idsCobro = new Set(cobros.filter(c => c.status === 'succeeded').flatMap(c => [c.id, c.payment_intent]));
let totalFacturado = 0;
for (const f of facturas) {
  totalFacturado += Number(f.total || 0);
  const ref = String(f.ref_cobro || '').trim();
  if (!ref || !idsCobro.has(ref)) {
    out.push({ json: { tipo: 'FACTURA SIN COBRO', fecha: f.fecha, referencia: f.numero, cliente: f.cliente, importe: Number(f.total || 0) } });
  }
}
out.push({ json: { tipo: 'RESUMEN', fecha: new Date().toISOString().slice(0, 10), referencia: '-', cliente: `Cobrado ${totalCobrado.toFixed(2)} € / Facturado ${totalFacturado.toFixed(2)} €`, importe: Number((totalCobrado - totalFacturado).toFixed(2)) } });
return out;
```

## Cómo probarla
Ejecuta a mano con dos o tres facturas de prueba en la hoja, una con `ref_cobro` correcto y otra inventada. Debes ver exactamente un descuadre.
Usa primero la clave de test de Stripe (`rk_test_`) y el modo test del panel para no tocar datos reales.

## Qué puede salir mal
Stripe devuelve como máximo 100 cobros por llamada. Si superas eso al mes, añade un nodo **HTTP Request** en bucle usando `starting_after` con el `id` del último cobro, o pásalo a ejecución semanal por rangos.
Importes con céntimos: Stripe da céntimos enteros, por eso se divide entre 100. Si vendes en varias monedas, filtra `c.currency === 'eur'` o convertirás manzanas con peras.
Reembolsos parciales no se detectan con `c.refunded`: si los usas, cambia la condición a `c.amount_refunded === 0`.
Zona horaria: `created[gte]` va en segundos UTC. Con `Europe/Madrid` configurado en el flujo, los cobros de la primera hora del día 1 pueden caer en el mes anterior; no pasa nada si repites la conciliación cada semana.

## Cuánto cuesta
Stripe API: gratis (solo pagas las comisiones de cobro habituales). Google Sheets y Gmail: gratis. n8n auto-alojado: gratis.
