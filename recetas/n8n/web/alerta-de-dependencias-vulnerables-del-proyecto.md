# Alerta de dependencias vulnerables del proyecto…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Revisa cada semana las librerías de tus proyectos contra la base pública de vulnerabilidades y te dice cuáles hay que actualizar y con qué urgencia.

## Qué es y qué hace

Cada viernes lee el package.json de cada repositorio de tu lista desde GitHub, consulta por paquete y versión la API pública de OSV.dev y envía a Slack un resumen ordenado por gravedad, con la librería, la versión afectada y la versión que corrige el problema. OSV.dev no necesita clave. Para desarrolladores que entregan webs a medida.

## Cómo usarla

1. Crear el token de GitHub de solo lectura
2. Preparar la hoja Proyectos con repo y rama
3. Conectar Slack en n8n
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando mantienes webs a medida o proyectos Node y no tienes tiempo de leer avisos de seguridad, pero sí responsabilidad si entran por ahí.

## Cómo ganar dinero con ella

Evita el susto de un incidente (300-3.000 € de limpieza) y te da argumento para vender un mantenimiento mensual de 60-150 € por cliente.

- Mantenimiento de seguridad de dependencias para webs a medida entregadas a clientes.
- Informe de vulnerabilidades mensual para proyectos Node de pequeñas empresas.
- Servicio de revisión de dependencias vendido como parte del mantenimiento anual.

**Precio orientativo:** 60–150 € al mes por cliente. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién.** Cada viernes lee el `package.json` de cada repositorio de tu lista, pregunta a la API pública de OSV.dev si alguna versión tiene vulnerabilidades conocidas y te manda a Slack un resumen ordenado por gravedad con el nombre de la librería, la versión afectada y la versión que arregla el problema.
Para el desarrollador que entrega webs a medida y quiere ofrecer mantenimiento serio sin pagar Snyk.

**Lo que necesitas antes**
- Un token de GitHub: `github.com/settings/tokens` > Fine-grained token, permiso `Contents: Read-only` en los repos que quieras. Pégalo en n8n Credentials > GitHub API.
- Una hoja `Proyectos` en Sheets con columnas `repo` (formato `usuario/repositorio`), `rama` (normalmente `main`), `cliente`.
- Slack conectado en n8n (o Gmail si prefieres correo).
- OSV.dev no necesita clave ni registro.

**Los nodos, en orden**
1. **Schedule Trigger** — Weeks 1, Friday, Hour 9.
2. **Google Sheets** — Get Row(s) de `Proyectos`.
3. **GitHub** (`Leer package.json`) — Resource: File, Operation: Get, Repository Owner y Name desde `{{ $json.repo.split('/')[0] }}` y `{{ $json.repo.split('/')[1] }}`, File Path `package.json`, Additional Parameters > Reference `{{ $json.rama }}`. En Settings: On Error `Continue`.
4. **Code** (`Listar paquetes`) — Mode: Run Once for All Items. Código abajo: decodifica base64, junta dependencias y devDependencies y limpia los símbolos `^` y `~`.
5. **HTTP Request** (`OSV`) — Method POST, URL `https://api.osv.dev/v1/querybatch`, Body Content Type JSON, Using JSON: `{{ JSON.stringify({ queries: $json.queries }) }}`. Timeout 30000.
6. **Code** (`Resumir`) — cruza las respuestas de OSV con los paquetes y arma el mensaje. Código abajo.
7. **IF** (`Hay avisos?`) — Number `{{ $json.total }}` `larger` `0`.
8. **Slack** — Send Message a `#mantenimiento` con `{{ $json.mensaje }}`.

**El código del nodo `Listar paquetes`**
```js
const salida = [];
for (const item of $input.all()) {
  let pkg;
  try { pkg = JSON.parse(Buffer.from(item.json.content, 'base64').toString('utf8')); } catch (e) { continue; }
  const deps = { ...(pkg.dependencies || {}), ...(pkg.devDependencies || {}) };
  const lista = Object.entries(deps).map(([nombre, v]) => ({ nombre, version: String(v).replace(/[^0-9.]/g, '') })).filter(d => d.version);
  const queries = lista.map(d => ({ package: { name: d.nombre, ecosystem: 'npm' }, version: d.version }));
  salida.push({ json: { repo: pkg.name || 'proyecto', lista, queries } });
}
return salida;
```

**El código del nodo `Resumir`**
```js
const paquetes = $('Listar paquetes').first().json.lista;
const res = ($json.results || []);
const filas = [];
res.forEach((r, i) => {
  const vulns = r.vulns || [];
  if (!vulns.length) return;
  const p = paquetes[i];
  const ids = vulns.map(v => v.id).slice(0, 3).join(', ');
  filas.push(`- ${p.nombre}@${p.version} -> ${vulns.length} aviso(s): ${ids}`);
});
const mensaje = filas.length ? `Vulnerabilidades detectadas:\n${filas.join('\n')}\nRevisa en https://osv.dev buscando el ID.` : '';
return [{ json: { total: filas.length, mensaje } }];
```

**Cómo probarla**
- Añade a mano en un repo de pruebas una dependencia vieja conocida, por ejemplo `"lodash": "4.17.4"`, y comprueba que salta el aviso.
- Ejecuta a mano y revisa el nodo `OSV`: debe devolver un array `results` con la misma longitud que `queries`.

**Qué puede salir mal**
- Rangos de versión tipo `^4.17.0` no dicen la versión real instalada. Para precisión de verdad, lee `package-lock.json` en vez de `package.json` y saca las versiones exactas; el flujo es el mismo cambiando el File Path y el parseo.
- `querybatch` acepta muchas consultas pero conviene trocear por encima de 400 paquetes: usa Split In Batches de 200.
- Proyectos que no son Node (WordPress, PHP): cambia `ecosystem` a `Packagist` y lee `composer.json`.
- Un aviso no siempre es explotable en tu caso; prioriza los que afectan a dependencias de producción y con parche disponible antes de correr a actualizar y romper la web.

**Cuánto cuesta**
- OSV.dev y GitHub API: gratis. Slack gratis. n8n autoalojado gratis.
- Comparación: Snyk de pago cuesta desde 25 $/mes por desarrollador.
