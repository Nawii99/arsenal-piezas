# Radar de suscripciones y subidas de precio…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Vigila los cargos recurrentes de tu cuenta bancaria (software, seguros, cuotas) y te avisa cuando una suscripción sube de precio o aparece una nueva que no recuerdas haber contratado.

## Qué es y qué hace

Lee cada día los movimientos de tu cuenta bancaria con GoCardless Bank Account Data, agrupa los cargos que se repiten con el mismo concepto y guarda su historial de importes en Google Sheets. Si un cargo cambia de importe o aparece uno nuevo, te avisa por Telegram con el importe anterior y el nuevo. Pensado para autónomos y micronegocios con muchas herramientas de pago.

## Cómo usarla

1. Crear cuenta en GoCardless y vincular el banco
2. Preparar la hoja con el historial de cargos
3. Montar el flujo diario en n8n con aviso por Telegram
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando pagas muchas herramientas y cuotas con tarjeta y sospechas que algunas han subido o ya no las usas.

## Cómo ganar dinero con ella

Un negocio pequeño suele arrastrar entre 30 y 150 euros al mes en suscripciones olvidadas o subidas silenciosas. Detectarlas el primer mes ya paga el montaje.

- Auditoría de suscripciones para autónomos: se revisan los cargos del banco y se propone qué cancelar o renegociar.
- Mantenimiento mensual del radar de cargos recurrentes para micropymes con varias herramientas de pago.
- Montaje de un aviso de subidas de precio para una gestoría que atiende a clientes con muchas cuotas.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Lee cada día los movimientos de tu cuenta bancaria, agrupa los cargos que se repiten cada mes con el mismo concepto y guarda su historial de importes en una hoja.
Cuando un cargo recurrente cambia de importe o aparece uno nuevo, te manda un aviso por Telegram con el nombre, el importe viejo y el nuevo. Pensado para autónomos y micronegocios con muchas herramientas de pago.

## Lo que necesitas antes
Una cuenta gratuita en GoCardless Bank Account Data (antes Nordigen): te registras en bankaccountdata.gocardless.com, y en User Secrets creas un `secret_id` y un `secret_key`. Es gratis para uso propio y cubre casi todos los bancos españoles.
Haber vinculado tu cuenta bancaria una vez desde su panel: eso te devuelve un `account_id` (lo copias, es el que usarás en el flujo). El acceso caduca a los 90 días y hay que renovar el consentimiento.
Una hoja de Google Sheets llamada `Suscripciones` con las columnas: `fecha`, `concepto`, `importe`, `estado`.
Un bot de Telegram: hablas con @BotFather, `/newbot`, te da un token; y tu `chat_id` lo sacas escribiendo al bot y abriendo `https://api.telegram.org/bot<TOKEN>/getUpdates`.
n8n instalado (Docker en tu ordenador o servidor, o el plan gratuito de n8n Cloud).

## Los nodos, en orden
**1. Schedule Trigger** — Modo `Days`, cada 1 día, hora 07:00. Ojo: en Settings del flujo pon la zona horaria `Europe/Madrid`.
**2. HTTP Request** (nómbralo `Token`) — Método `POST`, URL `https://bankaccountdata.gocardless.com/api/v2/token/new/`, Body Content Type `JSON`, body: `{"secret_id": "TU_SECRET_ID", "secret_key": "TU_SECRET_KEY"}`. Devuelve un campo `access`.
**3. HTTP Request** (nómbralo `Movimientos`) — Método `GET`, URL `https://bankaccountdata.gocardless.com/api/v2/accounts/TU_ACCOUNT_ID/transactions/`. En Headers añade `Authorization` con valor `=Bearer {{ $json.access }}`. En Query Parameters añade `date_from` con valor `={{ $now.minus(400, 'days').toFormat('yyyy-MM-dd') }}`.
**4. Code** (nómbralo `Detectar recurrentes`) — Modo `Run Once for All Items`. Código abajo.
**5. Google Sheets** — Operación `Append`, documento `Suscripciones`, hoja `Hoja 1`, mapeo manual de `fecha`, `concepto`, `importe`, `estado`.
**6. IF** — Condición: `{{ $json.estado }}` `is not equal to` `igual`. Rama true sigue al aviso.
**7. Telegram** — Operación `Send Message`, chat ID el tuyo, texto: `={{ $json.estado === 'nueva' ? '🆕 Suscripción nueva' : '⚠️ Ha subido' }}: {{ $json.concepto }} — {{ $json.importe }} € (antes {{ $json.anterior }} €)`.

## El código del nodo Code
```javascript
const tx = $input.first().json.transactions.booked;
const norm = s => (s || '').toUpperCase().replace(/[0-9]/g, '').replace(/\s+/g, ' ').trim().slice(0, 25);
const grupos = {};
for (const t of tx) {
  const imp = Number(t.transactionAmount.amount);
  if (imp >= 0) continue;
  const clave = norm(t.creditorName || t.remittanceInformationUnstructured);
  if (!clave) continue;
  grupos[clave] = grupos[clave] || [];
  grupos[clave].push({ fecha: t.bookingDate, importe: Math.abs(imp) });
}
const salida = [];
for (const [concepto, lista] of Object.entries(grupos)) {
  if (lista.length < 2) continue;
  lista.sort((a, b) => a.fecha.localeCompare(b.fecha));
  const ultimo = lista[lista.length - 1];
  const previo = lista[lista.length - 2];
  const dias = (new Date(ultimo.fecha) - new Date(previo.fecha)) / 86400000;
  if (dias < 25 || dias > 400) continue;
  const hoy = new Date().toISOString().slice(0, 10);
  if (ultimo.fecha !== hoy && lista.length > 2) continue;
  let estado = 'igual';
  if (lista.length === 2) estado = 'nueva';
  else if (Math.abs(ultimo.importe - previo.importe) > 0.5) estado = 'subida';
  salida.push({ json: { fecha: ultimo.fecha, concepto, importe: ultimo.importe, anterior: previo.importe, estado } });
}
return salida;
```

## Cómo probarla
Pulsa `Test workflow` con el Schedule desconectado y ejecuta desde el nodo `Token`. Comprueba que `Movimientos` devuelve tus cargos reales.
La primera vez cambia el filtro de fecha del Code (quita la línea de `ultimo.fecha !== hoy`) para ver todas tus recurrentes de golpe y revisar que las detecta bien. Luego vuelve a ponerla.
Cuando el listado te cuadre, activa el flujo con el interruptor de arriba a la derecha.

## Qué puede salir mal
El consentimiento bancario caduca a los 90 días: el nodo `Movimientos` empieza a dar error 401. Solución: renueva el enlace desde el panel de GoCardless y pon un recordatorio trimestral.
Conceptos con números variables (referencias de factura) rompen la agrupación: por eso el código quita dígitos. Si aun así se te duplica un proveedor, baja el `slice(0, 25)` a 15.
Límite de la API: 4 llamadas por cuenta y día en el plan gratuito. Con una ejecución diaria vas sobrado; no lo pongas cada hora.
Avisos repetidos del mismo cargo: si te molesta, añade un nodo Google Sheets `Get Rows` antes del Telegram y filtra los conceptos ya avisados este mes.

## Cuánto cuesta
GoCardless Bank Account Data: gratis para uso propio. Google Sheets y Telegram: gratis. n8n auto-alojado: gratis (un VPS de 5 euros al mes si no lo quieres en tu ordenador). n8n Cloud arranca en unos 20 euros al mes si prefieres no montar nada.
