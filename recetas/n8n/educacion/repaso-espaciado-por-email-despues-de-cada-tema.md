# Repaso espaciado por email después de cada tema…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Cuando un alumno termina un tema, le programa automáticamente tres emails de repaso (a los 2, 7 y 21 días) con preguntas de ese tema y el enlace para repasar. Para academias de oposiciones.

## Qué es y qué hace

Cuando se registra que un alumno ha terminado un tema, programa tres repasos a los 2, 7 y 21 días en una hoja de envíos. Cada día un flujo manda 4 preguntas del banco de ese tema, con las respuestas al final para que el alumno se autoevalúe. Aplica repetición espaciada sin que el alumno haga nada, con Sheets y Gmail en n8n.

## Cómo usarla

1. Crea las hojas Progreso, Repasos y Banco
2. Carga las preguntas por tema
3. Programa el envío diario
4. Revisa el primer lote antes de activarlo

## Cuándo usarla

Úsalo cuando tus alumnos aprueban el test del tema y a las tres semanas no se acuerdan de nada.

## Cómo ganar dinero con ella

Sube la tasa de aprobados y el boca a boca, que es lo que llena una academia. Cuesta céntimos y funciona solo una vez montado.

- Montaje de repasos espaciados para academias de oposiciones, con banco de preguntas inicial.
- Mantenimiento trimestral del banco de preguntas y de los envíos para una academia activa.
- Plan de repasos para profesores de idiomas que quieren que los alumnos retengan vocabulario.

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cuando se registra que un alumno ha terminado un tema, el flujo programa tres repasos en el calendario de envíos. Cada día, un segundo flujo mira qué repasos tocan hoy y manda el email con 4 preguntas del banco de ese tema (las respuestas van al final, para que se autoevalúe) y una frase de resumen.
Es la técnica de repetición espaciada, que es lo que de verdad hace que se fije el temario, aplicada sin que el alumno tenga que hacer nada.

## Lo que necesitas antes
- Hoja `Progreso` con: `email`, `nombre`, `tema`, `fecha_completado`.
- Hoja `Repasos` (vacía al principio) con: `id`, `email`, `nombre`, `tema`, `fecha_envio`, `numero_repaso`, `enviado`.
- Hoja `Banco` con preguntas por tema: `tema`, `pregunta`, `respuesta`. Puedes llenarla a mano o con la receta de generación de exámenes.
- Credenciales de Sheets y Gmail. La clave de OpenAI solo si quieres que redacte el mensaje de ánimo; se puede prescindir de ella.

## Los nodos, en orden
**Flujo A: programar los repasos**
1) **Google Sheets Trigger** — On Row Added, hoja `Progreso`, Poll Every Minute.
2) **Code** — crea las tres filas de repaso con sus fechas. Código abajo.
3) **Google Sheets** (Append Row) — hoja `Repasos`, una fila por cada uno de los tres.
**Flujo B: enviar lo que toca hoy**
4) **Schedule Trigger** — Cron `0 18 * * *`, Timezone `Europe/Madrid` (a las 18:00, que es cuando se leen los emails de estudio).
5) **Google Sheets** (Get Rows) — hoja `Repasos`, Filters: `fecha_envio` igual a `{{ $now.format('yyyy-MM-dd') }}` y `enviado` vacío.
6) **IF** — `{{ $items().length }}` is greater than 0.
7) **Google Sheets** (Get Rows) — hoja `Banco`, Return All.
8) **Code** — para cada repaso, elige 4 preguntas del tema al azar sin repetir entre repasos. Código abajo.
9) **Gmail** (Send Message) — Subject `Repaso rápido: {{ $json.tema }}`, Email Type HTML, con las preguntas numeradas, un separador y las respuestas debajo.
10) **Google Sheets** (Update Row) — marca `enviado` con la fecha y hora.

## El código del nodo 2
```js
const intervalos = [2, 7, 21];
const base = new Date($json.fecha_completado || Date.now());
const out = [];
intervalos.forEach((d, idx) => {
  const f = new Date(base.getTime() + d * 86400000);
  out.push({ json: { id: `${$json.email}-${$json.tema}-${idx + 1}`, email: $json.email, nombre: $json.nombre, tema: $json.tema, fecha_envio: f.toISOString().slice(0, 10), numero_repaso: idx + 1, enviado: '' } });
});
return out;
```

## El código del nodo 8
```js
const banco = items.map(i => i.json);
const repasos = $('Google Sheets').all().map(i => i.json);
const out = [];
for (const r of repasos) {
  const preguntas = banco.filter(b => String(b.tema).trim() === String(r.tema).trim());
  if (!preguntas.length) continue;
  const semilla = r.numero_repaso;
  const mezcladas = [...preguntas].sort(() => Math.random() - 0.5);
  const trozo = mezcladas.slice((semilla - 1) * 4, (semilla - 1) * 4 + 4);
  const elegidas = trozo.length === 4 ? trozo : mezcladas.slice(0, 4);
  const lista = elegidas.map((p, i) => `<li>${p.pregunta}</li>`).join('');
  const resp = elegidas.map((p, i) => `<li>${p.respuesta}</li>`).join('');
  out.push({ json: { ...r, html: `<p>Hola ${r.nombre}, cinco minutos de repaso de <b>${r.tema}</b>. Responde mentalmente antes de mirar abajo.</p><ol>${lista}</ol><hr><p><small>Respuestas</small></p><ol>${resp}</ol><p>Repaso ${r.numero_repaso} de 3.</p>` } });
}
return out;
```

## Cómo probarla
- Añade una fila en `Progreso` con la fecha de hoy y comprueba que aparecen tres filas en `Repasos` con las fechas correctas (hoy+2, hoy+7, hoy+21).
- Cambia a mano la `fecha_envio` de una a hoy y lanza el flujo B: te debe llegar el email con 4 preguntas de ese tema.
- Prueba un tema sin preguntas en el banco: no debe romperse, solo saltárselo.

## Qué puede salir mal
- **Bombardeo de emails**: si un alumno completa 5 temas el mismo día, recibirá 5 repasos el mismo día. Añade un Code que agrupe por email y mande uno solo con preguntas de varios temas.
- **Banco de preguntas pequeño**: con menos de 12 preguntas por tema se repetirán. El código ya tiene un plan B para ese caso.
- **Bajas**: añade en el email un enlace de «no quiero más repasos» que apunte a un Webhook que ponga `enviado = baja` en todas sus filas pendientes. Es obligatorio en comunicaciones comerciales y de cortesía en las educativas.
- **Fechas**: guarda siempre en formato `AAAA-MM-DD` y compara como texto, así te olvidas de las zonas horarias.

## Cuánto cuesta
- Gratis del todo si no usas IA: Sheets y Gmail bastan.
- Gmail tiene un límite de 500 envíos al día en cuentas gratuitas y 2.000 en Workspace. Si superas eso, usa Brevo (300 emails al día gratis) con un nodo HTTP Request.
- n8n auto-alojado: gratis.
