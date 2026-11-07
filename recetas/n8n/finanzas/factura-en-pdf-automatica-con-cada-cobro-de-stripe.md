# Factura en PDF automática con cada cobro de Stripe…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cuando alguien te paga por Stripe, genera la factura en PDF con numeración correlativa a partir de una plantilla de Google Docs, se la envía al cliente y la archiva.

## Qué es y qué hace

Cuando Stripe confirma un pago, reserva el siguiente número correlativo en una hoja de control antes de enviar nada, duplica una plantilla de Google Docs, sustituye los marcadores de cliente, importe e IVA, exporta a PDF, lo guarda en Drive, lo envía por correo y apunta la línea en la hoja de facturas emitidas. Para servicios, cursos o productos digitales cobrados con Stripe. Solo factura con el webhook verificado, el pago confirmado y sin repetir el mismo evento, ejecutándose de uno en uno y con el número comprobado.

## Cómo usarla

1. Preparar la plantilla de Google Docs con marcadores
2. Guardar la clave de Stripe (modo test) en la credencial de n8n
3. Montar el webhook y el flujo en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando vendes servicios o productos digitales cobrando con Stripe y luego tienes que hacer la factura a mano una por una, con el riesgo de saltarte un número.

## Cómo ganar dinero con ella

Ahorra 5-10 minutos por venta y elimina errores de numeración, que son motivo de sanción. Con 30 ventas al mes son 4 horas recuperadas.

- Facturación automática para creadores de cursos o productos digitales que cobran con Stripe.
- Mantenimiento de la plantilla y la numeración para autónomos con varias líneas de venta.
- Montaje de facturación automática que el consultor vende a pequeños negocios de servicios.

**Precio orientativo:** 250–500 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
En cuanto Stripe confirma un pago, coge los datos del cliente y del importe, pide el siguiente número de factura a una hoja de control, duplica una plantilla de Google Docs, sustituye los campos, la exporta a PDF, la guarda en Drive, se la manda al cliente por email y apunta la línea en tu hoja de facturas emitidas.
Para autónomos y pymes que cobran servicios, cursos o productos digitales con Stripe.

## Lo que necesitas antes
- Cuenta de Stripe. La clave secreta está en Desarrolladores > Claves de API (`sk_live_...`; usa primero la de test, `sk_test_...`). Pégala solo en la credencial **Stripe API** de n8n, nunca en un nodo Code, Set o HTTP Request ni en el texto del flujo: porque un flujo exportado se llevaría la clave.
- Una plantilla en Google Docs llamada `Plantilla factura` con tus datos fiscales y los marcadores literales `{{NUMERO}}`, `{{FECHA}}`, `{{CLIENTE}}`, `{{NIF}}`, `{{DIRECCION}}`, `{{CONCEPTO}}`, `{{BASE}}`, `{{IVA}}`, `{{TOTAL}}`. Apunta su ID (está en la URL).
- Una carpeta en Drive `Facturas emitidas` y su ID.
- Hoja `Facturas` con `numero`, `fecha_emision`, `cliente`, `nif`, `email`, `base`, `iva`, `total`, `stripe_id`, `pdf_url`, `estado`.
- Credenciales en n8n: **Stripe API**, **Google Docs OAuth2**, **Google Drive OAuth2**, **Google Sheets OAuth2**, **Gmail OAuth2**.

## Los nodos, en orden
1. **Stripe Trigger** — Events: `checkout.session.completed` (o `invoice.paid` si cobras suscripciones). n8n registra el webhook en Stripe solo y el nodo comprueba su firma (con un Webhook genérico, verifica la cabecera `Stripe-Signature` con el «signing secret» del endpoint, guardado en una credencial o en la variable de entorno `$env.STRIPE_WEBHOOK_SECRET`, nunca escrito en un nodo Code). Solo emite factura si `payment_status` es `paid` (o el evento es `invoice.paid`).
2. **Google Sheets** («Último número») — Operation: `Get Row(s)`, Sheet: `Facturas`. Devuelve todas las filas para poder calcular el máximo y comprobar que el `stripe_id` del pago no esté ya registrado: añade un **IF** que pare el flujo si lo está (el mismo evento puede llegar dos veces y no debes emitir dos facturas). Este flujo debe ejecutarse de uno en uno: dos cobros simultáneos leerían el mismo «último número» (ver «Qué puede salir mal»).
3. **Code** («Preparar factura») — Mode: `Run Once for All Items`. Código abajo: calcula el siguiente número, desglosa base e IVA y normaliza los datos del cliente. Antes de copiar la plantilla, comprueba que ese `numero` no existe ya en la hoja `Facturas`; si existe, para y avísate.
4. **Google Drive** («Copiar plantilla») — Resource: `File`, Operation: `Copy`, File: el ID de la plantilla, Name: `{{ $json.numero }} - {{ $json.cliente }}`, Options > Parents: el ID de la carpeta `Facturas emitidas`.
**3 bis. Google Sheets** («Reservar número») — Operation: `Append Row`, Sheet: `Facturas`, con `numero`, `stripe_id` y `estado` = `reservada`, ANTES de copiar la plantilla y de enviar nada. Así el número queda ocupado aunque el envío falle y el siguiente cobro ya lo ve en la hoja (por eso el flujo se ejecuta de uno en uno).
5. **Google Docs** («Rellenar») — Operation: `Update a Document`, Doc ID or URL: `{{ $json.id }}` (el de la copia). En Actions añade una acción `Replace All Text` por cada marcador: Old Text `{{NUMERO}}` / New Text `{{ $('Preparar factura').item.json.numero }}`, y así con los nueve.
6. **HTTP Request** («Exportar PDF») — Method: `GET`, URL: `https://www.googleapis.com/drive/v3/files/{{ $('Copiar plantilla').item.json.id }}/export?mimeType=application/pdf`. Authentication: `Predefined Credential Type` > `Google Drive OAuth2`. Response > Format: `File`, Output Binary Field: `data`.
7. **Google Drive** («Guardar PDF») — Operation: `Upload`, Input Data Field: `data`, File Name: `{{ $('Preparar factura').item.json.numero }}.pdf`, carpeta `Facturas emitidas`. No la compartas con acceso público (nada de enlace abierto): la factura lleva el nombre, el NIF y la dirección del cliente (datos personales). Va adjunta en el paso 8; si quieres darle acceso desde Drive, compártela solo con su correo (Operation: Share, Type User).
8. **Gmail** («Enviar al cliente») — To: `{{ $('Preparar factura').item.json.email }}`, Subject: `Tu factura {{ $('Preparar factura').item.json.numero }}`, Message: texto de agradecimiento. En Options > Attachments, Attachment Field Name: `data`.
9. **Google Sheets** («Registrar») — Operation: `Update Row`, Sheet: `Facturas`, Column to Match On: `numero` (la fila reservada en el paso 3 bis), con `fecha_emision`, `cliente`, `nif`, `email`, importes, `estado` = `cobrada` y `pdf_url` = `{{ $('Guardar PDF').item.json.webViewLink }}`.

## El código del nodo Code
```javascript
const s = $('Stripe Trigger').first().json.data.object;
const filas = $('Último número').all().map(i => i.json).filter(f => f.numero);
const anio = new Date().getFullYear();
let max = 0;
for (const f of filas) {
  const m = String(f.numero).match(new RegExp(`^${anio}-(\\d+)$`));
  if (m) max = Math.max(max, Number(m[1]));
}
const numero = `${anio}-${String(max + 1).padStart(4, '0')}`;
const total = (s.amount_total ?? s.amount_paid ?? 0) / 100;
const IVA = 0.21;
const base = +(total / (1 + IVA)).toFixed(2);
const cuotaIva = +(total - base).toFixed(2);
const det = s.customer_details || {};
const dir = det.address || {};
return [{ json: {
  numero,
  fecha: new Date().toLocaleDateString('es-ES'),
  cliente: det.name || s.customer_name || 'Cliente',
  email: det.email || s.customer_email || '',
  nif: (s.metadata && s.metadata.nif) || (det.tax_ids && det.tax_ids[0]?.value) || '',
  direccion: [dir.line1, dir.postal_code, dir.city, dir.country].filter(Boolean).join(', '),
  concepto: (s.metadata && s.metadata.concepto) || 'Servicios profesionales',
  base: base.toFixed(2).replace('.', ',') + ' €',
  iva: cuotaIva.toFixed(2).replace('.', ',') + ' €',
  total: total.toFixed(2).replace('.', ',') + ' €',
  base_num: base, iva_num: cuotaIva, total_num: total,
  stripe_id: s.id
} }];
```

## Cómo probarla
- Usa la clave `sk_test_` y el Test Mode de Stripe. Haz un pago con la tarjeta de prueba `4242 4242 4242 4242`, cualquier fecha futura y CVC `123`.
- Comprueba el PDF resultante: que no quede ningún `{{MARCADOR}}` sin sustituir (es el fallo más típico: un espacio dentro de las llaves en el Docs).
- Haz tres pagos seguidos y verifica que la numeración va 2026-0001, 2026-0002, 2026-0003 sin saltos ni repeticiones.
- Antes de pasar a producción, enséñale una factura generada a tu asesor para que confirme que lleva todos los datos obligatorios.

## Qué puede salir mal
- **Numeración duplicada**: si entran dos pagos a la vez, ambas ejecuciones pueden leer el mismo número máximo. Evítalo haciendo que se ejecuten de uno en uno: deja este flujo como sub-flujo (Execute Workflow) llamado desde un flujo principal que procese los cobros en cola con concurrencia 1 (en n8n autoalojado en modo queue, un worker con `--concurrency=1`). Además, antes de emitir, comprueba que el número no existe ya en la hoja `Facturas`; si existe, para y avísate.
- **NIF del cliente**: Stripe no lo pide por defecto. Añade un campo personalizado en tu Checkout (`custom_fields`) o pásalo en `metadata.nif` desde tu web. Sin NIF, la factura no vale para un cliente empresa.
- **Verifactu**: desde 2026 los sistemas de facturación en España deben cumplir requisitos de registro y trazabilidad. Este flujo genera el documento, pero consulta con tu asesor si tu caso exige un software homologado. Para ventas a consumidor final con tickets suele bastar el registro ordenado.
- **Exportación a PDF**: si el nodo HTTP Request devuelve HTML de error, es que la credencial no tiene scope de Drive. Recrea la credencial marcando el ámbito de Drive completo.
- **Reembolsos**: añade otro **Stripe Trigger** con `charge.refunded` que te avise para emitir la factura rectificativa a mano. No las generes automáticamente.

## Cuánto cuesta
- Stripe: 1,5% + 0,25 € por pago con tarjeta europea. No cobra por los webhooks.
- Google Docs, Drive, Sheets y Gmail: gratis con cuenta personal.
- n8n auto-alojado: gratis; en n8n Cloud cada venta consume 1 ejecución.
- Alternativas de pago que hacen esto (Quaderno, Holded, Billin) cuestan entre 10 y 30 € al mes.
