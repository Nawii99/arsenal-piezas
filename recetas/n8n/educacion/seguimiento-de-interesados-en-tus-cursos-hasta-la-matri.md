# Seguimiento de interesados en tus cursos hasta la matrí…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Captura al que pide información, le manda al momento el programa y una secuencia de tres emails, y te avisa cuando alguien abre y pincha para que le llames en caliente.

## Qué es y qué hace

Recoge el formulario de información de tu web, guarda el lead en una hoja, envía al momento el PDF del programa y lanza una secuencia de tres correos durante una semana con Brevo. Cuando el lead abre o pincha, te avisa para que le llames. Entran formularios y eventos de correo, y salen registros, correos y avisos. Para academias y formadores que venden programas de precio medio-alto, con n8n.

## Cómo usarla

1. Conecta el formulario de la web al webhook
2. Crea la hoja de leads y la cuenta de Brevo
3. Programa la secuencia de tres correos
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando recibas solicitudes de información por web o redes y las contestes cuando puedes, que suele ser tarde. En formación, el que responde primero se lleva la matrícula.

## Cómo ganar dinero con ella

Responder en 5 minutos en vez de en 24 horas multiplica por 5 la conversión. En un curso de 900 €, dos matrículas más al mes son 1.800 €.

- Implantación de captación y seguimiento de leads para academias o escuelas de negocio, con secuencia de correos.
- Gestión mensual de la secuencia y avisos de interés para formadores que venden programas, por cuota.
- Plantilla de embudo de captación vendida a cursos de oposición o formación privada.

**Precio orientativo:** 300–600 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recoge el formulario de «solicita información» de tu web, guarda el lead, le manda el PDF del programa en menos de un minuto, lanza una secuencia de tres emails a lo largo de una semana y te avisa cuando el lead muestra interés real para que le llames.
Para academias, escuelas de negocio, cursos de oposición y formadores que venden programas de precio medio-alto.

## Lo que necesitas antes
- Un formulario en tu web. Si usas WordPress con Elementor o WPForms, puedes enviar a un webhook. Si es HTML puro, un `fetch()` con POST a la URL del webhook.
- Cuenta de Brevo (antes Sendinblue): plan gratuito con 300 emails al día. Saca la clave en Brevo > SMTP y API > Claves API.
- Una hoja «Leads» con: fecha | nombre | email | telefono | curso | origen | estado | ultimo_contacto
- El PDF del programa subido a Drive con enlace público, o alojado en tu web.
- Un enlace de Calendly o Google Calendar Appointment Schedule para las llamadas.

## Los nodos, en orden
1) **Webhook**. Method: POST. Path: `info-curso`. Response Mode: «Using Respond to Webhook Node» para poder devolver un «gracias» al formulario. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2) **Set** «Normalizar»: `nombre` = `{{ $json.body.nombre.trim() }}`, `email` = `{{ $json.body.email.trim().toLowerCase() }}`, `telefono`, `curso`, `origen` = `{{ $json.body.origen || 'web' }}`.
3) **IF** anti-basura. Condición: el email contiene `@` Y el nombre tiene más de 2 caracteres. Añade una segunda condición que descarte si el campo oculto `honeypot` viene relleno (mete en tu formulario un campo invisible con ese nombre: los bots lo rellenan, las personas no).
4) **Google Sheets** (Append Row) en «Leads» con `estado` = `nuevo`.
5) **HTTP Request** a Brevo. POST `https://api.brevo.com/v3/smtp/email`. Authentication: Generic Credential Type > Header Auth con una credencial (Name `api-key`, Value tu clave de Brevo); la clave va solo en la credencial, nunca escrita en el nodo, porque un flujo exportado se llevaría la clave. Body:
```json
{"sender":{"name":"Academia X","email":"info@academiax.com"},"to":[{"email":"{{ $json.email }}","name":"{{ $json.nombre }}"}],"subject":"Aquí tienes el programa de {{ $json.curso }}","htmlContent":"<p>Hola {{ $json.nombre }}, te dejo el programa completo: <a href='ENLACE_PDF'>descargar</a>. Si prefieres que te lo cuente en 15 minutos, reserva hueco <a href='TU_CALENDLY'>aquí</a>.</p>"}
```
6) **Respond to Webhook**. Response Body: `{"ok":true}`. Así tu formulario muestra el mensaje de gracias.
7) **Wait**. Amount: 2 días. Después un **Google Sheets** (Get Row(s)) que compruebe el `estado`: si ya está en `matriculado` o `descartado`, un **IF** corta la secuencia.
8) **HTTP Request** a Brevo (misma credencial), email 2: un caso real de alumno, con nombre, antes y después, y el enlace a la llamada.
9) **Wait** 3 días más. Email 3: fechas de la próxima convocatoria, plazas restantes y precio. Aquí sí se habla de dinero.
10) **Wait** 2 días. **IF** sobre si hay teléfono: si lo hay, **Gmail** o **Slack** a ti con «Llamar a {{ nombre }}, curso {{ curso }}, tel {{ telefono }}» y un **Google Calendar** (Create Event) que te bloquee 15 minutos mañana para esa llamada.
11) **Google Sheets** (Update Row) en cada paso con `ultimo_contacto`, para que sepas por dónde va cada uno.

## Cómo probarla
- Con el workflow en modo «Listen», manda una petición de prueba: `curl -X POST -H "Content-Type: application/json" -d '{"nombre":"Ana","email":"tu@email.com","telefono":"600111222","curso":"Marketing"}' TU_URL_WEBHOOK`
- Comprueba la fila en la hoja y el primer email en menos de un minuto.
- Para probar los Wait sin esperar una semana, cámbialos temporalmente a 1 minuto.
- Marca el lead como `matriculado` a mitad de secuencia y verifica que deja de recibir emails.

## Qué puede salir mal
- **Seguir escribiendo a quien ya se matriculó**: queda fatal. El IF del paso 7 es obligatorio, repítelo antes de cada email.
- **Emails a spam**: configura SPF, DKIM y DMARC de tu dominio en Brevo. Sin eso, la mitad no llega.
- **RGPD**: el formulario necesita casilla de consentimiento y enlace a política de privacidad, y todos los emails, enlace para darse de baja. Brevo lo pone solo si usas sus listas.
- **Formularios que no envían al webhook**: si tu plugin no lo permite, usa Zapier Catch Hook o cambia el trigger por un **Google Sheets Trigger** sobre la hoja de respuestas de un Google Form.
- **Bots**: el honeypot del paso 3 te quita el 90% de la basura.

## Cuánto cuesta
- Brevo: gratis hasta 300 emails al día; 9 €/mes si necesitas más.
- Sheets, Calendar y n8n auto-alojado: gratis.
- Calendly tiene plan gratuito suficiente para un tipo de reunión.
