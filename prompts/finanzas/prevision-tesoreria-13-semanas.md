# prevision-tesoreria-13-semanas…

**Tipo:** Prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Convierte tus cobros y pagos previstos en un calendario de caja semana a semana para ver con antelación en qué semana te quedas sin dinero.

## Qué es y qué hace

Prompt para cualquier chat de IA que convierte cobros y pagos previstos en un calendario de caja semanal. Devuelve la semana en que te quedas sin dinero y qué hacer: adelantar cobros, aplazar pagos o recortar. Ejemplo: revisar antes de firmar un gasto fijo.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con saldo, cobros y pagos
3. Pasa el calendario a una hoja de cálculo y actualízalo cada semana
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando no sepas si llegas a fin de mes, antes de contratar, comprar stock o firmar un gasto fijo, o cuando cobras tarde y pagas pronto.

## Cómo ganar dinero con ella

Ver el agujero de caja con semanas de margen te permite adelantar cobros o aplazar pagos sin recurrir a descubiertos ni financiación cara.

- Previsión de tesorería para pymes y autónomos…
- Seguimiento semanal de caja como servicio recurrente…
- Informe previo a contratar o comprar stock…

**Precio orientativo:** 100–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El prompt (cópialo entero)

```text
Actúa como director financiero de pymes especializado en tesorería de negocios pequeños en España. Tu trabajo no es contabilidad: es decirme si tengo dinero en la cuenta cada semana y qué hago si no.

CONTEXTO DEL NEGOCIO
- Actividad: [QUÉ VENDES Y A QUIÉN]
- Forma jurídica: [AUTÓNOMO O SOCIEDAD]
- Saldo real hoy en cuentas (suma de todas): [IMPORTE EN EUROS]
- Fecha de hoy: [FECHA]

COBROS PREVISTOS (una línea por cobro; pon lo que sepas aunque sea aproximado)
[CLIENTE O CONCEPTO | IMPORTE CON IVA | FECHA PREVISTA DE COBRO | SEGURIDAD: ALTA MEDIA O BAJA]
[REPITE TANTAS LÍNEAS COMO HAGA FALTA]

PAGOS PREVISTOS (una línea por pago)
[CONCEPTO | IMPORTE | FECHA | FIJO O VARIABLE | SE PUEDE APLAZAR: SÍ O NO]
[INCLUYE: ALQUILER, CUOTA DE AUTÓNOMOS O SEGUROS SOCIALES, NÓMINAS, PROVEEDORES, SUSCRIPCIONES, PRÉSTAMOS, IVA E IRPF TRIMESTRAL, SEGUROS, GESTORÍA]

LO QUE TIENES QUE HACER, PASO A PASO
1. Construye un calendario de 13 semanas (un trimestre) empezando en la semana de hoy. Para cada semana: saldo inicial, cobros, pagos, saldo final.
2. Aplica un ajuste de realismo a los cobros: los de seguridad alta al 100%, los de seguridad media al 70%, los de seguridad baja al 40%, y retrasa 15 días cualquier cobro de cliente que históricamente pague tarde si te lo indico. Explica el ajuste que has aplicado.
3. Si no te he dado los impuestos, calcúlalos y colócalos tú: IVA del trimestre (modelo 303) y pago fraccionado de IRPF (modelo 130) se liquidan del 1 al 20 de abril, julio y octubre, y del 1 al 30 de enero. Recuérdame que el IVA cobrado no es mío.
4. Marca en rojo cada semana con saldo final por debajo de mi colchón mínimo. Si no te lo he dicho, propón como colchón mínimo el importe de un mes de gastos fijos y dime cuál es.
5. Calcula tres cifras clave: la primera semana en negativo, el importe máximo que me falta y cuántos días de caja tengo (saldo hoy dividido entre el gasto medio diario).
6. Propón un plan de acción concreto y ordenado por facilidad: qué facturas reclamar y a quién, qué pagos aplazar o fraccionar, qué cobro puedo adelantar ofreciendo un pequeño descuento, y qué gasto puedo cancelar esta misma semana.
7. Haz un escenario pesimista: si se retrasa un mes el cobro más grande, ¿qué pasa? Dilo en una frase con la cifra.

REGLAS
- Trabaja siempre con importes con IVA, porque es el dinero que de verdad entra y sale de la cuenta.
- Nunca mezcles beneficio con caja: puedo tener beneficio y no tener dinero, y quiero saber lo segundo.
- No inventes datos. Si falta algo importante, márcalo como SUPUESTO y ponlo en una lista aparte al final.
- No me recomiendes financiación como primera opción; primero cobrar antes, gastar menos y aplazar.
- No des consejo fiscal cerrado: para casos concretos, remíteme a mi gestor.

ERRORES TÍPICOS QUE DEBES DETECTAR Y AVISARME
- Contar como cobrado lo que solo está facturado.
- Olvidar el trimestre de impuestos y la cuota de autónomos.
- Depender de un solo cliente para más del 30% de los cobros del trimestre.
- Pagar a proveedores a 15 días mientras cobro a 60.
- No tener ningún colchón: cualquier retraso me deja en descubierto.

FORMATO DE LA RESPUESTA
1) SEMÁFORO: una frase con el veredicto y la fecha del primer problema.
2) TABLA de 13 filas: Semana | Fechas | Saldo inicial | Cobros | Pagos | Saldo final | Estado.
3) LAS TRES CIFRAS CLAVE, en grande y explicadas en una línea cada una.
4) PLAN DE ACCIÓN: máximo 6 acciones, cada una con qué hacer, a quién, cuándo y cuántos euros aporta.
5) ESCENARIO PESIMISTA en dos líneas.
6) SUPUESTOS que has tenido que inventar.

CRITERIOS DE CALIDAD
- Toda cifra de la tabla tiene que poder reconstruirse con los datos que te he dado; si no, es un supuesto declarado.
- El plan de acción tiene que sumar, en euros, al menos el agujero máximo detectado.
- Nada de generalidades tipo 'controla tus gastos': cada acción con nombre, importe y fecha.

EMPIEZA ASÍ: si me falta algún dato imprescindible (saldo de hoy, gastos fijos mensuales o fecha del próximo trimestre de impuestos), hazme como máximo cinco preguntas concretas y espera mi respuesta antes de calcular nada.
```
