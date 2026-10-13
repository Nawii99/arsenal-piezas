# Entregas de trabajos: acuse, recordatorio y aviso de re…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Confirma al alumno que su trabajo ha llegado, le recuerda la entrega 48 horas antes y te avisa de quién no ha entregado cuando cierra el plazo.

## Qué es y qué hace

Recibe la entrega de cada alumno desde un Google Form con subida de archivo, la mueve a su carpeta, envía un acuse con código de entrega y la anota en una hoja. Dos días antes del cierre recuerda a quien falta y al cerrar genera la lista de pendientes. Entran formularios y listas de matriculados, y salen acuses, recordatorios y registros. Para formadores con trabajos evaluables, con n8n, Drive y Gmail.

## Cómo usarla

1. Crea el formulario con subida de archivos
2. Prepara las hojas de tareas y matriculados
3. Conecta Drive y Gmail en n8n
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando pidas trabajos, prácticas o proyectos con fecha límite y se te vaya el tiempo en perseguir entregas y responder «¿te ha llegado lo mío?».

## Cómo ganar dinero con ella

Quita la mitad de los emails de gestión de un curso y sube la tasa de entrega, que es lo que de verdad determina cuánta gente acaba el programa.

- Montaje de entrega de trabajos con acuse y recordatorios para bootcamps y másteres, cobrado por curso.
- Gestión de entregas por convocatoria para formadores con proyectos finales, por cuota.
- Plantilla de entregas y recordatorios vendida a academias que pierden tiempo persiguiendo trabajos.

**Precio orientativo:** 150–350 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Monta la entrega de trabajos sobre un formulario con subida de archivo: al recibir uno, lo mueve a la carpeta del alumno, le manda acuse de recibo con su código de entrega y lo apunta. Dos días antes del cierre recuerda a quien no ha entregado, y al cerrar te da la lista de pendientes.
Para formadores con trabajos evaluables, bootcamps, másteres y cursos con proyecto final.

## Lo que necesitas antes
- Un Google Form con: Email, Nombre, Tarea (desplegable) y una pregunta de tipo «Subida de archivos». Ojo: para subir archivos, el formulario obliga a iniciar sesión con Google.
- Una hoja «Entregas» (la de respuestas del formulario) y otra hoja «Tareas» con: tarea | fecha_limite | curso
- Una hoja «Matriculados» con: alumno | email | curso
- Una carpeta en Drive «Entregas» con subcarpetas por tarea.
- Credenciales de Google Sheets, Drive y Gmail.

## Los nodos, en orden
1) **Google Sheets Trigger**. Event: Row Added, sobre la hoja de respuestas del formulario. Poll cada minuto.
2) **Code** (Run Once for Each Item) que genera el código de entrega y saca el ID del archivo subido:
```js
const j = $input.item.json;
const url = j['Sube tu trabajo'] || '';
const id = (url.match(/[-\w]{25,}/) || [''])[0];
const cod = 'E' + Date.now().toString(36).toUpperCase().slice(-6);
return { json: { email: (j['Dirección de correo electrónico']||'').toLowerCase(), nombre: j.Nombre||'', tarea: j.Tarea||'', fileId: id, codigo: cod, fecha: new Date().toISOString().slice(0,16).replace('T',' ') } };
```
3) **Google Drive** (File > Update / Move). File ID: `{{ $json.fileId }}`. Cambia el nombre a `{{ $json.tarea }} - {{ $json.nombre }} - {{ $json.codigo }}` y mueve a la carpeta de esa tarea.
4) **Google Sheets** (Get Row(s)) sobre «Tareas» con filtro `tarea` igual a `{{ $json.tarea }}` para leer la fecha límite.
5) **Code** que compara: `const tarde = new Date() > new Date($json.fecha_limite + 'T23:59:59');`. Guarda `tarde` como booleano.
6) **IF** sobre `tarde`. Rama false: **Gmail** con asunto `Recibido: {{ tarea }} — código {{ codigo }}`, diciendo cuándo tendrá corrección. Rama true: mismo email pero indicando que llega fuera de plazo y qué implica según tus normas.
7) **Google Sheets** (Append Row) en un registro «Control entregas»: fecha, alumno, email, tarea, codigo, tarde, url del archivo.
8) Segundo flujo: **Schedule Trigger** `0 9 * * *`.
9) **Google Sheets** (Get Row(s)) sobre «Tareas» y **Code** que se queda con las tareas cuya `fecha_limite` es dentro de 2 días o es hoy.
10) **Google Sheets** (Get Row(s)) sobre «Matriculados» y otro sobre «Control entregas», y un **Code** que cruza las dos listas:
```js
const matric = $('Matriculados').all().map(i => i.json);
const entregas = $('Control entregas').all().map(i => i.json);
const tarea = $('Code').first().json.tarea;
const curso = $('Code').first().json.curso;
const yaEntregaron = new Set(entregas.filter(e => e.tarea === tarea).map(e => (e.email||'').toLowerCase()));
return matric.filter(m => m.curso === curso && !yaEntregaron.has((m.email||'').toLowerCase()))
  .map(m => ({ json: { ...m, tarea, nombre: String(m.alumno).split(' ')[0] } }));
```
11) **Split In Batches** (tamaño 1) + **Gmail** recordatorio: `Te quedan 2 días para entregar {{ tarea }}`.
12) El día del cierre, mismo cruce pero el email va a ti con la lista completa de pendientes, y un **Google Sheets** (Append Row) en «Pendientes» para el histórico.

## Cómo probarla
- Haz una entrega tú mismo desde el formulario.
- Comprueba que el archivo aparece renombrado en la carpeta correcta y que recibes el acuse con el código.
- Cambia la `fecha_limite` de una tarea a ayer y vuelve a entregar: el email debe decir que llega tarde.
- Pon una fecha límite dentro de 2 días y ejecuta el segundo flujo: solo deben recibir aviso los que no han entregado.

## Qué puede salir mal
- **La subida de archivos exige cuenta Google**: si tus alumnos no la tienen, cambia el formulario por un Tally o un formulario propio y recibe el archivo por Webhook.
- **El regex del fileId falla**: Forms guarda la URL completa; si cambia el formato, imprime `url` en el panel de datos y ajusta.
- **Emails duplicados en Matriculados**: normaliza siempre a minúsculas, como hace el Code.
- **Entregas repetidas**: si un alumno sube dos versiones, quédate con la última ordenando por fecha en el cruce.
- **Cuota de Drive**: 15 GB gratis se llenan rápido con vídeos. Pide entregas en PDF o enlaces.

## Cuánto cuesta
- Gratis del todo con cuenta de Google y n8n auto-alojado.
- 2 €/mes por 100 GB de Drive si los trabajos pesan.
- En Make son unas 8 operaciones por entrega más el chequeo diario.
