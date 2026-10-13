# Registro de horas por commits para facturar a clientes…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Apunta cada commit en una hoja, los agrupa en sesiones de trabajo reales y el día 1 de mes te manda el total de horas por proyecto, listo para pasar factura.

## Qué es y qué hace

Un webhook registra cada push de GitHub con repo, autor, hora y mensaje en Google Sheets. Un flujo mensual agrupa esos commits en sesiones de trabajo (un hueco de más de 90 minutos abre una nueva) y calcula las horas por proyecto. Te manda el total listo para pasar factura. Para freelances que facturan por horas y trabajan a saltos.

## Cómo usarla

1. Configurar el webhook de push en cada repo
2. Preparar la hoja horas y la de clientes con tarifa
3. Montar los dos flujos en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando facturas por horas a varios clientes y nunca apuntas el tiempo, así que acabas inventando la cifra al final del mes.

## Cómo ganar dinero con ella

Recupera horas trabajadas que no facturabas. Con 4 horas al mes rescatadas a 45 €, son más de 2.000 € al año.

- Registro automático de horas para desarrolladores que facturan por proyecto o por horas.
- Borrador mensual de horas para agencias pequeñas con varios clientes.
- Control de tiempo sin cronómetro que el consultor monta para equipos freelance.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un webhook registra cada push con repo, autor, hora y mensaje; un segundo flujo mensual agrupa esos commits en sesiones (un hueco de más de 90 minutos empieza una sesión nueva) y calcula horas por proyecto.
Para el freelance que factura por horas y trabaja a saltos, sin cronómetro.

## Lo que necesitas antes
- Token de GitHub no hace falta para el webhook, pero sí acceso a Settings > Webhooks de cada repo.
- Hoja de Google Sheets `horas` con columnas: `fecha_iso`, `repo`, `cliente`, `autor`, `mensaje`.
- Una segunda pestaña `clientes` con `repo` y `cliente` y `tarifa`, o mételo directo en el Code.
- Credenciales Google Sheets y Gmail en n8n.

## Los nodos, en orden — FLUJO A (registro)
**1. Webhook** — `POST`, Path `commit-hora`, Respond `Immediately`. En cada repo del cliente: Settings > Webhooks, evento **Just the push event**.
**2. Code** («Desglosar commits») — un item por commit del push.
**3. Google Sheets** — Operation `Append Row` en la pestaña `horas`, mapeo automático de los campos.

## Los nodos, en orden — FLUJO B (informe)
**4. Schedule Trigger** — `Months`, día 1, hora 8.
**5. Google Sheets** — Operation `Get Row(s)` de la pestaña `horas`, sin filtro (o filtrando por mes si la hoja crece mucho).
**6. Code** («Calcular sesiones») — agrupa y suma.
**7. Gmail** — Send, Subject `Horas del mes pasado`, Email Type `HTML`, Message `={{ $json.html }}`.

## El código del nodo 2
```javascript
const b = $input.first().json.body;
const repo = b.repository.full_name;
const mapa = { 'miusuario/web-cliente-a': 'Cliente A', 'miusuario/api-cliente-b': 'Cliente B' };
return (b.commits || []).map(c => ({ json: {
  fecha_iso: c.timestamp,
  repo,
  cliente: mapa[repo] || 'Interno',
  autor: c.author.name,
  mensaje: c.message.split('\n')[0].slice(0, 120)
}}));
```

## El código del nodo 6
```javascript
const filas = $input.all().map(i => i.json).filter(f => f.fecha_iso);
const ahora = new Date();
const mesPasado = new Date(ahora.getFullYear(), ahora.getMonth() - 1, 1);
const finMes = new Date(ahora.getFullYear(), ahora.getMonth(), 1);
const delMes = filas.filter(f => { const d = new Date(f.fecha_iso); return d >= mesPasado && d < finMes; });
const porCliente = {};
for (const f of delMes) { (porCliente[f.cliente] = porCliente[f.cliente] || []).push(new Date(f.fecha_iso)); }
const HUECO = 90 * 60 * 1000;
const MINIMO = 30 * 60 * 1000;
const tarifas = { 'Cliente A': 45, 'Cliente B': 55, 'Interno': 0 };
let html = '<h3>Horas de ' + mesPasado.toLocaleDateString('es-ES', { month: 'long', year: 'numeric' }) + '</h3><table border=1 cellpadding=6><tr><th>Cliente</th><th>Sesiones</th><th>Horas</th><th>Importe</th></tr>';
let totalEuros = 0;
for (const [cliente, fechas] of Object.entries(porCliente)) {
  fechas.sort((a, b) => a - b);
  let ms = 0, sesiones = 1, ini = fechas[0], prev = fechas[0];
  for (let i = 1; i < fechas.length; i++) {
    if (fechas[i] - prev > HUECO) { ms += Math.max(prev - ini, MINIMO); sesiones++; ini = fechas[i]; }
    prev = fechas[i];
  }
  ms += Math.max(prev - ini, MINIMO);
  const horas = Math.round(ms / 360000) / 10;
  const euros = Math.round(horas * (tarifas[cliente] || 0));
  totalEuros += euros;
  html += '<tr><td>' + cliente + '</td><td>' + sesiones + '</td><td>' + horas + '</td><td>' + euros + ' €</td></tr>';
}
html += '</table><p><b>Total: ' + totalEuros + ' €</b> (sin IVA). Estimación por commits: revísala antes de facturar.</p>';
return [{ json: { html } }];
```

## Cómo probarla
1. Haz un push de prueba y comprueba que aparecen tantas filas como commits llevaba.
2. Ejecuta el Flujo B a mano tras haber metido a mano en la hoja unas cuantas filas con fechas del mes pasado y horas separadas, y comprueba que las sesiones cuadran con tu intuición.
3. Ajusta `HUECO` y `MINIMO` a tu forma de trabajar: si haces commits muy espaciados, sube el mínimo por sesión.

## Qué puede salir mal
- **No es un cronómetro**: mide desde el primer al último commit de cada sesión, así que no cuenta la primera media hora de arranque ni el rato de leer código sin tocar nada. Trátalo como suelo, no como verdad.
- **Commits con fecha del autor falseada** (rebases, cherry-picks) meten ruido: usa `c.timestamp` del push, no la fecha del autor.
- **Pushes masivos tras días sin conexión** cuentan todo en un instante: revisa el informe siempre antes de facturar.
- **La hoja crece**: con miles de filas, Google Sheets se ralentiza. Crea una hoja por año.
- **Zonas horarias**: los timestamps de GitHub llevan offset; el cálculo es en milisegundos, así que no afecta a la duración.

## Cuánto cuesta
0 €. GitHub, Sheets, Gmail y n8n auto-alojado, todo gratis.
