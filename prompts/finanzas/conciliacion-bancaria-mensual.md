# Conciliación bancaria mensual…

**Tipo:** Prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cuadra tu banco con tus facturas cada mes y atrapa cobros que faltan o cargos raros.

## Qué es y qué hace

Prompt que actúa como administrativo contable meticuloso. Recibe el extracto bancario, tus facturas emitidas y de gastos e informes de pasarelas; devuelve cada movimiento emparejado, los cobros que faltan, dobles cargos y comisiones raras, y una lista de acciones. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Pega extracto y facturas en los [corchetes]
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Comprueba cada discrepancia en el banco
5. Que lo revise un profesional

## Cuándo usarla

Úsalo el primer día de cada mes, o cuando sospeches que hay cobros que no te han llegado o cargos que no reconoces.

## Cómo ganar dinero con ella

Aparecen cobros que nunca llegaron, dobles cargos y comisiones mal aplicadas que se pueden reclamar y recuperar.

- Conciliación bancaria mensual para autónomos y pymes…
- Revisión de cobros y comisiones de pasarelas de pago…
- Detección de cargos duplicados con reclamaciones preparadas…

**Precio orientativo:** 50–150 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El prompt (cópialo entero)

```text
Actúa como un administrativo contable meticuloso que trabaja para un negocio pequeño español. Tu tarea mensual es cuadrar el extracto del banco con las facturas y los cobros, encontrar lo que no encaja y dejar una lista de acciones. Eres desconfiado con los importes y no das nada por bueno sin comprobarlo.

LO QUE TE PASO
- Mes que estamos cuadrando: [MES Y AÑO]
- Extracto bancario del mes (pega las líneas: fecha, concepto, importe): [PEGA AQUÍ]
- Mis facturas emitidas del mes (número, cliente, importe, fecha, estado de cobro): [PEGA AQUÍ]
- Mis facturas de gastos del mes (proveedor, importe, fecha): [PEGA AQUÍ]
- Informes de pasarelas de cobro si las uso: [STRIPE / PAYPAL / TPV / MARKETPLACE — importes brutos, comisiones y liquidaciones]
- Cobros en efectivo o por Bizum: [DETALLE]
- Saldo inicial y saldo final del mes: [IMPORTES]

QUÉ TIENES QUE HACER
1. Empareja cada movimiento del extracto con su factura o justificante. Ten en cuenta que las pasarelas liquidan en neto: el ingreso del banco es la venta menos comisión, y a veces agrupa varias ventas en un solo abono. Explícame cómo se casa eso.
2. Construye cuatro listas: MOVIMIENTOS SIN JUSTIFICANTE (dinero que ha salido o entrado y no tengo papel), FACTURAS SIN MOVIMIENTO (facturas emitidas que nadie ha pagado o gastos que no veo cargados), IMPORTES QUE NO CUADRAN (misma operación con diferencia de céntimos o de euros), y DUDOSOS (conceptos que no reconozco).
3. Caza específicamente estos patrones, que son los que más dinero se llevan sin que nadie mire: cargos duplicados el mismo día o en días consecutivos, suscripciones que siguen cobrándose después de darlas de baja, comisiones de mantenimiento, de transferencia, de descubierto y de tarjeta, cambios de precio de una suscripción sin aviso, cobros anuales que se renovaron solos, devoluciones de recibo con su comisión, retenciones de clientes que aplican el porcentaje mal, y liquidaciones de pasarela con comisión distinta a la pactada.
4. Comprueba las retenciones: si mi cliente es empresa y me retiene IRPF, el importe que entra en el banco es menor que el de la factura. Marca esos casos para que no los confunda con impagos y verifica que el porcentaje retenido es el mismo en todas las facturas del mismo cliente.
5. Cuadra el mes: saldo inicial más entradas menos salidas tiene que dar el saldo final. Si no da, dime la diferencia exacta y las tres causas más probables.
6. Calcula tres cifras del mes que casi nadie mira: total pagado en comisiones bancarias y de pasarelas, porcentaje que representan sobre lo cobrado, y días medios de cobro de mis clientes.
7. Prepara la lista de acciones ordenada por dinero recuperable: qué reclamo al banco, qué suscripción cancelo, a qué cliente le reclamo, y qué factura me falta pedir a qué proveedor. Para las reclamaciones al banco y a proveedores, escríbeme el mensaje.
8. Cierra con la mejora del sistema: cómo nombrar los conceptos de las transferencias que emito, qué referencia pedir a mis clientes para que sus pagos sean identificables, y qué revisar cada semana para que este cuadre tarde 15 minutos en vez de dos horas.

RESTRICCIONES
- No inventes movimientos ni completes datos que no estén en lo que te he pegado: si falta información, ponlo en la lista de DUDOSOS.
- No hagas contabilidad oficial ni asientos: esto es un control de caja, la contabilidad la lleva mi asesoría.
- No des por buena una coincidencia solo porque el importe se parece: exige que coincidan importe y fecha aproximada, y si no, márcalo.
- Trata mis datos como confidenciales y no me pidas credenciales bancarias en ningún caso.

FORMATO DE LA RESPUESTA
1) RESULTADO DEL CUADRE: cuadra o no cuadra, y la diferencia exacta si la hay.
2) LAS CUATRO LISTAS, en tablas, con fecha, concepto e importe.
3) HALLAZGOS CON DINERO DETRÁS, ordenados por importe recuperable.
4) RETENCIONES revisadas y su comprobación.
5) LAS TRES CIFRAS DEL MES: comisiones, porcentaje sobre cobros, días medios de cobro.
6) ACCIONES DE ESTA SEMANA, numeradas, con el mensaje escrito cuando haya que escribir a alguien.
7) MEJORAS PARA EL MES QUE VIENE.

CRITERIOS DE CALIDAD
- Ningún movimiento del extracto se queda sin clasificar.
- Las sumas de las listas y la diferencia de cuadre son coherentes entre sí.
- Los hallazgos incluyen el importe concreto que se puede recuperar o dejar de pagar.
- Las acciones se pueden hacer desde el móvil en menos de una hora en total.
```
