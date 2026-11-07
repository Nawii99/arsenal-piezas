# Aviso y borrador de título al subir un montaje a Drive…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Automatización de n8n que avisa por Telegram con un borrador de título, descripción y hashtags cuando subes un vídeo montado a una carpeta de Drive.

## Qué es y qué hace

Automatización de n8n que vigila una carpeta de Google Drive y, cuando sube un vídeo montado, genera con IA un borrador de título, descripción y hashtags, y lo envía por Telegram al móvil para revisarlo. Entra el archivo nuevo y la carpeta; sale un mensaje con el texto propuesto. Usa Google Drive Trigger, un nodo de IA con API de pago por uso y un bot de Telegram creado con BotFather. Ejemplo: un vídeo de recetas sube y en un minuto llega el borrador. Se usa para publicar sin escribir cada texto desde cero.

## Cómo usarla

1. Crea la carpeta de vídeos listos en Drive
2. Configura el Google Drive Trigger
3. Añade el nodo de IA con tu clave y el prompt de título y hashtags
4. Envía el borrador a Telegram para revisarlo

## Cuándo usarla

Cuando subes vídeos ya montados a una carpeta de Drive y te cuesta ponerte a escribir título, descripción y hashtags. Te llega un borrador al móvil para revisarlo antes de publicar.

## Cómo ganar dinero con ella

Véndelo como servicio de publicación a creadores o pymes que graban mucho: tú montas, la automatización prepara el texto y tú lo repasas. Cobra una cuota mensual por vídeos al mes, [TU PRECIO].

- Servicio de publicación para creadores que graban mucho y no quieren escribir textos…
- Cuota mensual de borradores de publicación para pymes con varios vídeos al mes…
- Automatización de textos de publicación como parte de un paquete de edición…

**Precio orientativo:** 40–80 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Aviso automático cuando terminas un montaje

## Qué hace
Cuando subes un vídeo ya montado a una carpeta de Google Drive, la automatización genera un borrador de título, descripción y hashtags con IA, y te lo manda por Telegram al móvil para que lo revises antes de publicar.

## Cuentas necesarias
- Cuenta de Google Drive (gratis, con el límite de espacio de tu cuenta normal de Gmail).
- Cuenta de OpenAI con API key (de pago por uso; suele costar pocos céntimos por vídeo, pero no es gratis, revisa el precio actual en platform.openai.com).
- Un bot de Telegram creado con @BotFather (gratis, sin límite relevante para este uso).
- Cuenta de n8n (versión gratuita autoalojada, o la prueba gratuita temporal de n8n Cloud si aún no la has gastado).

## Nodos, en orden
1. Disparador "Google Drive Trigger": vigila una carpeta concreta, por ejemplo "vídeos listos", y se activa cuando aparece un archivo nuevo.
2. Nodo "Google Drive" (Get file): descarga el nombre y los metadatos del archivo nuevo.
3. Nodo "OpenAI" (Chat): le pasas el nombre del archivo, y si lo tienes, un resumen corto que tú mismo escribes al subir el vídeo, y le pides que devuelva un título, una descripción corta y 5 hashtags.
4. Nodo "Set": junta el título, la descripción y los hashtags en un solo mensaje de texto legible.
5. Nodo "Telegram" (Send Message): envía ese mensaje a tu chat personal con el bot.

## Cómo probarla sin liarla
1. Crea primero una carpeta de Drive de pruebas, aparte de la que uses de verdad, y apunta el disparador ahí.
2. Ejecuta el flujo de forma manual desde n8n (botón "Execute Workflow") antes de activarlo, subiendo un vídeo cualquiera de prueba a esa carpeta.
3. Revisa que el mensaje te llega bien a Telegram y que el texto generado tiene sentido antes de apuntar el disparador a tu carpeta real.
4. Esta automatización solo te avisa y te da un borrador: no publica nada por ti. La decisión y la subida final a la plataforma las haces tú a mano.
