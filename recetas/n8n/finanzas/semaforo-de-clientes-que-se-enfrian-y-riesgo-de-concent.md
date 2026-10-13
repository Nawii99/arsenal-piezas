# Semáforo de clientes que se enfrían y riesgo de concent…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Detecta qué clientes te están facturando menos que su media histórica y te avisa si uno solo concentra demasiada parte de tus ingresos.

## Qué es y qué hace

Una vez al mes lee el histórico de facturación por cliente de una hoja de Google Sheets, compara los últimos 3 meses con los 9 anteriores y marca los que han caído más de un 30 %. Calcula también qué parte de la facturación anual depende de cada cliente y avisa en Slack si uno supera el 25 %. Útil para carteras de clientes recurrentes.

## Cómo usarla

1. Preparar la hoja Facturacion con 12 meses de histórico
2. Crear el bot de Slack y el canal
3. Montar el cálculo mensual en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando tienes cartera de clientes recurrentes y quieres enterarte de que uno se va antes de que te lo diga.

## Cómo ganar dinero con ella

Recuperar un cliente que se enfría cuesta mucho menos que captar uno nuevo. Y ver que un cliente es el 45 % de tu facturación te obliga a diversificar antes del golpe.

- Análisis mensual de cartera de clientes para agencias y talleres con clientes que repiten.
- Alerta de concentración de ingresos para autónomos que dependen de uno o dos clientes grandes.
- Informe trimestral de retención de clientes que el consultor entrega como servicio de seguimiento.

**Precio orientativo:** 120–250 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Una vez al mes analiza tu histórico de facturación por cliente, compara los últimos 3 meses contra los 9 anteriores y saca los que han caído más de un 30 %.
Además calcula qué porcentaje de tu facturación anual depende de cada cliente y avisa si alguno supera el 25 %. Para servicios, agencias, talleres y mayoristas con clientes que repiten.

## Lo que necesitas antes
Hoja de Google Sheets `Facturacion` con pestaña `Facturas`: `numero`, `fecha` (texto `yyyy-mm-dd`), `cliente`, `email`, `total`. Con 12 meses de histórico como mínimo para que el análisis tenga sentido.
Un espacio de Slack (plan gratuito vale) y la credencial de n8n: creas una app en api.slack.com > Create New App > From scratch, le das el permiso `chat:write` en OAuth & Permissions, la instalas en tu espacio y copias el `Bot User OAuth Token`. Invita al bot al canal con `/invite @tu-bot`.
Si no usas Slack, sustituye ese nodo por Telegram o Gmail sin tocar nada más.

## Los nodos, en orden
**1. Schedule Trigger** — `Months`, día 1, hora 09:00, zona horaria `Europe/Madrid`.
**2. Google Sheets** (`Facturas`) — `Get Row(s)`, pestaña `Facturas`, sin filtro.
**3. Code** (`Analizar clientes`) — `Run Once for All Items`. Código abajo.
**4. Sort** — Campo `caida_pct`, orden `Descending`.
**5. IF** — Condición: `{{ $json.aviso }}` `is not empty`.
**6. Slack** — Operación `Send a message`, canal `#finanzas`, texto: `={{ $json.aviso }}`.
**7. Google Sheets** (`Registro`) — `Append`, pestaña `Alertas_clientes`, columnas `fecha`, `cliente`, `ultimos3`, `media_previa`, `caida_pct`, `peso_pct`.

## El código del nodo Analizar clientes
```javascript
const filas = $input.all().map(i => i.json).filter(f => f.cliente && f.fecha);
const hoy = new Date();
const mesesAtras = n => new Date(hoy.getFullYear(), hoy.getMonth() - n, 1);
const lim3 = mesesAtras(3), lim12 = mesesAtras(12);
const acc = {};
let totalAnual = 0;
for (const f of filas) {
  const d = new Date(f.fecha);
  if (d < lim12) continue;
  const imp = Number(f.total || 0);
  const c = String(f.cliente).trim();
  acc[c] = acc[c] || { recientes: 0, previos: 0, email: f.email || '' };
  totalAnual += imp;
  if (d >= lim3) acc[c].recientes += imp; else acc[c].previos += imp;
}
const out = [];
for (const [cliente, v] of Object.entries(acc)) {
  const mediaPrevia = v.previos / 9 * 3;
  const caida = mediaPrevia > 0 ? (1 - v.recientes / mediaPrevia) * 100 : 0;
  const peso = totalAnual > 0 ? (v.recientes + v.previos) / totalAnual * 100 : 0;
  let aviso = '';
  if (mediaPrevia > 300 && caida >= 30) aviso = `📉 *${cliente}* ha caído un ${caida.toFixed(0)} %: ${v.recientes.toFixed(0)} € en 3 meses frente a ${mediaPrevia.toFixed(0)} € esperados. Contacto: ${v.email}`;
  if (peso >= 25) aviso += `${aviso ? '\n' : ''}⚠️ *${cliente}* es el ${peso.toFixed(0)} % de tu facturación anual. Riesgo de concentración.`;
  out.push({ json: { cliente, email: v.email, ultimos3: Number(v.recientes.toFixed(2)), media_previa: Number(mediaPrevia.toFixed(2)), caida_pct: Number(caida.toFixed(1)), peso_pct: Number(peso.toFixed(1)), aviso, fecha: hoy.toISOString().slice(0, 10) } });
}
return out;
```

## Cómo probarla
Ejecuta a mano con tu histórico real y compara dos o tres clientes a ojo. Si un cliente grande que sabes que se fue no aparece, revisa que su nombre esté escrito igual en todas las filas.
Baja temporalmente el umbral `caida >= 30` a `caida >= 5` para ver que el mensaje se compone bien.

## Qué puede salir mal
Nombres de cliente escritos de formas distintas (`Talleres Pepe`, `TALLERES PEPE S.L.`) parten el histórico. Normaliza con `.toUpperCase()` o, mejor, usa una columna `cliente_id`.
Negocios estacionales dan falsos positivos: si vendes turismo o campañas de Navidad, compara contra el mismo trimestre del año anterior en vez de los 9 meses previos.
El filtro `mediaPrevia > 300` evita que microclientes disparen avisos. Ajusta ese número a tu ticket medio.
Slack tiene límite de 1 mensaje por segundo por canal: si tienes muchos clientes, añade un nodo **Loop Over Items** con `Batch Size` 1 y un **Wait** de 1 segundo, o junta todos los avisos en un solo mensaje.

## Cuánto cuesta
Gratis: Sheets, Slack plan gratuito y n8n auto-alojado.
