# Del RSS del podcast al borrador de promoción…

**Tipo:** Receta de automatización · **Área:** Música y audio · **Licencia:** CC BY 4.0

Receta de n8n que, al publicar un episodio nuevo en tu alojamiento, genera la descripción para YouTube y tres posts de promoción con una IA de texto (Claude, Codex, Gemini o una IA local) y los guarda en un Google Doc.

## Qué es y qué hace

Receta de n8n que, al publicar un episodio nuevo en tu alojamiento, genera la descripción para YouTube y tres posts de promoción con una IA de texto (Claude, Codex, Gemini o una IA local) y los guarda en un Google Doc. Tiene un nodo RSS Feed Trigger, un nodo de IA y un nodo de Google Docs. El texto lo revisa una persona antes de publicarlo.

## Cómo usarla

1. Pega la URL del RSS del podcast en el disparador
2. Conecta la IA y tu cuenta de Google Docs
3. Prueba con un episodio antiguo
4. Revisa el documento antes de pegar el texto

## Cuándo usarla

Publicas el episodio en tu alojamiento y quieres encontrar en un Google Doc la descripción para YouTube y tres posts de promoción, listos para revisar y pegar.

## Cómo ganar dinero con ella

Móntala para podcasters o negocios con podcast como servicio de promoción automática: instalación más mantenimiento [TU PRECIO]. Cada texto lo revisa una persona antes de publicarlo.

- Instalación de promoción automática para podcasts de empresa que no tienen equipo de redes.
- Mantenimiento mensual de la receta para agencias que gestionan varios podcasts de clientes.
- Documento de promoción por episodio para creadores que publican cada semana.

**Precio orientativo:** 120–250 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Qué resuelve: publicas el episodio en tu alojamiento (Spotify for Creators, Ivoox o el que uses) y a los pocos minutos tienes en un Google Doc la descripción para YouTube y 3 posts de promoción, listos para revisar y pegar. Te quita la media hora de redacción de cada estreno.

Cuentas necesarias y su coste:
- n8n: autoalojado es gratis; n8n Cloud es de pago tras la prueba, mira su precio actual antes de decidir.
- Anthropic API (u OpenAI): de pago por uso. Un episodio suele costar céntimos, pero pon un límite de gasto en el panel de la API el primer día.
- Google (Docs) y Telegram: gratis.

Nodos, en este orden:
1. RSS Feed Trigger. Pega la URL del feed RSS de tu podcast (la encuentras en los ajustes de tu alojamiento). Este nodo comprueba el feed cada cierto tiempo y se dispara solo con entradas nuevas; ponlo a revisar cada 30 minutos.
2. Nodo Anthropic (o OpenAI) - Message. En el mensaje, pásale el título y la descripción del episodio que llegan del feed (los insertas con los campos {{ }} que n8n te ofrece al arrastrar). Pídele: descripción para YouTube con gancho en la primera línea, un post para LinkedIn en tono personal y dos textos cortos para redes, todo en español de España y sin superlativos. Aclárale en el propio mensaje que no invente datos que no estén en la descripción.
3. Google Docs - Create. Crea un documento llamado con el título del episodio y la fecha, dentro de una carpeta Promo podcast, con la respuesta del nodo anterior como contenido.
4. Telegram - Send Message. Crea antes un bot con @BotFather en Telegram (gratis, dos minutos) y usa su token como credencial. El mensaje: Episodio nuevo detectado, borrador listo, con el enlace al Google Doc.

Aviso importante: esto genera borradores, no publica. No conectes la salida directamente a LinkedIn ni a ninguna red para publicar sola; además de publicar errores sin revisar, automatizar publicaciones y mensajes en LinkedIn va contra sus condiciones y puede costarte la cuenta. Publica tú a mano desde el Doc.
El audio en sí lo sigues subiendo tú: el alojamiento lo distribuye a Spotify por el propio RSS, y a YouTube lo subes a mano (o activas en YouTube Studio la ingesta por RSS si tu alojamiento lo soporta).

Cómo probarla sin liarla:
1. Antes de activar el flujo, abre el nodo RSS Feed Trigger y usa Fetch Test Event: te traerá el último episodio ya publicado sin esperar a uno nuevo.
2. Ejecuta el flujo entero con ese evento de prueba y revisa el Doc que crea. Ajusta el mensaje al modelo hasta que el texto salga a tu gusto.
3. Solo entonces pulsa Active. Con el siguiente episodio real, comprueba que solo llega un aviso; si llegan repetidos, revisa que el feed no cambie las fechas de los episodios viejos.
4. Deja el límite de gasto de la API puesto: si el feed diera problemas y el flujo se disparara en bucle, el coste queda acotado.
