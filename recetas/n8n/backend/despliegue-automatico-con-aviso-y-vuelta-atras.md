# Despliegue automático con aviso y vuelta atrás…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Cuando subes código a la rama principal, el servidor se actualiza solo, comprueba que la web responde y, si algo falla, vuelve a la versión anterior y te avisa.

## Qué es y qué hace

Escucha los push a main con un webhook firmado de GitHub, actualiza el código en el servidor, instala dependencias, reinicia el servicio y comprueba que la web responde. Si no responde, vuelve al commit anterior y avisa por Telegram. Entran el push y el repositorio clonado en el servidor; sale una web actualizada o revertida y un aviso. Para desarrolladores en solitario o equipos pequeños con un VPS.

## Cómo usarla

1. Clona el repo con deploy key en el servidor
2. Permite a n8n reiniciar solo tu servicio con sudoers
3. Crea el webhook de GitHub con secreto
4. Prueba con un cambio sin riesgo y otro que falle

## Cuándo usarla

Úsalo cuando despliegues entrando por SSH y copiando comandos a mano, y hayas dejado alguna vez la web rota sin darte cuenta.

## Cómo ganar dinero con ella

Ahorra 10-20 minutos por despliegue y evita las caídas de la web que cuestan ventas. Sustituye herramientas de CI/CD de pago para proyectos pequeños.

- Despliegue automatizado para webs de clientes en VPS, con vuelta atrás incluida…
- Configuración de CI/CD ligero para proyectos pequeños sin herramientas de pago…
- Mantenimiento de despliegues para desarrolladores freelance con aviso de incidencias…

**Precio orientativo:** 100–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Escucha los push a `main` en tu repositorio, valida la firma del webhook, actualiza el código en el servidor, instala dependencias, reinicia el servicio y verifica que responde. Si no responde, revierte al commit anterior. Para desarrolladores en solitario y equipos pequeños con un VPS.

## Lo que necesitas antes
- n8n en el mismo servidor que la app, con permiso para ejecutar comandos y para reiniciar el servicio (`sudo visudo` y añade: `node ALL=(ALL) NOPASSWD: /bin/systemctl restart mi-app`).
- El repositorio ya clonado en `/srv/mi-app` con acceso por deploy key.
- En GitHub: Settings del repo → Webhooks → Add webhook. Payload URL: `https://tu-n8n/webhook/deploy`, Content type: `application/json`, Secret: inventa uno largo, Events: solo «Just the push event».
- Bot de Telegram.

## Los nodos, en orden
1. **Webhook** — POST, Path: `deploy`, Respond: Immediately con código 200 (GitHub corta a los 10 segundos). En Options activa Raw Body.
2. **Code** (renómbralo «Validar y filtrar»):
```javascript
const crypto = require('crypto');
const SECRETO = 'PON_AQUI_EL_SECRETO_DE_GITHUB';
const req = $input.item.json;
const bruto = req.body ? req.body.toString() : '';
const firma = (req.headers['x-hub-signature-256'] || '').replace('sha256=', '');
const calc = crypto.createHmac('sha256', SECRETO).update(bruto).digest('hex');
const valida = firma.length === calc.length && crypto.timingSafeEqual(Buffer.from(firma), Buffer.from(calc));
let d = {};
try { d = JSON.parse(bruto); } catch (e) {}
return { json: {
  seguir: valida && d.ref === 'refs/heads/main',
  autor: d.head_commit?.author?.name || '?',
  mensaje: d.head_commit?.message || '',
  commit: (d.after || '').slice(0, 7)
} };
```
3. **IF** — `{{ $json.seguir }}` is true.
4. **Execute Command** (renómbralo «Guardar versión actual») — `cd /srv/mi-app && git rev-parse HEAD`.
5. **Execute Command** (renómbralo «Desplegar»):
```
cd /srv/mi-app && git fetch --all && git reset --hard origin/main && npm ci --omit=dev && npm run build && sudo systemctl restart mi-app && sleep 8 && echo DESPLEGADO
```
6. **HTTP Request** (renómbralo «Prueba de humo») — GET a `https://tudominio.com/health`, Options → Timeout 10000, Never Error on HTTP Status: on, Retry On Fail: on, Max Tries 3, Wait Between Tries 5000.
7. **IF** — Number: `{{ $json.statusCode }}` equal to 200.
8. Rama **true** → **Telegram**: `✅ Desplegado {{ $('Validar y filtrar').first().json.commit }} por {{ $('Validar y filtrar').first().json.autor }}`.
9. Rama **false** → **Execute Command** (renómbralo «Rollback»):
```
cd /srv/mi-app && git reset --hard {{ $('Guardar versión actual').first().json.stdout.trim() }} && npm ci --omit=dev && npm run build && sudo systemctl restart mi-app && echo REVERTIDO
```
10. → **Telegram**: `🔴 Despliegue fallido, revertido a la versión anterior. Revisa los logs.`

## Cómo probarla
- Primero ejecuta el comando de despliegue a mano por SSH, tal cual, y comprueba que funciona. Si falla ahí, fallará en n8n.
- Haz un push trivial (cambia un comentario) y mira que llega el Telegram verde.
- Provoca un fallo: rompe a propósito el endpoint `/health` y haz push. Debe revertir y avisarte en rojo.

## Qué puede salir mal
- **n8n no tiene el entorno**: `npm` o `node` pueden no estar en el PATH del proceso de n8n. Usa rutas absolutas (`/usr/bin/npm`) o envuelve todo en un script `/srv/deploy.sh` y llama solo a ese.
- **Despliegues solapados**: dos push seguidos lanzan dos despliegues a la vez. En Settings del workflow pon «Execution Order: v1» y limita la concurrencia, o crea un fichero de bloqueo: `[ -f /tmp/deploy.lock ] && exit 1; touch /tmp/deploy.lock; ...; rm /tmp/deploy.lock`.
- **Migraciones de base de datos**: si tu despliegue cambia el esquema, el rollback de código no revierte la base. Haz migraciones compatibles hacia atrás, siempre.
- **Timeout de GitHub**: por eso el Webhook responde de inmediato y el trabajo va después.
- **Secreto expuesto**: no subas nunca el secreto al repo. Mejor en variable de entorno de n8n (`process.env.GH_SECRET`).

## Cuánto cuesta
0 € en herramientas: n8n auto-alojado, GitHub webhooks y Telegram son gratis. Solo el VPS que ya pagas.
