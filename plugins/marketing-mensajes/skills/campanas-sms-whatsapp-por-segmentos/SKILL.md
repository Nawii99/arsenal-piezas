---
name: campanas-sms-whatsapp-por-segmentos
description: Planifica una campaña de SMS y WhatsApp a segmentos de clientes con permiso, con mensajes por canal, calendario, coste, topes y criterios de parada. Se activa cuando el usuario quiere enviar ofertas, avisos o confirmaciones a muchos clientes por SMS o WhatsApp.
---

# Campañas de SMS y WhatsApp por segmentos, con permiso

Esta skill prepara el envío a muchos clientes: a quién, qué se les dice en cada canal, cuándo, cuánto cuesta y cómo se mide. Deja la campaña lista para que una persona la apruebe. No la lanza.

## Sobre la plataforma de envío

La ficha de origen habla de UniOne. No está comprobado qué canales ofrece ni si su WhatsApp va por la vía oficial de Meta. [COMPRUEBA EN SU WEB qué canales tiene de verdad y cuánto cobra.] La skill no depende de ninguna plataforma. Donde veas [PLATAFORMA], pon la que use el usuario.

## Antes de empezar, pregunta

- ¿Cuál es el objetivo único de la campaña? Confirmar citas, avisar de una reposición, una oferta, reactivar clientes inactivos.
- ¿Es un mensaje de servicio (confirma o avisa de algo que el cliente ya pidió) o comercial (ofrece algo)? Las reglas cambian.
- ¿Cuándo y cómo dio permiso cada contacto, para qué canal y para qué fin? ¿Queda guardado con fecha?
- ¿Cuántos contactos hay y qué datos se tienen de ellos? Teléfono, nombre, última compra, ciudad, idioma.
- ¿Qué plataforma y qué canales se usan, y WhatsApp va por la vía oficial?
- ¿Cuál es el presupuesto máximo y la fecha límite?
- ¿Quién aprueba los textos y quién atiende las respuestas?

## Paso a paso

1. Fija un objetivo medible. Por ejemplo, citas reservadas esta semana. Elige la métrica con el usuario.
2. Filtra por permiso antes que nada. Solo entran contactos con permiso para ese canal y ese fin. Fuera bajas, rebotes y teléfonos no válidos. La ley (LSSI, artículo 21) prevé una excepción para clientes con relación previa y productos similares, siempre con baja fácil. No des por hecho que el caso entra: [confírmalo con un asesor].
3. Segmenta con reglas simples, entre tres y cinco segmentos. Ejemplos: clientes que compraron en los últimos 90 días, clientes inactivos de 6 a 12 meses, clientes de una tienda concreta. Anota para cada uno criterio, tamaño, canal y mensaje.
4. No segmentes por datos sensibles (salud, ideología, religión, orientación sexual). El RGPD los protege de forma especial.
5. Elige canal por segmento. SMS para avisos cortos. WhatsApp si el contacto lo usa y hay plantilla aprobada. Email si el texto es largo. Un solo canal por contacto y campaña. No repitas el mismo mensaje por dos canales.
6. Escribe los mensajes. En SMS, con tildes como á, í, ó, ú o con emojis el límite baja de 160 a 70 caracteres y cada tramo se cobra. Cuenta caracteres y segmentos. En WhatsApp, plantilla con huecos y un ejemplo para cada uno. En ambos: quién escribe, para qué, una sola acción y, si es comercial, cómo darse de baja.
7. Si el usuario quiere probar dos textos, haz dos variantes y pruébalas con una parte pequeña de la lista.
8. Calendario: días y horas razonables [decídelo con el cliente], sin noches, domingos ni festivos locales. Envío por lotes. Tope de frecuencia: no más de [N] mensajes por contacto al mes.
9. Presupuesto: contactos × segmentos de SMS × [TARIFA SMS], más contactos × [TARIFA WHATSAPP SEGÚN CATEGORÍA], más un margen para fallos. Pon un tope de gasto en la plataforma.
10. Pruebas: primero a números del equipo, luego a una muestra pequeña [N]. Mira errores, bajas y quejas antes de seguir.
11. Medición y parada: entregados, errores, respuestas, bajas, quejas y resultado del objetivo. Define antes de empezar cuándo se para [por ejemplo, si las bajas superan un porcentaje que decida el cliente].
12. Solo con aprobación escrita, y si el usuario lo pide, describe cómo dejarlo programado en n8n: disparador por fecha, lectura de la lista, filtro de permiso, envío por lotes y registro. Con el tope de gasto activado.

## Qué devolver

Una ficha de campaña con estas partes:

- Objetivo y métrica.
- Tipo de mensaje (servicio o comercial) y cómo se acredita el permiso.
- Segmentos: nombre, criterio, número de contactos, canal, mensaje y momento.
- Los mensajes: SMS con recuento de caracteres y segmentos, y WhatsApp con sus huecos.
- Calendario y lotes.
- Presupuesto con fórmula y tope.
- Plan de pruebas y criterios de parada.
- Lista de aprobación con casillas para marcar.
- Plantilla de informe posterior.

## Qué NO hacer

- No envíes ni programes nada sin aprobación escrita del responsable, después de ver la ficha y la prueba. Nada sale solo la primera vez: lo automático arranca únicamente cuando una persona lo ha aprobado.
- No uses listas compradas, alquiladas o sacadas de webs y redes sociales.
- No mezcles fines. El permiso para avisos de cita no vale para ofertas.
- No ocultes quién escribe ni cambies de número o de remitente para esquivar bloqueos.
- No uses urgencia falsa («últimas horas») si no es verdad. Es publicidad engañosa.
- No prometas ahorros, resultados ni ventas.
- No mandes por campaña masiva mensajes sobre deudas, salud o situaciones personales. Los atiende una persona.
- No dejes una campaña repetitiva funcionando sin tope de gasto ni vigilancia.
- No uses herramientas que imitan WhatsApp Web para envíos masivos. Pueden bloquear el número.

## Qué revisa una persona antes de lanzar

- Los permisos, la base legal y la prueba de cada permiso. Las sanciones por mensajes comerciales sin permiso existen y pueden ser serias [consulta con un abogado o con el delegado de protección de datos].
- Los textos: quién escribe, que la oferta sea verdadera y que lleve la baja.
- El presupuesto, el tope y los horarios.
- El tratamiento de datos personales (RGPD) y los contratos con los proveedores de envío.

## Dónde se guarda

Guarda este texto como SKILL.md en la carpeta .claude/skills/campanas-sms-whatsapp-por-segmentos/ de tu proyecto.
