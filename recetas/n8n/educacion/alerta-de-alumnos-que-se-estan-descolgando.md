# Alerta de alumnos que se están descolgando…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Detecta cada semana quién lleva días sin entrar ni entregar nada, te avisa a ti con la lista y le manda al alumno un mensaje para reengancharle antes de que abandone.

## Qué es y qué hace

Cada lunes revisa la hoja de actividad de los alumnos, calcula los días sin entrar ni entregar y les escribe un correo de reenganche. Además envía a la persona responsable un resumen con la lista por Slack o Telegram. Entran fechas de última actividad y salen correos y alertas. Para escuelas online, bootcamps y cursos con tutor, con n8n y Gmail o Google Sheets.

## Cómo usarla

1. Exporta la actividad a una hoja cada semana
2. Fija en n8n el umbral de días parados
3. Escribe el correo de reenganche con tu tono
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando vendas cursos online o programas largos y veas que la gente empieza con ganas y a las tres semanas desaparece sin decir nada.

## Cómo ganar dinero con ella

Recuperar 2 de cada 10 alumnos que iban a abandonar en un curso de 300 € son 600 € al mes que ya tenías cobrados y no acabas devolviendo.

- Implantación de alertas de abandono para escuelas online, con correo automático y resumen para el tutor.
- Revisión semanal de actividad y seguimiento de alumnos en riesgo para academias, por cuota mensual.
- Plantilla de reenganche para cursos grabados que se vende a creadores de formación.

**Precio orientativo:** 150–400 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Todos los lunes revisa la actividad de cada alumno (última conexión o última entrega), marca a los que llevan más de X días parados y actúa: email cercano al alumno y aviso resumen para ti.
Para escuelas online, mentorías, bootcamps y cursos con tutor.

## Lo que necesitas antes
- Una hoja «Actividad» con columnas: alumno | email | curso | ultima_actividad (formato AAAA-MM-DD) | leccion_actual | avisado_el
- De dónde sale esa hoja: si usas Moodle, exporta el informe de accesos; si usas Teachable o Thinkific, su exportación de progreso; si usas Google Classroom, la fecha de la última entrega. Si no tienes nada, actualízala tú una vez por semana: sigue mereciendo la pena.
- Credenciales de Google Sheets y Gmail. Opcional: Slack (crea una app en api.slack.com > Incoming Webhooks) o Telegram.

## Los nodos, en orden
1) **Schedule Trigger**. Cron: `0 9 * * 1` (lunes a las 9:00). Timezone Europe/Madrid en los ajustes del workflow.
2) **Google Sheets** (Get Row(s)) sobre «Actividad».
3) **Code** (Run Once for All Items). Clasifica por nivel de riesgo:
```js
const hoy = new Date();
const dias = (f) => Math.floor((hoy - new Date(f)) / 86400000);
const out = [];
for (const i of items) {
  const a = i.json;
  if (!a.email || !a.ultima_actividad) continue;
  const d = dias(a.ultima_actividad);
  let nivel = null;
  if (d >= 21) nivel = 'critico';
  else if (d >= 10) nivel = 'alto';
  else if (d >= 5) nivel = 'medio';
  if (!nivel) continue;
  const yaAvisado = a.avisado_el && dias(a.avisado_el) < 7;
  if (yaAvisado) continue;
  out.push({ json: { ...a, dias: d, nivel, nombre: String(a.alumno).split(' ')[0], fila: i.json.row_number } });
}
return out;
```
4) **Switch**. Modo: Rules sobre `{{ $json.nivel }}`. Salida 0 = medio, salida 1 = alto, salida 2 = critico.
5) **Gmail** (Send) para «medio». Asunto: `{{ $json.nombre }}, te dejo por dónde ibas`. Texto corto recordando la lección `{{ $json.leccion_actual }}` y un enlace directo para seguir.
6) **Gmail** (Send) para «alto». Asunto: `¿Te ayudo a retomar {{ $json.curso }}?`. Ofrece una llamada de 15 minutos con enlace a tu Calendly.
7) **Gmail** (Send) para «critico». Asunto: `Última llamada antes de cerrar tu plaza`. Pregunta abierta: «¿Qué te ha frenado?». Aquí la respuesta te da información de oro.
8) **Google Sheets** (Update Row) en las tres ramas. Actualiza la columna `avisado_el` con `{{ $now.format('yyyy-MM-dd') }}` usando `row_number` como clave.
9) **Code** (Run Once for All Items) que junta la lista, y **Slack** (Send Message) o **Gmail** a ti mismo con el resumen: «5 en riesgo medio, 3 alto, 1 crítico» y los nombres.

## Cómo probarla
- Mete tres filas de prueba con fechas de hace 6, 12 y 30 días y tu email.
- Ejecuta a mano y comprueba que cada una sale por la salida correcta del Switch.
- Cambia `avisado_el` a la fecha de hoy en una fila y vuelve a ejecutar: esa fila debe desaparecer del resultado.

## Qué puede salir mal
- **Fechas en formato español**: si la hoja guarda 03/09/2026, `new Date()` lo interpreta mal. Formatea la columna como texto AAAA-MM-DD o convierte con `.split('/').reverse().join('-')`.
- **Agobiar al alumno**: el filtro de `avisado_el` evita mandarle un correo cada lunes. No lo quites.
- **Vacaciones**: añade un IF que no ejecute en agosto o durante las fechas que marques en una hoja «Pausas».
- **Falsos positivos**: alguien puede estar al día pero consumir el curso descargado. Por eso los mensajes preguntan, no acusan.

## Cuánto cuesta
- Gratis entero con Google y n8n auto-alojado.
- Si mandas los avisos por WhatsApp en vez de email, cuenta unos 0,04 € por mensaje.
