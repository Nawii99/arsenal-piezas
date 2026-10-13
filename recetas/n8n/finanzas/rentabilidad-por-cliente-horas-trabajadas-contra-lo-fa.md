# Rentabilidad por cliente: horas trabajadas contra lo fa…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cruza las horas que registras en Clockify con lo que has facturado a cada cliente y te dice tu precio real por hora, cliente a cliente, cada mes.

## Qué es y qué hace

El día 2 de cada mes descarga de Clockify las entradas de tiempo del mes anterior, las agrupa por cliente y proyecto, las cruza con lo facturado a cada cliente en la hoja de facturas y calcula el precio real por hora frente a tu tarifa objetivo. Te envía por email un ranking de clientes y actualiza un histórico en Google Sheets. Para servicios por proyecto o igualas.

## Cómo usarla

1. Generar la API key y el workspaceId en Clockify
2. Asignar un Cliente a cada proyecto
3. Preparar la hoja de facturación
4. Que lo revise un profesional

## Cuándo usarla

Cuando sospechas que un cliente te está saliendo caro pero no puedes demostrarlo, o cuando vas a subir precios y necesitas datos para decidir a quién y cuánto.

## Cómo ganar dinero con ella

Sacar a la luz un cliente que te paga a 18 €/hora cuando tu objetivo son 45 €/hora.

- Análisis de rentabilidad por cliente para agencias y consultores que facturan por proyecto.
- Revisión mensual de tarifas por hora para freelancers que quieren decidir a quién subir precio.
- Informe de rentabilidad trimestral que el consultor de gestión entrega a pequeños despachos.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
El día 2 de cada mes descarga todas las entradas de tiempo del mes anterior desde Clockify, las agrupa por cliente y proyecto, cruza esas horas con lo facturado a cada cliente en tu hoja de facturas, calcula el precio por hora real y lo compara con tu tarifa objetivo. Te manda un email con el ranking de clientes de mejor a peor y una hoja actualizada con el histórico para ver tendencias.
Para servicios profesionales que venden proyectos cerrados o igualas: agencias, consultores, despachos, estudios, freelancers con varios clientes.

## Lo que necesitas antes
- Cuenta de Clockify (el plan gratuito vale de sobra y es ilimitado en usuarios). Clave de API: tu avatar > Preferences > Advanced > API, botón Generate. Apunta también tu `workspaceId`, que está en la URL cuando entras al espacio.
- Los proyectos de Clockify deben tener asignado un Cliente. Es el paso que la gente se salta y sin él esto no funciona.
- Hoja `Facturas` (emitidas) con `cliente`, `importe`, `fecha_emision`, `estado`.
- Hoja `Rentabilidad` con: `mes`, `cliente`, `horas`, `facturado`, `precio_hora`, `objetivo`, `desvio_pct`.
- Una hoja o una constante con tu tarifa objetivo por hora (calcúlala así: gastos fijos anuales más el sueldo que quieres, dividido entre las horas facturables reales del año, que suelen ser 1.100-1.300, no 1.800).
- Credenciales: **Google Sheets OAuth2**, **Gmail OAuth2**. Clockify no tiene nodo propio: se usa HTTP Request con la cabecera `X-Api-Key`.

## Los nodos, en orden
1. **Schedule Trigger** — Mode: `Custom (Cron)`, Expression: `0 8 2 * *` (el día 2 de cada mes a las 8:00). Timezone `Europe/Madrid`.
2. **HTTP Request** («Clientes Clockify») — Method: `GET`, URL: `https://api.clockify.me/api/v1/workspaces/TU_WORKSPACE_ID/clients`. Headers: `X-Api-Key` con tu clave. En Options activa Pagination si tienes más de 50 clientes.
3. **HTTP Request** («Informe de horas») — Method: `POST`, URL: `https://reports.api.clockify.me/v1/workspaces/TU_WORKSPACE_ID/reports/summary`. Header `X-Api-Key`. Body Content Type `JSON`, Specify Body `Using JSON`, con este contenido: `{"dateRangeStart": "{{ $now.minus(1,'month').startOf('month').toISO() }}", "dateRangeEnd": "{{ $now.startOf('month').toISO() }}", "summaryFilter": {"groups": ["CLIENT", "PROJECT"]}, "amountShown": "HIDE_AMOUNT"}`.
4. **Google Sheets** («Facturas») — Operation: `Get Row(s)`, Sheet: `Facturas`.
5. **Code** («Cruzar datos») — Mode: `Run Once for All Items`. Código abajo.
6. **Google Sheets** («Guardar») — Operation: `Append or Update Row`, Sheet: `Rentabilidad`, Matching Columns: `mes` y `cliente` (puedes usar una columna combinada `clave` = mes+cliente para que el match sea único).
7. **Gmail** («Informe») — To: tu email. Subject: `Rentabilidad por cliente {{ $json.mes }}`. Message: `{{ $json.texto }}`.

## El código del nodo Code
```javascript
const OBJETIVO = 45;  // tu tarifa objetivo por hora, sin IVA
const num = v => Number(String(v ?? 0).replace(/\./g,'').replace(',','.')) || 0;
const norm = s => String(s || '').trim().toLowerCase();
const ahora = new Date();
const mesAnt = new Date(ahora.getFullYear(), ahora.getMonth() - 1, 1);
const mesStr = mesAnt.toISOString().slice(0,7);
const rep = $('Informe de horas').first().json;
const grupos = rep.groupOne || [];
const horasPorCliente = {};
for (const g of grupos) {
  const nombre = norm(g.name === 'Sin cliente' ? 'sin cliente' : g.name);
  horasPorCliente[nombre] = (horasPorCliente[nombre] || 0) + (g.duration || 0) / 3600;
}
const factPorCliente = {};
for (const it of $('Facturas').all()) {
  const f = it.json;
  if (!f.fecha_emision || String(f.fecha_emision).slice(0,7) !== mesStr) continue;
  const k = norm(f.cliente);
  factPorCliente[k] = (factPorCliente[k] || 0) + num(f.importe);
}
const claves = new Set([...Object.keys(horasPorCliente), ...Object.keys(factPorCliente)]);
const filas = [];
for (const k of claves) {
  const horas = +(horasPorCliente[k] || 0).toFixed(2);
  const facturado = +(factPorCliente[k] || 0).toFixed(2);
  const precioHora = horas ? +(facturado / horas).toFixed(2) : 0;
  filas.push({ mes: mesStr, clave: `${mesStr}|${k}`, cliente: k, horas, facturado, precio_hora: precioHora,
    objetivo: OBJETIVO, desvio_pct: horas ? +(((precioHora - OBJETIVO) / OBJETIVO) * 100).toFixed(1) : 0 });
}
filas.sort((a,b) => b.precio_hora - a.precio_hora);
const totalH = filas.reduce((a,f) => a + f.horas, 0);
const totalF = filas.reduce((a,f) => a + f.facturado, 0);
const linea = f => `${f.cliente.padEnd(22).slice(0,22)} ${String(f.horas).padStart(6)} h  ${f.facturado.toFixed(2).padStart(9)} €  ${f.precio_hora.toFixed(2).padStart(7)} €/h  ${f.desvio_pct > 0 ? '+' : ''}${f.desvio_pct}%`;
const malos = filas.filter(f => f.horas > 2 && f.precio_hora < OBJETIVO * 0.8);
const sinFacturar = filas.filter(f => f.horas > 2 && f.facturado === 0);
const texto = [
  `RENTABILIDAD ${mesStr}`, '',
  `Horas totales: ${totalH.toFixed(1)} h · Facturado: ${totalF.toFixed(2)} € · Media real: ${totalH ? (totalF/totalH).toFixed(2) : 0} €/h (objetivo ${OBJETIVO} €/h)`, '',
  'CLIENTE                 HORAS   FACTURADO   €/HORA   DESVÍO',
  ...filas.map(linea), '',
  malos.length ? `POR DEBAJO DEL OBJETIVO:\n${malos.map(f => `• ${f.cliente}: ${f.precio_hora} €/h. Para llegar a ${OBJETIVO} €/h tendrías que facturarle ${(f.horas * OBJETIVO).toFixed(2)} € en vez de ${f.facturado.toFixed(2)} €.`).join('\n')}` : 'Todos los clientes por encima del objetivo.', '',
  sinFacturar.length ? `HORAS SIN FACTURAR:\n${sinFacturar.map(f => `• ${f.cliente}: ${f.horas} h sin factura este mes. ¿Está pendiente de emitir?`).join('\n')}` : ''
].filter(Boolean).join('\n');
filas[0] = filas[0] || {};
return [...filas.map(f => ({ json: f })), { json: { tipo: 'informe', mes: mesStr, texto } }];
```

## Cómo probarla
- Antes de nada, comprueba en Clockify que todos tus proyectos tienen cliente asignado. Los que no, saldrán como «sin cliente» y desvirtúan el informe.
- Ejecuta solo el nodo «Informe de horas» y mira el JSON: `groupOne` debe traer un elemento por cliente con `duration` en segundos.
- Ojo con el desfase: si facturas el trabajo de enero en marzo, el cruce mes a mes miente. Para igualas y proyectos largos, cambia el filtro de facturas a los últimos 3 meses y divide entre las horas de esos 3 meses.
- Compara el resultado del primer mes con tu intuición. Si un cliente que creías bueno sale mal, mira sus horas por proyecto en Clockify antes de tomar decisiones.

## Qué puede salir mal
- **Nombres distintos**: el cliente se llama «Talleres López SL» en Clockify y «Talleres Lopez» en tu hoja de facturas. Por eso el código normaliza a minúsculas y quita espacios, pero no arregla abreviaturas. Unifica los nombres o añade una hoja de equivalencias.
- **Horas no registradas**: si tu equipo no ficha, el informe dirá que eres rentabilísimo. Basura entra, basura sale. Este flujo obliga a la disciplina del registro horario, que además es obligatorio por ley en España para empleados.
- **Proyectos a precio cerrado**: si cobras 3.000 € por un proyecto de 4 meses, el mes que emites la factura sale espectacular y los otros tres, fatal. Solución: usa la vista acumulada de la hoja `Rentabilidad` (suma horas y facturado de todos los meses del proyecto) en vez de mirar mes a mes.
- **Límites de la API**: Clockify permite 50 peticiones por segundo. Aquí haces 2 al mes, no hay problema. Si tienes miles de entradas, la Reports API pagina: activa Pagination en el HTTP Request.
- **Zona horaria**: el rango de fechas se manda en ISO; con el timezone del workflow en `Europe/Madrid` las horas del último día del mes entran correctamente.

## Cuánto cuesta
- Clockify: gratis para siempre, usuarios ilimitados, incluida la API. Su plan de pago (unos 4 €/usuario/mes) no hace falta para esto.
- Google Sheets, Gmail y n8n auto-alojado: gratis.
- Coste total: 0 €, y es probablemente el informe que más dinero te va a hacer ganar de toda la lista.
- En Make se puede montar con módulos HTTP + Sheets, unas 5 operaciones al mes: plan gratuito de sobra.
