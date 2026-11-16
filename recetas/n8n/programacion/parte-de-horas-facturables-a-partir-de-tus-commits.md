# Parte de horas facturables a partir de tus commits

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Reconstruye tus horas de trabajo desde el historial de commits, las reparte por cliente según la rama o el repositorio y te deja el parte listo para facturar.

## Qué es y qué hace

Flujo de n8n que cada domingo descarga tus commits de la semana, los agrupa en sesiones de trabajo (si pasan menos de 45 minutos entre dos commits, es la misma sesión) y suma el tiempo con un margen de arranque configurable. Reparte las horas por cliente según el repositorio, calcula un importe estimado con su tarifa y genera el parte en una hoja.

## Cómo usarla

1. Define tarifa y repositorios por cliente en la hoja
2. Fija el hueco máximo y el margen de arranque
3. Revisa el parte semanal
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando factures por horas y siempre se te olvide arrancar el cronómetro, y acabes el mes calculando a ojo lo que has trabajado para cada cliente.

## Cómo ganar dinero con ella

Recuperar dos horas mensuales que antes no apuntabas, a 45 euros la hora, son 1.080 euros al año, además del tiempo de hacer el parte a mano.

- Partes de horas automáticos para freelances que facturan por proyecto.
- Estimación de dedicación para agencias con clientes por bolsa de horas.
- Control de tiempos para desarrolladores que revisan su rentabilidad mensual.

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada domingo descarga tus commits de la semana, los agrupa en sesiones de trabajo (si entre dos commits pasan menos de 45 minutos, es la misma sesión) y suma el tiempo con un margen de arranque configurable. Reparte esas horas por cliente según el repositorio y te manda el parte con el importe estimado.
Para el desarrollador freelance que factura por horas o por bolsa de horas y quiere una estimación defendible y trazable, no un número inventado.

## Lo que necesitas antes
- n8n y un token de GitHub con permiso `repo`.
- Una hoja «Clientes» con columnas: repo, cliente, tarifa_hora, email_facturacion.
- Una hoja «Partes» con columnas: semana, cliente, repo, horas, importe, detalle.
- Decidir tus dos parámetros: el hueco máximo dentro de una sesión (45 minutos va bien) y el tiempo de arranque que se suma a cada sesión (25 minutos, que es lo que pasa entre que te sientas y haces el primer commit).

## Los nodos, en orden
1. **Schedule Trigger** («Cada domingo a las 20:00») — Cron `0 20 * * 0` (domingos a las 20:00; la zona horaria Europe/Madrid se pone en los ajustes del workflow).
2. **Google Sheets** («Clientes») — Get Row(s).
3. **Split In Batches** (en n8n actual se llama «Loop Over Items»: renómbralo exactamente «Split In Batches», el código del paso 5 usa `$('Split In Batches')`) — Batch Size 1, un repositorio por vuelta. Su salida *loop* (la segunda) va a «Commits»; su salida *done* (la primera) va a «Resumen semanal» (paso 8).
4. **HTTP Request** («Commits») — GET `https://api.github.com/repos/{{ $json.repo }}/commits?author=TU_USUARIO&since={{ new Date(Date.now() - 7*86400000).toISOString() }}&per_page=100`, credencial GitHub (tipo de credencial predefinido GitHub API). En las opciones del nodo activa la paginación: modo «la respuesta contiene la URL de la siguiente página», con la URL siguiente sacada de la cabecera `Link` (la que lleva `rel="next"`), que se detenga cuando no haya siguiente, con un máximo de 20 peticiones. En Settings del nodo activa que siempre devuelva datos (*Always Output Data*), para que un repositorio sin commits no corte el bucle.
5. **Code** («Calcular sesiones») — la lógica de estimación.
```javascript
const HUECO = 45 * 60 * 1000;
const ARRANQUE = 25 * 60 * 1000;
// el repo/cliente de esta vuelta: el item de Split In Batches que originó estos commits
let cliente;
try { cliente = $('Split In Batches').itemMatching(0).json; } catch (e) { cliente = $('Split In Batches').first().json; }
// GitHub devuelve un array: n8n lo separa en un item por commit
const commits = $input.all().map(i => i.json).filter(c => c && c.commit && c.commit.author);
// El nodo Commits pide hasta 20 páginas de 100 (sigue la cabecera Link de GitHub). Si se llega a ese tope, puede faltar historia.
const TOPE = 20 * 100;
const incompleto = commits.length >= TOPE;
const aviso = incompleto ? '⚠ PARTE INCOMPLETO: se llegó al tope de ' + TOPE + ' commits; faltan commits de esta semana. Revísalo a mano.\n' : '';
const tarifa = Number(String(cliente.tarifa_hora).replace(',', '.')) || 0;
const semana = new Date().toISOString().slice(0, 10);
const fechas = commits.map(c => new Date(c.commit.author.date).getTime()).sort((a, b) => a - b);
// sin commits: se devuelve una fila a 0 horas para que el bucle siga con el repositorio siguiente
if (!fechas.length) return [{ json: { semana, cliente: cliente.cliente, repo: cliente.repo, sesiones: 0, horas: 0, importe: 0, detalle: '(sin commits esta semana)' } }];
const sesiones = [];
let inicio = fechas[0];
let fin = fechas[0];
for (let i = 1; i < fechas.length; i++) {
  if (fechas[i] - fin > HUECO) { sesiones.push([inicio, fin]); inicio = fechas[i]; }
  fin = fechas[i];
}
sesiones.push([inicio, fin]);
let ms = 0;
for (const [a, b] of sesiones) ms += (b - a) + ARRANQUE;
const horas = Math.round((ms / 3600000) * 4) / 4;
const detalle = commits.slice(0, 15).map(c => '- ' + c.commit.message.split('\n')[0]).join('\n');
return [{ json: { semana, cliente: cliente.cliente, repo: cliente.repo, sesiones: sesiones.length, horas, importe: Math.round(horas * tarifa * 100) / 100, detalle: aviso + detalle, incompleto } }];
```
6. **Google Sheets** («Guardar parte») — Append en «Partes», con las columnas `semana`, `cliente`, `repo`, `horas`, `importe` y `detalle` mapeadas a `{{ $json.semana }}`, `{{ $json.cliente }}`, etc.
7. Conecta la salida de «Guardar parte» de vuelta al **Split In Batches**; en su salida «done» sigue el resto (paso 8).
8. **Code** («Resumen semanal», conectado a la salida «done» de Split In Batches) — agrupa por cliente sumando horas e importe de todos los repositorios de esa semana.
9. **Gmail** («Enviar parte») — Send a tu propio correo, Subject `=Parte de la semana: {{ $json.total_horas }} h / {{ $json.total_importe }} €{{ $json.incompleto ? ' (INCOMPLETO)' : '' }}`, tipo de correo HTML, Message `{{ $json.html }}` (cuerpo con una tabla por cliente y el detalle de commits que ya construye el Code), para que lo revises y ajustes antes de facturar.

## Cómo probarla
Ejecútalo con la ventana de siete días sobre una semana que recuerdes bien y compara el resultado con tu sensación real. Si sale corto, sube el arranque a 35 minutos; si sale largo, baja el hueco a 30 minutos. Calíbralo dos o tres semanas y luego olvídate.

## Qué puede salir mal
- **Trabajo sin commits**: reuniones, diseño, depuración larga o llamadas no dejan rastro. Añade en la hoja «Partes» una columna `ajuste_manual` y súmala en el resumen; el flujo te da la base, no la verdad absoluta.
- **Commits en bloque al final del día**: si haces un único commit gigante, la estimación se queda en el arranque. Cometer más a menudo mejora el parte y también tu historial.
- **Zona horaria**: GitHub devuelve fechas en UTC; si trabajas de noche puedes ver commits en el día equivocado. Convierte con `toLocaleString('es-ES', { timeZone: 'Europe/Madrid' })` antes de agrupar por día.
- **Rebase y squash**: reescriben fechas y pueden inflar o desinflar sesiones; usa la fecha de `commit.author.date`, no la del committer, como hace el código.
- **Importante**: este parte es una estimación de apoyo. No lo mandes tal cual al cliente sin revisarlo.

## Cuánto cuesta
Gratis. Sustituye a herramientas de control de tiempo de 8-12 euros al mes por usuario, y no te obliga a acordarte de darle al play.

CÓDIGO DE LOS NODOS (el mismo que lleva el flujo importable)

Nodo Code «Resumen semanal»:
```js
// agrupa por cliente las filas guardadas en esta semana por todos los repositorios
const porCliente = {};
for (const it of $input.all()) {
  const r = it.json;
  const c = r.cliente || '(sin cliente)';
  const o = porCliente[c] ||= { cliente: c, horas: 0, importe: 0, repos: [] };
  o.horas += Number(String(r.horas).replace(',', '.')) || 0;
  o.importe += Number(String(r.importe).replace(',', '.')) || 0;
  o.repos.push({ repo: r.repo, horas: Number(String(r.horas).replace(',', '.')) || 0, detalle: r.detalle || '' });
}
const esc = s => String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
const clientes = Object.values(porCliente);
const total_horas = Math.round(clientes.reduce((s, c) => s + c.horas, 0) * 100) / 100;
const total_importe = Math.round(clientes.reduce((s, c) => s + c.importe, 0) * 100) / 100;
const hayIncompleto = clientes.some(c => c.repos.some(r => String(r.detalle).includes('PARTE INCOMPLETO')));
let html = '<p>Parte estimado de la semana. Revísalo y ajústalo antes de facturar.</p>';
if (hayIncompleto) html += '<p><b>⚠ ATENCIÓN: PARTE INCOMPLETO.</b> Algún repositorio superó el tope de commits descargados; las horas de esos repositorios están por debajo de la realidad (mira el detalle).</p>';
html += '<table border="1" cellpadding="6" cellspacing="0"><tr><th>Cliente</th><th>Horas</th><th>Importe (€)</th></tr>';
for (const c of clientes) html += '<tr><td>' + esc(c.cliente) + '</td><td>' + c.horas + '</td><td>' + (Math.round(c.importe * 100) / 100) + '</td></tr>';
html += '<tr><td><b>Total</b></td><td><b>' + total_horas + '</b></td><td><b>' + total_importe + '</b></td></tr></table>';
for (const c of clientes) {
  html += '<h3>' + esc(c.cliente) + '</h3>';
  for (const r of c.repos) html += '<p><b>' + esc(r.repo) + '</b> (' + r.horas + ' h)</p><pre>' + esc(r.detalle) + '</pre>';
}
return [{ json: { total_horas, total_importe, clientes, html, incompleto: hayIncompleto } }];
```
