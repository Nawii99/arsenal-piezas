# Control de bonos de sesiones y aviso antes de que se ag…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Lleva la cuenta de las sesiones que le quedan a cada cliente de su bono y le avisa cuando le quedan dos y cuando se le acaba, con enlace para renovar.

## Qué es y qué hace

Cada noche lee las citas ya realizadas del calendario, descuenta una sesión del bono de cada cliente en Google Sheets y, al quedar 2 o 0, envía por Gmail un resumen con el enlace para renovar. Entrada: eventos de Calendar y hoja Bonos; salida: saldos actualizados y correos. Se monta en n8n y es útil para fisios, entrenadores o centros de pilates.

## Cómo usarla

1. Prepara las hojas Bonos y Consumos
2. Nombra los eventos de Calendar con el nombre del cliente
3. Conecta Gmail y el enlace de renovación
4. Que lo revise un profesional

## Cuándo usarla

Cuando vendes bonos de 5 o 10 sesiones y llevas la cuenta en un cuaderno, con el lío de saber quién ha gastado qué y perdiendo renovaciones.

## Cómo ganar dinero con ella

Avisar dos sesiones antes sube la renovación notablemente. En un centro que vende 30 bonos al mes de 250 €, recuperar 3 renovaciones son 750 € mensuales.

- Control automático de bonos para un centro de fisioterapia con renovaciones por email.
- Gestión de paquetes de sesiones para entrenadores personales con histórico de consumos.
- Automatización de renovaciones para un estudio de pilates con treinta bonos al mes.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada noche lee las citas del día que ya han pasado, descuenta una sesión del bono de cada cliente en una hoja, y cuando el saldo baja a 2 o a 0 le manda un email con el resumen de sus sesiones y cómo renovar.
Para fisios, entrenadores personales, centros de pilates, estética, logopedia o cualquiera que venda paquetes de sesiones.

## Lo que necesitas antes
- Google Sheet `Bonos` con: cliente, email, bono_total, consumidas, restantes, fecha_compra, caduca, aviso_2, aviso_0.
- Google Sheet `Consumos` (histórico) con: fecha, cliente, event_id.
- Google Calendar donde el título de la cita sea exactamente el nombre del cliente, o lleve el nombre después de un guion: `Pilates - Marta Ruiz`.
- Gmail conectado y un enlace de pago o de reserva para renovar (Stripe Payment Link, Bizum manual, lo que uses).
- n8n.

## Los nodos, en orden
1. **Schedule Trigger** – Cron `0 22 * * 1-6`, Timezone Europe/Madrid. A las 22:00, cuando el día ya está cerrado.
2. **Google Calendar** – Get Many. Time Min `={{ $now.startOf('day').toISO() }}`, Time Max `={{ $now.toISO() }}`, Single Events activado, Return All activado.
3. **Google Sheets** – Read Rows de `Consumos` para saber qué eventos ya se descontaron.
4. **Code** – filtra los eventos ya contados y extrae el nombre del cliente del título. Código abajo.
5. **IF** – `={{ $json.nuevos }}` is greater than `0`. Si no hay citas nuevas, se acaba aquí.
6. **Split Out** – Field to Split Out: `citas`. Te convierte la lista en un item por cita.
7. **Google Sheets** – Read Rows de `Bonos` filtrando por `cliente` igual a `={{ $json.cliente }}`.
8. **Code** – resta uno a `restantes` y suma uno a `consumidas`.
9. **Google Sheets** – Update en `Bonos`, Matching Column `cliente`.
10. **Google Sheets** – Append en `Consumos` con fecha, cliente y event_id, para no volver a descontar mañana.
11. **Switch** – Mode: Rules sobre `={{ $json.restantes }}`. Regla 1: equal to `2`. Regla 2: equal to `0`. Salida por defecto: no hace nada.
12. **Gmail** (rama de 2) – asunto «Te quedan 2 sesiones», texto con las fechas de las sesiones usadas y el enlace de renovación.
13. **Gmail** (rama de 0) – asunto «Bono terminado, ¿seguimos?» con el enlace de compra y una propuesta de dos horarios.
14. **Google Sheets** – Update de `aviso_2` o `aviso_0` con la fecha para no repetir el aviso.

## El código del nodo Code (paso 4)
```
const yaContadas = $('Google Sheets').all().map(i => i.json.event_id);
const citas = [];
for (const item of $('Google Calendar').all()) {
  const ev = item.json;
  if (yaContadas.includes(ev.id)) continue;
  if (ev.status === 'cancelled') continue;
  const titulo = (ev.summary || '').trim();
  const cliente = titulo.includes(' - ') ? titulo.split(' - ').pop().trim() : titulo;
  if (!cliente) continue;
  citas.push({ cliente, event_id: ev.id, fecha: (ev.start.dateTime || ev.start.date).slice(0, 10) });
}
return [{ json: { nuevos: citas.length, citas } }];
```

## Cómo probarla
- Crea un cliente de prueba en `Bonos` con 3 sesiones restantes y tu email.
- Mete tres citas en el calendario a lo largo de hoy con su nombre en el título y ejecuta el flujo: `restantes` debe quedar en 0 y te llegan dos emails (el de 2 y el de 0) si las tres citas entran en la misma ejecución.
- Vuelve a ejecutarlo sin tocar nada: no debe descontar de nuevo. Si descuenta, el nodo de `Consumos` no está guardando bien el `event_id`.
- Prueba con una cita cuyo título no coincida con ningún cliente: debe pasar de largo sin romper el flujo.

## Qué puede salir mal
- **Nombres que no cuadran**: «Marta Ruiz» y «marta ruiz» no son lo mismo para el Sheets. Normaliza en el Code con `.toLowerCase()` y guarda también en la hoja en minúsculas.
- **Saldos negativos**: añade un IF antes del update para no bajar de 0, o lo verás en -3 y no te enterarás de que el cliente lleva tres sesiones regaladas.
- **Sesiones canceladas que se descuentan**: por eso filtras `status === 'cancelled'`. Si tú borras la cita en vez de cancelarla, ni siquiera aparece.
- **Bonos caducados**: añade un segundo Schedule mensual que compare la columna `caduca` con la fecha de hoy y te avise a ti para decidir si lo estiras.
- **Dos citas del mismo cliente el mismo día**: se descuentan las dos, que es lo correcto si son dos sesiones. Si tienes clases dobles que cuentan como una, marca el título con `[doble]` y trátalo en el Code.

## Cuánto cuesta
- 0 € con n8n auto-alojado, Sheets, Calendar y Gmail.
- Si quieres cobrar la renovación desde el propio email, un Payment Link de Stripe es gratis de crear y cobra alrededor del 1,5% + 0,25 € por transacción europea.
