---
name: producto-minimo-con-cobro
description: Guía por fases para construir con Claude Code un producto digital mínimo con página de venta, cobro, pruebas, publicación y vigilancia, pidiendo permiso antes de publicar, cobrar o gastar. Úsala cuando haya una idea validada y se quiera lanzar sin equipo técnico.
---

# De la idea al primer cobro: producto digital mínimo

## Qué hace
Te lleva por fases desde una idea ya validada hasta un producto publicado que cobra de verdad, con pruebas y vigilancia después.
Hay dos «puertas» donde Claude se para y espera tu «sí» por escrito: antes de publicar y antes de activar cobros reales.
También se para antes de enviar emails a personas reales, de gastar dinero o de usar claves.
Riesgos reales: cobrar sin el alta fiscal hecha, tratar datos personales sin cumplir el RGPD y dejar claves expuestas. Por eso hay revisión humana antes de cada puerta.
Coste: Claude Code gasta uso de tu plan, o dinero si usas la API de pago. Pon un límite de gasto mensual en la consola de la API antes de empezar.

## Qué preguntar antes de empezar
Pregunta todo junto, en lista, y espera.
1. Qué problema resuelve y para quién, en una frase.
2. Validación: cuántas personas reales te han dicho que pagarían, o ya han pagado o reservado. Si ninguna, propón primero una página con lista de espera o preventa antes de construir nada.
3. Qué vendes exactamente: descarga, acceso con registro, suscripción o servicio con formulario. Precio [PRECIO], y si es pago único o recurrente.
4. Quién cobra: autónomo o sociedad. Si el alta en Hacienda y la cuenta bancaria del negocio no están hechas, no se activan cobros reales hasta hablar con tu gestor.
5. Dónde están tus clientes: España, resto de la UE u otros países. El IVA cambia, sobre todo en ventas digitales a particulares de otros países de la UE. Pregunta a tu gestor.
6. Qué datos personales vas a pedir: email, nombre, dirección, datos de salud, menores. Cuantos menos, mejor.
7. Presupuesto mensual máximo para dominio, alojamiento, base de datos, emails y comisiones de cobro. Muchas herramientas tienen plan gratuito con límites: [COMPRUEBA LOS LÍMITES VIGENTES].
8. Qué tienes ya: dominio, marca, cuenta de la pasarela de pago, alojamiento, repositorio. Nunca pegues claves en el chat.
9. Cómo sabrás si funciona: un número simple, por ejemplo [VENTAS EN 30 DÍAS].

## Paso a paso
1. Fase 0, alcance. Escribe en `ALCANCE.md` una sola promesa, para quién es, un máximo de 3 funciones y lo que NO hará esta primera versión. Crea también un `CLAUDE.md` con las reglas de este proyecto para que Claude las recuerde en cada sesión. Espera aprobación.
2. Fase 1, página de venta. Una sola página: titular, problema, solución, cómo funciona, precio, preguntas frecuentes y un botón. Sin promesas de resultados que no puedas demostrar. Enlaza aviso legal, privacidad, cookies y condiciones como borradores que revisará una persona. Si aún no hay producto, pon un formulario de lista de espera.
3. Fase 2, construcción. Primero un plan (usa el modo plan de Claude Code), después piezas pequeñas. Tras cada pieza la abres en tu navegador, la revisas y guardas un punto de control (un commit de git). Explica cada herramienta elegida en 2 líneas, con su coste. Las claves van en variables de entorno, nunca escritas en el código ni subidas al repositorio.
4. Fase 3, cobros en modo prueba. Conecta la pasarela de pago (por ejemplo Stripe) solo en modo prueba, con tarjetas de prueba. Verifica la firma de los avisos (webhooks) que llegan de la pasarela. Da el pedido por pagado solo cuando la pasarela lo confirma, no porque el usuario llegue a la página de «gracias». Cubre pago fallido, reembolso y cancelación de suscripción.
5. Fase 4, pruebas. Haz una lista de casos: registro, pago correcto, pago rechazado, reembolso, email de confirmación, móvil Android, iPhone, enlaces rotos y si un usuario puede ver datos de otro. Pide a un subagente revisor que busque claves expuestas, permisos mal puestos y datos personales en registros. Devuelve una tabla de resultados. Parte de las pruebas las haces tú con tu móvil.
6. Puerta 1, antes de publicar. Presenta esta lista y espera tu «sí»: dominio, HTTPS, páginas legales revisadas, aviso de cookies si hay cookies no técnicas, correo de soporte, política de reembolsos, copia de seguridad, claves de producción guardadas en el panel del alojamiento y plan para volver atrás.
7. Puerta 2, cobros reales. Con tu «sí», haz tú mismo un pago de [IMPORTE BAJO] y reembólsalo después. Comprueba que el dinero llega, que sale el email y que se genera la factura que corresponda. Pregunta a tu gestor quién emite factura y cómo.
8. Fase 5, vigilancia. Activa un monitor de disponibilidad (los hay gratuitos), avisos de errores y avisos de pagos fallidos. Las primeras [4] semanas, revisión semanal: visitas, conversión, pagos, reembolsos, errores y mensajes de soporte. Anota las incidencias en `DIARIO.md`.
9. Fase 6, mejora. Un cambio cada vez y mide el efecto antes del siguiente.

## Qué devolver y con qué formato
- Al final de cada fase, un «Resumen de fase»: qué se ha hecho, qué se ha probado, qué falta, qué cuesta y qué decisión necesitas de ti.
- Al terminar, un `ENTREGA.md` con: dirección pública, cuentas usadas (sin claves), costes mensuales, cómo restaurar una copia, qué ha revisado una persona y qué queda pendiente.
- Los archivos del proyecto ordenados, con `ALCANCE.md`, `CLAUDE.md` y `DIARIO.md` en la raíz.

## Qué revisa una persona antes de publicar y de cobrar
- Tu gestor: alta en Hacienda, IVA, facturas y cuenta bancaria.
- Un abogado o asesor de protección de datos: aviso legal, privacidad, cookies, condiciones, derecho de desistimiento de 14 días y sus excepciones en contenido digital.
- Una persona técnica de confianza: seguridad básica si hay pagos o datos de personas.
- Tú: el recorrido completo, de la compra al email, desde tu móvil.

## Qué NO hacer
- No publiques, no pases a cobros reales, no envíes emails a personas y no gastes dinero sin un «sí» por escrito.
- No pidas ni pegues claves, contraseñas o tokens en el chat. Si aparece una, avisa y pide que se genere una nueva.
- No guardes datos de tarjetas. Los gestiona la pasarela.
- No uses datos reales de clientes en las pruebas.
- No copies código, textos ni diseños de otros sin licencia. Ojo con paquetes de uso no comercial.
- No pongas promesas de ingresos, testimonios inventados ni cuentas atrás falsas en la página de venta.
- No añadas funciones que no estén en `ALCANCE.md`.
- No borres archivos ni datos del proyecto sin avisar y sin copia de seguridad.
- No des por bueno «en mi ordenador funciona». Prueba en la dirección pública y en el móvil.
- No presentes los textos legales como definitivos.

## Dónde guardarla
Guarda este archivo como `.claude/skills/producto-minimo-con-cobro/SKILL.md` en tu proyecto. Claude la usa cuando le pides algo parecido, o la llamas con `/producto-minimo-con-cobro`.
Texto revisado en octubre de 2026. Planes gratuitos, comisiones y normas cambian: compruébalos antes de decidir.
