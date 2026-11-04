---
name: crear-plantilla-app-movil
description: Crea la estructura inicial de una app móvil con Expo (React Native) para Android e iOS cuando alguien quiere arrancar un proyecto desde cero.
---

## Qué hace
Genera la carpeta base de una app móvil nueva usando Expo, que permite programar una sola vez y sacar la app tanto para Android como para iOS sin necesitar un Mac para probarla.

## Antes de empezar, pregunta
- Nombre de la app (para la carpeta y el título).
- Para qué sirve en una frase (ayuda a decidir las primeras pantallas).
- ¿Va a publicarse en Android, iOS o ambas? Para iOS hace falta una cuenta de Apple Developer (99 dólares al año) para subirla a la App Store, aunque para probarla en tu propio móvil no hace falta pagar nada.
- ¿Tienes ordenador Mac? Si no lo tienes, usa Expo Go para probar en el móvil; no intentes compilar directamente para iOS.

## Paso a paso
1. Ejecuta `npx create-expo-app@latest nombre-app` en una terminal.
2. Entra en la carpeta y ejecuta `npx expo start` para comprobar que arranca.
3. Crea las carpetas `screens/`, `components/` y `navigation/` dentro de `src/`.
4. Instala la navegación con `npx expo install @react-navigation/native @react-navigation/native-stack react-native-screens react-native-safe-area-context`.
5. Crea un archivo `navigation/AppNavigator.js` con un Stack Navigator que contenga al menos una pantalla de inicio.
6. Deja una pantalla `screens/InicioScreen.js` de ejemplo con un texto y el nombre de la app.
7. Explica al usuario cómo abrir la app en su móvil: instalar la app Expo Go y escanear el código QR que sale en la terminal.

## Qué devolver
La lista de archivos creados, el comando para arrancar el proyecto (`npx expo start`) y un resumen en una frase de qué contiene cada carpeta.

## Qué NO hacer
- No uses `react-native init` (proyecto "bare"): sin Mac no podrás compilar para iOS y complica todo para alguien que empieza.
- No instales librerías con código nativo (cámara avanzada, pagos, mapas complejos) en esta fase inicial: puede romper Expo Go y hace falta un paso extra ("development build") que no es para el primer día.
- No publiques la app en ninguna tienda todavía: primero se prueba en el móvil con Expo Go.
- No pidas datos personales del usuario (contraseñas, pagos) en este primer esqueleto: eso se añade después con las librerías adecuadas.
