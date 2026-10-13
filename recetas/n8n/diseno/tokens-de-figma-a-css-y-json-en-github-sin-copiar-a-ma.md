# Tokens de Figma a CSS y JSON en GitHub, sin copiar a ma…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Lee las variables de color, texto y espaciado de tu archivo de Figma y sube automáticamente un CSS y un JSON al repositorio del desarrollador cuando algo cambia.

## Qué es y qué hace

Cada noche lee las variables de color, texto y espaciado de un archivo de Figma mediante su API, las convierte en un tokens.css con variables CSS y un tokens.json, y los sube al repositorio solo si han cambiado. Sirve para que el diseño y el código no se desincronicen. Se monta con n8n, Make o Zapier y necesita un token personal de Figma.

## Cómo usarla

1. Crea variables en tu archivo de Figma
2. Genera un token personal de Figma con permiso de lectura
3. Conecta GitHub en n8n
4. Ejecuta una vez y revisa el commit generado

## Cuándo usarla

Cuando trabajas con un programador y los colores de la marca se desincronizan entre el diseño y el código, o cada retoque te obliga a mandar un correo con la lista.

## Cómo ganar dinero con ella

Elimina el «esto no es el azul bueno» de cada revisión: entre 1 y 2 horas por sprint de idas y venidas, y evita rediseñar pantallas ya publicadas.

- Sincronización de tokens de diseño entre Figma y el repositorio del cliente…
- Mantenimiento mensual del sistema de diseño para equipos de producto…
- Configuración inicial de tokens como servicio para startups con web propia…

**Precio orientativo:** 200–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada noche pregunta a la API de Figma por las variables (tokens) de tu archivo de sistema de diseño, las convierte en un fichero `tokens.css` con variables CSS y un `tokens.json`, y los sube al repositorio solo si han cambiado.
Es para el diseñador que mantiene la identidad y trabaja con desarrolladores, sin tener que aprender Git ni instalar nada en el ordenador.
## Lo que necesitas antes
Un archivo de Figma con Variables creadas (Local variables, colecciones tipo `color`, `spacing`, `radius`). Ojo: leer variables por API requiere plan Figma Enterprise; si estás en gratuito o Professional, usa en su lugar los Estilos con el endpoint `/v1/files/:key/styles` y adapta el Code.
Un token personal de Figma: figma.com > tu avatar > Settings > Security > Personal access tokens > Generate new token, con permiso de lectura de file content y variables. Cópialo, solo se ve una vez.
La clave del archivo: está en la URL `figma.com/design/CLAVE/nombre`.
Una cuenta de GitHub y un token: github.com > Settings > Developer settings > Personal access tokens > Fine-grained token, con permiso `Contents: Read and write` sobre el repositorio.
En n8n, credencial «GitHub API» con ese token, y credencial «Header Auth» con Name `X-Figma-Token` y Value tu token de Figma.
## Los nodos, en orden
**1. «Schedule Trigger»** — Interval: Days, Trigger at Hour 3.
**2. «HTTP Request»** (nómbralo Figma Variables) — Method GET, URL `https://api.figma.com/v1/files/TU_CLAVE/variables/local`, Authentication: Generic Credential Type > Header Auth > tu credencial. Response Format: JSON.
**3. «Code»** — Mode: Run Once for All Items. Convierte la respuesta en CSS y JSON (código abajo).
**4. «GitHub»** (nómbralo Leer actual) — Resource: File, Operation: Get, Repository Owner y Name los tuyos, File Path `tokens/tokens.css`. En Settings del nodo activa «Continue On Fail» para que no reviente la primera vez, cuando el archivo aún no existe.
**5. «IF»** — Condition String: `{{ $json.content ? Buffer.from($json.content,'base64').toString() : '' }}` > is not equal to > `{{ $('Code').first().json.css }}`. Solo sigue si hay cambios reales.
**6. «GitHub»** (rama true) — Resource: File, Operation: Create or Edit (Edit si existe), File Path `tokens/tokens.css`, File Content `{{ $('Code').first().json.css }}`, Commit Message `Actualiza tokens desde Figma`.
**7. «Slack»** — Operation: Send Message, canal `#diseno`, Text: `Tokens actualizados: {{ $('Code').first().json.total }} variables. Revisad el repo.`
## El trozo de código (nodo «Code»)
```javascript
const data = $input.first().json.meta;
const vars = Object.values(data.variables || {});
const cols = data.variableCollections || {};
function toHex(c){ const n = x => Math.round(x*255).toString(16).padStart(2,'0'); return '#' + n(c.r) + n(c.g) + n(c.b); }
const lineas = [];
const json = {};
for (const v of vars) {
  if (v.remote) continue;
  const col = cols[v.variableCollectionId];
  const modoId = col ? col.defaultModeId : Object.keys(v.valuesByMode)[0];
  const val = v.valuesByMode[modoId];
  if (val && typeof val === 'object' && 'r' in val) {
    const nombre = '--' + v.name.toLowerCase().replace(/[^a-z0-9]+/g,'-').replace(/^-|-$/g,'');
    lineas.push(`  ${nombre}: ${toHex(val)};`);
    json[nombre] = toHex(val);
  } else if (typeof val === 'number') {
    const nombre = '--' + v.name.toLowerCase().replace(/[^a-z0-9]+/g,'-').replace(/^-|-$/g,'');
    lineas.push(`  ${nombre}: ${val}px;`);
    json[nombre] = val + 'px';
  }
}
lineas.sort();
const css = '/* Generado automaticamente desde Figma. No editar a mano. */\n:root {\n' + lineas.join('\n') + '\n}\n';
return [{ json: { css, json: JSON.stringify(json, null, 2), total: lineas.length } }];
```
## Cómo probarla
Ejecuta a mano solo el nodo HTTP Request y mira que devuelve `meta.variables`. Si da 403, tu plan de Figma no permite variables por API: cambia al endpoint de estilos.
Ejecuta hasta el Code y lee el CSS generado en el panel. Cambia un color en Figma, vuelve a ejecutar y comprueba que el IF ahora sí deja pasar.
## Qué puede salir mal
Nombres de variables con barras (`color/primario/hover`) generan `--color-primario-hover`: acuerda esa nomenclatura con el desarrollador antes de soltarlo.
La API de Figma limita las peticiones; con una al día no te acercas al tope.
Si el archivo `tokens.css` no existe, el nodo GitHub Get falla: por eso lleva «Continue On Fail» y la primera vez usa la operación Create.
Las variables con alias (una que apunta a otra) llegan como `{type:'VARIABLE_ALIAS'}` y el código las salta; resuélvelas manualmente o amplía el Code si las usas mucho.
## Cuánto cuesta
n8n gratis, GitHub gratis (repositorios privados incluidos), Slack gratis. La única pega es que las variables por API piden Figma Enterprise; con la variante de estilos funciona en el plan gratuito.
