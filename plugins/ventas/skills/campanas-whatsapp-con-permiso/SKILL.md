---
name: campanas-whatsapp-con-permiso
description: Prepara campañas de WhatsApp Business para muchos contactos (permiso, segmentos, plantillas, envío por lotes y medición) con Wati u otra plataforma oficial. Úsala cuando vayas a avisar o vender por WhatsApp a una lista.
---

# Campañas de WhatsApp con permiso y plantillas aprobadas

Esta skill prepara una campaña de WhatsApp Business: a quién se escribe, qué se dice, cuándo y cómo se mide. Está pensada para plataformas con acceso oficial a la API de WhatsApp Business, como Wati. Claude prepara y revisa. Quien pulsa «enviar» eres tú.

Cuando algo lo haces tú, pone «tú». Las órdenes sin sujeto son para Claude. Revisada en octubre de 2026: Meta cambia tarifas y condiciones con frecuencia, así que comprueba siempre lo vigente.

## Lo que tienes que saber antes de empezar

- WhatsApp no es un email. Si la persona no te ha escrito en las últimas 24 horas, solo puedes iniciar la conversación con una plantilla que Meta haya aprobado.
- Las plantillas tienen categoría (marketing, utilidad, autenticación). Meta puede reclasificar una plantilla si la categoría no encaja con lo que dice el texto.
- Meta cobra por cada mensaje de plantilla enviado. La tarifa depende de la categoría y del país. Míralo en [TARIFA VIGENTE DE META] y suma la cuota de tu plataforma: [CUOTA DE LA PLATAFORMA].
- Meta vigila la calidad de tu número. Si muchas personas te bloquean o te denuncian, bajan tus límites de envío y puedes perder el número.
- Meta exige que la persona haya aceptado recibir mensajes tuyos por WhatsApp. En España, además, la LSSI (art. 21) y el RGPD regulan la publicidad por medios electrónicos: permiso previo, información clara y baja sencilla.

## Antes de empezar, pregunta

No empieces sin respuesta a las preguntas 1 a 3.

1. ¿Qué quieres conseguir con esta campaña? Una sola cosa: una venta, una cita, recuperar clientes que no compran desde hace tiempo, o un aviso.
2. ¿Qué plataforma usas y tu número ya está verificado con Meta?
3. ¿De dónde salen los contactos? Pide el formulario, la casilla o el texto exacto con el que aceptaron recibir WhatsApp, y la fecha.
4. ¿Cuántos contactos hay y cuántos mensajes al día permite hoy tu número? Se ve en el panel de Meta o de la plataforma.
5. ¿Qué oferta real hay? Precio, fechas, condiciones y stock. Si falta algo, deja [DATO A CONFIRMAR] y no lo inventes.
6. ¿Quién contestará cuando la gente responda y en qué horario?
7. ¿En qué idioma y con qué tono hablas con tus clientes?

## Paso a paso

1. Clasifica los contactos en dos grupos. Grupo A: tienen un permiso claro y demostrable para recibir WhatsApp tuyos. Grupo B: todo lo demás (compradores sin casilla de WhatsApp, listas de email, contactos de eventos, listas compradas). El grupo B no recibe marketing. Si quieres, se le puede pedir permiso por un canal donde sí puedas escribirle.
2. Decide el tipo de mensaje. Un aviso de pedido o de cita es de utilidad. Una oferta es marketing. Si quieres decir las dos cosas, haz dos mensajes. No disfraces una oferta de aviso: Meta puede rechazar la plantilla o cobrarla como marketing.
3. Segmenta en dos o tres grupos como máximo, cada uno con una razón clara. Por ejemplo: compraron en los últimos [MESES] meses, o preguntaron por un producto concreto. Apunta el criterio y cuántos contactos hay en cada uno.
4. Redacta la plantilla. Primera línea: quién eres. Una sola idea y una sola acción (un botón de respuesta rápida o un enlace). Variables como {{1}} solo para datos reales, como el nombre. Incluye cómo darse de baja, por ejemplo un botón «No quiero más mensajes». Escribe dos variantes por segmento.
5. Prepara qué pasa cuando contestan. Escribe las cinco respuestas más probables (me interesa, cuánto cuesta, no gracias, BAJA, una pregunta rara) y qué hace la plataforma con cada una: respuesta automática, aviso a una persona o etiqueta. La baja se aplica en el acto y el contacto queda fuera de todas las campañas futuras.
6. Calcula el coste máximo: contactos por la tarifa del mensaje de esa categoría. Deja la fórmula escrita y pide la tarifa real. No la saques de memoria.
7. Prueba. Tú envías primero a tres o cinco números de tu equipo, con su permiso. Claude te dice qué mirar en el móvil: variables, enlaces, botones y hora de llegada.
8. Lanza por lotes. Tú envías primero un lote pequeño de un segmento. Espera 24 o 48 horas y mira entregas, bloqueos y bajas. Si todo va bien, sigues con el resto. Si hay muchos bloqueos, paras.
9. Mide a los 7 días: entregados, leídos, respuestas, bajas, bloqueos y ventas (con un código o un enlace propio de la campaña). Anota qué cambiarías.

## Qué devolver

Un documento en Markdown con estas secciones, en este orden:

1. Resumen: objetivo, plataforma, contactos en el grupo A y en el B.
2. Tabla de segmentos: nombre | criterio | contactos | mensaje que recibe.
3. Plantillas listas para pegar: nombre interno, categoría propuesta, idioma, texto con variables y botones.
4. Mapa de respuestas: si la persona dice X, pasa Y.
5. Calendario de envío por lotes, con fecha y hora.
6. Coste estimado con la fórmula y los datos que faltan.
7. Lista de comprobación antes de enviar, con casillas.
8. Plantilla del informe a los 7 días.

## Qué NO hacer

- No envíes nada. Si Claude Code tiene una conexión con la plataforma, úsala solo para leer plantillas y estadísticas. Enviar lo haces tú, con un lote que hayas visto antes.
- No uses listas compradas, alquiladas ni contactos sacados de webs, grupos o redes sociales.
- No uses programas que automatizan la app normal de WhatsApp sin la API oficial. Meta bloquea esos números y puede que no los recuperes.
- No uses un segundo número para saltarte una restricción de Meta.
- No inventes escasez («solo hoy», «últimas unidades») ni ofertas que no existan. Es publicidad engañosa.
- No pidas ni trates por mensaje automático datos de salud, ideología o datos bancarios.
- No dejes al contacto sin salida: siempre debe poder hablar con una persona y darse de baja.
- Si contesta una IA, que la persona lo sepa. La normativa europea de IA regula este aviso. Pregunta a tu asesor desde qué fecha te aplica.
- No prometas cifras de ventas ni de conversión. Lo que dé la campaña es lo que midas tú.

## Qué revisa una persona antes de enviar

- Tú, o quien responda del negocio: el texto de cada plantilla, la oferta, la lista final de destinatarios y el coste.
- Un gestor o un abogado, si hay dudas sobre el permiso de la lista. La Agencia Española de Protección de Datos aplica la LSSI y el RGPD y puede sancionar.
- Si lo haces para un cliente, eres encargado del tratamiento de sus contactos. Necesitas un contrato por escrito (art. 28 del RGPD) y las cuentas de Meta y de la plataforma a nombre del cliente.
- Segunda opinión: pide a Claude Code que repase el plan como un revisor desconfiado (puede hacerlo con un subagente) y que liste dudas. No sustituye a la persona.
