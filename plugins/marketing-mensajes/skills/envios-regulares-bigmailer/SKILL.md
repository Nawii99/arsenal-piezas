---
name: envios-regulares-bigmailer
description: "Planifica newsletters y promociones periódicas de una marca en BigMailer: revisa la lista, la personalización y el ritmo de envío, lo deja en borrador y pide tu confirmación antes de cada tanda. Úsala cuando vayas a escribir a muchos contactos de forma repetida."
---
# Envíos regulares por marca en BigMailer
## Qué hace
Ordena los envíos periódicos cuando hay muchos contactos. Se centra en lo que falla con volumen: listas sucias, campos vacíos, envíos de golpe, rebotes y quejas.
Trabaja por marca: una marca o un cliente, una lista, un remitente. Si llevas varios clientes, sus contactos nunca se mezclan.
No se conecta sola a BigMailer. Comprueba si hay un conector (MCP) o un flujo de n8n con tu cuenta. Si no, modo manual: te da el plan y los textos, y los cargas tú en el panel.
## Pregunta antes de empezar (todo junto)
- Marca o cliente, qué vende y a quién escribe.
- Tamaño de la lista y cada cuánto se envía.
- Cuándo fue el último envío. Si el dominio lleva meses sin enviar, cambia el plan.
- Cómo salen los correos: mira en tu cuenta qué servicio de envío hay detrás (por ejemplo, tu propia cuenta de Amazon SES). Si es tuya, los rebotes y las quejas cuentan contra tu cuenta.
- Campos que tiene la lista (nombre, ciudad, última compra) y cuáles vienen vacíos a menudo.
- Origen y permiso de los contactos.
- Contenido del envío y qué fechas y condiciones son reales.
## Paso a paso
1. Foto de la lista: total, duplicados, campos vacíos y contactos sin actividad en los últimos [MESES SIN ACTIVIDAD] meses.
2. Segmenta por actividad: recientes y antiguos. Los inactivos no se borran. Se propone un correo de reenganche y, con tu permiso, se apartan los que no respondan.
3. Plan por tandas. Si el dominio es nuevo o lleva meses parado, empieza por los contactos más activos y sube poco a poco: [TAMAÑO DE CADA TANDA]. Si suben rebotes o quejas, se para.
4. Personalización: cada campo con valor de reserva. «Hola» a secas es mejor que «Hola ,». Prueba con cinco contactos reales, uno de ellos con campos vacíos.
5. Enlaces con etiquetas UTM (texto al final del enlace que dice de qué campaña viene la visita) para medir en tu analítica.
6. Pie legal con enlace de baja que funciona.
7. Borrador, envío de prueba a dos buzones de proveedores distintos y revisión en el móvil.
8. Confirmación literal por cada tanda: ENVIAR «campaña», tanda N, N contactos, DD/MM. Sin esa frase, no envía.
9. Tras cada tanda, mira rebotes, bajas y quejas antes de pasar a la siguiente.
## Umbrales
- Quejas por spam: Gmail pide mantenerlas por debajo del 0,1 % y no llegar al 0,3 %. Confírmalo en sus guías para remitentes.
- Rebotes: el límite lo marca tu servicio de envío. Mira sus umbrales y apunta aquí el tuyo: [LÍMITE DE REBOTES].
- Si superas alguno, se pausa el envío y se avisa a una persona.
## Qué devuelve
- Foto de la lista en tabla.
- Plan de tandas en tabla: tanda, segmento, número de contactos, fecha y condición para seguir.
- Correo con campos de reserva y etiquetas UTM.
- Lista de comprobación: permiso, bajas y rebotes fuera, baja probada, remitente autenticado (SPF, DKIM y DMARC) y número esperado.
- Informe por tanda y final: entregados, rebotes, bajas, quejas, clics y resultado frente al objetivo. Las aperturas valen poco como medida porque Apple Mail las infla.
## Qué NO hacer
- No envíes a toda la lista de golpe después de un parón.
- No mezcles contactos de marcas o clientes distintos.
- No escribas de nuevo a quien se dio de baja, rebotó o se quejó.
- No uses listas compradas ni sacadas de webs.
- No borres contactos, listas ni campañas. Propón y espera.
- No segmentes con datos sensibles (salud, religión, ideología).
- No pegues claves de acceso en el chat. Van en el conector o en n8n.
- No midas el éxito solo por aperturas.
- Medir aperturas y clics es tratar datos personales: debe constar en tu política de privacidad.
- El coste depende de tu plan en BigMailer y de lo que cobre el servicio de envío. Mira ambos antes de un envío grande: [TU TARIFA ACTUAL].
## Qué revisa una persona antes de usar el resultado
- El texto final, el pie legal y que la baja funciona.
- Que cada contacto dio permiso y de dónde salió.
- El plan de tandas, los umbrales y el número de destinatarios.
- Si gestionas la lista de un cliente, hace falta un contrato de encargado del tratamiento (RGPD). Dudas legales: tu gestor o un abogado.
Instalación: guarda este texto como .claude/skills/envios-regulares-bigmailer/SKILL.md dentro de tu carpeta de trabajo.
