---
name: campanas-benchmark-con-revision
description: Prepara campañas, boletines y secuencias de email en Benchmark Email como borrador, revisa permiso, baja y textos, y no envía nada sin tu confirmación escrita. Úsala cuando pidas una campaña, un boletín o un aviso por email con Benchmark.
---
# Campañas de Benchmark Email con revisión antes de enviar
## Qué hace
Te deja una campaña de email lista para revisar: segmento, asunto, texto, pie legal y comprobaciones. Siempre como borrador. El envío lo decide una persona.
No se conecta sola a Benchmark. Al empezar mira si hay un conector (MCP) o un flujo de n8n ya enlazado a tu cuenta. Si no lo hay, trabaja en modo manual: te da textos y ajustes para pegar tú en el panel, y te lo dice.
## Pregunta antes de empezar (todo junto, en un solo mensaje)
- Objetivo de la campaña. Solo uno: avisar, vender, recuperar clientes o informar.
- A quién va: qué lista o segmento, cuántos contactos y de dónde salieron.
- Cómo dieron permiso: casilla en un formulario, compra previa u otra vía. Si no lo sabes, dilo.
- Quién firma: nombre, correo de respuesta y dirección postal del negocio.
- Qué ofreces y qué fechas y condiciones son reales. No se inventan plazos ni descuentos.
- Cuándo quieres que salga y qué cuenta como éxito: clics, reservas, ventas.
- Si hay conexión con Benchmark o trabajas en modo manual.
## Paso a paso
1. Con conexión, empieza en solo lectura: mira listas, plantillas y campañas anteriores. Sin conexión, modo manual.
2. Revisa la lista antes de escribir: total, duplicados y direcciones con pinta de error. Si hay contactos sin permiso claro, para y avisa. Esos no entran.
3. Excluye a quien se dio de baja y a quien rebotó. Si no ves esas listas, pídelas.
4. Redacta tres asuntos distintos, cortos y sin prometer lo que el correo no cumple. Añade el preheader (la frase gris que se ve junto al asunto). Cuerpo breve con una sola acción principal.
5. Añade el pie obligatorio: quién envía, por qué recibe el correo, dirección del negocio y un enlace de baja que funcione.
6. Deja la campaña en BORRADOR (o la ficha para pegarla a mano en el panel).
7. Haz un envío de prueba a tu correo y a otro de otro proveedor, por ejemplo Gmail y Outlook. Míralo en el móvil: botón, imágenes, enlaces y baja.
8. Pasa la lista de comprobación de abajo y enseña el resultado.
9. Pide confirmación literal: ENVIAR «nombre de la campaña» a N contactos el DD/MM. Solo con esa frase programa o envía. Con cualquier otra respuesta, no envía.
10. A las 48 horas, informe: enviados, entregados, rebotes, bajas, quejas y clics frente al objetivo. Las aperturas valen poco como medida porque Apple Mail las infla. Mira clics y resultados.
## Lista de comprobación
- Permiso: cada contacto tiene base legal. En España, la publicidad por email exige consentimiento previo, o ser cliente y recibir algo parecido a lo que compró, con baja fácil (LSSI). Vale también si vendes a empresas.
- Bajas y rebotes fuera de la lista.
- Enlace de baja visible, probado y que funciona.
- Dominio del remitente autenticado con SPF, DKIM y DMARC: tres ajustes que prueban que el correo es tuyo. Gmail y Yahoo los piden a quien envía mucho. Si no sabes si los tienes, pregunta a quien lleva tu web.
- Precios con IVA si vendes a particulares. Fechas y condiciones reales.
- Cada enlace probado. Número de destinatarios igual al esperado.
## Qué devuelve
Un solo documento con este orden: resumen de la campaña, segmento y número de contactos, tres asuntos, preheader, texto del correo, pie legal, tabla de comprobación (OK, FALTA o NO SE PUEDE COMPROBAR) y lista de lo que debe mirar una persona.
## Qué NO hacer
- No envíes ni programes nada sin la frase de confirmación completa.
- No importes listas compradas, alquiladas o sacadas de webs, redes o tarjetas de visita sin permiso.
- No quites ni escondas el enlace de baja.
- No inventes descuentos, plazos, escasez ni testimonios.
- No borres contactos, listas ni campañas. Propón y espera.
- No segmentes por salud, religión, ideología u otros datos sensibles.
- No pegues claves de acceso en el chat. Van en el conector o en las credenciales de n8n.
- No prometas aperturas, clics ni ventas.
- Más contactos puede subir la cuota de tu plan en Benchmark. Mira el precio antes de importar: [PRECIO DE TU PLAN].
- Si algo no se puede comprobar, escribe NO COMPROBADO. No lo des por bueno.
## Qué revisa una persona antes de usar el resultado
- El texto final, palabra por palabra, y el pie legal.
- La lista: de dónde sale y que cada contacto dio permiso.
- El número de destinatarios y la fecha de envío.
- Si llevas la lista de un cliente, vosotros dos necesitáis un contrato de encargado del tratamiento (RGPD). Dudas legales: tu gestor, un abogado o tu delegado de protección de datos.
Instalación: guarda este texto como .claude/skills/campanas-benchmark-con-revision/SKILL.md dentro de tu carpeta de trabajo.
