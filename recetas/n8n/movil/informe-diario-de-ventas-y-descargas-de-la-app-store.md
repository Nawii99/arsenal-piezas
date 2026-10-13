# Informe diario de ventas y descargas de la App Store…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Descarga cada mañana el informe oficial de ventas de Apple, lo traduce a números claros y te manda descargas, ingresos y países por correo.

## Qué es y qué hace

Receta de n8n que cada mañana se conecta a la API de App Store Connect, descarga el informe de ventas del día anterior, lo interpreta y envía un correo con unidades, ingresos, desglose por país y comparación con el día anterior y con el mismo día de la semana pasada. Entrada: clave de API con rol Finance, número de proveedor y hoja de histórico. Salida: correo diario y datos en Sheets. Requiere firmar el token y descomprimir el informe en un nodo Code.

## Cómo usarla

1. Genera la clave con rol Finance y anota el número de proveedor
2. Activa los módulos de crypto y zlib en n8n
3. Compara una semana con tu panel de Apple
4. Que lo revise un profesional

## Cuándo usarla

Cuando entras a App Store Connect todos los días solo para mirar cuántas descargas llevas, y quieres el dato en el correo con la comparación de ayer.

## Cómo ganar dinero con ella

Cinco minutos al día son 30 horas al año. Además detectas una caída de descargas el mismo día en vez de a final de mes.

- Pulso diario de ventas para una app de pago de un autónomo…
- Informe de ingresos por país para un estudio que vende en varios mercados…
- Alerta de caída de descargas para un negocio con app propia…

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Se conecta a la API de App Store Connect, descarga el informe de ventas del día anterior (un fichero comprimido que Apple entrega en texto separado por tabuladores), lo interpreta y te manda un correo con unidades, ingresos, desglose por país y comparación con el día anterior y con el mismo día de la semana pasada. Para quien vive de la app y quiere el pulso diario sin abrir paneles.

## Lo que necesitas antes
- Clave de API de App Store Connect con rol **Finance** o **Admin**: Users and Access → Integrations → App Store Connect API. Guarda el `.p8`, el Key ID y el Issuer ID.
- Tu **Vendor Number**: está en App Store Connect → Pagos e informes, arriba a la izquierda (un número de 8 dígitos).
- n8n auto-alojado con `NODE_FUNCTION_ALLOW_BUILTIN=crypto,zlib` para firmar el token y descomprimir el informe dentro del nodo Code.
- Hoja de Google Sheets `ventas_diarias` con: fecha, unidades, ingresos_eur, top_pais, ios_version, notas.
- Credencial de Gmail o SMTP.
- Ten claro que **Apple publica el informe con retraso**: el de un día suele estar disponible a partir de las 8-9 de la mañana del día siguiente, hora española.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Days, Trigger at Hour: 10 (para que Apple ya lo tenga listo).
2. **Code** (nombre: Firmar JWT) — el mismo generador de token ES256 de otras recetas de App Store Connect, con `exp` de 15 minutos.
3. **Code** (nombre: Fecha del informe) — calcula la fecha de ayer en formato `AAAA-MM-DD`. `const d = new Date(Date.now() - 86400000); return [{ json: { fecha: d.toISOString().slice(0,10) } }];`
4. **HTTP Request** (nombre: Descargar informe) — GET `https://api.appstoreconnect.apple.com/v1/salesReports`. Headers: `Authorization` = `Bearer {{ $('Firmar JWT').item.json.token }}`, `Accept` = `application/a-gzip`. Query Parameters: `filter[frequency]` = `DAILY`, `filter[reportType]` = `SALES`, `filter[reportSubType]` = `SUMMARY`, `filter[vendorNumber]` = tu número, `filter[reportDate]` = `{{ $json.fecha }}`. Options → Response → Response Format: File, Put Output in Field: `data`. Y Never Error activado, porque un 404 significa «aún no está listo».
5. **IF** — comprueba que la respuesta no es un 404. Si lo es, un **Wait** de 2 horas y reintento.
6. **Code** (nombre: Descomprimir y sumar) — código completo abajo. Devuelve unidades totales, ingresos y el ranking por país.
7. **Google Sheets** — Append Row en `ventas_diarias`.
8. **Google Sheets** — Get Row(s) para recuperar los 7 días anteriores.
9. **Code** (nombre: Comparar) — calcula el cambio frente a ayer y frente al mismo día de la semana pasada, que es la comparación honesta (los fines de semana no se parecen a los martes).
10. **Gmail** — Send. Subject: `📊 {{$json.fecha}}: {{$json.unidades}} descargas ({{$json.varSemana}}% vs semana pasada)`. Message en HTML con la tabla de países.

## El trozo de código (nodo Code «Descomprimir y sumar»)
```javascript
const zlib = require('zlib');
const item = $input.first();
const buf = Buffer.from(item.binary.data.data, 'base64');
const texto = zlib.gunzipSync(buf).toString('utf8');
const lineas = texto.split('\n').filter(l => l.trim());
const cabecera = lineas[0].split('\t');
const idx = (n) => cabecera.indexOf(n);
const iUnidades = idx('Units');
const iPrecio = idx('Developer Proceeds');
const iPais = idx('Country Code');
const iTipo = idx('Product Type Identifier');
const iDivisa = idx('Currency of Proceeds');
let unidades = 0, ingresos = 0;
const porPais = {};
for (const linea of lineas.slice(1)) {
  const c = linea.split('\t');
  const u = parseInt(c[iUnidades] || '0', 10) || 0;
  const p = parseFloat((c[iPrecio] || '0').replace(',', '.')) || 0;
  const tipo = c[iTipo] || '';
  if (tipo.startsWith('1') || tipo.startsWith('7')) unidades += u; // descargas de app
  ingresos += u * p;
  const pais = c[iPais] || '??';
  porPais[pais] = (porPais[pais] || 0) + u;
}
const top = Object.entries(porPais).sort((a,b) => b[1]-a[1]).slice(0,5);
return [{ json: {
  fecha: $('Fecha del informe').first().json.fecha,
  unidades,
  ingresos: Number(ingresos.toFixed(2)),
  divisa: lineas[1] ? lineas[1].split('\t')[iDivisa] : 'EUR',
  top_pais: top[0] ? top[0][0] : '',
  ranking: top.map(([p,u]) => `${p}: ${u}`).join(' · ')
}}];
```

## Cómo probarla
- Ejecuta a mano con una fecha de hace 3 días (seguro que existe) y compara el total con lo que ves en App Store Connect → Ventas y tendencias. Debe cuadrar exactamente.
- Prueba con una fecha de mañana: debe devolver 404 y entrar por la rama de reintento sin romperse.
- Deja el flujo una semana y revisa que la comparación semanal tiene sentido.

## Qué puede salir mal
- **404 con «There were no sales»**: si no vendiste nada ese día, Apple no genera informe. Trátalo como cero, no como error.
- **Los ingresos son «Developer Proceeds»**, o sea, después de la comisión de Apple y antes de impuestos. No es lo mismo que la facturación bruta; dilo en el correo para no confundirte.
- **Divisas mezcladas** si vendes en muchos países: el informe viene en la divisa de cada zona de pago. Suma por divisa o conviértelas con un nodo HTTP a `api.frankfurter.app`.
- **Zona horaria de Apple**: los informes van por día del Pacífico, no de Madrid. Un pico de las 23:00 en España puede caer al día siguiente.
- **Token caducado**: mantén `exp` por debajo de 20 minutos o Apple lo rechaza.

## Cuánto cuesta
Incluido en tu cuenta de desarrollador de Apple (99 €/año, que ya pagas). Sheets y Gmail gratis. n8n auto-alojado 0 €. Coste añadido: 0 €.
