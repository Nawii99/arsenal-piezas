# Aviso a testers cuando sube una build nueva a TestFligh…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Detecta la build recién procesada en App Store Connect y avisa a tus probadores por Telegram o correo con la versión, los cambios y qué tienen que probar.

## Qué es y qué hace

Receta de n8n que consulta cada 20 minutos la API de App Store Connect y detecta si hay una build nueva ya procesada. Entonces envía a tu grupo de testers un mensaje por Telegram o correo con el número de versión, las notas de la entrega y la lista de cosas que tienen que probar. Entrada: clave de API de App Store Connect (.p8) y bundleId. Salida: aviso de nueva build al grupo. Necesita firmar un token JWT en un nodo Code.

## Cómo usarla

1. Genera la clave de API en App Store Connect
2. Configura el bundleId y el grupo
3. Sube una build de prueba y confirma el aviso

## Cuándo usarla

Cuando tienes un grupo de testers que nunca se entera de que hay build nueva, y tú acabas escribiendo el mismo mensaje a mano en cada entrega.

## Cómo ganar dinero con ella

Quita 20-30 minutos por entrega. Con dos builds por semana son 4 horas al mes, y consigues feedback en horas en vez de días.

- Avisos de entregas para un freelance que entrega apps a clientes…
- Coordinación de testers para un equipo con dos entregas por semana…

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta cada 20 minutos la API de App Store Connect, ve si hay una build nueva ya procesada, y manda a tu grupo de testers un mensaje con número de versión, notas de la entrega y la lista concreta de cosas a probar. Para equipos pequeños o freelances que entregan a cliente por TestFlight.

## Lo que necesitas antes
- Acceso de Admin o App Manager en App Store Connect.
- Una **clave de API**: Users and Access → Integrations → App Store Connect API → generar clave con rol «App Manager». Te bajas un fichero `.p8` (solo una vez) y apuntas el **Key ID** y el **Issuer ID**.
- El `bundleId` de tu app, por ejemplo `com.tuempresa.tuapp`.
- En n8n auto-alojado, la variable de entorno `NODE_FUNCTION_ALLOW_BUILTIN=crypto` para poder firmar el token dentro del nodo Code. Si usas n8n Cloud y no puedes, firma el token con un servicio aparte o usa Fastlane.
- Un grupo de Telegram con tus testers y el bot dentro (token de @BotFather; el chat_id de un grupo empieza por `-100`).
- Hoja de Google Sheets `builds` con columnas: build_id, version, build_number, fecha, avisado.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Minutes, Minutes Between Triggers: 20.
2. **Code** (nombre: Firmar JWT) — genera el token ES256 que exige Apple. Código completo abajo. Pega el contenido del `.p8` en una credencial de tipo variable de entorno o en el propio Code (si el n8n es solo tuyo).
3. **HTTP Request** (nombre: Listar builds) — GET `https://api.appstoreconnect.apple.com/v1/builds`. Headers: `Authorization` = `Bearer {{ $json.token }}`. Query Parameters: `filter[app]` = tu appId numérico, `sort` = `-uploadedDate`, `limit` = `5`, `fields[builds]` = `version,uploadedDate,processingState,expired`.
4. **Code** (nombre: Quedarme con la última procesada) — filtra `processingState === 'VALID'` y `expired === false`, y devuelve la primera.
5. **Google Sheets** — Get Row(s) de `builds`, Filter: build_id igual al de la build.
6. **IF** — Condition: `{{ $json.yaAvisado }}` «is false». Así no repites el aviso cada 20 minutos.
7. **Telegram** — Send Message al grupo: `🚀 Nueva build {{$json.version}} ({{$json.build_number}}) ya en TestFlight.\n\nQué probar:\n{{$json.checklist}}\n\nSi peta, mándame captura y qué hacías.` Activa «Disable Notification» a false para que suene.
8. **Google Sheets** — Append Row con build_id, version, build_number, fecha y avisado `si`.
9. Opcional, **HTTP Request** — GET `https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=https://testflight.apple.com/join/TUCODIGO` y un **Telegram** con Operation: Send Photo, para que los testers nuevos se apunten escaneando.

## El trozo de código (nodo Code «Firmar JWT»)
```javascript
const crypto = require('crypto');
const KEY_ID = 'ABCD123456';
const ISSUER_ID = '69a6de70-xxxx-xxxx-xxxx-xxxxxxxxxxxx';
const P8 = `-----BEGIN PRIVATE KEY-----
AQUI_PEGAS_EL_CONTENIDO_DEL_FICHERO_P8
-----END PRIVATE KEY-----`;
const b64 = (o) => Buffer.from(JSON.stringify(o)).toString('base64url');
const ahora = Math.floor(Date.now() / 1000);
const header = b64({ alg: 'ES256', kid: KEY_ID, typ: 'JWT' });
const payload = b64({ iss: ISSUER_ID, iat: ahora, exp: ahora + 900, aud: 'appstoreconnect-v1' });
const firmante = crypto.createSign('SHA256');
firmante.update(header + '.' + payload);
const der = firmante.sign(P8);
// Apple exige la firma en formato plano (r||s), no DER
const r = der.slice(4, 4 + der[3]);
const s = der.slice(4 + der[3] + 2);
const pad = (buf) => Buffer.concat([Buffer.alloc(32 - buf.length > 0 ? 32 - buf.length : 0), buf.slice(-32)]);
const firma = Buffer.concat([pad(r), pad(s)]).toString('base64url');
return [{ json: { token: header + '.' + payload + '.' + firma } }];
```

## Cómo probarla
- Ejecuta solo los dos primeros nodos y mira que la llamada a `/v1/builds` devuelve 200. Si da 401, el token está mal firmado.
- Sube una build de prueba con Xcode y espera a que TestFlight diga «Listo para probar»: el aviso debe salir en el siguiente ciclo de 20 minutos.
- Deja el flujo corriendo una hora sin subir nada: no debe mandar ningún mensaje repetido.

## Qué puede salir mal
- **401 Unauthorized**: casi siempre es que la firma va en DER en vez de plano, o que el `exp` supera 20 minutos (Apple lo rechaza).
- **La build tarda en procesarse**: entre subirla y estar `VALID` pueden pasar de 5 a 60 minutos; por eso se consulta cada 20.
- **Duplicados** si el Sheets falla: pon «Retry On Fail» y escribe en la hoja **antes** de mandar el Telegram si prefieres pecar de callado.
- **La clave .p8 no se puede volver a descargar**: guárdala en un gestor de contraseñas el día que la creas.
- **Límite de la API**: unas 3.600 peticiones por hora; con una cada 20 minutos vas sobradísimo.

## Cuánto cuesta
La API de App Store Connect va incluida en tu cuenta de desarrollador de Apple (99 €/año, que ya pagas si publicas). Telegram y Sheets gratis. n8n gratis auto-alojado. Coste añadido: 0 €.
