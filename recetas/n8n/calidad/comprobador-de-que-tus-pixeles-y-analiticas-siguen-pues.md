# Comprobador de que tus píxeles y analíticas siguen pues…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Revisa cada día que el píxel de Meta, GA4 y el aviso de cookies siguen en tus páginas clave. Si un cambio los tumba, te enteras el mismo día.

## Qué es y qué hace

Cada día descarga el HTML de tus páginas clave y busca las huellas del píxel de Meta, de GA4, de Google Tag Manager, del banner de cookies y del chat. Si falta alguno donde debería estar, avisa por Telegram. Entrada: URLs e IDs de tus herramientas; salida: alerta de scripts ausentes. Se monta en n8n con HTTP Request y Telegram.

## Cómo usarla

1. Anotar tus IDs de GA4, Meta y GTM
2. Listar las páginas clave
3. Probar con una página que sepas correcta
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando inviertas en publicidad o tomes decisiones con Analytics, y muy especialmente si tocas la web, cambias de plantilla o actualizas plugins.

## Cómo ganar dinero con ella

Dos semanas de anuncios sin píxel son dos semanas de campañas optimizando a ciegas: con 600 €/mes de inversión, tiras entre 150 y 300 € y pierdes el histórico.

- Verificar que la medición de campañas funciona en tiendas que invierten en anuncios.
- Ofrecer revisiones tras cada cambio de web o plugin a agencias de marketing.
- Montar un informe diario de píxeles para un negocio con campañas de pago.

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Descarga el HTML de tus páginas importantes y busca las huellas de los scripts que te importan: píxel de Meta, etiqueta de GA4, Google Tag Manager, el banner de cookies y el script de tu chat. Si falta alguno donde debería estar, te avisa.
Para quien hace anuncios o mide de verdad, y ya se ha llevado el susto de descubrir un mes después que no había datos.

## Lo que necesitas antes
- n8n.
- Saber qué debe haber en cada página: tu ID de GA4 (`G-XXXXXXX`), el ID del píxel de Meta (número largo), el ID de GTM (`GTM-XXXX`). Los tienes en el administrador de eventos de Meta y en Administrar > Flujos de datos de GA4.
- Bot de Telegram.

## Los nodos, en orden
1. **Schedule Trigger** — Days, Hour: 8.
2. **Code** (nombre: «Qué revisar»). Run Once for All Items.
```js
const paginas = ['https://tudominio.es/','https://tudominio.es/producto/estrella','https://tudominio.es/gracias'];
const reglas = [
  { nombre: 'GA4', patron: 'G-XXXXXXX' },
  { nombre: 'Pixel Meta', patron: 'connect.facebook.net' },
  { nombre: 'ID Pixel', patron: '123456789012345' },
  { nombre: 'GTM', patron: 'GTM-XXXX' },
  { nombre: 'Cookies', patron: 'cookieconsent' }
];
return paginas.map(p => ({ json: { pagina: p, reglas } }));
```
3. **HTTP Request** — GET `={{ $json.pagina }}`, Response Format: Text, Never Error: on, Timeout: 20000, Header `User-Agent: Mozilla/5.0 (compatible; n8n-qa)`.
4. **Code** (nombre: «Buscar huellas»). Run Once for Each Item.
```js
const html = ($json.data || '').toLowerCase();
const item = $('Qué revisar').item.json;
const faltan = item.reglas.filter(r => !html.includes(r.patron.toLowerCase())).map(r => r.nombre);
return { json: { pagina: item.pagina, faltan, ok: faltan.length === 0 } };
```
5. **IF** — Boolean `={{ $json.ok }}` is false.
6. **Telegram** — `=🔴 En {{ $json.pagina }} faltan: {{ $json.faltan.join(', ') }}. Revisa el plugin de etiquetas o la caché.`
7. **Google Sheets** — Append Row con fecha, página y lo que falta, para tener histórico de cuándo se rompió.

## Cómo probarla
Añade a la lista de reglas un patrón inventado (`patron: 'esto-no-existe'`) y ejecuta: debe llegarte el Telegram. Quítalo y vuelve a ejecutar: silencio. Comprueba también una página donde el píxel NO deba estar (por ejemplo el aviso legal) para no llenarte de falsos avisos.

## Qué puede salir mal
- **Scripts cargados por GTM o por JavaScript**: si tu píxel se inyecta con Tag Manager, en el HTML solo verás el `GTM-XXXX`, no `connect.facebook.net`. Entonces vigila el GTM y, si quieres ir más fino, comprueba el contenedor con `https://www.googletagmanager.com/gtm.js?id=GTM-XXXX` y busca ahí el ID del píxel.
- **Caché o Cloudflare** te devuelven una versión vieja: añade a la URL `?nocache={{ $now.toMillis() }}`.
- **Consent mode**: si el píxel solo carga tras aceptar cookies, este método te da falso negativo. En ese caso vigila que exista el script del banner y el ID del píxel dentro del HTML, aunque no se ejecute.
- **La página /gracias solo existe tras comprar**: crea una versión accesible o quítala de la lista.

## Cuánto cuesta
Gratis. Tres peticiones al día contra tu propia web no le hacen cosquillas a ningún hosting.
