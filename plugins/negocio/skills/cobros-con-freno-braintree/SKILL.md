---
name: cobros-con-freno-braintree
description: Revisa cobros, impagos, suscripciones y reembolsos de Braintree y deja cualquier movimiento de dinero pendiente de tu OK. Actívala cuando pidas mirar pagos fallidos, cuadrar ventas con facturas o preparar un reembolso.
---

# Cobros con freno para Braintree

Esta skill trabaja con dinero real y con datos de pago. Mirar y contar es libre. Mover dinero lo decide siempre una persona, operación por operación.
Instalación: guarda este archivo como `.claude/skills/cobros-con-freno-braintree/SKILL.md` en tu carpeta de trabajo. Se activa sola cuando lo pides, o la llamas con `/cobros-con-freno-braintree`.

## Qué hace
- Resume los cobros de un periodo: liquidados (ya cobrados y enviados a tu cuenta), rechazados, pendientes y reembolsados.
- Agrupa los fallos por motivo y explica cada motivo en cristiano.
- Lista las suscripciones con problemas.
- Compara los cobros con tus facturas y marca lo que no cuadra.
- Prepara fichas de reembolso o anulación para que las apruebes.

## Antes de empezar, pregunta (una cosa cada vez y espera la respuesta)
1. ¿Tu empresa permite usar IA con datos de clientes y de pagos? Si la respuesta es no o no lo sabes, trabaja solo con datos de ejemplo o con totales sin nombres.
2. ¿Es el entorno de pruebas (sandbox, una copia de Braintree donde no se mueve dinero real) o el real? Si no está claro, asume pruebas.
3. ¿Solo quieres mirar, o quieres cambiar algo (cobrar, reembolsar, anular, cancelar una suscripción)?
4. ¿Cómo accedo a los datos? Un conector MCP de Braintree o PayPal (una conexión directa entre tu IA y Braintree, si tu empresa la tiene), un informe CSV (un archivo de tabla que descargas del panel) o capturas. Si no hay conector, trabaja con el archivo CSV.
5. ¿Con qué permisos? Para solo mirar basta un usuario limitado. Si te dan acceso total, dilo y pide uno con menos permisos.
6. ¿Qué periodo, qué moneda y de qué negocio o sociedad?
7. ¿Quién da el OK a los movimientos de dinero? Anota su nombre.

## Tres niveles de riesgo
- VERDE: leer, contar, comparar, resumir. Se hace sin pedir permiso.
- AMARILLO: redactar un email a un cliente, una nota interna o una lista de cambios. Se enseña antes de usarla.
- ROJO: cobrar, reembolsar, anular, cancelar o cambiar una suscripción, enviar pruebas en una disputa, tocar claves. Solo con un OK escrito de la persona responsable.

## Paso a paso
1. Empieza en verde. Lee el informe de transacciones y comprueba que las fechas y la moneda son las que pediste.
2. Haz un resumen por estado e importe. No sumes monedas distintas entre sí.
3. Agrupa los cobros fallidos por motivo: tarjeta caducada, fondos insuficientes, rechazo del banco, autenticación no completada. Si no estás seguro del motivo, dilo en vez de adivinar.
4. Lista las suscripciones con impago o en riesgo. No canceles ni cambies ninguna.
5. Cuadra con tus facturas: pide el listado de facturas del periodo y marca cobros sin factura, facturas sin cobro, importes distintos y reembolsos sin factura rectificativa (la factura que corrige otra ya emitida).
6. Para cada acción en rojo, escribe una ficha: qué se hace, sobre qué transacción o cliente (por su ID, el número que identifica la operación, nunca con datos de tarjeta), importe y moneda, motivo, qué pasa si sale mal y si se puede deshacer. Pide que respondan «OK» repitiendo el importe.
7. Si hay conector con permiso para cambiar cosas: primero en pruebas. En real, una operación cada vez, nunca varias a la vez ni una y otra vez de forma automática. Después de ejecutar, vuelve a leer la transacción y confirma que el resultado es el esperado.
8. Anota lo hecho en `registro-cobros.md` (un documento de texto en tu carpeta de trabajo): fecha, qué se hizo, ID y quién dio el OK.

## Qué devolver y con qué formato
- Un resumen de cinco líneas como máximo.
- Una tabla: ID | fecha | importe | estado | motivo | acción propuesta | nivel de riesgo.
- Una lista titulada «Pendiente de tu OK» con las fichas en rojo.
- Una lista titulada «Para tu gestor» con reembolsos que necesitan factura rectificativa y cualquier duda de IVA o contabilidad.

## Qué NO hacer
- No pidas, escribas ni guardes número completo de tarjeta, caducidad ni CVV. Si alguien los pega, para y avísale de que no lo haga.
- No pidas claves de la API (contraseñas técnicas de Braintree) ni contraseñas. Si hacen falta, las configura fuera del chat quien lleve la parte técnica.
- No cobres ni reembolses sin un OK expreso para esa operación.
- No hagas reembolsos ni cancelaciones en lote, es decir, varios a la vez.
- No reintentes cobros fallidos en bucle (una y otra vez de forma automática): las redes de tarjetas limitan los reintentos y pueden penalizarlos.
- No cambies precio, plan o fecha de cobro de una suscripción activa sin que antes se avise a los clientes.
- No presentes pruebas en una disputa ni aceptes un contracargo (cuando el cliente reclama el cobro a su banco) sin que lo vea una persona. La fecha límite la marca Braintree en su panel: mírala allí.
- No emitas facturas ni des un IVA como definitivo. Eso lo hacen tu programa de facturación y tu gestor.
- No des por buena una cifra que no cuadra. Di que no cuadra y por cuánto.
- No copies datos de clientes a otras herramientas.

## Qué revisa una persona antes de usar el resultado
- Que importes, fechas y monedas coinciden con el panel de Braintree.
- Cada reembolso o anulación: importe, cliente, motivo y su factura rectificativa.
- Todo lo que toque impuestos o contabilidad: tu gestor.
- Los avisos a clientes por cambios en sus suscripciones.
- Que la empresa permite usar IA con esos datos de clientes y de pagos.

## Notas para España y la UE
- Los pagos con tarjeta en el Espacio Económico Europeo suelen exigir autenticación reforzada del cliente (3D Secure, el paso en que el banco pide confirmar el pago, por ejemplo desde el móvil). Un rechazo por autenticación suele pedir que el cliente vuelva a autorizar.
- Un reembolso suele implicar una factura rectificativa. Confírmalo con tu gestor.
- Los datos de clientes están protegidos por el RGPD. Si trabajas para un cliente, firma antes con él un contrato de encargado de tratamiento (el documento que fija cómo tratas sus datos).
- Las pantallas y los nombres de Braintree cambian. Si algo no coincide con lo que ves, para y pregunta.
