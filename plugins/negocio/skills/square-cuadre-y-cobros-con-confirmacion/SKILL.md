---
name: square-cuadre-y-cobros-con-confirmacion
description: Consulta pagos, pedidos, facturas y locales de Square, cuadra las ventas de cada día y prepara cobros o devoluciones que solo se ejecutan con tu confirmación. Úsala cuando quieras revisar ventas o cobros de Square sin entrar al panel.
---

# Square: cuadrar ventas y preparar cobros sin sustos

## Qué hace
- Consulta pagos, devoluciones, pedidos, facturas y locales (ubicaciones) de tu cuenta de Square.
- Cuadra las ventas de un periodo con tu cierre de caja, tu banco o tu libro de ingresos, y explica las diferencias.
- Detecta pagos fallidos, cobros duplicados, devoluciones raras y facturas vencidas.
- Las acciones con dinero (cobrar, devolver, cancelar, enviar una factura) las prepara como borrador. Solo se ejecutan si escribes CONFIRMO.

## Conexión y seguridad
- Square ofrece una API y un servidor MCP oficial [COMPRUEBA EN SU DOCUMENTACIÓN PARA DESARROLLADORES QUE SIGUE VIGENTE]. En Claude Code, escribe /mcp para ver qué conectores tienes.
- Sin conector vale una exportación de ventas en CSV desde el panel de Square.
- Empieza en el Sandbox de Square, que usa dinero de mentira.
- Para consultar, usa permisos de solo lectura. Los permisos de cobrar o devolver se activan solo cuando haga falta.
- Nunca pegues en el chat claves, tokens de acceso ni números de tarjeta completos. Si aparece uno, paro y te lo digo.

## Antes de empezar, pregunta
1. Qué necesitas: consultar, cuadrar o preparar una acción con dinero.
2. Qué local y qué fechas. Las fechas de la API pueden venir en hora universal (UTC). Las paso a hora de España y te lo digo.
3. Contra qué cuadras: cierre de caja, extracto del banco o libro de ingresos.
4. Qué tipos de IVA aplicas [CONFÍRMALOS CON TU GESTOR].
5. Si es una acción: a quién, importe en euros, concepto, motivo y quién la autoriza.
6. Si trabajas en el Sandbox o en la cuenta real.

## Paso a paso para consultar y cuadrar
1. Confirmo periodo y local contigo antes de pedir datos.
2. Traigo pagos, devoluciones, propinas y comisiones del periodo. Separo importe bruto, devoluciones, comisiones y neto. Las comisiones son las que Square informe en cada pago. No las calculo de memoria.
3. Square ingresa en tu banco agrupando pagos y con retraso. Por eso las ventas de un día y el dinero que entra ese día no coinciden. Comparo ventas con ventas y transferencias con banco.
4. Listo las diferencias con su posible causa: devolución, propina, comisión, efectivo sin registrar, pago pendiente o cambio de hora.
5. Lo que no puedo explicar lo marco como «sin explicar». No fuerzo que cuadre.
6. Facturas: listo las vencidas con cliente, importe, fecha de vencimiento y días de retraso, y propongo un recordatorio amable. Comprueba si las facturas de Square están disponibles en tu país y plan.

## Paso a paso para una acción con dinero
1. Preparo una ficha: qué (cobro, factura, devolución o cancelación), a quién, importe con y sin IVA, local, motivo y entorno (real o pruebas).
2. Antes de nada, consulto si ya existe una operación igual, para no duplicar.
3. Te pregunto: «¿Confirmas [ACCIÓN] de [IMPORTE] a [CLIENTE]? Escribe CONFIRMO.» Sin esa palabra, no hago nada.
4. Ejecuto una sola operación cada vez, nunca en lote, y con una clave que evita que un reintento cobre dos veces.
5. Después vuelvo a consultar, confirmo el estado y anoto el identificador de la operación.

## Qué devolver
- Un resumen de tres líneas: periodo, local, total neto y número de diferencias.
- La tabla de cuadre en Markdown. Importes con formato español (1.234,56 €).
- La lista de pendientes para una persona.
- Si hubo una acción, su ficha con identificador, importe y estado final.

## Qué NO hacer
- No cobrar, devolver, cancelar ni enviar facturas sin tu CONFIRMO para esa operación. Tampoco en masa ni «por si acaso».
- No cobrar con una tarjeta guardada de un cliente si no consta su autorización.
- No pasar al entorno real algo probado en el Sandbox sin avisarte.
- No pedir, copiar ni guardar datos completos de tarjetas.
- No inventar cifras. Si falta un dato, lo digo.
- No tocar la configuración de la cuenta, los empleados, los permisos ni los datos bancarios.
- No sacar listas de clientes con sus compras para usos distintos al trabajo pedido (RGPD).

## Dinero, impuestos y cuándo pedir una persona
- Facturas: en España tienen requisitos (NIF, numeración, IVA desglosado) y hay obligaciones sobre los programas de facturación (ley antifraude y VeriFactu) con fechas que han cambiado [PREGUNTA A TU GESTOR LAS VIGENTES]. Consulta si las facturas y tickets de Square encajan.
- Una devolución puede exigir factura rectificativa. Avisa a tu gestor.
- Diferencias que no cuadran, sospecha de fraude o contracargos (disputas de un cliente con su banco): decide el responsable del negocio y se habla con el soporte de Square. Las disputas tienen plazos cortos [MÍRALO EN TU PANEL].
- Antes de usar el resultado, una persona (tú o tu gestor) revisa cualquier cifra que vaya al gestor, al banco o a Hacienda. Este cuadre no es contabilidad oficial.

## Dónde se guarda
- Guárdala como .claude/skills/square-cuadre-y-cobros-con-confirmacion/SKILL.md dentro de tu proyecto, o en la carpeta .claude de tu usuario para usarla en todos.
- Se activa sola cuando hablas de ventas o cobros de Square, o la llamas escribiendo /square-cuadre-y-cobros-con-confirmacion.
