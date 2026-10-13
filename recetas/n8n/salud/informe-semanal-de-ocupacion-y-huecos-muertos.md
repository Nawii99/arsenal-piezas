# Informe semanal de ocupación y huecos muertos…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Cada lunes te manda un email con la ocupación real de cada profesional y de cada sala, los huecos sueltos que nadie puede aprovechar y qué franjas están siempre vacías.

## Qué es y qué hace

Cada lunes lee la semana que acaba de terminar en los calendarios de cada profesional o sala, calcula minutos ocupados frente a jornada y detecta huecos de 15 a 40 minutos que no se pueden vender. Te manda un email con una tabla y guarda la serie en una hoja. Entrada: calendarios y jornadas; salida: informe semanal e histórico. Se monta en n8n con Google Calendar, Sheets y Gmail.

## Cómo usarla

1. Compartir los calendarios con la cuenta de n8n
2. Crear las hojas Ocupacion y Jornadas
3. Probar con una semana pasada
4. Activar el informe del lunes

## Cuándo usarla

Cuando no sabes si te falta agenda o te sobra sitio, y contratas o alquilas a ojo porque no tienes números de ocupación.

## Cómo ganar dinero con ella

Ver que los martes por la tarde están al 30% te permite mover horarios o lanzar una promo; un 10% más de ocupación en una agenda de 6.000 €/mes son 600 €.

- Medir la ocupación de clínicas con varias salas, cobrando configuración y un informe mensual.
- Ofrecer análisis de huecos muertos a centros de fisioterapia con varios profesionales.
- Montar el histórico de ocupación para decidir promociones por franja horaria.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Lee la semana que acaba de terminar en los calendarios de cada profesional, calcula minutos ocupados frente a minutos de jornada, detecta huecos de entre 15 y 40 minutos entre citas (los que no se pueden vender) y compara con la semana anterior.
Te lo manda en un email con tabla y guarda la serie histórica en un Sheet para que dentro de un año puedas ver la estacionalidad.
Para clínicas con dos o más profesionales o salas.

## Lo que necesitas antes
Un calendario de Google por profesional o por sala, compartido con la cuenta que usa n8n.
Credencial `Google Calendar OAuth2` y `Google Sheets OAuth2`.
Google Sheet `Ocupacion` con `semana`, `profesional`, `minutos_disponibles`, `minutos_ocupados`, `ocupacion_pct`, `huecos_muertos`, `citas`.
Google Sheet `Jornadas` con `profesional`, `calendar_id`, `hora_inicio`, `hora_fin`, `dias` (por ejemplo `1,2,3,4,5`).

## Los nodos, en orden
1. **Schedule Trigger** — `0 8 * * 1`, timezone `Europe/Madrid`.
2. **Google Sheets** — `Get Row(s)` de `Jornadas`, `Return All`.
3. **Loop Over Items** (Split In Batches, tamaño 1) para procesar profesional a profesional.
4. **Google Calendar** — `Get Many`, Calendar `{{$json.calendar_id}}`, Start `{{$now.minus(1,'week').startOf('week').toISO()}}`, End `{{$now.startOf('week').toISO()}}`, `Return All`, `Single Events` activado para que las repeticiones se expandan.
5. **Code** — calcula ocupación y huecos (código abajo).
6. **Google Sheets** — `Append Row` en `Ocupacion`.
7. Fuera del bucle, **Code** — construye la tabla HTML ordenada de menor a mayor ocupación y añade la comparación con la semana anterior leída del Sheet.
8. **Gmail** — `Send` a tu correo, asunto `Ocupación semana {{$now.minus(1,'week').weekNumber}}`, Email Type `HTML`.

## El nodo Code de cálculo
```js
const jornada = $('Loop Over Items').first().json;
const eventos = $input.all().map(i => i.json).filter(e => e.status !== 'cancelled' && !String(e.summary || '').includes('[BLOQUEO]'));
const dias = String(jornada.dias).split(',').map(Number);
const [hi, mi] = String(jornada.hora_inicio).split(':').map(Number);
const [hf, mf] = String(jornada.hora_fin).split(':').map(Number);
const minutosDia = (hf * 60 + mf) - (hi * 60 + mi);
const disponibles = minutosDia * dias.length;
let ocupados = 0;
let huecosMuertos = 0;
const porDia = {};
for (const e of eventos) {
  const ini = new Date(e.start.dateTime || e.start.date);
  const fin = new Date(e.end.dateTime || e.end.date);
  ocupados += (fin - ini) / 60000;
  const clave = ini.toISOString().slice(0, 10);
  (porDia[clave] = porDia[clave] || []).push([ini, fin]);
}
for (const clave of Object.keys(porDia)) {
  const lista = porDia[clave].sort((a, b) => a[0] - b[0]);
  for (let i = 1; i < lista.length; i++) {
    const gap = (lista[i][0] - lista[i - 1][1]) / 60000;
    if (gap >= 15 && gap <= 40) huecosMuertos++;
  }
}
return [{ json: { semana: $now.minus(1, 'week').toFormat('kkkk-WW'), profesional: jornada.profesional, minutos_disponibles: disponibles, minutos_ocupados: Math.round(ocupados), ocupacion_pct: Math.round((ocupados / disponibles) * 100), huecos_muertos: huecosMuertos, citas: eventos.length } }];
```

## Cómo probarla
Ejecuta a mano un lunes cualquiera y compara la ocupación de un profesional con lo que ves en su calendario: si da más del 100%, tienes citas solapadas o eventos de todo el día colándose.
Marca un evento de vacaciones como `[BLOQUEO]` y comprueba que deja de contar como cita.

## Qué puede salir mal
Eventos de día completo inflan las cifras: fíltralos añadiendo `if (e.start.date && !e.start.dateTime) continue;`.
Festivos: si no los descuentas, la ocupación de las semanas de puente sale artificialmente baja; añade una hoja `Festivos` y réstalos de `disponibles`.
Citas duplicadas en dos calendarios distintos cuentan doble; decide un único calendario fuente por profesional.
Google Calendar API tiene cuota de 1.000.000 de consultas al día, no la vas a rozar.

## Cuánto cuesta
Todo gratis: n8n auto-alojado, Google Calendar, Sheets y Gmail.
Si usas n8n Cloud, unos 20 €/mes y esta automatización consume 5 ejecuciones al mes.
