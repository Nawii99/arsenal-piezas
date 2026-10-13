# Informe semanal de descargas e ingresos de tu app…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Descarga cada lunes los datos de App Store Connect y Google Play, los mete en una hoja y te envía un correo con instalaciones, ingresos y comparación con la semana anterior.

## Qué es y qué hace

Flujo de n8n que cada lunes descarga los informes de ventas y descargas de App Store Connect y de Google Play, los consolida en una hoja de métricas y envía un correo con instalaciones, ingresos y variación frente a la semana anterior. Entran la clave de API de Apple y el acceso al bucket de Google Play; sale una tabla semanal y el correo. Requiere la clave .p8 de Apple y una cuenta de servicio de Google.

## Cómo usarla

1. 1. Crea la clave de API de Apple con rol Sales and Reports
2. 2. Da acceso a tu cuenta de servicio al bucket de Google Play
3. 3. Compara el primer correo con las consolas
4. Que lo revise un profesional

## Cuándo usarla

Cuando cada semana entras a dos consolas distintas a copiar cifras a mano, o cuando no sabes decir de memoria si tu app crece o se hunde.

## Cómo ganar dinero con ella

Quita 1-2 horas semanales de copiar y pegar informes y te da los números el lunes a primera hora para decidir dónde meter el presupuesto de publicidad.

- Informe semanal de ventas para fundadores de apps que quieren dejar de copiar cifras entre consolas.
- Cuadro de mando de descargas e ingresos para agencias que reportan a clientes cada semana.
- Previsión de presupuesto de publicidad para equipos que deben decidir inversión con datos del lunes.

**Precio orientativo:** 150–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Baja los informes de ventas y descargas de las dos tiendas, los consolida en una hoja y te manda un email con las cifras de la semana y el porcentaje de cambio.
Para el fundador que quiere una foto semanal del negocio sin abrir App Store Connect ni Play Console.

## Lo que necesitas antes
- App Store Connect: Usuarios y accesos → Integraciones → Claves de API App Store Connect. Crea una con rol `Sales and Reports`. Apunta el `Key ID`, el `Issuer ID` y descarga el `.p8` (solo se descarga una vez).
- Google Play: en Play Console → Descargar informes → Ventas, verás un bucket de Google Cloud Storage tipo `pubsite_prod_xxxx`. Da acceso de lectura a tu cuenta de servicio.
- Hoja `Metricas` con: `semana`, `tienda`, `instalaciones`, `ingresos_eur`, `desinstalaciones`.
- Gmail conectado.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 7 * * 1`, zona horaria `Europe/Madrid`.
2. **Code** («Firmar JWT Apple») — genera el token de acceso de App Store Connect.
3. **HTTP Request** («Ventas iOS») — GET `https://api.appstoreconnect.apple.com/v1/salesReports` con Query Params: `filter[frequency]`=`WEEKLY`, `filter[reportType]`=`SALES`, `filter[reportSubType]`=`SUMMARY`, `filter[vendorNumber]`=tu número, `filter[reportDate]`=`{{ $now.minus(7,'days').toFormat('yyyy-MM-dd') }}`. Header `Authorization: Bearer {{ $json.token }}`. Response Format: `File`.
4. **Compression** — operación `Decompress` (el informe llega en .gz).
5. **Extract From File** — formato CSV, delimitador tabulador.
6. **HTTP Request** («Ventas Android») — GET al objeto del bucket `https://storage.googleapis.com/pubsite_prod_xxxx/stats/installs/installs_com.tuempresa.tuapp_YYYYMM_overview.csv` con credencial Google Service Account.
7. **Code** («Consolidar») — suma unidades e ingresos por tienda y compara con la semana previa.
8. **Google Sheets** — `Append` en `Metricas`.
9. **Gmail** — Send Message, HTML, con una tabla: instalaciones, ingresos, variación con flechas.

## El código del nodo «Firmar JWT Apple»
```javascript
const jwt = require('jsonwebtoken');
const KEY_ID = 'ABC123DEFG';
const ISSUER_ID = '69a6de00-1111-2222-3333-444444444444';
const PRIVATE_KEY = `-----BEGIN PRIVATE KEY-----\n...pega aquí tu .p8...\n-----END PRIVATE KEY-----`;
const token = jwt.sign({
  iss: ISSUER_ID,
  exp: Math.floor(Date.now() / 1000) + 1000,
  aud: 'appstoreconnect-v1'
}, PRIVATE_KEY, { algorithm: 'ES256', header: { alg: 'ES256', kid: KEY_ID, typ: 'JWT' } });
return [{ json: { token } }];
```

## Cómo probarla
- Ejecuta solo los tres primeros nodos: si el JWT está mal, Apple devuelve 401. Revisa que el `.p8` conserve los saltos de línea (`\n`).
- Compara las cifras del primer informe con lo que ves en App Store Connect para esa misma semana. Deben cuadrar al céntimo.
- Si el CSV llega vacío, cambia `reportDate` a la semana anterior: Apple tarda 1-2 días en publicar.

## Qué puede salir mal
- En n8n auto-alojado hay que permitir el módulo `jsonwebtoken`: arranca el contenedor con `NODE_FUNCTION_ALLOW_EXTERNAL=jsonwebtoken`. En n8n Cloud usa en su lugar el nodo `Crypto` + una plantilla de JWT, o un servicio externo de firma.
- Los informes semanales de Apple solo existen los domingos como fecha de corte. Usa siempre un domingo en `reportDate`.
- Los ingresos vienen en la divisa de cada mercado. Si vendes fuera de la zona euro, añade un HTTP Request a `https://api.frankfurter.app/latest?from=USD&to=EUR` y multiplica.
- Play Console cambia a veces la ruta de los CSV; si falla, entra al bucket y copia el nombre exacto del fichero del mes.

## Cuánto cuesta
Gratis: las dos APIs están incluidas en tu cuenta de desarrollador (99 $/año Apple y 25 $ únicos Google, que ya pagas por publicar). n8n auto-alojado, Sheets y Gmail sin coste.
