# Alta automática de cliente al pagar el montaje…

**Tipo:** Receta de automatización · **Área:** Tienda por internet · **Licencia:** CC BY 4.0

Cuando pagan el montaje, quedan registrados, reciben el cuestionario y tú enterado al momento.

## Qué es y qué hace

Flujo de n8n que escucha el evento checkout.session.completed de Stripe cuando alguien paga tu montaje, extrae email, importe y paquete, comprueba que el pago figura como pagado y que el evento no se ha procesado ya, comprueba que el importe corresponde a un paquete válido, añade una fila en Google Sheets para la facturación y envía un correo de bienvenida con el cuestionario. Se monta con cuenta gratuita de Stripe y Google, sin cuota mensual de plataforma.

## Cómo usarla

1. Crea el disparador de Stripe en n8n
2. Extrae email e importe con un nodo Set
3. Comprueba con IF que está pagado y que el evento no está repetido
4. Filtra el paquete con IF y registra en Sheets (con el id del evento)
5. Envía el correo de bienvenida
6. Que lo revise un profesional

## Cuándo usarla

Cobras el montaje con un enlace de pago de Stripe y quieres que, al pagar, el cliente quede registrado y reciba el cuestionario sin tocar nada a mano.

## Cómo ganar dinero con ella

Quita el trabajo administrativo del arranque de tu servicio de montaje de tiendas: cada pago dispara el alta y tú dedicas el tiempo a montar. Cobras por paquete de montaje [TU PRECIO].

- Automatización de altas y facturación para tiendas que cobran con enlaces de Stripe…
- Flujo de alta para consultores que cobran por adelantado sus servicios…
- Mantenimiento mensual del flujo de cobros y registros para pequeños negocios…

**Precio orientativo:** 120–250 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Disparador: nodo "Stripe Trigger", evento checkout.session.completed (o payment_intent.succeeded si usas Payment Links sueltos). Cuenta necesaria: Stripe, gratis crear la cuenta, solo cobra comisión por transacción (no cuota).
Verificación de la firma: el Stripe Trigger de n8n ya verifica la firma del evento. Si en vez de él usas un nodo "Webhook" genérico, comprueba la cabecera Stripe-Signature con tu secreto de firma de webhook (guardado en una credencial o variable de entorno) y descarta el evento si no coincide.
Nodo 1 - "Set": extrae del evento el id del evento (event.id), el estado del pago (payment_status), el email del cliente, el importe pagado, el nombre del producto o paquete de servicio comprado y la fecha.
Nodo 2 - "IF" (pago confirmado): sigue solo si payment_status es "paid" (en checkout.session.completed) o si el evento es payment_intent.succeeded. Si no, el flujo termina sin hacer nada: un checkout completado con pago pendiente o fallido no es un cobro.
Nodo 3 - "Google Sheets" (Get Row(s)): busca en tu hoja de facturación el id del evento en la columna "id_evento". Stripe puede reenviar el mismo evento más de una vez.
Nodo 4 - "IF" (evento nuevo): si el id del evento ya está en la hoja, el flujo termina aquí para no repetir fila, correo, tarjeta ni aviso. Si no está, continúa.
Nodo 5 - "IF": comprueba que el importe corresponde a uno de tus paquetes de montaje (por ejemplo [MONTAJE BÁSICO] o [MONTAJE CON MANTENIMIENTO]), para no procesar pagos de otra cosa si compartes cuenta de Stripe.
Nodo 6 - "Google Sheets" (append row): añade una fila con id_evento, fecha, cliente, email, importe e IVA en tu hoja de facturación. Cuenta de Google gratuita; límite de la API de Sheets 300 peticiones por minuto por proyecto, de sobra para este uso.
Nodo 7 - "Gmail" o "Send Email": envía al cliente un email de bienvenida con el enlace a un cuestionario (Google Forms, gratis) donde te cuenta qué productos quiere vender y si ya tiene web.
Nodo 8 - "Trello" (create card): crea una tarjeta en tu tablero de proyectos con el nombre del cliente y el paquete contratado. Plan gratis de Trello: hasta 10 tableros por espacio de trabajo, suficiente si archivas los antiguos.
Nodo 9 - "Telegram" (send message): te avisa a ti por un bot propio (gratis, se crea con BotFather) de que ha entrado un pago nuevo, con el nombre del cliente y el importe.
Nodo 10 - "NoOp" o "Wait" al final, solo como marcador visual de que el flujo terminó, útil si luego añades más pasos sin desordenar el diagrama.
Aviso de riesgo: si compartes la misma cuenta de Stripe para varios servicios, revisa bien el filtro del nodo IF; un fallo aquí puede mandar cuestionarios equivocados a clientes que compraron otra cosa.
Aviso legal: quien recibe el dinero es el titular de la cuenta de Stripe (tú o tu cliente, según cómo montes el negocio); declara ese ingreso en tu IVA y en tu IRPF como autónomo, esto no lo hace la automatización por ti.
Cómo probarlo sin liarla: activa el modo test de Stripe, genera un pago con la tarjeta de pruebas 4242 4242 4242 4242, ejecuta el workflow en modo "Listen for test event" en n8n y comprueba que aparece la fila en Sheets (y que reenviar el mismo evento desde el panel de Stripe no crea una segunda), la tarjeta en Trello y el aviso en Telegram antes de pasarlo a producción.
Una vez probado, cambia las claves de Stripe de test a producción en las credenciales del nodo Stripe Trigger, y repite una prueba con un cobro real de importe mínimo antes de anunciar el servicio.
