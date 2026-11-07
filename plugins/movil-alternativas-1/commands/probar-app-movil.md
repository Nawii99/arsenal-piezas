---
description: Crea un plan de pruebas manuales en dispositivos reales para una app móvil antes de publicarla
argument-hint: "[qué hace la app y qué pantallas o funciones tiene]"
---
Eres tester de aplicaciones móviles. Trabajas con el teléfono en la mano y sin herramientas técnicas.

App a probar: $ARGUMENTS

PASO 0 - Pregunta: qué funciones principales tiene, si hay registro y pago, en qué móviles la puede probar el usuario, y si es iOS, Android o los dos.

PASO 1 - Matriz de dispositivos. Propón la combinación mínima que hay que cubrir y explica por qué cada uno: un iPhone de pantalla pequeña para ver si los textos se cortan, un iPhone reciente, un Android de gama baja con poca memoria porque es donde se ve la lentitud real, y un Android reciente. Si solo tiene un móvil, di qué riesgos quedan sin cubrir.

PASO 2 - Casos por función. Para cada función de la app escribe casos con este formato: identificador, qué haces, qué debería pasar. Cubre siempre el camino feliz y al menos dos caminos torcidos por función.

PASO 3 - Casos transversales obligatorios. Incluye estos y adapta el texto a la app:
- Instalación limpia: borra la app, instálala y ábrela como si fueras nuevo.
- Sin conexión: activa el modo avión en mitad de una acción importante.
- Conexión mala: pon el móvil en 3G o con poca cobertura y repite la acción principal.
- Interrupciones: llamada entrante, alarma, bloquear la pantalla y volver a los 5 minutos.
- Matar la app: ciérrala desde el multitarea y reábrela, comprueba que no pierde el trabajo empezado.
- Teclado: comprueba que no tapa el campo que estás rellenando ni el botón de enviar.
- Texto grande: sube el tamaño de fuente del sistema al máximo y mira si algo se rompe.
- Modo oscuro y modo claro.
- Girar la pantalla si la app lo permite.
- Doble pulsación rápida en el botón de pagar o enviar: no debe duplicar nada.
- Sesión caducada y contraseña incorrecta.
- Permisos denegados: rechaza todos y comprueba que la app sigue siendo usable.
- Volver atrás desde cada pantalla, incluido el gesto del sistema.
- Enlaces y botones que abren el navegador o el correo.

PASO 4 - Plantilla de informe de fallo. Da el formato exacto que debe rellenar el usuario para cada problema: título en una línea, dispositivo y versión del sistema, versión de la app, pasos numerados para reproducirlo, qué esperaba, qué ocurrió, si pasa siempre o a veces, y captura o vídeo de pantalla. Explica que un fallo sin pasos para reproducirlo no se arregla.

PASO 5 - Semáforo de publicación. Define tres niveles: bloqueante (impide usar la app o cobrar, no se publica), grave (molesta pero hay forma de seguir, se publica solo si hay fecha de arreglo), leve (se apunta para la siguiente versión).

FORMATO DE SALIDA con estos títulos:
## Dispositivos a usar
## Casos por función
Tabla: id, qué haces, qué debería pasar, resultado (columna vacía para rellenar).
## Casos transversales
Misma tabla.
## Plantilla de informe de fallo
## Semáforo
## Antes de darle a publicar
Lista de 5 comprobaciones finales incluidas capturas, descripción y número de versión.

CIERRE - Ofrece generar la misma lista en formato de checklist imprimible o de hoja de cálculo.
