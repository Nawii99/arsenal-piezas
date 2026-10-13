# Cobros de cuotas: aviso de recibo devuelto y recuperaci…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Detecta las cuotas que se devuelven o no se pagan, avisa al cliente con un enlace de pago y te deja la lista de morosos ordenada antes de que se acumule.

## Qué es y qué hace

Escucha los eventos de fallo de pago de Stripe mediante un webhook y, cuando un cobro falla, envía al cliente un correo con enlace para pagar y registra el caso en la hoja Impagos. Si a los cinco días sigue sin pagar, te lo marca para llamar y avisa por Telegram. Entrada: eventos invoice.payment_failed; salida: correo, hoja y aviso. Se monta en n8n.

## Cómo usarla

1. Crea el webhook en Stripe con los eventos de factura
2. Prepara la hoja Impagos y conecta Gmail y Telegram en n8n
3. Que lo revise un profesional

## Cuándo usarla

Cuando cobras cuotas mensuales por domiciliación o Stripe y descubres los impagos semanas después, cuando ya son tres meses y una conversación incómoda.

## Cómo ganar dinero con ella

Recuperar 6 cuotas de 45 € al mes son 270 €, y evitas la fuga silenciosa del que deja de pagar y de venir. Menos de un minuto de tu tiempo por caso.

- Recuperación de cuotas impagadas para un gimnasio o estudio con cobro recurrente.
- Aviso automático de pagos fallidos para un centro de yoga con suscripciones.
- Lista de morosos ordenada para una clínica con bonos mensuales y seguimiento semanal.

**Precio orientativo:** 200–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Escucha los avisos de Stripe (o revisa tu hoja de cobros si usas domiciliación bancaria) y en cuanto un pago falla manda al cliente un email amable con un enlace para pagar en un clic, lo apunta en la hoja de incidencias y te avisa por Telegram. Si a los 5 días sigue sin pagar, insiste una vez más y te lo marca para llamar.
Para gimnasios, centros de yoga o pilates, clínicas con bonos mensuales y cualquier negocio de bienestar con cuota recurrente.

## Lo que necesitas antes
- Cuenta de Stripe con suscripciones activas, o una hoja donde apuntes las devoluciones que te da el banco.
- La clave secreta de Stripe (Desarrolladores > Claves API) y un webhook en Stripe apuntando a la URL de producción de tu nodo Webhook de n8n, suscrito a los eventos `invoice.payment_failed` e `invoice.paid`.
- Google Sheet `Impagos`: fecha, cliente, email, importe, factura_id, estado, avisos, enlace_pago.
- Gmail y un bot de Telegram.
- n8n con URL pública (si es auto-alojado, detrás de un dominio con HTTPS).

## Los nodos, en orden
1. **Webhook** – HTTP Method: POST, Path: `stripe-pagos`, Respond: Immediately. Copia la URL de producción y pégala en Stripe.
2. **Switch** – Mode: Rules sobre `={{ $json.body.type }}`. Salida A: equal `invoice.payment_failed`. Salida B: equal `invoice.paid`.
3. **Code** (salida A) – extrae cliente, email, importe y el `hosted_invoice_url` que Stripe genera y que sirve como enlace de pago. Código abajo.
4. **Google Sheets** – Append or Update en `Impagos`, Matching Column `factura_id`, con estado `pendiente` y avisos `1`.
5. **Gmail** – Send al cliente. Asunto: «No ha podido pasarse tu cuota de este mes». Texto: pasa a veces, no es nada, aquí tienes el enlace para arreglarlo en 30 segundos. Botón grande con `={{ $json.enlace_pago }}`.
6. **Telegram** – te avisa a ti: nombre, importe y motivo del rechazo.
7. **Google Sheets** (salida B) – Update por `factura_id` poniendo estado `pagado`. Así el seguimiento no persigue a quien ya pagó.
8. **Schedule Trigger** (workflow dos, «Segundo aviso») – Cron `0 10 * * 1-5`, Timezone Europe/Madrid.
9. **Google Sheets** – Read Rows de `Impagos`. **Filter**: estado igual a `pendiente`.
10. **Code** – calcula días desde el aviso y separa en «segundo aviso» (5 días) y «llamada» (12 días).
11. **Gmail** – segundo aviso, mismo tono, recordando que la plaza se mantiene.
12. **Google Sheets** – Update `avisos` = 2.
13. **Aggregate** + **Telegram** – lista de los que llevan más de 12 días para que llames tú, con teléfono e importe acumulado.

## El código del nodo Code (paso 3)
```
const inv = $json.body.data.object;
return [{ json: {
  factura_id: inv.id,
  cliente: inv.customer_name || (inv.customer_email || '').split('@')[0],
  email: inv.customer_email,
  importe: (inv.amount_due / 100).toFixed(2) + ' €',
  enlace_pago: inv.hosted_invoice_url,
  motivo: (inv.last_finalization_error && inv.last_finalization_error.message) || 'rechazo del banco',
  fecha: new Date().toLocaleDateString('es-ES'),
  estado: 'pendiente',
  avisos: 1
} }];
```

## El código del paso 10
```
const hoy = Date.now();
const salida = [];
for (const item of $input.all()) {
  const f = item.json;
  const [d, m, a] = String(f.fecha).split('/');
  const dias = Math.floor((hoy - new Date(`${a}-${m}-${d}`).getTime()) / 86400000);
  let accion = 'esperar';
  if (dias >= 12) accion = 'llamar';
  else if (dias >= 5 && Number(f.avisos) < 2) accion = 'segundo_aviso';
  salida.push({ json: { ...f, dias, accion } });
}
return salida;
```

## Cómo probarla
- En Stripe, modo test: crea un cliente con la tarjeta `4000 0000 0000 0341`, que falla al cobrar. Crea una suscripción y espera al primer cobro; te llegará el webhook.
- Comprueba que la fila aparece en la hoja y que te llega el email con el enlace, y que ese enlace abre la página de pago de Stripe.
- Paga desde ese enlace con una tarjeta de prueba buena: el evento `invoice.paid` debe cambiar el estado a `pagado`.
- Cambia a mano la fecha de una fila a hace 6 días y ejecuta el workflow 2: debe salir el segundo aviso una sola vez.

## Qué puede salir mal
- **Webhook sin verificar la firma**: cualquiera que sepa tu URL puede mandarte datos falsos. Añade un nodo **Code** al principio que compruebe la cabecera `stripe-signature` con tu secreto del webhook, o al menos usa un path largo y aleatorio.
- **Reintentos automáticos de Stripe**: Stripe ya reintenta el cobro varios días. Si tienes eso activo, deja pasar 2 días antes del primer email o el cliente pagará solo y le habrás dado la lata.
- **Emails que suenan a bufete**: la primera vez no es morosidad, es una tarjeta caducada. Escribe como si le hubieras visto el jueves, porque así es.
- **Domiciliación bancaria sin Stripe**: cambia el Webhook por un **Schedule Trigger** que lea el fichero de devoluciones que te manda el banco (súbelo a Drive) con **Google Drive** + **Extract From File**, y el resto del flujo es idéntico.
- **Duplicados**: usa siempre `factura_id` como llave; el mismo impago puede generar varios eventos.

## Cuánto cuesta
- Stripe: 0 € de cuota, alrededor del 1,5% + 0,25 € por cobro con tarjeta europea.
- Sheets, Gmail, Telegram y n8n auto-alojado: 0 €.
- Comparado con una gestoría o un software de cobros de 30-60 €/mes, aquí solo pagas la comisión que ya pagabas.
