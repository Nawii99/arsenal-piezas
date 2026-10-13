---
name: primer-contacto-email-empresas
description: Prepara una campaña corta de primer contacto por email a empresas (ficha, lista justificada, secuencia de 3 o 4 mensajes y prueba de envío) y la carga pausada en Emelia. Úsala solo cuando tengas un motivo real para escribir a cada empresa y hayas confirmado con un asesor que puedes hacerlo.
---

# Primer contacto por email a empresas, con cautela

## Qué hace
Prepara una campaña pequeña y cuidada de email a empresas con las que no has hablado antes. Define a quién, por qué ahora y de dónde sale cada contacto, y escribe una secuencia corta. Si Emelia está conectada, la deja cargada y en pausa. Lanzarla lo hace la persona.

## Riesgos que conviene tener claros antes de empezar
- Legal: en España el email comercial a quien no lo ha pedido está restringido por la LSSI, y los datos personales se rigen por el RGPD y la LOPDGDD. Escribir al correo profesional de alguien con un motivo relacionado con su cargo suele apoyarse en el interés legítimo, pero eso no te libra del resto de obligaciones y cada caso se discute. Hay sanciones. Esto es orientación, no asesoramiento: lo confirma un abogado o un delegado de protección de datos.
- Reputación: si te marcan como spam, tu dominio puede acabar en listas negras y ni los correos normales de tu negocio llegarán. Google pide mantener las quejas de spam por debajo del 0,10 % y no llegar nunca al 0,30 %.
- Cuenta: la herramienta puede suspenderte si envías mal o recibes quejas.
- LinkedIn: esta pieza es solo email. No automatices mensajes ni conexiones de LinkedIn con herramientas externas: sus normas lo prohíben y pueden cerrarte la cuenta.

## Antes de empezar, pregunta (y para si no lo saben)
- ¿Qué vende, en una frase, y a quién le resuelve qué?
- ¿Qué tipo de empresa (sector, tamaño, zona) y qué cargo?
- ¿Qué motivo real hay para escribir a cada una? Una oferta de empleo, una web nueva, una subvención, una obra. Sin motivo, para.
- ¿De dónde ha sacado cada email y cuándo? ¿Es información pública y profesional? Si es comprada, rascada de una web o de origen dudoso, para.
- ¿Escribirá desde un dominio secundario? ¿Tiene SPF, DKIM y DMARC configurados? ¿Qué volumen diario permite su plan y su buzón: [LÍMITE]?
- Datos del pie: nombre, razón social, NIF, dirección y email de contacto.
- ¿Cómo se darán de baja? ¿Quién lee las respuestas y en cuánto tiempo?
- ¿Emelia está conectada y con qué permisos? Lo ideal es poder crear campañas pero no lanzarlas.

## Paso a paso
1. Haz la ficha de campaña: oferta, a quién, motivo para escribir, fuente de los contactos y si el asesor lo ha confirmado. Si falta la fuente o el motivo, no sigas.
2. Propón una tanda inicial pequeña, por ejemplo [30 A 50 CONTACTOS]. Es mejor probar poco y corregir.
3. Limpia la lista: duplicados, emails genéricos o dudosos, correos personales de Gmail, empresas que ya son clientes, personas que ya dijeron que no y bajas anteriores.
4. Personaliza solo con datos verificables: una frase concreta basada en algo que la empresa ha publicado, con la fuente anotada en una columna. Si no hay dato, no hay frase personalizada. Nunca inventes.
5. Escribe la secuencia, de 3 o 4 mensajes como máximo. Mensaje 1: presentación breve, motivo y una pregunta fácil de contestar. Mensaje 2, a los 3 o 4 días: algo útil, como un dato o un caso real tuyo, sin presionar. Mensaje 3, pasada una semana: recordatorio corto. Mensaje 4: cierre amable que dice que no escribirás más. Entre 60 y 120 palabras cada uno.
6. Cada mensaje dice quién eres, por qué escribes, de dónde sacaste el contacto y cómo dejar de recibir correos. Si el asesor lo pide, empieza con la palabra «publicidad». Asuntos honestos: sin «Re:» ni «Fwd:» falsos y sin simular una conversación anterior.
7. Si Emelia está conectada, crea la campaña en pausa y enseña lo creado.
8. Prueba: envía la secuencia a 2 o 3 cuentas propias (Gmail, Outlook), mira si cae en spam y revisa móvil, enlaces y baja.
9. La persona lanza la campaña. Claude no pulsa enviar.
10. Cuando lleguen respuestas, clasifícalas: interesado, ahora no, baja, contacto equivocado, respuesta automática. Para los interesados, prepara un borrador de respuesta que enviará la persona. Las bajas se anotan el mismo día en una lista de exclusión y no se vuelve a escribir a esa dirección.
11. Criterio de parada: para la campaña ante cualquier queja de spam, rebotes por encima de [UMBRAL] o aviso de la herramienta o del proveedor de correo.

## Qué devolver
- Ficha de campaña.
- Lista en tabla: Empresa | Cargo | Email | Fuente | Fecha | Frase personalizada | Estado.
- Secuencia en tabla: Nº | Día | Asunto A y B | Texto | Objetivo.
- Lista de comprobación previa: dominio, autenticación, baja, pie, prueba y visto bueno del asesor.
- Informe a los 7 días: enviados, rebotes, respuestas por tipo, bajas y quejas. Con pocos envíos los porcentajes no dicen nada: da los números reales.

## Qué NO hacer
- No compres ni rasques listas. No uses emails de origen que no puedas explicar.
- No envíes, lances ni programes nada sin el OK expreso de la persona.
- No envíes desde el dominio principal del negocio sin haberlo hablado: un dominio secundario protege al principal.
- No inventes datos de la empresa, cifras, clientes ni conversaciones anteriores.
- No sigas escribiendo a quien dice que no, pide la baja o no es la persona.
- No ocultes quién eres ni uses un nombre falso.
- No prometas resultados ni uses urgencia falsa.
- No escribas a particulares, ni a autónomos o profesionales a su correo personal, sin asesoramiento previo.
- No cargues datos sensibles (salud, ideología, religión) ni datos de menores.
- No pegues claves de API en el chat. Van en la configuración del conector.

## Cuándo pedir a una persona
- Antes de lanzar: un abogado o delegado de protección de datos revisa la base legal, el texto, el pie y la política de privacidad.
- Si el cliente vende productos regulados (salud, finanzas, juego).
- Ante cualquier queja, requerimiento o aviso de la herramienta.

## Instalación (para ti, no para Claude)
Guarda este texto como SKILL.md dentro de una carpeta con el nombre de arriba, en .claude/skills/ de tu proyecto, o en ~/.claude/skills/ para usarlo en todos tus proyectos. Deja Claude Code en el modo que pide permiso antes de usar el conector.
