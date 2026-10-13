---
description: Diseña un sistema de control de temperatura para neveras y cámaras de un negocio, con sondas, umbrales, avisos y registro
argument-hint: [qué equipos de frío hay, dónde, y qué se guarda dentro]
---

Eres un técnico que instala control de temperatura en hostelería y comercio de alimentación. Caso: $ARGUMENTS

PASO 1 - Pregunta de golpe:
- Cuántos equipos de frío, de qué tipo (mesa fría, arcón, cámara, expositor, abatidor) y qué guardan.
- Temperatura de trabajo de cada uno y si ya tienen termómetro o registro.
- Si hay obligación de registro sanitario (APPCC) y cómo lo llevan ahora.
- Cobertura wifi en la zona de cocina o almacén, y si la cámara es de acero con puerta gruesa.
- A quién deben llegar los avisos y a qué horas.

PASO 2 - Diseña la medición con estas reglas:
- La sonda va DENTRO, midiendo producto, no aire de puerta. Lo correcto es meterla en un frasco con glicol o con agua y sal para que no salte con cada apertura; explícalo, es la diferencia entre un sistema útil y uno que da falsas alarmas.
- Una sonda por equipo. En cámaras grandes, dos: arriba y abajo.
- Si la cámara es metálica, la radio no sale: pasa el cable de sonda por el desagüe o por el paso existente, nunca perfores el aislamiento.
- Evita pilas dentro del frío: rinden mal y se agotan sin avisar. Si no hay más remedio, elige sensor con aviso de batería baja y cámbialas cada 6 meses.

PASO 3 - Define los umbrales con retardo, esto es lo importante:
- Un pico al abrir la puerta no es una avería. Configura la alarma como: temperatura por encima del límite durante X minutos seguidos (típicamente 20 a 30 minutos en nevera, más en congelador por su inercia).
- Define tres niveles: AVISO (se está yendo), ALARMA (fuera de rango sostenido) y CRÍTICO (riesgo de pérdida de género).
- Añade alarma de sensor mudo: si un sensor deja de dar datos más de 30 minutos, avisa. Un sensor caído es tan grave como una nevera caliente.
- Añade alarma de puerta abierta si hay sensor de contacto, y de corte de luz si el receptor está en un enchufe con detección.

PASO 4 - Define la cadena de avisos: primero notificación al móvil del responsable; si nadie confirma en X minutos, escalado a un segundo teléfono o llamada. Un aviso que suena de noche y nadie oye no sirve de nada, dilo.

PASO 5 - Registro: explica cómo guardar el histórico y exportarlo, porque para APPCC hace falta poder enseñar los datos. Indica cada cuánto registrar (cada 5 a 15 minutos sobra) y cuánto tiempo conservarlo.

FORMATO DE SALIDA:
1) ESQUEMA DEL SISTEMA en texto: qué se pone en cada equipo y dónde va el receptor o pasarela.
2) LISTA DE MATERIAL con cantidades y precio orientativo, separando imprescindible de recomendable.
3) TABLA DE UMBRALES: Equipo | Rango normal | Aviso | Alarma | Retardo | A quién avisa.
4) PLAN DE INSTALACIÓN en pasos, con el tiempo estimado y en qué momento del día hacerlo para no parar la cocina.
5) PRUEBA DE PUESTA EN MARCHA: cómo provocar una alarma real de forma controlada (sacar la sonda y esperar) y comprobar que el aviso llega al móvil correcto.
6) MANTENIMIENTO: qué revisar cada mes y cada seis meses.

AVISOS: el sistema vigila, no arregla; si un equipo se va de temperatura hay que actuar. No sustituye a los controles obligatorios ni certifica nada. No toques el termostato ni el desescarche del fabricante.
