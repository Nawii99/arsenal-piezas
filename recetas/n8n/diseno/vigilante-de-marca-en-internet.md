# Vigilante de marca en internet…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Rastrea cada día si alguien menciona tu marca, copia tu nombre o sube tu logo, resume lo encontrado con IA y te avisa solo cuando merece la pena.

## Qué es y qué hace

Cada mañana lee los avisos de Google Alerts en RSS con el nombre de tu marca y variantes, descarta lo ya visto y pide a un modelo de IA que clasifique cada aviso como mención normal, posible copia o uso indebido del logo. Te envía al móvil solo lo importante. Entran los feeds RSS y una clave de IA; sale un aviso filtrado. Para dueños de marca y diseñadores. Las decisiones sobre copias o marcas: que lo revise un profesional.

## Cómo usarla

1. Crea alertas en google.com/alerts con salida RSS
2. Pon tu clave de IA en n8n
3. Define las categorías de clasificación
4. Revisa una semana de avisos para ajustar el filtro
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tu marca ya empieza a sonar y quieres enterarte de copias, malos usos del logo o menciones sin pagar una herramienta de monitorización de 80 €/mes.

## Cómo ganar dinero con ella

Reemplaza suscripciones tipo Mention o Brand24 (50-90 €/mes). Coste: 0 € más unos céntimos al día en el resumen con IA.

- Vigilancia de marca para diseñadores que venden identidad a sus clientes…
- Monitorización de copias y usos de logo para estudios creativos con informe mensual…
- Configuración de alertas de marca para pymes que quieren evitar herramientas de pago…

**Precio orientativo:** 40–120 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Cada mañana lee los avisos de Google Alerts en formato RSS con el nombre de tu marca y variantes, descarta lo que ya viste, pide a la IA que clasifique si es una mención normal, un posible plagio o un uso indebido del logo, y te manda al móvil solo lo importante.
Para dueños de marca, estudios de diseño y artistas que venden diseño y no quieren pagar una herramienta de escucha.

**Lo que necesitas antes**
- Cuenta de Google. Entra en google.com/alerts, crea alertas para: `"Tu Marca"`, `"tumarca.com"`, `"tu nombre" diseño`. En cada alerta pon Entrega en «Fuente RSS» y copia la URL del feed.
- n8n gratis, auto-alojado o cloud.
- Clave de API de IA: console.anthropic.com, sección API Keys (también sirve OpenAI). Gasto de céntimos.
- Bot de Telegram: habla con @BotFather, comando /newbot, te da el token. Escríbele algo a tu bot y saca tu chat_id abriendo `https://api.telegram.org/bot<TOKEN>/getUpdates`.
- Una hoja de Google Sheets llamada `vistos` con una columna `enlace`.

**Los nodos, en orden**
1. **Schedule Trigger**: Cron `0 9 * * *`, zona horaria Europe/Madrid.
2. **RSS Read**: pega la URL del primer feed de Google Alerts. Duplica el nodo por cada alerta y conéctalos todos al siguiente paso, o usa un Code node con la lista de URLs y un HTTP Request en bucle.
3. **Google Sheets**: operación Get Row(s) sobre la hoja `vistos`.
4. **Code** (Run Once for All Items): filtra lo ya visto comparando enlaces.
```javascript
const vistos = new Set($('Google Sheets').all().map(i => i.json.enlace));
const nuevos = items.filter(i => !vistos.has(i.json.link));
return nuevos.map(i => ({ json: { titulo: i.json.title, enlace: i.json.link, resumen: (i.json.contentSnippet || '').slice(0, 400) } }));
```
5. **IF**: condición Number, `{{ $items().length }}` mayor que 0. Si no hay nada nuevo, el flujo termina y no te molesta.
6. **HTTP Request**: POST a `https://api.anthropic.com/v1/messages`. Cabeceras: `x-api-key` desde una credencial de n8n (Generic Credential Type > Header Auth, Name `x-api-key`, Value tu clave; no la escribas en el nodo: un flujo exportado se la llevaría), `anthropic-version` con `2023-06-01`. Body JSON con el modelo y este prompt: «Eres el vigilante de marca de [TU MARCA], que hace [QUÉ HACE]. Para cada resultado dime en una línea: MENCION, PLAGIO o RUIDO, y una frase de por qué. Resultados: {{ JSON.stringify($json) }}».
7. **Telegram**: operación Send Message, con tu chat_id y en Text el texto que devuelve la IA más los enlaces.
8. **Google Sheets**: operación Append Row para guardar los enlaces nuevos en `vistos`.

**Cómo probarla**
- Ejecuta a mano con Test Workflow. La primera vez te llegará todo lo que hay en el feed: es normal, se guarda en `vistos` y al día siguiente ya solo verás lo nuevo.
- Para probar el aviso, crea una alerta con una palabra muy común (por ejemplo tu ciudad) y comprueba que Telegram recibe el mensaje. Luego bórrala.

**Qué puede salir mal**
- Google Alerts no lo pilla todo, sobre todo en Instagram. Para imágenes, complementa con una búsqueda inversa manual en Google Lens una vez al mes.
- Feeds vacíos: si la alerta no tiene resultados, RSS Read devuelve cero elementos y el IF corta bien. No es un error.
- La hoja `vistos` crece sin fin: cada tres meses borra las filas de más de 90 días.
- Falsos positivos con nombres genéricos: pon el nombre entre comillas en Google Alerts y añade al prompt tu sector para que la IA descarte homónimos.

**Cuánto cuesta**
- Google Alerts, RSS y Telegram: gratis.
- IA: menos de 0,01 € por ejecución diaria, unos 0,30 €/mes.
- n8n: gratis auto-alojado.
