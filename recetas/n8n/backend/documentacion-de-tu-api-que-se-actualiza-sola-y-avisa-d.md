# Documentación de tu API que se actualiza sola y avisa d…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Lee tu especificación OpenAPI, la compara con la anterior y publica una página de documentación actualizada, avisando si has roto algo que tus clientes usaban.

## Qué es y qué hace

Cuando cambias openapi.yaml en tu repositorio, n8n descarga la especificación, la compara con la guardada y detecta cambios que rompen (endpoints borrados, parámetros obligatorios, campos quitados). Genera una documentación HTML con Redoc, la publica en GitHub Pages y envía a Slack un resumen. Entrada: especificación OpenAPI; salida: web publicada y aviso.

## Cómo usarla

1. Genera el openapi.yaml con tu framework
2. Crea el repositorio docs-api con Pages
3. Crea el token de solo lectura
4. Prueba con un cambio rompedor de ensayo

## Cuándo usarla

Cuando tengas una API que use más gente que tú, hayas roto integraciones sin querer alguna vez, o pierdas tiempo explicando por WhatsApp cómo se llama un campo.

## Cómo ganar dinero con ella

Sustituye herramientas tipo Stoplight, Readme.io o Bump.sh (de 30 a 100 euros al mes) y evita las horas de soporte que genera cada cambio no comunicado.

- Documentación de API para startups con clientes que integran su producto.
- Changelog automático para equipos que mantienen una API pública o de socios.
- Mantenimiento de documentación técnica para agencias que entregan APIs a clientes.

**Precio orientativo:** 150–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cuando cambias el fichero `openapi.yaml` en tu repositorio, n8n se lo descarga, lo compara con la versión guardada y detecta cambios que rompen: endpoints eliminados, parámetros que pasan a obligatorios, campos borrados de una respuesta o tipos cambiados.
Genera una página HTML de documentación (con Redoc, que es un solo fichero) y la publica, y manda a Slack un resumen tipo "3 cambios nuevos, 1 rompedor" con la lista concreta.

## Lo que necesitas antes
- Un fichero `openapi.yaml` u `openapi.json` en tu repositorio. Si no lo tienes, casi cualquier framework lo genera solo (FastAPI, NestJS con Swagger, Laravel con Scribe).
- n8n con URL pública.
- Token de GitHub de solo lectura sobre contenidos.
- Un sitio donde publicar: lo más fácil es un repositorio `docs-api` con GitHub Pages activado (Settings, Pages, source: rama main, carpeta /root). Gratis y con HTTPS.
- Webhook entrante de Slack.
- Una tabla o una hoja donde guardar la última versión del spec para comparar. Uso Google Sheets aquí por simpleza: hoja "API specs" con columnas version, fecha, json.

## Los nodos, en orden
1. **GitHub Trigger** — Events: `push`, sobre tu repositorio.
2. **Code** (nombre: ¿Cambió el spec?) — mira si `openapi.yaml` está entre los ficheros modificados del push.
3. **IF** — `={{ $json.cambio }}` is true.
4. **HTTP Request** (nombre: Bajar spec) — GET `=https://raw.githubusercontent.com/{{ $json.repo }}/main/openapi.yaml`, con Authentication: Generic > Header Auth con una credencial de n8n (Name `Authorization`, Value `Bearer TU_TOKEN`), Response Format: Text. No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él.
5. **Code** (nombre: Parsear YAML) — convierte YAML a objeto. n8n trae `js-yaml` disponible en el nodo Code auto-alojado; si estás en Cloud, guarda el spec en JSON en vez de YAML y usa `JSON.parse`.
6. **Google Sheets** (nombre: Spec anterior) — Get Row(s), última fila.
7. **Code** (nombre: Comparar) — el detector de cambios rotos. Código abajo.
8. **HTTP Request** (nombre: Generar HTML) — no hace falta llamar a nadie: usa un nodo **Code** que devuelva la plantilla de Redoc con el spec incrustado.
9. **GitHub** (nombre: Publicar) — Resource: File, Operation: Create/Update, Repository: docs-api, File Path: `index.html`, File Content: `={{ $json.html }}`, Commit Message: `=docs: actualiza a {{ $json.version }}`.
10. **Google Sheets** (nombre: Guardar spec) — Append Row con la versión nueva.
11. **Slack** — mensaje con el resumen y el enlace a la documentación.
12. **IF** (nombre: ¿Rompedor?) — si hay cambios rompedores, un segundo **Slack** al canal de avisos con `@here` y la lista.

## El código del nodo "Parsear YAML"
```javascript
const yaml = require('js-yaml');
const texto = $json.data || $json.body || '';
const spec = yaml.load(texto);
return [{ json: { spec, version: spec.info?.version || '0.0.0', titulo: spec.info?.title || 'API' } }];
```

## El código del nodo "Comparar"
```javascript
const nuevo = $('Parsear YAML').first().json.spec;
const filaAnt = $('Spec anterior').all().slice(-1)[0]?.json;
const viejo = filaAnt ? JSON.parse(filaAnt.json) : { paths: {} };
const rotos = [], nuevos = [], cambios = [];
const rutas = new Set([...Object.keys(viejo.paths || {}), ...Object.keys(nuevo.paths || {})]);
for (const ruta of rutas) {
  const v = (viejo.paths || {})[ruta], n = (nuevo.paths || {})[ruta];
  if (v && !n) { rotos.push('❌ Eliminado el endpoint ' + ruta); continue; }
  if (!v && n) { nuevos.push('🆕 Nuevo endpoint ' + ruta); continue; }
  for (const metodo of new Set([...Object.keys(v), ...Object.keys(n)])) {
    if (v[metodo] && !n[metodo]) { rotos.push('❌ Eliminado ' + metodo.toUpperCase() + ' ' + ruta); continue; }
    if (!v[metodo] && n[metodo]) { nuevos.push('🆕 ' + metodo.toUpperCase() + ' ' + ruta); continue; }
    const pv = (v[metodo].parameters || []), pn = (n[metodo].parameters || []);
    for (const p of pn) {
      const antes = pv.find(x => x.name === p.name);
      if (!antes && p.required) rotos.push('❌ Nuevo parámetro obligatorio "' + p.name + '" en ' + metodo.toUpperCase() + ' ' + ruta);
      if (antes && !antes.required && p.required) rotos.push('❌ "' + p.name + '" pasa a obligatorio en ' + metodo.toUpperCase() + ' ' + ruta);
      if (antes && antes.schema?.type !== p.schema?.type) cambios.push('⚠️ Cambia el tipo de "' + p.name + '" en ' + ruta);
    }
    for (const p of pv) if (!pn.find(x => x.name === p.name)) rotos.push('❌ Eliminado el parámetro "' + p.name + '" en ' + metodo.toUpperCase() + ' ' + ruta);
  }
}
const resumen = [...rotos, ...nuevos, ...cambios].join('\n') || 'Sin cambios relevantes';
return [{ json: { rotos: rotos.length, nuevos: nuevos.length, resumen, hay_rotos: rotos.length > 0, spec: nuevo, version: nuevo.info?.version } }];
```

## El código del nodo que genera el HTML
```javascript
const spec = $json.spec;
const html = '<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"><title>' + (spec.info?.title || 'API') + '</title><meta name="viewport" content="width=device-width,initial-scale=1"><style>body{margin:0}</style></head><body><div id="redoc"></div><script src="https://cdn.redoc.ly/redoc/latest/bundles/redoc.standalone.js"></script><script>Redoc.init(' + JSON.stringify(spec) + ', {hideDownloadButton:false, theme:{colors:{primary:{main:"#111"}}}}, document.getElementById("redoc"));</script></body></html>';
return [{ json: { html, version: spec.info?.version } }];
```

## Cómo probarla
- Sube un cambio inofensivo al spec (añadir una descripción): debe publicarse la doc y llegar un Slack sin avisos rojos.
- Marca un parámetro opcional como `required: true` y sube: tiene que saltar el aviso de cambio rompedor con el nombre exacto del parámetro.
- Abre la URL de GitHub Pages y comprueba que Redoc carga y se ve el nuevo endpoint.

## Qué puede salir mal
- **js-yaml no está disponible**: en n8n Cloud los módulos externos están capados. Solución: guarda el spec como JSON en el repositorio, o añade `NODE_FUNCTION_ALLOW_EXTERNAL=js-yaml` a las variables de entorno de tu n8n auto-alojado.
- **GitHub Pages tarda**: hasta 2 minutos en reflejar el cambio. No te asustes si al abrir enseguida ves la versión anterior.
- **El comparador es simple a propósito**: no mira dentro de los `$ref` ni de los esquemas anidados. Para el 90% de los cambios que rompen (endpoints y parámetros) es suficiente; si necesitas más, existe la librería `oasdiff` que puedes llamar desde un nodo Execute Command.
- **Celda de Sheets demasiado grande**: una celda aguanta 50.000 caracteres. Si tu spec es mayor, guárdalo en una tabla Postgres con columna TEXT o en un fichero de Drive.
- **Cambios que rompen y ya has desplegado**: este flujo avisa después, no antes. Para avisar antes, dispara el mismo análisis desde un Pull Request en vez de desde el push a main.

## Cuánto cuesta
- Gratis del todo: GitHub y GitHub Pages, Redoc (versión open source por CDN), n8n auto-alojado, Slack gratuito.
- Alternativa de pago que evitas: plataformas de documentación de API desde 30 euros al mes.
