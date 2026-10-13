# Cobros de mensualidad, impagos y corte de acceso…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Controla las cuotas mensuales de tus alumnos: avisa antes del cobro, reintenta los recibos fallidos con un email de recuperación y, si no se paga, suspende el acceso y te avisa.

## Qué es y qué hace

Flujo de n8n que escucha los eventos de pago de suscripciones de Stripe y gestiona el ciclo de la cuota: aviso previo al cobro, confirmación, secuencia de recuperación si falla el recibo y suspensión del acceso tras diez días sin pago. Entra el producto de suscripción y la hoja Suscripciones; sale el estado de cada alumno y los avisos.

## Cómo usarla

1. Crea el producto de suscripción en Stripe y su webhook
2. Escribe la secuencia de recuperación de impagos
3. Conecta el corte de acceso de tu plataforma
4. Que lo revise un profesional (cobros y datos de pago)

## Cuándo usarla

Cuando cobras suscripciones o mensualidades y se te acumulan impagos que descubres semanas después.

## Cómo ganar dinero con ella

Recuperar un 30% de los recibos fallidos en una academia de 60 alumnos a 60 € son más de 1.000 € al año que hoy se pierden. Y quita el control manual de quién ha pagado.

- Gestión de cuotas mensuales para academias con alumnos que pagan a plazos.
- Recuperación de impagos para comunidades de formación con membresía de pago.
- Automatización de cobros para escuelas de oficios con matrícula mensual.

**Precio orientativo:** 300–550 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Escucha los eventos de pago de Stripe y monta todo el ciclo de la cuota: aviso previo, confirmación con factura, secuencia de recuperación si falla el recibo y suspensión ordenada si tras 10 días no hay pago.
Es para academias con cuota mensual, membresías de formación y comunidades de pago.

## Lo que necesitas antes
n8n.
Cuenta de Stripe con un producto de suscripción creado (Productos > Añadir producto > Precio recurrente mensual). Clave secreta en Desarrolladores > Claves de API.
Hoja «Suscripciones» con: email, nombre, id_cliente, id_suscripcion, estado, fecha_proximo_cobro, intentos_fallidos, fecha_primer_fallo.
Credencial Google OAuth2 (Sheets y Gmail) y webhook de Slack.
Un método para cortar el acceso: quitar el permiso de la carpeta de Drive, sacar del grupo de Telegram o llamar a la API de tu plataforma con **HTTP Request**.

## Los nodos, en orden
**1. Stripe Trigger**. Eventos a marcar: `invoice.upcoming`, `invoice.paid`, `invoice.payment_failed`, `customer.subscription.deleted`.
**2. Switch**. Campo: `{{ $json.type }}`. Cuatro salidas, una por evento.
**3a.** (`invoice.upcoming`, llega 3 días antes) **Gmail**. Subject: `El {{ $json.fecha }} se pasa tu cuota de {{ $json.importe }} €`. Cuerpo: recordatorio amable, enlace al portal de cliente de Stripe para cambiar la tarjeta y qué incluye este mes. Evita sorpresas y reduce reclamaciones.
**3b.** (`invoice.paid`) **Gmail** con la factura adjunta (`{{ $json.data.object.invoice_pdf }}` descargado con un nodo **HTTP Request** en modo File) y **Google Sheets** «Update Row»: estado `activo`, `intentos_fallidos` = 0, `fecha_proximo_cobro` = `{{ $json.data.object.lines.data[0].period.end }}` convertido a fecha.
**3c.** (`invoice.payment_failed`) es la parte importante: **Google Sheets** «Update Row» suma 1 a `intentos_fallidos` y, si es el primero, guarda `fecha_primer_fallo`. Luego un **Switch** por número de intento.
Intento 1: **Gmail** con asunto `No hemos podido cobrar tu cuota` y un botón grande al portal de Stripe (`https://billing.stripe.com/p/login/xxxx`, se genera en Configuración > Portal de clientes). Tono neutro, culpa al banco, no al alumno.
Intento 2 (a los 3 días): **Gmail** recordando que el acceso se mantiene hasta el día 10 y ofreciendo cambiar la fecha de cobro.
Intento 3 (a los 7 días): **Gmail** + **Slack** al canal #cobros para que alguien llame por teléfono.
**4. Schedule Trigger** aparte, cron `0 9 * * *`: **Google Sheets** «Leer suscripciones» filtrando `intentos_fallidos` mayor que 0, y un **Code** que calcula los días desde `fecha_primer_fallo`.
**5. IF** «¿Más de 10 días?». Rama TRUE: **HTTP Request** o **Google Drive** «Share File» con operación de eliminar permiso para cortar el acceso, **Google Sheets** «Update Row» estado `suspendido`, **Gmail** al alumno explicando cómo reactivar en un clic y **Slack** a ti.
**6.** (`customer.subscription.deleted`) **Google Sheets** estado `baja` y **Gmail** de despedida con encuesta de una pregunta: «¿Por qué te vas?». Esa respuesta vale oro.

## El trozo de código
Nodo **Code** para preparar los datos del evento de Stripe, modo «Run Once for Each Item»:
```javascript
const ev = $input.item.json;
const obj = ev.data.object;
const importe = (obj.amount_due ?? obj.amount_paid ?? 0) / 100;
const fechaTs = obj.next_payment_attempt || obj.period_end || obj.created;
const fecha = new Date(fechaTs * 1000).toLocaleDateString('es-ES', { day: 'numeric', month: 'long', timeZone: 'Europe/Madrid' });
return { json: { tipo: ev.type, email: obj.customer_email, nombre: obj.customer_name || 'hola', id_cliente: obj.customer, id_suscripcion: obj.subscription, importe: importe.toFixed(2).replace('.', ','), fecha, factura_url: obj.invoice_pdf || '', portal: 'https://billing.stripe.com/p/login/TU_ENLACE' } };
```

## Cómo probarla
Trabaja siempre primero en modo de prueba de Stripe. Usa la tarjeta 4000 0000 0000 0341, que autoriza y luego falla el cobro recurrente: así disparas `invoice.payment_failed` de verdad.
Con la CLI de Stripe (`stripe trigger invoice.payment_failed`) puedes lanzar cada evento sin esperar a fin de mes.
Prueba el corte de acceso con un alumno ficticio antes de dejarlo activo: es el paso que más daño hace si falla.

## Qué puede salir mal
El mayor riesgo es cortar el acceso a quien sí ha pagado. Añade siempre antes del corte una comprobación en vivo con un nodo **Stripe** «Get Subscription» y solo corta si el estado es `past_due` o `unpaid`.
Stripe reintenta los cobros por su cuenta según la configuración de Recuperación (Configuración > Facturación > Reintentos). Ajusta tus emails para que no se solapen con los suyos.
Los webhooks pueden llegar duplicados: guarda el `id` del evento en la hoja y descarta los repetidos.
Si el flujo está caído cuando Stripe manda el evento, Stripe reintenta durante 3 días; aun así, monta un **Schedule Trigger** semanal que compare la hoja con la lista real de suscripciones de Stripe.
Legal: en España debes emitir factura de cada cuota. El PDF de Stripe sirve si tienes bien configurados NIF y datos fiscales en Stripe.

## Cuánto cuesta
Stripe: 1,5% + 0,25 € por transacción europea; el sistema de facturación básico está incluido.
n8n auto-alojado, Sheets, Gmail y Slack: 0 €.
Alternativa sin Stripe: si cobras por domiciliación, sustituye el trigger por la lectura de un CSV bancario con el nodo **Read/Write Files from Disk**.
