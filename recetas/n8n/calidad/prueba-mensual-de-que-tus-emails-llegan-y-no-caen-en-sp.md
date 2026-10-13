# Prueba mensual de que tus emails llegan y no caen en sp…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Manda un correo de prueba a varias bandejas, comprueba si aterriza en entrada o en spam y revisa que SPF, DKIM y DMARC de tu dominio siguen bien puestos.

## Qué es y qué hace

Flujo de n8n que una vez al mes envía un correo de prueba igual a los tuyos a buzones semilla de Gmail, Outlook y tu dominio. Después comprueba en cuál ha caído en spam y consulta por DNS que los registros SPF, DKIM y DMARC existan. Entra tu credencial de envío real y las direcciones de prueba; sale una hoja con el resultado por proveedor. Útil para newsletters y envíos de presupuestos.

## Cómo usarla

1. Crea tres buzones semilla
2. Conecta el envío SMTP real y la lectura de Gmail en n8n
3. Prepara la hoja Entregabilidad
4. Revisa los registros DNS y corrige lo que falle

## Cuándo usarla

Úsalo cuando mandes newsletters, presupuestos o emails automáticos y notes que la gente dice «no me ha llegado», o después de cambiar de proveedor de correo o de hosting.

## Cómo ganar dinero con ella

Caer en spam es perder el 100% del retorno de tu lista. Un servicio de monitorización de entregabilidad cuesta 40-150 €/mes; esta versión básica es gratis.

- Chequeo mensual de entregabilidad para empresas que envían newsletters a su lista de clientes.
- Puesta a punto de SPF, DKIM y DMARC tras cambiar de hosting o de proveedor de correo.
- Informe trimestral de entregabilidad con recomendaciones para agencias que llevan emails de varios clientes.

**Precio orientativo:** 30–60 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Una vez al mes envía un correo idéntico a los que mandas de verdad a varias direcciones tuyas de prueba, espera y comprueba en cuáles ha entrado en la bandeja principal y en cuáles en spam. Además consulta por DNS que tus registros SPF, DKIM y DMARC existan y no estén rotos. Para quien vive de su lista de correo o manda presupuestos por email.

## Lo que necesitas antes
- n8n.
- Direcciones «semilla»: una de Gmail, una de Outlook/Hotmail y una de tu propio dominio. Crea `semilla1@gmail.com` y compañía solo para esto y no las uses para nada más.
- Credencial de envío igual a la que usas de verdad: nodo **Send Email** (SMTP) con los datos de tu proveedor (Brevo, Mailrelay, Zoho, tu hosting) o el nodo **Gmail** si es lo que usas.
- Credencial **Gmail OAuth2** de la semilla de Gmail, para poder leer si el mensaje cayó en spam.
- Hoja «Entregabilidad» con columnas: fecha, gmail, spf, dkim, dmarc, notas.

## Los nodos, en orden
1. **Schedule Trigger** — Days, Trigger at Day of Month: 1, Hour: 9.
2. **Code** (nombre: «Preparar»). `const marca = 'ENTREGA-' + Date.now(); return [{ json: { marca, asunto: 'Novedades de tu pedido y ofertas de este mes ' + marca } }];` (usa un asunto parecido a los tuyos de verdad, con las mismas palabras; si mandas siempre «oferta», pon «oferta»).
3. **Send Email** (SMTP) — From: tu dirección real de envío, To: `semilla1@gmail.com, semilla2@outlook.com, semilla3@tudominio.es`, Subject: `={{ $json.asunto }}`, HTML: pega el HTML de una de tus campañas reales, cambiando los enlaces por los tuyos.
4. **Wait** — 10 Minutes.
5. **Gmail** (nombre: «¿En bandeja?») — Get Many, Filters > Search: `={{ 'in:inbox ' + $('Preparar').first().json.marca }}`, Limit 5, Never Error: on.
6. **Gmail** (nombre: «¿En spam?») — Get Many, Filters > Search: `={{ 'in:spam ' + $('Preparar').first().json.marca }}`, Limit 5, Never Error: on.
7. **HTTP Request** (nombre: «SPF») — GET `https://dns.google/resolve?name=tudominio.es&type=TXT`.
8. **HTTP Request** (nombre: «DMARC») — GET `https://dns.google/resolve?name=_dmarc.tudominio.es&type=TXT`.
9. **HTTP Request** (nombre: «DKIM») — GET `https://dns.google/resolve?name=SELECTOR._domainkey.tudominio.es&type=TXT` (el SELECTOR te lo da tu proveedor de envío: en Brevo suele ser `mail`, en Google `google`).
10. **Code** (nombre: «Veredicto»). Run Once for All Items.
```js
const enBandeja = $('¿En bandeja?').all().length > 0;
const enSpam = $('¿En spam?').all().length > 0;
const txt = (n) => JSON.stringify($(n).first().json.Answer || []);
const spf = /v=spf1/i.test(txt('SPF'));
const dmarc = /v=DMARC1/i.test(txt('DMARC'));
const dkim = /p=/i.test(txt('DKIM'));
const avisos = [];
if (enSpam) avisos.push('Tu correo ha caído en SPAM en Gmail');
if (!enBandeja && !enSpam) avisos.push('El correo no ha llegado a Gmail en 10 minutos');
if (!spf) avisos.push('Falta el registro SPF');
if (!dkim) avisos.push('Falta o está mal el DKIM (revisa el selector)');
if (!dmarc) avisos.push('Falta el registro DMARC');
return [{ json: { fecha: new Date().toISOString().slice(0,10), gmail: enSpam ? 'SPAM' : (enBandeja ? 'Bandeja' : 'No llega'), spf, dkim, dmarc, ok: avisos.length === 0, texto: avisos.join(' | ') } }];
```
11. **Google Sheets** — Append Row a «Entregabilidad».
12. **IF** — Boolean `={{ $json.ok }}` is false → **Telegram** con `=📪 Entregabilidad: {{ $json.texto }}`.

## Cómo probarla
Ejecuta a mano y mira las tres bandejas semilla mientras corre. Para comprobar que la detección de spam funciona, marca a mano como spam en Gmail el correo recibido, vuelve a lanzar solo el paso 6 y verás que lo encuentra. Prueba también poniendo un dominio inventado en el paso 7: debe avisarte de que falta SPF.

## Qué puede salir mal
- **Gmail agrupa por conversación**: por eso la marca única va en el asunto, no repitas asuntos idénticos.
- **Las semillas se «entrenan»**: si abres siempre esos correos, Gmail aprende a meterlos en bandeja y el test se vuelve optimista. No los abras ni los marques; deja que el flujo los lea por API.
- **Esto no es un test de entregabilidad profesional**: te dice si algo va mal a lo bruto. Si mandas a decenas de miles, un servicio tipo GlockApps o el informe DMARC agregado te dará mucho más detalle.
- **DKIM con selector equivocado** da falso negativo: pídele el selector exacto a tu proveedor de envío.
- **Enviar HTML de campaña real** puede disparar tu contador de envíos; con una vez al mes no notarás nada.

## Cuánto cuesta
Gratis: DNS de Google es público, Gmail y Sheets gratis, y el envío entra en el plan que ya pagas de tu proveedor de correo (Brevo regala 300 envíos al día). Solo el hosting de n8n si no lo tienes.
