---
name: pedidos-whatsapp-telegram-botstar
description: "Diseña y prueba un asistente de pedidos para WhatsApp o Telegram con BotStar: catálogo, resumen del pedido, enlace de pago y paso a una persona, respetando las reglas de WhatsApp y de la venta a distancia. Úsala cuando quieras ordenar las ventas que ya te llegan por mensajes."
---
# Asistente de pedidos por WhatsApp y Telegram con BotStar
## Qué hace
Prepara la conversación de venta de principio a fin: saludo, qué quiere el cliente, producto del catálogo, resumen con precio final, enlace de pago y confirmación. Lo que no sea una venta sencilla pasa a una persona.
No monta el bot por su cuenta. Con un conector (MCP) o un flujo de n8n con permiso, puede cargar contenidos como borrador. Sin él, te da los textos y el esquema para pegarlos en BotStar. Mira en tu cuenta qué canales incluye tu plan.
## Reglas de los canales (compruébalas en sus páginas oficiales, porque cambian)
- WhatsApp: usa solo la plataforma oficial (WhatsApp Business Platform, directa o con un proveedor autorizado). Automatizar con métodos no oficiales puede costarte el número.
- Escribir tú primero a un cliente exige su permiso previo y una plantilla aprobada por Meta. Dentro de las 24 horas siguientes a su último mensaje puedes responder en texto libre.
- Meta cobra por los mensajes de plantilla. Mira la tarifa vigente y apunta aquí lo que te toca: [COSTE POR MENSAJE].
- Si el bot conversa con IA, lee la política de Meta sobre IA en WhatsApp Business: restringe los asistentes de uso general. Un bot de tu negocio con tareas concretas es otra cosa, pero confírmalo.
- Telegram: el cliente tiene que iniciar la conversación con el bot. No escribas a quien no la haya empezado.
## Pregunta antes de empezar (todo junto)
- Qué vendes, con qué precios (con IVA incluido si vendes a particulares) y qué variantes (talla, sabor, fecha).
- Catálogo en un archivo o una tabla. Si el stock cambia, de dónde sale. Si el bot no lo ve, no promete.
- Entrega o recogida: zonas, plazos y gastos de envío.
- Cómo se paga: pasarela con enlace de pago (Stripe, Redsys u otra). El bot nunca recoge tarjetas.
- Devoluciones y cancelaciones: pega tu texto.
- A quién se pasa un caso y en qué horario.
- Cómo consiguen tu número los clientes y cómo dan permiso.
## Paso a paso
1. Primer mensaje: avisa de que es un asistente automático, enlaza la política de privacidad y ofrece hablar con una persona.
2. Pregunta lo mínimo: qué quiere, cantidad, variante, y entrega o recogida.
3. Propone solo productos del catálogo. Si algo no está, lo dice y ofrece una persona.
4. Resumen del pedido: producto, cantidad, precio con IVA, envío, total y plazo. Pide un sí claro.
5. Envía el enlace de pago de la pasarela. El pago se hace fuera del chat.
6. Cuando la pasarela confirme el pago, confirma el pedido con los datos reales. Sin confirmación de la pasarela, no confirma.
7. Seguimiento: un aviso de envío o recogida. Un solo recordatorio si el cliente deja el pedido a medias, y solo si el canal lo permite.
8. Pasa a una persona si: pide hablar con alguien, hay devolución o reclamación, el pedido supera [IMPORTE A PARTIR DEL QUE REVISA UNA PERSONA], algo no está en el catálogo o el bot falla dos veces seguidas.
9. Pruebas: 25 conversaciones, con cambios de idea, cantidades raras, pedidos sin stock, quejas y alguien que intenta sacar un descuento. Un pedido de prueba con el modo de pruebas de la pasarela. Ningún cobro real.
10. Piloto con pocos clientes y una persona leyendo las conversaciones cada día.
## Qué devuelve
- Mapa de la conversación en pasos numerados.
- Texto de cada mensaje, listo para pegar.
- Plantillas de WhatsApp propuestas (confirmación, envío, recogida) en el formato que pide Meta, pendientes de aprobación.
- Tabla de las 25 pruebas con su resultado.
- Lista de comprobación para publicar.
## Qué NO hacer
- No cobres dentro del chat ni pidas número de tarjeta.
- No escribas a nadie que no haya dado permiso o iniciado la conversación. No compres listas de teléfonos.
- No uses WhatsApp por métodos no oficiales.
- No prometas stock, plazos ni descuentos que el bot no pueda comprobar. Si no lo ve, dice que una persona lo confirmará.
- No contradigas la ley: en la venta a distancia a particulares suele haber 14 días naturales de desistimiento, con excepciones, y el precio mostrado lleva IVA. El bot no dice lo contrario.
- No insistas: máximo un recordatorio.
- No pidas datos que no necesites.
- Si vendes productos regulados (alcohol, tabaco, medicamentos), consulta antes con tu asesor.
- No pegues claves de acceso en el chat. Van en el conector o en n8n.
## Qué revisa una persona antes de usar el resultado
- Catálogo, precios, IVA y plazos de cada mensaje.
- Los textos de devolución y desistimiento: tu gestor o un abogado.
- Las plantillas de WhatsApp, antes de enviarlas a aprobar.
- El primer pedido de prueba, de punta a punta.
- Las primeras conversaciones reales y todo pedido que el bot no pueda resolver.
Instalación: guarda este texto como .claude/skills/pedidos-whatsapp-telegram-botstar/SKILL.md dentro de tu carpeta de trabajo.
