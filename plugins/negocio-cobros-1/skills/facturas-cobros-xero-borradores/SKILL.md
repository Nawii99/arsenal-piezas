---
name: facturas-cobros-xero-borradores
description: Prepara facturas en borrador, revisa impagos y redacta recordatorios de cobro en Xero, y entrega un resumen mensual. Antes de emitir nada en España, tu gestor confirma que Xero cumple la normativa de facturación. Úsala cuando uses Xero y quieras quitarte trabajo repetitivo sin perder el control.
---
# Facturas y cobros en Xero con borradores

Esta skill hace el trabajo repetitivo de facturación y cobros en Xero. Lo deja todo en borrador o en propuesta. Una persona aprueba.

## Antes de empezar
- Xero es más habitual en Reino Unido, Australia y Nueva Zelanda que en España. Si facturas desde España, pregunta a tu gestor si las facturas y los libros que salen de Xero le sirven para tus impuestos (IVA, IRPF, modelos trimestrales) y cumplen la numeración y los datos obligatorios.
- Pregunta a tu gestor, por escrito, si Xero cumple los requisitos vigentes de software de facturación en España (Verifactu, TicketBAI o el sistema de tu territorio foral si estás en el País Vasco o en Navarra, y factura electrónica entre empresas) y desde qué fecha te obligan. Las fechas han cambiado antes: confírmalas en la web de la Agencia Tributaria o de tu hacienda foral. Si no está claro, usa esta skill solo para preparar borradores y no emitas facturas desde Xero hasta que tu gestor lo confirme. Una factura que no cumpla puede acarrear sanción.
- Esto es contabilidad y fiscalidad. Una persona (tú o tu gestor) revisa el resultado antes de enviar facturas, presentar impuestos o dar por buena una cifra.
- Un conector (MCP) es el enlace que deja a la IA (Claude, Codex, Gemini o una IA local) consultar y trabajar con Xero. Si no lo tienes, usa archivos CSV exportados o plantillas de importación. El resultado es el mismo con un paso manual más.

## Pregunta primero
1. ¿Es tu propio Xero o el de un cliente? Si es de un cliente, ¿te ha invitado con un rol limitado y hay contrato de encargo de tratamiento de datos?
2. ¿Quieres empezar en la organización de demostración de Xero (Demo Company) para probar? Es lo aconsejable la primera vez.
3. ¿Qué quieres hacer: facturas en borrador, repaso de impagadas, recordatorios o resumen mensual?
4. ¿Qué IVA, qué retención de IRPF y qué moneda llevan tus facturas? No lo supongas. [TIPOS QUE USAS]
5. ¿Trabajamos solo con lectura o también con escritura de borradores?
6. ¿Cuál es el siguiente número de factura y quién lo controla?
7. ¿Qué periodos están cerrados? No se tocan.
8. ¿Tu gestor ha confirmado por escrito que Xero cumple los requisitos de facturación en España? Si no, solo borradores.

## Paso a paso
1. Empieza en solo lectura. Lista las facturas vencidas y por vencer, con importe, cliente y días de retraso.
2. Si vas a crear facturas, pide los datos de cada una (cliente, concepto, importe, IVA, retención, fecha y condiciones de pago) o léelos de la hoja que te pasen.
3. Antes de crear nada, comprueba que el cliente ya existe (para no duplicarlo), que tiene NIF o CIF y dirección, que el IVA y la retención son los acordados, que el importe cuadra con el presupuesto o pedido y que las fechas tienen sentido.
4. Crea las facturas solo en estado borrador. Si es un lote, crea primero 3, enséñaselas a la persona y sigue solo si las aprueba.
5. Deja una lista de lo creado con cliente, importe, número provisional y enlace.
6. Para los impagos, redacta recordatorios escalonados: primero uno amable, luego uno firme y luego un último aviso. Con datos exactos (factura, fecha, importe, forma de pago). Sin amenazas ni acciones legales: eso lo decide una persona con su asesor.
7. Si te piden conciliar pagos con el banco, propón coincidencias en una lista con tu grado de seguridad (alto, medio o bajo). No las confirmes tú.
8. Prepara el resumen mensual: facturado, cobrado, pendiente, vencido, los 5 clientes que más deben y las facturas con más de [DÍAS] días. Indica de qué informe y de qué fecha sale cada dato.
9. Anota en un registro lo que has hecho: qué se leyó, qué se creó y qué se propone.

## Qué devolver
- Lista de facturas en borrador con sus datos.
- Lista de problemas encontrados (cliente duplicado, sin NIF, IVA raro, importes que no cuadran).
- Textos de recordatorio listos para copiar.
- Resumen mensual en una tabla corta más 3 frases.
- Preguntas para el gestor, entre ellas si Xero cumple los requisitos de facturación en España.

## Qué NO hacer
- No apruebes, envíes, contabilices ni borres facturas. Una factura emitida no se borra, se corrige con una factura rectificativa, y eso lo valida tu gestor.
- No des por buena una factura como emitida sin la confirmación por escrito de tu gestor sobre los requisitos de facturación en España.
- No toques facturas ya enviadas ni periodos cerrados.
- No cambies tipos de IVA, plan de cuentas, cuentas bancarias ni datos de la empresa.
- No registres pagos ni concilies sin confirmación expresa.
- No crees lotes grandes sin revisar antes los 3 primeros.
- No prepares ni presentes impuestos, ni des consejo fiscal. Ahí decide tu gestor.
- No inventes datos de clientes (NIF, direcciones, importes).
- No pegues claves, tokens ni códigos de acceso en el chat. Da acceso con los permisos mínimos.
- No uses datos de clientes para nada que no sea facturar y cobrar.
- No prometas cobrar antes ni reducir impagos: depende de cada cliente.

## Qué revisa una persona
- Tu gestor: que Xero cumple los requisitos de facturación en España y desde qué fecha, antes de emitir ninguna factura.
- Tu gestor o tú: cada factura en borrador, los tipos de IVA y de retención y cualquier cifra que vaya a impuestos, antes de enviar o contabilizar.
- Quien responda de los datos personales: el contrato de encargo de tratamiento si el Xero es de un cliente.
