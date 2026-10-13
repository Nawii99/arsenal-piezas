---
name: gestor-prudente-meta-ads
description: Revisa, prepara y pausa campañas de Meta (Facebook e Instagram) pidiendo tu permiso en cada cambio que mueva dinero. Úsala cuando gestiones anuncios en Meta y quieras analizar resultados o preparar cambios.
---

# Gestor prudente de campañas de Meta

## Qué hace
Te ayuda a llevar anuncios de Facebook e Instagram sin abrir Ads Manager a cada rato. Lee resultados, detecta lo que gasta sin dar frutos, prepara campañas nuevas y propone pausas. Cada cambio que mueva dinero lo apruebas tú antes.

## El riesgo, dicho al principio
- Esto toca dinero de verdad. Un anuncio activo gasta euros cada hora. Confirma si tus límites de gasto llevan IVA o no.
- Meta puede limitar o cerrar una cuenta publicitaria si hay muchos anuncios rechazados, pagos fallidos o cambios muy bruscos. Recuperar una cuenta cerrada es lento y no está garantizado.
- Si llevas la cuenta de un cliente, necesitas su permiso por escrito y que el método de pago sea suyo.

## Tres niveles. Empiezas siempre por el 1
- Nivel 1, solo mirar: se leen datos y se hace un informe. No se cambia nada.
- Nivel 2, preparar: se crean campañas, conjuntos y anuncios siempre en pausa o en borrador.
- Nivel 3, actuar: se pausa o se ajusta solo lo que tú apruebes por escrito, de uno en uno.
- Nunca se sube de nivel sin que tú lo pidas.

## Cómo conectarlo
- Con un conector (MCP) de Meta Ads o un flujo de n8n con la API de Meta: para el nivel 1 pide acceso de solo lectura (rol de analista).
- Sin conexión: exporta de Ads Manager un CSV de campañas de los últimos 30 días, con gasto, resultados, coste por resultado, frecuencia y CTR, y pásalo.
- Nunca pegues una contraseña o un token de acceso en el chat. Si te lo piden, para y avisa.
- Para reglas simples, como pausar si el coste por resultado pasa de un límite, Ads Manager ya trae reglas automáticas. Úsalas para eso. Aquí se analiza y se decide el límite, pero nadie vigila las 24 horas.

## Qué preguntar antes de empezar
1. ¿Cuenta propia o de un cliente? ¿Tienes permiso por escrito?
2. ¿Qué objetivo: ventas, contactos, mensajes o visitas? ¿Qué cuenta como éxito?
3. ¿Cuánto puedes pagar por cada resultado? Coste máximo: [COSTE MÁXIMO POR RESULTADO EN €].
4. Tope de gasto que nunca se puede superar: [TOPE DIARIO EN €] y [TOPE MENSUAL EN €].
5. ¿Qué nivel quieres: 1, 2 o 3?
6. ¿El sector es finanzas, empleo, vivienda, salud o política? Si sí, ahí revisa una persona cada anuncio antes de activar.
7. ¿Están instalados y probados el píxel o la API de conversiones, y hay banner de cookies con consentimiento? Sin medición fiable, el análisis no vale.

## Paso a paso
Nivel 1, revisión:
1. Compara los últimos 7 y 30 días.
2. Por campaña, saca gasto, resultados, coste por resultado, frecuencia y CTR.
3. Marca como «sin juzgar todavía» lo que haya gastado menos de [GASTO MÍNIMO ANTES DE JUZGAR EN €], lleve menos de [DÍAS MÍNIMOS] días en marcha o siga en fase de aprendizaje. Como orientación, Meta pide unos 50 resultados por conjunto en una semana. Mira lo que indique Ads Manager.
4. Clasifica cada campaña en: seguir, vigilar, candidata a pausar o sin datos. Una línea de motivo con el dato.
5. Avisa de frecuencia por encima de [FRECUENCIA MÁXIMA] y de anuncios rechazados.
Nivel 2, preparar:
1. Pide oferta, público (zona, edad, intereses, sin listas de clientes), creatividades, URL de destino, fechas y presupuesto.
2. Estructura mínima: una campaña, uno o dos conjuntos y dos o tres anuncios.
3. Textos en español de España. Precio con IVA incluido si vendes a particulares. Sin promesas como «garantizado» o «sin riesgo», ni frases que señalen a la persona, como «¿tienes diabetes?»: Meta las rechaza.
4. Crea todo en pausa. Resume lo creado y di claramente: «Nada está activo».
Nivel 3, actuar:
1. Presenta un plan numerado: campaña, cambio, valor actual y valor propuesto, y efecto sobre el gasto diario en €.
2. Espera una respuesta del tipo «SÍ 1 y 3». Sin confirmación no hay cambio.
3. Aplica solo lo aprobado. Las subidas de presupuesto, como mucho de [20] % cada vez, porque los saltos grandes suelen desordenar el aprendizaje. Nunca por encima del tope.
4. Después vuelve a leer y confirma que el estado es el esperado. Apunta fecha, qué se cambió y por qué.
5. Explica cómo deshacerlo: reactivar la campaña en Ads Manager.

## Qué devolver
- Resumen de tres líneas con gasto total y resultados.
- Tabla: campaña | gasto | resultados | coste por resultado | frecuencia | estado propuesto | motivo.
- Plan de cambios, si procede, con el formato del nivel 3.
- Qué no se puede juzgar todavía y por qué.
- Preguntas pendientes. Todo el dinero, en €.

## Qué NO hacer
- No actives nada ni gastes un euro sin confirmación escrita para ese cambio concreto.
- No borres campañas, anuncios ni audiencias. Solo se pausa.
- No toques métodos de pago, límites de cuenta, permisos ni roles.
- No juzgues con pocos datos. Un mal día no es motivo para pausar.
- No hagas más de [5] cambios a la vez.
- No subas listas de clientes (emails o teléfonos) como audiencia sin base legal del RGPD y sin que la política de privacidad lo recoja. Eso lo revisa quien lleve la protección de datos.
- No reenvíes una y otra vez un anuncio rechazado. Lee el motivo y cambia el contenido. Insistir puede acabar en restricción de la cuenta.
- No prometas retorno. Depende de la oferta, la web y el mercado.
- En anuncios de salud, finanzas, empleo, vivienda o política, una persona revisa texto y público antes de activar.
- Si algo no cuadra (gasto raro, cargo inesperado, cuenta restringida), para y avisa.
