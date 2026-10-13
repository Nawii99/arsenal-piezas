# Secuencia para pedir reseñas tras la compra…

**Tipo:** JSON prompt · **Área:** Negocio · **Licencia:** CC BY 4.0

Te escribe la serie completa de mensajes post-venta (email y WhatsApp) para que los clientes te dejen reseña sin que tengas que perseguirlos.

## Qué es y qué hace

Prompt JSON que escribe la serie de mensajes post-venta para pedir reseñas: el momento de cada envío según la entrega, un mensaje de satisfacción previo y el de petición para la plataforma elegida, en email y WhatsApp. Respeta el tiempo que tarda el cliente en valorar el producto. Se usa en Claude, Codex, Gemini o una IA local y puede programarse con n8n, Make o Zapier.

## Cómo usarla

1. Indica plataforma, plazos de entrega y tono
2. Genera la serie de mensajes
3. Carga los envíos en tu herramienta o flujo
4. Revisa que no se pida reseña antes de recibir el producto

## Cuándo usarla

Úsalo cuando vendas online y casi nadie te deje reseña, o cuando vayas a lanzar por fin un sistema fijo de petición de opiniones tras cada pedido.

## Cómo ganar dinero con ella

Más reseñas nuevas suben la conversión de la ficha y bajan las dudas previas a comprar, sin gastar en publicidad.

- Automatización de reseñas post-compra para tiendas que no reciben opiniones.
- Sistema de petición de valoraciones en Google o Trustpilot para negocios locales.
- Plantillas de mensajes post-venta para marcas que venden en Amazon o Etsy.

**Precio orientativo:** 100–300 € por sistema. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Diseñar una secuencia completa de solicitud de reseñas post-compra para una tienda online, con mensajes listos para copiar y calendario de envío",
  "contexto": {
    "tienda": "[NOMBRE DE TU TIENDA]",
    "producto_o_categoria": "[PRODUCTO O CATEGORÍA PRINCIPAL]",
    "plataforma_resenas": "[GOOGLE / TRUSTPILOT / JUDGE.ME / LOOX / AMAZON / OTRA]",
    "canal_disponible": "[EMAIL / WHATSAPP / SMS / VARIOS]",
    "dias_hasta_entrega": "[DÍAS MEDIOS DESDE PEDIDO HASTA ENTREGA]",
    "tiempo_para_notar_resultado": "[DÍAS QUE TARDA EL CLIENTE EN VALORAR EL PRODUCTO]",
    "incentivo": "[NINGUNO / DESCUENTO PRÓXIMA COMPRA / SORTEO / PUNTOS]",
    "tono": "[CERCANO Y DIRECTO / FORMAL / DIVERTIDO]"
  },
  "pasos": [
    "Calcular el momento óptimo de cada envío: nunca antes de la entrega, y sumando el tiempo real que tarda el cliente en formarse una opinión",
    "Escribir un primer mensaje de confirmación de satisfacción antes de pedir nada, que permita detectar clientes descontentos y desviarlos a atención al cliente",
    "Escribir la petición principal de reseña, con enlace directo y una sola acción",
    "Escribir un recordatorio suave para quien no respondió, con ángulo distinto al primero",
    "Escribir una petición específica de foto o vídeo para los clientes que ya puntuaron alto",
    "Adaptar cada mensaje a los canales indicados respetando su longitud natural"
  ],
  "restricciones": [
    "No condicionar el incentivo a que la reseña sea positiva: se ofrece por reseñar, sea cual sea la nota",
    "Cumplir la normativa española y europea de reseñas: nada de comprar opiniones ni filtrar solo las buenas",
    "Máximo 90 palabras por email y 45 por mensaje de WhatsApp o SMS",
    "Un solo enlace y una sola llamada a la acción por mensaje",
    "Nada de asuntos con mayúsculas sostenidas, signos repetidos ni palabras tipo urgente o gratis en el asunto"
  ],
  "formato_salida": {
    "tipo": "tabla + bloques de texto",
    "tabla": "Columnas: nº de mensaje, canal, día de envío, objetivo, asunto o primera línea",
    "bloques": "Cada mensaje completo y listo para pegar, con asunto, cuerpo, texto del botón y variables entre llaves",
    "extra": "Lista final de las variables que hay que conectar con la tienda"
  },
  "criterios_calidad": [
    "Cada mensaje se entiende y se responde en menos de 15 segundos de lectura",
    "Ningún mensaje repite el argumento del anterior",
    "El cliente descontento tiene siempre una salida clara que no es la reseña pública",
    "Los tiempos de envío están justificados con una frase que explique el porqué"
```
