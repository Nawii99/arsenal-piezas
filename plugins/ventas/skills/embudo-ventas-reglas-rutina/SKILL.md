---
name: embudo-ventas-reglas-rutina
description: Diseña u ordena el embudo de ventas de cualquier CRM u hoja de cálculo con etapas de criterio claro, campos mínimos, reglas de aviso interno y una revisión semanal. Úsala al montar un CRM, cuando se pierden oportunidades de vista o quieres prever ventas con datos reales.
---
# Embudo de ventas con reglas claras y revisión semanal
Qué hace: entrega un diseño (etapas, campos, reglas y rutina) que luego se configura en tu CRM (HubSpot, Pipedrive, Zoho, Holded, Odoo u otro), en una hoja de cálculo o en un flujo de n8n. Automatiza tareas y avisos internos para el vendedor. No envía mensajes a clientes.
Cómo se usa: se activa sola con peticiones de este tema, o la llamas escribiendo /embudo-ventas-reglas-rutina. Si tienes un MCP de tu CRM configurado, empieza solo en lectura. Si no, trabaja con una exportación CSV.
## Pregunta antes de empezar
- ¿Qué vendes y cuál es el importe medio de una venta? [IMPORTE MEDIO]
- ¿Cuánto tarda una venta desde el primer contacto hasta el cobro? ¿Cuántas personas venden?
- ¿Qué CRM o herramienta usas hoy, qué etapas tiene y cuántas oportunidades abiertas hay?
- ¿De dónde llegan los clientes (web, recomendación, llamadas, ferias, anuncios)?
- ¿Dónde crees que se pierden más oportunidades?
- ¿Tienes datos de ventas de los últimos 6 a 12 meses? Si no, el diseño parte de suposiciones y se marcan como tales.
## Paso a paso
1. Dibuja el proceso real tal como ocurre hoy, del primer contacto al cobro. Pide un caso real de venta ganada y otro de venta perdida para ver qué pasó en cada paso.
2. Define entre 5 y 7 etapas. Para cada una: nombre, hecho comprobable que permite entrar («reunión celebrada», «propuesta enviada con precio»), siguiente acción y días máximos antes de dar la alerta. Evita etapas basadas en sensaciones como «cliente interesado».
3. Fija los campos mínimos de cada oportunidad: cliente y contacto, origen, importe (elige con IVA o sin IVA y no lo mezcles), fecha de cierre estimada, próxima acción con fecha, responsable y, si se pierde, motivo. Cada campo extra necesita una razón.
4. Escribe las reglas con frases simples «si pasa X, entonces Y». Ejemplos. Si una oportunidad lleva más de [N] días sin actividad, se crea una tarea y se avisa al responsable. Si pasa a «propuesta enviada», se crea una tarea de seguimiento a los [N] días. Si se marca como ganada, se crea una tarea para facturar y preparar la entrega. Si se marca como perdida, se pide el motivo. Empieza con 8 reglas como máximo.
5. Indica dónde se configura cada regla: en las automatizaciones del propio CRM, en un flujo de n8n (con disparador, condiciones y acción, nodo por nodo) o en una hoja de cálculo con formato condicional. Los límites y precios de cada herramienta cambian: consúltalos en su web [COMPRUEBA EL PLAN].
6. Previsión: muestra siempre dos cifras, el importe sin ponderar y el ponderado. La probabilidad por etapa se calcula con el histórico si hay al menos [N] oportunidades cerradas. Si no las hay, usa porcentajes provisionales marcados como suposición y revísalos cada trimestre.
7. Rutina semanal de 30 minutos. Primero las oportunidades paradas. Después las cinco de mayor importe y su próxima acción. Después las cerradas esa semana, con el motivo de las perdidas. Después la previsión y la diferencia con la semana anterior. Al final, quién hace qué hasta la próxima reunión.
8. Métricas simples a partir de los tres meses: conversión entre etapas, días medios por etapa, importe en el embudo y motivos de pérdida más repetidos. Si hay menos de [30] oportunidades cerradas, di que las cifras son orientativas.
9. Prueba antes de activar: aplica las reglas a 5 oportunidades de prueba o a una copia del CRM y comprueba qué tareas se crean y a quién.
## Qué devolver
Un documento en este orden:
1. Etapas, cada una con criterio de entrada, siguiente acción y días máximos.
2. Campos mínimos.
3. Reglas «si pasa X, entonces Y» y dónde se configura cada una.
4. Rutina semanal.
5. Previsión y métricas, con la fórmula explicada en lenguaje llano.
6. Suposiciones pendientes de confirmar, entre [corchetes].
## Qué NO hacer
- No envíes correos ni mensajes a clientes o posibles clientes con estas reglas. Si quieren secuencias automáticas de email, avisa de que en España hay que cumplir el RGPD y la LSSI (consentimiento o relación previa) y que lo revise un asesor.
- No muevas, borres ni cierres oportunidades reales por tu cuenta. Propón y que decida el comercial.
- No inventes porcentajes de cierre, duración de ciclos ni ahorros de tiempo. Lo que no se sepa va entre [corchetes].
- No añadas etapas, campos o reglas por si acaso. Cuanto más complejo, menos se rellena el CRM.
- No uses la previsión como promesa ante un banco o un inversor sin que la revise una persona.
- No subas listas completas de contactos a servicios externos si no hace falta. Son datos personales.
## Quién revisa antes de usar el resultado
- El responsable comercial revisa etapas, criterios y porcentajes.
- Quien administra el CRM revisa permisos y hace la prueba antes de activar automatizaciones.
- Tu asesor de protección de datos o tu gestoría revisa el tratamiento de datos personales y, si las métricas por vendedor se usan para evaluar personas, cómo se informa a la plantilla.
