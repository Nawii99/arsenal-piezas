---
name: pedir-archivos-dropbox
description: "Prepara una solicitud de archivos de Dropbox para que clientes o colaboradores te suban documentos sin email: lista de lo que pedir, nombres de archivo, mensaje para enviar y seguimiento de lo recibido. Úsala cuando tengas que recoger materiales, facturas o documentos de varias personas."
---

# Pedir archivos con un enlace de subida de Dropbox

Dónde va: guárdala como .claude/skills/pedir-archivos-dropbox/SKILL.md dentro de tu carpeta de trabajo. Se activa cuando pides algo parecido; también puedes nombrarla.

## Qué hace
Prepara todo lo necesario para pedir archivos de forma ordenada: la lista exacta de lo que necesitas, las reglas de nombres, el texto de la solicitud, el mensaje para enviar y una hoja de seguimiento. Dropbox tiene una función de solicitud de archivos (File requests): generas un enlace y quien lo recibe sube archivos a una carpeta tuya sin ver el resto de tu Dropbox. Normalmente no necesita cuenta; comprueba el aviso que le sale.

## Dos formas de trabajar
- Si tienes Dropbox conectado a Claude Code (escribe /mcp para ver tus conexiones), puede crear la solicitud. Antes te enseña qué va a crear y espera tu OK.
- Si no, te deja todo preparado y tú pulsas los botones en dropbox.com. Es lo más habitual.

## Riesgos que debes saber
- Quien tenga el enlace puede subir archivos. Envíalo solo a quien toca. No lo pongas en una web ni en un grupo abierto.
- Lo que suben cuenta en tu espacio de Dropbox. Un archivo enorme puede llenarlo. Mira cuánto te queda.
- No es un buzón pensado para documentos muy sensibles. No pidas DNI, nóminas, datos de salud o de menores salvo que haga falta y puedas justificarlo. El RGPD te obliga a pedir solo lo necesario, a explicar para qué y a borrarlo cuando acabe.
- Pueden llegar archivos con virus o que no son lo que dicen. No abras ejecutables (.exe), archivos comprimidos de desconocidos ni documentos que pidan activar macros.
- Si pides fotos o logotipos, pide que confirmen que tienen derecho a usarlos.
- Si conectas Dropbox a Claude Code, limita su trabajo a la carpeta de entregas. No le abras todo tu Dropbox.

## Qué preguntar antes de empezar (todo junto)
1. ¿Qué necesitas recibir exactamente? Pide una lista concreta.
2. ¿Quién va a subirlo? Mejor una solicitud por persona o por cliente, para saber quién subió qué.
3. ¿Para cuándo lo necesitas?
4. ¿Llegarán datos personales o sensibles? Si sí, ¿de verdad hacen falta?
5. ¿Qué plan de Dropbox tienes? Según el plan puedes poner fecha límite u otras opciones. Compruébalo.
6. ¿En qué carpeta quieres que lleguen y cómo organizas tus carpetas?
7. ¿Por qué canal vas a enviar el enlace? Email, WhatsApp u otro.

## Paso a paso
1. Lista de pedidos en tabla: número, qué se pide, formato aceptado, obligatorio u opcional, y un ejemplo. Si la lista es larga, divídela en dos solicitudes. Es más fácil de cumplir.
2. Reglas de nombres. Sin espacios ni acentos, con fecha, persona y tipo. Ejemplo: 2026-10-05_Garcia_logotipo.png. Explícalo en una línea.
3. Estructura de carpeta de destino, por ejemplo Entregas/Cliente/Proyecto.
4. Título y descripción de la solicitud, listos para pegar: qué subir, formatos, fecha y a quién preguntar si hay dudas.
5. Si no hay conexión, pasos para crearla: entra en dropbox.com, busca «Solicitudes de archivos» (File requests) en el menú lateral, pulsa para crear una, pon título, descripción y carpeta de destino, añade fecha límite si tu plan lo permite y copia el enlace. Los nombres y la ubicación de los menús cambian: si no los ves, busca «solicitud de archivos» en la ayuda de Dropbox.
6. Mensaje para enviar el enlace: una versión de email con asunto y otra de WhatsApp de tres o cuatro líneas. Con [ENLACE], la fecha y qué hacer si tienen dudas.
7. Hoja de seguimiento: pedido, recibido (sí o no), fecha, revisado (formato y calidad) y comentario.
8. Cuando me pases el listado de archivos recibidos (solo los nombres), compáralo con la lista, marca lo que falta y redacta un recordatorio cordial.
9. Cierre: cuando esté todo, mueve lo recibido a su carpeta definitiva, cierra la solicitud para que el enlace deje de funcionar y borra lo que ya no necesites si eran datos personales.

## Qué devolver y con qué formato
Markdown, en este orden:
1. Tabla de lo que se pide.
2. Reglas de nombres y carpeta de destino.
3. Título y descripción de la solicitud.
4. Mensaje de email y mensaje de WhatsApp.
5. Pasos para crearla, o confirmación de que se creó y el enlace.
6. Tabla de seguimiento vacía.
7. Avisos: datos personales detectados y qué hacer con ellos.

## Qué NO hacer
- No crear la solicitud ni enviar el enlace sin que lo confirmes.
- No pedir documentos de identidad, datos bancarios ni de salud si no son imprescindibles.
- No borrar, mover ni renombrar archivos de tu Dropbox por su cuenta.
- No abrir archivos recibidos que sean ejecutables o pidan activar macros.
- No compartir el enlace en canales públicos.
- No decir a nadie que la subida es «segura» o «cifrada». No conoces la configuración de la cuenta.

## Cuándo pasar a una persona
- Vas a recibir datos personales de muchos clientes: consulta a tu gestor o a quien lleve tu protección de datos.
- Un archivo recibido te parece sospechoso.
- El espacio de Dropbox se acaba.
