# Alta automática de probadores para la beta de tu app…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Un formulario recoge a la gente que quiere probar tu app, los mete solos en TestFlight y en el grupo de prueba de Google Play, y les manda las instrucciones.

## Qué es y qué hace

Receta de n8n que recoge en un formulario el email y el sistema de quien quiere probar tu app. Si usa iPhone, lo añade como probador en TestFlight mediante la API de App Store Connect; si usa Android, lo añade al grupo de prueba cerrada de Google Play. Después le envía las instrucciones por correo. Entrada: formulario con email, nombre y sistema. Salida: probadores dados de alta y correo de bienvenida. Requiere claves de API de Apple y acceso a Play Console.

## Cómo usarla

1. Crea el formulario y la clave de App Store Connect
2. Vincula el grupo de Play
3. Prueba con un tester propio y revisa el correo

## Cuándo usarla

Úsalo cuando lanzas una beta y te toca copiar emails a mano en dos consolas distintas, o cuando Google te exige 12 testers durante 14 días para poder publicar.

## Cómo ganar dinero con ella

Quita 5-10 minutos por tester y elimina los errores de copiar emails. Con 50 testers son varias horas y una publicación que no se retrasa.

- Gestión de betas para una app de un estudio pequeño antes de lanzar…
- Alta de testers para una app de cliente que sale en dos tiendas…
- Captación de probadores para un negocio con app propia…

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Pones un formulario donde la gente deja su email y si usa iPhone o Android. Al enviarlo, n8n mete el email como tester en TestFlight (si es iOS) o lo añade al grupo de Google que tienes vinculado a la prueba cerrada de Play (si es Android), y le manda un email con el enlace y los pasos.
Es para quien lanza una app o una versión nueva y necesita probadores reales sin perder la mañana.

## Lo que necesitas antes
n8n.
Formulario en Tally con campos email, nombre y sistema (iOS/Android). También sirve el nodo nativo «n8n Form Trigger» si no quieres cuenta externa.
Para iOS: una clave de API de App Store Connect. Entra en appstoreconnect.apple.com, Users and Access, Integrations, App Store Connect API, genera una clave con rol App Manager y descarga el .p8. Apunta el Key ID y el Issuer ID. La API exige un token JWT firmado.
Para Android: en Play Console, prueba cerrada, elige «Grupos de Google» como método de testers y crea un grupo en groups.google.com. Necesitas la Google Admin SDK Directory API si tienes Workspace, o simplemente añadir al grupo con el nodo de Google Groups.
Brevo o Gmail para el email de bienvenida.

## Los nodos, en orden
1. «Webhook» (o «n8n Form Trigger» si usas el formulario propio de n8n). Method POST.
2. «Set» normalizando email en minúsculas y sistema.
3. «Google Sheets» (Lookup por email) para no dar de alta dos veces al mismo.
4. «IF» (email ya existe) → «NoOp» y fin.
5. «Switch» por sistema, dos salidas.
6. Rama iOS, nodo «Code» que genera el JWT de Apple. Código completo:
```js
const jwt = require('jsonwebtoken');
const KEY_ID = 'TU_KEY_ID';
const ISSUER = 'TU_ISSUER_ID';
const P8 = `-----BEGIN PRIVATE KEY-----
PEGA_AQUI_TU_CLAVE
-----END PRIVATE KEY-----`;
const token = jwt.sign({}, P8, {
  algorithm: 'ES256',
  expiresIn: '15m',
  issuer: ISSUER,
  audience: 'appstoreconnect-v1',
  header: { alg: 'ES256', kid: KEY_ID, typ: 'JWT' }
});
return [{ json: { token } }];
```
Nota: para que require funcione tienes que arrancar n8n con la variable NODES_EXCLUDE vacía y NODE_FUNCTION_ALLOW_EXTERNAL=jsonwebtoken. Si no puedes tocar eso, genera el token con un servicio externo o usa solo la rama Android.
7. Rama iOS, «HTTP Request». Method POST, URL https://api.appstoreconnect.apple.com/v1/betaTesters . Header Authorization: Bearer {{ $json.token }}. Body JSON con el email, nombre y la relación al betaGroup cuyo id sacas de una llamada previa a /v1/betaGroups.
8. Rama Android, «Google Groups» (Add member) o «HTTP Request» POST a https://admin.googleapis.com/admin/directory/v1/groups/TU_GRUPO/members con body {"email":"{{ $json.email }}","role":"MEMBER"}.
9. «Brevo» (Send transactional email) con el asunto «Ya eres tester de TU_APP» y el cuerpo con: enlace de TestFlight o de la prueba de Play, aviso de que hay que aceptar la invitación desde el mismo email, y cómo enviarte feedback.
10. «Google Sheets» (Append) apuntando email, sistema y fecha.
11. Opcional: «Wait» de 3 días más «IF» que compruebe si instaló y «Brevo» con un recordatorio.

## Cómo probarla
Rellena el formulario con tu propio email en iOS y luego en Android. Comprueba que aparece en la lista de testers de App Store Connect y como miembro del grupo de Google.
Prueba a enviarlo dos veces con el mismo email: no debe duplicarse.

## Qué puede salir mal
Apple limita a 10.000 testers externos y exige revisión de la primera build. Si la build no está aprobada, el tester se añade pero no ve nada.
El JWT de Apple caduca a los 20 minutos como máximo. Genéralo en cada ejecución, no lo guardes.
En Android, el usuario tiene que abrir el enlace de la prueba con la misma cuenta de Google del grupo; si tiene varias cuentas en el móvil, es el fallo más habitual. Dilo en el email de bienvenida con todas las letras.
Los grupos de Google tardan hasta unos minutos en propagarse a Play.
Cuidado con el RGPD: estás guardando emails, pon una casilla de consentimiento en el formulario.

## Cuánto cuesta
n8n, Tally, Google Groups y Brevo: gratis. La cuenta de desarrollador de Apple cuesta 99 $ al año y la de Google 25 $ una vez, pero eso ya lo pagas por tener la app.
