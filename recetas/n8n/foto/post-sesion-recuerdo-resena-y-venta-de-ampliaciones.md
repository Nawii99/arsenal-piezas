# Post-sesión: recuerdo, reseña y venta de ampliaciones…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Después de entregar, manda solo el mensaje que toca: recordatorio, petición de reseña en Google y oferta de copias, cada uno a su tiempo.

## Qué es y qué hace

Sobre la hoja de entregas, lanza una secuencia de tres mensajes: a los 3 días un WhatsApp o SMS corto, a los 10 la petición de reseña en Google y a los 30 la oferta de ampliaciones con descuento. Cada mensaje se envía una vez y la secuencia se para si el cliente pide la baja o ya dejó reseña (la petición de reseña va a todos por igual). Entran fechas de entrega y salen mensajes programados y registro. Para fotógrafos y negocios de servicios con entrega puntual, con n8n y Twilio.

## Cómo usarla

1. Añade las columnas de seguimiento a la hoja de clientes
2. Consigue tu enlace de reseña de Google
3. Conecta Twilio en n8n
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando entregas y ahí muere la relación: ni pides reseñas, ni vendes ampliaciones, ni el cliente vuelve al año siguiente.

## Cómo ganar dinero con ella

Cada reseña nueva en Google trae clientes durante años, y la venta de copias añade un 15-25% al ticket sin trabajo extra.

- Secuencia posterior a la entrega para fotógrafos que quieren reseñas y repetir clientes, cobrada por puesta en marcha.
- Gestión mensual de reseñas y ofertas de ampliaciones para estudios, por cuota.
- Plantilla de seguimiento vendida a negocios de servicios locales con entrega puntual.

**Precio orientativo:** 150–300 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Sobre la misma hoja de entregas, monta una secuencia de tres toques: a los 3 días, un mensaje corto por WhatsApp o SMS preguntando qué tal; a los 10, la petición de reseña con enlace directo; a los 30, la oferta de ampliaciones y álbum con un 10% si compran ese mes. Cada mensaje se manda una sola vez y se para si el cliente pide la baja (BAJA o STOP) o si ya dejó reseña. La petición de reseña va a todos los clientes por igual: filtrar según su satisfacción está prohibido por Google y las tiendas.
Para fotógrafos, estudios y cualquier negocio local de servicios con entrega puntual.

## Lo que necesitas antes
- Hoja `Clientes` con columnas: `nombre`, `email`, `telefono`, `tipo_sesion`, `fecha_entrega`, `t1_enviado`, `t2_enviado`, `t3_enviado`, `resena`, `baja`.
- Tu enlace corto para reseñas de Google: en tu Perfil de Empresa, botón `Pedir reseñas`, copia la URL tipo `g.page/r/XXXX/review`.
- Para WhatsApp/SMS: cuenta en twilio.com. Compra un número español (unos 5 €/mes) o usa el sandbox de WhatsApp para pruebas. Apunta `Account SID`, `Auth Token` y el número emisor.
- Si prefieres no pagar Twilio, sustituye los nodos de SMS por **Gmail** y funciona igual, aunque abre menos gente.
- Los teléfonos en formato internacional: `+34600111222`.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 11 * * 2,4`, martes y jueves a las 11. Mejor que a diario: parece menos robot.
2. **Google Sheets** — `Get Row(s)` de `Clientes`.
3. **Code** (`Qué toca hoy`) — decide el toque de cada cliente. Código abajo.
4. **Filter** — Condition: `{{ $json.toque }}` no está vacío.
5. **Switch** — sobre `{{ $json.toque }}`: salidas `T1`, `T2`, `T3`.
6. En la salida T1: **HTTP Request** a Twilio. Method `POST`, URL `https://api.twilio.com/2010-04-01/Accounts/TU_SID/Messages.json`. Authentication `Basic Auth` (usuario SID, contraseña Auth Token). Body Content Type `Form Urlencoded`, parámetros: `From` = `whatsapp:+34XXXXXXXXX`, `To` = `whatsapp:{{ $json.telefono }}`, `Body` = `{{ $json.mensaje }}`.
7. En la salida T2: el mismo nodo Twilio, y además un **Gmail** con el mismo mensaje por si no ve el WhatsApp.
8. En la salida T3: **Gmail** con la oferta, en HTML y con dos o tres fotos suyas incrustadas. Aquí el email funciona mejor que el SMS.
9. **Google Sheets** — `Update Row`, marcando la columna `t1_enviado`, `t2_enviado` o `t3_enviado` con la fecha de hoy.
10. Opcional: un **Webhook** que reciba las respuestas entrantes de Twilio y ponga `baja` a `SI` si el cliente escribe BAJA o STOP.

## El código del nodo Qué toca hoy
```javascript
const RESENA = 'https://g.page/r/TU_CODIGO/review';
const hoy = new Date(); hoy.setHours(0,0,0,0);
const dias = (f) => Math.round((hoy - new Date(f)) / 86400000);
const salida = [];
for (const it of $input.all()) {
  const d = it.json;
  if (!d.fecha_entrega || d.baja === 'SI') continue;
  const n = dias(d.fecha_entrega);
  const nombre = String(d.nombre).split(' ')[0];
  let toque = '', mensaje = '';
  if (!d.t1_enviado && n >= 3 && n < 10) {
    toque = 'T1';
    mensaje = `Hola ${nombre}, soy [TU NOMBRE]. Solo queria saber que tal han quedado las fotos de tu ${d.tipo_sesion}. Si hay alguna que quieras retocar distinto, dimelo sin problema.`;
  } else if (!d.t2_enviado && n >= 10 && n < 30 && d.resena !== 'SI') {
    toque = 'T2';
    mensaje = `Hola ${nombre}, gracias por confiar en mi. Si tienes un minuto, una resena en Google, sea cual sea tu opinion, me ayuda muchisimo a mejorar y a que otras familias me encuentren: ${RESENA} . Mil gracias.`;
  } else if (!d.t3_enviado && n >= 30) {
    toque = 'T3';
    mensaje = `Hola ${nombre}, tus fotos siguen guardadas. Si quieres alguna ampliada o el album impreso, este mes tienes un 10% de descuento. Respondeme y te digo medidas y precios.`;
  }
  if (toque) salida.push({ json: { ...d, toque, mensaje, hoy: hoy.toISOString().slice(0,10) } });
}
return salida;
```

## Cómo probarla
- Métete tú como cliente con tu propio móvil y una `fecha_entrega` de hace 4 días. Lanza a mano y comprueba que llega el T1 y solo el T1.
- Cambia la fecha a hace 12 días, borra el `t1_enviado` de prueba y comprueba el T2.
- Lee los mensajes en voz alta. Si suenan a plantilla, reescríbelos con tus palabras: la automatización es el envío, no el tono.

## Qué puede salir mal
- **WhatsApp por API exige plantillas aprobadas** para iniciar conversación fuera de las 24 horas. Con el sandbox de Twilio pruebas gratis; para producción hay que registrar plantillas en Meta. Si te parece mucho lío, usa SMS o email y funciona.
- **Duplicados.** El truco es marcar la columna justo después del envío. Si el flujo falla a mitad, revisa la hoja antes de relanzar.
- **Cliente que se queja en el T1.** Atiéndelo tú personalmente y rápido, pero no lo saques de la petición de reseña (T2): se manda a todos los clientes por igual, porque Google y las tiendas prohíben pedir reseñas solo a quien está contento.
- **RGPD.** Guarda el consentimiento para comunicaciones comerciales en el contrato de la sesión, incluye siempre cómo darse de baja y no compres bases de datos.
- **Zona horaria.** Fija `Europe/Madrid` en los ajustes del workflow o los mensajes saldrán a las 13:00 en verano.

## Cuánto cuesta
- Twilio: número español desde unos 5 €/mes y cada SMS sobre 0,07 €. WhatsApp por conversación, sobre 0,04-0,08 €.
- Versión solo email: 0 €.
- n8n auto-alojado y Google Sheets: gratis.
