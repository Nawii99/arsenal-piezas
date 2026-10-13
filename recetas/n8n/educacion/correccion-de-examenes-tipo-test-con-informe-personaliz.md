# Corrección de exámenes tipo test con informe personaliz…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Corrige automáticamente los cuestionarios que entregan tus alumnos, calcula la nota, detecta en qué temas fallan y les manda un email con su informe y qué repasar.

## Qué es y qué hace

Cuando un alumno envía un Google Form, n8n compara sus respuestas con un solucionario guardado en una hoja, calcula la nota, agrupa los fallos por tema y envía un correo con el informe y tres temas a repasar. Entran respuestas del formulario y salen notas y feedback personalizado. Sirve para academias de oposiciones, tests de repaso y exámenes de curso, sin software de corrección de pago.

## Cómo usarla

1. Pon el tema entre corchetes en cada pregunta
2. Crea el solucionario en una hoja
3. Conecta el disparador del formulario y el cálculo en n8n
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando corriges a mano tests de repaso, simulacros de oposición o exámenes de curso, y quieres devolver el resultado el mismo día en vez de la semana siguiente.

## Cómo ganar dinero con ella

Corregir 40 tests de 50 preguntas son unas 3 horas. Aquí son 2 minutos, y el alumno recibe feedback útil que reduce las bajas del curso.

- Montaje de corrección automática para academias de oposiciones, con informe por tema y entrega el mismo día.
- Mantenimiento de tests y solucionarios por trimestre para formadores online, por cuota.
- Plantilla de test con informe automático que se vende a profesores de refuerzo y autoescuelas.

**Precio orientativo:** 150–350 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
En cuanto un alumno entrega el cuestionario, el flujo compara sus respuestas con el solucionario, calcula la nota, agrupa los fallos por tema y le manda un email con su informe y las tres cosas que debe repasar.
Para academias de oposiciones, formadores online, profesores de refuerzo y cualquiera que use tests.

## Lo que necesitas antes
- Un Google Form con las preguntas, cada una con el tema entre corchetes al principio del enunciado, por ejemplo: «[Tema 3] ¿Cuál es el plazo de...?».
- La hoja de respuestas del formulario (botón verde en la pestaña Respuestas).
- Una segunda hoja en el mismo documento llamada «Solucionario» con columnas: pregunta | correcta | tema
- Credenciales de Google Sheets y Gmail en n8n.

## Los nodos, en orden
1) **Google Sheets Trigger**. Event: Row Added. Documento: la hoja de respuestas. Sheet: «Respuestas de formulario 1». Poll: cada minuto.
2) **Google Sheets** (Get Row(s)). Documento: el mismo. Sheet: «Solucionario». Devuelve todas las filas.
3) **Code** (Run Once for All Items). Recibe el solucionario; el envío del alumno lo coges con `$('Google Sheets Trigger')`:
```js
const sol = items.map(i => i.json);
const resp = $('Google Sheets Trigger').first().json;
let aciertos = 0, total = 0;
const porTema = {};
const fallos = [];
for (const s of sol) {
  const dada = resp[s.pregunta];
  if (dada === undefined) continue;
  total++;
  const tema = s.tema || 'General';
  porTema[tema] = porTema[tema] || { ok: 0, n: 0 };
  porTema[tema].n++;
  if (String(dada).trim() === String(s.correcta).trim()) { aciertos++; porTema[tema].ok++; }
  else fallos.push({ pregunta: s.pregunta, tuya: dada, correcta: s.correcta, tema });
}
const nota = total ? Math.round((aciertos / total) * 1000) / 100 : 0;
const debiles = Object.entries(porTema)
  .map(([t, v]) => ({ tema: t, pct: Math.round(v.ok / v.n * 100) }))
  .sort((a, b) => a.pct - b.pct).slice(0, 3);
const filas = fallos.map(f => `<tr><td>${f.tema}</td><td>${f.pregunta}</td><td>${f.tuya}</td><td><b>${f.correcta}</b></td></tr>`).join('');
return [{ json: {
  email: resp['Dirección de correo electrónico'] || resp.Email,
  nombre: resp.Nombre || 'alumno',
  nota, aciertos, total,
  apto: nota >= 5,
  debiles: debiles.map(d => `${d.tema} (${d.pct}% acierto)`).join(', '),
  tablaFallos: filas || '<tr><td colspan="4">Ningún fallo. Enhorabuena.</td></tr>'
}}];
```
4) **IF**. Condición Boolean: `{{ $json.apto }}` es true. Sirve para mandar dos emails con tono distinto.
5) **Gmail** (Send) en la rama true. Asunto: `Tu nota: {{ $json.nota }}/10 — APTO`. Cuerpo HTML con nombre, nota, aciertos sobre total, los temas flojos y una tabla `<table>{{ $json.tablaFallos }}</table>`.
6) **Gmail** (Send) en la rama false. Mismo contenido pero con un párrafo de ánimo y el enlace a la sesión de repaso.
7) **Google Sheets** (Append Row) en una hoja «Notas»: fecha, alumno, email, nota, temas flojos. Es tu histórico para ver la evolución.

## Cómo probarla
- Rellena tú el formulario contestando la mitad bien a propósito.
- Ejecuta el workflow y abre el panel de datos del nodo Code: comprueba que `total` coincide con el número de preguntas del solucionario.
- Si `total` sale 0, es que los enunciados de la hoja «Solucionario» no son idénticos a las cabeceras de la hoja de respuestas. Cópialos y pégalos, no los escribas a mano.

## Qué puede salir mal
- **Los enunciados no casan**: es el fallo número uno. Copia las cabeceras exactas, con tildes y signos de interrogación.
- **Respuestas múltiples**: si usas casillas de verificación, Forms devuelve «A, C». Compara con `.split(', ').sort().join(',')` en ambos lados.
- **Mayúsculas y espacios**: el Code ya hace `trim()`; añade `.toLowerCase()` si aceptas texto libre.
- **Reenvíos**: si el alumno entrega dos veces, recibirá dos informes. Añade un IF que compruebe si su email ya está en «Notas» con la fecha de hoy.
- **Límite de Gmail**: 500 correos al día en cuenta gratuita.

## Cuánto cuesta
- Todo gratis con cuenta de Google y n8n auto-alojado.
- En Make gasta unas 6 operaciones por examen: 1000 gratis al mes dan para 160 correcciones.
