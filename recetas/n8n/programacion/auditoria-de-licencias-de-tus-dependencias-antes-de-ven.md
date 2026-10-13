# Auditoría de licencias de tus dependencias antes de ven…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Revisa la licencia de cada librería que usas en JavaScript y Python y te avisa si alguna te obliga a abrir tu código o te impide venderlo.

## Qué es y qué hace

Flujo de n8n que lee tus ficheros de dependencias de JavaScript y Python, consulta la licencia declarada de cada paquete en npm y PyPI y la clasifica en sin problema, cuidado o prohibida para producto cerrado. Genera una hoja que puedes adjuntar a un contrato o a una due diligence. No sustituye el criterio de un abogado.

## Cómo usarla

1. Define tu criterio de licencias aceptables
2. Conecta GitHub y la hoja de licencias
3. Ejecuta el análisis sobre el proyecto
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando vayas a entregar software a un cliente, vender una licencia o levantar inversión, y necesites saber que ninguna dependencia te mete en un problema legal.

## Cómo ganar dinero con ella

Descubrir una librería con licencia copyleft al final de un proyecto obliga a reescribir o a renegociar el contrato; detectarlo pronto ahorra días y disgustos.

- Informe de licencias de software para entregar a clientes corporativos…
- Due diligence técnica previa a una inversión o compraventa de software…
- Auditoría de cumplimiento open source para startups…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee tus archivos de dependencias, consulta la licencia declarada de cada paquete en el registro público correspondiente y las clasifica en «sin problema», «cuidado» y «prohibida para producto cerrado». Genera una hoja que puedes adjuntar como anexo de un contrato o de una due diligence.
Para el freelance o estudio que entrega código propietario a clientes y para quien vende un producto y no quiere sorpresas legales.

## Lo que necesitas antes
- n8n con credencial de GitHub (o los archivos accesibles por URL).
- Los registros públicos `https://registry.npmjs.org` y `https://pypi.org/pypi/PAQUETE/json`, ambos gratuitos y sin clave.
- Una hoja «Licencias» con columnas: fecha, proyecto, paquete, ecosistema, licencia, categoria, accion.
- Tener claro tu criterio: si vendes software cerrado, MIT, Apache-2.0, BSD e ISC son cómodas; GPL y AGPL te obligan a publicar tu código si distribuyes; LGPL y MPL están en medio y dependen de cómo enlaces.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 6 1 * *` (día 1 de cada mes) y además déjalo ejecutable a mano antes de cada entrega.
2. **GitHub** («package.json») — Resource: File, Operation: Get, ruta `package.json`.
3. **GitHub** («requirements») — otro nodo igual con ruta `requirements.txt`. En Settings marca «Continue On Fail» por si el proyecto no es de Python.
4. **Code** («Unificar lista de paquetes»)
```javascript
const salida = [];
function b64(x) { return Buffer.from(x, 'base64').toString('utf8'); }
const js = $('package.json').first();
if (js && js.json.content) {
  const pkg = JSON.parse(b64(js.json.content));
  const todas = { ...(pkg.dependencies || {}), ...(pkg.devDependencies || {}) };
  for (const nombre of Object.keys(todas)) salida.push({ json: { paquete: nombre, ecosistema: 'npm' } });
}
const py = $('requirements').first();
if (py && py.json.content) {
  for (const linea of b64(py.json.content).split('\n')) {
    const limpia = linea.split('#')[0].trim();
    if (!limpia) continue;
    salida.push({ json: { paquete: limpia.split(/[=<>!~\[]/)[0].trim(), ecosistema: 'pypi' } });
  }
}
return salida;
```
5. **Split In Batches** — Batch Size 1.
6. **Switch** — según `{{ $json.ecosistema }}`, salida 0 para npm y salida 1 para pypi.
7. **HTTP Request** («npm») — GET `https://registry.npmjs.org/{{ encodeURIComponent($json.paquete) }}`.
8. **HTTP Request** («pypi») — GET `https://pypi.org/pypi/{{ $json.paquete }}/json`. Ambos con «Continue On Fail» activado (hay paquetes privados o retirados).
9. **Code** («Clasificar licencia»)
```javascript
const prohibidas = ['GPL-3.0', 'GPL-2.0', 'AGPL-3.0', 'SSPL', 'CC-BY-NC'];
const cuidado = ['LGPL', 'MPL-2.0', 'EPL', 'CDDL', 'BUSL'];
const salida = [];
for (const item of $input.all()) {
  const d = item.json;
  let lic = 'desconocida';
  if (d['dist-tags']) { const v = d.versions[d['dist-tags'].latest]; lic = (typeof v.license === 'string' ? v.license : (v.license && v.license.type)) || 'desconocida'; }
  else if (d.info) { lic = d.info.license || (d.info.classifiers || []).filter(c => c.startsWith('License ::')).join(' ') || 'desconocida'; }
  let categoria = 'sin problema';
  if (cuidado.some(x => lic.includes(x))) categoria = 'cuidado';
  if (prohibidas.some(x => lic.includes(x))) categoria = 'prohibida';
  if (lic === 'desconocida') categoria = 'revisar a mano';
  salida.push({ json: { fecha: new Date().toISOString().slice(0,10), paquete: d.name || (d.info && d.info.name), licencia: lic, categoria } });
}
return salida;
```
10. **Google Sheets** — Append en «Licencias».
11. **IF** — `{{ $json.categoria }}` distinto de `sin problema`.
12. **Gmail** — Send con la lista de paquetes problemáticos, su licencia y una línea de acción sugerida (sustituir, pedir licencia comercial o consultar con abogado).

## Cómo probarla
Instala a propósito en un proyecto de prueba una dependencia con GPL (por ejemplo alguna herramienta de línea de comandos) y ejecuta: debe salir en rojo. Comprueba también que un paquete privado tuyo cae en «revisar a mano» y no rompe el flujo.

## Qué puede salir mal
- **Licencia declarada distinta de la real**: el campo del registro no siempre coincide con el archivo LICENSE del repositorio. Para los casos críticos, abre el repositorio y míralo; esta receta te dice dónde mirar, no sustituye a un abogado.
- **Dependencias de dependencias**: esto revisa el primer nivel. Para el árbol completo, en n8n auto-alojado añade un **Execute Command** con `npx license-checker --json` sobre un clon del proyecto y pasa su salida al Code de clasificación.
- **Paquetes retirados**: devuelven 404; el «Continue On Fail» evita que pare el flujo.
- **Falsos rojos con licencias duales**: algunos paquetes ofrecen «MIT OR GPL-3.0»; el clasificador los marca en rojo por precaución, revísalos.

## Cuánto cuesta
Gratis. Los dos registros son públicos, y todo lo demás entra en las cuentas gratuitas. Una auditoría de licencias hecha por terceros cuesta cientos de euros.
