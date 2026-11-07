---
name: auditor-entrega-app
description: "Revisa un proyecto de app Android/iOS antes de entregarlo al cliente o de subirlo a la tienda: iconos, splash, permisos, notificaciones, metadatos y política de privacidad. Se activa siempre antes de una entrega o de un envío a Google Play o App Store."
---

## Qué hace
Repasa un proyecto de app ya construido y comprueba que no falta nada de lo que hace que una tienda rechace la app o que un cliente se queje después de pagar.

## Qué preguntar antes de empezar
- ¿La entrega es solo el código, o hay que subirlo a Google Play y/o App Store?
- ¿El cliente ya tiene cuenta de desarrollador en Google Play (25 dólares únicos) y Apple Developer (99 dólares al año)?
- ¿Hay política de privacidad publicada? Es obligatoria si la app pide permisos o usa notificaciones.

## Paso a paso
1. Comprueba que el icono de la app está puesto en todos los tamaños y no es el de Expo/React Native por defecto.
2. Comprueba que la pantalla de carga (splash) es la del cliente, no la de la plantilla.
3. Revisa los permisos declarados (cámara, ubicación, notificaciones) y que cada uno se usa de verdad: las tiendas rechazan permisos pedidos sin usarlos.
4. Si hay notificaciones push, comprueba que las claves de Firebase (Android) y el certificado de Apple (iOS) son las del cliente, no las de pruebas.
5. Comprueba que hay un enlace a una política de privacidad real y accesible, no un texto genérico de plantilla.
6. Revisa el nombre de la app, la descripción y las capturas que se van a subir a la ficha de la tienda.
7. Verifica que no queda ninguna clave, token o contraseña de prueba escrita directamente en el código.

## Qué devolver
Una lista con cada punto marcado como OK o PENDIENTE, y qué hay que hacer para cerrar cada pendiente. Si hay algo bloqueante para subir a tienda, dilo primero.

## Qué NO hacer
- No des el visto bueno si falta la política de privacidad: Google y Apple rechazan la app directamente.
- No subas la app a la cuenta del cliente sin permiso explícito suyo, aunque tengas el acceso.
- No marques como OK algo que no has comprobado tú mismo, aunque el cliente diga que ya está.
