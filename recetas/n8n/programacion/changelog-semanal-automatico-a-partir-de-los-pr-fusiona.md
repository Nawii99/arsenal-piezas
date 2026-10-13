# Changelog semanal automático a partir de los PR fusiona…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cada viernes recopila los pull requests fusionados de la semana, los ordena por tipo y redacta con IA un changelog en cristiano que te llega por email y se guarda en Google Docs.

## Qué es y qué hace

Cada viernes busca los pull requests fusionados de los últimos siete días, los agrupa por tipo (nuevo, arreglo, interno) y pide a un modelo de IA (Claude, Codex, Gemini o una IA local) un changelog en lenguaje no técnico. Lo envía por Gmail y lo guarda en Google Docs. Para productos con clientes que preguntan qué se ha hecho cada semana.

## Cómo usarla

1. Crear el token de GitHub de lectura
2. Crear la clave del modelo de IA
3. Conectar Gmail y Google Docs en n8n
4. Revisar el primer changelog

## Cuándo usarla

Cuando tienes clientes o compañeros que preguntan «¿qué habéis hecho esta semana?» y acabas escribiendo el resumen a mano cada viernes.

## Cómo ganar dinero con ella

Sustituye 30-45 minutos semanales de recopilar y redactar. Al año son unas 30 horas. El coste en IA no llega a 1 € al mes.

- Changelog semanal para SaaS pequeños que comunican avances a sus clientes.
- Resumen de cambios para equipos de desarrollo que informan a dirección cada viernes.
- Servicio de comunicación de producto que el desarrollador vende como parte del mantenimiento.

**Precio orientativo:** 60–150 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Busca los PR fusionados en los últimos 7 días, los agrupa por tipo (nuevo, arreglo, interno) y le pide a un modelo que escriba un changelog para gente no técnica.
Es para quien mantiene un producto con clientes y necesita comunicar avances sin repetir el ritual del viernes.

## Lo que necesitas antes
- Token de GitHub (github.com/settings/tokens, permiso de lectura sobre el repo o los repos).
- Clave de la API de Anthropic (console.anthropic.com > API Keys) o de OpenAI; el flujo es el mismo cambiando URL y cabeceras.
- Cuenta de Google para Docs y Gmail: en n8n, Credentials > Google OAuth2, siguiendo el asistente (hay que crear un proyecto en console.cloud.google.com y activar las APIs de Docs y Gmail).

## Los nodos, en orden
**1. Schedule Trigger** — Trigger Interval `Weeks`, Weeks Between Triggers 1, Trigger on Weekdays `Friday`, Trigger at Hour 17. Ojo: en Settings del workflow pon Timezone `Europe/Madrid`.
**2. Code** («Fecha de corte») — calcula la fecha de hace 7 días en formato `YYYY-MM-DD`.
**3. HTTP Request** («Buscar PR») — `GET` `https://api.github.com/search/issues`, Send Query Parameters activado, parámetro `q` con valor `repo:TU_USUARIO/TU_REPO is:pr is:merged merged:>={{ $json.desde }}` y parámetro `per_page` = `100`. Header Auth `Authorization: Bearer TU_TOKEN` y `User-Agent: n8n`.
**4. Code** («Ordenar por tipo») — clasifica por el prefijo del título o por las etiquetas.
**5. HTTP Request** («Redactar con IA») — `POST` `https://api.anthropic.com/v1/messages`. Headers: `x-api-key: TU_CLAVE`, `anthropic-version: 2023-06-01`, `content-type: application/json`. Body Content Type `JSON`, con el modelo, `max_tokens` 1500 y el prompt del apartado siguiente.
**6. Code** («Sacar el texto») — devuelve `$json.content[0].text`.
**7. Google Docs** — Operation `Update a Document` sobre un documento fijo que crees tú («Changelog»), acción `Insert` del texto al principio. Alternativa más simple: Operation `Create` con título `Changelog semana {{ $now.format('yyyy-MM-dd') }}`.
**8. Gmail** — Operation `Send`, To tu lista, Subject `Novedades de la semana`, Message el texto, Email Type `Text`.

## El código del nodo 2
```javascript
const d = new Date(Date.now() - 7*24*60*60*1000);
return [{ json: { desde: d.toISOString().slice(0,10) } }];
```

## El código del nodo 4
```javascript
const items = $input.first().json.items || [];
const grupos = { nuevo: [], arreglo: [], interno: [] };
for (const pr of items) {
  const t = pr.title.toLowerCase();
  if (t.startsWith('fix') || t.includes('bug')) grupos.arreglo.push(pr.title);
  else if (t.startsWith('chore') || t.startsWith('refactor') || t.startsWith('test')) grupos.interno.push(pr.title);
  else grupos.nuevo.push(pr.title);
}
const total = items.length;
return [{ json: { total, grupos: JSON.stringify(grupos, null, 2) } }];
```

## El cuerpo del nodo 5
```json
{ "model": "claude-sonnet-5-5", "max_tokens": 1500, "messages": [{"role":"user","content":"Eres redactor de producto. Con esta lista de pull requests fusionados esta semana, escribe un changelog en español de España para clientes NO técnicos. Tres secciones: Novedades, Mejoras y arreglos, Por dentro. Frases cortas, sin jerga, sin nombres de fichero. Si una sección queda vacía, omítela.\n\n{{ $json.grupos }}"}] }
```

## Cómo probarla
1. Ejecuta el workflow a mano con `Test workflow` un día cualquiera y mira el output del nodo 3: si sale `total_count: 0`, amplía el rango a 30 días para tener material.
2. Revisa el texto que devuelve la IA antes de conectar el Gmail; ajusta el prompt hasta que el tono te valga.
3. Solo entonces activa el Schedule.

## Qué puede salir mal
- **Búsqueda vacía**: la Search API de GitHub indexa con retraso de minutos y solo devuelve 100 resultados por página. Si tienes más, añade paginación con el parámetro `page`.
- **Límite estricto**: la Search API permite 30 consultas por minuto. Con una a la semana vas sobrado.
- **Zona horaria**: si no fijas `Europe/Madrid` en los ajustes del workflow, en verano se te dispara a las 19:00.
- **Repos privados**: el token necesita el permiso de lectura del repo concreto o no verás nada, y la API responde 200 con lista vacía en vez de error. Confunde mucho.
- **La IA se inventa cosas**: pásale solo títulos de PR, nunca le pidas que deduzca funcionalidades.

## Cuánto cuesta
GitHub y Google gratis. La llamada a la IA cuesta unos céntimos por ejecución: menos de 1 € al mes. n8n auto-alojado gratis; en Cloud, este flujo consume 1 ejecución semanal.
