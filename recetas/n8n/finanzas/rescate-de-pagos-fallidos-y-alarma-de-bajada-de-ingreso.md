# Rescate de pagos fallidos y alarma de bajada de ingreso…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cuando falla el cobro de una suscripción, avisa al cliente con un mensaje útil y reintenta en el mejor momento. Y si tus ingresos recurrentes bajan dos meses, te avisa a ti.

## Qué es y qué hace

Cuando Stripe avisa de un pago fallido, envía al cliente un correo con el enlace para actualizar la tarjeta y programa reintentos escalonados. Cada día 1 calcula tus ingresos recurrentes y, si bajan dos meses seguidos, te avisa con el detalle de quién se ha ido. Se monta con n8n, Make o Zapier y necesita Stripe con suscripciones.

## Cómo usarla

1. Obtén la clave secreta de Stripe
2. Crea la hoja MRR con sus columnas
3. Conecta Gmail y Telegram
4. Prueba con un pago fallido de prueba de Stripe
5. Que lo revise un profesional

## Cuándo usarla

Cuando cobras cuotas mensuales (mantenimientos, membresías, iguala) y pierdes clientes solo porque les caducó la tarjeta y nadie lo miró.

## Cómo ganar dinero con ella

Entre el 20 % y el 40 % de las bajas en cuotas son por tarjeta caducada, no por decisión. Recuperar 3 cuotas de 60 € al mes son 2.160 €/año.

- Recuperación de cuotas fallidas para gimnasios, gestorías y mantenimientos…
- Seguimiento de ingresos recurrentes como servicio mensual para SaaS pequeños…
- Campaña de reactivación de pagos para membresías con tarjetas caducadas…

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

**Qué hace y para quién**
Dos cosas en un mismo flujo. Uno: cuando Stripe te avisa de un pago fallido, manda al cliente un email claro con el enlace para actualizar la tarjeta y programa reintentos escalonados. Dos: cada día 1 calcula tus ingresos recurrentes del mes y, si bajan dos meses seguidos, te suena la alarma con el detalle de quién se ha ido.
Para negocios de cuota: mantenimientos informáticos, gimnasios, gestorías, membresías, software.

**Lo que necesitas antes**
- Stripe con suscripciones activas y su clave secreta (Dashboard > Desarrolladores > Claves API). Si cobras por domiciliación bancaria en vez de Stripe, sustituye el disparador por los recibos devueltos que te llegan por email del banco.
- Gmail conectado.
- Hoja `MRR` en Sheets con `mes`, `ingresos_recurrentes`, `clientes_activos`, `bajas`.
- Bot de Telegram para las alarmas.

**Los nodos, en orden**
1. **Stripe Trigger** — eventos `invoice.payment_failed` y `customer.subscription.deleted`.
2. **IF** — antes de seguir, busca el `id` del evento (`{{ $json.id }}`) en la pestaña `Fallos`; si ya está, para aquí, porque Stripe puede reenviar el mismo evento y el cliente recibiría dos emails. Después, un **Switch** que separa los dos eventos.
3. **HTTP Request** (rama fallo) — POST a `https://api.stripe.com/v1/billing_portal/sessions` con `customer={{ $json.data.object.customer }}` y `return_url`, autenticación con una credencial de n8n (Authentication: Generic Credential Type > Header Auth; en la credencial, Name `Authorization` y Value `Bearer sk_live_...`), nunca con la clave escrita en el nodo. Te devuelve un enlace para que el cliente cambie la tarjeta sin llamarte.
4. **Gmail** — email al cliente: asunto sin drama («No hemos podido renovar tu cuota»), explicación en dos líneas y el botón con el enlace del portal.
5. **Wait** — 3 días.
6. **HTTP Request** — GET a `https://api.stripe.com/v1/invoices/{{ $json.invoice_id }}` para ver si ya está pagada.
7. **IF** — si sigue impagada: **Gmail** segundo aviso y **Telegram** a ti para que llames por teléfono. Una llamada recupera más que diez emails.
8. **Google Sheets** — «Append» a una pestaña `Fallos` para saber qué clientes fallan a menudo; guarda también el `id` del evento para la comprobación del paso 2.
9. Segundo disparador **Schedule Trigger** — día 1 a las 8:00 + **HTTP Request** a `https://api.stripe.com/v1/subscriptions?status=active&limit=100` + **Code** (abajo) + **Google Sheets** + **IF** + **Telegram**.

**El trozo de código (nodo Code de MRR)**
```javascript
const subs = $json.data || [];
let mrr = 0;
let activos = 0;
for (const s of subs) {
  for (const it of (s.items?.data || [])) {
    const p = it.price;
    if (!p) continue;
    const importe = (p.unit_amount / 100) * (it.quantity || 1);
    const inter = p.recurring?.interval;
    const cuenta = p.recurring?.interval_count || 1;
    let mensual = importe;
    if (inter === 'year') mensual = importe / (12 * cuenta);
    if (inter === 'week') mensual = importe * (4.33 / cuenta);
    if (inter === 'month') mensual = importe / cuenta;
    mrr += mensual;
  }
  activos++;
}
const historico = $('Leer MRR').all().map(i => i.json).sort((a, b) => String(a.mes).localeCompare(String(b.mes)));
const previo = historico.length ? Number(historico[historico.length - 1].ingresos_recurrentes) : 0;
const anterior2 = historico.length > 1 ? Number(historico[historico.length - 2].ingresos_recurrentes) : 0;
const bajaDoble = previo && anterior2 && mrr < previo && previo < anterior2;
const variacion = previo ? ((mrr - previo) / previo) * 100 : 0;
return [{ json: {
  mes: new Date().toISOString().slice(0, 7),
  ingresos_recurrentes: mrr.toFixed(2),
  clientes_activos: activos,
  variacion_pct: variacion.toFixed(1),
  alarma: bajaDoble,
  texto: `MRR ${mrr.toFixed(0)} EUR (${variacion >= 0 ? '+' : ''}${variacion.toFixed(1)}%) con ${activos} clientes.${bajaDoble ? ' ALARMA: segundo mes consecutivo bajando.' : ''}`
} }];
```

**Cómo probarla**
- En Stripe modo test, crea una suscripción con la tarjeta 4000 0000 0000 0341 (falla en el cobro recurrente). Debe llegarte el email con el enlace del portal.
- Abre el enlace del portal: tiene que dejarte cambiar la tarjeta.
- Ejecuta a mano el flujo del MRR y compara con el panel de Stripe.

**Qué puede salir mal**
- El Wait de 3 días mantiene la ejecución abierta: en n8n auto-alojado no hay problema; en n8n Cloud (prueba gratuita temporal y después planes de pago) puede contar como ejecución larga. Alternativa: guarda la fecha en Sheets y usa un Schedule diario que revise pendientes.
- Usa `sk_test_` mientras pruebas y no olvides cambiar a `sk_live_`. Guarda la clave como credencial de n8n (en los nodos HTTP Request, la credencial Header Auth), nunca escrita en el nodo ni en un Set: un flujo exportado se llevaría la clave.
- El portal de cliente hay que activarlo antes en Stripe (Configuración > Portal de clientes) o la llamada da error.
- Reintentos: Stripe ya reintenta solo. No dupliques la lógica; tú añades la parte humana (email claro y llamada).

**Cuánto cuesta**
n8n auto-alojado gratis (Cloud: prueba gratuita temporal y después planes de pago). Stripe no cobra por la API ni por el portal, solo su comisión por cobro. Gmail y Sheets gratis.
