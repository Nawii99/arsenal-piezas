# Aviso semanal de dependencias con vulnerabilidades…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cada lunes revisa las dependencias de tus proyectos contra la base pública de vulnerabilidades OSV y te manda solo las que de verdad tienes que actualizar.

## Qué es y qué hace

Cada lunes descarga el package.json o requirements.txt de cada repositorio y consulta la API pública de OSV.dev, que no pide registro ni clave. Publica en Slack solo las dependencias con vulnerabilidades conocidas, con su gravedad y la versión que la corrige. Se monta con n8n, Make o Zapier y necesita un token de lectura de GitHub.

## Cómo usarla

1. Crea un token de GitHub de solo lectura
2. Escribe la lista de repositorios a revisar
3. Crea un webhook entrante de Slack
4. Ejecuta y revisa el primer informe
5. Que lo revise un profesional

## Cuándo usarla

Cuando mantengas varios proyectos con package.json o requirements.txt y no tengas ni idea de cuáles arrastran una librería con un agujero conocido.

## Cómo ganar dinero con ella

Un sitio comprometido por una librería vieja son días de trabajo y confianza perdida. Snyk equivalente cuesta desde 25 €/mes; esto es gratis.

- Revisión semanal de dependencias para agencias con proyectos de clientes en producción…
- Auditoría básica de paquetes como servicio mensual para desarrolladores…
- Plan de actualización de librerías para webs con más de dos años…

**Precio orientativo:** 60–150 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Los lunes descarga el `package.json` (o `requirements.txt`) de cada repo, consulta la API pública de OSV.dev (la base de datos de vulnerabilidades de Google, sin registro ni clave) y publica en Slack solo las dependencias con vulnerabilidad conocida, con su gravedad y la versión que la corrige.
Para el freelance o la agencia con 5-20 proyectos vivos que no puede revisarlos uno a uno.
## Lo que necesitas antes
- Token de GitHub con lectura de `Contents` en los repos.
- Nada más: la API de OSV.dev es abierta y gratuita, sin registro.
- Un webhook entrante de Slack (api.slack.com/apps > Incoming Webhooks) o el nodo Slack con bot token.
## Los nodos, en orden
1) **Schedule Trigger**: Cron `0 9 * * 1`, Timezone `Europe/Madrid`.
2) **Code**: lista de repos a revisar.
```javascript
return ['miempresa/web-a', 'miempresa/api-b', 'miempresa/panel-c'].map(r => ({ json: { repo: r } }));
```
3) **HTTP Request**: GET `https://api.github.com/repos/{{ $json.repo }}/contents/package.json`, Header Auth `Authorization: Bearer TU_TOKEN` y cabecera `Accept: application/vnd.github.raw`. En Settings marca «Continue On Fail» (habrá repos sin package.json).
4) **Code** (extraer paquetes y versiones limpias):
```javascript
const salida = [];
for (const item of $input.all()) {
  let pkg;
  try { pkg = typeof item.json.data === 'string' ? JSON.parse(item.json.data) : item.json; } catch (e) { continue; }
  const deps = { ...(pkg.dependencies || {}), ...(pkg.devDependencies || {}) };
  for (const [nombre, v] of Object.entries(deps)) {
    const version = String(v).replace(/[\^~>=<\s]/g, '');
    if (!/^\d/.test(version)) continue;
    salida.push({ json: { nombre, version, repo: item.json.repo || 'repo' } });
  }
}
return salida;
```
5) **Split In Batches**: Batch Size 1, para consultar OSV paquete a paquete sin saturar.
6) **HTTP Request** (OSV): POST `https://api.osv.dev/v1/query`, sin autenticación. Body JSON:
```json
{ "version": "{{ $json.version }}", "package": { "name": "{{ $json.nombre }}", "ecosystem": "npm" } }
```
7) **IF**: comprueba que hay vulnerabilidades. Number, valor 1 `{{ ($json.vulns || []).length }}`, «larger», valor 2 `0`.
8) **Code** (formatear hallazgos):
```javascript
const v = $json.vulns[0];
const info = $('Split In Batches').item.json;
const grav = (v.database_specific || {}).severity || (v.severity || [{}])[0].score || 'desconocida';
const arregla = ((v.affected || [])[0]?.ranges || [])[0]?.events?.find(e => e.fixed)?.fixed || 'sin versión corregida';
return [{ json: { texto: `⚠️ *${info.repo}* · \`${info.nombre}@${info.version}\` · ${v.id} · gravedad ${grav} · arregla en ${arregla}` } }];
```
9) **Slack**: Operation `Send`, canal `#seguridad`, Text `{{ $json.texto }}`. Si prefieres un solo mensaje, mete un nodo **Aggregate** antes y junta los textos.
## Cómo probarla
- Prueba primero con un paquete que sepas vulnerable, por ejemplo `lodash@4.17.11`, poniéndolo a mano en el Code. Tiene que devolver resultados.
- Ejecuta contra un repo real y comprueba que los paquetes sin problemas NO generan mensaje.
- Compara la salida con `npm audit` en local: los resultados deben parecerse.
## Qué puede salir mal
- **Versiones con `^` o `~`**: el Code las limpia, pero eso significa que revisas la versión mínima, no la instalada. Para exactitud usa el `package-lock.json` (ajusta el Code para leer `packages` en vez de `dependencies`).
- **Otros lenguajes**: cambia `ecosystem` a `PyPI`, `Packagist`, `Go` o `RubyGems` y lee el fichero correspondiente.
- **Muchas peticiones**: con 20 repos y 40 dependencias son 800 llamadas. OSV aguanta, pero mete un **Wait** de 200 ms dentro del bucle para ir con educación.
- **Ruido**: si te llegan 50 avisos de devDependencies, filtra en el paso 4 quedándote solo con `dependencies`.
## Cuánto cuesta
- OSV.dev: gratis y sin registro. GitHub y Slack: gratis.
- n8n auto-alojado: gratis. Alternativa de pago: Snyk Team desde unos 25 €/mes por desarrollador.
