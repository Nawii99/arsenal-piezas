# Vigía de copias y certificados en n8n…

**Tipo:** Receta de automatización · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Vigilancia automática semanal de tus webs: responden, certificados vivos, copias en orden.

## Qué es y qué hace

Es una receta de n8n que cada semana revisa las webs de tus clientes: si responden, cuándo caduca el certificado y si las copias están en orden. Te avisa solo cuando hay algo que mirar. Entra una hoja con clientes y URLs, y un canal de aviso; sale un aviso semanal solo si hay fallos. Es vigilancia, no reparación, y solo vale para webs que te han encargado por escrito.

## Cómo usarla

1. Crea la hoja de clientes con URL y contacto
2. Monta el disparador semanal y las comprobaciones
3. Revisa el primer informe y ajusta los avisos

## Cuándo usarla

Para montar una cuota mensual de vigilancia a clientes pequeños con web, tienda o servidor propio.

## Cómo ganar dinero con ella

Cuota de 30 a 60 € al mes por cliente, con informe mensual. Instalación inicial aparte, unos 150 €.

- Cuota mensual de vigilancia para clientes con web o tienda propia.
- Informe mensual de estado de webs como entregable visible al cliente.
- Vigilancia de certificados para agencias que llevan muchas webs pequeñas.

**Precio orientativo:** 30–60 € al mes por cliente. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

# Vigía semanal de copias y certificados (n8n)

Qué consigue: cada lunes revisa los sitios de tus clientes y te avisa solo si hay algo que mirar. Es vigilancia, no reparación.

## Cuentas que hacen falta

- n8n: gratis si lo ejecutas tú (n8n Community, autoalojado). La nube oficial empieza sobre 20 € al mes con límite de ejecuciones.
- Un canal de aviso: Telegram (bot gratis, sin límite práctico) o correo con tu proveedor. Gmail por API tiene cupo gratuito de sobra para esto.
- Opcional, Google Sheets (gratis) como lista de clientes y registro de resultados.

## Nodos, en orden

1. **Schedule Trigger** — disparador. Semanal, lunes a las 8:00, zona horaria Europe/Madrid.
2. **Google Sheets (Get rows)** — lee la hoja `clientes` con columnas: `nombre`, `url`, `avisar_dias_certificado`, `url_prueba_copia`, `contacto`.
3. **Split In Batches** — tamaño 1, para tratar un cliente por vuelta y no saturar.
4. **HTTP Request (web viva)** — GET a `{{$json.url}}`, tiempo máximo 15 segundos, activa «Never Error» para que un fallo no rompa el flujo. Guarda código de estado y tiempo de respuesta.
5. **Code (revisar certificado)** — llama a un servicio público de consulta de caducidad TLS o usa el dato que devuelva tu propio comprobador, y calcula los días que quedan.
6. **HTTP Request (señal de copia)** — GET a `url_prueba_copia`: una dirección que tu script de copias marca con la fecha del último respaldo correcto. Si el cliente no tiene copias, esta rama se salta y el aviso lo dice.
7. **IF (hay algo que avisar)** — condición verdadera si el estado no es 200, o si el certificado caduca en menos de `avisar_dias_certificado`, o si la última copia tiene más de 8 días.
8. **Set (redactar aviso)** — texto corto: nombre del cliente, qué falla, desde cuándo y qué toca hacer. Nada de datos personales del cliente final en el mensaje.
9. **Telegram (Send Message)** o **Gmail (Send)** — el aviso va a ti, no al cliente. Tú decides qué le cuentas y cuándo.
10. **Google Sheets (Append)** — escribe una fila en `registro` con fecha, cliente y resultado. Ese registro es lo que enseñas en la factura mensual.

## Cómo probarla sin liarla

1. Empieza con una sola fila en la hoja y que sea tu propia web.
2. Ejecuta con «Execute Workflow» a mano y mira la salida de cada nodo antes de encadenar el siguiente.
3. Fuerza el fallo a propósito: pon una dirección inventada y comprueba que el aviso llega.
4. Baja `avisar_dias_certificado` a 400 para ver que la rama del certificado dispara, y luego déjalo en 21.
5. Solo cuando todo salga bien, activa el disparador y añade el resto de clientes.

## Límites y cuándo hace falta una persona

- Esto detecta síntomas. No arregla nada y no sustituye a copias de seguridad reales ni a probar una restauración completa al menos dos veces al año.
- Que la web responda 200 no significa que no esté comprometida.
- Pide autorización por escrito antes de vigilar un sitio que no es tuyo, aunque solo sea consultarlo.
- Si el aviso apunta a intrusión, datos filtrados o web secuestrada, no improvises: eso lo lleva el responsable técnico del cliente o un profesional de respuesta a incidentes, y si hay datos personales afectados hay plazos legales de notificación que revisa un abogado.
