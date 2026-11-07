# Alta automática de alumnos y acceso al curso…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Cuando alguien se apunta a tu curso por un formulario o por Stripe, se le da de alta en tu hoja de alumnos, se le envía el email de bienvenida con sus accesos y se le añade al calendario.

## Qué es y qué hace

Flujo de n8n que cuando alguien compra o se inscribe en tu curso, lo da de alta en una hoja de alumnos de Google Sheets, le envía un email de bienvenida con sus accesos y lo añade al calendario de clases en directo. Entra el formulario o el evento de Stripe y tus credenciales de Google; sale el alta completa. Ahorra el alta manual de cada alumno. Solo da el alta si el webhook de Stripe está verificado y el pago consta como pagado.

## Cómo usarla

1. Conecta el formulario o Stripe con n8n
2. Prepara la hoja de alumnos y el email de bienvenida
3. Configura Google OAuth con Sheets, Gmail y Calendar
4. Que lo revise un profesional (datos personales y RGPD)

## Cuándo usarla

Úsalo cuando vendas cursos o formaciones y estés dando de alta a cada alumno a mano: copiar el email, mandarle el enlace, apuntarlo en una hoja.

## Cómo ganar dinero con ella

Ahorra entre 8 y 12 minutos por alumno y elimina el clásico «no me ha llegado el acceso». Con 40 alumnos al mes son unas 6 horas.

- Alta automática de alumnos para academias pequeñas que venden cursos online o presenciales.
- Automatización de accesos para formadores que venden cursos en plataformas propias.
- Puesta en marcha de un flujo de matrícula y bienvenida para escuelas de idiomas o de oficios.

**Precio orientativo:** 250–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recoge cada compra o inscripción a tu curso y monta el alta completa del alumno sin que toques nada: ficha en la hoja, email de bienvenida con sus accesos y evento en el calendario de clases en directo.
Es para formadores, academias pequeñas e infoproductores que hoy hacen ese alta copiando y pegando.

## Lo que necesitas antes
Cuenta de n8n: n8n Cloud ofrece una prueba gratuita temporal y después planes de pago; la opción gratis es n8n auto-alojado (Community Edition) con Docker, en tu ordenador o servidor.
Cuenta de Google con Sheets, Gmail y Calendar. En n8n se conectan con «Google OAuth2 API»: creas un proyecto en console.cloud.google.com, activas las APIs de Sheets, Gmail y Calendar, generas credenciales OAuth de tipo «Aplicación web» y pegas el Client ID y el Client Secret en n8n con la URL de redirección que te da n8n.
Si cobras con Stripe: dashboard.stripe.com > Desarrolladores > Claves de API, crea una clave restringida o copia la clave secreta y guárdala solo en una credencial «Stripe API» de n8n. No la escribas en un nodo Code, Set ni HTTP Request: un flujo exportado se llevaría la clave.
Una hoja de Google llamada «Alumnos» con estas columnas en la fila 1: fecha_alta, nombre, email, curso, importe, id_pago, estado.
Un calendario de Google llamado «Clases en directo» con las sesiones ya creadas (opcional, si das clases en vivo).

## Los nodos, en orden
**1. Stripe Trigger** (o **Webhook** si usas un formulario). Evento: `checkout.session.completed`. El Stripe Trigger comprueba la firma del webhook (si usas un Webhook genérico para Stripe, verifica tú la cabecera `Stripe-Signature` con el «signing secret» del endpoint, guardado en una variable de entorno como `$env.STRIPE_WEBHOOK_SECRET`, nunca escrito en un nodo; un secreto «en la ruta» del webhook no autentica nada). Antes de dar el alta, comprueba que `payment_status` sea `paid`. Si prefieres formulario, usa el nodo **n8n Form Trigger** con los campos Nombre, Email, Curso y acepta condiciones.
**2. Set** (renómbralo «Datos alumno»). Crea los campos: `nombre` = `{{ $json.data.object.customer_details.name }}`, `email` = `{{ $json.data.object.customer_details.email }}`, `importe` = `{{ $json.data.object.amount_total / 100 }}`, `id_pago` = `{{ $json.data.object.id }}`, `curso` = el nombre fijo de tu curso.
**3. Google Sheets**. Operación: «Get Row(s)», hoja «Alumnos», filtro por columna `email` igual a `{{ $json.email }}`. Sirve para detectar duplicados.
**4. IF**. Condición: Number > «Items» del nodo anterior es igual a 0. Rama TRUE = alumno nuevo. Rama FALSE = ya existía, va directo a un nodo **NoOp** llamado «Ya inscrito».
**5. Google Sheets** (rama TRUE). Operación: «Append Row». Hoja «Alumnos». Mapeo: fecha_alta = `{{ $now.format('yyyy-MM-dd HH:mm') }}`, nombre, email, curso, importe, id_pago, estado = `activo`.
**6. Google Drive**. Operación: «Share File/Folder». Indica el ID de la carpeta del curso (lo sacas de la URL de la carpeta en Drive), Permission: `reader`, Type: `user`, Email Address: `{{ $json.email }}`, y desactiva «Send Notification Email» porque el correo lo mandas tú.
**7. Gmail**. Operación: «Send». To: `{{ $json.email }}`. Subject: `Bienvenido a {{ $json.curso }} — aquí tienes tus accesos`. Message (HTML): saludo con el nombre, enlace a la carpeta de Drive, enlace al aula o al grupo, fecha de la primera clase y a quién escribir si algo falla.
**8. Google Calendar**. Operación: «Add Attendee to Event» sobre el evento de la primera clase, o «Create Event» si cada alumno tiene su sesión de bienvenida. Attendees: `{{ $json.email }}`.
**9. Gmail** (segundo, para ti). To: tu correo. Subject: `Nueva inscripción: {{ $json.nombre }}`. Así te enteras sin mirar la hoja.

## El trozo de código
Si quieres normalizar el nombre y sacar el nombre de pila para los emails, mete un nodo **Code** entre el 2 y el 3 con modo «Run Once for Each Item»:
```javascript
const nombre = ($input.item.json.nombre || '').trim();
const limpio = nombre.replace(/\s+/g, ' ');
const partes = limpio.split(' ');
const nombrePila = partes[0] ? partes[0].charAt(0).toUpperCase() + partes[0].slice(1).toLowerCase() : 'hola';
$input.item.json.nombre = limpio;
$input.item.json.nombre_pila = nombrePila;
$input.item.json.email = ($input.item.json.email || '').trim().toLowerCase();
return $input.item;
```

## Cómo probarla
En Stripe activa el «Modo de prueba» y haz una compra con la tarjeta 4242 4242 4242 4242. Comprueba que aparece la fila en la hoja y que te llega el email a una dirección tuya.
Ejecuta el flujo dos veces con el mismo email: la segunda debe irse por la rama FALSE y no duplicar nada.
Revisa que el email se ve bien en el móvil antes de activarlo.

## Qué puede salir mal
Emails con mayúsculas o espacios crean duplicados: por eso el nodo Code pasa todo a minúsculas y recorta espacios.
Stripe puede enviar el mismo evento dos veces: guarda el id del evento de Stripe (o `id_pago`) en la hoja y filtra el nodo 3 también por él: si ya existe, no repitas el alta ni el email. El filtro por email evita además duplicar al alumno.
Gmail por API tiene un límite de 500 envíos al día en cuentas gratuitas y 2.000 en Workspace. Si vendes en avalancha, sustituye Gmail por Brevo (300 emails gratis al día) con el nodo **HTTP Request**.
Zona horaria: en Ajustes de n8n pon `Europe/Madrid`, si no el evento del calendario saldrá con dos horas de desfase en verano.
Si Drive falla al compartir, suele ser porque el email del alumno no es una cuenta de Google. Añade un **IF** que compruebe si el dominio es gmail.com y, si no, manda el material como archivo adjunto en el email o pídele una cuenta de Google. Mantén el acceso restringido a cada alumno: el material del curso está ligado a alumnos concretos (datos personales).
Activa en cada nodo de Google la opción «Retry On Fail» con 3 intentos y 5 segundos de espera.

## Cuánto cuesta
n8n auto-alojado: 0 €. n8n Cloud tiene una prueba gratuita temporal y después planes de pago (consulta el precio vigente).
Google Sheets, Gmail, Drive y Calendar: gratis con cuenta personal.
Stripe: 1,5% + 0,25 € por cobro europeo; no hay cuota fija.
Total realista para menos de 500 altas al mes: 0 € además de las comisiones de Stripe.
