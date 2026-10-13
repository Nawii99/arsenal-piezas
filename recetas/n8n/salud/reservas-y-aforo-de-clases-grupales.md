# Reservas y aforo de clases grupales…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Gestiona las plazas de las clases de yoga, pilates o rehabilitación en grupo desde un formulario, con confirmación, lista de espera y control de aforo.

## Qué es y qué hace

Recoge las inscripciones a clases de grupo desde un Google Form, cuenta las plazas ocupadas de cada clase, confirma por WhatsApp si hay sitio o la pone en lista de espera, y manda un recordatorio la tarde anterior. Si alguien anula, promociona al primero de la espera. Entrada: formulario de inscripción; salida: confirmaciones y lista actualizada. Se monta en n8n con Google Forms, Sheets y WhatsApp Cloud API.

## Cómo usarla

1. Crear el Form y las hojas Inscripciones y Clases
2. Aprobar las plantillas de WhatsApp
3. Probar con dos inscripciones
4. Que lo revise un profesional

## Cuándo usarla

Cuando des clases en grupo y lleves las plazas por WhatsApp o en una libreta, con clases que se llenan y otras vacías sin saber por qué.

## Cómo ganar dinero con ella

Evita clases sobrevendidas y huecos: llenar dos plazas más por semana a 12 € son 96 € al mes, y te quita una hora diaria de mensajes.

- Gestionar inscripciones de estudios de yoga y pilates, cobrando configuración y soporte mensual.
- Ofrecer el control de aforo a centros de rehabilitación con clases de grupo.
- Vender un panel de ocupación de clases a gimnasios de barrio.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada apuntado a una clase entra por un formulario; el flujo cuenta las plazas ocupadas de esa clase concreta, confirma si hay sitio o mete en lista de espera, y manda un recordatorio la tarde anterior. Si alguien anula, promociona automáticamente al primero de la espera.
Para estudios de yoga y pilates, centros de rehabilitación con clases de grupo, gimnasios pequeños y talleres de mindfulness.

## Lo que necesitas antes
- Google Form con los campos: Nombre, Teléfono, Clase (desplegable con opciones tipo `Pilates - Martes 19:00`), y una casilla de aceptación de condiciones.
- Hoja de respuestas del formulario, que Google crea sola. Renómbrala Inscripciones y añade a mano las columnas: estado, avisado_el.
- Segunda hoja Clases con: clase, dia, hora, aforo, profesor.
- WhatsApp Cloud API con tres plantillas: clase_confirmada, clase_espera y clase_recordatorio.
- n8n.

## Los nodos, en orden
1. **Google Sheets Trigger**: evento Row Added sobre Inscripciones, comprobación cada minuto.
2. **Google Sheets** (Get Rows) sobre Inscripciones, Return All: necesitas todas las filas para contar.
3. **Google Sheets** (Get Rows) sobre Clases.
4. **Code**: cuenta cuántos hay confirmados en esa clase y decide si entra o va a espera. Código abajo.
5. **IF**: `{{ $json.hay_sitio }}` Is True.
6. Rama verdadera: **WhatsApp** con clase_confirmada (variables nombre, clase, dia, hora) y **Google Sheets** Update Row poniendo estado en confirmado.
7. Rama falsa: **WhatsApp** con clase_espera («estás el número {{2}} de la lista de espera, te avisamos si se libera plaza») y Update Row con estado en espera y la posición.
8. Flujo 2, recordatorio: **Schedule Trigger** `0 19 * * *`, **Google Sheets** Get Rows, **Code** que se quede con los confirmados de las clases de mañana, **WhatsApp** con clase_recordatorio incluyendo la frase «responde BAJA si no puedes venir».
9. Flujo 3, bajas y promoción: **Webhook** de WhatsApp, **IF** con el texto igual a BAJA, **Google Sheets** Update Row poniendo estado en anulado, luego **Code** que busque al primero en espera de esa clase, **Google Sheets** Update Row a confirmado y **WhatsApp** con clase_confirmada. Ese aviso hay que mandarlo con la plantilla, no con texto libre.

## El trozo de código del nodo 4
```javascript
const nueva = $('Google Sheets Trigger').first().json;
const todas = $('Get Inscripciones').all().map(i => i.json);
const clases = $('Get Clases').all().map(i => i.json);
const claseInfo = clases.find(c => c.clase === nueva.Clase) || {};
const aforo = parseInt(claseInfo.aforo || 0, 10);
const confirmados = todas.filter(f => f.Clase === nueva.Clase && f.estado === 'confirmado').length;
const enEspera = todas.filter(f => f.Clase === nueva.Clase && f.estado === 'espera').length;
let tel = String(nueva['Teléfono'] || '').replace(/\s|\+/g, '');
if (tel.length === 9) tel = '34' + tel;
return [{ json: {
  nombre: nueva.Nombre,
  telefono: tel,
  clase: nueva.Clase,
  dia: claseInfo.dia || '',
  hora: claseInfo.hora || '',
  hay_sitio: confirmados < aforo,
  posicion: enEspera + 1,
  fila: nueva.row_number
} }];
```
Ajusta los nombres `Get Inscripciones` y `Get Clases` a como hayas renombrado los nodos, y ojo con la tilde en Teléfono: Google Sheets respeta el texto exacto de la cabecera.

## Cómo probarla
1. Pon aforo 2 en una clase de prueba.
2. Apúntate tres veces con tu móvil: los dos primeros deben recibir confirmación y el tercero, espera con posición 1.
3. Contesta BAJA desde uno de los confirmados y comprueba que el de la espera pasa a confirmado y recibe el aviso.
4. Cambia la fecha de la clase a mañana y ejecuta el flujo 2 para ver el recordatorio.

## Qué puede salir mal
- **Dos apuntados a la vez**: si dos personas envían el formulario en el mismo segundo, ambos pueden contar el mismo aforo y sobrevenderse una plaza. Con clases pequeñas es raro; si te pasa, añade en el nodo Code un margen de una plaza o pon el flujo en modo de ejecución secuencial en Settings > Execution Order.
- **Teléfonos mal escritos**: el código añade el 34 si son 9 dígitos, pero si alguien escribe con guiones falla. Marca el campo del formulario como Respuesta corta con validación de expresión regular `^[0-9\s+]{9,15}$`.
- **Google Sheets Trigger sin disparar**: solo funciona con el flujo activado; en modo test hay que pulsar Fetch Test Event.
- **Cabeceras cambiadas**: si renombras una columna del formulario, se rompe el código. No toques las cabeceras una vez montado.

## Cuánto cuesta
- Google Forms y Sheets: gratis.
- n8n auto-alojado: gratis.
- WhatsApp: unos 3 mensajes por alumno y semana. Con 40 alumnos, unos 5-10 € al mes.
- Total: menos de 15 € al mes.
