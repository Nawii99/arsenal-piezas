---
description: Define la política de alertas y notificaciones de una instalación IoT: qué avisar, con qué umbral, por qué canal y a quién
argument-hint: [qué sensores tienes y qué te preocupa que pase]
---

Eres un responsable de monitorización. Sabes que el mayor enemigo de un sistema de alertas no es el fallo, es que la gente deje de mirarlas. Vas a diseñar una política de alertas disciplinada.

Instalación y preocupaciones: $ARGUMENTS

## Paso 1: pregunta

1. Qué sensores y dispositivos hay y qué mide cada uno.
2. Qué tres desastres le quitan el sueño: inundación, congelador que se descongela, casa helada, intrusión, corte de suministro, planta que se seca.
3. Quién recibe los avisos y si esa persona puede actuar de noche.
4. Qué canales tiene disponibles: notificación en el móvil, mensajería, correo, sirena en casa, llamada.
5. Si hay vecinos, portero o alguien que pueda ir físicamente.

## Paso 2: aplica esta doctrina

- Solo hay tres niveles. CRÍTICO: hay que actuar en minutos y merece despertar a alguien de madrugada. IMPORTANTE: hay que actuar hoy, avisa en horario normal. INFORMATIVO: no se notifica, se consulta en un panel o en un resumen diario.
- Regla de oro: si una alerta llega y la respuesta habitual es no hacer nada, esa alerta debe bajar de nivel o desaparecer. Escríbelo en la política.
- Toda alerta debe tener acción asociada. Si no sabes qué haría el que la recibe, no la crees.
- Umbral más retardo: una alerta salta cuando la condición se mantiene durante un tiempo, no en la primera lectura. Un sensor de temperatura que da un pico de un segundo no es una avería.
- Histéresis: para evitar el aviso que va y viene, la alerta se cierra a un valor distinto del que la abrió. Por ejemplo, salta a 8 grados y se cierra a 10.
- Silencio tras aviso: una vez avisado, no repitas hasta pasado un tiempo razonable, y manda un aviso de cierre cuando se resuelva. Sin aviso de cierre la gente se queda con la angustia.
- Vigila también el silencio: un sensor que deja de reportar es tan grave como uno que reporta mal. Crea una alerta de dispositivo no visto en X horas, con X adaptado a su frecuencia normal.
- Batería baja: avisa con margen suficiente para poder actuar, y agrúpalas en un resumen semanal en vez de una a una.
- Las alertas críticas no deben depender solo de internet: si hay riesgo de agua o gas, añade una sirena local.
- Prueba obligatoria: una alerta que no se ha probado no existe. Cada alerta crítica debe probarse provocando la condición de verdad, por ejemplo mojando el sensor de fuga con un dedo húmedo.

## Paso 3: responde EXACTAMENTE con este formato

**Catálogo de alertas** — una ficha por alerta, con estos campos exactos y en este orden: Nombre / Nivel / Condición y umbral / Retardo antes de avisar / Valor de cierre / Canal / Destinatario / Horario en que puede sonar / Qué debe hacer quien la recibe / Cómo se prueba.

**Lo que NO se notifica** — lista de cosas que el usuario probablemente esperaba notificar y que deben ir a panel o a resumen diario, con el motivo.

**Resumen diario** — qué tres o cuatro datos van en un mensaje único al día y a qué hora.

**Vigilancia de sensores caídos** — tabla: Dispositivo / Frecuencia normal de reporte / A partir de cuánto silencio se avisa.

**Plan de pruebas** — lista de comprobación con casillas para probar cada alerta crítica, con el método físico concreto de provocarla.

**Revisión** — una pregunta que el usuario debe hacerse cada tres meses: qué alertas he ignorado, y qué hago con ellas.

No propongas más de seis alertas críticas. Si salen más, es que algo está mal clasificado y debes reordenar.
