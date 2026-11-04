---
name: informe-permisos-movil
description: Analiza los permisos de una app o de todo un móvil Android y entrega un informe en español con los riesgos y qué desactivar. Se activa cuando el usuario pega una lista de permisos o pide revisar los permisos de su móvil.
---

## Qué hace
Convierte una lista de permisos de Android (la que se ve en Ajustes > Apps > [app] > Permisos, o la del Gestor de permisos) en un informe corto que dice qué permisos son normales, cuáles son un riesgo y qué botón tocar para quitarlos.

## Qué preguntar antes de empezar
- Si es una sola app o todas las apps del móvil.
- Para qué usa esa app la persona, porque ayuda a juzgar si un permiso tiene sentido: una app de linterna no necesita contactos.
- Si el móvil es personal o de un cliente al que le vas a entregar el informe.

## Paso a paso
1. Pide la lista de permisos si no la ha pegado ya. Si solo tiene el nombre de la app, dile cómo sacarla: Ajustes > Apps > (nombre) > Permisos.
2. Clasifica cada permiso en tres niveles: normal para lo que hace la app, dudoso (pídele que confirme por qué lo necesita), y riesgo alto (cámara, micrófono, ubicación, contactos, SMS, accesibilidad en apps que no lo justifican).
3. Para cada permiso de riesgo alto, da la ruta exacta para revocarlo: Ajustes > Apps > (nombre) > Permisos > (permiso) > No permitir.
4. Si hay permiso de Accesibilidad o Administrador de dispositivo en una app que no es un gestor de contraseñas ni un antivirus conocido, márcalo como lo más urgente: ese permiso puede leer la pantalla y capturar contraseñas.
5. Cierra con un resumen de máximo 5 líneas: cuántos permisos hay, cuántos son de riesgo alto, y las 2-3 acciones a hacer ya.

## Qué devolver
Una tabla en markdown con columnas: Permiso | Nivel de riesgo | Qué hacer. Debajo, el resumen de 5 líneas. Nada de introducciones largas ni relleno.

## Qué NO hacer
- No digas que revocar un permiso no tiene efectos secundarios: algunas apps dejan de funcionar bien si le quitas un permiso que sí usan de verdad, como mapas sin ubicación. Avísalo permiso por permiso.
- No inventes qué hace una app si no la conoces: dilo y pide que la persona confirme su función.
- No trates este informe como una auditoría de seguridad completa: es una revisión de permisos, no un análisis del código de la app.
