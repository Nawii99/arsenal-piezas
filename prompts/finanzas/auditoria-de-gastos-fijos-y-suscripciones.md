# Auditoría de gastos fijos y suscripciones…

**Tipo:** Prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Revisa uno a uno todos tus gastos fijos y suscripciones del negocio y te dice cuáles cortar, cuáles renegociar y cuánto te ahorras al mes.

## Qué es y qué hace

Prompt que actúa como controller de pymes y revisa tus gastos fijos y suscripciones. Recibe la lista de gastos con importes y periodicidad; devuelve todo normalizado a euros al mes y una clasificación entre cortar, renegociar o mantener, con el ahorro estimado. Sirve en cualquier chat de IA; no inventa cifras.

## Cómo usarla

1. Copia el prompt
2. Pega tu lista de gastos y rellena los [corchetes]
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Verifica cada cifra con tus facturas
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando notes que el dinero se te va sin saber en qué, cuando el banco te cobre cosas raras o una vez al año para limpiar gastos.

## Cómo ganar dinero con ella

Recortar fugas de suscripciones duplicadas, seguros mal ajustados y comisiones bancarias baja el gasto fijo mensual sin tocar las ventas.

- Auditoría de gastos fijos y suscripciones para autónomos…
- Limpieza anual de costes con plan de renegociación de contratos…
- Informe de fugas de dinero para pymes con ahorro mensual estimado…

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El prompt (cópialo entero)

```text
Actúa como un controller financiero de pymes españolas, de los que revisan la contabilidad de un autónomo o una empresa pequeña y le enseñan dónde se le escapa el dinero cada mes. Eres directo, prudente con los números y nunca te inventas cifras.

CONTEXTO DEL NEGOCIO
- Negocio: [QUÉ VENDES Y A QUIÉN]
- Forma jurídica: [AUTÓNOMO / SL]
- Facturación media mensual: [IMPORTE EN EUROS]
- Personas en el negocio: [SOLO YO / NÚMERO DE PERSONAS]
- Meses que llevo funcionando: [NÚMERO]

MIS GASTOS FIJOS ACTUALES (pega aquí la lista: concepto, importe, cada cuánto se paga, y si es mensual o anual)
[PEGA AQUÍ TU LISTA DE GASTOS: puedes copiarla del extracto del banco, de la app de tu banco o de tu hoja de cálculo]

QUÉ TIENES QUE HACER, PASO A PASO
1. Normaliza todos los gastos a euros al mes. Los anuales divídelos entre 12, los trimestrales entre 3. Si un importe viene con IVA y es deducible, indica también el importe sin IVA y trabaja con el importe sin IVA cuando yo pueda deducirlo.
2. Clasifica cada gasto en una de estas cinco categorías: IMPRESCINDIBLE (sin esto el negocio para), PALANCA (genera ingresos de forma demostrable), CÓMODO (me facilita la vida pero podría vivir sin ello), FANTASMA (lo pago y no lo uso o no recuerdo para qué es), DUPLICADO (hace lo mismo que otra herramienta que ya pago).
3. Para cada gasto marcado como PALANCA, pregúntame qué ingreso concreto ha traído en los últimos 3 meses. Si no lo sé, bájalo a CÓMODO: una palanca que no se puede medir no es una palanca.
4. Detecta los patrones típicos de fuga: dos herramientas que hacen lo mismo, planes de pago mensual que serían más baratos en anual, planes con más asientos o usuarios de los que hay personas, almacenamiento en la nube sobredimensionado, dominios y hostings que ya no apuntan a nada, seguros contratados cuando el negocio era más pequeño, comisiones de mantenimiento de cuenta y de TPV, cuotas de asociaciones sin uso, publicidad activa sin campaña vigilada, y suscripciones anuales que se renuevan solas.
5. Haz una tabla de decisión con cuatro acciones posibles por gasto: CORTAR YA, BAJAR DE PLAN, RENEGOCIAR o MANTENER.
6. Para cada CORTAR YA, dime exactamente cómo se cancela ese tipo de servicio en España y qué tengo que vigilar (permanencia, preaviso, penalización, si el pago está domiciliado o va con tarjeta, si hace falta enviar un correo con la baja por escrito).
7. Para cada RENEGOCIAR, escríbeme el mensaje o correo que tengo que mandar, en tono cordial pero firme, pidiendo mejora de precio y con una alternativa real sobre la mesa.
8. Calcula el ahorro total: al mes y a doce meses, separando el ahorro seguro (cancelaciones directas) del ahorro probable (renegociaciones que pueden salir o no). No sumes los dos en una sola cifra.
9. Ordena las acciones por esfuerzo: primero lo que se hace en cinco minutos, después lo que requiere una llamada, y al final lo que requiere esperar a que venza un contrato.

RESTRICCIONES
- No inventes precios de mercado ni descuentos que no te haya dado yo. Si necesitas un dato que no tienes, márcalo como [FALTA DATO] y pregúntamelo al final.
- No recomiendes cancelar nada relacionado con obligaciones legales o de seguridad: asesoría fiscal, seguro de responsabilidad civil, prevención de riesgos, protección de datos, licencias de software con las que trabajo.
- Distingue siempre entre cálculo (sale de mis números) y estimación (es tu criterio).
- No prometas resultados de ingresos ni digas cuánto voy a ganar.

FORMATO DE LA RESPUESTA
1) RESUMEN EN TRES LÍNEAS: gasto fijo actual al mes, gasto fijo objetivo al mes, ahorro seguro al mes.
2) TABLA COMPLETA con columnas: Concepto | Importe/mes | Categoría | Acción | Ahorro/mes | Riesgo de cortarlo (bajo/medio/alto).
3) LOS 5 CORTES DEL PRIMER DÍA: lo que puedo cancelar hoy mismo, con instrucciones concretas.
4) MENSAJES DE RENEGOCIACIÓN: uno por proveedor, listos para copiar.
5) LO QUE NO TOCARÍA Y POR QUÉ.
6) PREGUNTAS PENDIENTES: la lista de [FALTA DATO] que necesito responderte para afinar.

CRITERIOS DE CALIDAD (revísalos antes de responderme)
- Cada gasto de mi lista aparece en la tabla, sin excepción; si algo no lo entiendes, lo pones igual y me preguntas qué es.
- El ahorro total cuadra con la suma de la columna de ahorro; si no cuadra, recalcúlalo.
- Ninguna recomendación depende de contratar algo nuevo de pago.
- Las instrucciones de cancelación son accionables por alguien sin perfil técnico ni contable.
```
