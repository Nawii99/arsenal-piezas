---
name: revisar-navegacion-movil
description: Revisa el código de navegación de una app Android o iOS (Jetpack Navigation, SwiftUI NavigationStack, React Navigation) y detecta los fallos que rompen el botón atrás, los enlaces y el estado de la pantalla.
---

# Revisar navegación móvil

## Qué hace
Lee el código de navegación de tu app y busca los errores que casi nunca se ven en local pero que los usuarios sí sufren: el botón atrás que saca de la app en vez de volver a la pantalla anterior, los enlaces externos (deep links) que abren la pantalla equivocada, y las pantallas que pierden los datos escritos cuando el usuario gira el móvil o recibe una llamada.

## Qué preguntar antes de empezar
- ¿Qué framework de navegación usas: Jetpack Navigation, SwiftUI, React Navigation u otro?
- ¿La app tiene enlaces desde fuera (un email, una notificación, un enlace web) que abren una pantalla concreta?
- ¿Hay pantallas con formularios donde el usuario escribe datos antes de continuar?
- ¿Tienes pestañas o menú lateral con varias secciones independientes?

## Paso a paso
1. Localiza el grafo o árbol de navegación y comprueba que cada pantalla tiene una única forma de llegar a la anterior. Si hay dos rutas distintas al mismo destino, el botón atrás se comporta distinto según por dónde entró el usuario.
2. Revisa los enlaces externos uno a uno: abre cada uno y comprueba que llega a la pantalla correcta con los datos correctos, no a la pantalla de inicio.
3. Comprueba que las pantallas con formularios guardan lo escrito cuando el sistema operativo cierra la app en segundo plano para liberar memoria. Es el fallo más habitual y el que más quejas genera.
4. Si hay pestañas, comprueba que cada una mantiene su propio historial: volver atrás en una pestaña no debe saltar a otra.
5. Prueba el flujo completo con el móvil en modo avión y luego recuperando conexión, porque muchas apps navegan mal cuando una pantalla se queda esperando una respuesta que no llega.

## Qué devolver
Una lista de los fallos encontrados, cada uno con: la pantalla afectada, qué pasa exactamente, y la línea o archivo donde está el problema. Al final, un resumen de cuáles son urgentes porque afectan a todos los usuarios y cuáles son casos raros.

## Qué NO hacer
- No des por buena la navegación solo porque funciona en el emulador: el emulador casi nunca cierra la app en segundo plano, así que no detecta la pérdida de datos.
- No propongas reescribir todo el sistema de navegación si el fallo se puede arreglar en una pantalla concreta.
- No ignores los enlaces externos por parecer un detalle menor: es la puerta de entrada desde notificaciones y campañas, y si falla, se pierde el usuario que ya hizo clic.
