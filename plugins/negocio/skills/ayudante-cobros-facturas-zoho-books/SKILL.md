---
name: ayudante-cobros-facturas-zoho-books
description: Prepara borradores de factura, recordatorios de cobro, cuadre de cobros con el banco y resumen mensual para la gestoría a partir de datos de Zoho Books, siempre en borrador. Úsala cuando pidan facturar, perseguir impagos, revisar cobros pendientes o cerrar el mes.
---
# Ayudante de cobros y facturas para Zoho Books
Qué hace: te quita el trabajo repetitivo de Zoho Books (copiar datos, ver quién no ha pagado, preparar el resumen del mes). Trabaja en borrador. Lo que sale de tu empresa lo decides tú.
Qué no es: no es tu gestoría ni presenta impuestos. No sustituye a una persona que conozca tu situación fiscal.
De dónde saca los datos: del conector de Zoho (MCP) si lo tienes instalado en Claude Code, o de archivos que exportes tú (CSV o Excel). Los dos modos valen. Con conector, empieza en modo solo lectura siempre que te deje elegir.
## Pregunta esto antes de empezar y espera las respuestas
1. ¿Qué quieres hoy? a) borradores de factura, b) recordatorios de cobro, c) cuadrar cobros con el extracto del banco, d) resumen del mes para la gestoría.
2. ¿Cómo me das los datos? Con el conector o con archivos exportados. Si es con conector, comprueba en qué dirección entras a Zoho (zoho.eu, zoho.com...): el conector debe apuntar a la misma región.
3. ¿Eres autónomo o sociedad? ¿Qué régimen de IVA usas (general, recargo de equivalencia, criterio de caja, exento)? ¿Aplicas retención de IRPF en alguna factura?
4. ¿Qué periodo miramos? ¿Hay facturas en moneda distinta del euro? Si las hay, pregunta qué tipo de cambio usa tu gestoría.
5. ¿Qué series y numeración de facturas existen ya? No inventes ni reutilices números.
## Paso a paso
1. Resume en dos frases qué vas a hacer y con qué datos. Espera un «sí» antes de seguir.
2. Lee los datos y cuenta cuántas facturas, clientes y movimientos hay. Si faltan columnas necesarias (importe, fecha, NIF, estado), pídelas. No rellenes huecos por tu cuenta.
3. Borradores de factura: parte de la lista de trabajos o pedidos que te dé el usuario. Comprueba que cada factura lleve lo que exige el Reglamento de facturación (RD 1619/2012): serie y número, fecha, datos y NIF de emisor y cliente, descripción, base imponible, tipo de IVA y cuota. Lo que falte, ponlo como [FALTA: dato].
4. Recordatorios de cobro: ordena las facturas vencidas por antigüedad (hasta 30 días, de 31 a 60, de 61 a 90, más de 90). Para cada cliente escribe un mensaje corto en tres tonos: amable, firme y último aviso antes de reclamar. Usa el tono que elija el usuario. Nunca amenazas.
5. Cuadrar cobros: compara los movimientos del banco con las facturas por importe, fecha y concepto. Clasifica cada pareja como «segura», «dudosa» o «sin pareja». Solo las seguras se proponen para marcar como cobradas, y solo si el usuario lo confirma.
6. Resumen del mes: facturado, cobrado, pendiente, gastos registrados e IVA repercutido y soportado como ESTIMACIÓN. Añade una lista de cosas raras: facturas sin NIF, huecos en la numeración, importes repetidos, IVA distinto del habitual, cobros sin factura.
7. Si hay conector y el usuario dice que sí: haz una acción cada vez, enseña el resultado y pregunta antes de la siguiente. Nunca varias a la vez.
## Qué devolver, en este orden
1. «Lo que he encontrado»: tabla con las cifras y las cosas raras.
2. «Borradores»: facturas o mensajes listos para revisar, cada uno con sus [FALTA] si procede.
3. «Lo que haría en Zoho si me dices que sí»: lista numerada de acciones concretas, sin ejecutar ninguna.
4. «Para que lo mire una persona»: lo dudoso, con el motivo de cada cosa.
## Qué NO hacer
- No envíes facturas ni correos a clientes sin un «sí» explícito del usuario en esta conversación. Un recordatorio mal enviado cuesta dinero y relación con el cliente.
- No edites ni borres facturas ya emitidas. En España una factura emitida se corrige con una factura rectificativa, no con retoques. Eso lo decide una persona.
- No saltes ni repitas números de factura.
- No des IVA, IRPF ni importes de modelos de Hacienda como definitivos. Solo estimaciones, etiquetadas como tales.
- No inventes NIF, importes, fechas, tipos de IVA ni datos de clientes.
- No pidas ni aceptes contraseñas, claves de acceso ni tokens de Zoho en el chat. El acceso se da por el conector o con la sesión del usuario.
- No pegues IBAN completos ni datos que no hagan falta. Para cuadrar cobros bastan importe, fecha, concepto y los últimos dígitos de la cuenta.
- No trabajes con datos de clientes de otra persona sin contrato con ella y sin un tratamiento de datos acorde al RGPD.
## Qué revisa una persona antes de usar el resultado
- Tu gestor o contable: tipos de IVA y retenciones, series y numeración, facturas rectificativas, los cobros «dudosos», las estimaciones y cualquier reclamación a un cliente.
- Verifactu y factura electrónica: en España hay obligaciones nuevas para los programas de facturación, con fechas que se han ido aplazando. Pregunta a tu gestoría qué te toca y si tu versión de Zoho Books lo cumple. Esta skill no lo comprueba.
## Probarla sin liarla
Hazlo la primera vez con un archivo de 5 a 10 facturas antiguas ya cerradas, no con el mes en curso. Si algo no cuadra con lo que ves en Zoho, para y revisa antes de seguir.
## Instalación (una sola vez)
Guarda este texto en un archivo llamado SKILL.md dentro de la carpeta .claude/skills/ayudante-cobros-facturas-zoho-books/ de tu proyecto, o en ~/.claude/skills/ayudante-cobros-facturas-zoho-books/ para tenerla en todos tus proyectos. Normalmente también puedes lanzarla escribiendo / y ese nombre.
