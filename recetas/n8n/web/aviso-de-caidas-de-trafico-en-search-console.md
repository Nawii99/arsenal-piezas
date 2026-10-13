# Aviso de caídas de tráfico en Search Console…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Compara cada semana las páginas de tu web en Google con la semana anterior y te avisa solo de las que se han desplomado, con la palabra clave afectada.

## Qué es y qué hace

Cada martes pide a Search Console los clics por página de los últimos 7 días completos y de los 7 anteriores, calcula la variación y se queda con las páginas que tenían tráfico y han perdido más de un 35 %. Busca qué consulta cayó en cada una y te lo envía a Telegram con el enlace directo. Para quien vive del tráfico orgánico propio o de clientes.

## Cómo usarla

1. Verificar la propiedad en Search Console
2. Crear credencial OAuth2 con scope webmasters.readonly
3. Preparar la hoja Caidas
4. Montar el flujo semanal en n8n

## Cuándo usarla

Úsalo cuando quieres enterarte de una penalización, un cambio de algoritmo o una página rota antes de que el cliente vea la factura de ventas del mes.

## Cómo ganar dinero con ella

Reaccionar en 7 días en vez de en 60 puede salvar la mitad del tráfico perdido. Sustituye herramientas de monitorización de 30-80 €/mes.

- Vigilancia semanal de tráfico para webs de clientes que dependen de Google.
- Alerta de penalizaciones o páginas rotas para tiendas que viven de búsquedas.
- Informe semanal de SEO técnico que el consultor entrega como servicio de vigilancia.

**Precio orientativo:** 80–180 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién.** Cada martes pide a Search Console los clics por página de los últimos 7 días completos y de los 7 anteriores, calcula la variación, se queda solo con las páginas que tenían tráfico apreciable y han perdido más de un 35%, busca qué consulta ha caído en cada una y te lo manda a Telegram con el enlace directo a la página.
Para quien vive del tráfico orgánico, propio o de clientes, y no quiere abrir Search Console todos los días.

**Lo que necesitas antes**
- Propiedad verificada en Search Console y acceso con tu cuenta de Google.
- En Google Cloud: proyecto con `Google Search Console API` habilitada y credencial OAuth2 con scope `https://www.googleapis.com/auth/webmasters.readonly`, cargada en n8n como Google OAuth2 API.
- La cadena exacta del sitio: `https://tudominio.com/` o `sc-domain:tudominio.com`.
- Hoja `Caidas` con columnas `fecha`, `pagina`, `clics_antes`, `clics_ahora`, `variacion`, `consulta`.
- Bot de Telegram y tu chat id.

**Los nodos, en orden**
1. **Schedule Trigger** — Weeks 1, Tuesday, Hour 10 (martes, porque Search Console va con 2-3 días de retraso).
2. **Code** (`Rangos`) — calcula los dos periodos de 7 días acabando hace 3 días. Código abajo.
3. **HTTP Request** (`GSC ahora`) — POST `https://www.googleapis.com/webmasters/v3/sites/{{ encodeURIComponent('sc-domain:tudominio.com') }}/searchAnalytics/query`, Authentication: Predefined Credential Type > Google, Body JSON: `{ "startDate":"{{ $json.iniA }}", "endDate":"{{ $json.finA }}", "dimensions":["page"], "rowLimit": 500 }`.
4. **HTTP Request** (`GSC antes`) — igual con `iniB` y `finB`.
5. **Code** (`Detectar caidas`) — cruza ambos y filtra. Código abajo.
6. **IF** (`Hay caidas?`) — Number `{{ $json.total }}` `larger` `0`.
7. **HTTP Request** (`Consultas de la pagina`) — POST al mismo endpoint con `dimensions: ["query"]` y un `dimensionFilterGroups` que filtre `page` `equals` `{{ $json.pagina }}`, para saber qué palabra ha caído. Ejecuta este bloque dentro de un **Split In Batches** de 1.
8. **Google Sheets** — Append Row en `Caidas`.
9. **Telegram** — Send Message con el resumen.

**El código del nodo `Rangos`**
```js
const fin = $now.setZone('Europe/Madrid').minus({ days: 3 });
const iniA = fin.minus({ days: 6 });
const finB = iniA.minus({ days: 1 });
const iniB = finB.minus({ days: 6 });
const f = (d) => d.toFormat('yyyy-LL-dd');
return [{ json: { iniA: f(iniA), finA: f(fin), iniB: f(iniB), finB: f(finB) } }];
```

**El código del nodo `Detectar caidas`**
```js
const ahora = ($('GSC ahora').first().json.rows || []);
const antes = ($('GSC antes').first().json.rows || []);
const mapaAntes = {};
for (const r of antes) mapaAntes[r.keys[0]] = r;
const caidas = [];
for (const r of ahora) {
  const url = r.keys[0];
  const prev = mapaAntes[url];
  if (!prev || prev.clicks < 10) continue;
  const variacion = Math.round(((r.clicks - prev.clicks) / prev.clicks) * 100);
  if (variacion <= -35) caidas.push({ pagina: url, clics_antes: prev.clicks, clics_ahora: r.clicks, variacion: variacion + '%', posicion: Math.round(r.position) });
}
for (const url of Object.keys(mapaAntes)) {
  if (mapaAntes[url].clicks >= 15 && !ahora.find(r => r.keys[0] === url)) caidas.push({ pagina: url, clics_antes: mapaAntes[url].clicks, clics_ahora: 0, variacion: '-100%', posicion: 0 });
}
caidas.sort((a, b) => a.clics_ahora - b.clics_ahora);
const texto = caidas.slice(0, 15).map(c => `${c.variacion} ${c.pagina} (${c.clics_antes} -> ${c.clics_ahora} clics)`).join('\n');
return caidas.length ? caidas.map((c, i) => ({ json: { ...c, total: caidas.length, mensaje: i === 0 ? `Caidas de trafico esta semana:\n${texto}` : '' } })) : [{ json: { total: 0 } }];
```

**Cómo probarla**
- Ejecuta a mano y compara con el informe de Rendimiento de Search Console con los mismos rangos y comparación: los números deben cuadrar exactamente.
- Baja temporalmente el umbral a `-5` para forzar resultados y comprobar que el mensaje llega bien; luego devuélvelo a `-35`.

**Qué puede salir mal**
- Estacionalidad: agosto y Navidad disparan falsos positivos. Añade una lista de semanas a ignorar o compara con la misma semana del año anterior cambiando los rangos.
- Search Console limita `rowLimit` a 25.000 pero pagina de 500 en 500 con `startRow`: para webs grandes añade un bucle.
- Cuota de la API: 1.200 consultas por minuto y 30.000 al día por propiedad; con esta receta ni te acercas, salvo que consultes cada página por separado en webs enormes. Limita el paso 7 a las 15 peores.
- Propiedad de dominio vs prefijo de URL: si te da 403, casi seguro es el formato del identificador del sitio.
- Datos de los últimos 2-3 días incompletos: por eso el rango acaba hace 3 días.

**Cuánto cuesta**
- Search Console API: gratis. Telegram y Sheets: gratis.
- n8n autoalojado gratis; en Cloud son 4-5 ejecuciones al mes por web.
