# Informe semanal de dependencias con vulnerabilidades…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cada lunes lee el fichero de dependencias de tus repos, consulta la base pública de vulnerabilidades OSV y te manda por email solo lo que hay que arreglar, ordenado por gravedad.

## Qué es y qué hace

Cada lunes descarga el package-lock.json o el requirements.txt de los repos que indiques, consulta por cada paquete y versión la API pública de OSV.dev y te envía un correo con las vulnerabilidades encontradas, ordenadas por gravedad y con enlace al aviso. No hace falta instalar nada en los servidores. Para freelances que mantienen webs de clientes.

## Cómo usarla

1. Crear el token de GitHub de lectura
2. Preparar la lista de repos
3. Configurar Gmail en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando arrastras proyectos de clientes con dependencias que nadie actualiza y quieres enterarte de los agujeros antes que ellos.

## Cómo ganar dinero con ella

Evita pagar herramientas de seguridad de suscripción y te da un informe vendible como servicio de mantenimiento a tus clientes.

- Informe de dependencias como servicio de mantenimiento para desarrolladores freelance.
- Revisión mensual de seguridad de librerías para proyectos de clientes.
- Documentación de vulnerabilidades que el freelance entrega en cada cierre de proyecto.

**Precio orientativo:** 60–150 € al mes por cliente. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Descarga el `package-lock.json` (o `requirements.txt`) de los repos que le digas, pregunta a la API pública de OSV.dev por cada paquete y versión, y te envía un email con las vulnerabilidades encontradas y el enlace al aviso.
Para el freelance que mantiene varias webs de clientes y necesita un chequeo periódico sin instalar nada en los servidores.

## Lo que necesitas antes
- Token de GitHub con lectura de contenidos de los repos.
- Nada más: la API de OSV.dev (`api.osv.dev`) es pública, gratuita y sin clave.
- Credencial de Gmail (o SMTP) en n8n para el envío.

## Los nodos, en orden
**1. Schedule Trigger** — `Weeks`, lunes, hora 8. Timezone `Europe/Madrid` en Settings del workflow.
**2. Code** («Repos a revisar») — un item por repo con `repo` y `ruta` del fichero.
**3. HTTP Request** («Bajar lockfile») — `GET` `https://api.github.com/repos/{{ $json.repo }}/contents/{{ $json.ruta }}`, con Authentication: Generic > Header Auth con una credencial de n8n (Name `Authorization`, Value `Bearer TU_TOKEN`), headers `Accept: application/vnd.github.raw`, `User-Agent: n8n`. Options > Response Format `Text`. No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él.
**4. Code** («Extraer paquetes») — saca nombre y versión de cada dependencia.
**5. Split In Batches** — Batch Size `100`. La API de OSV acepta lotes.
**6. HTTP Request** («Consultar OSV») — `POST` `https://api.osv.dev/v1/querybatch`, Body Content Type `JSON`, Specify Body `Using JSON`, con `={{ JSON.stringify({queries: $json.queries}) }}`.
**7. Code** («Filtrar hallazgos») — cruza respuesta con paquetes y se queda con lo vulnerable.
**8. Gmail** — Send, Subject `Dependencias vulnerables — {{ $now.format('dd/MM') }}`, Email Type `HTML`, Message `={{ $json.html }}`.
**9. IF** antes del Gmail: si no hay hallazgos, no envíes nada (o envía un «todo limpio» mensual, tú decides).

## El código del nodo 2
```javascript
return [
  { json: { repo: 'miusuario/web-cliente-a', ruta: 'package-lock.json' } },
  { json: { repo: 'miusuario/api-interna', ruta: 'package-lock.json' } }
];
```

## El código del nodo 4
```javascript
const texto = $input.first().json.data;
const lock = JSON.parse(texto);
const paquetes = [];
const src = lock.packages || {};
for (const [ruta, info] of Object.entries(src)) {
  if (!ruta || !info.version) continue;
  const nombre = ruta.replace(/^node_modules\//, '').split('/node_modules/').pop();
  paquetes.push({ nombre, version: info.version });
}
const unicos = Object.values(Object.fromEntries(paquetes.map(p => [p.nombre + '@' + p.version, p])));
const queries = unicos.map(p => ({ package: { name: p.nombre, ecosystem: 'npm' }, version: p.version }));
return [{ json: { queries, lista: unicos } }];
```

## El código del nodo 7
```javascript
const res = $input.first().json.results || [];
const lista = $('Extraer paquetes').first().json.lista;
const filas = [];
res.forEach((r, i) => {
  const vulns = r.vulns || [];
  if (!vulns.length) return;
  const p = lista[i];
  vulns.forEach(v => filas.push('<tr><td>' + p.nombre + '</td><td>' + p.version + '</td><td><a href="https://osv.dev/vulnerability/' + v.id + '">' + v.id + '</a></td></tr>'));
});
if (!filas.length) return [{ json: { hay: false, html: '' } }];
const html = '<h3>' + filas.length + ' avisos</h3><table border=1 cellpadding=6><tr><th>Paquete</th><th>Versión</th><th>Aviso</th></tr>' + filas.join('') + '</table>';
return [{ json: { hay: true, html } }];
```

## Cómo probarla
1. Ejecuta a mano con un repo viejo tuyo: casi seguro salen avisos, y así ves el email real.
2. Comprueba que el nodo 4 devuelve cientos de paquetes; si devuelve 0, tu lockfile es de la versión 1 y usa `dependencies` en vez de `packages` (cambia `lock.packages` por `lock.dependencies` y `info.version` sigue valiendo).
3. Manda el primer email a ti mismo antes de ponerlo en copia a clientes.

## Qué puede salir mal
- **Repos sin lockfile**: si solo tienes `package.json` con rangos (`^1.2.0`), las versiones no son exactas y OSV no puede responder bien. Sube el lockfile al repo.
- **Ficheros grandes**: la API de contents devuelve error por encima de 1 MB en modo raw en algunos casos; si pasa, usa la URL `https://raw.githubusercontent.com/{{repo}}/main/package-lock.json` con el mismo token.
- **Ruido**: OSV lista también avisos de baja gravedad y de dependencias de desarrollo. Añade al Code un filtro por `v.database_specific.severity` si te abruma.
- **Otro lenguaje**: para Python cambia `ecosystem` a `PyPI` y parsea `requirements.txt` con una expresión regular sobre `nombre==version`.

## Cuánto cuesta
0 €. OSV.dev es un servicio público de Google/OpenSSF sin clave ni cuota práctica; GitHub y Gmail gratis; n8n auto-alojado gratis.
