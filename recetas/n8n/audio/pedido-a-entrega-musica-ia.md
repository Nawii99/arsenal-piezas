# De pedido a entrega en un servicio de música con IA…

**Tipo:** Receta de automatización · **Área:** Música y audio · **Licencia:** CC BY 4.0

Encargo en formulario, se cobra en Stripe, alguien lo genera, cliente recibe, queda registrado.

## Qué es y qué hace

Flujo de n8n que recoge el pedido de música con IA en un formulario, cobra el servicio con un enlace de Stripe, espera la confirmación de pago por webhook y avisa a la persona que genera el audio con un resumen. Después entrega el archivo al cliente por correo y registra el pedido en una hoja. La generación sigue siendo manual, porque no hay API pública fiable de Suno ni de Udio.

## Cómo usarla

1. Crea el formulario y el enlace de pago
2. Espera el webhook de Stripe antes de trabajar
3. Avisa al generador y entrega por correo
4. Que lo revise un profesional

## Cuándo usarla

Automatiza el cobro y la entrega, pero deja la generación del audio en manos de una persona porque hoy no hay una API pública fiable de Suno/Udio.

## Cómo ganar dinero con ella

n8n + Stripe + Google Drive + Gmail + Google Sheets…

- Venta y entrega de canciones personalizadas con cobro automático…
- Pedidos de pistas separadas para estudios que trabajan por encargo…
- Gestión de encargos de doblaje musical para agencias pequeñas…

**Precio orientativo:** 200–350 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

1. Disparador: nodo "Form Trigger" de n8n (gratis, incluido) con un formulario donde el cliente elige el servicio (canción a medida, separar pistas, remezcla, doblaje), escribe el brief y deja su email.
2. Nodo de Stripe (Payment Link o Checkout) para cobrar el precio fijo del servicio elegido; la cuenta de Stripe es gratis de crear pero cobra comisión por cada cobro, revisa el porcentaje actual en España antes de fijar precios.
3. Nodo "Webhook" que escucha la confirmación de pago de Stripe antes de seguir: así no se empieza a trabajar en un encargo que no se ha pagado.
4. Nodo "Set" que arma un resumen del pedido (servicio, brief, email del cliente, importe cobrado) para pasarlo al siguiente paso.
5. Nodo "Send Email" o "Telegram" que te avisa a ti (o a tu operador) con ese resumen: hoy no existe una API pública y estable de Suno o Udio, así que la canción se genera a mano, no de forma automática.
6. Aviso de riesgo: si en el futuro usas una API no oficial de estas herramientas para automatizar la generación, revisa antes sus condiciones de uso; usar una vía no soportada puede acabar en el bloqueo de la cuenta con la que generas la música.
7. Paso manual: subes el archivo final a una carpeta de Google Drive (15 GB gratis en la cuenta normal) dentro de una subcarpeta con el nombre del cliente y la fecha del encargo.
8. Nodo "Google Drive: Share" que genera el enlace de descarga del archivo y lo guarda en una variable para usarlo en el correo de entrega.
9. Nodo "Send Email" (Gmail, gratis hasta 500 correos al día en cuenta normal) que manda al cliente el enlace de descarga o el archivo, con un texto de agradecimiento y el aviso de qué licencia de uso tiene el resultado.
10. Nodo "Google Sheets" (gratis) que registra el pedido: fecha, cliente, servicio, importe cobrado, si la factura está emitida o pendiente.
11. Nodo "IF" que comprueba si el cliente pidió factura con NIF; si es así, te avisa a ti para emitirla a mano o conectarlo con tu programa de facturación de autónomos.
12. Cómo probarlo sin liarla: usa la clave de test de Stripe (sin cobros reales), rellena el formulario con tus propios datos y comprueba que el correo final llega y que el enlace de Drive funciona, antes de pasar a las claves reales.
13. Límite a vigilar cada mes: la versión gratuita de n8n cloud tiene un tope de ejecuciones; si lo superas, el flujo se para y el cliente que ya ha pagado no recibe nada, así que revisa el contador antes de que pase eso.
