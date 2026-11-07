# Factura automática y aviso de pago pendiente…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Genera la factura al cerrar cada sesión, la manda por email en PDF y persigue sola los pagos que se quedan sin cobrar a los 7, 15 y 25 días.

## Qué es y qué hace

Al marcar una sesión como realizada en la hoja, crea una factura con numeración correlativa a partir de una plantilla de Google Docs, la convierte en PDF y la envía al paciente con un enlace de pago. Si no paga a los 7, 15 y 25 días, manda recordatorios cada vez más firmes y a los 30 te avisa. Entrada: sesión realizada; salida: factura PDF y recordatorios. Se monta en n8n con Sheets, Docs y Gmail. El cobro solo se da por bueno con el webhook de Stripe verificado, el pago en estado pagado y sin repetir eventos.

## Cómo usarla

1. Preparar la hoja Sesiones y el contador de facturas
2. Crear la plantilla de Google Docs con marcadores
3. Probar con una sesión de prueba
4. Que lo revise un profesional

## Cuándo usarla

Cuando facturas a mano en Word, se te olvidan sesiones sin cobrar y tienes un puñado de recibos pendientes que nadie reclama.

## Cómo ganar dinero con ella

Recuperar 300 € de impagos al mes y ahorrar 4 horas de administración. Solo el tiempo ya vale unos 60 € mensuales.

- Automatizar la facturación de fisioterapeutas y psicólogos autónomos, cobrando una instalación única.
- Ofrecer el seguimiento de impagos a clínicas pequeñas con una cuota mensual.
- Montar la plantilla y la numeración para un nutricionista que factura sesión a sesión.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Al marcar una sesión como realizada en la hoja de trabajo, crea la factura con numeración correlativa, la convierte en PDF y se la manda al paciente con un enlace de pago; si a los 7, 15 y 25 días sigue sin pagarse, manda recordatorios cada vez más firmes y a los 30 días te avisa a ti.
Para fisioterapeutas, psicólogos, nutricionistas y entrenadores autónomos que facturan sesión a sesión y odian la parte administrativa.

## Lo que necesitas antes
- Google Sheets con dos hojas. Sesiones: fecha, paciente, email, nif, direccion, concepto, base, iva, total, estado (pendiente, facturada, cobrada), num_factura. Contador: una celda A2 con el último número emitido.
- Un Google Doc plantilla llamado Plantilla-factura con marcadores tipo {{numero}}, {{fecha}}, {{paciente}}, {{nif}}, {{direccion}}, {{concepto}}, {{base}}, {{iva}}, {{total}} y tus datos fiscales fijos.
- Cuenta de Stripe (stripe.com), gratis de alta; en el panel, Desarrolladores > Claves de API, copia la clave secreta.
- Gmail de la clínica y n8n.
- Importante: la mayoría de servicios sanitarios prestados por profesionales titulados están exentos de IVA en España; el bienestar no sanitario, no. Confírmalo con tu asesoría y ajusta la columna iva.

## Los nodos, en orden
1. **Schedule Trigger**: `0 21 * * 1-6`, cada día al cerrar.
2. **Google Sheets** (Get Rows) sobre Sesiones.
3. **Filter**: `{{ $json.estado }}` equals `pendiente`.
4. **Google Sheets** (Get Rows) sobre Contador, para leer el último número.
5. **Code**: asigna números correlativos y calcula importes. Código abajo. Justo después, antes de crear o enviar nada, un **Google Sheets** (Update) sobre Contador con el último número asignado: así el número queda reservado aunque el envío falle. Ejecuta este flujo de uno en uno.
6. **Google Drive** (Copy File): copia Plantilla-factura con nombre `Factura-{{ $json.num_factura }}`.
7. **Google Docs** (Update Document): usa la acción Replace Text una vez por cada marcador, sustituyendo {{numero}} por `{{ $json.num_factura }}` y así con el resto.
8. **Google Drive** (Download): descarga ese documento indicando en las opciones el formato de conversión PDF.
9. **Stripe** (nodo Stripe, recurso Charge no; usa **HTTP Request** POST a `https://api.stripe.com/v1/payment_links` con autenticación Predefined Credential Type > Stripe): en el cuerpo, `line_items[0][price_data][currency]=eur`, `line_items[0][price_data][product_data][name]={{ $json.concepto }}`, `line_items[0][price_data][unit_amount]={{ Math.round($json.total * 100) }}`, `line_items[0][quantity]=1`. Guarda la URL que devuelve.
10. **Gmail** (Send): asunto `Factura {{ $json.num_factura }} - {{ $json.concepto }}`, adjunta el PDF (en Options > Attachments pon el nombre del campo binario, normalmente data) y en el cuerpo el enlace de pago.
11. **Google Sheets** (Update Row): estado pasa a facturada, y guarda num_factura y el enlace de pago.
12. El contador ya se actualizó en el paso 5. Si un envío falla, reenvía esa misma factura: no generes otra con número nuevo.
13. Flujo 2, la persecución de impagos: **Schedule Trigger** diario a las 10:00, **Google Sheets** Get Rows, **Filter** estado igual a facturada, **Code** que calcule los días desde la fecha de factura, **Switch** con salidas 7, 15 y 25 días, y tres **Gmail** con textos distintos: recordatorio amable, recordatorio firme y aviso de que a partir de ahí no se dan más citas hasta regularizar. A los 30 días, un Gmail a ti.
14. Flujo 3, el cobro: **Stripe Trigger** con el evento `checkout.session.completed` (este nodo comprueba la firma del webhook; si usas un **Webhook** genérico, verifica antes la cabecera `Stripe-Signature` con el «signing secret» del endpoint y no te fíes del aviso sin ese paso). Un **IF** comprueba que `payment_status` sea `paid` y que el `id` del evento no esté ya guardado en la hoja (guárdalo para no repetir el trabajo si llega dos veces); después un **Google Sheets** Update pone estado en cobrada.

## El trozo de código del nodo 5
```javascript
let contador = parseInt($('Google Sheets Contador').first().json.ultimo || 0, 10);
const anio = new Date().getFullYear();
const salida = [];
for (const item of $input.all()) {
  const s = item.json;
  contador += 1;
  const base = parseFloat(String(s.base).replace(',', '.')) || 0;
  const tipoIva = parseFloat(String(s.iva).replace(',', '.')) || 0;
  const cuota = Math.round(base * tipoIva) / 100;
  salida.push({ json: {
    ...s,
    num_factura: `${anio}-${String(contador).padStart(4, '0')}`,
    base: base.toFixed(2),
    iva: cuota.toFixed(2),
    total: (base + cuota).toFixed(2),
    fecha_factura: new Date().toISOString().slice(0, 10)
  } });
}
return salida;
```

## Cómo probarla
1. Mete una sesión de prueba con tu propio email y 50 € de base.
2. Ejecuta paso a paso y abre el Google Doc copiado: ningún marcador {{...}} debe quedar sin sustituir.
3. Comprueba que el PDF llega adjunto y que el enlace de Stripe abre el importe correcto. Usa las claves de test de Stripe y la tarjeta 4242 4242 4242 4242.
4. Paga en modo test y verifica que el webhook cambia el estado a cobrada.
5. Cambia a mano la fecha de factura a hace 8 días y ejecuta el flujo 2 para ver el primer recordatorio.

## Qué puede salir mal
- **Numeración con huecos o repetida**: es lo más grave a efectos fiscales. Nunca ejecutes dos veces el flujo sobre la misma fila; el cambio de estado a facturada es lo que lo evita, así que ponlo justo después del envío y no antes.
- **Ejecución paralela**: si dos ejecuciones leen el contador a la vez, repites número. Evítalo haciendo que este flujo se ejecute siempre de uno en uno: en n8n, llámalo desde un sub-flujo único (nunca lo lances a mano mientras corre otro) o limita las ejecuciones simultáneas a 1 (en autoalojado, `N8N_CONCURRENCY_PRODUCTION_LIMIT=1`, que afecta a todos tus flujos de producción). Y antes de emitir, añade tras el nodo Code un **IF** que compruebe en la hoja Sesiones que ese `num_factura` no existe ya; si existe, para y avísate.
- **Requisitos legales de la factura**: tiene que llevar tus datos fiscales, NIF del cliente, fecha, número, base, tipo y cuota. Si estás en Verifactu o facturación electrónica obligatoria, esta receta genera el PDF pero no sustituye al programa homologado: úsala como borrador o conecta con la API de tu programa (Holded, Quipu, Facturascripts) en el paso 6.
- **Stripe cobra comisión**: 1,5% + 0,25 € en tarjetas europeas. Si prefieres transferencia, quita el paso 9 y pon tu IBAN en el email.

## Cuánto cuesta
- n8n autoalojado (Community Edition), Sheets, Docs, Drive y Gmail: gratis o incluido. n8n Cloud tiene una prueba gratuita temporal y después planes de pago.
- Stripe: sin cuota, solo comisión por cobro.
- Total: 0 € fijos con n8n autoalojado, más la comisión de lo que cobres.
