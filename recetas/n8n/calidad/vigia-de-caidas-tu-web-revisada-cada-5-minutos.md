# Vigía de caídas: tu web revisada cada 5 minutos…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Comprueba cada 5 minutos que tu web y tu checkout responden. Si algo se cae o tarda demasiado, te llega un aviso al móvil con el código de error.

## Qué es y qué hace

Cada 5 minutos pide tu web, tu portada y tu página de carrito, y mira el código de respuesta y el tiempo de carga. Si algo falla dos veces seguidas te manda un aviso de Telegram con el error y, cuando vuelve, avisa de que está arreglado. Entrada: URLs que indiques; salida: avisos y registro de incidencias. Se monta en n8n con Telegram y Google Sheets, o con un monitor equivalente en Make o Zapier.

## Cómo usarla

1. Montar n8n con Docker o en la nube
2. Crear el bot de Telegram y la hoja Incidencias
3. Probar apagando una URL de prueba
4. Ajustar los intervalos

## Cuándo usarla

Úsalo cuando vendas o captes clientes desde tu web y no quieras enterarte de una caída porque te lo diga un cliente cabreado o porque veas el día sin pedidos.

## Cómo ganar dinero con ella

Una caída de 6 horas sin detectar en una tienda que factura 3.000 €/mes son unos 25 € perdidos más el SEO; detectarla en 5 minutos la reduce a casi nada.

- Vigilar webs y tiendas de pequeños comercios, cobrando una configuración y una cuota mensual.
- Ofrecer el monitor de caídas a agencias que gestionan webs de clientes.
- Montar un informe mensual de disponibilidad para dueños de tiendas online.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada 5 minutos pide tus páginas clave (portada, una ficha de producto, el carrito) y mira el código de respuesta y el tiempo que tarda. Si algo falla dos veces seguidas te manda un mensaje de Telegram, y cuando vuelve te avisa de que ya está arreglado.
Para autónomos y tiendas pequeñas que no tienen a nadie mirando la web todo el día.

## Lo que necesitas antes
- n8n. Gratis auto-alojado con Docker (`docker run -it --rm -p 5678:5678 -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n`) o el plan de pago más barato de n8n Cloud si no quieres servidor.
- Un bot de Telegram: en Telegram escribe a @BotFather, manda `/newbot`, ponle nombre y copia el token. Después escribe cualquier cosa a tu bot y consulta `getUpdates` de la API de Telegram desde tu navegador o con curl en tu ordenador (es la única vez que el token va en una URL; no la pegues en ningún nodo ni la compartas): ahí ves tu `chat_id`. El token se guarda solo en una credencial «Telegram API» de n8n; un flujo exportado con el token escrito en un nodo se llevaría la clave.
- Una hoja de Google Sheets llamada «Incidencias web» con las columnas: fecha, url, estado, ms, mensaje.
- La lista de 3 a 6 URLs que de verdad importan. No vigiles 80 páginas, vigila las que dan dinero.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: Minutes, Minutes Between Triggers: 5. En Settings del workflow pon la Timezone en Europe/Madrid.
2. **Code** (nombre: «Lista de URLs»). Mode: Run Once for All Items. Devuelve una fila por URL a vigilar.
```js
const urls = [
  { nombre: 'Portada', url: 'https://tudominio.es/' },
  { nombre: 'Producto estrella', url: 'https://tudominio.es/producto/estrella' },
  { nombre: 'Carrito', url: 'https://tudominio.es/carrito' }
];
return urls.map(u => ({ json: u }));
```
3. **HTTP Request** — Method: GET, URL: `={{ $json.url }}`. En Options activa: Response > Include Response Headers and Status (para que no explote con un 500), Response > Never Error (o en Settings del nodo, «On Error: Continue (using error output)»), Timeout: 15000, Redirects: Follow. En Options > Headers añade `User-Agent: n8n-monitor` (algunos hostings bloquean peticiones sin User-Agent).
4. **Code** (nombre: «Evaluar»). Mode: Run Once for Each Item.
```js
const code = $json.statusCode || $json.error?.status || 0;
const ok = code >= 200 && code < 400;
return { json: { nombre: $('Lista de URLs').item.json.nombre, url: $('Lista de URLs').item.json.url, code, ok, fecha: new Date().toISOString() } };
```
5. **IF** — Condition: Boolean, `={{ $json.ok }}` is false. Rama true (o sea, ha fallado) sigue al aviso.
6. **Telegram** — Credencial «Telegram API» (el token no se escribe en el nodo). Resource: Message, Operation: Send Message, Chat ID: el tuyo, Text: `=🔴 {{ $json.nombre }} no responde. Código {{ $json.code }}. {{ $json.url }}`.
7. **Google Sheets** — Operation: Append Row, hoja «Incidencias web», mapeando fecha, url, estado y mensaje.

## Evitar el aviso doble y el falso positivo
Un fallo suelto puede ser la red. Añade entre el IF y el Telegram un nodo **Wait** de 60 segundos y luego otro **HTTP Request** al mismo URL; solo avisa si también falla la segunda vez. Y para no recibir 12 avisos por hora de la misma caída, antes del Telegram mete un **Google Sheets** (Operation: Get Rows, filtro por url) y un **IF** que corte si ya hay una incidencia abierta de esa URL en las últimas 2 horas.

## Cómo probarla
Cambia una URL de la lista por `https://tudominio.es/esta-pagina-no-existe` y pulsa «Test workflow»: te tiene que llegar el Telegram con el 404. Después devuélvela a su sitio, ejecuta otra vez y comprueba que no llega nada. Solo entonces pulsa «Active».

## Qué puede salir mal
- **Tu propio hosting te bloquea** por hacer muchas peticiones: baja a cada 10 minutos y usa el User-Agent identificado, o mete tu IP en la lista blanca del firewall/Cloudflare.
- **Te avisa de noche**: añade un IF con `={{ new Date().getHours() >= 8 && new Date().getHours() < 23 }}` si prefieres dormir, pero para una tienda yo lo dejaría 24 horas.
- **Zona horaria**: si las horas de la hoja salen desplazadas, revisa Settings > Timezone del workflow, no la del servidor.
- **La web responde 200 pero está en blanco**: en el paso 4 añade también `const vacio = (($json.data||'').length < 500);` y trátalo como fallo.

## Cuánto cuesta
Gratis del todo: n8n auto-alojado (un VPS de 5 €/mes te sirve para esto y para 30 automatizaciones más), Telegram gratis, Sheets gratis. En n8n Cloud, 12 ejecuciones/hora son unas 8.600 al mes: te obliga a un plan de pago (desde ~20 €/mes), así que aquí compensa el auto-alojado.
