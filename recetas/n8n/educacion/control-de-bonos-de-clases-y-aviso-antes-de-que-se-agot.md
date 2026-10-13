# Control de bonos de clases y aviso antes de que se agot…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Lleva la cuenta de las sesiones consumidas de cada bono, avisa al alumno cuando le quedan dos y te avisa a ti para ofrecer la renovación en el momento justo.

## Qué es y qué hace

Lleva la cuenta de las sesiones consumidas de cada bono leyendo las clases del día en Google Calendar y actualiza el saldo en una hoja de Google Sheets. Cuando quedan dos sesiones envía un email de renovación al alumno y te avisa; al llegar a cero bloquea nuevas reservas. Se monta en n8n sobre el calendario que ya usas, sin cambiar de agenda.

## Cómo usarla

1. Crea la hoja Bonos con sus columnas
2. Conecta Calendar, Sheets y Gmail en n8n
3. Activa el cron nocturno y prueba una semana
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando vendes bonos de 5 o 10 clases y llevas la cuenta en la cabeza o en un cuaderno, con lo que siempre hay discusiones y renovaciones que se pierden.

## Cómo ganar dinero con ella

Recuperar 3 renovaciones al mes de un bono de 150 € son 450 € que se caían por no avisar a tiempo. Y se acaban las reclamaciones por sesiones descontadas mal.

- Instalación del control de bonos para academias de idiomas o profesores particulares, en un proyecto de uno o dos días.
- Mantenimiento mensual: revisar saldos, corregir avisos y añadir bonos nuevos cuando cambian los precios.
- Plantilla de bonos y renovaciones vendida a autónomos que cobran paquetes de sesiones por adelantado.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada noche lee las clases del día en tu Google Calendar, descuenta una sesión al bono del alumno correspondiente y actualiza el saldo en una hoja. Cuando quedan 2 sesiones, manda un email al alumno con la propuesta de renovación y te avisa a ti. Cuando llega a 0, marca el bono como agotado y bloquea nuevas reservas hasta que cobres.
Funciona con el calendario que ya usas: no hay que cambiar de sistema.

## Lo que necesitas antes
- Google Calendar donde los eventos de clase lleven el email del alumno como invitado, o el nombre exacto en el título con el formato `Clase - Nombre Apellido`.
- Hoja `Bonos` con: `alumno`, `email`, `sesiones_compradas`, `sesiones_usadas`, `saldo`, `fecha_compra`, `caducidad`, `estado`, `precio_bono`, `aviso_enviado`.
- Credenciales de Google Calendar, Sheets y Gmail en n8n.

## Los nodos, en orden
1) **Schedule Trigger** — Cron `0 22 * * *`, Timezone `Europe/Madrid`.
2) **Google Calendar** (Operation: Get Many Events) — Calendar el tuyo, After `{{ $now.startOf('day').toISO() }}`, Before `{{ $now.endOf('day').toISO() }}`, Return All. En Options activa Single Events para que las series se expandan.
3) **Code** — extrae el email o el nombre del alumno de cada evento y descarta los que no sean clase. Código abajo.
4) **Google Sheets** (Get Rows) — hoja `Bonos`, Return All.
5) **Code** — cruza clases del día con bonos, resta sesiones y decide a quién avisar. Código abajo.
6) **Google Sheets** (Append or Update Row) — hoja `Bonos`, Matching Column `email`, actualizando `sesiones_usadas`, `saldo`, `estado`.
7) **Switch** (Mode: Rules) — Rule 1: `{{ $json.saldo }}` equals 2 → salida `aviso`. Rule 2: `{{ $json.saldo }}` equals 0 → salida `agotado`. Fallback Output: none.
8) **Gmail** (Send Message) en la salida `aviso` — To el alumno, Subject `Te quedan 2 clases del bono`, cuerpo con el enlace de pago del siguiente bono.
9) **Gmail** (Send Message) en la salida `agotado` — To el alumno y copia a ti, avisando de que la próxima clase requiere renovar.
10) **Gmail** (Send Message) final — a ti, resumen diario: quién ha dado clase, saldos actualizados y bonos caducados.

## El código del nodo 3
```js
const out = [];
for (const it of items) {
  const e = it.json;
  const titulo = e.summary || '';
  if (!/clase|sesi[óo]n|tutor[ií]a/i.test(titulo)) continue;
  if (e.status === 'cancelled') continue;
  let email = (e.attendees || []).map(a => a.email).find(a => a && !a.includes('tu-correo@'));
  const nombre = titulo.split('-').slice(1).join('-').trim();
  out.push({ json: { email: (email || '').toLowerCase(), nombre, inicio: e.start?.dateTime || e.start?.date } });
}
return out;
```

## El código del nodo 5
```js
const clases = $('Code').all().map(i => i.json);
const bonos = items.map(i => i.json);
const hoy = new Date().toISOString().slice(0,10);
const res = [];
for (const b of bonos) {
  const suyas = clases.filter(c => (c.email && c.email === String(b.email).toLowerCase()) || (c.nombre && c.nombre === b.alumno));
  if (!suyas.length) continue;
  const usadas = Number(b.sesiones_usadas || 0) + suyas.length;
  const saldo = Math.max(0, Number(b.sesiones_compradas || 0) - usadas);
  const caducado = b.caducidad && b.caducidad < hoy;
  res.push({ json: { ...b, sesiones_usadas: usadas, saldo, estado: caducado ? 'caducado' : (saldo === 0 ? 'agotado' : 'activo') } });
}
return res;
```

## Cómo probarla
- Crea dos eventos de prueba hoy con el título `Clase - Prueba Uno` y un alumno ficticio con saldo 3 en la hoja. Ejecuta a mano y comprueba que el saldo baja a 1.
- Cancela un evento y vuelve a ejecutar: no debe descontar.
- Ejecuta dos veces el mismo día para ver el problema de doble descuento y arreglarlo con la columna `ultima_fecha_procesada`.

## Qué puede salir mal
- **Doble descuento si ejecutas dos veces**: añade en la hoja una columna `ultima_fecha_procesada` y en el Code salta el bono si ya vale la fecha de hoy. Es el fallo más habitual.
- **Alumnos con el mismo nombre**: usa siempre el email del invitado como clave, no el título.
- **Clases canceladas con menos de 24 horas**: decide tu política y refléjala; si se cobran, no filtres por `status === 'cancelled'`.
- **Eventos recurrentes**: sin Single Events activado, Calendar devuelve la serie y no las ocurrencias.

## Cuánto cuesta
- Todo gratis salvo el alojamiento de n8n. En Make cabe de sobra en el plan gratuito.
- Si quieres cobrar el bono desde el propio email, un enlace de pago de Stripe cuesta 1,5% + 0,25 € por cobro y no tiene cuota.
