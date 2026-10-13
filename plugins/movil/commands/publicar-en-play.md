---
description: Guía paso a paso para publicar una app en Google Play Console, incluyendo cuenta, firma, prueba cerrada con testers y envío a revisión
argument-hint: [nombre de la app y si tienes cuenta de desarrollador]
---

Vas a guiar la publicación en Google Play de esta app: $ARGUMENTS

Escribes en español de España y tuteas. La persona no es técnica: cada paso empieza con dónde hay que pulsar y termina con qué debe ver en pantalla si ha salido bien.

PASO 1. Preguntas de arranque, todas juntas:
- ¿Tienes ya cuenta de desarrollador de Google Play?
- ¿Vas a publicar como particular o como empresa con CIF?
- ¿Tienes ya el archivo de la app generado, y es un AAB o un APK?
- ¿La app tiene cuentas de usuario, compras dentro o publicidad?
- ¿Tienes ya la política de privacidad publicada en una dirección pública?

PASO 2. Explica el orden real de los trámites, sin saltártelos:
- Crear la cuenta de desarrollador: pago único de 25 dólares, verificación de identidad con documento y, si eres particular, la dirección se muestra en la ficha.
- Aviso importante: las cuentas personales creadas desde noviembre de 2023 tienen que pasar una prueba cerrada con al menos 12 testers que estén dentro durante 14 días seguidos antes de poder pedir el acceso a producción. Avisa de esto al principio, porque cambia el calendario del lanzamiento.
- Las cuentas de organización necesitan un identificador DUNS y tardan más en verificarse.

PASO 3. Prepara el material antes de entrar en la consola, en forma de lista:
- Archivo AAB firmado (Play exige AAB, no APK, para apps nuevas).
- Icono 512x512, gráfico de cabecera 1024x500, mínimo 2 capturas de teléfono.
- Título de 30 caracteres, descripción corta de 80 y descripción larga.
- Enlace a la política de privacidad y email de contacto.
- Cuestionario de clasificación por edades, formulario de Seguridad de los datos y declaración de público objetivo.
- Si hay cuentas de usuario, credenciales de prueba para el revisor y forma de borrar la cuenta.

PASO 4. Da el recorrido dentro de Play Console en este orden y con el nombre real de cada sección: crear la aplicación, configurar el panel de tareas iniciales, subir la versión al canal de prueba cerrada, invitar a los testers por lista de correos o por grupo de Google, dejar pasar los 14 días, solicitar el acceso a producción, y solo después crear la versión de producción y enviarla a revisión.

PASO 5. Explica la firma de la app en cristiano: Google guarda la clave con Play App Signing, y la clave de subida es la que usas tú. Advierte de que si se pierde la clave de subida se puede recuperar, pero si se pierde la clave original de una app antigua sin ese sistema, no se puede volver a actualizar nunca esa app. Manda guardar copia del almacén de claves y su contraseña en un gestor de contraseñas.

PASO 6. Motivos habituales de rechazo, para revisarlos antes de enviar: permisos que la app pide y no usa, falta de política de privacidad, formulario de datos que no coincide con la realidad, capturas que enseñan funciones inexistentes, contenido que no encaja con la clasificación de edad declarada y apps que son solo una web metida en un marco sin nada propio.

CÓMO SABER SI VA BIEN: al terminar cada bloque, el panel de Play Console tiene que mostrar la tarea en verde. Si algo queda en ámbar, no se puede enviar. Di al usuario que la primera revisión suele tardar días, no horas, y que no reenvíe la versión mientras esté en revisión.

FORMATO DE SALIDA: una lista de comprobación numerada con casillas, un calendario realista en semanas contando los 14 días de prueba cerrada, y al final un bloque con los tres errores que más probablemente cometerá esta app en concreto.
