# Cobros pendientes con recordatorio escalonado…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Cruza las citas realizadas con los cobros recibidos, detecta lo que sigue sin pagar y manda tres recordatorios con tonos distintos antes de que tengas que llamar tú.

## Qué es y qué hace

Cada día compara los servicios prestados con los pagos registrados en Stripe y en la hoja de cobros, y genera la lista de pendientes con los días de retraso. A los 3 días manda un email con enlace de pago, a los 10 un email más directo, a los 20 un WhatsApp y a los 30 crea una tarea para llamar. Entrada: hojas de servicios y pagos de Stripe; salida: recordatorios y tareas. Se monta en n8n con Stripe, Sheets, Gmail y WhatsApp.

## Cómo usarla

1. Crear la hoja Servicios y conectar Stripe en modo test
2. Fijar los plazos de recordatorio
3. Probar con un impago ficticio
4. Que lo revise un profesional

## Cuándo usarla

Cuando das facilidades de pago o cobras por transferencia y acabas con una lista de pequeños impagos que da pereza reclamar.

## Cómo ganar dinero con ella

Recuperar 400 € al mes en impagos pequeños son 4.800 € al año que ya habías trabajado.

- Reducir impagos de clínicas que cobran por transferencia, cobrando configuración y revisión.
- Ofrecer seguimiento de cobros a centros que facturan sesión a sesión.
- Montar un informe mensual de cobros pendientes para la gerencia.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada día compara la hoja de servicios prestados con los pagos registrados en Stripe y en la hoja de cobros en efectivo o transferencia, y genera la lista de pendientes con los días de retraso.
A los 3 días manda un email suave con el enlace de pago, a los 10 un email más directo, a los 20 un WhatsApp y a los 30 crea una tarea para llamar. Todo con un tono cuidado: nada de amenazas ni de mencionar el servicio recibido en el asunto.
Para clínicas y centros que facturan sesión a sesión y no cobran siempre en el momento.

## Lo que necesitas antes
Cuenta de Stripe si cobras con tarjeta: en dashboard.stripe.com, Desarrolladores, Claves de API, copia la clave secreta (`sk_live_...`). Empieza con la clave de prueba.
Google Sheet `Servicios` con `id_servicio`, `fecha`, `paciente`, `email`, `telefono`, `importe`, `metodo`, `estado_cobro`, `avisos_enviados`.
Enlaces de pago de Stripe (Payment Links) o una plantilla de enlace por importe.
Credenciales `Stripe API`, `Google Sheets OAuth2`, `Gmail OAuth2` y `Twilio` en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — `0 10 * * 1-5`, timezone `Europe/Madrid`.
2. **Google Sheets** — `Get Row(s)` de `Servicios`, `Return All`.
3. **Filter** — `{{$json.estado_cobro}}` distinto de `pagado`.
4. **Stripe** — Resource `Charge`, Operation `Get Many`, `Return All`; o **HTTP Request** GET a `https://api.stripe.com/v1/payment_intents?limit=100` con Authentication `Generic Credential Type`, `Header Auth`, cabecera `Authorization` con valor `Bearer sk_live_...`.
5. **Code** — cruza por importe y por email o por el campo `metadata.id_servicio` si lo pasas al crear el cobro, marca lo cobrado y calcula los días de retraso y el tramo de aviso (código abajo).
6. **Switch** — sobre `{{$json.tramo}}`: `pagado`, `aviso1`, `aviso2`, `aviso3`, `llamada`.
7. `pagado` → **Google Sheets** `Update Row`, `estado_cobro` = `pagado`.
8. `aviso1` y `aviso2` → **Gmail** con asunto `Factura pendiente de tu visita del {{$json.fecha}}` y el enlace de pago; el segundo email añade la fecha límite.
9. `aviso3` → **Twilio** WhatsApp corto con el enlace.
10. `llamada` → **Google Sheets** `Append Row` en una hoja `Llamadas` y **Gmail** a administración.
11. En todas las ramas, **Google Sheets** `Update Row` sumando 1 a `avisos_enviados` y guardando `ultimo_aviso`.

## El nodo Code
```js
const cobros = $('Stripe').all().map(i => i.json);
const hoy = new Date();
const out = [];
for (const it of $('Filter').all()) {
  const s = it.json;
  const pagado = cobros.some(c => (c.metadata && c.metadata.id_servicio === s.id_servicio) || (c.status === 'succeeded' && Math.round(c.amount) === Math.round(Number(s.importe) * 100) && (c.receipt_email || '') === s.email));
  const dias = Math.floor((hoy - new Date(s.fecha)) / 86400000);
  let tramo = null;
  if (pagado) tramo = 'pagado';
  else if (dias >= 30) tramo = 'llamada';
  else if (dias >= 20) tramo = 'aviso3';
  else if (dias >= 10) tramo = 'aviso2';
  else if (dias >= 3) tramo = 'aviso1';
  if (!tramo) continue;
  const enviados = Number(s.avisos_enviados || 0);
  const orden = { aviso1: 1, aviso2: 2, aviso3: 3, llamada: 4 };
  if (tramo !== 'pagado' && enviados >= orden[tramo]) continue;
  out.push({ json: { ...s, dias, tramo, avisos_enviados: tramo === 'pagado' ? enviados : orden[tramo], ultimo_aviso: hoy.toISOString().slice(0, 10) } });
}
return out;
```

## Cómo probarla
Usa las claves de test de Stripe y una tarjeta `4242 4242 4242 4242` para simular un cobro; comprueba que el servicio pasa a `pagado` y deja de recibir avisos.
Crea tres servicios con fechas de hace 4, 12 y 25 días y verifica que cada uno recibe solo el aviso que le toca.

## Qué puede salir mal
Cruzar por importe es frágil si tienes muchos servicios al mismo precio: pásale siempre `metadata[id_servicio]` al crear el enlace de pago en Stripe.
El campo `avisos_enviados` es lo que evita el bombardeo diario; si lo borras, todos reciben todo otra vez.
Cobros en efectivo hay que apuntarlos en la hoja el mismo día o el paciente recibirá un recordatorio injusto y muy molesto.
No pongas nunca el nombre del tratamiento en el asunto ni en el WhatsApp: solo la fecha y el importe.
Stripe API limita a unas 100 peticiones por segundo, no es un problema aquí; usa paginación si tienes más de 100 cobros al día.

## Cuánto cuesta
n8n auto-alojado 0 €.
Stripe: 1,5% + 0,25 € por cobro con tarjeta europea, sin cuota fija.
Twilio unos pocos euros al mes; Gmail y Sheets gratis.
