---
name: chatbot-web-botpress-con-limites
description: Diseña, prueba y publica de forma controlada un chatbot de atención para tu web con Botpress: qué responde, qué no, cuándo pasa a una persona y qué hace con los datos. Úsala cuando quieras montar o revisar un asistente de web, o cuando un bot ya publicado dé respuestas dudosas.
---
# Chatbot web con Botpress y reglas claras
## Qué hace
Prepara lo que un chatbot necesita antes de tocarlo: alcance, base de respuestas verificadas, instrucciones del bot, paso a una persona, captación de contactos con permiso y un guion de pruebas.
No construye dentro de Botpress por su cuenta. Si hay un conector (MCP) o un flujo de n8n con permiso, puede cargar contenidos como borrador. Si no, te da textos y ajustes listos para pegar en el panel. Mira en tu cuenta qué canales y qué modelos de IA incluye tu plan.
## Pregunta antes de empezar (todo junto)
- Qué negocio es y para qué quieres el bot: dudas frecuentes, reservas o captar contactos.
- Dónde irá: solo la web u otros canales.
- Horario en que atiende una persona y a quién se deriva (correo, teléfono, WhatsApp o formulario).
- Documentos que mandan: web, preguntas frecuentes, condiciones, política de devoluciones, tarifas. Con su fecha.
- Cosas que el bot nunca debe prometer ni decir.
- Idiomas.
- Qué datos recogerá, si recoge alguno.
## Paso a paso
1. Alcance: de 5 a 10 temas que SÍ atiende y una lista de lo que NO (precios a medida, reclamaciones, reembolsos, salud, temas legales).
2. Base de respuestas: 20 preguntas frecuentes con respuesta sacada solo de tus documentos y con la fuente al lado. Avisa si dos documentos se contradicen.
3. Instrucciones del bot, en español: papel, tono, límites y qué hacer cuando no sabe («no lo tengo claro, te paso con una persona»).
4. Primer mensaje: dice que es un asistente automático, no una persona, y enlaza la política de privacidad.
5. Paso a una persona cuando: lo pida el cliente, haya enfado, se hable de pagos, reclamaciones o datos personales, el tema esté fuera del alcance, o el bot falle dos veces seguidas. Debe ser fácil y dar un plazo de respuesta real.
6. Captación de contactos: pide lo mínimo y con casilla de permiso sin marcar.
7. Guion de 30 pruebas, con las difíciles: pedir un descuento, pedir un precio que no existe, quejas, insultos, preguntas médicas o legales, cambios de idioma e intentos de que el bot se salte sus reglas. Se anota qué responde y si pasa o falla.
8. Regla de publicación: no se publica con ningún fallo grave (inventar un precio, plazo o política, o dar un consejo médico o legal).
9. Fase piloto de [SEMANAS DE PILOTO] semanas, con una persona leyendo las conversaciones cada día.
10. Revisión semanal: preguntas sin respuesta, derivaciones, quejas y gasto.
11. Coste: si tu plan cobra por el uso de IA, pon un límite o una alerta de gasto en el panel antes de publicar. Un bot abierto en una web puede recibir mucho tráfico o abusos. Límite elegido: [LÍMITE DE GASTO].
## Qué devuelve
- Ficha del bot en tabla: alcance, fuera de alcance, canales y derivación.
- Las 20 respuestas con su fuente.
- Instrucciones del bot, listas para pegar.
- Primer mensaje y texto del permiso.
- Guion de 30 pruebas en tabla: pregunta, respuesta esperada y resultado.
- Lista de comprobación para publicar.
- Qué mirar cada semana.
## Qué NO hacer
- No dejes que el bot invente precios, plazos, descuentos ni políticas. Lo que no está en la base, no se contesta.
- No lo presentes como una persona.
- No le pidas DNI, tarjeta, contraseñas ni datos de salud.
- No le dejes aceptar reclamaciones, reembolsos ni contratos.
- No lo publiques sin pruebas ni sin alguien que lea las conversaciones al principio.
- No uses conversaciones de clientes para mejorarlo sin haberlos informado.
- Mira dónde guarda las conversaciones tu proveedor y qué contrato de tratamiento de datos tienes con él.
- No pegues claves de acceso en el chat. Van en el conector o en n8n.
## Qué revisa una persona antes de usar el resultado
- Cada respuesta de la base, contra el documento original.
- Los fallos del guion de pruebas, uno a uno.
- El texto de privacidad y el de permiso: tu gestor, un abogado o tu delegado de protección de datos.
- Las primeras conversaciones reales del piloto.
- Quién responde en tu empresa cuando el bot pasa un caso a una persona.
Instalación: guarda este texto como .claude/skills/chatbot-web-botpress-con-limites/SKILL.md dentro de tu carpeta de trabajo.
