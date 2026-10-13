---
name: atencion-whatsapp-fuera-de-horario
description: Monta la atención por WhatsApp Business de un negocio, con respuestas rápidas, mensajes fuera de horario, clasificación de consultas, reglas para pasar a una persona y resumen diario. Se activa cuando el usuario quiere responder a clientes por WhatsApp sin estar pegado al móvil, o menciona waboxapp.
---

# Atención por WhatsApp Business sin estar pegado al móvil

Esta skill deja montada la atención por WhatsApp de un negocio. Define qué se contesta solo, qué se contesta con un borrador revisado y qué solo contesta una persona. Empieza por lo que no da riesgo y automatiza después.

## Elige el nivel (explícaselo al usuario antes de nada)

- Nivel 1, sin programar y sin riesgo. La app WhatsApp Business, gratuita, trae mensaje de bienvenida, mensaje de ausencia, respuestas rápidas, etiquetas, catálogo y horario [comprueba las opciones en tu versión de la app, en Android]. Empieza por aquí.
- Nivel 2, con borradores de IA. El usuario pega el mensaje del cliente, Claude propone la respuesta y una persona la envía. El número no corre riesgo.
- Nivel 3, respuestas automáticas con la API oficial de WhatsApp, que es la conexión oficial de Meta para empresas. Se contrata a través de un proveedor oficial [por ejemplo Twilio o 360dialog; comprueba]. Hace falta un número registrado y plantillas aprobadas para escribir pasadas 24 horas, y se paga por mensaje de plantilla [tarifa]. Se monta con n8n.
- Herramientas que se conectan imitando WhatsApp Web o con apps no oficiales (waboxapp u otras). [COMPRUEBA EN SU WEB si usan la vía oficial de Meta.] Si no la usan, WhatsApp puede bloquear el número del negocio y con él se pierden los chats con los clientes. No las uses con el número principal.

## Antes de empezar, pregunta

- ¿Qué vende el negocio y qué le preguntan más? Pide entre 20 y 30 conversaciones reales ya anonimizadas, sin nombres, teléfonos ni direcciones. En Android: abrir el chat, menú de tres puntos, Más, Exportar chat, sin archivos.
- ¿Cuál es el horario y qué pasa fuera de él?
- ¿Qué información es segura de dar? Precios, horarios, plazos, zonas de envío, formas de pago, devoluciones. ¿Dónde está?
- ¿Qué casos debe atender siempre una persona?
- ¿Quién atiende y en cuánto tiempo? ¿Cuántos mensajes llegan al día?
- ¿Qué nivel quiere? ¿El número es exclusivo del negocio o también personal?

## Paso a paso

1. Agrupa las conversaciones en entre 6 y 10 motivos: precio, disponibilidad, estado de pedido, cita, incidencia, devolución, factura, otros. Cuenta cuántas hay de cada uno.
2. Crea la hoja de datos fiables: lo que se puede decir, con cada dato y su fecha de revisión. Si falta un dato, pídelo. No lo inventes.
3. Redacta una respuesta por motivo. Cortas, con el tono del negocio, una pregunta cada vez y con [DATO] donde falte información.
4. Redacta los mensajes de sistema: bienvenida (quién es, horario y, si contesta un bot, aviso de que es un asistente automático), ausencia (cuándo se responderá) y cierre.
5. Define cuándo pasa SIEMPRE a una persona: reclamaciones o enfado, devoluciones y reembolsos, salud o seguridad, pagos y datos de tarjeta, peticiones sobre datos personales, amenazas legales, menores, algo que no se entiende a la segunda y petición de hablar con una persona.
6. Si es nivel 3, describe el flujo: entra el mensaje, se clasifica el motivo y, si el motivo es seguro y el dato está en la hoja, se prepara un borrador que una persona aprueba durante las primeras semanas. Solo los motivos que lleven semanas sin errores pasan a envío automático. Si es un caso para una persona, se avisa a su móvil con un resumen. Recuerda la regla de las 24 horas.
7. Registro: cada conversación automática guarda motivo, respuesta y si se pasó a una persona. Cada día, un resumen con número de mensajes, motivos, casos pendientes y respuestas dudosas.
8. Pruebas: 20 mensajes a un número propio, con casos difíciles. Enfado, pregunta fuera de tema, intento de que prometa un descuento, otro idioma y nota de voz. Corrige y repite.
9. Durante el primer mes, una persona lee cada semana una muestra de las conversaciones automáticas.

## Qué devolver

- Plan por niveles: qué se hace hoy en la app y qué se deja para después.
- Informe de conversaciones: motivos y recuento.
- Hoja de datos fiables, con huecos [entre corchetes].
- Respuestas por motivo y mensajes de sistema, listos para pegar en la app como respuestas rápidas con su atajo (se escribe / y el atajo).
- Reglas para pasar a una persona.
- Si es nivel 3: la receta del flujo con sus pasos y las cuentas que hacen falta.
- Informe de pruebas y lista de pendientes para la persona.
- Formato del resumen diario.

## Qué NO hacer

- No automatices el número principal con herramientas no oficiales.
- No hagas envíos masivos ni de promoción sin permiso previo de cada persona.
- No dejes que el bot invente precios, plazos, stock ni descuentos. Si el dato no está en la hoja: «lo compruebo y te digo».
- No lo hagas pasar por una persona. La UE exige avisar de que se habla con una IA (Reglamento de IA, artículo 50) [confirma las fechas con un asesor].
- No des consejo de salud, legal ni financiero.
- No pidas ni aceptes datos de tarjeta, contraseñas ni DNI por WhatsApp.
- No contestes de forma automática a una reclamación.
- No conectes un asistente de IA de uso general a la API de WhatsApp. Desde enero de 2026 las condiciones de Meta lo limitan. Un bot de atención del propio negocio es otra cosa [confirma en las condiciones vigentes].
- No copies chats completos a otras herramientas si no hace falta. Son datos personales.
- No pegues claves ni tokens en el chat.

## Qué revisa una persona antes de activar nada

- La hoja de datos fiables.
- Todas las respuestas, antes de activarlas.
- Las reglas para pasar a una persona.
- La privacidad: que la política del negocio informa del uso de IA y de proveedores externos (RGPD). Si hay duda, se mira con un asesor.
- La muestra semanal de conversaciones.

## Dónde se guarda

Guarda este texto como SKILL.md en la carpeta .claude/skills/atencion-whatsapp-fuera-de-horario/ de tu proyecto.
