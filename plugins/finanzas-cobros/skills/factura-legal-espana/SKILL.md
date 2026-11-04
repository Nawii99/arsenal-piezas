---
name: factura-legal-espana
description: Revisa o redacta una factura española con todos los campos obligatorios (numeración, NIF, IVA, retención IRPF, menciones de exención). Se activa cuando el usuario dice factura, facturar, emitir factura, nota de pago o pega una factura para revisar.
---

# Factura legal para autónomo en España

## Qué hace
Toma los datos de una venta (o una factura ya hecha) y devuelve una factura con todo lo que exige el Reglamento de facturación (Real Decreto 1619/2012). Si falta algo, lo dice campo por campo. No es asesoría fiscal: para casos raros (extranjero, exenciones, recargo de equivalencia) remite al gestor.

## Qué preguntar antes de empezar
Solo lo que no esté ya en el mensaje. Nunca inventes un dato fiscal.
1. ¿Quién emite? Nombre y apellidos o razón social, NIF, domicilio fiscal.
2. ¿Quién recibe? Nombre o razón social, NIF/CIF, domicilio. Si es particular sin NIF y el importe es menor de 400 € con IVA, se puede hacer factura simplificada (ticket).
3. ¿Qué se vende? Descripción clara, cantidad, precio unitario sin IVA.
4. ¿Qué IVA lleva? 21 % general, 10 % o 4 % reducidos, o exento (indicar por qué: por ejemplo formación reglada, sanidad, artículo 20 de la Ley del IVA).
5. ¿Hay retención de IRPF? Solo si el emisor es autónomo (persona física) y el cliente es empresa o autónomo. 15 % general; 7 % durante el año de alta y los dos siguientes. Si el cliente es particular, no hay retención.
6. ¿Qué número le toca? Las facturas van numeradas de forma correlativa dentro de cada serie, sin huecos. Pide el último número emitido.
7. Fecha de emisión y, si es distinta, fecha en que se hizo el trabajo.
8. Forma y plazo de pago (IBAN, Bizum, transferencia, fecha límite).

## Paso a paso
1. Lista los datos recibidos y marca los que faltan. Si falta NIF de cualquiera de las dos partes, para: sin NIF no hay factura completa.
2. Calcula base imponible = suma de líneas sin IVA.
3. Calcula cuota de IVA = base × tipo. Si hay varios tipos, una línea de IVA por cada tipo.
4. Si aplica retención, calcula retención = base × porcentaje. La retención se resta del total a pagar, pero el IVA se calcula sobre la base, no sobre la base menos retención.
5. Total a pagar = base + IVA − retención.
6. Añade las menciones obligatorias cuando toquen: "Operación exenta de IVA según artículo [X] de la Ley 37/1992", "Inversión del sujeto pasivo" (cliente empresa de la UE con NIF-IVA), "Factura rectificativa de la nº [X]" si corrige otra.
7. Monta la factura con el formato de abajo y repasa la lista de comprobación final.

## Qué devolver
Primero la factura en texto plano lista para copiar a Word, Google Docs o al programa de facturación. Después la lista de comprobación.

FACTURA Nº [SERIE]-[NÚMERO]
Fecha de emisión: [DD/MM/AAAA]
Fecha de la operación: [solo si es distinta]

EMISOR
[Nombre o razón social]
NIF: [NIF]
[Dirección completa]

CLIENTE
[Nombre o razón social]
NIF: [NIF]
[Dirección completa]

CONCEPTO | CANTIDAD | PRECIO UNITARIO | IMPORTE
[Descripción] | [n] | [x €] | [x €]

Base imponible: [x €]
IVA [21] %: [x €]
Retención IRPF [15] %: −[x €]
TOTAL A PAGAR: [x €]

Forma de pago: [transferencia al IBAN ES..]
Vencimiento: [DD/MM/AAAA]
[Menciones legales si aplican]

Lista de comprobación (marca cada una):
- Número correlativo, sin saltos respecto a la anterior
- NIF y domicilio de las dos partes
- Descripción que se entienda sin preguntar
- Base, tipo de IVA, cuota y total por separado
- Retención solo si emisor persona física y cliente empresa/autónomo
- Mención de exención o inversión del sujeto pasivo si no hay IVA
- Fecha de emisión dentro de los plazos: como tarde el día 16 del mes siguiente a la operación si el cliente es empresa

## Avisos que van dentro de la respuesta
- Una factura emitida no se borra ni se edita. Si te equivocas, se hace una factura rectificativa que la anula o corrige.
- Guarda todas las facturas emitidas y recibidas al menos 4 años (plazo de prescripción fiscal), mejor 6 por el Código de Comercio.
- El sistema Verifactu (facturación con registro verificable ante la AEAT) tiene fechas de obligación que han cambiado varias veces. Antes de elegir programa de facturación, comprueba la fecha vigente para tu caso en la web de la AEAT: [consultar sede.agenciatributaria.gob.es]. Un Excel o un Word no van a cumplirlo.

## Qué NO hacer
- No inventes NIF, direcciones ni números de factura. Si faltan, déjalos entre corchetes y dilo.
- No apliques retención a facturas a particulares ni a clientes fuera de España.
- No pongas IVA en una factura a empresa de otro país de la UE sin comprobar que tiene NIF-IVA (ROI). Si no lo sabes, dilo y remite al gestor.
- No des por buena una exención de IVA solo porque el usuario lo diga: pide el artículo o remite al gestor.
- No mezcles series ni reinicies la numeración a mitad de año sin motivo.
- No conviertas un presupuesto o una factura proforma en factura sin cambiar el título y asignar número: la proforma no tiene validez fiscal.
