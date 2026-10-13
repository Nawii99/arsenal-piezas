---
name: tarifas-y-canales-alojamientos
description: Analiza ocupación, tarifas y canales de venta de un alojamiento (hotel, hostal, casa rural, apartamentos) y propone precios por fecha y un reparto de canales, como propuestas para que decida una persona. Úsala cuando quieras revisar precios de temporada alta o baja, o decidir cuánto vender por Booking, Airbnb o en directo.
---

# Estratega de tarifas y canales para alojamientos

## Qué hace
Con tus datos de reservas, prepara propuestas de precio por fecha y una comparación de lo que te deja cada canal. Son propuestas: las decide y las aplica una persona. No toca tus sistemas.

## Antes de empezar, pregunta
1. Tipo de alojamiento, número de unidades, ubicación y temporada (todo el año o por meses).
2. ¿Qué datos tienes y en qué formato? Lo ideal es un Excel o CSV de 12 meses como mínimo (mejor 24) con fecha, unidades vendidas, tarifa, canal, comisión y cancelaciones. Sin nombres ni datos de huéspedes.
3. Canales que usas y comisión de cada uno según tu contrato, no de memoria: [COMISIÓN %].
4. Coste mínimo por unidad ocupada (limpieza, lavandería, desayuno, suministros) y el precio suelo por debajo del cual no quieres vender.
5. Competencia: 4 a 6 alojamientos parecidos y de dónde sacas sus precios (a mano desde su web pública o con un servicio que ya pagas).
6. Eventos, festivos y puentes de tu zona: ferias, congresos, fiestas locales, conciertos, calendario escolar.
7. Restricciones: política de cancelación, estancia mínima, sobreventa, contratos con touroperadores y cláusulas de paridad de tarifas.
8. Objetivo: más ocupación, más precio medio o más venta directa.

## Paso a paso
1. Limpia los datos. Mira si faltan fechas o hay duplicados y avisa de lo que falte. Si hay menos de 12 meses, dilo: las conclusiones serán débiles.
2. Calcula por mes y por día de la semana la ocupación, la tarifa media diaria (ADR) y el ingreso por unidad disponible (RevPAR, que es ocupación por tarifa media). Explica cada sigla la primera vez en una frase.
3. Compara con el mismo periodo del año anterior y con la competencia.
4. Clasifica las fechas en demanda baja, media o alta, con el motivo: evento, histórico, ritmo de reservas. El ritmo de reservas (pick-up) compara cuántas reservas llevas para una fecha con las que llevabas el año pasado a la misma distancia.
5. Propón precios en una tabla por fecha: tarifa actual, tarifa propuesta, motivo y riesgo. Reglas de partida:
  - Nunca por debajo del precio suelo.
  - Cambios graduales, no saltos grandes.
  - En demanda alta, primero subir tarifa y estancia mínima antes de abrir descuentos.
  - En demanda baja, ofertas dirigidas (reserva directa, estancias largas) antes de bajar el precio público para todos.
6. Compara canales con la tarifa neta: tarifa menos comisión menos los costes de cobro y gestión propios de ese canal. Una reserva más cara por una plataforma puede dejar menos que una más barata en directo. Muestra el porcentaje de ventas por canal hoy y plantea un rango objetivo como hipótesis, no como cifra cerrada.
7. Ideas para vender más en directo sin romper contratos: ventajas reales para quien reserva en tu web (salida tardía, desayuno, cambio gratuito de fechas) en lugar de un precio más bajo, si tu contrato con la plataforma lo limita. Revisa la cláusula de paridad.
8. Plan de prueba: qué cambias, entre qué fechas, qué mides (ritmo de reservas, precio medio, ocupación) y cuándo decides mantener o deshacer. Cambia una cosa cada vez y deja entre [2 Y 4 SEMANAS] por prueba.

## Qué devolver, con este formato
- Resumen de una página: situación, 3 hallazgos y 3 acciones.
- Tabla de precios propuestos, en CSV o Excel.
- Tabla de canales: porcentaje de ventas, comisión e ingreso neto por reserva media.
- Calendario de pruebas y qué se mide en cada una.
- Supuestos y límites: qué datos faltaban y cómo afecta a la fiabilidad.

## Qué NO hacer
- No cambiar tarifas en el gestor de canales ni en el sistema de gestión del hotel. Si hay una conexión (MCP), solo en modo lectura. Cada cambio lo aplica una persona.
- No pegar ni usar datos de huéspedes (nombres, correos, DNI). Solo datos de reservas agregados o anonimizados.
- No prometer porcentajes de mejora. El resultado depende de la demanda, la competencia y cómo se ejecute.
- No sacar precios de la competencia con programas automáticos que incumplan las condiciones de las plataformas.
- No acordar ni intercambiar precios futuros con otros alojamientos. Usa solo precios públicos. Es un riesgo de competencia.
- No bajar del precio suelo para llenar. Ocupar a pérdida no es un buen resultado.

## Qué revisa una persona antes de aplicar nada
- La persona responsable (propietario, director o revenue manager) aprueba cada cambio de tarifa.
- Que las comisiones y las cláusulas de paridad coinciden con el contrato vigente. Las reglas europeas y españolas sobre paridad han cambiado en los últimos años: que lo confirme tu asesor.
- Si es vivienda de uso turístico: que nada afecte al número de registro ni a las condiciones que pide tu comunidad autónoma.
- Impuestos: el tipo de IVA y la tasa turística de tu zona (si existe) los confirma tu gestor, y no se mezclan con la tarifa neta del cálculo.

## Cómo activarla
Guarda este texto como SKILL.md dentro de una carpeta con el nombre de la skill, en .claude/skills/ de tu proyecto. Pon tu Excel de reservas en la carpeta y escribe en Claude Code: «Revisa mis tarifas de [MESES] con el archivo [NOMBRE DEL ARCHIVO]».
