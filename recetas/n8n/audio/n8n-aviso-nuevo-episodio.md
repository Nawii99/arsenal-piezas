# Aviso y borrador de redes cuando publicas episodio…

**Tipo:** Receta de automatización · **Área:** Música y audio · **Licencia:** CC BY 4.0

Cada episodio que publicas, recibe por Telegram un borrador de post para redes. Tú lo revisas y publicas donde quieras.

## Qué es y qué hace

Automatización de n8n que vigila el feed RSS de tu podcast y, al detectar un episodio nuevo, pide a una IA de texto (Claude, Codex, Gemini o una IA local) un borrador de publicación para redes y te lo envía por Telegram. Tú revisas el texto y lo publicas a mano. Usa RSS Feed Trigger, Edit Fields, un nodo de IA y un bot de Telegram; cuesta céntimos por episodio.

## Cómo usarla

1. Crea el bot de Telegram y guarda el token
2. Pega la URL del RSS en el primer nodo
3. Prueba con un episodio
4. Revisa cada borrador antes de publicarlo

## Cuándo usarla

Publicas un episodio y siempre se te queda pendiente escribir el post para redes. Aquí te llega el borrador por Telegram en cuanto sale.

## Cómo ganar dinero con ella

Instálalo a podcasters o agencias pequeñas como automatización de promoción, con una cuota de montaje y otra de mantenimiento [TU PRECIO].

- Instalación de avisos automáticos para podcasters que olvidan promocionar cada episodio.
- Mantenimiento mensual de la automatización de promoción para agencias pequeñas de contenido.
- Automatización de promoción para negocios con podcast, con borradores que aprueba su equipo.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Qué hace: cada vez que publicas un episodio, detecta la novedad en el RSS de tu podcast, le pide a Claude un borrador de publicación para redes y te lo envía por Telegram. Tú lo revisas y lo publicas a mano donde quieras.

Cuentas que necesitas:
- n8n (el plan de pago tiene prueba gratuita; si lo instalas tú en un servidor, es gratis pero más lioso para empezar).
- API de Anthropic (de pago por uso; un borrador de texto por episodio cuesta céntimos).
- Telegram (gratis). Crea un bot con @BotFather y guarda el token.
- La URL del RSS de tu podcast: en Spotify for Creators, Ajustes > Distribución.

Nodos, en orden:

1. RSS Feed Trigger (disparador). URL: la del RSS de tu podcast. Intervalo: cada hora sobra; un podcast no publica más a menudo. Este nodo solo se dispara con elementos nuevos, así que no repite episodios ya avisados.

2. Edit Fields (Set). Crea dos campos limpios a partir del elemento del RSS: titulo (desde title) y descripcion (desde contentSnippet o content, según traiga tu feed). Así el siguiente nodo recibe solo lo necesario.

3. Anthropic (o HTTP Request a la API de Anthropic si no te aparece el nodo). Modelo: uno barato tipo Haiku vale de sobra. Prompt del mensaje: "Escribe una publicación para LinkedIn y otra para X anunciando este episodio de podcast. Español de España, tuteando, sin superlativos ni emojis. Máximo 3 párrafos la de LinkedIn y 280 caracteres la de X. No inventes nada que no esté en la descripción. Título: {{ $json.titulo }}. Descripción: {{ $json.descripcion }}".

4. Telegram (Send Message). Chat ID: el tuyo (escríbele a tu bot y consulta tu ID con @userinfobot). Texto: el borrador que devuelve Claude más una línea fija al final: "Revisar antes de publicar".

Aviso importante: la receta termina en Telegram a propósito. No conectes la publicación automática a LinkedIn: LinkedIn restringe la automatización no oficial y puede costarte limitaciones en la cuenta. Copiar y pegar tú el texto te lleva un minuto y no arriesgas nada.

Cómo probarla sin liarte:
1. Deja el flujo desactivado y usa el botón de ejecutar el disparador manualmente (Fetch Test Event): el nodo RSS traerá tu último episodio ya publicado y podrás ver el flujo entero con datos reales.
2. Comprueba que el mensaje llega a tu Telegram y que el texto no inventa nada.
3. Cuando el resultado te convenza, activa el flujo. El próximo episodio real disparará el aviso solo.
