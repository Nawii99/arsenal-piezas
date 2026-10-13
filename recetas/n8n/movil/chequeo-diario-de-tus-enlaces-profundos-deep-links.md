# Chequeo diario de tus enlaces profundos (deep links)

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Comprueba cada día que los ficheros que hacen que tus enlaces abran la app siguen bien publicados en tu web, y avisa si se rompen.

## Qué es y qué hace

Flujo de n8n que cada día pide a tu dominio los ficheros apple-app-site-association y assetlinks.json, comprueba que responden correctamente y que contienen tu Team ID, bundle ID y huella SHA-256, y avisa por Telegram si algo falla. Entran la URL de tu dominio y tus identificadores; sale un registro diario en la hoja Deeplinks y un aviso si se rompe. Funciona con n8n Cloud o auto-alojado.

## Cómo usarla

1. 1. Anota el Team ID, el bundle ID y la huella SHA-256 de tu app
2. 2. Crea la hoja Deeplinks y el bot de Telegram
3. 3. Prueba el aviso cambiando un dato a propósito

## Cuándo usarla

Úsalo cuando tus campañas o correos lleven enlaces que deben abrir la app y no el navegador, y no quieras enterarte por un cliente.

## Cómo ganar dinero con ella

Un deep link roto tira a la basura el tráfico de una campaña entera. Detectarlo el mismo día evita perder cientos de euros de publicidad.

- Control de Universal Links y App Links para apps que reciben tráfico de campañas, correos y códigos QR.
- Vigilancia de enlaces profundos para agencias que lanzan campañas de apps para varios clientes.
- Chequeo de configuración web-app para equipos que cambian de dominio o de firma y rompen los enlaces.

**Precio orientativo:** 80–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Pide a tu dominio los dos ficheros que Apple y Google usan para asociar la web con la app (`apple-app-site-association` y `assetlinks.json`), comprueba que responden bien y que contienen tus identificadores, y te avisa si algo falla.
Para cualquiera que use Universal Links en iOS o App Links en Android: campañas, correos, códigos QR, enlaces compartidos.

## Lo que necesitas antes
Tu dominio con los ficheros ya publicados (esto lo pone tu desarrollador; si no existen, este flujo te lo dirá el primer día).
Tu Team ID y bundle id de Apple (App Store Connect > Membership) y el nombre de paquete y huella SHA-256 de Android (Play Console > Integridad de la app > Firma de apps).
n8n y un bot de Telegram.
Hoja `Deeplinks` con columnas: fecha, fichero, estado, detalle (opcional, para tener histórico).

## Los nodos, en orden
1. **Schedule Trigger**: Cron `0 7 * * *`.
2. **HTTP Request** (iOS): GET `https://tudominio.com/.well-known/apple-app-site-association`. En Options activa «Never Error» y «Full Response» para poder mirar el código de estado y las cabeceras.
3. **HTTP Request** (Android): GET `https://tudominio.com/.well-known/assetlinks.json`, mismas opciones.
4. **Merge**: modo «Combine > All Combinations», para tener las dos respuestas juntas.
5. **Code**: valida ambas. Código abajo.
6. **Google Sheets** (Append) para el histórico.
7. **IF**: Boolean `{{ $json.todo_ok }}` es false.
8. **Telegram** (rama true del IF): manda `{{ $json.detalle }}`.

## El nodo Code
```javascript
const TEAM_BUNDLE = 'ABCDE12345.com.tuempresa.tuapp';
const PAQUETE = 'com.tuempresa.tuapp';
const items = $input.all().map(i => i.json);
const ios = items[0] || {};
const android = items[1] || {};
const fallos = [];
if (Number(ios.statusCode) !== 200) { fallos.push('El fichero de iOS responde ' + ios.statusCode); }
const tipoIos = ((ios.headers || {})['content-type'] || '');
if (tipoIos.indexOf('json') === -1) { fallos.push('iOS: content-type debe ser application/json y es ' + tipoIos); }
const cuerpoIos = JSON.stringify(ios.body || {});
if (cuerpoIos.indexOf(TEAM_BUNDLE) === -1) { fallos.push('iOS: no aparece ' + TEAM_BUNDLE + ' en el fichero'); }
if (Number(android.statusCode) !== 200) { fallos.push('El fichero de Android responde ' + android.statusCode); }
const cuerpoAndroid = JSON.stringify(android.body || {});
if (cuerpoAndroid.indexOf(PAQUETE) === -1) { fallos.push('Android: no aparece el paquete ' + PAQUETE); }
if (cuerpoAndroid.indexOf('delegate_permission/common.handle_all_urls') === -1) { fallos.push('Android: falta el permiso handle_all_urls'); }
return [{ json: {
  fecha: new Date().toISOString(),
  todo_ok: fallos.length === 0,
  detalle: fallos.length ? fallos.join(' | ') : 'Todo correcto'
}}];
```

## Cómo probarla
Ejecuta a mano: si todo está bien, verás `todo_ok: true`. Cambia a propósito el TEAM_BUNDLE por uno inventado y comprueba que te llega el aviso a Telegram.
Extra útil: prueba también una redirección. Si el fichero devuelve un 301, Apple lo rechaza; con «Full Response» verás el código real si desactivas «Follow Redirects» en Options.

## Qué puede salir mal
El fallo más típico es que un despliegue nuevo de la web borre la carpeta `.well-known` o que el servidor la sirva como `text/plain`. Este flujo lo caza justo por eso.
El certificado SSL caducado también rompe los deep links: si el HTTP Request falla por TLS, el aviso te llegará igual, y ese es el arreglo prioritario.
iOS cachea la asociación: aunque lo arregles, algunos móviles tardan en volver a leerlo (se fuerza reinstalando la app).

## Cuánto cuesta
Gratis. Dos peticiones al día a tu propia web no cuestan nada.
