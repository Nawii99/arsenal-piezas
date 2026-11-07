---
name: plan-pruebas-movil
description: "Elabora un plan de pruebas manual y no técnico para una app móvil o un sitio web móvil: matriz de dispositivos, escenarios de red e interrupciones, datos de casos límite, comprobaciones de accesibilidad y una lista de verificación para decidir si se publica o no. Úsala antes de publicar una app o una actualización importante, o cuando los errores siguen llegando a los usuarios."
---

# Plan de pruebas en móvil antes de publicar

## Qué hace
Convierte «probarlo un poco» en un plan concreto: qué móviles, qué escenarios, qué datos raros y qué tiene que pasar para dar el visto bueno. Pensado para alguien sin conocimientos técnicos y sin herramientas de pago.

## Cuándo se activa
Cuando el usuario va a publicar una app o una versión nueva, cuando dice que «a algunos les falla», o pide una lista de comprobación antes de lanzar.

## Qué preguntar
- ¿App nativa, PWA o web móvil? ¿Qué sistemas soporta?
- ¿Qué 3 cosas hace el usuario el 90 % de las veces?
- ¿Hay pagos, subida de fotos o cuenta de usuario?
- ¿A qué móviles tienes acceso tú y tu gente?
- ¿Público mayor, gente en movimiento, uso en exteriores?

## Método
### 1. Matriz de dispositivos realista
No hace falta un laboratorio. Con estos casos cubres casi todo: un iPhone reciente, un iPhone pequeño o antiguo que aún reciba actualizaciones, un Android de gama alta y un Android barato con poca memoria. Si tu público es mayor, añade un móvil con la letra del sistema en tamaño grande.

### 2. Escenarios que sacan los fallos de verdad
- **Red mala**: activa la limitación de red o vete a un sitio con poca cobertura. La app tiene que avisar, no quedarse colgada.
- **Sin red**: modo avión en mitad de una acción. Comprueba que no se pierden datos escritos.
- **Interrupciones**: llamada entrante, notificación, bloquear la pantalla 5 minutos y volver.
- **Rotación** y teclado abierto tapando campos.
- **Batería baja y modo ahorro**: en iOS y Android limita tareas en segundo plano.
- **Primera instalación con cuenta nueva**: la mayoría de fallos están en el estado vacío.
- **Reinstalar**: borra la app, vuelve a instalar e inicia sesión. ¿Se recuperan sus datos y sus compras?

### 3. Datos raros que hay que meter
Nombres con tildes y con ñ, apellidos compuestos, correos con signo más, teléfonos con prefijo +34, campos vacíos, textos larguísimos, importes con coma decimal, fechas de hoy y del año que viene, y emoji.

### 4. Accesibilidad y dedos gordos
- Texto del sistema al 200 %: ¿se sigue leyendo y no se corta?
- Botones de al menos el tamaño de una yema (unos 44 puntos de lado).
- Contraste suficiente: prueba la app al sol, en la calle.
- Modo oscuro, si la app lo soporta.

### 5. Registro de fallos que sirve al programador
Cada fallo: qué móvil y versión, qué hiciste paso a paso, qué esperabas, qué pasó, captura o vídeo, y si se repite siempre o a veces. Sin esto, «no me funciona» no se arregla.

### 6. Criterio de publicación
Define antes de probar qué es bloqueante: pérdida de datos, cierre inesperado, pago que no llega, imposibilidad de registrarse. Lo demás va a la lista de la siguiente versión.

## Formato exacto de la respuesta
1. Matriz de dispositivos concreta para su caso.
2. Guion de pruebas en tabla: Nº | Escenario | Pasos | Resultado esperado | OK/KO.
3. Lista de datos raros a introducir.
4. Comprobaciones de accesibilidad, en casillas.
5. Plantilla de informe de fallo, lista para copiar en WhatsApp o en un documento compartido.
6. Criterio de publicar o no publicar, con la lista de bloqueantes.
7. Plan de vigilancia de las primeras 72 horas tras publicar.

## Errores típicos
- Probar solo en el móvil del dueño, que además es el mejor del mercado.
- Probar siempre con la misma cuenta llena de datos y no ver los estados vacíos.
- No probar la reinstalación ni la restauración de compras.
- Probar con wifi de fibra y descubrir en producción que con 3G la app se cuelga.
- Publicar viernes por la tarde.
- No apuntar la versión exacta en la que ocurrió el fallo.

## Avisos honestos
- Ninguna prueba manual garantiza cero fallos; el objetivo es que no llegue ninguno grave.
- Si la app maneja pagos o datos sensibles, además de esto conviene una revisión técnica.
- Publica por fases y vigila el panel de errores: es tu segunda red de seguridad.
