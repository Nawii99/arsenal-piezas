# Aviso a familias por faltas de asistencia el mismo día…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Registra la asistencia con un formulario o un QR, detecta quién ha faltado sin justificar y avisa a la familia o al alumno por WhatsApp o email antes de que acabe la tarde.

## Qué es y qué hace

Flujo de n8n que recibe la asistencia de cada grupo desde un formulario o un QR y, a las 18:30, compara la lista de matriculados con quién ha marcado presencia. Envía un WhatsApp o SMS breve a la familia por cada falta sin justificar, vía Twilio, y un parte diario con el resumen de todos los grupos. Entra la hoja Matricula y el formulario; sale el aviso.

## Cómo usarla

1. Crea el formulario de asistencia o los códigos QR
2. Rellena la hoja Matricula con teléfonos y días de clase
3. Conecta Twilio con su SID y token
4. Que lo revise un profesional (datos de menores y comunicaciones a familias)

## Cuándo usarla

Úsalo cuando las faltas se acumulan durante semanas y para cuando las detectas ya es tarde para reaccionar.

## Cómo ganar dinero con ella

Evita las bajas silenciosas y las reclamaciones de familias. Un alumno recuperado en una academia de 90 €/mes son más de 800 € al año.

- Control de asistencia y avisos a familias para academias con alumnos menores de edad.
- Seguimiento de faltas para escuelas de refuerzo que quieren reducir bajas silenciosas.
- Parte diario de asistencia para centros de formación con varios grupos y profesores.

**Precio orientativo:** 200–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada profesor pasa lista en un formulario que tarda 20 segundos (o los alumnos escanean un QR al entrar). A las 18:30 el flujo compara la lista de matriculados de cada grupo con quién ha marcado presencia, y avisa de las ausencias sin justificar.
Manda un WhatsApp o SMS breve a la familia, y a dirección un parte con el resumen de todos los grupos.

## Lo que necesitas antes
- Hoja `Matricula` con: `alumno`, `grupo`, `dias_clase` (por ejemplo `L,X,V`), `contacto_nombre`, `telefono` (formato `+34600111222`), `email`.
- Hoja `Asistencia` alimentada por un Google Form con campos: Grupo, Fecha, Alumnos presentes (casillas de verificación), Profesor.
- Hoja `Justificadas` donde se apuntan avisos previos: `alumno`, `fecha`, `motivo`.
- Cuenta de Twilio (twilio.com) con número español o el sandbox de WhatsApp. El SID y el Auth Token están en la consola de Twilio, y se meten en n8n en Credentials > Twilio.

## Los nodos, en orden
1) **Schedule Trigger** — Cron Expression `30 18 * * 1-5`, Timezone `Europe/Madrid` en Settings.
2) **Google Sheets** (Get Rows) — hoja `Matricula`, Return All.
3) **Google Sheets** (Get Rows) — hoja `Asistencia`, con Filters: `Fecha` igual a `{{ $now.format('yyyy-MM-dd') }}`.
4) **Google Sheets** (Get Rows) — hoja `Justificadas`, filtrando también por la fecha de hoy.
5) **Merge** (Mode: Combine, Combine By: Position) o directamente un **Code** que lea las tres con `$('nombre del nodo').all()`. Código abajo.
6) **IF** — `{{ $json.tiene_telefono }}` is true. Rama true al nodo Twilio, rama false al Gmail de aviso a la familia.
7) **Twilio** (Resource: SMS o WhatsApp, Operation: Send) — To `{{ $json.telefono }}`, From tu número Twilio, Message: `Hola {{ $json.contacto_nombre }}, te escribimos de {{ 'Academia Ejemplo' }}. Hoy {{ $json.alumno }} no ha asistido a la clase de {{ $json.grupo }}. Si es un despiste, contesta a este mensaje. Gracias.`
8) **Gmail** (Send Message) — igual pero por correo para quien no tenga móvil.
9) **Code** — arma la tabla del parte diario por grupos.
10) **Gmail** (Send Message) — a dirección, Subject `Parte de asistencia {{ $now.format('dd/MM') }}`, HTML con la tabla y el porcentaje de asistencia por grupo.
11) **Google Sheets** (Append Row) — hoja `Historico_faltas` para poder sacar informes trimestrales.

## El código del nodo 5
```js
const dias = ['D','L','M','X','J','V','S'];
const hoyLetra = dias[new Date().getDay()];
const matricula = $('Google Sheets').all().map(i => i.json);
const asistencia = $('Google Sheets1').all().map(i => i.json);
const justif = $('Google Sheets2').all().map(i => i.json.alumno);
const presentes = new Set();
for (const a of asistencia) { String(a['Alumnos presentes'] || '').split(',').forEach(n => presentes.add(n.trim())); }
const out = [];
for (const m of matricula) {
  if (!String(m.dias_clase || '').split(',').map(s => s.trim()).includes(hoyLetra)) continue;
  if (presentes.has(m.alumno)) continue;
  if (justif.includes(m.alumno)) continue;
  out.push({ json: { ...m, tiene_telefono: !!(m.telefono && m.telefono.startsWith('+')), fecha: new Date().toISOString().slice(0,10) } });
}
return out;
```

## Cómo probarla
- Rellena el formulario de un grupo dejando fuera a un alumno de mentira con tu propio móvil como contacto. Ejecuta a mano y comprueba que te llega el SMS.
- Prueba el caso de que ningún profesor haya pasado lista: el flujo marcaría a todo el grupo como ausente. Añade un **IF** que corte si `asistencia.length === 0` para ese grupo.
- Comprueba un festivo: mete un **IF** que consulte una hoja `Festivos` antes de nada.

## Qué puede salir mal
- **El profesor se olvida de pasar lista**: el corte por grupo sin registro evita el desastre, pero manda además un recordatorio al profesor a las 18:00.
- **Teléfonos mal formateados**: Twilio exige formato internacional. Normaliza en el Code con `m.telefono.replace(/\s/g,'').replace(/^0034|^34(?=\d{9}$)/,'+34')`.
- **Coste de WhatsApp**: cada conversación iniciada por la empresa se cobra y exige plantilla aprobada por Meta. Para empezar, SMS o email salen más baratos y sin trámites.
- **RGPD**: los datos de menores exigen consentimiento del tutor y una base legal clara. Ten la cláusula firmada en la matrícula.

## Cuánto cuesta
- n8n auto-alojado: gratis. Sheets y Forms: gratis.
- SMS con Twilio en España: unos 0,07 € por mensaje. Con 5 faltas al día son unos 7 € al mes.
- WhatsApp Business API: alrededor de 0,04 € por conversación de utilidad, más el alta con un proveedor.
- Alternativa a coste cero: solo email a familias.
