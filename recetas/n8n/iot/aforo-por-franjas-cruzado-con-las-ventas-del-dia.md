# Aforo por franjas cruzado con las ventas del día…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Cuenta cuánta gente entra en tu local por franjas de media hora y lo cruza con los tickets para decirte cuántos entran y cuántos compran a cada hora.

## Qué es y qué hace

Dos sensores de distancia en la puerta detectan en qué orden se activan, y así saben si alguien entra o sale. Cada paso llama a un webhook de n8n que lo anota en una franja de media hora. Cada noche cruza ese conteo con los tickets y envía por correo entradas, compras y tasa de conversión por franja. Para tiendas y locales de barrio, con ESP32 y n8n, sin cámaras ni datos de personas.

## Cómo usarla

1. Monta dos sensores VL53L0X separados 10-15 cm
2. Programa en ESPHome el orden de disparo
3. Recibe los pasos en n8n por franja
4. Cruza el conteo con los tickets cada noche

## Cuándo usarla

Cuando tengas tienda o local a pie de calle y no sepas si vendes poco porque entra poca gente o porque entra y se va sin comprar.

## Cómo ganar dinero con ella

Descubrir que a las 18:00 entra el triple de gente y hay un solo dependiente cambia el cuadrante y sube la venta un 5-15 % sin gastar un euro en publicidad.

- Instalación de contador de entradas e informe de conversión para tiendas de barrio u ópticas, cobrado por local.
- Análisis mensual de franjas con propuesta de cuadrante para panaderías o tiendas con horario amplio, por cuota.
- Kit de contador de puerta vendido a integradores de comercio pequeño, con panel de franjas horarias.

**Precio orientativo:** 300–700 € por tienda. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un par de sensores en la puerta detectan el paso y, según el orden en que se activan, saben si alguien entra o sale. Cada paso llama a un webhook de n8n que lo apunta en una franja de media hora. Cada noche se cruza ese conteo con los tickets del día y te llega un correo con entradas, tickets y tasa de conversión por franja.
Para tiendas, panaderías, ópticas, tiendas de barrio y locales con horario amplio.

## Lo que necesitas antes
- Dos sensores de distancia VL53L0X separados 10-15 cm en el marco de la puerta, o dos barreras infrarrojas, conectados a un ESP32. Con dos sabes la dirección; con uno solo cuentas pasos y no distingues entrada de salida.
- ESPHome con un `binary_sensor` por cada uno y una automatización que, al dispararse A antes que B, llame a `https://tu-n8n/webhook/paso?dir=in`, y al revés `dir=out`.
- n8n accesible desde el local (misma red o Cloudflare Tunnel gratuito).
- Los tickets del día: exporta el CSV de tu TPV a una carpeta de Google Drive, o si usas Shopify o similar, usa su nodo nativo en n8n.
- Hoja «Aforo» en Google Sheets con columnas: fecha, franja, entradas, salidas.

## Los nodos, en orden (workflow 1: contar)
1. **Webhook**: GET, path `paso`, Respond Immediately.
2. **Code** «Franja»: calcula la franja de media hora actual.
3. **Google Sheets** (Append or Update, Matching Columns: fecha y franja): suma 1 a entradas o a salidas.

## Los nodos (workflow 2: informe nocturno)
1. **Schedule Trigger**: Cron `30 22 * * 1-6`.
2. **Google Sheets** (Read, hoja «Aforo», filtrando la fecha de hoy).
3. **Google Drive** (Download) del CSV del TPV, o **Shopify** (Get Orders del día).
4. **Code** «Cruzar»: agrupa tickets por franja y calcula conversión.
5. **Gmail** (Send) con la tabla.

## El trozo de código (nodo Code, «Franja»)
```js
const ahora = new Date(new Date().toLocaleString('en-US', { timeZone: 'Europe/Madrid' }));
const h = ahora.getHours();
const m = ahora.getMinutes() < 30 ? '00' : '30';
const franja = `${String(h).padStart(2, '0')}:${m}`;
const fecha = ahora.toISOString().slice(0, 10);
const dir = ($json.query && $json.query.dir) || 'in';
return [{ json: { fecha, franja, entradas: dir === 'in' ? 1 : 0, salidas: dir === 'out' ? 1 : 0 } }];
```

## El trozo de código (nodo Code, «Cruzar»)
```js
const aforo = $('Google Sheets').all().map(i => i.json);
const tickets = $('Google Drive').all().map(i => i.json);
const porFranja = {};
for (const t of tickets) { const hh = String(t.hora || '').slice(0, 5); const f = hh.slice(0, 3) + (Number(hh.slice(3, 5)) < 30 ? '00' : '30'); porFranja[f] = (porFranja[f] || 0) + 1; }
const lineas = aforo.map(a => { const tk = porFranja[a.franja] || 0; const ent = Number(a.entradas) || 0; const conv = ent ? Math.round((tk / ent) * 100) : 0; return `${a.franja} — entran ${ent}, compran ${tk} (${conv}%)`; });
return [{ json: { texto: lineas.join('\n') } }];
```

## Cómo probarla
- Pasa 10 veces por la puerta hacia dentro y comprueba que la hoja marca 10 entradas en la franja correcta.
- Pasa hacia fuera y verifica que suma salidas, no entradas. Si se confunde, invierte los sensores A y B en ESPHome.
- Compara un sábado el conteo con un recuento manual de una hora: un error del 5-10 % es normal y aceptable.

## Qué puede salir mal
- **Grupos que entran juntos**: dos personas hombro con hombro cuentan como una. Es la limitación de los sensores baratos; asúmela como sesgo constante, que para comparar franjas sirve igual.
- **Puerta abierta en verano con gente parada en el marco**: mete un antirrebote en ESPHome (`filters: - delayed_off: 800ms`).
- **Privacidad**: estos sensores no identifican a nadie ni graban imagen, así que no manejas datos personales. Si usas cámara, entras en RGPD y necesitas cartel informativo y base legal; con sensores de distancia te lo ahorras.
- **Volumen de webhooks**: 400 entradas al día son 400 ejecuciones; con n8n Cloud gratuito te quedas corto. Alternativa: que el ESP32 acumule y envíe el total cada 30 minutos en una sola llamada.

## Cuánto cuesta
Software 0 € autoalojado. Hardware: 30-45 € (ESP32 más dos VL53L0X). Un contador comercial equivalente cuesta 300-600 €.
