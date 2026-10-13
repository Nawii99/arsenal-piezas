# Despliegue al servidor al hacer push a main…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cada push a la rama main lanza el despliegue en tu VPS por SSH, comprueba que la web responde y, si algo falla, revierte a la versión anterior y te avisa.

## Qué es y qué hace

Al recibir un push a main, entra por SSH en tu servidor con una clave dedicada, actualiza el código, instala dependencias, reinicia el servicio y comprueba con una petición HTTP que la web responde. Si la comprobación falla, vuelve al commit anterior y avisa por Telegram. Se monta con n8n, Make o Zapier y necesita acceso SSH a un VPS.

## Cómo usarla

1. Crea una clave SSH solo para despliegues
2. Crea un usuario con permisos mínimos
3. Prueba el comando de reinicio a mano
4. Haz un push de prueba y revisa el aviso
5. Que lo revise un profesional

## Cuándo usarla

Cuando despliegues entrando por SSH a mano y arrastrando comandos, y ya hayas roto producción alguna vez por un paso olvidado.

## Cómo ganar dinero con ella

Ahorra 10-15 minutos por despliegue y evita las caídas por despliegue manual. Sustituye planes de PaaS de 20 €/mes por un VPS de 5 €.

- Despliegue automatizado para webs de clientes en VPS propio…
- Configuración de integración continua para proyectos pequeños sin PaaS…
- Revisión de procesos de despliegue como consultoría para equipos con incidencias…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Al recibir un push a `main`, entra por SSH en tu servidor, hace `git pull`, instala dependencias, construye, reinicia el servicio y comprueba con una petición HTTP que la web sigue viva. Si la comprobación falla, vuelve al commit anterior y te avisa por Telegram.
Para quien tiene su proyecto en un VPS propio (Node, Laravel, Django, Astro...) y despliega a mano.
## Lo que necesitas antes
- VPS con acceso SSH y el proyecto ya clonado y funcionando en, por ejemplo, `/var/www/miapp`.
- Un par de claves SSH dedicado para n8n: en tu máquina `ssh-keygen -t ed25519 -C "n8n-deploy"`, la pública al `~/.ssh/authorized_keys` del servidor, la privada como credencial «SSH» en n8n. No uses tu clave personal.
- Un usuario de despliegue con permisos solo sobre esa carpeta y sobre reiniciar el servicio (`sudoers` con `NOPASSWD` únicamente para `systemctl restart miapp`).
- Bot de Telegram y token de GitHub para el webhook.
## Los nodos, en orden
1) **Webhook**: POST, path `deploy-miapp`. En GitHub: Settings > Webhooks, evento «Just the push event», y define un `Secret`.
2) **Code** (verificar la rama y la firma del secreto):
```javascript
const body = $input.first().json.body;
if (body.ref !== 'refs/heads/main') return [];
return [{ json: { autor: body.head_commit?.author?.name || '?', mensaje: body.head_commit?.message?.split('\n')[0] || '', sha: (body.after || '').slice(0, 7) } }];
```
3) **SSH** (guardar el commit actual por si hay que volver): Resource `Command`, Command:
```bash
cd /var/www/miapp && git rev-parse HEAD
```
4) **SSH** (desplegar): Command en una línea, encadenado con `&&` para que se pare al primer fallo:
```bash
cd /var/www/miapp && git fetch --all && git reset --hard origin/main && npm ci --omit=dev && npm run build && sudo systemctl restart miapp && sleep 5 && echo DEPLOY_OK
```
5) **HTTP Request** (comprobación de salud): GET `https://miapp.es/health`, Timeout 10000, «Full Response» activado y «Continue On Fail» activado.
6) **IF**: Number `{{ $json.statusCode || 0 }}` «is equal to» `200`.
7) **Telegram** (rama true): `✅ Desplegado {{ $('Code').item.json.sha }} · {{ $('Code').item.json.mensaje }} · por {{ $('Code').item.json.autor }}`.
8) **SSH** (rama false, marcha atrás): Command:
```bash
cd /var/www/miapp && git reset --hard {{ $('SSH').first().json.stdout.trim() }} && npm ci --omit=dev && npm run build && sudo systemctl restart miapp && echo ROLLBACK_OK
```
9) **Telegram** (rama false): `🔴 Despliegue fallido de {{ $('Code').item.json.sha }}. He revertido al commit anterior. Revisa los logs: journalctl -u miapp -n 100`.
## Cómo probarla
- Primero prueba con un servidor de staging, no con producción. Nunca estrenes esto en la web que da de comer.
- Haz un push inofensivo (cambiar un texto) y mira la ejecución paso a paso en n8n.
- Prueba a propósito un despliegue roto (un error de sintaxis) y comprueba que la marcha atrás funciona y que la web vuelve a responder.
- Verifica antes a mano que el usuario de n8n puede ejecutar todos los comandos sin pedir contraseña.
## Qué puede salir mal
- **`sudo` pide contraseña**: el SSH se queda colgado hasta el timeout. Configura la línea en `/etc/sudoers.d/deploy` con `NOPASSWD`.
- **Dos pushes seguidos**: pueden solaparse. En Settings del workflow limita la concurrencia o añade un fichero de bloqueo: `[ -f /tmp/deploy.lock ] && exit 1 || touch /tmp/deploy.lock` al principio y `rm -f /tmp/deploy.lock` al final.
- **Migraciones de base de datos**: añádelas al comando (`php artisan migrate --force` o `npx prisma migrate deploy`) ANTES del reinicio, y haz backup antes (ver la receta de copia de seguridad).
- **Webhook público sin protección**: usa el Secret de GitHub y valida la cabecera `x-hub-signature-256` en el Code, o al menos usa un path largo e imposible de adivinar.
- **Caída de segundos durante el reinicio**: si te importa, usa `pm2 reload` en vez de `restart`, que hace recarga sin corte.
## Cuánto cuesta
- VPS: desde 5 €/mes (Hetzner, Contabo). n8n auto-alojado en el mismo servidor: 0 €.
- GitHub y Telegram: gratis.
- Alternativa gestionada equivalente: Vercel Pro o Railway, desde unos 20 €/mes.
