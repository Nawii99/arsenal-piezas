# Chivato de facturas vencidas y reclamación automática…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Revisa cada mañana tu hoja de facturas emitidas, detecta las que han pasado de fecha de cobro y manda al cliente un email de recordatorio educado y escalonado.

## Qué es y qué hace

Cada mañana a las 9:00 revisa la hoja de facturas emitidas de Google Sheets, busca las que siguen sin cobrar y con el vencimiento pasado, y envía por Gmail un recordatorio distinto a los 3, 15 y 30 días de retraso. Te manda a ti un resumen de lo pendiente. Pensado para autónomos y pymes que facturan a empresas sin nadie que reclame.

## Cómo usarla

1. Preparar la hoja de facturas con estado y vencimiento
2. Crear credenciales de Google Sheets y Gmail en n8n
3. Probar con facturas de prueba
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando emites facturas a empresas o profesionales con pago a 15, 30 o 60 días y se te acumulan los impagados porque nadie lleva el seguimiento a mano.

## Cómo ganar dinero con ella

Recuperas antes el dinero que ya has facturado y te ahorras entre 2 y 4 horas al mes persiguiendo cobros. Cada factura cobrada 20 días antes es tesorería propia.

- Seguimiento de cobros para despachos y estudios que facturan a empresas a 30 o 60 días.
- Reclamación escalonada mensual para autónomos con varios impagados abiertos.
- Plantilla de recordatorios de pago que el asesor entrega a sus clientes como servicio de cobros.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada día a las 9:00 mira tu hoja de facturas emitidas y busca las que están sin cobrar y con la fecha de vencimiento pasada. A los 3, 15 y 30 días de retraso envía un email distinto al cliente (recordatorio suave, aviso firme y último aviso antes de reclamación) y te manda a ti un resumen de lo pendiente.
Pensado para autónomos y pymes que facturan a otras empresas y no tienen a nadie dedicado a reclamar cobros.

## Lo que necesitas antes
- Una cuenta de Google (gratis) con Gmail y Google Sheets.
- n8n: o bien auto-alojado con Docker en tu ordenador o un VPS de 5 €/mes, o el plan gratuito de n8n Cloud.
- En n8n, credencial **Google Sheets OAuth2** y credencial **Gmail OAuth2**. Se sacan en console.cloud.google.com: creas un proyecto, activas las APIs «Google Sheets API» y «Gmail API», vas a «Credenciales» > «Crear credenciales» > «ID de cliente de OAuth» tipo «Aplicación web», y pegas en «URI de redirección autorizados» la URL que te muestra el propio n8n al crear la credencial.
- Una hoja de Google llamada `Facturas` con estas columnas exactas en la fila 1: `numero`, `cliente`, `email`, `importe`, `fecha_emision`, `fecha_vencimiento`, `estado`, `ultimo_aviso`, `avisos_enviados`. En `estado` escribe `pendiente` o `cobrada`. Las fechas en formato `AAAA-MM-DD`.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: `Days`, Days Between Triggers: `1`, Trigger at Hour: `9`, Trigger at Minute: `0`. En Settings del workflow pon Timezone: `Europe/Madrid` (si no, te disparará a las 10 u 11 según la época del año).
2. **Google Sheets** (renómbralo «Leer facturas») — Resource: `Sheet Within Document`, Operation: `Get Row(s)`, Document: tu hoja `Facturas`, Sheet: `Hoja 1`. Sin filtros: filtramos nosotros en el Code para poder calcular días.
3. **Code** (renómbralo «Calcular avisos») — Mode: `Run Once for All Items`. Código abajo. Devuelve solo las facturas a las que hoy les toca aviso, con el texto ya montado.
4. **IF** — Condition: `Number` > `Array` no; usa `Number`: valor izquierdo `{{ $items().length }}`... más simple: pon un **IF** con condición `Number`, izquierda `{{ $json.importe }}`, operación `is not empty`. Si no hay items, el flujo simplemente no continúa y te ahorras el IF; puedes saltártelo.
5. **Gmail** (renómbralo «Aviso al cliente») — Resource: `Message`, Operation: `Send`. To: `{{ $json.email }}`. Subject: `{{ $json.asunto }}`. Email Type: `Text`. Message: `{{ $json.cuerpo }}`. En Options añade `Sender Name` con el nombre de tu negocio.
6. **Google Sheets** (renómbralo «Marcar aviso») — Operation: `Update Row`, Matching Columns: `numero`, y en Values to Send mapea `numero` = `{{ $json.numero }}`, `ultimo_aviso` = `{{ $json.hoy }}`, `avisos_enviados` = `{{ $json.avisos_nuevos }}`.
7. **Gmail** (renómbralo «Resumen para mí») — conéctalo también desde «Calcular avisos». To: tu propio email. Subject: `Facturas pendientes de cobro`. Message: `{{ $json.cuerpo }}` (el Code ya incluye una línea de resumen en el primer item; si quieres un único email, añade antes un nodo **Aggregate** con Aggregate: `All Item Data`).

## El código del nodo Code
```javascript
const hoy = new Date();
hoy.setHours(0,0,0,0);
const salida = [];
for (const item of $input.all()) {
  const f = item.json;
  if (!f.numero || String(f.estado).toLowerCase() !== 'pendiente') continue;
  if (!f.fecha_vencimiento) continue;
  const venc = new Date(f.fecha_vencimiento + 'T00:00:00');
  const dias = Math.floor((hoy - venc) / 86400000);
  const enviados = Number(f.avisos_enviados || 0);
  let nivel = 0;
  if (dias >= 30) nivel = 3;
  else if (dias >= 15) nivel = 2;
  else if (dias >= 3) nivel = 1;
  if (nivel === 0 || nivel <= enviados) continue;
  const imp = Number(String(f.importe).replace(',', '.')).toFixed(2);
  const textos = {
    1: `Hola ${f.cliente}:\n\nTe escribo por la factura ${f.numero} de ${imp} € con vencimiento el ${f.fecha_vencimiento}. Puede que se haya traspapelado. ¿Me confirmas la fecha prevista de pago?\n\nGracias.`,
    2: `Hola ${f.cliente}:\n\nLa factura ${f.numero} de ${imp} € lleva ${dias} días vencida. Te agradecería que me indiques hoy mismo la fecha de pago o, si hay alguna incidencia, cuál es.\n\nUn saludo.`,
    3: `Hola ${f.cliente}:\n\nLa factura ${f.numero} de ${imp} € acumula ${dias} días de retraso. Si no recibo el pago o una fecha en firme en los próximos 7 días, pasaré el asunto a reclamación formal.\n\nUn saludo.`
  };
  salida.push({ json: {
    numero: f.numero, cliente: f.cliente, email: f.email, importe: imp,
    dias, avisos_nuevos: nivel, hoy: hoy.toISOString().slice(0,10),
    asunto: `Factura ${f.numero} pendiente de pago`,
    cuerpo: textos[nivel]
  }});
}
return salida;
```

## Cómo probarla
- Crea 3 filas falsas con tu propio email en la columna `email` y vencimientos de hace 4, 16 y 35 días. Deja `avisos_enviados` vacío.
- Pulsa **Execute Workflow** y mira el panel del Code: deben salir exactamente 3 items con nivel 1, 2 y 3.
- Desconecta el nodo Gmail la primera vez (clic derecho > Deactivate) para ver los datos sin mandar nada. Luego actívalo y comprueba que recibes los 3 correos y que la hoja se actualiza.
- Vuelve a ejecutar sin cambiar nada: no debe salir ningún item (esa es la prueba de que no duplica).

## Qué puede salir mal
- **Duplicados**: si `avisos_enviados` no se actualiza (nombre de columna mal escrito o Matching Column incorrecta), el cliente recibe el mismo correo cada día. Comprueba siempre esa columna después del primer envío real.
- **Zona horaria**: sin Timezone `Europe/Madrid` en Settings, las fechas se calculan en UTC y un vencimiento del día se cuenta mal. Las fechas en la hoja deben ir como texto `AAAA-MM-DD`, no como fecha con formato español, o el Code las leerá al revés (día/mes).
- **Límites de Gmail**: 500 envíos al día en cuentas gratuitas, 2.000 en Workspace. Muy por encima de lo que necesitas, pero si mandas desde un alias no verificado los correos irán a spam: verifica el alias en Gmail > Configuración > Cuentas.
- **Importes con coma**: si escribes `1.250,50`, el `replace` del código no basta. Escribe los importes con punto decimal y sin separador de miles.
- **Reintentos**: en el nodo Gmail activa Settings > Retry On Fail, con 3 intentos y 5000 ms de espera.

## Cuánto cuesta
- n8n auto-alojado: gratis (te cuesta el VPS, 4-6 €/mes, o cero si lo dejas en tu ordenador encendido). El plan gratuito de n8n Cloud te da ejecuciones limitadas y este flujo consume 1 al día.
- Google Sheets y Gmail: gratis con cuenta personal. Google Workspace desde 6 €/usuario/mes si quieres enviar desde tu dominio.
- En Make se monta igual con módulos Google Sheets + Gmail y entra en el plan gratuito de 1.000 operaciones al mes. En Zapier el plan gratuito no permite varios pasos con filtro; necesitarías el plan Professional (unos 20 €/mes).
