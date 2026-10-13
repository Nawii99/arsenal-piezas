---
name: revisor-estudios-de-precio
description: Revisa un estudio de sensibilidad al precio (encuesta tipo Van Westendorp, Gabor-Granger u otras), dice si es fiable, calcula el rango de precios que sostienen los datos y propone una prueba real. Úsala cuando tengas respuestas de clientes sobre cuánto pagarían.
---

# Revisor de estudios de precio

## Qué hace
Lee los resultados de una encuesta de precios y primero comprueba si se puede fiar de ellos. Después calcula un rango de precios razonable, lo cruza con tus costes y te propone una prueba pequeña y real.
No da un precio mágico. Da un rango, con su margen de duda, y dice qué haría falta para estar más seguro.
Si no tienes estudio, te ayuda a diseñar una encuesta corta y bien formulada.

## Qué preguntar antes de empezar
1. Qué se vende, a quién, y qué precio tiene hoy (con y sin IVA).
2. Coste por unidad o por cliente, comisiones (pasarela de pago, marketplace) y costes fijos que quieras repartir.
3. Qué decisión hay que tomar: subir, bajar, crear planes, hacer packs, lanzar un producto.
4. Qué archivo hay (CSV, Excel, PDF del informe) y cuántas respuestas trae.
5. Cómo se recogieron: clientes actuales, seguidores de redes, panel pagado, conocidos. Y a quién se preguntó exactamente.
6. Qué método se usó y qué preguntas se hicieron, tal cual se escribieron.
7. Si los precios del estudio llevan IVA, y si son por mes, por año o por unidad.

## Paso a paso
1. Identifica el método. Van Westendorp son cuatro preguntas: precio tan barato que dudarías, precio barato, precio caro y precio tan caro que no comprarías. Gabor-Granger pregunta si comprarías a varios precios concretos. Conjoint y MaxDiff necesitan un diseño específico: si es tu caso, dilo y pide ayuda a quien los haya hecho, no improvises el análisis.
2. Audita la calidad y presenta una tabla con semáforo (verde, ámbar, rojo): tamaño de muestra, quién respondió, sesgo de selección (solo fans), preguntas que inducen, precio de referencia mostrado antes, respuestas incoherentes, duplicados, valores raros, IVA y periodo.
3. En Van Westendorp, descarta y cuenta las respuestas que rompan el orden lógico (barato por encima de caro). Si son muchas, dilo: es una señal de que se entendió mal la pregunta.
4. Calcula el margen de error. Como regla aproximada al 95 %, el de un porcentaje es 1 entre la raíz de n. Con 100 respuestas son unos ±10 puntos; con 400, unos ±5. Y solo si la muestra es representativa; si no, el error real es mayor.
5. Haz el análisis con código por detrás si hace falta, pero enseña las cifras y de qué filas salen. En Van Westendorp: el rango va de donde «demasiado barato» se cruza con «no es barato» hasta donde «demasiado caro» se cruza con «no es caro». En Gabor-Granger: porcentaje que compraría a cada precio, ingreso por visitante y margen por visitante.
6. Recuerda que lo que la gente dice que pagaría suele ser más que lo que luego paga. Usa los resultados para comparar precios entre sí, no para predecir ventas.
7. Pasa a euros reales: precio sin IVA, menos comisiones, menos coste, igual margen por unidad. Calcula cuántas ventas necesitas para no perder dinero con cada precio candidato.
8. Propón una prueba real: 2 o 3 precios, durante un tiempo fijado de antemano, midiendo conversión, ingresos por visita, devoluciones y bajas. Define antes el criterio de parada.

## Qué devolver
En Markdown y de una página, más anexos:
1. Veredicto de fiabilidad en una frase (verde, ámbar o rojo) y por qué.
2. Tabla de auditoría: comprobación, resultado, cómo afecta a las conclusiones.
3. Rango de precios que sostienen los datos, diciendo si lleva IVA, y el margen de error.
4. Dos o tres precios candidatos con su margen en euros por unidad.
5. Plan de prueba, con fechas y criterio de parada.
6. Lo que falta para fiarse más (más respuestas, otra muestra, otro método).

## Qué NO hacer
- No des «el precio óptimo» como una cifra única y segura.
- No cambies precios en tu tienda ni en tu facturación. Esta skill solo analiza y propone.
- No mezcles precios con IVA y sin IVA. Si no está claro, pregunta.
- No saques conclusiones con muestras pequeñas o sesgadas sin avisar en la primera línea del informe.
- No propongas hablar de precios con competidores ni ponerse de acuerdo con ellos: está sancionado por la ley de competencia. Mirar precios públicos sí es legal.
- No subas el precio a clientes con contrato o suscripción sin revisar el aviso previo que exigen sus condiciones.
- Si personalizas precios según datos de cada persona, la normativa de consumo exige avisarlo. Pregunta a tu asesor.
- No guardes ni pegues datos personales de quienes respondieron; trabaja con respuestas anonimizadas.

## Qué revisa una persona antes de decidir
Quien manda en el negocio decide el precio. Tu gestor o contable confirma el margen y el tratamiento del IVA. Si el cambio afecta a contratos vigentes o a precios personalizados, lo ve también alguien con conocimiento legal.

## Dónde guardarla
Guarda este archivo como .claude/skills/revisor-estudios-de-precio/SKILL.md. Después pide: «Revisa este estudio de precios: [ARCHIVO]. Mi coste por unidad es [IMPORTE] euros».
