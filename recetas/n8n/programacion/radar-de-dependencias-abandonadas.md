# Radar de dependencias abandonadas…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cada lunes revisa las librerías de tus proyectos y te avisa de las que llevan más de 18 meses sin actualizarse o han quedado sin mantenimiento, antes de que te den un susto.

## Qué es y qué hace

Cada lunes lee el package.json o requirements.txt de tus repositorios, consulta la fecha de la última versión publicada de cada dependencia en npm o PyPI y marca las que llevan más de 18 meses sin actualizarse o están archivadas. Se monta con n8n, Make o Zapier y necesita un token de GitHub de solo lectura.

## Cómo usarla

1. Crea el token de GitHub con permiso de lectura de contenido
2. Escribe la lista de repositorios
3. Conecta Sheets y Gmail
4. Revisa el primer informe antes de planificar cambios

## Cuándo usarla

Úsalo cuando tengas dos o más proyectos en producción con dependencias de npm o Python y nadie se encargue de vigilarlas.

## Cómo ganar dinero con ella

Evita migraciones de urgencia: detectar una librería muerta con meses de margen te ahorra días de refactor pagado a precio de bombero.

- Revisión de dependencias abandonadas para estudios con varios proyectos…
- Plan de migración de librerías como servicio trimestral…
- Informe de salud de proyectos para clientes con software a medida…

**Precio orientativo:** 60–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

### Qué hace y para quién
Lee el `package.json` (o `requirements.txt`) de tus repos, consulta la fecha de la última versión publicada de cada dependencia y marca las que llevan demasiado tiempo paradas o están archivadas.
Pensado para el desarrollador o el pequeño estudio que mantiene varios proyectos y no tiene tiempo de auditar dependencias a mano.

### Lo que necesitas antes
- Cuenta de n8n (auto-alojado con Docker o n8n Cloud, con prueba gratuita temporal y después de pago).
- Un token de GitHub: GitHub → Settings → Developer settings → Personal access tokens → Fine-grained, permiso `Contents: Read-only` sobre tus repos.
- Cuenta de Google para Sheets y Gmail (credencial OAuth2 de Google en n8n).
- El registro de npm (`registry.npmjs.org`) es público y no pide clave.

### Los nodos, en orden
1. **Schedule Trigger** — Mode: `Every Week`, Day: `Monday`, Hour: `8`, Minute: `0`. En Settings del workflow pon Timezone `Europe/Madrid`.
2. **Code** (nombre: «Lista de repos») — devuelve tus repos a mano, uno por item.
3. **HTTP Request** (nombre: «Bajar package.json») — Method `GET`, URL `https://api.github.com/repos/{{$json.repo}}/contents/package.json`, Authentication `Generic Credential Type` → `Header Auth` con nombre `Authorization` y valor `Bearer TU_TOKEN`. Añade header `Accept: application/vnd.github.raw`. En Settings del nodo activa `Always Output Data` y `Continue On Fail`.
4. **Code** (nombre: «Extraer dependencias») — parsea el JSON y saca un item por librería.
5. **Split In Batches** — Batch Size `20`. Así no bombardeas al registro.
6. **HTTP Request** (nombre: «Consultar npm») — `GET https://registry.npmjs.org/{{ encodeURIComponent($json.paquete) }}`, sin autenticación. En Settings: `Retry On Fail` activado, `Max Tries` 3, `Wait Between Tries` 2000 ms.
7. **Code** (nombre: «Calcular antigüedad») — calcula meses desde la última publicación y marca el riesgo.
8. **IF** — Condition: Number `{{$json.meses}}` `larger` `18`. Rama true sigue; rama false vuelve al Split In Batches.
9. **Google Sheets** — Operation `Append`, hoja «Dependencias en riesgo», columnas: fecha, repo, paquete, version_actual, ultima_publicacion, meses, deprecada.
10. **Gmail** — Operation `Send`, To tu correo, Subject `Radar de dependencias — {{$now.format('dd/MM/yyyy')}}`, mensaje con la lista de paquetes en riesgo.

### El código del nodo «Extraer dependencias»
```javascript
const raw = $input.first().json.data || $input.first().json;
const pkg = typeof raw === 'string' ? JSON.parse(raw) : raw;
const repo = $('Lista de repos').first().json.repo;
const todas = { ...(pkg.dependencies || {}), ...(pkg.devDependencies || {}) };
const salida = [];
for (const [paquete, version] of Object.entries(todas)) {
  if (version.startsWith('file:') || version.startsWith('link:')) continue;
  salida.push({ json: { repo, paquete, version_actual: version } });
}
return salida;
```

### El código del nodo «Calcular antigüedad»
```javascript
const d = $input.first().json;
const times = d.time || {};
const ultima = times[d['dist-tags'] && d['dist-tags'].latest] || times.modified;
const meses = ultima ? Math.round((Date.now() - new Date(ultima)) / 2592000000) : 999;
const deprecada = !!(d.versions && d['dist-tags'] && d.versions[d['dist-tags'].latest] && d.versions[d['dist-tags'].latest].deprecated);
return [{ json: { ...$('Consultar npm').first().json.__meta || {}, paquete: d.name, ultima_publicacion: ultima || 'desconocida', meses, deprecada } }];
```

### Cómo probarla
- Desconecta el Schedule Trigger y pulsa `Execute Workflow` a mano con un solo repo en la lista.
- Mete a propósito un paquete viejo conocido (por ejemplo `request`) y comprueba que sale marcado como deprecado.
- Revisa que la fila llega a Google Sheets antes de conectar el Gmail.

### Qué puede salir mal
- **429 del registro de npm**: baja el Batch Size a 10 y añade un nodo `Wait` de 2 segundos dentro del bucle.
- **Repos privados con 404**: el token fine-grained tiene que tener ese repositorio marcado explícitamente en «Repository access».
- **Monorepos**: el `package.json` de la raíz no lleva las dependencias reales; apunta la URL a `contents/apps/web/package.json`.
- **Zona horaria**: si el correo llega a las 10 en vez de a las 8, tienes el timezone del workflow en UTC.
- **Duplicados semana tras semana**: añade una columna `estado` en la hoja y filtra con un IF los paquetes que ya marcaste como «asumido».

### Cuánto cuesta
- n8n auto-alojado: 0 €. n8n Cloud (de pago tras la prueba gratuita): entra de sobra (4 ejecuciones al mes).
- npm Registry, GitHub API y Google Sheets: gratis en este volumen.
- Si pasas de 30 repos y quieres ejecutarlo a diario, el plan Starter de n8n Cloud ronda los 20-24 €/mes; con Docker en un VPS de 5 €/mes te sale más barato.
