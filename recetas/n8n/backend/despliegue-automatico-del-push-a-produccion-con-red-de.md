# Despliegue automático: del push a producción con red de…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Cuando subes código a la rama principal, ejecuta los tests, despliega en tu servidor, comprueba que la web sigue viva y, si no, vuelve atrás sola. Para quien despliega a mano por FTP o SSH.

## Qué es y qué hace

Al hacer push a la rama main, se conecta por SSH al servidor, guarda la versión actual, despliega la nueva, ejecuta migraciones y comprueba tres URLs. Si falla, vuelve a la versión anterior y avisa en Slack; si va bien, envía el resumen de commits. Entrada: evento de GitHub; salida: despliegue o reversión. Se monta en n8n con clave SSH y el repositorio clonado en el servidor.

## Cómo usarla

1. Clona el proyecto en el servidor con git
2. Crea el usuario de deploy con sudo acotado
3. Configura el webhook de GitHub
4. Que lo revise un profesional

## Cuándo usarla

Cuando tengas el código en GitHub y despliegues manualmente, o cuando ya despliegues con un script pero sin comprobación posterior ni vuelta atrás.

## Cómo ganar dinero con ella

Quita 15-30 minutos de trabajo tenso por despliegue y evita las caídas de "lo subí y se rompió", que son las que cuestan ventas y llamadas de clientes.

- Despliegues seguros para pymes que hoy suben cambios por FTP sin copia de seguridad.
- Pipeline de despliegue con reversión para agencias con varios clientes en VPS.
- Configuración y soporte mensual de despliegues para tiendas online.

**Precio orientativo:** 200–700 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Escucha los push a la rama `main` de tu repositorio, se conecta por SSH a tu servidor, guarda la referencia de la versión actual, despliega la nueva, ejecuta migraciones y comprueba con tres peticiones HTTP que la web responde.
Si la comprobación falla, hace `git checkout` a la versión anterior, reinicia y te avisa en Slack de que ha revertido. Si va bien, te manda el resumen con los commits incluidos.

## Lo que necesitas antes
- n8n auto-alojado con URL pública (GitHub necesita alcanzarlo).
- Repositorio en GitHub y una credencial: Settings, Developer settings, Personal access tokens (fine-grained), permisos de solo lectura sobre contenidos del repositorio.
- Tu servidor con el proyecto clonado con git (no subido por FTP) y un script de despliegue. Usuario SSH `deploy` con clave, y sudoers acotado a reiniciar tu servicio.
- Credencial SSH en n8n (Private Key) y credencial de Slack o Telegram.
- Un endpoint de salud en tu app: `/health` que devuelva 200 y un JSON con la versión desplegada.

## El script en el servidor (/home/deploy/desplegar.sh)
```bash
#!/bin/bash
set -euo pipefail
cd /var/www/miapp
ANTERIOR=$(git rev-parse HEAD)
echo "ANTERIOR=$ANTERIOR"
git fetch --all --quiet
git checkout --quiet "$1"
npm ci --omit=dev --silent
npm run build --silent
npm run migrate --silent
sudo /bin/systemctl restart miapp
echo "DESPLEGADO=$1"
```
Hazlo ejecutable con `chmod +x /home/deploy/desplegar.sh`.

## Los nodos, en orden
1. **GitHub Trigger** — Authentication: tu credencial, Repository Owner y Name, Events: `push`. n8n crea el webhook en GitHub solo.
2. **IF** (nombre: ¿Es main?) — String: `={{ $json.ref }}` equals `refs/heads/main`.
3. **HTTP Request** (nombre: Estado de los tests) — GET `=https://api.github.com/repos/{{ $json.repository.full_name }}/commits/{{ $json.after }}/check-runs`, Header `Authorization: Bearer TU_TOKEN` y `Accept: application/vnd.github+json`. Antes pon un **Wait** de 2 minutos para dar tiempo a que corran.
4. **IF** (nombre: ¿Tests verdes?) — `={{ $json.check_runs.every(c => c.conclusion === 'success') }}` is true.
5. **Slack** (nombre: Empiezo) — "Desplegando `{{ $json.after.slice(0,7) }}` en producción...".
6. **SSH** (nombre: Desplegar) — Command: `=/home/deploy/desplegar.sh {{ $('GitHub Trigger').first().json.after }}`, Settings: On Error, Continue (using error output).
7. **Wait** — Amount: 20, Unit: Seconds.
8. **HTTP Request** (nombre: Salud) — GET `https://tudominio.com/health`, Timeout 8000, Settings: Retry On Fail activado con Max Tries 3 y Wait Between Tries 5000, On Error: Continue.
9. **Code** (nombre: ¿Va bien?) — comprueba código 200 y que la versión que devuelve coincide con el commit desplegado.
10. **IF** — `={{ $json.ok }}` is true.
11. (rama sí) **Slack** — mensaje de éxito con la lista de commits.
12. (rama no) **SSH** (nombre: Revertir) — Command: `=/home/deploy/desplegar.sh {{ $json.anterior }}`.
13. **Slack** — "🔴 Despliegue revertido. Motivo: {{ $json.motivo }}".

## El código del nodo "¿Va bien?"
```javascript
const salud = $('Salud').first().json;
const despliegue = $('Desplegar').first().json;
const stdout = String(despliegue.stdout || '');
const anterior = (stdout.match(/ANTERIOR=([0-9a-f]+)/) || [])[1] || '';
const esperado = $('GitHub Trigger').first().json.after;
const codigo = salud.statusCode || (salud.error ? 0 : 200);
const versionViva = salud.version || salud.body?.version || '';
let ok = true, motivo = '';
if (despliegue.error || despliegue.exitCode) { ok = false; motivo = 'el script de despliegue falló: ' + String(despliegue.stderr || '').slice(0, 300); }
else if (codigo !== 200) { ok = false; motivo = '/health devolvió ' + codigo; }
else if (versionViva && !esperado.startsWith(versionViva) && !versionViva.startsWith(esperado.slice(0,7))) { ok = false; motivo = 'la versión viva (' + versionViva + ') no es la desplegada'; }
return [{ json: { ok, motivo, anterior, esperado } }];
```

## El mensaje de éxito
En el nodo Slack, Text: `=✅ Desplegado {{ $('GitHub Trigger').first().json.after.slice(0,7) }} en producción por {{ $('GitHub Trigger').first().json.pusher.name }}\n{{ $('GitHub Trigger').first().json.commits.map(c => '• ' + c.message.split('\n')[0]).join('\n') }}`

## Cómo probarla
- Primero, con el nodo SSH de Desplegar **desactivado** (clic derecho, Deactivate): haz un push y comprueba que llega el trigger, que lee bien los tests y que el flujo recorre las ramas correctas.
- Luego actívalo apuntando a un servidor de pruebas o a una copia del proyecto.
- Prueba la vuelta atrás a propósito: rompe temporalmente el endpoint /health y haz un push. Debe revertir y avisarte. Esta prueba es la importante, no la del camino feliz.

## Qué puede salir mal
- **Migraciones de base de datos que no se pueden deshacer**: la vuelta atrás del código no deshace un `DROP COLUMN`. Regla de oro: nunca borres columnas en el mismo despliegue en que dejas de usarlas; espera al siguiente.
- **Dos push seguidos**: se pisarían. En Settings del workflow, activa "Limit execution concurrency" a 1 si tu versión lo permite, o añade un candado en la memoria estática.
- **Los tests aún no han terminado** cuando consultas: el Wait de 2 minutos es un apaño; mejor usa el evento `check_suite` en el GitHub Trigger si tus tests tardan más.
- **npm ci se queda sin memoria** en VPS pequeños: compila en local o en GitHub Actions y sube solo el resultado.
- **Ventana de caída**: el `systemctl restart` corta unos segundos. Si te importa, monta despliegue con dos carpetas y un enlace simbólico que cambies al final.

## Cuánto cuesta
- Gratis: GitHub (repos privados incluidos), n8n auto-alojado, Slack plan gratuito.
- Alternativa de pago que sustituyes: un servicio de CI/CD gestionado (20-40 euros al mes) o Actions minutes si te pasas de los 2.000 minutos gratuitos.
