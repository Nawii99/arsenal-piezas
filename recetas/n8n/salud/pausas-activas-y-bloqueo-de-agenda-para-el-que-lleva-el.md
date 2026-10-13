# Pausas activas y bloqueo de agenda para el que lleva el…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Mira tu calendario cada mañana, busca los huecos reales entre citas y te reserva pausas, comida y una sesión de movimiento, con aviso al móvil cuando toca.

## Qué es y qué hace

Cada mañana lee el calendario de Google, busca huecos de más de 25 minutos y crea bloques de comida y de movimiento. Cada 90 minutos de jornada envía por Telegram una pausa de 3 minutos. Entrada: eventos de Calendar y horario; salida: eventos bloqueados y avisos. Se monta en n8n con los nodos de Google Calendar y Telegram.

## Cómo usarla

1. Define tu horario y los minutos de comida y movimiento
2. Conecta Calendar y Telegram en n8n
3. Que lo revise un profesional

## Cuándo usarla

Cuando encadenas clientes sin levantarte de la silla, comes de pie a las cuatro y llevas meses diciendo que empiezas a moverte la semana que viene.

## Cómo ganar dinero con ella

Menos bajas y menos días perdidos por dolor de espalda o agotamiento. Un autónomo que factura 250 €/día pierde 1.000 € cada 4 días de parón.

- Bloqueo de agenda con pausas para un fisioterapeuta que encadena pacientes.
- Configuración de avisos de descanso para un autónomo del sector del bienestar.
- Plantilla de agenda protegida para un entrenador personal con jornada partida.

**Precio orientativo:** 100–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
A las 6:30 de la mañana lee tu agenda del día, encuentra los huecos libres de más de 25 minutos, y crea en tu calendario un bloque de comida y un bloque de movimiento en los mejores huecos. Además, cada 90 minutos de jornada te manda un Telegram con una pausa de 3 minutos: levántate, estira, bebe agua, mira lejos.
Para el autónomo o dueño de negocio de bienestar que cuida a todo el mundo menos a sí mismo.

## Lo que necesitas antes
- Google Calendar conectado en n8n.
- Bot de Telegram (@BotFather) y tu chat_id.
- Decidir tus horas de trabajo, por ejemplo de 8:00 a 19:00, y cuánto quieres reservar: 40 minutos de comida y 30 de movimiento.
- n8n.

## Los nodos, en orden
1. **Schedule Trigger** – Cron `30 6 * * 1-5`, Timezone Europe/Madrid.
2. **Google Calendar** – Get Many. Time Min `={{ $now.startOf('day').plus({hours: 8}).toISO() }}`, Time Max `={{ $now.startOf('day').plus({hours: 19}).toISO() }}`, Single Events activado, Return All activado.
3. **Code** – calcula los huecos libres y elige dónde meter comida y movimiento. Código abajo.
4. **IF** – `={{ $json.hay_huecos }}` is true. Si el día está a tope, ve a la rama de aviso.
5. **Google Calendar** – Operation: Create. Summary: `Comer sin pantalla`. Start: `={{ $json.comida_inicio }}`, End: `={{ $json.comida_fin }}`. En Additional Fields marca Color y ponle uno distinto.
6. **Google Calendar** – Create. Summary: `Movimiento`. Start y End del hueco de movimiento. Description: la rutina de 20 minutos que quieras.
7. **Telegram** – Send Message con el plan del día: cuántas citas tienes, a qué hora comes y a qué hora te mueves.
8. **Telegram** (rama del IF en false) – «Hoy no cabe nada. Tienes X citas seguidas. ¿Mueves alguna?».
9. **Schedule Trigger** (workflow dos, «Micropausas») – Cron `0 9,11,13,16,18 * * 1-5`, Timezone Europe/Madrid.
10. **Google Calendar** – Get Many de los próximos 10 minutos, para no interrumpirte en mitad de una sesión.
11. **IF** – `={{ $json.length }}` equal to `0`, es decir, solo avisa si estás libre.
12. **Code** – elige al azar una de tus microrrutinas de una lista.
13. **Telegram** – Send Message con el texto de la pausa y un botón «Hecho» que apunte en una hoja tu racha (reutiliza el registro de hábitos si ya lo tienes montado).

## El código del nodo Code (paso 3)
```
const eventos = $input.all().map(i => i.json).filter(e => e.start && e.start.dateTime).map(e => ({ ini: new Date(e.start.dateTime), fin: new Date(e.end.dateTime) })).sort((a, b) => a.ini - b.ini);
const base = new Date(); base.setHours(0, 0, 0, 0);
const H = h => new Date(base.getTime() + h * 3600000);
let cursor = H(8);
const huecos = [];
for (const e of eventos) { if (e.ini - cursor >= 25 * 60000) huecos.push({ ini: new Date(cursor), fin: new Date(e.ini) }); if (e.fin > cursor) cursor = e.fin; }
if (H(19) - cursor >= 25 * 60000) huecos.push({ ini: new Date(cursor), fin: H(19) });
if (!huecos.length) return [{ json: { hay_huecos: false, citas: eventos.length } }];
const cerca = (h, hora) => Math.abs(h.ini.getHours() - hora);
const comidaHueco = [...huecos].sort((a, b) => cerca(a, 14) - cerca(b, 14))[0];
const restantes = huecos.filter(h => h !== comidaHueco);
const movHueco = restantes.length ? restantes.sort((a, b) => (b.fin - b.ini) - (a.fin - a.ini))[0] : null;
const iso = d => d.toISOString();
const mas = (d, min) => new Date(d.getTime() + min * 60000);
return [{ json: {
  hay_huecos: true,
  citas: eventos.length,
  comida_inicio: iso(comidaHueco.ini),
  comida_fin: iso(mas(comidaHueco.ini, 40)),
  mov_inicio: movHueco ? iso(movHueco.ini) : null,
  mov_fin: movHueco ? iso(mas(movHueco.ini, 30)) : null
} }];
```

## Cómo probarla
- Mete tres citas de prueba en el día de hoy dejando un hueco de 13:30 a 15:00 y otro de 17:00 a 18:00, y ejecuta el flujo: la comida debe caer a las 13:30 y el movimiento a las 17:00.
- Llena el día entero de citas y comprueba que te llega el mensaje de «hoy no cabe nada».
- Ejecuta el flujo dos veces: te creará dos bloques repetidos. Añade un filtro que descarte los eventos con título `Comer sin pantalla` o `Movimiento` antes de calcular, y ya no se duplican.
- Prueba la micropausa a una hora en la que tengas cita: no debe llegarte nada.

## Qué puede salir mal
- **Eventos de todo el día**: los de tipo `date` sin hora rompen el cálculo. Por eso se filtran en la primera línea del Code.
- **Zona horaria**: el ISO que devuelve `toISOString()` va en UTC y Google lo interpreta bien, pero el `setHours` usa la hora del servidor de n8n. Si tu n8n está en un servidor con UTC, arráncalo con `GENERIC_TIMEZONE=Europe/Madrid` y `TZ=Europe/Madrid`.
- **Citas que se solapan**: el cursor las va absorbiendo, pero si tienes dos calendarios (personal y trabajo) haz dos nodos Google Calendar y junta los eventos con un **Merge** en modo Append.
- **Bloques que molestan a los clientes**: si usas Calendly o Cal.com conectado a ese calendario, los bloques hacen que esos huecos ya no se puedan reservar. Es justo lo que quieres, pero tenlo claro.
- **Te acostumbras a ignorar los avisos**: cambia el texto de las pausas cada mes y quita las que nunca cumples. Un aviso que ignoras siempre es peor que ninguno.

## Cuánto cuesta
- Gratis: Calendar, Telegram y n8n auto-alojado.
- Si quieres avisos con sonido en el móvil de forma más agresiva, ntfy.sh es gratis y se llama con un HTTP Request de una línea.
