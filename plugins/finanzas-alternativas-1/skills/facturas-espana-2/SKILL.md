---
name: facturas-espana-2
description: Genera o revisa facturas de autónomos y pymes en España con los datos obligatorios (RD 1619/2012), IVA, retención de IRPF y facturas simplificadas o rectificativas. Actívala cuando el usuario pida hacer una factura, revisar una, montar una plantilla de facturas o preparar un pack de facturación para un cliente.
---

# Facturas que cumplen la ley en España

Esta skill no es asesoramiento fiscal. Sirve para que la factura salga completa y con los cálculos bien. Si hay dudas de régimen (recargo de equivalencia, módulos, operaciones con la UE), decirlo y remitir al gestor.

## Qué preguntar antes de empezar

Si falta cualquiera de estos datos, preguntar. No inventar ninguno.

1. Quién emite: nombre y apellidos o razón social, NIF, domicilio fiscal. ¿Autónomo o sociedad?
2. Quién recibe: nombre o razón social, NIF, domicilio. ¿Es empresa/autónomo o particular?
3. Qué se factura: descripción concreta de cada línea, cantidad, precio unitario sin IVA.
4. Tipo de IVA: general 21 %, reducido 10 %, superreducido 4 %, o exento (y por qué artículo).
5. ¿Lleva retención de IRPF? Solo si el emisor es autónomo profesional y el cliente es empresa o autónomo. Tipo: 15 % general, 7 % durante el año de alta y los dos siguientes (el usuario debe confirmar cuál le toca).
6. Número y serie: el último número emitido para seguir la correlación.
7. Fecha de la operación si es distinta de la fecha de emisión.
8. Forma y plazo de pago: IBAN, Bizum, transferencia, días de vencimiento.

## Datos obligatorios (Real Decreto 1619/2012, art. 6)

Una factura completa lleva todo esto. Si falta uno, no es válida para deducir:

- Número y, si se usan, serie. Correlativos, sin huecos.
- Fecha de expedición.
- Nombre y apellidos o razón social del emisor y del destinatario.
- NIF del emisor. NIF del destinatario si es empresario o profesional, o si la operación es intracomunitaria o con inversión del sujeto pasivo.
- Domicilio de ambos.
- Descripción de las operaciones con todo lo necesario para calcular la base imponible.
- Base imponible, tipo de IVA aplicado y cuota resultante, por separado si hay varios tipos.
- Fecha de la operación si es distinta de la de expedición.
- Si está exenta: mención al artículo (por ejemplo, 'Operación exenta de IVA según art. 20 Ley 37/1992').
- Si aplica: 'Inversión del sujeto pasivo', 'Régimen especial del criterio de caja' o 'Facturación por el destinatario'.

## Factura simplificada (el antiguo ticket)

Se puede emitir si el importe no supera 400 € IVA incluido, o 3.000 € en actividades como comercio al por menor, hostelería, transporte de personas o peluquería. No lleva datos del destinatario ni desglose completo, pero sí número, fecha, NIF y nombre del emisor, descripción, tipo de IVA o la expresión 'IVA incluido' y el total. Si el cliente la quiere para deducir, hay que hacer una factura completa.

## Factura rectificativa

Para corregir una ya emitida (error de datos, devolución, descuento posterior). Va en una serie distinta, indica que es rectificativa, el número y fecha de la factura que corrige y el motivo. Nunca se borra ni se edita la original.

## Paso a paso

1. Comprobar la lista de datos obligatorios de arriba contra lo que ha dado el usuario. Listar lo que falta y pedirlo.
2. Calcular por línea: cantidad x precio unitario = base de la línea.
3. Sumar bases por tipo de IVA. Calcular cuota de cada tipo.
4. Si hay retención de IRPF: aplicarla sobre la base imponible total (no sobre el total con IVA). Restarla del total.
5. Total a pagar = base + IVA - retención.
6. Mostrar los cálculos con dos decimales y el redondeo explicado.
7. Añadir bloque de pago: método, IBAN o enlace, fecha de vencimiento.
8. Entregar en el formato pedido (ver abajo).

## Qué devolver

Por defecto, dos cosas:

1. La factura en Markdown con esta estructura: cabecera con FACTURA, número y fechas; bloque emisor; bloque cliente; tabla de líneas (concepto, cantidad, precio, base); bloque de totales (base, IVA por tipo, retención IRPF si aplica, TOTAL); forma de pago; menciones legales si las hay.
2. Una lista 'Comprobado' con cada dato obligatorio y su estado (OK o FALTA).

Si el usuario lo pide, generar además un HTML sencillo listo para imprimir a PDF desde el navegador, o un archivo .csv con la línea para pegar en su hoja de facturas.

## Cómo venderlo como servicio

Lo que se puede cobrar no es 'hacer una factura', es quitarle el papeleo a alguien que lo odia. Formatos que funcionan:

- Pack de arranque para autónomo nuevo: plantilla de factura completa, simplificada y rectificativa con sus datos ya metidos, hoja de registro numerada y un documento de una página con 'qué IVA e IRPF te toca'. Precio orientativo: [DEFINE TU PRECIO], factura única.
- Facturación mensual: el cliente te pasa por WhatsApp o email lo que ha vendido y tú emites, numeras y archivas. Cuota mensual: [DEFINE TU PRECIO].
- Revisión de facturas antes de la declaración trimestral: pasar cada factura por la lista 'Comprobado' y avisar de las que no valen.

Tu propio servicio lleva IVA al 21 % y, si eres autónomo profesional y facturas a empresas, retención de IRPF. Aplica esta misma skill a tus facturas.

Riesgos reales que hay que decir al cliente por escrito:

- Tú preparas documentos, no sustituyes al gestor. Quien firma la declaración es el cliente.
- Desde la entrada en vigor de Verifactu (Ley 11/2021 y RD 1007/2023) los programas de facturación deben cumplir requisitos técnicos. Las fechas se han aplazado varias veces: [comprueba la fecha vigente en la web de la AEAT antes de prometer nada]. Una plantilla de Word o Excel usada a mano no es un programa, pero hay debate sobre dónde está el límite. Si el cliente quiere volumen, recomendar un programa de facturación homologado y no intentar sustituirlo con n8n.
- Las facturas se guardan al menos 4 años a efectos de Hacienda y 6 según el Código de Comercio. Ante la duda, 6.

## Qué NO hacer

- No inventar NIF, direcciones ni números de factura. Si falta, pedirlo.
- No decidir el tipo de IVA por intuición. Si el usuario no lo sabe, preguntar qué vende y proponer un tipo marcando que debe confirmarlo con su gestor.
- No aplicar retención de IRPF a facturas a particulares ni a facturas emitidas por sociedades.
- No calcular la retención sobre el total con IVA.
- No saltar números de factura ni reutilizar uno anulado. Lo anulado se corrige con rectificativa.
- No poner 'factura proforma' como si fuera factura: una proforma no tiene validez fiscal y no se numera en la serie oficial.
- No prometer al cliente que 'así ya cumple con Hacienda'. Lo correcto es 'esta factura lleva los datos que exige la norma'.
