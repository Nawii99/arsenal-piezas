# Prueba diaria del formulario de contacto de punta a pun…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Cada mañana rellena tu propio formulario de contacto con un mensaje marcado y comprueba que el email llega de verdad a tu bandeja. Si no llega, te avisa.

## Qué es y qué hace

Cada mañana envía un formulario de prueba a tu propia web con un texto único y busca ese texto en tu bandeja de entrada. Si el correo no llega en unos minutos, avisa: el formulario o el envío están rotos. Entrada: URL y campos del formulario; salida: resultado de la prueba y aviso. Se monta en n8n con HTTP Request, Gmail y Telegram.

## Cómo usarla

1. Descubrir la URL y los campos del formulario con las herramientas de desarrollo
2. Crear la credencial de Gmail
3. Probar un envío manual
4. Activar la prueba diaria

## Cuándo usarla

Úsalo cuando dependas de los formularios de la web para conseguir clientes, sobre todo después de cambiar de plantilla, plugin o proveedor de correo.

## Cómo ganar dinero con ella

Un formulario roto dos semanas puede costarte todos los presupuestos de ese mes. Detectarlo el mismo día vale más que cualquier campaña.

- Comprobar formularios de captación para despachos y clínicas que viven de los presupuestos.
- Ofrecer el control del formulario tras cada cambio de plantilla o proveedor.
- Montar un informe semanal de formularios que funcionan para un negocio de servicios.

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Envía un formulario de prueba a tu propia web con un texto único, espera unos minutos y busca ese texto en tu bandeja de entrada. Si el email no aparece, te avisa: el formulario está roto o los correos se están perdiendo.
Para negocios de servicios (abogados, clínicas, reformas, agencias) donde el formulario es el canal de ventas.

## Lo que necesitas antes
- n8n auto-alojado o Cloud.
- Saber a qué URL manda datos tu formulario. Ábrelo en el navegador con el clic derecho > Inspeccionar > pestaña Network, rellénalo una vez a mano y mira la petición POST: te da la URL y los nombres exactos de los campos. Es el único paso algo técnico y se hace una sola vez.
- Cuenta de Gmail o Google Workspace donde recibes los avisos, conectada en n8n con la credencial «Gmail OAuth2» (se crea en Google Cloud Console > APIs y servicios > Credenciales, activando la Gmail API).
- Bot de Telegram para el aviso (ver @BotFather).

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: Days, Trigger at Hour: 7, Minute: 30. Timezone Europe/Madrid.
2. **Code** (nombre: «Marca única»). Mode: Run Once for All Items.
```js
const marca = 'QA-' + new Date().toISOString().slice(0,16).replace(/[-:T]/g,'');
return [{ json: { marca, mensaje: 'Mensaje automático de comprobación, ignóralo. Referencia ' + marca } }];
```
3. **HTTP Request** — Method: POST, URL: la del formulario. Body Content Type: Form-Urlencoded (o JSON si tu formulario es de una API). En Body Parameters añade los campos con los nombres EXACTOS que viste en Network, por ejemplo: `your-name` = `Prueba QA`, `your-email` = `qa@tudominio.es`, `your-message` = `={{ $json.mensaje }}`. Si el formulario tiene campos ocultos (nonce, `_wpcf7`, `_wpcf7_unit_tag`), cópialos igual. Options > Never Error activado.
4. **Wait** — Resume: After Time Interval, Wait Amount: 5, Wait Unit: Minutes. Da margen al servidor de correo.
5. **Gmail** — Resource: Message, Operation: Get Many, Return All: off, Limit: 5, Filters > Search: `={{ 'newer_than:1d ' + $('Marca única').first().json.marca }}`. Simple: off.
6. **IF** — Condition: Number, `={{ $items().length }}` (o más fácil: Condition Object is empty sobre `$json`). Si no hay resultados, rama de alarma.
7. **Telegram** — Text: `=🔴 El formulario de contacto NO ha entregado el mensaje de prueba {{ $('Marca única').first().json.marca }}. Revisa el plugin y el SMTP.`
8. Opcional, rama buena: **Gmail** > Operation: Delete (o Add Label «QA») sobre el mensaje encontrado, para no llenar la bandeja.

## Cómo probarla
Ejecuta a mano con «Test workflow». Debe llegarte el email de prueba a tu bandeja y NO debe llegar el Telegram. Después rompe el formulario a propósito (cambia el nombre de un campo en el HTTP Request) y vuelve a ejecutar: ahora sí tiene que llegar el Telegram.

## Qué puede salir mal
- **reCAPTCHA o Turnstile**: si el formulario tiene captcha, la petición fallará siempre. Solución: en el plugin del formulario crea una copia del formulario sin captcha en una URL secreta tipo `/qa-form-9f2b/` y prueba esa; comparte el mismo SMTP, que es lo que quieres vigilar.
- **Honeypot antispam**: algunos formularios exigen que un campo oculto vaya vacío. Déjalo vacío, no lo rellenes.
- **El email tarda más de 5 minutos**: sube el Wait a 10 y baja la frecuencia a una vez al día.
- **Llenas tu CRM de leads falsos**: usa siempre el mismo email `qa@tudominio.es` y crea una regla en el CRM para descartarlo.
- **Te bloquea el WAF** por peticiones repetidas: mete la IP de tu n8n en la lista blanca.

## Cuánto cuesta
Gratis: n8n auto-alojado, Gmail dentro de tu cuenta, Telegram gratis. En n8n Cloud son 30 ejecuciones al mes, entra hasta en el plan más pequeño.
