# Informe semanal de huecos vacíos y ausencias…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Cada lunes calcula cuántas horas de agenda quedaron vacías, cuántas ausencias hubo por profesional y a qué horas fallas, y te lo manda en un email claro.

## Qué es y qué hace

Cada lunes a las 7:00 lee la agenda de la semana pasada, cuenta las horas ocupadas frente a las de apertura por profesional y franja, y cuenta las citas marcadas como ausencia. Envía un email con una tabla y las tres franjas peor cubiertas, y guarda la serie en una hoja. Entrada: Google Calendar y horarios; salida: informe semanal. Se monta en n8n con Calendar, Sheets y Gmail.

## Cómo usarla

1. Crear la hoja Metricas y el horario de apertura
2. Marcar las ausencias con NO SHOW
3. Probar con una semana pasada
4. Activar el informe del lunes

## Cuándo usarla

Cuando no sepas de verdad cuánto rinde tu agenda y decidas horarios, contrataciones o promociones a ojo, sin números encima de la mesa.

## Cómo ganar dinero con ella

Ver que los martes por la mañana tienes un 40% de agenda vacía te permite mover horarios o lanzar oferta ahí. Suele valer 200-600 € al mes en ocupación.

- Montar el panel de ocupación para clínicas con varios profesionales que deciden horarios a ojo.
- Ofrecer un informe mensual de ocupación y ausencias a gerentes de centros de fisioterapia.
- Vender la configuración y la formación para leer el informe y tomar decisiones de agenda.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada lunes a las 7:00 lee toda la agenda de la semana pasada, cuenta horas ocupadas frente a horas de apertura por profesional y por franja, cuenta las citas marcadas como ausencia y te manda un email con la tabla y las tres franjas peor cubiertas.
Es para el dueño o el gerente de una clínica con dos o más profesionales, que necesita decidir con datos y no con sensaciones.

## Lo que necesitas antes
- Google Calendar con una agenda por profesional, o una sola con el formato de título `Paciente - Profesional`.
- Norma: cuando alguien no viene, se añade `NO SHOW` al título de la cita antes de dejarla. Esto es lo único manual y es imprescindible.
- Una hoja de Google Sheets llamada Metricas con las columnas: semana, profesional, horas_disponibles, horas_ocupadas, ocupacion, ausencias.
- Tu horario de apertura escrito en el nodo Code (por ejemplo, de lunes a viernes de 9 a 20, sábado cerrado).
- Gmail y n8n.

## Los nodos, en orden
1. **Schedule Trigger**: `0 7 * * 1`, lunes a las 7:00, zona Europe/Madrid.
2. **Google Calendar** (Get Many Events): Return All activado, After = `{{ $now.minus(1, 'week').startOf('week').toISO() }}`, Before = `{{ $now.startOf('week').toISO() }}`. En n8n, startOf('week') es lunes.
3. **Code** (Run Once for All Items): hace todo el cálculo. Código completo abajo.
4. **Google Sheets** (Append or Update): mete una fila por profesional en la hoja Metricas, usando semana + profesional como clave.
5. **HTML**: monta una tabla sencilla con los resultados; en el nodo HTML pega una plantilla con `{{ $json.tabla_html }}` dentro.
6. **Gmail** (Send): a tu dirección, asunto `Ocupación semana {{ $json.semana }}: {{ $json.ocupacion_total }}%`, cuerpo el HTML. Marca la opción de enviar como HTML.
7. Opcional, **IF**: si la ocupación total baja del 65%, añade un segundo Gmail con asunto de alerta o un mensaje a tu Telegram con el nodo **Telegram**.

## El trozo de código del nodo 3
```javascript
const APERTURA = { 1: 11, 2: 11, 3: 11, 4: 11, 5: 11, 6: 0, 0: 0 };
const eventos = $input.all().map(i => i.json);
const porProf = {};
let ausencias = 0;
const franjas = {};
for (const ev of eventos) {
  if (ev.status === 'cancelled') continue;
  if (!ev.start || !ev.start.dateTime) continue;
  const ini = new Date(ev.start.dateTime);
  const fin = new Date(ev.end.dateTime);
  const horas = (fin - ini) / 3600000;
  const titulo = ev.summary || '';
  const prof = (titulo.split(' - ')[1] || 'Sin asignar').replace('NO SHOW', '').trim();
  if (!porProf[prof]) porProf[prof] = { ocupadas: 0, ausencias: 0 };
  porProf[prof].ocupadas += horas;
  if (titulo.toUpperCase().includes('NO SHOW')) { porProf[prof].ausencias++; ausencias++; }
  const clave = ini.toLocaleDateString('es-ES', { weekday: 'long' }) + ' ' + ini.getHours() + 'h';
  franjas[clave] = (franjas[clave] || 0) + horas;
}
let disponiblesSemana = 0;
for (let d = 0; d < 7; d++) { disponiblesSemana += APERTURA[d]; }
const nProf = Math.max(Object.keys(porProf).length, 1);
const filas = [];
let totalOcupadas = 0;
for (const [prof, v] of Object.entries(porProf)) {
  const ocupacion = Math.round((v.ocupadas / disponiblesSemana) * 100);
  totalOcupadas += v.ocupadas;
  filas.push(`<tr><td>${prof}</td><td>${v.ocupadas.toFixed(1)} h</td><td>${ocupacion}%</td><td>${v.ausencias}</td></tr>`);
}
const peores = Object.entries(franjas).sort((a, b) => a[1] - b[1]).slice(0, 3).map(f => f[0]).join(', ');
const tabla_html = `<table border=1 cellpadding=6><tr><th>Profesional</th><th>Horas ocupadas</th><th>Ocupación</th><th>Ausencias</th></tr>${filas.join('')}</table><p>Franjas más flojas: ${peores}</p>`;
return [{ json: {
  semana: new Date().toISOString().slice(0, 10),
  ocupacion_total: Math.round((totalOcupadas / (disponiblesSemana * nProf)) * 100),
  ausencias,
  tabla_html
} }];
```
Cambia el objeto APERTURA por tus horas reales de apertura de cada día de la semana (0 es domingo).

## Cómo probarla
1. Ejecuta el flujo un lunes cualquiera y compara el total de horas ocupadas con lo que ves en la agenda de la semana anterior. Si no cuadra, casi siempre es porque hay citas de todo el día sin hora, que el código descarta a propósito.
2. Marca una cita antigua con NO SHOW y vuelve a ejecutar: el contador de ausencias tiene que subir.
3. Revisa que el email llega con la tabla bien formada y no con el HTML en crudo: eso pasa si olvidas marcar el envío como HTML en Gmail.

## Qué puede salir mal
- **Nombres de profesional inconsistentes**: si un día escribes «Marta» y otro «Marta G.», salen dos filas. Pon los nombres en un desplegable de tu software o acuerda el formato exacto con el equipo.
- **Citas de bloqueo**: las vacaciones o los descansos cuentan como ocupadas. Añade una regla en el código que salte los títulos que contengan BLOQUEO o VACACIONES.
- **Semana con festivo**: la ocupación baja artificialmente. Puedes restar 11 horas a disponiblesSemana por cada festivo, con una lista de festivos en el propio código.
- **Datos que se acumulan**: la hoja Metricas crece una fila por profesional y semana; en tres años son unas 500 filas, nada preocupante, y te sirve para ver la evolución en un gráfico de Sheets.

## Cuánto cuesta
- Todo gratis: Google Calendar, Sheets y Gmail con cuenta normal, n8n auto-alojado.
- Único coste el VPS, unos 5 € al mes, compartido con el resto de tus flujos.
