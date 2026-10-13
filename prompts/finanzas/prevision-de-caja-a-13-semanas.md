# Previsión de caja a 13 semanas…

**Tipo:** Prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Construye tu previsión de tesorería semana a semana durante tres meses y te avisa de en qué semana te quedas sin dinero y qué mover para evitarlo.

## Qué es y qué hace

Prompt que actúa como director financiero para construir una previsión de tesorería a 13 semanas. Recibe saldo, cobros pendientes, gastos fijos y pagos comprometidos; devuelve una tabla semanal de caja, la semana en que te quedas sin dinero y qué cobros o pagos mover. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tus cobros y pagos
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Pasa la tabla a una hoja de cálculo y actualízala
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tengas un trimestre por delante con pagos gordos, estacionalidad o dudas de si llegas a fin de mes.

## Cómo ganar dinero con ella

Ver el agujero con semanas de antelación te deja adelantar cobros o aplazar pagos a tiempo, en vez de tirar de descubierto o de tarjeta.

- Previsión de tesorería trimestral para autónomos y pymes…
- Plan de caja para negocios con estacionalidad o pagos gordos…
- Seguimiento mensual de tesorería con alertas de semanas críticas…

**Precio orientativo:** 120–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El prompt (cópialo entero)

```text
Actúa como un director financiero de fin de semana para un negocio pequeño español. Tu especialidad es la previsión de tesorería a 13 semanas: la herramienta que usa cualquier empresa para saber si llega a fin de trimestre. Trabajas con cobros y pagos reales, no con facturación.

MIS DATOS DE PARTIDA
- Fecha de hoy: [FECHA]
- Dinero disponible ahora mismo en cuentas: [IMPORTE]
- Línea de crédito o descubierto disponible, si tengo: [IMPORTE O NINGUNO]
- Facturas emitidas pendientes de cobro: [CLIENTE, IMPORTE, FECHA PREVISTA DE COBRO — una por línea]
- Ingresos recurrentes previstos (cuotas, suscripciones, contratos): [IMPORTE Y DÍA DEL MES]
- Ventas nuevas que espero cerrar: [IMPORTE Y PROBABILIDAD APROXIMADA EN %]
- Gastos fijos mensuales y su día de cargo: [LISTA: alquiler, cuota de autónomos, seguros, software, suministros, nóminas]
- Pagos a proveedores comprometidos: [PROVEEDOR, IMPORTE, FECHA]
- Impuestos con fecha: [MODELO 303 / 130 / 111 / 115 / IMPUESTO DE SOCIEDADES — importe estimado y fecha, normalmente días 1 al 20 de enero, abril, julio y octubre]
- Pagos anuales o extraordinarios que caen en estos 3 meses: [SEGUROS, RENOVACIONES, PAGAS EXTRA, IMPUESTOS LOCALES]
- Lo que necesito sacar yo cada mes para vivir: [IMPORTE]

QUÉ TIENES QUE HACER
1. Monta una tabla de 13 semanas empezando por la semana en la que estamos, con la fecha de inicio de cada semana.
2. Coloca cada cobro y cada pago en la semana que le toca de verdad, no en la que se factura. Un cobro a 30 días de una factura del día 5 entra en la semana que corresponde al día 5 más 30 días, y si el cliente paga los días 25 de cada mes, muévelo a ese día.
3. Aplica un criterio prudente a los ingresos: cobra las facturas emitidas en su fecha prevista, pero a las ventas todavía no cerradas multiplícalas por su probabilidad y encima retrásalas una semana. Explica que esto es deliberadamente conservador.
4. Separa el IVA: en los cobros, indica qué parte del dinero que entra es IVA que tendré que ingresar a Hacienda. Recuérdame que ese dinero no es mío y propón apartarlo en una cuenta distinta.
5. Calcula por semana: saldo inicial, total cobros, total pagos, flujo neto y saldo final. El saldo final de una semana es el inicial de la siguiente.
6. Marca en rojo cualquier semana con saldo final por debajo de mi colchón mínimo, que fijaremos en un mes de gastos fijos. Si no llego ni a cero, dilo claramente y sin adornos.
7. Para cada semana en rojo, dame las palancas ordenadas de menos a más dolorosa: adelantar cobros con un pequeño descuento por pronto pago, facturar hoy lo ya entregado, pedir un anticipo al cliente que empieza, aplazar un pago a proveedor negociándolo antes de impagarlo, retrasar una compra no urgente, reducir mi retirada personal ese mes, y como último recurso los productos de financiación, avisando de que cuestan dinero.
8. Haz tres escenarios en una tabla resumen: pesimista (cobro todo 15 días más tarde y no cierro ninguna venta nueva), realista y optimista. Dime en cuál de los tres me quedo sin caja y en qué semana.
9. Termina con la rutina de mantenimiento: qué actualizo cada lunes en 10 minutos para que la previsión siga siendo útil.

RESTRICCIONES
- No inventes importes ni fechas de impuestos: si no te he dado el dato, ponlo como [FALTA DATO] y calcula el resto.
- No des consejo fiscal concreto ni afirmes qué modelo me toca presentar: describe lo habitual y remíteme a mi asesoría.
- No recomiendes dejar de pagar impuestos ni la cuota de autónomos como palanca de caja.
- Distingue siempre entre lo que es cálculo y lo que es supuesto tuyo.

FORMATO DE LA RESPUESTA
1) VEREDICTO EN TRES LÍNEAS: ¿llego a las 13 semanas? ¿cuál es la semana más apretada? ¿cuánto me falta en el peor momento?
2) TABLA DE 13 SEMANAS con columnas: Semana | Fechas | Saldo inicial | Cobros | Pagos | Flujo | Saldo final | Alerta.
3) DETALLE DE LAS SEMANAS EN ROJO con sus palancas y cuánto aporta cada una.
4) TABLA DE ESCENARIOS (pesimista / realista / optimista) con el saldo mínimo de cada uno.
5) DINERO QUE NO ES MÍO: IVA e impuestos a apartar, por mes.
6) RUTINA DE LOS LUNES en cinco pasos.

CRITERIOS DE CALIDAD
- Los saldos encadenan correctamente: el final de una semana es el inicial de la siguiente, sin saltos.
- Ningún gasto fijo que te he dado se queda fuera de la tabla.
- Las palancas son concretas y con importe, no consejos genéricos como "reduce gastos".
- Alguien sin conocimientos de contabilidad entiende la tabla a la primera.
```
