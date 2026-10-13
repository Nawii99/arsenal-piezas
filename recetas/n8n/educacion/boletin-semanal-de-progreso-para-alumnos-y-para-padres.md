# Boletín semanal de progreso para alumnos y para padres…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Cada viernes manda a cada alumno (o a su familia) un correo personalizado con lo que ha avanzado esa semana, su nota media, lo que le queda y el objetivo de la siguiente.

## Qué es y qué hace

Flujo de n8n que cada viernes lee la asistencia, las entregas y las notas de la semana de cada alumno desde una hoja de registro. Calcula su progreso, pide a un modelo de IA un comentario sobre su evolución y envía a cada familia o alumno un boletín personalizado. Entra el registro y las direcciones; sale el boletín semanal.

## Cómo usarla

1. Crea la hoja Registro con asistencia, entregas y notas
2. Redacta la plantilla del boletín
3. Elige el modelo entre Claude, Codex, Gemini o una IA local
4. Que lo revise un profesional (datos de menores y familias)

## Cuándo usarla

Cuando quieres que los alumnos o sus padres vean el progreso sin que tengas que escribir un email distinto a cada uno.

## Cómo ganar dinero con ella

Un informe que tardarías 5 minutos en escribir por alumno sale solo. Con 50 alumnos son 4 horas semanales y muchas menos preguntas de «¿cómo va?».

- Boletines de progreso para academias de refuerzo que quieren mantener informadas a las familias.
- Informes semanales para escuelas de idiomas con seguimiento de alumnos y grupos.
- Comunicación con familias para centros de formación con alumnos adultos o de apoyo escolar.

**Precio orientativo:** 250–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Toma los datos de asistencia, entregas y notas de la semana, calcula el progreso de cada alumno y le envía un boletín personalizado con un comentario escrito por IA sobre su evolución.
Es para academias, clases de refuerzo, escuelas de idiomas y cursos con seguimiento de familias.

## Lo que necesitas antes
n8n.
Hoja «Registro» con una fila por evento y columnas: fecha, email_alumno, nombre_alumno, email_familia, tipo (asistencia, entrega, examen), modulo, valor (1/0 para asistencia, nota de 0 a 10 para entregas y exámenes).
Hoja «Alumnos» con: email_alumno, nombre_alumno, email_familia, curso, objetivo_semana, activo.
Credencial Google OAuth2 (Sheets y Gmail).
API key de OpenAI (opcional, solo para el comentario personalizado).

## Los nodos, en orden
**1. Schedule Trigger**. Cron: `0 17 * * 5` (viernes a las 17:00).
**2. Google Sheets** «Leer alumnos». Get Row(s) de «Alumnos», filtro `activo` igual a `si`.
**3. Google Sheets** «Leer registro». Get Row(s) de «Registro» (todo; filtramos por código).
**4. Code** «Calcular semana». Para cada alumno, cuenta asistencias, entregas y saca la media de notas de los últimos 7 días, y compara con la semana anterior (código abajo).
**5. Filter**. Condición: `{{ $json.eventos }}` mayor que 0. Si un alumno no ha hecho nada, no le mandes un boletín vacío: mejor mételo en el flujo de rescate.
**6. OpenAI** «Message a Model» (opcional). Model: `gpt-4o-mini`. Sistema: «Eres el tutor. Escribe 2 frases de comentario personal para el alumno a partir de sus datos. Si mejora respecto a la semana pasada, reconócelo. Si baja, señálalo sin dramatizar y propón una acción concreta. Español de España, tuteando, máximo 45 palabras.» Usuario: los datos calculados.
**7. Code** «Montar HTML». Construye el cuerpo del email con una tabla sencilla: asistencia, entregas, media, tendencia y objetivo de la semana que viene.
**8. Gmail** «Boletín alumno». To: `{{ $json.email_alumno }}`. Subject: `Tu semana en {{ $json.curso }}: media {{ $json.media }}`.
**9. IF** «¿Tiene familia asociada?». Si `email_familia` no está vacío, un segundo **Gmail** con el mismo contenido y un párrafo inicial dirigido a la familia.
**10. Google Sheets** «Histórico boletines». Append Row en una hoja «Boletines» con fecha, alumno, media y tendencia, para tener la serie histórica.
**11. Gmail** «Panel para ti». Un único correo con la lista de alumnos ordenada por media ascendente: los tres primeros son los que necesitan atención el lunes.

## El trozo de código
Nodo **Code** número 4, modo «Run Once for All Items»:
```javascript
const registro = $('Leer registro').all().map(i => i.json);
const alumnos = $('Leer alumnos').all().map(i => i.json);
const hoy = new Date();
const hace7 = new Date(hoy.getTime() - 7 * 86400000);
const hace14 = new Date(hoy.getTime() - 14 * 86400000);
const media = arr => arr.length ? Math.round((arr.reduce((a, b) => a + b, 0) / arr.length) * 10) / 10 : null;
return alumnos.map(al => {
  const suyos = registro.filter(r => r.email_alumno === al.email_alumno);
  const sem = suyos.filter(r => new Date(r.fecha) >= hace7);
  const prev = suyos.filter(r => new Date(r.fecha) >= hace14 && new Date(r.fecha) < hace7);
  const notasSem = sem.filter(r => r.tipo !== 'asistencia').map(r => Number(r.valor));
  const notasPrev = prev.filter(r => r.tipo !== 'asistencia').map(r => Number(r.valor));
  const m = media(notasSem), mp = media(notasPrev);
  let tendencia = 'estable';
  if (m !== null && mp !== null) tendencia = m > mp + 0.3 ? 'subiendo' : (m < mp - 0.3 ? 'bajando' : 'estable');
  return { json: { ...al, asistencias: sem.filter(r => r.tipo === 'asistencia' && Number(r.valor) === 1).length, entregas: sem.filter(r => r.tipo === 'entrega').length, media: m === null ? 'sin notas' : m, tendencia, eventos: sem.length } };
});
```

## Cómo probarla
Mete 15 filas de prueba en «Registro» con fechas de esta semana y de la anterior para dos alumnos ficticios con tu email. Ejecuta a mano y revisa los dos boletines.
Comprueba el caso del alumno sin notas: no debe salir «NaN» ni «null» en el email.

## Qué puede salir mal
Fechas mal formateadas rompen la comparación. Fuerza la columna fecha a formato ISO (yyyy-mm-dd) en la hoja.
Si mandas boletín a menores, el email va siempre a la familia: revisa el consentimiento del centro y el RGPD.
Comentarios de la IA demasiado blandos o repetidos: dale ejemplos concretos en el prompt de qué es un buen comentario.
Con más de 100 alumnos, Gmail puede cortarte. Usa **Loop Over Items** de 25 en 25 con un **Wait** de 30 segundos.
No mandes el boletín si tú no has metido los datos de la semana: añade un **IF** inicial que compruebe que hay al menos 10 registros nuevos, y si no, te avisa a ti en vez de mandar nada.

## Cuánto cuesta
n8n, Sheets y Gmail: 0 €.
OpenAI: unos 0,001 € por comentario. 50 alumnos por 4 semanas son menos de 0,25 € al mes.
Puedes quitar el nodo de IA y usar frases fijas según la tendencia: entonces el coste es 0 €.
