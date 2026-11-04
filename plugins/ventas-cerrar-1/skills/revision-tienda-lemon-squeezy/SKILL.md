---
name: revision-tienda-lemon-squeezy
description: Lee ventas, suscripciones, clientes y licencias de tu tienda Lemon Squeezy, señala lo que necesita atención y prepara reembolsos, cancelaciones o descuentos que solo se ejecutan si los confirmas. Se activa cuando preguntas por ventas, pagos fallidos, licencias o clientes de tu tienda.
---
# Revisión de tu tienda en Lemon Squeezy
Lemon Squeezy vende por ti productos digitales (cursos, plantillas, software, suscripciones) y se encarga de cobrar y de gran parte de los impuestos de venta. Pertenece a Stripe desde 2024, así que mira en su web cómo está el servicio hoy, porque puede cambiar. Esta skill te ahorra entrar al panel para ver cifras y resolver consultas.
Para instalarla, guarda este archivo como .claude/skills/revision-tienda-lemon-squeezy/SKILL.md dentro de tu proyecto.
## Cómo se conecta
- Lo más seguro. Exportas informes de pedidos y suscripciones desde el panel y se los das a Claude. Solo lee.
- Con clave de la API. Créala en el panel, en modo de prueba primero. Va en la configuración del conector o de n8n, nunca en el chat.
- Con un conector MCP. Úsalo solo si es oficial o de alguien en quien confías, y mira qué permisos tiene.
- Con la clave de producción, Claude toca dinero real. Empieza siempre por la de modo de prueba.
## Qué preguntar antes de empezar
- ¿Qué periodo, qué productos y en qué moneda?
- ¿Qué quieres saber? Un resumen de ventas, pagos fallidos, buscar a un cliente, localizar una licencia, preparar un reembolso.
- ¿La conexión es de solo lectura o también puede escribir? Por defecto trátala como solo lectura.
- ¿Cuál es tu política de reembolsos? Para consumidores de la UE hay un derecho de desistimiento de 14 días con excepciones para contenido digital. Tus términos de venta lo concretan, y si dudas lo consultas con tu gestor.
## Paso a paso
1. Haz el resumen del periodo con pedidos, importe bruto, reembolsos, y clientes nuevos y repetidos. No calcules comisiones ni impuestos por tu cuenta. Usa lo que diga el informe de pagos y, si el dato no está, escribe «no consta».
2. Señala lo que necesita atención. Suscripciones con pago fallido o en pausa, cancelaciones recientes, reembolsos y disputas, licencias sin activar o que superaron su límite de activaciones, y pedidos con un estado raro.
3. Si preguntan por un pedido, pide el email Y el número de pedido. No des claves de licencia, enlaces de descarga ni datos personales a quien no lo acredite. Si escribe un cliente, redacta la respuesta como borrador y la envías tú.
4. Si hay que actuar (reembolsar, cancelar una suscripción, crear un código de descuento, cambiar un precio), prepara una ficha. Dice qué se hace, sobre qué pedido o cliente, el importe exacto, el efecto (¿se corta el acceso?, ¿se anula la licencia?) y si se puede deshacer.
5. Espera una confirmación literal, «CONFIRMO» más el número de pedido o de suscripción. Una acción por confirmación. Nunca varias en bloque sin que las veas todas.
6. Tras ejecutar, vuelve a leer el registro y comprueba que el estado cambió.
## Qué devolver
- Resumen del periodo en una tabla pequeña con concepto, número e importe.
- Lista de «necesita atención» con pedido o cliente, motivo y acción sugerida.
- Fichas de las acciones pendientes de confirmar.
- Acciones ejecutadas, con su identificador, o la frase «ninguna acción».
- Datos que no constan y supuestos que has hecho.
## Qué NO hacer
- No reembolses, canceles ni cambies precios sin confirmación literal. Un reembolso es dinero real y a veces no se puede revertir.
- No uses la clave de producción para probar.
- No borres productos, variantes ni clientes. Si algo debe retirarse, déjalo en borrador o archivado, según permita el panel.
- No cambies el precio de un producto con suscripciones activas sin comprobar antes cómo afecta a quienes ya pagan.
- No crees descuentos sin fecha de fin ni límite de usos.
- No calcules comisiones, IVA ni retenciones, y no des consejo fiscal.
- No pegues emails, direcciones ni claves de licencia en documentos que vayas a compartir.
- No prometas ingresos.
## Qué revisa una persona
- Todo reembolso, cancelación o descuento, antes de confirmarlo.
- Las cifras, antes de usarlas para declarar o facturar. Cómo declarar en España los ingresos de una plataforma así (IRPF, IVA y facturas) lo decide tu gestor.
- Las respuestas a clientes, antes de enviarlas.
