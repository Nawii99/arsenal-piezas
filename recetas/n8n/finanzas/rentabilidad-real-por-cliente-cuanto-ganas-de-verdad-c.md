# Rentabilidad real por cliente: cuánto ganas de verdad c

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cruza las horas que dedicas a cada cliente con lo que le facturas y te dice tu precio real por hora. Cada mes te enseña quién te da de comer y quién te está costando dinero.

## Qué es y qué hace

El día 1 de cada mes descarga las horas registradas en Clockify, las cruza con lo facturado a cada cliente en una hoja y calcula el euro por hora real de cada uno. Te envía un informe ordenado de mejor a peor, con los clientes por debajo de tu tarifa objetivo. Se monta con n8n, Make o Zapier y necesita Clockify y una hoja de facturas.

## Cómo usarla

1. Crea tu cuenta de Clockify y su clave de API
2. Registra las horas con el cliente como proyecto
3. Prepara la hoja de facturas emitidas
4. Fija tu tarifa objetivo
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tienes la sensación de que hay un cliente que te absorbe la vida pero no sabes demostrarlo con números.

## Cómo ganar dinero con ella

Identificar y soltar (o resubir) al cliente menos rentable suele mejorar el beneficio anual entre un 10% y un 20% sin facturar ni un euro más.

- Análisis de rentabilidad por cliente como servicio para agencias y consultoras.
- Informe de tarifa real para freelancers que cobran por proyecto.
- Diagnóstico de cartera de clientes para negocios con muchos encargos pequeños.

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
El día 1 de cada mes descarga tus horas registradas en Clockify (gratis y sin límite de usuarios en su plan básico), las cruza con lo facturado a cada cliente en tu hoja y calcula el euro/hora real de cada uno.
Te manda un informe ordenado de mejor a peor, con un aviso de qué clientes están por debajo de tu tarifa objetivo y cuánto tendrías que subirles.
Para consultores, agencias, diseñadores, desarrolladores y cualquier servicio que se venda por proyecto pero se ejecute por horas.

## Lo que necesitas antes
Cuenta gratuita en clockify.me. Saca tu clave en Profile Settings > API > Generate. Apunta también tu Workspace ID (sale en la URL cuando estás dentro).
Registrar las horas con el cliente bien puesto como «Project» en Clockify. Si no registras horas, esta receta no puede hacer magia: empieza por ahí.
Hoja «Facturas emitidas» con Cliente, Total, Base, FechaFactura.
Una pestaña `Objetivo` con una celda TarifaObjetivo (tu euro/hora mínimo aceptable, por ejemplo 45).
Credencial de Google en n8n para Sheets y Gmail.

## Los nodos, en orden
**Schedule Trigger** (llámalo «Día 1 de cada mes»): Cron `0 9 1 * *`. La zona horaria Europe/Madrid se pone en los ajustes del workflow. Conecta los nodos en cadena, uno tras otro, en el orden de esta lista.
**HTTP Request** (renombra a `Horas`): Los informes van por POST en la API de reports: Method POST a `https://reports.api.clockify.me/v1/workspaces/TU_WORKSPACE_ID/reports/summary`. Headers: `X-Api-Key` desde una credencial de n8n (Generic Credential Type > Header Auth, Name `X-Api-Key`, Value tu clave; no la escribas en el nodo: un flujo exportado se la llevaría). Body JSON:
`={{ JSON.stringify({ dateRangeStart: new Date(new Date().getFullYear(), new Date().getMonth()-1, 1).toISOString(), dateRangeEnd: new Date(new Date().getFullYear(), new Date().getMonth(), 0, 23, 59).toISOString(), summaryFilter: { groups: ["PROJECT"] } }) }}`
**Google Sheets** (renombra a `Facturado`): Get Row(s) en «Facturas emitidas», Return All. En las opciones del nodo activa que siempre devuelva datos (*Always Output Data*), para que el flujo siga aunque la hoja venga vacía.
**Google Sheets** (renombra a `Objetivo`): Get Row(s) en pestaña Objetivo. En las opciones del nodo activa que se ejecute una sola vez (*Execute Once*), para que no se repita por cada fila que le llegue de «Facturado».
**Code** (llámalo «Calcular rentabilidad»): modo «Run Once for All Items».
```javascript
// num(): si la hoja ya da un número, se usa tal cual; si es texto, acepta formato español («1.234,56», «1234,56»)
// e inglés («1234.56», «1,234.56»). Con solo puntos en grupos de 3 («1.234») se lee como miles (1234).
const num = (v) => {
  if (typeof v === 'number') return Number.isFinite(v) ? v : 0;
  let s = String(v ?? '').replace(/[€\s ]/g, '');
  if (!s) return 0;
  const coma = s.lastIndexOf(','), punto = s.lastIndexOf('.');
  if (coma > -1 && punto > -1) s = coma > punto ? s.replace(/\./g, '').replace(',', '.') : s.replace(/,/g, '');
  else if (coma > -1) s = (s.match(/,/g).length > 1) ? s.replace(/,/g, '') : s.replace(',', '.');
  else if (/^-?\d{1,3}(\.\d{3})+$/.test(s)) s = s.replace(/\./g, '');
  const n = Number(s);
  return Number.isFinite(n) ? n : 0;
};
// mes «AAAA-MM» de una fecha de la hoja: texto «AAAA-MM-DD», texto «DD/MM/AAAA» o número de serie de Sheets
const mesDe = (v) => {
  if (typeof v === 'number' && v > 0) return new Date(Date.UTC(1899, 11, 30) + v * 86400000).toISOString().slice(0, 7);
  const s = String(v ?? '').trim();
  let m = s.match(/^(\d{4})-(\d{1,2})/);
  if (m) return m[1] + '-' + m[2].padStart(2, '0');
  m = s.match(/^(\d{1,2})\/(\d{1,2})\/(\d{4})/);
  if (m) return m[3] + '-' + m[2].padStart(2, '0');
  return '';
};
const objetivo = num($('Objetivo').first().json.TarifaObjetivo) || 45;
const rep = $('Horas').first().json;
const grupos = rep.groupOne || [];
const horasPorCliente = {};
grupos.forEach(g => { horasPorCliente[String(g.name).toLowerCase().trim()] = (g.duration || 0) / 3600; });
const hoy = new Date();
const mp = new Date(hoy.getFullYear(), hoy.getMonth() - 1, 1);
const mesPasado = mp.getFullYear() + '-' + String(mp.getMonth() + 1).padStart(2, '0');
const facturado = {};
$('Facturado').all().map(i => i.json).filter(f => mesDe(f.FechaFactura) === mesPasado).forEach(f => {
  const c = String(f.Cliente).toLowerCase().trim();
  facturado[c] = (facturado[c] || 0) + num(f.Base);
});
const clientes = [...new Set([...Object.keys(horasPorCliente), ...Object.keys(facturado)])];
const filas = clientes.map(c => {
  const h = horasPorCliente[c] || 0;
  const e = facturado[c] || 0;
  const tarifa = h > 0 ? e / h : 0;
  const subida = tarifa > 0 && tarifa < objetivo ? ((objetivo / tarifa - 1) * 100) : 0;
  return { cliente: c, horas: h, euros: e, tarifa, subida };
}).sort((a,b) => b.tarifa - a.tarifa);
const totalH = filas.reduce((s,f)=>s+f.horas,0);
const totalE = filas.reduce((s,f)=>s+f.euros,0);
const lineas = filas.map(f => `${f.tarifa >= objetivo ? '✅' : '⚠️'} ${f.cliente}: ${f.horas.toFixed(1)} h · ${f.euros.toFixed(0)} € · ${f.tarifa.toFixed(1)} €/h${f.subida > 0 ? ` → subir un ${f.subida.toFixed(0)}%` : ''}`);
const malos = filas.filter(f => f.tarifa > 0 && f.tarifa < objetivo * 0.7);
const informe = `RENTABILIDAD POR CLIENTE — ${mesPasado}\n\nTu tarifa media real: ${totalH > 0 ? (totalE/totalH).toFixed(1) : 0} €/h (objetivo: ${objetivo} €/h)\nHoras trabajadas: ${totalH.toFixed(1)} · Facturado: ${totalE.toFixed(0)} €\n\n${lineas.join('\n')}\n\n${malos.length ? 'CLIENTES QUE TE ESTÁN COSTANDO DINERO:\n' + malos.map(m=>`• ${m.cliente} (${m.tarifa.toFixed(1)} €/h). O le subes el precio, o reduces horas, o le dejas ir.`).join('\n') : 'Ningún cliente por debajo del 70% de tu objetivo. Buen mes.'}`;
return [{ json: { informe } }];
```
**Gmail** (llámalo «Enviar informe»): Resource Message, Operation Send, To tu correo, Subject `=Rentabilidad por cliente`, tipo de correo Text, Message `={{ $json.informe }}`.

## Cómo probarla
Ejecuta a mano el día 5 de un mes con datos reales del mes anterior.
Coge el cliente que crees que es tu mejor cliente y comprueba a mano las horas: si Clockify dice 40 h y tú sabes que fueron 60, el problema es el registro, no el flujo.
Fíjate en que los nombres de proyecto en Clockify coincidan con los nombres de cliente en tu hoja de facturas; el código compara en minúsculas y sin espacios, pero «Bar Manolo» y «Bar Manolo SL» no casarán.

## Qué puede salir mal
Horas no registradas: es el fallo grande. Todo lo que no anotes hace que el cliente parezca más rentable de lo que es. Anota también reuniones, correos y presupuestos.
Proyectos con nombre distinto al cliente: crea en Clockify un cliente por cada cliente real y agrupa por CLIENT en vez de PROJECT (cambia `"PROJECT"` por `"CLIENT"` en el body).
Facturas de un mes por trabajo de otro: si facturas a mes vencido, compara el mes de trabajo con el mes de factura desplazado. Cambia el filtro de FechaFactura si te descuadra.
La API de reportes de Clockify va en el dominio `reports.api.clockify.me`, no en `api.clockify.me`. Es el error típico que da 404.
Plan gratuito de Clockify: los informes de resumen están incluidos, pero algunos informes avanzados son de pago.

## Cuánto cuesta
Clockify: gratis para lo que hace falta aquí (usuarios y proyectos ilimitados).
Sheets y Gmail: gratis. n8n autoalojado: gratis.
