# Aviso en Telegram cuando se rompe un despliegue…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cuando un workflow de GitHub Actions falla, te llega al móvil un mensaje con el repo, la rama, quién lo rompió y las líneas de error del log.

## Qué es y qué hace

Un webhook de GitHub recibe el evento de cada workflow terminado y, si ha fallado, te manda a Telegram el repositorio, la rama, quién lo originó y las líneas de error extraídas del log. Pensado para equipos que despliegan varias veces al día con GitHub Actions y no quieren vigilar la pestaña Actions.

## Cómo usarla

1. Crear el token de GitHub con permiso Actions Read
2. Crear el bot de Telegram y el chat_id
3. Configurar el webhook en el repositorio
4. Probar con un workflow que falle

## Cuándo usarla

Úsalo cuando tengas despliegues automáticos en GitHub Actions y te enteres tarde de que producción está caída o de que la build lleva horas roja.

## Cómo ganar dinero con ella

Te ahorra revisar la pestaña Actions a mano y recorta el tiempo medio de reacción de horas a minutos. Todo con herramientas gratuitas.

- Alertas de fallo de despliegue para desarrolladores que mantienen varios repositorios.
- Vigilancia de build para equipos pequeños con despliegues frecuentes.
- Configuración de alertas en CI que el técnico entrega a clientes con producción propia.

**Precio orientativo:** 80–180 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Escucha los eventos de GitHub Actions y, en cuanto un workflow termina en fallo, te manda un Telegram con el error real extraído del log.
Es para el programador o el equipo pequeño que despliega varias veces al día y no quiere vivir mirando la pestaña Actions.

## Lo que necesitas antes
- Una cuenta de GitHub con permisos de administrador en el repo (Settings > Webhooks).
- Un token personal de GitHub: github.com/settings/tokens > Fine-grained tokens > permisos `Actions: Read` y `Contents: Read` sobre ese repo. Cópialo, solo se ve una vez.
- Un bot de Telegram: habla con `@BotFather`, `/newbot`, te da un token tipo `12345:AAF...`.
- Tu chat_id: escribe a `@userinfobot` y te lo dice.
- n8n con URL pública (n8n Cloud, o auto-alojado con un dominio o un túnel). GitHub necesita poder llamarte.

## Los nodos, en orden
**1. Webhook** — HTTP Method `POST`, Path `deploy-fallo`, Respond `Immediately`. Copia la Production URL.
En GitHub: Settings > Webhooks > Add webhook > Payload URL esa, Content type `application/json`, «Let me select individual events» > marca solo **Workflow runs**.
**2. IF** (nombre: «¿Ha fallado?») — Condición 1 (String): valor `{{ $json.body.action }}` igual a `completed`. Condición 2 (String): `{{ $json.body.workflow_run.conclusion }}` igual a `failure`. Combinador `AND`.
**3. HTTP Request** («Listar jobs») — Method `GET`, URL `https://api.github.com/repos/{{ $json.body.repository.full_name }}/actions/runs/{{ $json.body.workflow_run.id }}/jobs`. Authentication `Generic Credential Type` > `Header Auth`, nombre `Authorization`, valor `Bearer TU_TOKEN`. Añade header `User-Agent: n8n`.
**4. Code** («Coger el job roto») — modo `Run Once for All Items`.
**5. HTTP Request** («Bajar el log») — `GET` `https://api.github.com/repos/{{ $('Webhook').item.json.body.repository.full_name }}/actions/jobs/{{ $json.jobId }}/logs`, misma credencial, Options > Response > Response Format `Text`, y activa `Never Error` para que un 404 no tumbe el flujo.
**6. Code** («Extraer errores») — filtra las líneas con error.
**7. Telegram** — Resource `Message`, Operation `Send Message`, Chat ID el tuyo, Text `={{ $json.mensaje }}`, Additional Fields > Parse Mode `HTML`.

## El código del nodo 4
```javascript
const jobs = $input.first().json.jobs || [];
const roto = jobs.find(j => j.conclusion === 'failure');
if (!roto) return [];
return [{ json: { jobId: roto.id, jobName: roto.name } }];
```

## El código del nodo 6
```javascript
const log = $input.first().json.data || '';
const lineas = log.split('\n');
const malas = lineas.filter(l => /error|Error|ERROR|failed|npm ERR!/.test(l)).slice(-15);
const w = $('Webhook').first().json.body.workflow_run;
const repo = $('Webhook').first().json.body.repository.full_name;
const texto = '<b>Despliegue roto</b>\n' + repo + ' (' + w.head_branch + ')\nAutor: ' + w.actor.login + '\n<a href="' + w.html_url + '">Ver en GitHub</a>\n\n<pre>' + malas.join('\n').slice(0, 3000).replace(/</g,'&lt;') + '</pre>';
return [{ json: { mensaje: texto } }];
```

## Cómo probarla
1. Activa el workflow y en GitHub > Webhooks > Recent Deliveries pulsa `Redeliver` sobre una entrega antigua para ver que llega.
2. Haz un commit en una rama de pruebas que rompa la build a propósito (por ejemplo un `import` inexistente) y comprueba que te llega el Telegram con las líneas correctas.
3. Repite con una build correcta: no debe llegar nada.

## Qué puede salir mal
- **Te llegan tres avisos por despliegue**: el evento `workflow_run` se dispara en `requested`, `in_progress` y `completed`. El IF con `action = completed` lo arregla; si te saltas ese filtro, spam asegurado.
- **El log llega vacío**: GitHub responde con una redirección a un fichero temporal; asegúrate de que en el HTTP Request está `Follow Redirects` activo (Options > Redirects) y el Response Format en `Text`.
- **Logs enormes**: por eso cortamos a 3000 caracteres; Telegram rechaza mensajes de más de 4096.
- **Error 401**: el token fine-grained caduca. Ponte un recordatorio y renuévalo.
- **Límite de la API**: 5.000 llamadas/hora con token. Este flujo gasta 2 por fallo, ni te acercas.

## Cuánto cuesta
GitHub Actions, la API, Telegram y n8n auto-alojado: 0 €. Si no quieres montar servidor, n8n Cloud arranca en unos 20 €/mes; el plan gratuito de n8n Cloud te da suficientes ejecuciones para esto.
