# Informe mensual automático para el cliente…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

El día 1 de cada mes genera un informe con las visitas, las búsquedas y la velocidad de la web del cliente, con comentario en cristiano, y se lo envía.

## Qué es y qué hace

El día 1 de cada mes pide a GA4 usuarios, sesiones y conversiones del mes anterior y del previo para compararlos, y a Search Console las consultas y páginas con más clics. Monta un correo HTML con la evolución y una frase de conclusión, y lo envía al cliente con copia para ti. Pensado para agencias o freelances con contratos de mantenimiento web.

## Cómo usarla

1. Dar acceso de lectura a GA4 y Search Console
2. Crear credenciales OAuth2 con los scopes de lectura
3. Escribir la plantilla del correo
4. Revisar el primer envío

## Cuándo usarla

Úsalo cuando cobras mantenimiento mensual y justificarlo te lleva media mañana de copiar gráficas de Analytics y Search Console.

## Cómo ganar dinero con ella

Ahorra 1-2 h por cliente y mes y reduce las bajas: el cliente que recibe informe percibe valor. Con 6 clientes son 12 h al mes.

- Informe mensual de analítica para clientes de mantenimiento web de agencias pequeñas.
- Resumen de SEO y tráfico para justificar cuotas de mantenimiento de webs.
- Plantilla de informe automático que el freelance vende como servicio de seguimiento.

**Precio orientativo:** 40–90 € al mes por cliente. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién.** El día 1 a las 8:00 pide a GA4 los usuarios, sesiones y conversiones del mes anterior y del mes previo para comparar, pide a Search Console las 10 consultas y páginas con más clics, monta un email HTML limpio con la evolución y una frase de conclusión, y lo envía al cliente con copia a ti.
Para agencia o freelance con contratos de mantenimiento web.

**Lo que necesitas antes**
- Acceso de lectura a la propiedad GA4 del cliente y a su propiedad de Search Console con tu cuenta de Google.
- En Google Cloud: crea un proyecto, habilita `Google Analytics Data API` y `Google Search Console API`, crea credenciales OAuth2 (tipo Aplicación web) con la Redirect URI que te da n8n, y en n8n crea una credencial `Google OAuth2 API` genérica con los scopes `https://www.googleapis.com/auth/analytics.readonly https://www.googleapis.com/auth/webmasters.readonly`.
- El Property ID de GA4 (número, en Administrar > Detalles de la propiedad) y la URL exacta de la propiedad de Search Console (con `https://` y barra final o el formato `sc-domain:tudominio.com`).
- Hoja `Clientes` con columnas `cliente`, `email`, `ga4_property`, `gsc_site`.

**Los nodos, en orden**
1. **Schedule Trigger** — Interval: Months, Trigger at Day of Month 1, Hour 8.
2. **Google Sheets** — Get Row(s) de `Clientes`.
3. **Code** (`Fechas`) — calcula rangos del mes pasado y del anterior. Código abajo.
4. **HTTP Request** (`GA4`) — POST a `https://analyticsdata.googleapis.com/v1beta/properties/{{ $json.ga4_property }}:runReport`. Authentication: Predefined Credential Type > Google Analytics OAuth2 (o Generic OAuth2 con tu credencial). Body JSON: `{ "dateRanges": [{"startDate":"{{ $json.inicio }}","endDate":"{{ $json.fin }}"},{"startDate":"{{ $json.inicioPrev }}","endDate":"{{ $json.finPrev }}"}], "metrics": [{"name":"totalUsers"},{"name":"sessions"},{"name":"conversions"},{"name":"engagementRate"}] }`.
5. **HTTP Request** (`GA4 canales`) — igual pero añadiendo `"dimensions": [{"name":"sessionDefaultChannelGroup"}]` y `"limit": 8`.
6. **HTTP Request** (`GSC`) — POST a `https://www.googleapis.com/webmasters/v3/sites/{{ encodeURIComponent($json.gsc_site) }}/searchAnalytics/query`, Body JSON: `{ "startDate":"{{ $json.inicio }}", "endDate":"{{ $json.fin }}", "dimensions":["query"], "rowLimit": 10 }`.
7. **Code** (`Montar informe`) — arma el HTML con tablas y la frase de conclusión. Código abajo (versión resumida, amplíala a tu gusto).
8. **Gmail** — To `{{ $('Google Sheets').item.json.email }}`, CC tú, Subject `Informe de {{ $('Fechas').item.json.nombreMes }} - {{ $('Google Sheets').item.json.cliente }}`, Email Type HTML, Message `{{ $json.html }}`.

**El código del nodo `Fechas`**
```js
const salida = [];
for (const item of $input.all()) {
  const hoy = $now.setZone('Europe/Madrid');
  const finMes = hoy.minus({ months: 1 }).endOf('month');
  const iniMes = hoy.minus({ months: 1 }).startOf('month');
  const finPrev = hoy.minus({ months: 2 }).endOf('month');
  const iniPrev = hoy.minus({ months: 2 }).startOf('month');
  salida.push({ json: { ...item.json, inicio: iniMes.toFormat('yyyy-LL-dd'), fin: finMes.toFormat('yyyy-LL-dd'), inicioPrev: iniPrev.toFormat('yyyy-LL-dd'), finPrev: finPrev.toFormat('yyyy-LL-dd'), nombreMes: iniMes.setLocale('es').toFormat('LLLL yyyy') } });
}
return salida;
```

**El código del nodo `Montar informe`**
```js
const ga = $('GA4').first().json;
const filas = ga.rows || [];
const val = (fila, i) => Number(fila?.metricValues?.[i]?.value || 0);
const act = filas[0], ant = filas[1];
const usuarios = val(act, 0), usuariosAnt = val(ant, 0);
const variacion = usuariosAnt ? Math.round(((usuarios - usuariosAnt) / usuariosAnt) * 100) : 0;
const consultas = ($('GSC').first().json.rows || []).map(r => `<tr><td>${r.keys[0]}</td><td>${r.clicks}</td><td>${Math.round(r.position)}</td></tr>`).join('');
const conclusion = variacion >= 10 ? 'Mes de crecimiento claro.' : variacion <= -10 ? 'Mes de bajada: conviene revisar contenidos y campanas.' : 'Mes estable.';
const html = `<h2>Informe de ${$('Fechas').first().json.nombreMes}</h2><p><b>${usuarios}</b> usuarios (${variacion >= 0 ? '+' : ''}${variacion}% respecto al mes anterior). Sesiones: ${val(act,1)}. Conversiones: ${val(act,2)}.</p><p>${conclusion}</p><h3>Que buscan para encontrarte</h3><table border=1 cellpadding=6><tr><th>Busqueda</th><th>Clics</th><th>Posicion media</th></tr>${consultas}</table><p>Cualquier duda, respondeme a este correo.</p>`;
return [{ json: { html, usuarios, variacion } }];
```

**Cómo probarla**
- Ejecuta a mano en cualquier día del mes: te dará el informe del mes anterior. Contrasta la cifra de usuarios con la interfaz de GA4 en el mismo rango; si baila mucho, revisa que el Property ID es el correcto.
- Manda el primer informe solo a ti (quita el email del cliente) hasta que el diseño te guste.

**Qué puede salir mal**
- Search Console tiene 2-3 días de retraso en los datos: pedir el mes cerrado el día 1 suele ir bien, pero si ves ceros, dispara el informe el día 4.
- El token OAuth caduca si no se usa: n8n lo refresca solo mientras la credencial siga autorizada; si el cliente te quita el acceso, el nodo dará 403.
- Propiedades de dominio en Search Console usan el formato `sc-domain:tudominio.com`, sin `https://`. Es el error más típico.
- `conversions` puede no existir si el cliente no tiene eventos marcados: quítala del body o el informe fallará entero.

**Cuánto cuesta**
- APIs de Google: gratis dentro de cuotas amplísimas. Gmail gratis.
- n8n autoalojado gratis; en Cloud, 1 ejecución por cliente y mes.
