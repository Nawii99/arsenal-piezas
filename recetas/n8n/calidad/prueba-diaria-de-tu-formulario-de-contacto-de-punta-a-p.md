# Prueba diaria de tu formulario de contacto de punta a p…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Rellena y envía tu propio formulario de contacto cada mañana con un código único y comprueba que el aviso llega de verdad a tu correo y a tu hoja de leads.

## Qué es y qué hace

Flujo de n8n que cada mañana rellena tu propio formulario de contacto con un código único y busca ese código en tu bandeja de Gmail y en tu hoja de leads. Entra la petición POST copiada de tu formulario y las credenciales de Gmail y Telegram; sale un aviso si el mensaje no llega. Sirve para detectar a tiempo un formulario roto tras una actualización de plugin.

## Cómo usarla

1. Copia la petición del formulario con Copy as cURL
2. Configura el envío diario con código único
3. Comprueba que el aviso llega a Gmail y a la hoja
4. Activa el aviso a Telegram si falla

## Cuándo usarla

Úsalo cuando dependas de los leads del formulario de la web y te aterre la idea de que lleve semanas roto sin que nadie te avise, algo que pasa tras cada actualización de plugin.

## Cómo ganar dinero con ella

Un formulario roto una semana son todos los presupuestos de esa semana perdidos. Detectarlo el mismo día vale por sí solo cientos de euros.

- Monitorización diaria de formularios para clínicas, asesorías o inmobiliarias que viven de los leads web.
- Servicio de vigilancia mensual de formularios de contacto para agencias con varios clientes.
- Configuración de un sistema de pruebas automáticas de leads para webs de servicios locales.

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**: envía un formulario de prueba con un código irrepetible, espera unos minutos y busca ese código en tu bandeja de entrada. Si no aparece, te avisa. Para negocios de servicios, clínicas, asesorías, agencias e inmobiliarias que viven de los formularios.
**Para quién no es**: si el único canal de contacto es WhatsApp o teléfono.

### Lo que necesitas antes
- **n8n**, cuenta de **Gmail** conectada (la misma donde recibes los avisos del formulario) y **Telegram** con un bot (mira @BotFather).
- **La petición real que hace tu formulario**: abre tu web en Chrome, pulsa F12 > pestaña Network, rellena el formulario con datos falsos y envíalo. Localiza la petición POST (en WordPress suele ser `admin-ajax.php` o `/wp-json/contact-form-7/v1/contact-forms/123/feedback`). Botón derecho > **Copy > Copy as cURL**.
- **Un aviso a tu propio equipo**: crea una etiqueta en Gmail llamada `PRUEBAS` (opcional pero recomendable) y una regla para que estos mensajes se archiven solos.
- **Si usas un formulario sin backend propio** (Tally, Typeform, Fillout, Formspree), todos tienen un endpoint de envío directo que aparece igual en el Network.

### Los nodos, en orden
**1. Schedule Trigger** — Days, cada 1 día, a las 8:00. Timezone `Europe/Madrid`.
**2. Code** («Generar código») — Mode: Run Once for All Items:
```js
const codigo = 'TEST-' + Date.now().toString(36).toUpperCase();
return [{ json: {
  codigo,
  nombre: 'Prueba automatica ' + codigo,
  email: 'pruebas@tudominio.com',
  telefono: '600000000',
  mensaje: 'Mensaje automatico de control de calidad. Codigo ' + codigo + '. Ignorar.'
} }];
```
**3. HTTP Request** («Enviar formulario») — Aquí está el truco: abre el nodo, pulsa el botón **Import cURL** (arriba a la derecha del panel) y pega el cURL que copiaste de Chrome. n8n rellena solo la URL, el método, las cabeceras y el cuerpo. Después sustituye en el cuerpo los valores falsos por expresiones: nombre `{{ $json.nombre }}`, email `{{ $json.email }}`, mensaje `{{ $json.mensaje }}`. Deja las cabeceras tal cual (algunos formularios llevan un nonce; si caduca, mira el apartado de problemas). Options: Never Error activado, Full Response activado.
**4. IF** («¿Aceptó el envío?») — Number: `{{ $json.statusCode }}` is less than `400`. Si es false, salta directo al aviso de error con el motivo «El servidor rechazó el envío».
**5. Wait** — Resume: `After Time Interval`, Wait Amount: `5`, Wait Unit: `Minutes`. Da margen a las colas de correo.
**6. Gmail** («Buscar el aviso») — Resource: Message, Operation: `Get Many`, Return All: desactivado, Limit: `10`. En Options > Search (query de Gmail): `newer_than:1d "{{ $('Generar código').first().json.codigo }}"`. Marca «Always Output Data» en Settings para que no se pare si no hay resultados.
**7. IF** («¿Ha llegado?») — Number: `{{ $items().length }}` is greater than `0`. Alternativa más simple: usa la condición String `{{ $json.id }}` is not empty.
**8. Telegram** (rama false) — Send Message: `🚨 EL FORMULARIO DE LA WEB NO FUNCIONA. Se envió {{ $('Generar código').first().json.codigo }} a las {{ $now.format('HH:mm') }} y no ha llegado ningún email en 5 minutos. Revisa la web ya.`
**9. Gmail** (rama true, opcional) — Operation: `Add Label to Message`, Label: `PRUEBAS`, Message ID: `{{ $json.id }}`. Así no te ensucian la bandeja.
**10. (Opcional) Gmail** — Operation: `Delete` o `Trash` para el mensaje de prueba, si prefieres no acumularlos.

### Cómo probarla
- Ejecútalo a mano con «Test workflow» y mira si te llega el correo de contacto con el código. Debería.
- Ahora rompe el formulario a propósito: en el nodo 3 cambia la URL por una inventada. Ejecuta: debes recibir el aviso de Telegram.
- Deja el `Wait` en 1 minuto mientras pruebas y súbelo a 5 al terminar.

### Qué puede salir mal
- **El formulario usa un nonce o token que caduca** (Contact Form 7, WPForms): el envío empezará a fallar a los días con un 403. Solución: añade antes del nodo 3 un **HTTP Request** GET a la página del formulario y un **Code** que saque el token con una expresión regular (`/name="_wpnonce" value="([^"]+)"/`), y pásalo en el cuerpo.
- **reCAPTCHA activo**: no lo podrás enviar. Alternativa: pide a quien te hizo la web una URL de formulario duplicada sin captcha y con una palabra secreta en la URL, y prueba esa.
- **Falsos positivos por retraso del correo**: sube el Wait a 10 minutos antes de dar por rota la web.
- **Te llenas la bandeja de mensajes de prueba**: usa el nodo 9 o crea un filtro en Gmail que archive todo lo que contenga `TEST-`.
- **Cuidado con el CRM**: si el formulario vuelca en tu CRM, filtra allí los contactos con email `pruebas@tudominio.com` para que no te ensucien las métricas.

### Cuánto cuesta
- **0 €**. n8n auto-alojado, Gmail y Telegram gratis. En n8n cloud, cada Wait cuenta como una ejecución más, así que son 60 ejecuciones al mes: cabe de sobra en cualquier plan.
