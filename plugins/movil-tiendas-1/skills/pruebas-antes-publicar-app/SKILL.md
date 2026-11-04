---
name: pruebas-antes-publicar-app
description: Produces a manual QA plan for a mobile app before release: device matrix, edge-case scenarios, permission and connectivity paths, and a bug reporting template. Use when the user is about to publish an app or an update, gets bug reports they cannot reproduce, or has only tested on their own phone.
---

# Pruebas antes de publicar tu app

## Qué hace
Genera la lista concreta de pruebas a mano que hay que pasar antes de subir una versión, adaptada a lo que hace tu app, y el formato para anotar los fallos.

## Cuándo se activa
Cuando el usuario va a publicar o actualizar, habla de pruebas, de bugs, de que "en mi móvil funciona" o de quejas que no reproduce.

## Qué preguntar si falta información
1. ¿Qué hace la app y cuáles son sus 3 flujos principales?
2. ¿iPhone, Android o los dos? ¿Versiones mínimas soportadas?
3. ¿Usa cámara, ubicación, notificaciones, pagos, cuenta de usuario o funciona sin conexión?
4. ¿Qué has cambiado en esta versión?
5. ¿Qué móviles tienes a mano tú o gente cercana?

## Método
1. Monta la matriz de dispositivos con lo mínimo viable: un iPhone pequeño y antiguo dentro de tu versión mínima, un iPhone reciente con isla o notch, un Android de gama baja y uno de gama alta. Si solo tienes uno, usa los simuladores para lo visual y consigue prestado al menos un móvil real de la otra plataforma.
2. Prueba los flujos principales de punta a punta, no funciones sueltas: registrarse, hacer la acción central, pagar si aplica, cerrar y volver a entrar.
3. Situaciones que rompen las apps y casi nadie prueba: modo avión y recuperación de la conexión; red muy lenta; permiso denegado en cámara, ubicación o notificaciones; sesión caducada; teclado tapando el campo y el botón; rotación de pantalla; modo oscuro; tamaño de letra del sistema al máximo (accesibilidad); llamada entrante en mitad del flujo; app en segundo plano media hora y vuelta; batería baja con ahorro de energía; botón atrás de Android en cada pantalla; y desinstalar y volver a instalar.
4. Datos límite: campo vacío, texto larguísimo, emojis y acentos, importes con coma decimal, fechas al revés, cero elementos y muchos elementos en una lista.
5. Zonas seguras: comprueba que nada queda debajo de la isla dinámica, del notch, ni de la barra inferior de gestos.
6. Actualización: instala la versión anterior desde la tienda, úsala, y luego instala encima la nueva. Es la prueba que más se olvida y donde aparecen las pérdidas de datos.
7. Pasa una revisión de textos: faltas de ortografía, textos que se cortan, cadenas sin traducir, importes con formato español.
8. Anota cada fallo con: título, pasos exactos, resultado esperado, resultado obtenido, dispositivo y versión, y captura o vídeo. Un fallo sin pasos no se arregla.
9. Prioriza: bloqueante (impide usar la app o perder dinero), grave (función principal a medias), menor (cosmético). Solo los dos primeros paran el lanzamiento.

## Formato exacto de la respuesta
- MATRIZ DE DISPOSITIVOS: modelo | sistema | quién lo prueba
- CHECKLIST POR FLUJO: casilla, paso, resultado esperado
- CHECKLIST DE SITUACIONES RARAS, adaptado a los permisos que usa la app
- PLANTILLA DE INCIDENCIA lista para copiar
- CRITERIOS DE PARADA: qué fallos impiden publicar
- TIEMPO ESTIMADO de la pasada completa

## Errores típicos
- Probar solo en el móvil del desarrollador, siempre con buena conexión y sesión abierta.
- Probar la instalación limpia pero no la actualización desde la versión anterior.
- No probar qué pasa cuando el usuario dice "No permitir".
- Corregir un fallo y no volver a pasar el flujo entero.
- Publicar un viernes por la tarde.

## Avisos honestos
- Estas pruebas manuales no sustituyen a pruebas automáticas si la app crece, pero son lo que evita el 80% de las reseñas de una estrella.
- No vas a cubrir todos los móviles del mundo: cubre los que usan tus clientes.
- Reserva un rato después de publicar para mirar los informes de fallos: la primera semana es cuando aparece lo que no viste.
