# Servicio automático de plan de nutrición con cobro incluido…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Receta de n8n que recoge los datos de un cliente por formulario, calcula su plan de calorías y macros, genera el menú y la lista de la compra, y solo los envía si el pago se ha confirmado.

## Qué es y qué hace

Receta de n8n que recoge los datos de un cliente por formulario, calcula su plan de calorías y macros, genera menú y lista de la compra, y los envía solo si el pago se ha confirmado (firma y estado de Stripe verificados). Entran el formulario de alta y el cobro; sale un plan por correo solo para clientes que han pagado. Usa Google Forms o Typeform, Stripe, Google Sheets y una API de IA de pago por uso (Claude, Codex, Gemini o una IA local), con n8n gratuito si lo instalas tú.

## Cómo usarla

1. Monta el formulario de alta y el cobro
2. Calcula el plan con IA y guarda el registro
3. Envía el plan solo tras el pago
4. Que lo revise un profesional

## Cuándo usarla

Para montar el servicio de nutrición como algo que funciona sin que tengas que hacer cada paso a mano, cliente por cliente.

## Cómo ganar dinero con ella

n8n (self-hosted gratis o plan Starter de pago), más las cuentas de los servicios que use cada nodo.

- Instalación de un servicio de planes de nutrición que funciona sin atención manual por cliente.
- Mantenimiento mensual del flujo de cobro y envío para un nutricionista con muchos clientes.
- Automatización para un gimnasio que ofrece planes de alimentación de pago a sus socios.

**Precio orientativo:** 150–300 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Cuentas necesarias y su límite gratuito
- n8n: gratis si lo instalas tú mismo (self-hosted); el plan en la nube tiene periodo de prueba y luego es de pago.
- Google Forms o Typeform para el cuestionario: Google Forms es gratis sin límite; Typeform gratis tiene límite de respuestas al mes.
- Stripe o similar para cobrar: gratis de alta, cobra comisión por transacción.
- Un nodo de IA (por ejemplo la API de Claude o de OpenAI) para el cálculo: de pago por uso, revisa el coste por token antes de lanzarlo a muchos clientes.
- Google Sheets para guardar el registro de clientes: gratis.
- Gmail o WhatsApp Business API para enviar el resultado: Gmail gratis con límite diario de envíos; WhatsApp Business API es de pago por conversación.

## Paso a paso, nodo por nodo
1. Disparador: nodo 'Google Sheets Trigger' o 'Webhook' que se activa cuando llega una respuesta nueva del formulario de alta del cliente.
2. Confirmación del pago: usa el nodo Stripe Trigger (comprueba la firma del evento) o, con un Webhook genérico, verifica la cabecera `Stripe-Signature` con el «signing secret» del endpoint, guardado en las credenciales o en una variable de entorno. Comprueba que el pago de ese cliente está confirmado (`payment_status` = `paid`, evento `checkout.session.completed`) y guarda el id del evento para no enviar dos veces el plan. Si no está pagado, el flujo se detiene aquí con un nodo 'IF' y no se genera nada.
3. Nodo 'Set': ordena los datos del formulario en el formato que necesita el cálculo (peso, altura, edad, actividad, objetivo, condiciones médicas).
4. Nodo 'IF': si el campo de condiciones médicas no está vacío, desvía el flujo a una rama que solo manda un aviso a tu email para que revises el caso a mano, y no sigue de forma automática.
5. Nodo de IA (HTTP Request a la API de Claude o similar): envía los datos con el jsonprompt de cálculo del plan y recibe el JSON con calorías y macros.
6. Segundo nodo de IA: con el resultado anterior, pide el menú semanal y la lista de la compra.
7. Nodo 'Google Docs' o 'HTML to PDF': rellena una plantilla con el menú, la lista de la compra y los datos del cliente, y genera el documento final.
8. Nodo 'Gmail' o 'WhatsApp': envía el documento al cliente con un mensaje corto de bienvenida al servicio.
9. Nodo 'Google Sheets': registra la fecha de entrega, el cliente y el estado del pago, para llevar el control del negocio.

## Cómo probarla sin liarla
Antes de activarla para clientes reales, rellena el formulario tú mismo con datos ficticios y con el pago en modo de prueba de Stripe (modo test, sin cobro real). Revisa que el PDF que llega por email tiene sentido y que la rama de 'condición médica' se activa cuando marcas esa casilla, antes de dejar el flujo en producción.

## Qué no hacer
- No actives el envío automático a clientes reales sin haber probado antes con el modo test de la pasarela de pago.
- No mandes un plan automático a nadie que haya marcado una condición médica: esa rama tiene que pasar siempre por revisión humana.
- No uses WhatsApp normal para enviar mensajes automáticos masivos: no es lo mismo que la API de WhatsApp Business y puede acabar en un bloqueo de la cuenta.
