# Prueba diaria de extremo a extremo del formulario de co…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Rellena tu propio formulario de contacto cada mañana con un código único y comprueba que el correo llega de verdad a tu bandeja. Si no llega, te avisa.

## Qué es y qué hace

Cada mañana envía un mensaje real con un código único a través de tu formulario de contacto, espera unos minutos y busca ese código en tu buzón. Registra el resultado y los minutos de entrega en una hoja y, si no llega, avisa por un canal distinto al buzón probado. Entrada: URL del formulario y Gmail; salida: registro y aviso. Se monta en n8n.

## Cómo usarla

1. Localiza el POST del formulario con F12
2. Conecta Gmail OAuth2 en n8n
3. Crea la hoja pruebas_formulario
4. Usa un segundo canal de aviso

## Cuándo usarla

Úsalo cuando captas clientes por un formulario de la web y un cambio de plugin, de servidor o de correo podría estar tirando mensajes sin que te enteres.

## Cómo ganar dinero con ella

Un formulario roto tres semanas puede costar decenas de contactos. Esto detecta el fallo el mismo día por 0 € de software.

- Prueba diaria de formularios para una web que capta presupuestos.
- Control de captación para un centro que recibe reservas por formulario.
- Registro de fiabilidad del formulario para un autónomo tras cambios de hosting.

**Precio orientativo:** 60–120 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada mañana envía un mensaje real a través de tu formulario de contacto con un código único, espera unos minutos y busca ese código en tu buzón. Si no aparece, te avisa por otra vía.
Para cualquier negocio cuya web tenga formulario de contacto, presupuesto o reserva y no pueda permitirse perder mensajes en silencio.

## Lo que necesitas antes
- n8n.
- Credencial de Gmail en n8n (OAuth2, desde console.cloud.google.com con la API de Gmail activada).
- Saber cómo envía tu formulario: en WordPress con Contact Form 7 o WPForms hay un endpoint POST; lo más fácil es abrir el formulario en el navegador, pulsar F12 > pestaña Network, enviar un mensaje de prueba y copiar la URL a la que hace POST y los nombres de los campos.
- Una hoja `pruebas_formulario` con columnas: `fecha`, `token`, `resultado`, `minutos`.
- Un segundo canal de aviso que NO sea el buzón que estás probando (Telegram o un correo distinto).

## Los nodos, en orden
1. **Schedule Trigger**. `Cron`, todos los días a las 8:15. Expresión: `15 8 * * *`.
2. **Code** (`Run Once for All Items`):
```javascript
const token = 'QA-' + Date.now().toString(36).toUpperCase();
return [{ json: {
  token,
  nombre: 'Prueba interna QA',
  email: 'qa@tudominio.com',
  telefono: '600000000',
  mensaje: 'Prueba automatica, ignorar. Codigo ' + token
} }];
```
3. **HTTP Request**. Método `POST`. URL: la del endpoint del formulario. Body Content Type: `Form-Data` (o `Form Urlencoded`, según lo que viste en Network). Añade cada campo con el nombre exacto que usa tu formulario: `your-name` = `{{ $json.nombre }}`, `your-email` = `{{ $json.email }}`, `your-message` = `{{ $json.mensaje }}`. En Options activa *Response > Never Error* para poder leer el código de estado.
4. **Wait**. `Time Interval`, 5 minutos. (Deja margen a las colas de correo.)
5. **Gmail**. Operación `Get Many`. Activa *Simplify*. En Filters > Search pon: `{{ $('Code').first().json.token }}`. Limit 5.
6. **IF**. Condición: `{{ $input.all().length }}` *larger or equal* `1`. Rama true = todo bien.
7. Rama **true** > **Google Sheets** `Append Row` en `pruebas_formulario` con `resultado` = `OK`.
8. Rama **false** > **Google Sheets** `Append Row` con `resultado` = `FALLO` y luego **Gmail** (a tu correo alternativo) con asunto `El formulario de la web NO entrega mensajes` y cuerpo con el token, el código HTTP de la respuesta (`{{ $('HTTP Request').first().json.statusCode }}`) y la hora.
9. **Gmail**. Operación `Delete` o `Add Label` sobre los mensajes de prueba encontrados, para no ensuciar la bandeja. Si prefieres, crea antes un filtro en Gmail que archive todo lo que contenga `QA-` y le ponga la etiqueta `pruebas`.

## Cómo probarla
- Ejecútala a mano una vez y comprueba que el mensaje de prueba llega y que el token coincide.
- Rompe el formulario a propósito (cambia una letra del nombre de un campo en el HTTP Request) y vuelve a ejecutar: debe saltar la alerta.
- Comprueba que la etiqueta o el borrado funciona y no te quedan 30 mensajes de prueba en la bandeja.

## Qué puede salir mal
- **Captcha**: si tu formulario tiene reCAPTCHA, el POST directo fallará siempre. Solución: crea una segunda copia del formulario en una URL oculta sin captcha (por ejemplo `/qa-formulario`) y prueba esa; comparte el mismo destino de correo.
- **Honeypot antispam**: algunos plugins añaden un campo trampa que debe ir vacío. Déjalo vacío, no lo rellenes.
- **Retraso del correo**: si a veces tarda más de 5 minutos, sube el Wait a 15 y mueve la hora de ejecución.
- **Tu propio filtro de spam**: revisa que la prueba no acabe en Spam; si pasa, ya has encontrado un problema real que arreglar.
- **Falsos positivos por cuota de Gmail API**: n8n reintenta solo; en Settings del nodo Gmail pon *Retry On Fail* con 3 intentos.

## Cuánto cuesta
0 € con n8n autoalojado, Gmail y Sheets gratis. Si usas n8n Cloud, que solo tiene una prueba gratuita temporal y después es de pago, consume una ejecución diaria de tu cupo.
