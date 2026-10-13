---
name: enlaces-cortos-seguimiento-por-canal
description: Prepara y ordena enlaces cortos de Cutt.ly con etiquetas UTM para saber qué canal trae clics. Úsala cuando vayas a compartir enlaces en redes, emails, carteles o anuncios y quieras medirlos.
---

# Enlaces cortos con seguimiento por canal

## Qué hace
Ordena los enlaces de una campaña: un enlace por canal, con nombre claro y etiquetas UTM, para poder comparar de dónde vienen los clics. Si Cutt.ly está conectado (conector MCP, Composio o n8n), crea los enlaces cortos. Si no, entrega una tabla lista para pegar.
Mide clics, no ventas. Un clic no es un cliente. Dilo siempre en el informe.

## Antes de empezar, pregunta
- ¿Cuál es la campaña y qué fechas tiene?
- ¿A qué páginas apuntan los enlaces? Pide las direcciones completas, con https.
- ¿En qué canales se van a poner? Por ejemplo: biografía de Instagram, stories, newsletter, WhatsApp, cartel con QR, anuncio.
- ¿Hay Cutt.ly conectado a Claude, o trabajamos con una tabla que luego pega la persona?
- ¿Qué plan de Cutt.ly tiene? Límite de enlaces y de clics visibles: [LÍMITE DEL PLAN]. Si no lo sabe, que lo mire en su cuenta antes de crear nada.
- ¿Tiene dominio propio para los enlaces? Si no, llevarán el dominio público de Cutt.ly.
- ¿Dónde mirará luego las visitas y las ventas? Google Analytics 4, otra herramienta o solo Cutt.ly.
- ¿Algún enlace va a imprimirse (cartel, flyer, tarjeta, QR)?

## Paso a paso
1. Escribe una regla de nombres y enséñala antes de crear nada. Todo en minúsculas, sin tildes, sin espacios, con guiones. Ejemplo: utm_source=instagram, utm_medium=bio, utm_campaign=rebajas-octubre-2026.
2. Monta la dirección larga de cada canal: destino, un signo ? y las etiquetas unidas con &. Si el destino ya lleva un ?, añade las etiquetas con &.
3. Si puedes visitar las páginas, comprueba que cada destino abre y no da error 404. Marca los que fallen y no crees su enlace corto.
4. Propón un alias legible para cada enlace, como /rebajas-ig. Evita nombres que parezcan otra marca.
5. Enseña la tabla completa y espera el OK de la persona. Solo después crea los enlaces, empezando por uno de prueba.
6. Si no hay conector, entrega la tabla en formato CSV para pegar en Cutt.ly o en una hoja de cálculo.
7. Cuando pase la campaña, lee los clics por enlace (con el conector o con los datos que pegue la persona) y haz el informe.

## Qué devolver
- Una tabla con las columnas: Campaña | Canal | Dirección final con etiquetas | Enlace corto | Alias | Estado (creado, pendiente o error).
- Después, el informe: clics por canal de más a menos, qué canal parece funcionar mejor y qué no se puede concluir. Máximo tres conclusiones, una frase cada una.
- Si hay pocos clics por enlace (por debajo de [UMBRAL MÍNIMO]), di claramente que son pocos para decidir nada.
- Una línea final con lo que no mide este informe: ventas, calidad de los visitantes, gente que vio el anuncio y no hizo clic.

## Límites de los datos
- Los clics se inflan. Las vistas previas de WhatsApp, Telegram o Slack, y los robots, pueden contar como clic.
- Para unir clics con ventas hace falta que la web lo mida (Google Analytics 4 u otra herramienta). Si no, no inventes la conversión.

## Qué NO hacer
- No crees, borres ni cambies enlaces sin el OK de la persona. Un enlace publicado puede estar ya en cientos de sitios.
- No cambies el destino de un enlace que ya circula sin avisar de qué cambia y por qué.
- No acortes enlaces para esconder el destino ni para engañar. Si el enlace es de afiliado o patrocinado, el texto de al lado debe decirlo.
- No uses el dominio público de un acortador en impresos ni QR que vayan a durar años. Si se cierra la cuenta o no se paga el plan, dejan de funcionar. Para impresos, usa dominio propio o una dirección de tu web que redirija.
- No lo uses en emails masivos o fríos con el dominio compartido: los filtros de spam desconfían. Con dominio propio, mejor.
- No metas datos personales (nombre, email, teléfono de un cliente) dentro de las etiquetas o del alias. Quedan guardados en los informes y en las direcciones.
- No superes el límite del plan sin avisar: pueden cobrar o cortar el servicio.
- No saques conclusiones con pocas visitas.
- No pegues claves de API en el chat. Van en la configuración del conector.

## Cuándo pedir a una persona
- Si tu web usa cookies o píxeles de medición, el aviso y el consentimiento los revisa quien lleve tu web o tu asesor de protección de datos.
- Los acortadores guardan datos de cada clic (país, dispositivo, de dónde viene). Confirma con quien lleve tu privacidad que tu política de privacidad lo recoge.

## Instalación (para ti, no para Claude)
Guarda este texto como SKILL.md dentro de una carpeta con el nombre de arriba, en .claude/skills/ de tu proyecto, o en ~/.claude/skills/ para usarlo en todos tus proyectos. Claude la usa cuando lo que pidas encaja con la descripción, y también puedes nombrarla.
