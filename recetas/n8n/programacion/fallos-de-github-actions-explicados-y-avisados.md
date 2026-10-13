# Fallos de GitHub Actions explicados y avisados…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cuando un workflow de GitHub Actions falla, descarga el log, extrae el error de verdad, lo explica en llano y te lo manda con la posible causa y el arreglo.

## Qué es y qué hace

Cuando una ejecución de GitHub Actions falla, descarga los logs del job, se queda con las líneas del error, las envía a un modelo de IA que explica en dos frases qué ha pasado y qué probar, y lo manda a Telegram con el enlace al log. Se monta con n8n, Make o Zapier y necesita un token de GitHub con permiso de Actions.

## Cómo usarla

1. Crea el token de GitHub con lectura de Actions
2. Configura el webhook de ejecuciones fallidas
3. Añade la clave del modelo de IA
4. Provoca un fallo de prueba y revisa el resumen

## Cuándo usarla

Cuando recibas emails de «Run failed» de GitHub que no dicen nada y tengas que abrir el navegador y leer 2.000 líneas de log para saber qué pasó.

## Cómo ganar dinero con ella

Cortas 15-20 minutos de diagnóstico por fallo. Con 10 fallos al mes son 3 horas recuperadas por menos de 1 € de IA.

- Diagnóstico de fallos de CI para equipos que pierden tiempo en logs…
- Seguimiento de tests inestables como servicio mensual para agencias…
- Configuración de alertas de despliegue para proyectos con Actions…

**Precio orientativo:** 60–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Cuando una ejecución de GitHub Actions termina en fallo, esta automatización descarga los logs del job que falló, se queda con las líneas relevantes, se las pasa a una IA para que diga en dos frases qué ha pasado y qué probar, y te lo manda por Telegram con el enlace directo al log.
Para desarrolladores con tests o despliegues en Actions que se cansan de abrir el navegador para descubrir que era un test flaky.
## Lo que necesitas antes
- Token de GitHub con permisos de lectura de `Actions` y `Metadata` (fine-grained token).
- Clave de API de OpenAI.
- n8n accesible desde internet y un bot de Telegram.
## Los nodos, en orden
1) **Webhook**: POST, path `actions-fallo`. En el repo: Settings > Webhooks, marca solo el evento «Workflow runs».
2) **IF**: dos condiciones con AND. String `{{ $json.body.action }}` «is equal to» `completed`; String `{{ $json.body.workflow_run.conclusion }}` «is equal to» `failure`.
3) **HTTP Request** (listar jobs): GET `{{ $json.body.workflow_run.jobs_url }}`, Header Auth `Authorization: Bearer TU_TOKEN`, cabecera `Accept: application/vnd.github+json`.
4) **Code** (quedarse con el job fallido):
```javascript
const jobs = $json.jobs || [];
const malo = jobs.find(j => j.conclusion === 'failure');
if (!malo) return [];
const paso = (malo.steps || []).find(s => s.conclusion === 'failure');
return [{ json: { jobId: malo.id, jobNombre: malo.name, paso: paso ? paso.name : 'desconocido', url: malo.html_url, repo: $('Webhook').first().json.body.repository.full_name, rama: $('Webhook').first().json.body.workflow_run.head_branch } }];
```
5) **HTTP Request** (descargar el log): GET `https://api.github.com/repos/{{ $json.repo }}/actions/jobs/{{ $json.jobId }}/logs`, Header Auth con el token. En Options > Response, Format `Text`. GitHub responde con una redirección a un fichero de texto; deja activado «Follow Redirects».
6) **Code** (quedarse con lo importante del log):
```javascript
const lineas = ($json.data || '').split('\n');
const idx = lineas.findIndex(l => /(error|failed|Error:|npm ERR!|Traceback|exit code [1-9])/i.test(l));
const desde = Math.max(0, (idx === -1 ? lineas.length - 60 : idx - 15));
const trozo = lineas.slice(desde, desde + 80).join('\n').slice(0, 6000);
return [{ json: { trozo, ...$('Code').first().json } }];
```
7) **HTTP Request** (IA): POST `https://api.openai.com/v1/chat/completions`, Header Auth. Body:
```json
{ "model": "gpt-4o-mini", "messages": [{"role": "user", "content": "Este es el final del log de un job fallido de GitHub Actions (paso '{{ $json.paso }}'). En español de España y en 3 líneas máximo: 1) qué ha fallado exactamente, 2) causa más probable, 3) qué probar primero. Nada de rodeos.\n\n{{ $json.trozo }}"}] }
```
8) **Telegram**: Parse Mode `HTML`, Text:
`<b>🔴 Actions falló</b>\n{{ $('Code1').item.json.repo }} · rama {{ $('Code1').item.json.rama }}\nJob: {{ $('Code1').item.json.jobNombre }} → paso <i>{{ $('Code1').item.json.paso }}</i>\n\n{{ $json.choices[0].message.content }}\n\n<a href="{{ $('Code1').item.json.url }}">Ver el log completo</a>`
## Cómo probarla
- Rompe un test a propósito en una rama de pruebas y haz push. Debe llegarte el aviso en menos de un minuto tras terminar el job.
- Prueba con un fallo de instalación de dependencias y con un fallo de test: el recorte del log debe capturar bien ambos.
- Comprueba que un workflow que termina en éxito NO dispara nada.
## Qué puede salir mal
- **Logs enormes**: algunos jobs generan megas. El recorte a 80 líneas alrededor del primer error es lo que hace esto barato; no lo quites.
- **Descarga del log vacía**: si el token no tiene permiso de `Actions` recibirás un 403. Revisa el token fine-grained.
- **Muchos fallos seguidos**: si un workflow falla en bucle, te llenará Telegram. Añade un **Code** que descarte si ya avisaste del mismo `workflow_run.id` en los últimos 10 minutos usando un Google Sheets o el nodo de almacenamiento estático.
- **Jobs de matriz**: si tienes matrix builds, fallarán varios a la vez. En el paso 4 quédate solo con el primero (`find`, como está) o agrupa el mensaje.
## Cuánto cuesta
- GitHub Actions: 2.000 minutos gratis al mes en repos privados; ilimitado en públicos.
- OpenAI gpt-4o-mini: unos 0,003 € por aviso.
- n8n auto-alojado y Telegram: gratis.
