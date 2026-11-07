# Parte mensual de mantenimiento WordPress para enviar al…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

El día 1 de cada mes revisa por SSH todas las webs WordPress que gestionas, actualiza los plugins menores y envía a cada cliente un informe con lo hecho. Para agencias, freelances.

## Qué es y qué hace

El día 1 de cada mes entra por SSH a cada WordPress con WP-CLI, revisa la versión del núcleo y los plugins con actualización, aplica las actualizaciones menores, anota espacio y comentarios spam en Google Sheets y envía a cada cliente un correo con lo hecho y lo pendiente. Requiere SSH con WP-CLI en cada hosting.

## Cómo usarla

1. Pedir acceso SSH con WP-CLI a cada hosting
2. Preparar la hoja Webs mantenimiento con credenciales
3. Montar el flujo mensual en n8n
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando cobres una cuota de mantenimiento y no tengas nada que enseñar a final de mes, o cuando gestiones varias webs y las actualizaciones se te acumulen.

## Cómo ganar dinero con ella

Justifica cuotas de 50-150 €/mes por web con un informe automático. Ahorra 20-30 minutos por web y mes, y evita hackeos por plugins desactualizados.

- Mantenimiento mensual de WordPress con informe para agencias y freelances.
- Cuota de mantenimiento por web con informe automático que justifica el precio ante el cliente.
- Actualización de plugins para webs de clientes con plugins antiguos y riesgo de seguridad.

**Precio orientativo:** 60–150 € al mes por web. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recorre una lista de webs, entra por SSH y usa WP-CLI para ver la versión del núcleo, los plugins con actualización pendiente, el espacio ocupado y si hay comentarios spam.
Aplica las actualizaciones menores de plugins (las de versión de parche), guarda todo en una hoja y manda a cada cliente un correo bonito con lo hecho, lo pendiente y una recomendación.

## Lo que necesitas antes
- Acceso SSH con WP-CLI en cada hosting (pídeselo a soporte si no lo tienes; sin esto la receta no funciona).
- n8n auto-alojado (Community Edition, gratis). n8n Cloud solo tiene una prueba gratuita temporal y después es de pago.
- Hoja de Google «Webs mantenimiento» con columnas: web, cliente, email_cliente, ssh_host, ssh_user, ruta_wp, credencial.
- Una credencial SSH en n8n por cada hosting distinto (nómbralas igual que la columna `credencial`).
- Credencial Gmail OAuth2.

## Los nodos, en orden
1. **Schedule Trigger** — Months, Trigger at Day of Month: 1, Hour: 6.
2. **Google Sheets** — Get Row(s) de «Webs mantenimiento».
3. **Loop Over Items** — Batch Size: 1.
4. **Code** (renómbralo «Validar ruta») — Mode: Run Once for Each Item. Para el flujo si `ruta_wp` no es una ruta absoluta limpia. Ver código.
5. **SSH** (renómbralo «Diagnóstico») — Resource: Command; Command: `cd {{ $json.ruta_wp }} && echo "--CORE--" && wp core version && echo "--CORE_UPD--" && wp core check-update --format=csv && echo "--PLUGINS--" && wp plugin list --format=json && echo "--DISCO--" && du -sh . && echo "--SPAM--" && wp comment count --format=json`. Settings: `On Error: Continue`, Timeout alto.
6. **Code** (renómbralo «Interpretar») — ver código.
7. **SSH** (renómbralo «Actualizar menores») — Command: `cd {{ $('Validar ruta').item.json.ruta_wp }} && wp plugin update {{ $json.plugins_menores.join(' ') }} --minor 2>&1 || echo 'sin cambios'`. Ponle Settings `Always Output Data` y `On Error: Continue`.
8. **SSH** (renómbralo «Limpiar spam») — Command: `cd {{ $('Validar ruta').item.json.ruta_wp }} && wp comment delete $(wp comment list --status=spam --format=ids) 2>&1 || echo 'nada que borrar'`.
9. **Code** (renómbralo «Montar informe») — construye el HTML del correo con los datos del paso 6 y la salida del 7.
10. **Gmail** — To: `={{ $('Loop Over Items').item.json.email_cliente }}`; Cc: tu correo; Subject: `Informe de mantenimiento — {{ $('Loop Over Items').item.json.web }} — {{ new Date().toLocaleDateString('es-ES', { month: 'long', year: 'numeric' }) }}`; Message Type: HTML; Message: `={{ $json.html }}`.
11. **Google Sheets** — Append Row a una pestaña `historial` con fecha, web, plugins actualizados y pendientes.
12. La salida vuelve al **Loop Over Items**.

## El código de «Validar ruta»
```js
const ruta = String($json.ruta_wp || '');
if (!/^\/[A-Za-z0-9._\/-]+$/.test(ruta)) throw new Error('ruta_wp no válida para ' + $json.web + ': ' + ruta.slice(0, 80));
return $input.item;
```

## El código de «Interpretar»
```js
const out = $json.stdout || '';
const trozo = (a, b) => { const i = out.indexOf(a); const j = b ? out.indexOf(b) : out.length; return i === -1 ? '' : out.slice(i + a.length, j === -1 ? out.length : j).trim(); };
const core = trozo('--CORE--', '--CORE_UPD--');
const coreUpd = trozo('--CORE_UPD--', '--PLUGINS--');
let plugins = [];
try { plugins = JSON.parse(trozo('--PLUGINS--', '--DISCO--')); } catch (e) { plugins = []; }
const disco = trozo('--DISCO--', '--SPAM--').split(/\s+/)[0] || '?';
const pendientes = plugins.filter(p => p.update === 'available');
const menores = pendientes.filter(p => { const a = (p.version || '0').split('.'); const b = (p.update_version || '0').split('.'); return a[0] === b[0] && a[1] === b[1]; }).map(p => p.name).filter(n => /^[A-Za-z0-9][A-Za-z0-9._-]*$/.test(n));
const mayores = pendientes.filter(p => !menores.includes(p.name)).map(p => `${p.name} (${p.version} → ${p.update_version})`);
const inactivos = plugins.filter(p => p.status === 'inactive').map(p => p.name);
return [{ json: { core, core_actualizable: coreUpd.includes(','), disco, total_plugins: plugins.length, plugins_menores: menores, plugins_mayores: mayores, inactivos } }];
```

## El código de «Montar informe»
```js
const d = $('Interpretar').item.json;
const w = $('Loop Over Items').item.json;
const li = (a) => a.length ? '<ul>' + a.map(x => `<li>${x}</li>`).join('') + '</ul>' : '<p>Nada pendiente.</p>';
const html = `<h2>Mantenimiento de ${w.web}</h2><p>Hola ${w.cliente}, este es el resumen del mes.</p>` +
  `<p><b>WordPress:</b> versión ${d.core} ${d.core_actualizable ? '(hay una versión nueva, la aplicamos en ventana acordada)' : '(al día)'}<br>` +
  `<b>Plugins instalados:</b> ${d.total_plugins}<br><b>Espacio ocupado:</b> ${d.disco}</p>` +
  `<h3>Actualizado automáticamente</h3>${li(d.plugins_menores)}` +
  `<h3>Requiere revisión manual (cambio de versión mayor)</h3>${li(d.plugins_mayores)}` +
  `<h3>Plugins desactivados que conviene eliminar</h3>${li(d.inactivos)}` +
  `<p>Copia de seguridad y comentarios spam: revisados. Cualquier duda, respóndeme a este correo.</p>`;
return [{ json: { html } }];
```

## Cómo probarla
- Prueba primero con UNA web tuya, no de cliente, y con el nodo «Actualizar menores» desactivado (clic derecho > Deactivate).
- Revisa el correo que se genera (ponte a ti en el To) y ajusta el texto a tu tono.
- Activa el nodo de actualización solo cuando tengas la receta 2 (copias de seguridad) funcionando. Nunca actualices sin backup del mismo día.

## Qué puede salir mal
- **Una actualización rompe la web**: por eso solo se aplican versiones de parche. Aun así, encadena antes el flujo de backup o llama a `wp db export` en el nodo 5.
- **`Error: This does not seem to be a WordPress installation`**: la `ruta_wp` está mal; usa la ruta absoluta hasta donde está `wp-config.php`.
- **Multisite o WooCommerce grande**: añade `--skip-plugins --skip-themes` al comando de diagnóstico si tarda demasiado.
- **El cliente responde asustado**: escribe el correo en lenguaje llano y sin tecnicismos; el informe es un argumento de venta, no un log.
- **Credenciales SSH distintas por web**: n8n no permite elegir la credencial con una expresión; crea un flujo por hosting o usa un único usuario con acceso a todas las rutas.
- **Datos de la hoja dentro del comando SSH**: `ruta_wp` y los nombres de plugin acaban en la shell del hosting; por eso «Validar ruta» y el filtro de «Interpretar» solo dejan pasar letras, números, `.`, `_`, `-` y `/`. Un plugin con nombre raro pasa a revisión manual.
- **Opciones coladas como nombre de plugin**: un nombre que empiece por `-` (`--all`) se leería como opción de WP-CLI; el filtro exige que empiece por letra o número, y los comandos SSH leen la ruta de «Validar ruta», no de la hoja.

## Cuánto cuesta
- Gratis: n8n auto-alojado, WP-CLI, Gmail (cuidado con el límite de 500 correos/día, que aquí no vas a rozar).
- Coste real: la VPS de n8n, 5-10 €/mes, repartida entre todos tus clientes.
