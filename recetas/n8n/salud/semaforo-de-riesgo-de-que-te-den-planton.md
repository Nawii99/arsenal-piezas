# Semáforo de riesgo de que te den plantón…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Puntúa a cada paciente según su historial de plantones, cancelaciones tardías y antigüedad de la reserva, y refuerza el recordatorio solo con los de riesgo alto, pidiéndoles confirmación.

## Qué es y qué hace

Cada noche revisa las citas de las próximas 48 horas y calcula una puntuación de riesgo de plantón por paciente a partir de su historial. El riesgo bajo recibe el recordatorio normal, el medio pide confirmación y el alto genera una tarea para llamar desde recepción. Entrada: citas y hoja Historial; salida: recordatorios y tareas. Se monta en n8n con Google Calendar, Sheets, Twilio y Gmail.

## Cómo usarla

1. Crear las hojas Historial y Tareas
2. Conectar Calendar, Sheets y Twilio
3. Probar con tres pacientes de riesgo distinto
4. Que lo revise un profesional

## Cuándo usarla

Cuando ya mandas recordatorios a todo el mundo y aun así te fallan citas, y quieres apretar solo donde hace falta sin agobiar al paciente fiel.

## Cómo ganar dinero con ella

Bajar del 12% al 6% de plantones en 300 citas mensuales de 45 € son unos 800 € al mes que dejas de perder.

- Reducir plantones en clínicas con volumen medio, cobrando configuración y revisión mensual.
- Ofrecer el cálculo de riesgo a centros de estética con muchas citas.
- Montar un panel de tareas de llamada para recepción.

**Precio orientativo:** 250–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada noche mira las citas de dentro de 48 horas, calcula una puntuación de riesgo por paciente a partir de su historial y aplica tres tratos distintos: riesgo bajo recibe un recordatorio normal, riesgo medio un recordatorio con confirmación por respuesta, riesgo alto una llamada o un aviso al mostrador para telefonear.
Para clínicas con volumen medio-alto donde el plantón es el mayor agujero de ingresos.

## Lo que necesitas antes
Google Sheet `Historial` con columnas `telefono`, `citas_totales`, `plantones`, `cancelaciones_tardias`.
Google Calendar `Citas` con el teléfono del paciente en la descripción del evento, en una línea con el formato `tel: 6XXXXXXXX`.
Credenciales `Google Calendar OAuth2`, `Google Sheets OAuth2`, `Twilio` y `Gmail OAuth2` en n8n.
Un Sheet `Tareas` para volcar las llamadas que debe hacer recepción.

## Los nodos, en orden
1. **Schedule Trigger** — `0 19 * * *` (todos los días a las 19:00), timezone `Europe/Madrid`.
2. **Google Calendar** — `Get Many`, Start `{{$now.plus(2,'days').startOf('day').toISO()}}`, End `{{$now.plus(2,'days').endOf('day').toISO()}}`, `Return All`.
3. **Google Sheets** — hoja `Historial`, `Get Row(s)`, `Return All`.
4. **Merge** — Mode `Combine`, Combine By `Matching Fields`, campo izquierdo `telefono`, campo derecho `telefono`, Output `Enrich Input 1` para que las citas sin historial también pasen.
5. **Code** — extrae el teléfono de la descripción y calcula la puntuación (código abajo).
6. **Switch** — Mode `Rules`, sobre `{{$json.riesgo}}`: salida 0 si es `bajo`, salida 1 si es `medio`, salida 2 si es `alto`.
7. Salida 0 → **Twilio** WhatsApp con texto informativo: `Te esperamos el {{$json.fecha}} a las {{$json.hora}}.`
8. Salida 1 → **Twilio** WhatsApp con texto de confirmación: `Confirma respondiendo OK, o escribe CAMBIO si necesitas otra hora.`
9. Salida 2 → **Google Sheets** `Append Row` en `Tareas` con nombre, teléfono, hora de la cita y motivo, y además un **Gmail** a recepción con el listado del día para que llamen por la mañana.

## El nodo Code
```js
const out = [];
for (const it of $input.all()) {
  const e = it.json;
  const desc = e.description || '';
  const m = desc.match(/tel:\s*([0-9+ ]{9,15})/i);
  const telefono = m ? m[1].replace(/\s/g, '') : null;
  if (!telefono) continue;
  const totales = Number(e.citas_totales || 0);
  const plantones = Number(e.plantones || 0);
  const tardias = Number(e.cancelaciones_tardias || 0);
  const tasa = totales > 0 ? plantones / totales : 0;
  let puntos = 0;
  if (totales === 0) puntos += 2;
  puntos += Math.round(tasa * 10);
  puntos += tardias >= 2 ? 2 : 0;
  const creado = e.created ? new Date(e.created) : null;
  const inicio = new Date(e.start.dateTime || e.start);
  if (creado && (inicio - creado) / 86400000 > 30) puntos += 1;
  const hora = inicio.toISOString().slice(11, 16);
  if (hora < '10:00' || hora >= '19:00') puntos += 1;
  const riesgo = puntos >= 5 ? 'alto' : puntos >= 3 ? 'medio' : 'bajo';
  out.push({ json: { telefono, nombre: e.summary, fecha: inicio.toISOString().slice(0, 10), hora, puntos, riesgo } });
}
return out;
```

## Cómo probarla
Mete tres citas de prueba a 48 horas con tres teléfonos que en `Historial` tengan 0, 1 y 4 plantones, y comprueba que cada una sale por una rama distinta del Switch.
Ejecuta primero con los nodos de envío desactivados y revisa la columna `puntos` a mano: si casi todos salen `alto`, sube los cortes a 4 y 6.

## Qué puede salir mal
Teléfonos mal escritos en la descripción: normaliza siempre a 9 dígitos sin prefijo o con `+34` fijo, y usa el mismo formato en el Sheet.
Si no tienes histórico todavía, todo el mundo será riesgo medio-alto; deja el sistema un par de meses alimentando la hoja de plantones antes de apretar.
El campo `created` de Google Calendar solo llega si en el nodo activas `Return All Fields`.
No pongas nunca el motivo de consulta en el WhatsApp: es dato de salud.

## Cuánto cuesta
n8n auto-alojado 0 €.
Twilio: solo pagas los mensajes que envías; al filtrar por riesgo mandas la mitad que antes.
Sheets, Calendar y Gmail: gratis.
