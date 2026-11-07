---
description: Genera un plan de pruebas manuales en móvil real para una app o web, con casos concretos, qué observar y una plantilla de reporte de fallos
argument-hint: "[qué app o web hay que probar y qué hace]"
---

Vas a montar el plan de pruebas de: $ARGUMENTS

Escribes en español de España y tuteas. La persona probará a mano con su propio móvil, no con herramientas automáticas. Todo tiene que ser tocable y comprobable a ojo.

PASO 1. Pregunta lo mínimo para acertar con los casos:
- ¿Es app instalada o una web abierta en el navegador del móvil?
- ¿Cuáles son las tres acciones que más va a hacer un usuario dentro?
- ¿Hay registro, pago o subida de archivos?
- ¿Qué móviles tienes a mano para probar?

PASO 2. Define el mínimo de aparatos y explica por qué: un iPhone y un Android, uno de pantalla pequeña y uno grande, y uno con el sistema no actualizado. Si solo hay un móvil, dilo claro: se puede probar, pero hay que asumir el riesgo y explicarlo al cliente.

PASO 3. Escribe los casos de prueba. Cada caso en una línea con este formato exacto: CASO, PASOS, RESULTADO ESPERADO. Cubre estos bloques y ajusta los casos a lo que hace esta app en concreto:
- Primer uso: instalar o abrir por primera vez, ver la primera pantalla, entender qué hay que hacer.
- Camino principal: la acción que da valor, hecha de principio a fin.
- Registro y acceso: alta, entrada, contraseña olvidada, salir de la cuenta, volver a entrar.
- Datos raros: campos vacíos, textos larguísimos, acentos y eñes, emojis, números negativos, fechas al revés.
- Interrupciones: llamada entrante, bloquear la pantalla y volver, cambiar de app y volver, girar el móvil.
- Conexión: modo avión en mitad de una acción, wifi lento, cambio de wifi a datos.
- Permisos: denegar el permiso de cámara, ubicación o notificaciones y ver que la app no se rompe ni deja al usuario atrapado.
- Botón atrás de Android y gesto de volver de iPhone en cada pantalla.
- Teclado: que no tape el campo que estás escribiendo ni el botón de enviar.
- Accesibilidad: texto del sistema al tamaño más grande, y modo oscuro si el móvil lo tiene.
- Batería y calor: si hay vídeo o mapa, comprobar que el móvil no se calienta en cinco minutos de uso.

PASO 4. Da los criterios de aceptación medibles, no opiniones:
- Ningún cierre inesperado en todo el recorrido principal.
- Toda pantalla que espera muestra algo en menos de dos segundos, aunque sea un indicador de carga.
- Ningún botón o zona pulsable menor de 44 puntos en iPhone o 48 en Android: si hay que apuntar con la uña, está mal.
- Ningún texto cortado ni que se salga por el lado derecho.
- Ningún mensaje de error en inglés o con jerga técnica delante del usuario.
- Se puede volver atrás desde cualquier pantalla sin quedarse encerrado.

PASO 5. Entrega la plantilla de reporte de fallos, una línea por campo: título corto, aparato y versión del sistema, pasos exactos para reproducirlo, qué esperabas, qué pasó, captura o vídeo, y gravedad clasificada en bloquea, molesta o cosmético.

PASO 6. Explica cómo priorizar: primero lo que bloquea el camino principal, después lo que afecta a pagos o a datos, después lo molesto y al final lo cosmético. Nunca retrases un lanzamiento por un cosmético, y nunca lances con un bloqueante.

CÓMO SABER SI ESTÁ BIEN: la prueba está terminada cuando el recorrido principal se ha completado dos veces seguidas en dos móviles distintos sin ningún fallo bloqueante, y todos los casos tienen una marca de pasa o falla.

FORMATO DE SALIDA: tabla de casos con casillas para marcar, tabla de criterios de aceptación, plantilla de reporte y una nota final con los tres riesgos concretos de esta app.
