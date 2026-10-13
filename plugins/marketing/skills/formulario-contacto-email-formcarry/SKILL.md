---
name: formulario-contacto-email-formcarry
description: Prepara un formulario de contacto para tu web que envía cada mensaje a tu email mediante Formcarry, con campos mínimos, texto de privacidad, antispam y lista de pruebas. Úsala cuando tu web necesite un formulario y no tengas servidor ni quieras montar uno.
---
# Formulario de contacto a tu email con Formcarry
Formcarry es un servicio que recibe lo que envía un formulario de tu web y te lo manda por email. Así no necesitas un servidor propio. Esta skill diseña el formulario, redacta el texto de privacidad y te deja una lista de pruebas.

## Instalación (para la persona, no para Claude)
- Guarda este texto como SKILL.md dentro de .claude/skills/formulario-contacto-email-formcarry/ de tu proyecto, o de ~/.claude/skills/formulario-contacto-email-formcarry/ para todos tus proyectos.
- Crea una cuenta en Formcarry y un formulario nuevo. Su panel te dará una dirección de envío. Cópiala tal cual: [URL-DE-TU-FORMULARIO-EN-FORMCARRY].
- Mira qué incluye tu plan y cuál es el límite de envíos al mes: [LÍMITE DE TU PLAN]. Comprueba también qué pasa al superarlo: podrías perder mensajes sin enterarte.

## Pregunta esto antes de empezar
1. ¿Dónde está tu web y quién la edita? WordPress, Wix, Webflow, Shopify, HTML a mano u otra. Si ya trae formularios propios, ¿de verdad necesitas Formcarry?
2. ¿Tienes ya la dirección de envío de Formcarry? Si no, guía a la persona para crearla en su panel, sin inventar nombres de menús.
3. ¿Qué campos hacen falta de verdad? Lo mínimo es nombre, email y mensaje. Cada campo extra baja los envíos y añade obligaciones legales.
4. ¿A qué email deben llegar los mensajes y quién los responde? ¿En cuánto tiempo?
5. ¿Quién es el responsable de los datos? Nombre o razón social, NIF y email de contacto. ¿Dónde está la política de privacidad?
6. ¿Qué ve la persona al enviar? Página de gracias o mensaje en pantalla.
7. ¿Quieres una casilla para la newsletter? Si sí, va aparte y sin marcar.

## Paso a paso
1. Diseña el formulario con los campos mínimos. Etiqueta visible encima de cada campo (no solo texto de ayuda dentro), tipo correcto (email, teléfono), campos obligatorios marcados y un texto breve de ayuda.
2. Escribe el código HTML con method POST y como action la dirección de Formcarry que te dé la persona. Añade un campo trampa oculto contra el spam y avisa de que active en el panel la protección antispam que ofrezca su plan.
3. Redacta el aviso de privacidad de primera capa, justo bajo el botón: quién es el responsable, para qué se usan los datos (atender la consulta), por qué es legal (consentimiento o petición de la persona), quién los recibe (Formcarry como proveedor), derechos de acceso y borrado, y enlace a la política de privacidad. Si se pide consentimiento, usa una casilla sin marcar.
4. Explica dónde pegar el código en su plataforma: en WordPress, un bloque HTML personalizado; en Wix, Webflow o Squarespace, un elemento de código incrustado; en HTML a mano, dentro de la página. Si la plataforma ya trae formularios, dilo.
5. Indica cómo configurar la página de gracias en el panel de Formcarry, si el plan lo permite. Si no lo sabes, dilo.
6. Entrega la lista de pruebas de abajo y deja por escrito: qué plan hay, cuál es el límite mensual y a quién avisar si dejan de llegar mensajes.

## Cómo probarlo sin liarla
- Prueba primero en una copia o en una página que nadie tenga enlazada.
- Envía un mensaje con tu propio email. Comprueba que llega y mira la carpeta de spam. Si cae allí, márcalo como correo legítimo y crea un filtro.
- Prueba con campos vacíos, con un email mal escrito y con un texto muy largo.
- Prueba desde el móvil.
- Rellena el campo trampa a propósito: ese mensaje no debe llegar.
- Comprueba que sale el mensaje de gracias y que los datos no aparecen en la dirección del navegador.
- Mira el panel de Formcarry: el envío debe aparecer registrado.
- Al día siguiente, haz otro envío de prueba.

## Qué devolver
- El código del formulario, listo para pegar.
- El texto de privacidad con sus huecos entre corchetes.
- Las instrucciones para su plataforma, en pasos cortos.
- La lista de pruebas y la nota de límites del plan.

## Qué NO hacer
- No pidas DNI, datos bancarios ni de salud, ni nada que no necesites. Este formulario no sirve para cobros ni para datos de tarjeta.
- No pongas claves secretas ni contraseñas en el código de la página: lo que está en una web lo puede ver cualquiera. La dirección del formulario es pública por diseño; una clave de API, no.
- No marques casillas por defecto ni mezcles el consentimiento de privacidad con el de la newsletter.
- No publiques sin hacer las pruebas. Un formulario roto pierde clientes sin avisar.
- No toques la web en producción sin una copia previa.
- No prometas un plazo de respuesta que no vas a cumplir.
- No uses los emails recibidos para mandar ofertas si la persona solo pidió información.

## Qué revisa una persona antes de usar el resultado
- El texto legal y la política de privacidad los revisa quien lleve lo legal en tu negocio (abogado, gestor o delegado de protección de datos). Los textos de esta skill son un punto de partida, no asesoramiento.
- Que hay contrato de encargado de tratamiento con Formcarry y que sabes dónde guarda los datos. Si es fuera de la UE, hay requisitos adicionales (RGPD).
- Que los avisos llegan a alguien que los lee y responde.
- Si tu web usa cookies no técnicas, que el aviso de cookies está bien (LSSI, art. 22). Algunos sistemas antispam añaden cookies.
