# Informe mensual para el cliente con datos de Analytics…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

El día 1 de cada mes reúne visitas, fuentes de tráfico y posiciones en Google de cada cliente, monta un informe legible y lo manda por email con tu firma.

## Qué es y qué hace

El día 1 de cada mes consulta la API de Google Analytics 4 y la de Search Console de cada cliente, calcula las variaciones frente al mes anterior, redacta un informe en HTML con las cifras clave y las tres cosas que más han cambiado, y lo envía por correo al cliente con copia para ti. Entrada: hoja de clientes y credenciales OAuth de Google. Salida: informe HTML por cliente. Se monta en n8n y el patrón puede adaptarse a Make o Zapier.

## Cómo usarla

1. Crea las credenciales OAuth de Google
2. Rellena la hoja de clientes
3. Prueba con un cliente sin enviar
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando mantienes webs de clientes con una cuota mensual y cada mes pierdes una tarde entera haciendo capturas de Analytics y pegándolas en un documento.

## Cómo ganar dinero con ella

Una tarde al mes son 4-6 horas, entre 180 y 270 € de tu tiempo. Además, el cliente que recibe informe cada mes renueva la cuota sin discutir.

- Informe mensual de tráfico y SEO incluido en la cuota de mantenimiento web.
- Reporting automático para agencias con diez o más clientes de analítica.
- Paquete de seguimiento SEO para freelancers que quieren justificar su tarifa cada mes.

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
El día 1 de cada mes consulta la API de Google Analytics 4 y la de Search Console para cada cliente, calcula las variaciones respecto al mes anterior, redacta un informe en HTML con las cifras clave y las tres cosas que más han cambiado, y lo manda al email del cliente con copia a ti.
Para agencias y freelancers con clientes de mantenimiento web o SEO.

## Lo que necesitas antes
- n8n con credencial de **Google OAuth2** que incluya los permisos `analytics.readonly` y `webmasters.readonly`. Se configura en console.cloud.google.com: crea proyecto, activa «Google Analytics Data API» y «Search Console API», crea credenciales OAuth de tipo aplicación web y pega en n8n el Client ID y el Secret (la URL de redirección te la da n8n).
- Ser usuario con permiso de lectura en la propiedad GA4 y en la propiedad de Search Console de cada cliente.
- Hoja «Clientes» con columnas: `nombre`, `email`, `property_id` (el número de la propiedad GA4, lo ves en Administrar > Configuración de la propiedad), `site_url` (tal cual aparece en Search Console, por ejemplo `sc-domain:tudominio.es`).

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 8 1 * *` (día 1 a las 8:00), zona `Europe/Madrid`.
2. **Google Sheets** (*Get Row(s)*) — hoja «Clientes».
3. **Split In Batches** — Batch Size `1`.
4. **HTTP Request** («GA4 mes actual») — POST a `=https://analyticsdata.googleapis.com/v1beta/properties/{{ $json.property_id }}:runReport`, autenticación con tu credencial de Google OAuth2 (Predefined Credential Type). Cuerpo JSON con `dateRanges` de los dos últimos meses completos, `metrics`: sessions, totalUsers, screenPageViews, engagementRate, y `dimensions`: sessionDefaultChannelGroup.
5. **HTTP Request** («Search Console») — POST a `https://www.googleapis.com/webmasters/v3/sites/{{ encodeURIComponent($json.site_url) }}/searchAnalytics/query` con cuerpo `{ "startDate": ..., "endDate": ..., "dimensions": ["query"], "rowLimit": 20 }`.
6. **Code** — junta los dos bloques, calcula porcentajes y escribe el HTML (código abajo).
7. **Gmail** (*Send*) — To `={{ $json.email }}`, Bcc tu correo, asunto `Informe de {{ $json.mes }} — {{ $json.nombre }}`, Message Type `HTML`.
8. **Google Sheets** (*Append Row*) en una hoja «Historico informes» para dejar constancia.
9. Vuelve al **Split In Batches**.

## El nodo Code
```javascript
const cliente = $('Split In Batches').first().json;
const ga = $('GA4 mes actual').first().json;
const sc = $('Search Console').first().json;
function fila(i){ const r = (ga.rows || []).filter(x => x.dateRanges === undefined); return r; }
// GA4 devuelve dos rangos: el actual (date_range_0) y el anterior (date_range_1)
let actual = { sesiones:0, usuarios:0, paginas:0 };
let previo = { sesiones:0, usuarios:0, paginas:0 };
for (const r of (ga.rows || [])) {
  const rango = r.dimensionValues[r.dimensionValues.length - 1].value;
  const destino = rango === 'date_range_0' ? actual : previo;
  destino.sesiones += Number(r.metricValues[0].value || 0);
  destino.usuarios += Number(r.metricValues[1].value || 0);
  destino.paginas += Number(r.metricValues[2].value || 0);
}
function variacion(a, b){ if (!b) return '—'; const v = ((a - b) / b) * 100; return (v >= 0 ? '+' : '') + v.toFixed(1) + '%'; }
const consultas = (sc.rows || []).slice(0, 10).map(r => '<tr><td>' + r.keys[0] + '</td><td>' + r.clicks + '</td><td>' + r.impressions + '</td><td>' + r.position.toFixed(1) + '</td></tr>').join('');
const meses = ['enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiembre','octubre','noviembre','diciembre'];
const d = new Date(); d.setMonth(d.getMonth() - 1);
const mes = meses[d.getMonth()] + ' ' + d.getFullYear();
const html = '<h2>Informe de ' + mes + ' — ' + cliente.nombre + '</h2>' +
 '<p>Hola, aquí tienes el resumen del mes.</p>' +
 '<ul>' +
 '<li>Sesiones: <b>' + actual.sesiones + '</b> (' + variacion(actual.sesiones, previo.sesiones) + ' respecto al mes anterior)</li>' +
 '<li>Usuarios: <b>' + actual.usuarios + '</b> (' + variacion(actual.usuarios, previo.usuarios) + ')</li>' +
 '<li>Páginas vistas: <b>' + actual.paginas + '</b> (' + variacion(actual.paginas, previo.paginas) + ')</li>' +
 '</ul>' +
 '<h3>Búsquedas que más te traen</h3>' +
 '<table border="1" cellpadding="6" cellspacing="0"><tr><th>Búsqueda</th><th>Clics</th><th>Impresiones</th><th>Posición</th></tr>' + consultas + '</table>' +
 '<p>Cualquier duda, me dices y lo vemos.</p>';
return [{ json: { nombre: cliente.nombre, email: cliente.email, mes, html, sesiones: actual.sesiones } }];
```

## Cómo probarla
- Ejecuta a mano con un solo cliente y con tu propio email en la columna `email`. Compara las cifras con lo que ves en la interfaz de GA4 para el mismo periodo: deben cuadrar (puede haber una diferencia mínima por el muestreo).
- Revisa el HTML en el móvil, que es donde lo va a abrir el cliente.
- Cuando esté bien, pon los emails reales y activa.

## Qué puede salir mal
- **Search Console va con 2-3 días de retraso**: si lo lanzas el día 1 a las 8:00, los últimos días del mes anterior pueden venir incompletos. Lánzalo el día 4 (`0 8 4 * *`) y quedará más exacto.
- **La propiedad de Search Console mal escrita**: si el sitio está verificado por dominio hay que poner `sc-domain:tudominio.es`, y si es por prefijo `https://tudominio.es/`. Un carácter de más y da 403.
- **Token de Google caducado**: si el flujo empieza a dar 401, vuelve a autorizar la credencial en n8n.
- **Cuotas**: la API de GA4 tiene un límite de tokens por propiedad y día; con un informe mensual por cliente ni te acercas.
- **Cifras que asustan**: si un mes cae el tráfico, no mandes el informe en frío. Añade un IF que, si la caída supera el 25%, te avise a ti primero y no envíe hasta que tú lo apruebes.

## Cuánto cuesta
- APIs de Google Analytics y Search Console: gratis.
- Gmail: gratis hasta 500 envíos diarios.
- n8n: 0 € auto-alojado. Una ejecución al mes por cliente cabe en cualquier plan.
