---
name: andamiaje-app-cliente
description: Genera la estructura inicial de una app Android/iOS (React Native con Expo) con navegación y notificaciones push ya conectadas, a partir del briefing de un cliente. Se activa cuando arrancas un proyecto de app para un cliente de pago.
---

## Qué hace
Genera la estructura inicial de una app para Android e iOS usando React Native con Expo, con navegación entre pantallas y notificaciones push ya conectadas, a partir del briefing de un cliente de pago.
Está pensada para el momento en que aceptas un encargo y necesitas arrancar el proyecto rápido, con una base sólida que luego personalizas pantalla a pantalla.

## Qué preguntar antes de empezar
- Nombre de la app y una frase de qué hace.
- Lista de pantallas principales (ejemplo: login, listado, ficha, perfil, ajustes).
- ¿Necesita notificaciones push? ¿De qué tipo (recordatorios, avisos, chat)?
- ¿Login con email, con Google, con Apple, o sin login?
- ¿Para Android, iOS o los dos? Los dos implica cuenta de Apple Developer, 99 dólares al año.
- ¿Tiene ya logo, colores de marca y textos, o hay que dejar huecos de plantilla?

## Paso a paso
1. Crea el proyecto con Expo (npx create-expo-app) usando TypeScript.
2. Instala React Navigation y monta la navegación: stack para el flujo principal, tabs si hay entre 3 y 5 secciones.
3. Crea una pantalla por cada elemento de la lista del cliente, vacía pero con título y navegación funcionando entre ellas.
4. Si pidió notificaciones, instala expo-notifications y deja el código de pedir permiso y registrar el token, con un comentario explicando que hace falta un proyecto en Firebase (Android) y un certificado de Apple (iOS) para que funcione en producción.
5. Deja un README en español con cómo arrancar el proyecto (npx expo start) y qué falta por rellenar: logo, textos, claves de Firebase y Apple.
6. Sube el proyecto a un repositorio Git nuevo, sin subir claves ni certificados.

## Qué devolver
Un resumen corto: pantallas creadas, si la navegación funciona, si las notificaciones están cableadas o pendientes de claves, y la lista de lo que falta antes de poder mandarlo a las tiendas.

## Qué NO hacer
- No inventes claves de Firebase, Apple o cualquier servicio: se dejan como [PENDIENTE DE CLAVE].
- No subas certificados, contraseñas ni el archivo .p12 de Apple a ningún repositorio, ni siquiera privado.
- No prometas que la app estará en la tienda en una fecha concreta: Apple puede tardar días en revisar y puede rechazarla.
- No actives notificaciones push de prueba contra usuarios reales sin que el cliente lo sepa: puede darse de baja o quejarse de spam.
