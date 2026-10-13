# Vigía de caídas de la web cada 5 minutos…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Comprueba tu web cada 5 minutos y te avisa al móvil cuando deja de responder, y otra vez cuando vuelve. Para cualquiera que venda o capte clientes por internet.

## Qué es y qué hace

Cada cinco minutos pide tu página como lo haría un visitante y comprueba que responde bien y en un tiempo razonable. Tras dos fallos seguidos envía un aviso por Telegram y, cuando vuelve, un mensaje de recuperación. Entrada: URLs de tu web; salida: avisos. Se monta en n8n con el nodo Schedule Trigger en modo cron.

## Cómo usarla

1. Lista las URLs a vigilar
2. Crea el bot de Telegram y obtén tu chat ID
3. Programa el cron */5 en n8n
4. Comprueba el aviso con una URL falsa

## Cuándo usarla

Úsalo cuando tu web o tienda es tu escaparate principal y ahora mismo te enteras de que está caída porque te lo dice un cliente.

## Cómo ganar dinero con ella

Una hora de tienda caída en un día normal se lleva las ventas de esa hora. Enterarte en 5 minutos en vez de en 5 horas es dinero directo.

- Monitor de disponibilidad para una tienda online con avisos al móvil.
- Vigilancia de web y tienda para un autónomo que capta clientes por internet.
- Informe mensual de caídas y tiempos de respuesta para un negocio con web propia.

**Precio orientativo:** 60–120 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada 5 minutos pide tu página como lo haría un visitante y mira si responde bien y en un tiempo razonable.
Si falla dos veces seguidas te manda un aviso a Telegram; cuando vuelve a funcionar, te manda el «ya está arreglado».

## Lo que necesitas antes
- n8n funcionando (n8n.io plan gratuito, o auto-alojado en tu ordenador o en un VPS de 5 €/mes).
- La URL exacta que quieres vigilar, por ejemplo `https://tunegocio.es` y también `https://tunegocio.es/tienda` si tienes tienda.
- Una cuenta de Telegram y un bot: abre @BotFather en Telegram, escribe `/newbot`, ponle nombre y copia el token que te da.
- Tu chat ID: escribe cualquier cosa a tu bot y abre en el navegador `https://api.telegram.org/bot<TU_TOKEN>/getUpdates`; el número que aparece en `chat.id` es el tuyo.

## Los nodos, en orden
1. **Schedule Trigger** — modo *Custom (Cron)*, expresión `*/5 * * * *`. Así se ejecuta cada 5 minutos.
2. **HTTP Request** — Method `GET`, URL `https://tunegocio.es`. En *Options* activa: `Timeout` = 10000 (10 segundos), `Response > Include Response Status Code` = ON, `Response > Never Error` = ON. Ese último es imprescindible: si no, un error 500 rompe el flujo en vez de dejarte reaccionar.
3. **Code** — modo *Run Once for All Items*. Cuenta los fallos seguidos para no bombardearte con avisos.
4. **IF** — condición *Boolean*: `{{ $json.avisar }}` **is true**. Rama true sigue; rama false no hace nada.
5. **Telegram** — operación *Send Message*, Chat ID el tuyo, Text `{{ $json.mensaje }}`.

## El código del nodo Code
```javascript
const s = $getWorkflowStaticData('global');
const item = $input.first().json;
const code = item.statusCode || 0;
const ok = code >= 200 && code < 400;
s.fails = s.fails || 0;
if (ok) {
  const volvio = s.fails >= 2;
  s.fails = 0;
  return [{ json: { avisar: volvio, mensaje: '✅ La web ha vuelto a funcionar (código ' + code + ')' } }];
}
s.fails = s.fails + 1;
return [{ json: { avisar: s.fails === 2, mensaje: '🔴 La web NO responde. Código: ' + code + '. Fallos seguidos: ' + s.fails } }];
```

## Cómo probarla
- Cambia temporalmente la URL del HTTP Request a `https://tunegocio.es/pagina-que-no-existe` y ejecuta el flujo a mano tres veces con *Test workflow*: a la segunda te debe llegar el aviso a Telegram.
- Vuelve a poner la URL buena y ejecuta dos veces más: te debe llegar el «ha vuelto».
- Solo entonces activa el workflow con el interruptor *Active* arriba a la derecha.

## Qué puede salir mal
- **Te avisa por nada**: hay webs que tardan más de 10 segundos en horas punta. Sube el `Timeout` a 20000 y exige tres fallos seguidos en vez de dos (cambia el `=== 2` por `=== 3`).
- **No detecta la caída**: algunos hostings devuelven un 200 con una página de error. Añade en el Code una comprobación de contenido: `const tieneTexto = (item.body||'').includes('Añadir al carrito');` y trátalo como fallo si es false.
- **Cloudflare te bloquea** por parecer un bot: en HTTP Request añade en *Headers* `User-Agent: Mozilla/5.0 (monitor propio)`.
- **Se te llena el historial**: en *Settings* del workflow pon *Save successful production executions* = `None`, para no guardar 288 ejecuciones al día.

## Cuánto cuesta
- n8n auto-alojado: gratis. n8n Cloud: el plan de arranque ronda los 20-25 €/mes y 8.640 ejecuciones al mes se comen buena parte de la cuota, así que si vas de cloud, pon `*/15 * * * *` (cada 15 min).
- Telegram: gratis y sin límites relevantes.
- Alternativa en Make o Zapier: cada comprobación gasta una operación o tarea, con lo que cada 5 minutos te sales del plan gratuito el primer día. Para esta receta, n8n auto-alojado es la opción sensata.
