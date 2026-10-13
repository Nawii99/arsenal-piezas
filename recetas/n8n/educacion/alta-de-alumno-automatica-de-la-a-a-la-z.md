# Alta de alumno automática de la A a la Z…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Cuando alguien rellena el formulario de matrícula, se crea su ficha, su carpeta de material en Drive y recibe el email de bienvenida con accesos, sin que toques nada.

## Qué es y qué hace

Cuando alguien envía el formulario de matrícula, n8n crea la ficha del alumno en una hoja, le abre una carpeta de material en Drive y le envía un correo de bienvenida con sus accesos. Entran datos del formulario y salen fichas, carpetas y correos. Usa cuentas gratuitas de Google y puede alojarse en un VPS barato. Pensado para academias pequeñas y profesores que dan de alta alumnos a mano.

## Cómo usarla

1. Crea el formulario y la hoja de alumnos
2. Conecta Google y n8n con tus credenciales
3. Prueba el alta con un alumno de prueba
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando das de alta alumnos a mano y siempre se te olvida algo: mandar el enlace, crear la carpeta, apuntarlo en la hoja. A partir de 3-4 matrículas al mes ya compensa.

## Cómo ganar dinero con ella

Ahorras entre 10 y 15 minutos por alumno y evitas el alumno que paga y no recibe accesos, que es la primera causa de devolución.

- Implantación del alta automática para academias o profesores particulares, con formulario y carpetas en Drive.
- Mantenimiento mensual de los flujos de matrícula y revisión de cambios en Google, por cuota.
- Plantilla de matrícula y alta para escuelas online que se vende como paquete a otras academias.

**Precio orientativo:** 200–450 € por academia. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada envío del formulario de matrícula crea la ficha del alumno en una hoja de cálculo, le abre una carpeta propia en Drive con el material del curso y le manda el email de bienvenida personalizado.
Está pensado para academias pequeñas, profesores particulares y escuelas online que hoy hacen todo esto a mano, una y otra vez.

## Lo que necesitas antes
- Cuenta de Google normal (gratis): Forms, Sheets, Drive y Gmail.
- n8n: prueba gratis en n8n.cloud, o auto-alojado gratis para siempre en un VPS de unos 5 €/mes con `docker run -p 5678:5678 n8nio/n8n`.
- Credenciales de Google para n8n: entra en console.cloud.google.com, crea un proyecto, ve a «APIs y servicios» y activa Google Sheets API, Google Drive API y Gmail API. Luego «Credenciales» > «Crear credenciales» > «ID de cliente de OAuth» > tipo «Aplicación web», y pega en URIs de redirección la dirección que te enseña n8n al crear la credencial (algo como https://tu-n8n/rest/oauth2-credential/callback).
- Un formulario de Google con estos campos: Nombre y apellidos, Email, Teléfono, Curso (desplegable), Cómo nos conociste.
- Una hoja de cálculo «Alumnos» con la primera fila así: fecha_alta | nombre | email | telefono | curso | estado | carpeta_url
- Una carpeta en Drive llamada «Alumnos» y dentro una carpeta «Plantilla curso» con el material que quieres copiar.

## Los nodos, en orden
1) **Google Sheets Trigger**. Resource: Sheet. Event: Row Added. Documento: la hoja de respuestas que genera tu Google Form. Poll Times: cada minuto. Truco: en Forms, «Respuestas» > icono verde de Sheets, para que las respuestas caigan en una hoja.
2) **Set** (renómbralo «Normalizar»). Crea los campos: `nombre` = `{{ $json['Nombre y apellidos'].trim() }}`, `email` = `{{ $json.Email.trim().toLowerCase() }}`, `telefono` = `{{ $json['Teléfono'] }}`, `curso` = `{{ $json.Curso }}`.
3) **Google Sheets** (operación: Get Row(s)) sobre la hoja «Alumnos», con filtro columna `email` igual a `{{ $json.email }}`. Sirve para detectar si ya existe.
4) **IF**. Condición: Number > «Items count» no sirve aquí, usa String: valor 1 `{{ $items().length }}`… más sencillo: condición Number, valor 1 `{{ $input.all().length }}`, operación «Equal», valor 2 `0`. Rama true (no existe) sigue; rama false va a un nodo **NoOp** llamado «Ya matriculado».
5) **Google Drive** (operación: Folder > Create). Nombre: `{{ $('Normalizar').item.json.nombre }} - {{ $('Normalizar').item.json.curso }}`. Parent Folder: tu carpeta «Alumnos».
6) **Google Drive** (operación: File > Copy) para cada archivo de la plantilla, o más simple: operación Folder > Share con el email del alumno como Permission Type «user», Role «reader», sobre la carpeta del curso ya existente.
7) **Google Sheets** (operación: Append Row) en «Alumnos». Mapea: fecha_alta `{{ $now.format('yyyy-MM-dd') }}`, nombre, email, telefono, curso, estado `activo`, carpeta_url `{{ $('Google Drive').item.json.webViewLink }}`.
8) **Gmail** (operación: Send). Para: `{{ $('Normalizar').item.json.email }}`. Asunto: `Bienvenido a {{ $('Normalizar').item.json.curso }}`. Cuerpo en HTML con el enlace de la carpeta, el horario y tu teléfono de contacto.
9) **Gmail** (segundo nodo, operación: Send). Para: tu propio email. Asunto: `Nueva matrícula: {{ $('Normalizar').item.json.nombre }}`. Así te enteras al momento.

## Cómo probarla
- Rellena tú mismo el formulario con un email tuyo secundario.
- Pulsa «Test workflow» en n8n y mira que los nueve nodos se ponen en verde.
- Comprueba tres cosas: fila nueva en la hoja, carpeta creada en Drive y email recibido (mira también spam).
- Repite el envío con el mismo email: debe irse por la rama «Ya matriculado» y no duplicar nada.

## Qué puede salir mal
- **Duplicados**: si alguien envía el formulario dos veces, el nodo IF del paso 4 lo corta. No lo quites.
- **Gmail te limita**: la cuenta gratuita permite unos 500 envíos al día. Si matriculas más, usa Brevo (300 emails/día gratis) en un nodo HTTP Request.
- **Zona horaria**: en Settings del workflow pon «Europe/Madrid», si no las fechas salen con horas raras.
- **Tildes en los nombres de campo**: si el trigger no encuentra `Teléfono`, abre el nodo, ejecuta una vez y copia el nombre exacto de la columna desde el panel de datos.
- **Reintentos**: en los nodos de Gmail y Drive activa «Retry On Fail» con 3 intentos y 5000 ms de espera.

## Cuánto cuesta
- Google Forms, Sheets, Drive y Gmail: gratis con tu cuenta personal.
- n8n auto-alojado: gratis; el VPS ronda los 5 €/mes. n8n Cloud arranca sobre 20 €/mes.
- El mismo flujo en Make se monta con unas 9 operaciones por matrícula: con el plan gratis de 1000 operaciones al mes te dan para unas 110 matrículas.
