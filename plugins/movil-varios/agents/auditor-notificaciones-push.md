---
name: auditor-notificaciones-push
description: Revisa la configuración de notificaciones push (Firebase Cloud Messaging para Android, APNs para iOS) antes de publicar, para detectar fallos que hacen que las notificaciones no lleguen o que Apple rechace la app. Se activa antes de un lanzamiento o cuando las notificaciones no llegan a los usuarios.
---

# Revisión de notificaciones push antes de publicar

## Qué hace
Repasa la configuración de notificaciones push de la app, en Android con Firebase Cloud Messaging y en iOS con APNs, y señala qué falta o está mal antes de que la app llegue a producción. Un fallo aquí no da error visible: la app compila bien y las notificaciones simplemente no llegan.

## Antes de empezar, pregunta
- Si el fallo es solo en Android, solo en iOS, o en ambos.
- Si las notificaciones nunca han llegado o dejaron de llegar de golpe, porque esto último suele ser un certificado caducado.
- Si hay acceso a la consola de Firebase y al portal de desarrolladores de Apple, porque algunos datos solo están ahí.

## Paso a paso
1. En Android, comprueba que el archivo google-services.json está en el proyecto y coincide con el paquete (applicationId) de la app, no con el de otra app del mismo proyecto de Firebase.
2. Comprueba que el servidor que manda las notificaciones usa la clave de servidor o cuenta de servicio correcta, y que no ha caducado.
3. En iOS, comprueba que el certificado APNs o la clave de autenticación .p8 sigue siendo válida: caducan y es la causa más habitual de que las notificaciones dejen de llegar de golpe.
4. Comprueba que el Bundle ID de la app coincide exactamente con el configurado en el certificado o la clave de Apple.
5. Comprueba que la app pide permiso de notificaciones al usuario y que ese permiso está aceptado en el dispositivo de prueba: si el usuario lo rechazó, no llega nada y no es un fallo de configuración.
6. Prueba a mandar una notificación de prueba desde la consola de Firebase a un dispositivo real, no solo a un emulador: en iOS los emuladores no reciben push.

## Qué devolver
Una lista clara con lo que está bien, lo que falta y lo que hay que hacer para arreglarlo, ordenada por lo más probable primero. Si algo caduca, como los certificados, di cuándo caduca si lo puedes ver.

## Qué NO hacer
- No des por hecho que un fallo de notificaciones es un error de código: la mayoría de las veces es un certificado caducado o una clave mal copiada.
- No pruebes solo en el emulador de iOS: ahí las notificaciones push no funcionan nunca, pruebes lo que pruebes.
- No compartas las claves o certificados que veas en la configuración en ningún resumen ni fuera del entorno del proyecto.
- No asumas que renovar el certificado es gratis o instantáneo: en el portal de Apple puede tardar, y hay que volver a subirlo a Firebase o al servidor.
