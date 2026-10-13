# Diario de cambios de tu API a partir del OpenAPI…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Compara cada día la especificación de tu API con la de ayer y escribe solo el changelog, marcando en rojo los cambios que romperían a quien la consume.

## Qué es y qué hace

Cada noche descarga el openapi.json de tu API y lo compara con la versión guardada en Drive. Genera un resumen legible con rutas nuevas, rutas eliminadas, parámetros que pasan a obligatorios y campos de respuesta que desaparecen, marcando los cambios que rompen. Entrada: especificación JSON; salida: changelog en hoja y aviso en Slack. Se monta en n8n.

## Cómo usarla

1. Confirma que tu API sirve openapi.json
2. Crea la carpeta de snapshots en Drive
3. Crea la hoja changelog_api
4. Activa el aviso en Slack

## Cuándo usarla

Úsalo cuando tienes una API que usan una app móvil, un cliente o un socio, y los cambios se comunican por WhatsApp o directamente no se comunican.

## Cómo ganar dinero con ella

Evita integraciones rotas y las llamadas de soporte que traen. Y te quita escribir el changelog a mano: 1-2 h por versión.

- Changelog automático para equipos con una API que usan socios o clientes.
- Control de cambios para startups que publican versiones de API cada mes.
- Documentación de versiones para agencias que entregan APIs a sus clientes.

**Precio orientativo:** 80–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Descarga cada noche el `openapi.json` de tu API, lo compara con la foto del día anterior guardada en Drive y genera un resumen legible: rutas nuevas, rutas eliminadas, parámetros que pasan a ser obligatorios, campos de respuesta que desaparecen. Marca los cambios rompedores y los publica en Slack y en una hoja de changelog. Para quien mantiene una API que otros usan.
**Lo que necesitas antes**
- n8n.
- Que tu API sirva su especificación en JSON. Casi todos los frameworks lo hacen: FastAPI en `/openapi.json`, NestJS con Swagger en `/api-json`, Laravel con L5-Swagger. Si no la tienes, esta receta es la excusa para generarla.
- Credenciales de Google Drive y Google Sheets en n8n.
- Una carpeta en Drive `API/snapshots` (apunta su ID) y una hoja `changelog_api` con columnas `fecha`, `version`, `rompedores`, `resumen`.
- Un webhook entrante de Slack.
**Los nodos, en orden**
1. `Schedule Trigger` — Days, Hour `6`.
2. `HTTP Request` — GET `https://tu-api.com/openapi.json`, Response Format `JSON`, `Retry On Fail` 3 intentos.
3. `Google Drive` — Operation `Search Files and Folders`, en la carpeta de snapshots, Query String `openapi_ultimo.json`. Activa `Always Output Data`.
4. `IF` — `={{ $json.id }}` `is not empty`.
5. Rama true > `Google Drive` — Operation `Download`, File `={{ $json.id }}`, y detrás `Extract from File` — Operation `Move File to JSON` (campo binario `data`) para poder leerlo.
6. `Code` (*Comparar*) — Mode `Run Once for All Items`. Junta el nuevo y el viejo:
```js
const nuevo = $('HTTP Request').first().json;
let viejo = null;
try { viejo = $input.first().json.data || $input.first().json; } catch (e) { viejo = null; }
if (!viejo || !viejo.paths) return [{ json: { primera_vez: true, resumen: 'Primera foto guardada', rompedores: 0, version: nuevo.info?.version || '?' } }];
const rutasN = new Set(); const rutasV = new Set();
const detalleN = {}; const detalleV = {};
for (const [ruta, metodos] of Object.entries(nuevo.paths)) for (const m of Object.keys(metodos)) { const k = m.toUpperCase() + ' ' + ruta; rutasN.add(k); detalleN[k] = metodos[m]; }
for (const [ruta, metodos] of Object.entries(viejo.paths)) for (const m of Object.keys(metodos)) { const k = m.toUpperCase() + ' ' + ruta; rutasV.add(k); detalleV[k] = metodos[m]; }
const nuevas = [...rutasN].filter(k => !rutasV.has(k));
const borradas = [...rutasV].filter(k => !rutasN.has(k));
const obligatorios = [];
for (const k of [...rutasN].filter(x => rutasV.has(x))) {
  const oN = (detalleN[k].parameters || []).filter(p => p.required).map(p => p.name);
  const oV = (detalleV[k].parameters || []).filter(p => p.required).map(p => p.name);
  const anadidos = oN.filter(p => !oV.includes(p));
  if (anadidos.length) obligatorios.push(k + ' exige ahora: ' + anadidos.join(', '));
}
const lineas = [];
if (nuevas.length) lineas.push('NUEVAS RUTAS: ' + nuevas.join(', '));
if (borradas.length) lineas.push('🚨 RUTAS ELIMINADAS: ' + borradas.join(', '));
if (obligatorios.length) lineas.push('🚨 PARÁMETROS AHORA OBLIGATORIOS: ' + obligatorios.join(' · '));
const rompedores = borradas.length + obligatorios.length;
return [{ json: { primera_vez: false, hay_cambios: lineas.length > 0, rompedores, resumen: lineas.join('\n') || 'Sin cambios', version: nuevo.info?.version || '?' } }];
```
7. `IF` — `={{ $json.hay_cambios }}` `is true`.
8. Rama true > `Google Sheets` — `Append` en `changelog_api`: `fecha` = `={{ $now.setZone('Europe/Madrid').toFormat('dd/MM/yyyy') }}`, `version`, `rompedores`, `resumen`.
9. Detrás > `HTTP Request` al webhook de Slack, Body `={{ JSON.stringify({ text: (($json.rompedores > 0) ? '🚨 CAMBIOS ROMPEDORES en la API v' : '📘 Cambios en la API v') + $json.version + '\n' + $json.resumen }) }}`.
10. `Convert to File` — Operation `Convert to JSON`, con `={{ JSON.stringify($('HTTP Request').first().json) }}`, y detrás `Google Drive` — Operation `Upload`, File Name `openapi_ultimo.json`, carpeta de snapshots, y en Options `Overwrite` o borra antes el anterior. Guarda también una copia fechada: `openapi_{{ $now.toFormat('yyyyMMdd') }}.json` para tener historia.
**Cómo probarla**
- Ejecuta una vez: dirá `primera foto` y guardará el archivo en Drive.
- Descarga el JSON de Drive, bórrale una ruta a mano, súbelo de nuevo con el mismo nombre y ejecuta: debe avisar de `RUTAS ELIMINADAS` con el emoji de alarma.
- Añade un parámetro `required` en tu API en local y apunta la URL ahí para ver el aviso de parámetro obligatorio.
**Qué puede salir mal**
- *Tu API no expone OpenAPI*: entonces genera el JSON en tu proceso de despliegue y súbelo a una URL, o guárdalo en el repositorio y léelo con el nodo `GitHub` > `File` > `Get`.
- *Ruido por reordenación*: comparar textos completos daría falsos positivos; por eso aquí se comparan conjuntos de rutas y parámetros, no el texto.
- *Cambios en el cuerpo de las respuestas*: esta versión no los mira. Para ampliarlo, compara también `responses['200'].content['application/json'].schema.properties` de cada ruta con la misma lógica de conjuntos.
- *Drive y archivos con el mismo nombre*: Drive permite duplicados. Usa `Update File` sobre el ID conocido o borra el anterior antes de subir, o acabarás comparando con una foto vieja.
- *Despliegues varios al día*: si publicas a menudo, pasa de Schedule diario a un `Webhook` que llames desde tu CI al terminar el despliegue.
**Cuánto cuesta**
Gratis: una ejecución diaria en n8n auto-alojado, Drive y Sheets de una cuenta normal, Slack gratuito. Herramientas comerciales de diff de OpenAPI (Bump.sh, Optic) empiezan en 30-50 €/mes.
