# Semáforo de tesorería: saldo real a 30 días vista…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cada mañana suma tu saldo bancario, resta los pagos fijos que vienen y suma los cobros previstos. Si en algún día del mes que viene te quedas por debajo de tu colchón, te avisa.

## Qué es y qué hace

Cada mañana lee el saldo real de tu cuenta por open banking de GoCardless, lo cruza con cobros y pagos previstos de una hoja y proyecta los próximos 30 días. Si algún día baja de tu colchón mínimo, avisa con la fecha exacta y el importe que falta. Se monta con n8n, Make o Zapier y necesita una cuenta de GoCardless.

## Cómo usarla

1. Crea la cuenta en GoCardless y obtén secret_id y secret_key
2. Vincula tu cuenta bancaria
3. Prepara la hoja Tesoreria con Previstos y Config
4. Fija tu colchón mínimo
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando vives con el susto de «¿llegaré a fin de mes?» y miras el banco a ojo. Ideal si tienes cuotas fijas (alquiler, nóminas, cuota de autónomo) y cobros que llegan tarde.

## Cómo ganar dinero con ella

Ver un descubierto con 3 semanas de antelación te evita comisiones de descubierto (30-40 € cada una) y créditos de urgencia al 8-10 % TAE.

- Previsión de caja diaria para autónomos con cuotas fijas y cobros tardíos…
- Aviso de descubierto para microempresas que quieren evitar comisiones…
- Configuración de seguimiento de tesorería para negocios estacionales…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

**Qué hace y para quién**
Lee el saldo real de tu cuenta por banca abierta, lo cruza con una hoja de cobros y pagos previstos y proyecta día a día los próximos 30 días. Si algún día la proyección baja de tu colchón mínimo, te manda un aviso con la fecha exacta y cuánto falta.
Pensado para autónomos y micronegocios que no llevan tesorería en ningún sitio más que en la cabeza.

**Lo que necesitas antes**
- n8n (gratis auto-alojado con Docker, o el plan gratuito de n8n Cloud).
- Cuenta gratuita en GoCardless Bank Account Data (antes Nordigen): entras en bankaccountdata.gocardless.com, te registras y en «Developers > User secrets» sacas `secret_id` y `secret_key`. Lectura de cuentas bancarias españolas gratis.
- Una hoja de Google Sheets llamada `Tesoreria` con dos pestañas: `Previstos` (columnas: fecha, concepto, importe, tipo) donde tipo es `cobro` o `pago`; y `Config` con una celda para tu colchón mínimo (por ejemplo 3000).
- Un chat de Telegram contigo mismo (bot creado con @BotFather) o simplemente Gmail.

**Los nodos, en orden**
1. **Schedule Trigger** — todos los días a las 7:30. Ojo: pon la zona horaria `Europe/Madrid` en Settings del workflow, si no te dispara a las 9:30 en verano.
2. **HTTP Request** (nombre: Token) — POST a `https://bankaccountdata.gocardless.com/api/v2/token/new/`, body JSON con `secret_id` y `secret_key`. Devuelve `access`.
3. **HTTP Request** (Saldo) — GET a `https://bankaccountdata.gocardless.com/api/v2/accounts/{ID_CUENTA}/balances/`, cabecera `Authorization: Bearer {{ $json.access }}`. El ID de cuenta lo consigues la primera vez haciendo el flujo de consentimiento con tu banco (lo haces una vez a mano desde su panel).
4. **Google Sheets** (Leer previstos) — operación `Get Row(s)`, hoja `Previstos`.
5. **Merge** — modo `Combine > All possible combinations` para tener saldo y previsiones juntos. Más simple: pon el nodo Code detrás y usa `$('Saldo').first().json`.
6. **Code** — proyecta día a día (código abajo).
7. **IF** — condición: `{{ $json.alerta }}` es igual a `true`.
8. **Telegram** (rama true) — «Send Message» con el texto del aviso. Si prefieres correo, usa **Gmail** > Send Message a ti mismo.
9. **Google Sheets** (rama false o siempre) — «Append» a una pestaña `Historico` con la fecha y el saldo mínimo proyectado, para ver tu evolución.

**El trozo de código (nodo Code)**
```javascript
const colchon = 3000;
const saldo = Number($('Saldo').first().json.balances[0].balanceAmount.amount);
const filas = $('Leer previstos').all().map(i => i.json);
let acumulado = saldo;
const hoy = new Date();
let peorDia = null, peorSaldo = saldo;
for (let d = 0; d < 30; d++) {
  const dia = new Date(hoy.getTime() + d * 86400000);
  const clave = dia.toISOString().slice(0, 10);
  for (const f of filas) {
    const fechaFila = String(f.fecha).slice(0, 10);
    if (fechaFila === clave) {
      const imp = Math.abs(Number(String(f.importe).replace(',', '.')));
      acumulado += (f.tipo === 'cobro' ? imp : -imp);
    }
  }
  if (acumulado < peorSaldo) { peorSaldo = acumulado; peorDia = clave; }
}
const alerta = peorSaldo < colchon;
const texto = alerta
  ? `AVISO TESORERIA: el ${peorDia} te quedas en ${peorSaldo.toFixed(2)} EUR, por debajo de tu colchon de ${colchon} EUR. Faltan ${(colchon - peorSaldo).toFixed(2)} EUR.`
  : `Tesoreria OK. Saldo minimo previsto: ${peorSaldo.toFixed(2)} EUR el ${peorDia || 'sin movimientos'}.`;
return [{ json: { alerta, peorDia, peorSaldo, texto } }];
```

**Cómo probarla**
- Mete a mano en `Previstos` un pago enorme dentro de 10 días (por ejemplo 20.000 €) y ejecuta el workflow con «Execute Workflow». Debe saltar la alerta con esa fecha.
- Bórralo y vuelve a ejecutar: debe darte el mensaje de «Tesoreria OK».
- Comprueba que el saldo que lee coincide con el de tu app del banco (a veces el primer balance del array es «disponible» y otro es «contable»; elige el que uses tú).

**Qué puede salir mal**
- El consentimiento bancario de GoCardless caduca a los 90 días: el nodo dará error 401. Renuévalo desde su panel; añade en el HTTP Request «On Error > Continue» y un aviso por Telegram para enterarte.
- Zona horaria: si no fijas `Europe/Madrid`, las fechas se comparan en UTC y un pago del día 1 puede caer el día 31.
- Fechas en Sheets: escríbelas siempre como `2026-03-14`. Si Sheets te las convierte a formato español, el `slice(0,10)` no casa; formatea la columna como texto.
- Importes con coma: el código ya la convierte a punto, pero no metas separador de miles.

**Cuánto cuesta**
GoCardless Bank Account Data es gratis para uso propio. Google Sheets, Gmail y Telegram, gratis. n8n auto-alojado en un VPS de 5 €/mes, o gratis en tu propio ordenador. El plan gratuito de n8n Cloud da unas 200 ejecuciones al mes: una diaria te sobra.
