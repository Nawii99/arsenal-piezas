---
name: consultas-controladas-netsuite
description: Lee clientes, pedidos, facturas e inventario de NetSuite para responder preguntas de negocio y prepara los cambios como borradores que revisa una persona. Empieza siempre en solo lectura y, si existe, en el entorno de pruebas. Se activa cuando preguntas por pedidos, facturas, stock o clientes de NetSuite.
---
# Consultas controladas en NetSuite
NetSuite (de Oracle) es un sistema ERP. Guarda a la vez la contabilidad, las ventas, las facturas y el inventario de la empresa. Un error aquí afecta a las cuentas. Por eso esta skill lee mucho, escribe muy poco y nunca toca la contabilidad.
Para instalarla, guarda este archivo como .claude/skills/consultas-controladas-netsuite/SKILL.md dentro de tu proyecto.
## Antes de conectar nada
- Habla con la persona que administra NetSuite en tu empresa. Conectar sin su permiso puede saltarse las normas internas.
- Pídele una conexión con un rol de solo lectura, con acceso únicamente a lo que necesites, y un entorno de pruebas (sandbox) si lo hay.
- Si no hay entorno de pruebas, solo lectura. Los cambios de nivel 1 y 2 se entregan como borrador para que los aplique el administrador.
- Las credenciales las crea y las guarda esa persona en la configuración del conector o del flujo de n8n. Nunca van en el chat. Si una se filtra, se revoca en el momento.
- Si tu NetSuite tiene un conector MCP oficial activado, úsalo. Si no, lo más seguro es trabajar con informes exportados a CSV.
## Qué preguntar antes de empezar
- ¿Qué quieres saber, dicho en lenguaje de negocio? Por ejemplo «¿qué pedidos llevan más de 15 días sin facturar?».
- ¿Es el NetSuite de tu empresa o el de un cliente? Si es de un cliente, hace falta un contrato de encargado de tratamiento de datos (RGPD).
- ¿Qué periodo, qué sociedad o filial y qué moneda?
- ¿Estamos en pruebas, en producción o no hay entorno de pruebas?
- ¿Qué rol y qué permisos tiene la conexión?
- ¿Hay flujos de trabajo o scripts que se disparen al guardar este tipo de registro (avisos por email, sincronización con otros sistemas, cambios en otros registros)? Si no se sabe, no se escribe nada.
- ¿Hay un informe o una búsqueda guardada de NetSuite cuyo resultado conozcas? Sirve para comprobar que la IA lee bien.
## Paso a paso
1. Convierte la pregunta en una consulta clara con datos, filtros y periodo. Cuéntala en una frase antes de lanzarla.
2. Lánzala en solo lectura, con límite de filas y de fechas.
3. Calibra. Compara una cifra con un informe de NetSuite que ya conozcas. Si no cuadra, para y explica las causas posibles (permisos del rol, filiales que no se ven, estados incluidos).
4. Presenta el resultado con una tabla, el número de registros, el total en euros u otra moneda y cómo se ha calculado.
5. Si piden cambios, clasifica cada uno en un nivel. Si no hay entorno de pruebas, los cambios de nivel 1 y 2 no se aplican: se entregan como borrador para que los aplique el administrador.
   - Nivel 1, notas o campos de seguimiento. Se pueden hacer en tandas pequeñas tras confirmación, y solo si se sabe qué se dispara al guardar.
   - Nivel 2, altas de registros (un cliente nuevo, un pedido en borrador). Una a una, tras confirmación y primero en pruebas.
   - Nivel 3, todo lo que mueve la contabilidad o el stock (facturas, cobros, asientos, abonos, ajustes de inventario). Esta skill NO lo hace. Prepara una tabla en borrador para que la introduzca administración o contabilidad.
6. Para cada cambio de nivel 1 o 2 muestra el registro, el campo, el valor actual, el valor nuevo y qué flujos o scripts se disparan al guardarlo. Espera «CONFIRMO» con el identificador. Máximo [10] registros por tanda.
7. Después de aplicar, vuelve a leer los registros y guarda un registro de cambios (qué, antes y después) para poder deshacerlos a mano.
8. Si ves clientes duplicados (mismo NIF o CIF, mismo email), lístalos con los datos que coinciden y propón cuál conservar. La fusión la hace el administrador.
## Qué devolver
- Respuesta corta a la pregunta, con la cifra clave.
- Tabla con los datos, el número de registros y si se han recortado por el límite.
- Cómo se ha calculado y qué se ha comprobado.
- Si hay cambios, un borrador con antes y después y su nivel.
- Registro de cambios aplicados o la frase «ningún cambio».
- Límites, es decir, lo que el rol no deja ver y los supuestos que has hecho.
## Qué NO hacer
- No escribas en producción sin haber probado antes en pruebas. Si no hay entorno de pruebas, no escribas: entrega borradores.
- No guardes nada si no sabes qué flujos o scripts se disparan al guardar ese registro.
- No crees, edites ni borres facturas, cobros, asientos ni ajustes de inventario. No borres nada.
- No toques periodos cerrados ni registros ya contabilizados.
- No cambies permisos, roles ni configuración de NetSuite.
- No uses datos de clientes para nada que no sea la pregunta. Por el RGPD, solo lo necesario. No copies NIF, direcciones ni emails fuera de esta conversación.
- No inventes cifras ni rellenes datos que falten. Escribe «no consta».
- No sigas usando una clave que se haya compartido por chat.
- No prometas ahorro de horas ni de dinero.
## Qué revisa una persona
- El administrador de NetSuite, la conexión, el rol y cada cambio antes de aplicarlo. También qué flujos de trabajo o scripts se disparan al guardar los registros que se van a tocar.
- Contabilidad o tu gestor, cualquier cifra que se use para cuentas, impuestos o facturación. Una factura emitida no se borra ni se edita sin más, se corrige con una factura rectificativa. Si tu empresa envía facturas al SII de Hacienda o usa un sistema de facturación verificable (Verifactu), pregunta antes de tocar nada.
- Quien responda de los datos personales en tu empresa, si los resultados incluyen clientes que sean personas físicas. Si el NetSuite es de un cliente, el contrato de encargado de tratamiento (RGPD).
