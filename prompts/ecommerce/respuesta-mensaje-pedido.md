# Respuesta a mensajes de clientes sobre su pedido…

**Tipo:** Prompt · **Área:** Tienda por internet · **Licencia:** CC BY 4.0

Plantilla para redactar en segundos la respuesta a un cliente que pregunta por su pedido, su devolución o el estado de su pago, sin repetir el mismo texto a mano cada vez.

## Qué es y qué hace

Es un prompt que redacta en segundos la respuesta a un cliente que pregunta por su pedido, una devolución o el estado de su pago. Entran los datos de la tienda, el número de pedido, los estados de pago y envío y el mensaje literal del cliente; sale una respuesta que confirma el dato pedido y explica el proceso y el plazo sin prometer fechas que no conste. Se pega en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Rellena datos de la tienda y del pedido
2. Pega el mensaje literal del cliente
3. Revisa que la fecha prometida coincida con el envío real

## Cuándo usarla

Requiere: los datos del pedido concreto (número, estado en Stripe, estado de envío) y el mensaje literal del cliente.

## Cómo ganar dinero con ella

Cualquier LLM de uso general (Claude, GPT), pegado directamente en el chat.

- Plantillas de atención al cliente para tiendas pequeñas que responden a mano cada consulta.
- Respuestas a devoluciones con el proceso claro, para reducir mensajes de ida y vuelta.
- Paquete de textos de atención para negocios que venden por internet sin equipo de soporte.

## El prompt (cópialo entero)

```text
Eres el servicio de atención al cliente de una tienda online pequeña. Te voy a pasar el mensaje de un cliente sobre su pedido y tienes que redactar la respuesta.

Datos de la tienda:
- Nombre de la tienda: [NOMBRE_TIENDA]
- Plazo de envío habitual: [PLAZO_ENVIO] días laborables
- Plazo de devolución: [PLAZO_DEVOLUCION] días desde la entrega, según la Ley General para la Defensa de los Consumidores y Usuarios
- Email de contacto: [EMAIL_CONTACTO]

Datos del pedido:
- Número de pedido: [NUMERO_PEDIDO]
- Estado en Stripe: [ESTADO_PAGO]
- Estado de envío: [ESTADO_ENVIO]
- Fecha de compra: [FECHA_COMPRA]

Mensaje del cliente:
[MENSAJE_DEL_CLIENTE]

Redacta una respuesta que:
- Trate al cliente de [USTED_O_TU].
- Confirme el dato concreto que pregunta, sin dar largas.
- Si es una devolución, indique el proceso exacto y el plazo, sin que el cliente tenga que pedirlo dos veces.
- No prometa fechas de envío que no estén confirmadas: si no lo sabes, dilo y da el margen habitual.
- Termine con la firma [NOMBRE_FIRMA] y el email de contacto.
```
