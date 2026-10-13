---
name: lector-transacciones-tarjetas-vinculadas
description: Analiza las transacciones de tarjetas vinculadas a un programa de Fidel API (o su exportación en CSV), comprobando primero el permiso y la calidad de los datos, y devuelve métricas de grupo y acciones sin identificar a personas. Úsala cuando el usuario trabaje con Fidel API o con datos de gasto con tarjeta y quiera entender qué compran sus clientes.
---
# Lector de transacciones de tarjetas vinculadas
## Qué hace
Según su documentación, Fidel API permite vincular tarjetas de pago a un programa, con permiso del titular, y recibir después las compras que esas tarjetas hacen en los comercios registrados. Esta skill toma esos datos, comprueba que están limpios y saca conclusiones de grupo. Cuánto se gasta, cuándo, dónde y con qué frecuencia.
Escrita en octubre de 2026. Confirma en la documentación oficial de Fidel API [ENLACE A LA DOCUMENTACIÓN OFICIAL] cómo funciona hoy. No te fíes de lo que recuerdes.
Solo sirve si ya tienes cuenta y contrato con Fidel. Si no, aplica la misma idea a una exportación de tu TPV, tu pasarela de pago o tu banco.
Son datos de gasto de personas. Aunque no lleven el nombre, retratan hábitos. Se trabaja en grupo, nunca por persona.
## Antes de empezar, pregunta
1. ¿Hay cuenta y contrato con Fidel API? ¿Los datos son de pruebas (sandbox) o reales?
2. ¿Cómo me los das? Lo más seguro es una exportación en CSV o JSON. También vale una conexión de solo lectura. Nunca pegues claves secretas en el chat.
3. ¿Qué decisión quieres tomar con el análisis? Por ejemplo, qué oferta lanzar, qué días reforzar o qué local mirar. Sin decisión no hay análisis.
4. ¿Quién es el responsable del tratamiento de esos datos? ¿Qué finalidad se explicó al titular, qué texto aceptó y cuánto tiempo se conservan los datos?
5. ¿Se ha consultado a un asesor de protección de datos? ¿Hay un contrato con Fidel que defina el papel de cada uno?
6. ¿En qué moneda y países? ¿Qué comercios o locales participan?
## Paso a paso
1. Comprobación previa de privacidad. Antes de abrir un solo dato, confirma que hay consentimiento del titular, una finalidad concreta y una política de privacidad que lo cuenta. Si no puedes confirmarlo, para y explica por qué. No sigas «a ver qué sale».
2. Pide primero una muestra de 20 a 50 filas. Si en alguna aparece un número de tarjeta completo, una caducidad junto al número o un CVV, para. No proceses nada, di que se retire ese archivo y que alguien de seguridad lo revise. No repitas ese número en tu respuesta.
3. Haz el mapa de columnas: fecha y hora, importe, moneda, comercio, local, identificador de tarjeta o de cliente, estado (autorizada, pendiente, reembolsada) y el identificador único de cada transacción. Pregunta qué significa cada una. No supongas.
4. Revisa la calidad con cifras. Filas duplicadas por identificador (los avisos automáticos pueden repetirse). Importes que parezcan estar en céntimos en vez de euros (pide comprobar tres con un ticket real). Zonas horarias. Reembolsos con importe negativo. Pendientes que luego no se liquidan. Filas sin comercio. Informa de cuántas filas se descartan y por qué.
5. Calcula en grupo: gasto total, número de transacciones, ticket medio y mediana, reparto por día de la semana y franja horaria, gasto por comercio o local, clientes que repiten frente a nuevos (por identificador sin nombre) y reparto por tramos de importe.
6. Al presentar, no enseñes grupos de menos de 10 personas (es una regla prudente, el asesor la ajusta) y no pongas identificadores de tarjeta en el informe.
7. Si se lanzó una oferta, compara antes y después con cautela, porque cambian otras cosas a la vez (fechas, tiempo, campañas). Escribe «coincide con», no «ha causado».
8. Explica los límites. Solo se ven compras con tarjetas vinculadas, y quienes aceptan vincularla no son todos tus clientes. Las cifras no se pueden extender al total de las ventas.
9. Propón 3 acciones. Para cada una: el dato que la sostiene, lo que cuesta [COSTE EN €] y cómo comprobar si ha funcionado.
10. Si piden automatizarlo (por ejemplo en n8n), describe el flujo (recibir el aviso, guardarlo, informe semanal) pero no lo montes con claves reales. Primero en entorno de pruebas. Las claves van en las credenciales de la herramienta, no en el texto. La dirección que recibe los avisos usa https, y si la documentación ofrece firma de los avisos, se comprueba.
## Qué devolver
Informe en Markdown, en español de España y tuteando, en este orden.
1. Resumen de 5 líneas, empezando por la decisión que se quería tomar.
2. Estado de la comprobación de privacidad (cumplida, pendiente o no cumplida).
3. Tabla de calidad de datos con filas totales, filas descartadas y motivo.
4. Tabla de métricas con la métrica, el valor y cómo se ha calculado.
5. De 3 a 5 hallazgos, cada uno con su dato.
6. Tres acciones propuestas.
7. Límites del análisis.
8. Qué debe revisar una persona.
## Qué NO hacer
- No pidas ni guardes números completos de tarjeta, caducidades, CVV ni claves secretas de Fidel. Si te los pegan, avisa de que esas claves hay que cambiarlas.
- No crees, modifiques ni borres programas, comercios, tarjetas ni avisos (webhooks) en Fidel. Solo lectura. No desvincules tarjetas.
- No intentes saber quién es una persona. No cruces estos datos con emails, redes sociales ni otras bases.
- No deduzcas datos delicados (salud, religión, ideología, orientación sexual, afiliación sindical) a partir de dónde compra alguien.
- No hagas listas de personas «para ofrecerles algo» o «para excluirlas». Resultados de grupo, no de individuo.
- No tomes decisiones automáticas que afecten a una persona, como negarle una oferta, sin que otra persona lo revise.
- No envíes los datos a herramientas o servicios que no estén en el contrato.
- No inventes cifras ni rellenes huecos. Dato que falta, [DATO QUE FALTA].
- No digas que la muestra es representativa de todos los clientes.
## Qué revisa una persona antes de usar el resultado
- Un asesor de protección de datos o un abogado revisa el consentimiento, la finalidad, el plazo de conservación, el contrato con Fidel y, si procede, la evaluación de impacto. Las multas de la AEPD pueden ser importantes.
- El responsable del negocio comprueba que las acciones propuestas cuestan lo previsto y salen a cuenta.
- Quien conozca los datos comprueba que el mapa de columnas y la limpieza son correctos.
- Alguien de seguridad comprueba que los archivos con datos están en un sitio protegido y se borran al terminar.
## Dónde guardarla
Guárdala como `.claude/skills/lector-transacciones-tarjetas-vinculadas/SKILL.md` dentro de la carpeta de tu proyecto, o en `~/.claude/skills/` para usarla en todos. Si prefieres no instalar nada, pega este texto en el chat y di «usa esta skill».
