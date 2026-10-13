# Freno de gasto en APIs de pago…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Vigila cada hora cuánto llevas gastado en APIs de terceros, te avisa al 50, 80 y 100 % de tu presupuesto y corta el grifo antes del susto.

## Qué es y qué hace

Consulta cada hora el consumo de tus APIs de pago, lo compara con el presupuesto mensual que fijas, avisa al 50, 80 y 100 % y, al llegar al 100 %, activa un interruptor en Redis o Sheets que tu backend lee antes de cada llamada. Entran claves de solo lectura y la hoja de presupuestos; sale un aviso por tramos y una bandera de corte. Para apps que usan APIs por consumo como IA, SMS o mapas.

## Cómo usarla

1. Pon Redis o una hoja como interruptor
2. Crea claves de solo lectura por proveedor
3. Rellena la hoja Presupuestos
4. Haz que tu backend compruebe el interruptor antes de cada llamada
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando uses APIs que se pagan por uso (IA, SMS, mapas, envíos) y te dé miedo despertarte con una factura de tres cifras por un bucle mal hecho.

## Cómo ganar dinero con ella

Evita facturas descontroladas de cientos de euros por un fallo o un abuso, y te da visibilidad diaria del coste real por servicio.

- Control de costes de APIs para startups, con avisos y corte automático…
- Configuración de límites de gasto para agencias que integran IA en proyectos de clientes…
- Monitorización mensual de consumo de APIs para tiendas con servicios de pago…

**Precio orientativo:** 80–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta el consumo de tus APIs de pago, lo compara con el presupuesto mensual que tú fijas, avisa por tramos y, al llegar al 100 %, activa un interruptor que tu backend consulta para dejar de llamar a esa API. Para quien tiene una app o un servicio que usa APIs por consumo.

## Lo que necesitas antes
- Las claves de las APIs que quieras vigilar, en modo solo lectura si el proveedor lo permite.
- Un Redis accesible (Docker: `docker run -d -p 6379:6379 redis:7-alpine`) o, si prefieres no montar nada, usa una hoja de Sheets como interruptor.
- Una hoja «Presupuestos» con columnas: servicio, url_consumo, presupuesto_eur, gastado_eur, ultimo_aviso.
- Bot de Telegram.
- **Importante**: tu backend debe leer el interruptor. En Redis será la clave `corte:<servicio>`; si vale `1`, tu código no llama a esa API y devuelve un mensaje amable.

## Los nodos, en orden
1. **Schedule Trigger** — cada hora: Interval Hours, 1.
2. **Google Sheets** — Get Row(s) de «Presupuestos».
3. **Split In Batches** — Batch Size 1.
4. **HTTP Request** — URL: `={{ $json.url_consumo }}`, Authentication: la credencial correspondiente (crea una Header Auth por servicio). Options → Never Error on HTTP Status: on.
   Ejemplos de endpoints de consumo: Twilio `https://api.twilio.com/2010-04-01/Accounts/{SID}/Balance.json`; para otros, muchos proveedores exponen `/usage` o `/billing`. Si el tuyo no tiene endpoint, lleva tú la cuenta: cada vez que tu backend llame, que haga un `INCRBYFLOAT` en Redis.
5. **Code** (renómbralo «Calcular tramo») — Run Once for Each Item:
```javascript
const fila = $('Split In Batches').first().json;
const r = $input.item.json;
// Ajusta esta línea al campo que devuelva TU proveedor:
const gastado = Number(r.total_cost ?? r.balance ?? r.usage?.total_usd ?? 0);
const presupuesto = Number(fila.presupuesto_eur || 0);
const pct = presupuesto > 0 ? Math.round((gastado / presupuesto) * 100) : 0;
const tramos = [50, 80, 100];
const ultimo = Number(fila.ultimo_aviso || 0);
const alcanzado = tramos.filter(t => pct >= t).pop() || 0;
return { json: {
  servicio: fila.servicio,
  gastado: Math.round(gastado * 100) / 100,
  presupuesto, pct,
  avisar: alcanzado > ultimo,
  tramo: alcanzado,
  cortar: pct >= 100,
  ultimo_aviso: Math.max(alcanzado, ultimo)
} };
```
6. **Google Sheets** — Update Row (Matching Column `servicio`) con `gastado_eur` y `ultimo_aviso`.
7. **IF** — `{{ $json.cortar }}` is true → **Redis** — Operation: Set, Key: `corte:{{ $json.servicio }}`, Value: `1`, Expire: on, TTL: 86400.
8. **IF** — `{{ $json.avisar }}` is true → **Telegram**:
```
⚠️ {{ $json.servicio }}: {{ $json.pct }}% del presupuesto\nGastado {{ $json.gastado }} € de {{ $json.presupuesto }} €{{ $json.cortar ? '\n🛑 CORTADO hasta que lo reactives' : '' }}
```
9. Vuelve a **Split In Batches**.
10. Añade un flujo aparte con **Schedule Trigger** el día 1 de cada mes (`0 0 1 * *`) que ponga `gastado_eur` y `ultimo_aviso` a 0 y borre las claves `corte:*` de Redis.

## Cómo probarla
- Pon en la hoja un presupuesto de 0,01 € para un servicio real: al ejecutar debe avisarte y cortar.
- Comprueba con `redis-cli get corte:nombre` que la clave vale 1.
- Verifica que tu backend, con esa clave puesta, deja de llamar a la API. Si no lo hace, el freno no sirve de nada.

## Qué puede salir mal
- **Cada API devuelve el consumo con otro nombre**: por eso el Code tiene varios `??`. Ejecuta primero solo el HTTP Request y mira el JSON real antes de ajustar.
- **Retraso en la facturación**: muchos proveedores actualizan el consumo con 15-60 minutos de retraso. Deja margen: pon el presupuesto un 20 % por debajo del que realmente te duele.
- **Corte demasiado agresivo**: si esa API es esencial, cambia el corte por un modo degradado (respuestas cacheadas, cola para más tarde).
- **Redis sin persistencia**: si reinicias el contenedor, se pierde el corte. Arranca Redis con `--appendonly yes` y un volumen.
- **Zona horaria del cierre de mes**: el reinicio a las 00:00 de Madrid puede no coincidir con el ciclo de facturación del proveedor (suele ser UTC). Ajusta el cron a `0 22 L * *` si te importa el detalle.

## Cuánto cuesta
n8n, Redis y Telegram: 0 €. El ahorro llega cuando evitas una sola factura descontrolada.
