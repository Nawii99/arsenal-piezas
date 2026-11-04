---
name: iniciar-proyecto-movil
description: Genera una checklist antes de crear un proyecto Android o iOS desde plantilla, para evitar los fallos que luego cuestan días arreglar.
---

# Iniciar proyecto móvil

## Qué hace
Antes de que uses una plantilla de Android Studio o Xcode para crear tu app, te hace las preguntas que casi nadie se hace y te devuelve una checklist personalizada. Evita los tres fallos que más tiempo hacen perder: cambiar el identificador de la app a mitad de proyecto, subir la app a la tienda sin firma correcta, y pedir permisos que no usas.

## Qué preguntar antes de empezar
- ¿La app es para Android, iOS o las dos?
- ¿Ya tienes cuenta de desarrollador en Google Play (25 euros de pago único) y/o Apple Developer (99 dólares al año)?
- ¿Cómo se va a llamar la app en las tiendas? Ese nombre no es el identificador técnico, son cosas distintas.
- ¿Vas a usar login, cámara, ubicación, notificaciones o cobros dentro de la app?

## Paso a paso
1. Fija el identificador de paquete (Android, tipo com.tuempresa.tuapp) y el Bundle ID (iOS) ANTES de escribir una línea de código. Cambiarlo después obliga a publicar la app casi como si fuera nueva, perdiendo reseñas e instalaciones.
2. Genera y guarda la clave de firma de Android (keystore) en un sitio con copia de seguridad, no solo en tu ordenador. Si la pierdes, no puedes actualizar la app nunca más, tienes que publicarla como app distinta.
3. En iOS, configura el certificado y el perfil de aprovisionamiento en tu cuenta de Apple Developer, no en un ordenador prestado: si esa persona se va, pierdes el acceso.
4. Lista solo los permisos que la app va a pedir de verdad (cámara, ubicación, contactos). Cada permiso de más es un motivo de rechazo en las revisiones de Apple y de desconfianza para el usuario en Android.
5. Decide desde el día uno si vas a soportar tablets y pantallas grandes, porque cambiarlo luego implica rehacer las pantallas.
6. Activa el control de versiones (git) desde el primer commit, antes de tocar la plantilla.

## Qué devolver
Una checklist en formato lista con casillas, agrupada en tres bloques: identidad de la app (nombre, identificador, firma), permisos que se van a pedir y por qué, y cuentas de desarrollador necesarias con su coste.

## Qué NO hacer
- No reutilices el identificador de otra app tuya aunque esté sin publicar: si algún día coincide con otra ya subida, la tienda rechaza la tuya.
- No guardes la clave de firma solo en tu portátil ni la subas a un repositorio público: cualquiera con ella puede publicar actualizaciones falsas de tu app.
- No actives permisos 'por si acaso'. Google y Apple los revisan y piden justificación, y rechazan la app si no la tiene.
