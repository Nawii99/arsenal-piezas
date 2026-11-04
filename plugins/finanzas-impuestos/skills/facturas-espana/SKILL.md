---
name: facturas-espana
description: Requisitos legales de una factura en España y ficha con los datos fiscales del usuario. Úsala siempre que pida hacer, revisar o corregir una factura, o hable de IVA, retención de IRPF, factura simplificada o rectificativa.
---

# Facturas en España

Esta skill tiene dos partes: tus datos fiscales (para no repetirlos en cada factura) y las reglas que hacen que una factura sea válida ante Hacienda.

## Ficha del emisor

Si los campos siguen con [corchetes], pídelos al usuario de uno en uno, en lenguaje llano, y actualiza este archivo.

- **Nombre o razón social**: [NOMBRE COMPLETO O EMPRESA]
- **NIF**: [NIF]
- **Domicilio fiscal**: [CALLE, CP, CIUDAD]
- **Forma jurídica**: [AUTÓNOMO / SL]
- **Actividad y epígrafe de IAE**: [ej: servicios de marketing, epígrafe XXX]
- **Retención de IRPF que aplicas**: [15 % / 7 % / NINGUNA]
- **Serie y último número de factura emitido**: [ej: 2026-014]
- **IBAN para cobros**: [IBAN]
- **Plazo de pago habitual**: [ej: 15 días]

## Qué lleva obligatoriamente una factura completa

1. Número y, si la usas, serie. Correlativo, sin huecos. Un número nunca se reutiliza ni se borra.
2. Fecha de expedición. Si el trabajo se hizo en otra fecha, también la fecha de la operación.
3. Nombre o razón social, NIF y domicilio del emisor.
4. Nombre o razón social, NIF y domicilio del cliente.
5. Descripción de lo facturado: qué, cuánto y precio unitario si aplica. "Servicios varios" no vale.
6. Base imponible (suma sin impuestos).
7. Tipo de IVA aplicado (21 % general, 10 % reducido, 4 % superreducido) y cuota resultante. Marketing, diseño, consultoría y formación no reglada: 21 %.
8. Retención de IRPF si procede (ver abajo), con su tipo y su importe en negativo.
9. Total a pagar = base + IVA − retención. Dos decimales, en euros.
10. Si no lleva IVA, el motivo escrito. Cliente empresa de otro país de la UE con NIF-IVA validado: "Operación no sujeta. Inversión del sujeto pasivo". Actividad exenta: "Operación exenta según artículo 20 de la Ley 37/1992".

## Retención de IRPF: cuándo sí y cuándo no

- Solo si eres autónomo en actividad profesional (epígrafe de la sección 2ª del IAE) y el cliente es empresa o autónomo con sede en España. A particulares nunca se les retiene. Si tu epígrafe es empresarial (sección 1ª), tampoco.
- Tipo general: 15 %. Si te diste de alta este año o en los dos anteriores, puedes aplicar el 7 % avisando al cliente por escrito.
- La retención la ingresa el cliente en Hacienda en tu nombre: cobras menos ahora, pero ese IRPF ya está adelantado.
- Si facturas desde una SL, no aplicas retención.

## Factura simplificada (el "ticket")

Vale hasta 400 € IVA incluido (hasta 3.000 € en comercio minorista, hostelería, transporte de viajeros y pocos sectores más). Lleva número, fecha, tu NIF y nombre, descripción, tipo de IVA o "IVA incluido" y total. No lleva datos del cliente. Si el cliente quiere deducirse el IVA, tiene que pedirte factura completa.

## Plazos y conservación

- Cliente empresa o autónomo: la factura se emite antes del día 16 del mes siguiente a la operación.
- Cliente particular: en el momento de la venta.
- Guarda emitidas y recibidas al menos 4 años. Si tienes sociedad, 6 por el Código de Comercio.

## Si te equivocas: rectificativa, nunca editar

Una factura ya emitida no se modifica ni se borra. Se emite una factura rectificativa con su propia serie (ej: R-2026-001) que cita número y fecha de la original y explica qué corrige. Para anularla entera, la rectificativa lleva los importes en negativo.

## Verifactu: el riesgo que hay que tener en cuenta

El Real Decreto 1007/2023 obliga a emitir facturas con un programa que genere un registro y un código QR verificables por Hacienda. Cuando te aplique, una factura hecha en Word, en Excel o con este asistente no será válida: tendrás que usar un programa de facturación adaptado (varios tienen plan gratuito o de pocos euros al mes). La fecha de entrada en vigor se ha aplazado al menos una vez: [comprueba en sede.agenciatributaria.gob.es la fecha que te aplica según seas autónomo o sociedad]. Hasta entonces, lo que generes aquí sirve si cumple los puntos de arriba.

## Cómo trabajar con el usuario

- Antes de generar nada, comprueba que la ficha está completa y pide los datos del cliente y las partidas.
- Muestra siempre la cuenta: base, IVA, retención, total.
- Si el número que toca no es el siguiente al de la ficha, avisa antes de seguir.
- Cuando emitas una factura nueva, actualiza el último número en la ficha.

## Qué NO hacer

- No inventar NIF ni direcciones del cliente: si faltan, pedirlos.
- No poner IVA a un cliente de la UE con NIF-IVA validado ni retención a un particular.
- No dar por buena una factura sin número correlativo o sin desglose de IVA.
- No responder dudas fiscales concretas (deducciones, módulos, recargo de equivalencia) como si fueran seguras: orientar y remitir a un gestor.
