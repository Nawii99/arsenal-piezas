# Prueba diaria del formulario de contacto…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Todos los días rellena y envía tu propio formulario de contacto con datos de prueba y comprueba que el correo llega de verdad a tu bandeja.

## Qué es y qué hace

Cada mañana envía a tu formulario de contacto un mensaje de prueba como lo haría una persona, espera unos minutos y busca en Gmail si ha llegado el aviso. Si no aparece, te avisa por Telegram y borra el correo de prueba. Entrada: URL y campos del formulario; salida: aviso de fallo. Se monta en n8n con Gmail y HTTP Request.

## Cómo usarla

1. Localiza la URL del POST y los nombres de los campos con F12
2. Conecta Gmail en n8n
3. Programa el cron diario a las 8:00
4. Revisa el primer resultado

## Cuándo usarla

Cuando tus clientes te escriben por un formulario y no tienes forma de saber si un cambio en la web o el hosting lo ha dejado mudo.

## Cómo ganar dinero con ella

Un formulario roto dos semanas son todos los presupuestos de dos semanas. Detectarlo el mismo día vale más que la automatización entera.

- Prueba automática de formularios para una web que recibe presupuestos.
- Monitor de formularios de contacto para una tienda que depende de consultas por web.
- Revisión diaria de la captación para un autónomo tras cambios de hosting o plugins.

**Precio orientativo:** 60–120 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Envía una petición al formulario igual que la haría una persona, espera unos minutos y busca en tu Gmail si ha llegado el aviso.
Si no llega, te avisa por Telegram. Y de paso borra el correo de prueba para no ensuciarte la bandeja.

## Lo que necesitas antes
- Saber a dónde envía tu formulario. Abre tu página de contacto, pulsa F12, pestaña *Network*, envía el formulario a mano y mira la petición POST: apunta la URL y los nombres de los campos (`your-name`, `your-email`, `your-message` en Contact Form 7; `input_1`, `input_3` en Gravity Forms).
- Credencial de Gmail en n8n (*Credentials > Gmail OAuth2*), con la cuenta que recibe los avisos del formulario.
- Bot de Telegram (con @BotFather) o, si lo prefieres, un segundo correo distinto para los avisos.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 8 * * *`, cada día a las 8:00, `Timezone` `Europe/Madrid`.
2. **Code** («Preparar prueba») — genera un código único para poder buscar ese correo exacto.
3. **HTTP Request** («Enviar formulario») — Method `POST`, tu URL de destino. En *Body* elige `Form-Data` (o `Form-Urlencoded` según cómo lo pida tu web) y añade los campos con los nombres exactos que has apuntado. En el mensaje pon `{{ $json.texto }}`. *Never Error* ON.
4. **Wait** — *Resume* `After Time Interval`, 5 minutos. Da margen a que el correo llegue.
5. **Gmail** — operación *Get Many*, *Return All* OFF con Limit 10, y en *Filters > Search* pon `{{ $json.codigo }}`.
6. **IF** — *Number*: `{{ $items().length }}` **larger** `0`. Si prefieres algo más simple: pon un nodo **Code** que devuelva `{ encontrado: $input.all().length > 0 }` y evalúa eso.
7. **Telegram** (rama false) — «🔴 El formulario de contacto NO está entregando correos. Revísalo.»
8. **Gmail** (rama true) — operación *Delete Message* con el ID del correo encontrado, para limpiar.

## El código del nodo «Preparar prueba»
```javascript
const codigo = 'PRUEBAQA-' + Date.now();
return [{ json: {
  codigo,
  nombre: 'Prueba automatica',
  email: 'pruebas+' + Date.now() + '@tunegocio.es',
  texto: 'Mensaje automatico de control de calidad. Codigo: ' + codigo + '. Ignorar.'
} }];
```

## Cómo probarla
- Ejecuta con *Test workflow* y mira tu bandeja: debe entrar un correo con el código y desaparecer solo unos minutos después.
- Rompe el formulario a propósito: cambia la URL del HTTP Request por una inventada y ejecuta otra vez; te debe llegar el aviso de Telegram.
- Si tu formulario tiene reCAPTCHA, esto no funcionará tal cual: mira el apartado siguiente.

## Qué puede salir mal
- **reCAPTCHA o Turnstile bloquean el envío**: crea en tu web un formulario oculto duplicado, sin captcha, en una URL que solo conozcas tú (`/contacto-monitor`), que use el mismo sistema de envío de correo. Así pruebas la cañería sin pelearte con el captcha.
- **Honeypot antispam**: muchos formularios llevan un campo trampa vacío. Si lo rellenas, te descartan como spam. Envía solo los campos visibles.
- **El correo tarda más de 5 minutos**: sube el Wait a 15 minutos. Con proveedores lentos es habitual.
- **El correo va a spam**: en el nodo Gmail añade `in:anywhere {{ $json.codigo }}` en el buscador para que mire también spam. Y si acaba en spam, eso ya es un aviso en sí mismo.
- **Se te llena la base de datos de leads falsos** si el formulario guarda en un CRM: usa siempre el mismo email de prueba y crea un filtro en tu CRM que los descarte.

## Cuánto cuesta
- Gratis: una ejecución al día en cualquier plan, incluido el gratuito de n8n Cloud, Make (1.000 operaciones/mes) o Zapier (100 tareas/mes).
- Gmail API gratis con cuenta normal o Workspace.
- El nodo Wait en n8n auto-alojado no consume nada mientras espera.
