---
name: facturas-zoho-con-visto-bueno
description: Prepara facturas, presupuestos y recordatorios de cobro en Zoho Invoice como borradores, comprueba los datos fiscales y no envía nada sin tu aprobación. Úsala cuando haya que emitir o revisar facturas, repetir una facturación o conciliar cobros.
---

# Facturas en Zoho con visto bueno

Instalación: guarda este texto como SKILL.md dentro de la carpeta .claude/skills/facturas-zoho-con-visto-bueno/ de tu proyecto. Claude Code la activa cuando hablas de facturas en Zoho; también puedes nombrarla tú.

## Qué hace
- Prepara facturas y presupuestos como borradores a partir de pedidos, hojas o presupuestos aceptados.
- Revisa que no falte nada de lo que debe llevar una factura en España y que las cuentas cuadren.
- Avisa de posibles duplicados y de importes raros.
- Propone qué cobros del banco corresponden a qué facturas.
- Redacta recordatorios de pago en tono correcto para que tú los envíes.
- Una factura es un documento fiscal. Esta skill prepara, tú decides y envías.

## Cómo se conecta (dos formas)
- Con conector (MCP): es un enlace que deja a Claude Code hablar con Zoho. Escribe /mcp para ver los que tienes. Si no hay ninguno, pídele a Claude Code que te guíe para añadirlo [COMPRUEBA EN LA DOCUMENTACIÓN DE ZOHO SI HAY CONECTOR OFICIAL Y QUÉ PERMISOS PIDE].
- Sin conector: Claude te devuelve una hoja con las facturas preparadas y tú las creas o importas en Zoho. Es más lento y más seguro. Empieza por aquí.
- Tu cuenta vive en un centro de datos de Zoho (en España suele ser el europeo, con direcciones zoho.eu). El conector debe apuntar al mismo.
- Crea el acceso con permisos mínimos y con un usuario propio para esto. Si puedes, que no tenga permiso para enviar ni borrar.
- Mientras Claude analiza, activa el modo plan (Mayús+Tab hasta que lo indique): en ese modo no cambia nada.

## Antes de empezar, pregunta
1. ¿De dónde salen los datos de cada factura: pedido, hoja, presupuesto aceptado?
2. ¿Cuál es el último número emitido en cada serie? La numeración es correlativa y no se improvisa.
3. ¿Qué IVA se aplica a cada producto o servicio: 21 %, 10 %, 4 % o exento? Si hay exención, ¿con qué motivo? Lo decide tu gestor, no esta skill.
4. ¿Hay retención de IRPF en alguna factura? El porcentaje lo confirma tu gestor.
5. ¿Hay clientes de fuera de España o de Canarias, Ceuta o Melilla? Esas facturas se tratan aparte, con una persona.
6. ¿Tu software de facturación debe cumplir el reglamento Verifactu y desde cuándo? Las fechas se han ido aplazando [COMPRUEBA LA FECHA Y EL ESTADO ACTUALES EN LA WEB DE LA AGENCIA TRIBUTARIA Y CON TU GESTOR]. Tampoco des por hecho que Zoho Invoice lo cumpla en tu caso.
7. ¿Hay clientes en disputa a los que no se debe escribir?

## Paso a paso
1. Reúne los datos y fíjate en lo que falta antes de preparar nada.
2. Valida cada factura. Debe llevar: número y serie, fecha, datos completos del emisor y del cliente (nombre o razón social, NIF/CIF y domicilio), descripción de lo facturado, base imponible, tipo de IVA y cuota, retención si aplica y total. Si la fecha de la operación es distinta de la de factura, también esa.
3. Recalcula tú las cuentas: base más IVA menos retención tiene que dar el total. Si no coincide, no lo corrijas en silencio: avisa.
4. Comprueba que el NIF tiene pinta de válido (longitud y letra de control). Eso no prueba que exista; la web de la Agencia Tributaria tiene un servicio para contrastar NIF.
5. Busca posibles duplicados: mismo cliente, mismo concepto y mismo importe en los últimos [N] DÍAS. Busca también importes muy distintos de lo habitual para ese cliente.
6. Si el cliente paga en otra moneda, pregunta la divisa y de dónde sale el tipo de cambio. No lo inventes.
7. Crea borradores, nunca facturas emitidas. Si no hay conector, prepara la hoja de importación.
8. Presenta la tabla de borradores con avisos y espera tu aprobación escrita, factura por factura o por lote que hayas visto.
9. Envío: solo si dices expresamente «envía las facturas número X, Y y Z». Si no, no se envía nada.
10. Conciliación de cobros: compara el extracto del banco (CSV) con las facturas pendientes y propón parejas por importe y concepto. Las dudosas las decides tú. No marques una factura como cobrada sin ver el ingreso.
11. Recordatorios: redacta borradores en tono cordial y escalonado. No amenaces ni cites intereses de demora o acciones legales sin que lo vea tu gestor o abogado.
12. Facturas recurrentes: propón la configuración, pero no la actives. Ver una configuración propuesta no es lo mismo que revisar cada emisión.

## Qué devolver
- Una tabla de borradores con: número provisional, cliente, concepto, base, IVA, retención, total, vencimiento y avisos.
- La lista de facturas bloqueadas por falta de datos, con lo que falta y a quién pedirlo.
- La lista de comprobaciones hechas y su resultado.
- Los cobros conciliados y los dudosos, por separado.
- Los borradores de recordatorio, sin enviar.
- Lo que no se ha podido comprobar.

## Qué NO hacer
- No borres ni edites una factura ya emitida o enviada. Si hay un error, se corrige con una factura rectificativa y lo decide tu gestor.
- No cambies numeraciones ni series.
- No envíes facturas ni recordatorios por tu cuenta.
- No inventes NIF, direcciones, tipos de IVA ni retenciones.
- No des una factura por cobrada sin comprobar el ingreso.
- No des consejo fiscal: marca la duda y pásala a una persona.
- No afirmes que Zoho Invoice cumple Verifactu u otra norma: se comprueba aparte.
- No metas datos de clientes en servicios externos que no hayas elegido tú.
- No pegues contraseñas, tokens ni claves en el chat.

## Cuándo pedir a una persona
- Tu gestor revisa el tipo de IVA, las exenciones, las retenciones, las series, las rectificativas, Verifactu y la factura electrónica entre empresas antes de usar este flujo, y de nuevo cuando cambie la normativa.
- Tú revisas cada borrador antes de enviarlo: cliente, concepto, importe y fecha.
- Una persona decide cualquier factura a clientes extranjeros, con operaciones exentas o con importes fuera de lo normal.
- Un abogado o tu gestor revisa los recordatorios si el cliente está en disputa o si vas a reclamar intereses.
