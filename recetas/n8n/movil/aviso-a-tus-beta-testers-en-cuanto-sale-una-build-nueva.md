# Aviso a tus beta testers en cuanto sale una build nueva…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Cuando publicas una versión de prueba, manda un correo a tus testers con las novedades, qué probar y el enlace, y lleva la lista de quién ha respondido.

## Qué es y qué hace

Flujo de n8n que se dispara con un webhook al publicar una release o una build, toma las notas de la versión y envía un correo personalizado a cada tester activo con qué probar y el enlace de TestFlight o Firebase App Distribution. Actualiza la última versión avisada en la hoja Testers. Entran la lista de probadores y las notas; sale un correo por tester y el registro del aviso. Requiere Gmail y Google Sheets conectados.

## Cómo usarla

1. 1. Crea la hoja Testers con tu lista de probadores
2. 2. Configura el webhook en GitHub o en tu proceso de compilación
3. 3. Envía una build de prueba a un tester de confianza
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tengas un grupo de probadores y acabes escribiendo el mismo mensaje de WhatsApp uno por uno cada vez que subes una build.

## Cómo ganar dinero con ella

Te ahorra 20-30 minutos por versión y consigues el triple de feedback, porque la gente prueba cuando le dices exactamente qué mirar.

- Avisos de nueva build para equipos de apps con 10 a 100 probadores que se pierden entre versiones.
- Correos de beta para agencias que entregan prototipos a clientes y quieren feedback ordenado.
- Gestión de probadores para estudios que quieren que cada tester pruebe lo que de verdad importa.

**Precio orientativo:** 100–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Se dispara cuando publicas una release en GitHub (o cuando llamas a un webhook desde tu proceso de compilación), coge las notas de esa versión y manda un correo personalizado a cada tester con instrucciones claras.
Para equipos pequeños con TestFlight o Firebase App Distribution y una lista de 10-100 probadores.

## Lo que necesitas antes
n8n con Gmail y Google Sheets conectados.
Una hoja `Testers` con columnas: nombre, email, plataforma (iOS/Android), activo (SI/NO), ultima_version_avisada.
Un repositorio en GitHub donde crees releases, o cualquier sistema que pueda hacer una llamada POST.
El enlace público de TestFlight (App Store Connect > TestFlight > Grupo público > enlace) o el de Firebase App Distribution.

## Los nodos, en orden
1. **Webhook**: POST, Path `nueva-build`, con Header Auth para que no lo llame cualquiera. En GitHub: Settings del repo > Webhooks > Add webhook, pega la URL, content type `application/json`, evento «Releases».
2. **Code**: saca versión y notas del payload. Código abajo.
3. **Google Sheets** (Get Row(s)): hoja `Testers`, filtro `activo` = SI.
4. **IF**: descarta a quien ya tenga `ultima_version_avisada` igual a la versión nueva (String, «is not equal to»).
5. **Split In Batches**: Batch Size = 10, para no disparar los límites de Gmail.
6. **Gmail** (Send): a `{{ $json.email }}`, asunto `Nueva versión {{ $('Code').first().json.version }} lista para probar`, cuerpo con el nombre del tester, las notas, el enlace según plataforma y la pregunta concreta que quieras que respondan.
7. **Wait**: 30 segundos entre lotes.
8. **Google Sheets** (Update): pon `ultima_version_avisada` = la versión enviada.
9. Vuelve al **Split In Batches**.

## El nodo Code
```javascript
const body = $input.first().json.body || {};
const rel = body.release || {};
const version = rel.tag_name || body.version || 'sin-version';
const notas = (rel.body || body.notas || 'Correcciones varias.').slice(0, 2000);
const enlace_ios = 'https://testflight.apple.com/join/XXXXXXX';
const enlace_android = 'https://appdistribution.firebase.dev/i/XXXXXXX';
return [{ json: { version, notas, enlace_ios, enlace_android, fecha: new Date().toISOString() } }];
```

## El correo que consigue respuestas
Asunto corto con el número de versión. Primer párrafo: qué has cambiado, en dos líneas y en cristiano.
Después, «Qué necesito que pruebes» con máximo tres puntos numerados y muy concretos («entra con tu cuenta, sube una foto, dime si tarda más de 3 segundos»).
Cierra con «Responde a este correo con lo que sea, aunque sea *me va bien*». Ese permiso multiplica las respuestas.
En el enlace usa una expresión de n8n para elegir el de iOS o el de Android según la columna plataforma.

## Cómo probarla
Crea una release de prueba en GitHub con el tag `v0.0.1-test` y la hoja con un solo tester (tú). Comprueba el correo y que la columna se actualiza.
Si no llega nada, mira en n8n > Executions el detalle del Webhook: GitHub te enseña también la respuesta en la pestaña «Recent Deliveries» de su webhook.

## Qué puede salir mal
Gmail limita a 500 envíos al día en cuentas normales y a 2.000 en Workspace; con lotes de 10 y espera de 30 segundos no llamas la atención de sus filtros.
Si repites el envío por accidente, la columna `ultima_version_avisada` es la que impide que la gente reciba el mismo correo dos veces: no la quites.
GitHub manda el webhook también al editar una release; filtra con un **IF** por `{{ $json.body.action }}` igual a `published`.

## Cuánto cuesta
Gratis: GitHub, Gmail, Sheets y n8n auto-alojado. TestFlight está incluido en tu cuenta de desarrollador de Apple (99 $/año, que ya pagas por publicar).
