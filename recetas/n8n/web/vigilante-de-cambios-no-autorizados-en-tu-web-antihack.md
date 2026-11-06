# Vigilante de cambios no autorizados en tu web (antihack…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Cada media hora compara el HTML de tus páginas clave con la última versión conocida y te avisa si alguien ha metido código, enlaces raros o redirecciones. Para webs con WordPress.

## Qué es y qué hace

Cada media hora descarga tus páginas clave, quita las partes que cambian solas (fechas, tokens, contadores), calcula una huella digital y la compara con la guardada en Google Sheets. Si cambia, guarda el HTML en Drive, te avisa por Telegram y busca patrones típicos de intrusión como iframes ocultos, eval o base64 largo. Sirve para webs con varios usuarios o plugins de terceros.

## Cómo usarla

1. Preparar la hoja Vigilancia web con 5 a 10 URLs
2. Crear la carpeta de copias en Drive y el bot
3. Activar el módulo crypto si auto-alojas n8n
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando hayas tenido un susto de seguridad, tengas varias personas con acceso al panel, o uses plugins y temas nulled/antiguos. También si te preocupa el spam SEO japonés o farmacéutico.

## Cómo ganar dinero con ella

Detectar una inyección en 30 minutos en vez de en semanas evita la penalización de Google y limpiezas de emergencia que cuestan 300-800 €.

- Vigilancia de inyecciones y cambios en webs de clientes con varios editores.
- Revisión semanal de cambios en páginas legales y de precios para tiendas online.
- Servicio de monitorización de integridad incluido en el mantenimiento de WordPress.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Descarga tus páginas más importantes, les quita las partes que cambian solas (fechas, tokens, contadores), calcula una huella digital y la compara con la que tenía guardada.
Si la huella cambia, guarda una copia del HTML en Drive, te avisa por Telegram con las diferencias más relevantes y hace un chequeo extra de patrones típicos de hackeo (iframes ocultos, `eval`, base64 largo, enlaces a dominios raros).

## Lo que necesitas antes
- Hoja de Google «Vigilancia web» con columnas: url, huella, ultima_revision, cambios.
- Rellénala con 5-10 URLs: portada, contacto, política de privacidad, una ficha de producto, el `robots.txt` y el `.htaccess` si es accesible por HTTP (mejor si no).
- Bot de Telegram con tu chat ID.
- Carpeta en Drive «Copias vigilancia» y su ID.
- n8n con la variable de entorno `NODE_FUNCTION_ALLOW_BUILTIN=crypto` si te auto-alojas. Si no puedes, el código de abajo tiene una alternativa sin `crypto`.

## Los nodos, en orden
1. **Schedule Trigger** — Minutes, Minutes Between Triggers: 30.
2. **Google Sheets** — Get Row(s) de «Vigilancia web».
3. **Loop Over Items** — Batch Size: 1.
4. **HTTP Request** (renómbralo «Bajar HTML») — GET `={{ $json.url }}`; Response Format: `Text`, Output Field: `html`; Header `User-Agent`: `Mozilla/5.0`; Never Error activado; Settings: `On Error: Continue`.
5. **Code** (renómbralo «Comparar huella») — ver código.
6. **IF** — Boolean: `={{ $json.alarma }}` is true.
7. **Google Drive** (rama true) — Resource: File, Operation: Upload; File Content: `={{ $('Bajar HTML').item.json.html }}`; File Name: `=copia-{{ $json.slug }}-{{ $now.format('yyyyLLdd-HHmm') }}.html`; carpeta «Copias vigilancia».
8. **Telegram** (rama true) — Text: `={{ $json.mensaje }}`.
9. **Google Sheets** (las dos ramas) — Operation: Append or Update Row; Column to Match On: `url`; actualiza `huella`, `ultima_revision` y `cambios`.
10. La salida vuelve al **Loop Over Items**.

## El código de «Comparar huella»
```js
const fila = $('Loop Over Items').item.json;
const html = $('Bajar HTML').item.json.html || '';
let limpio = html
  .replace(/<!--[\s\S]*?-->/g, '')
  .replace(/\b\d{1,2}\/\d{1,2}\/\d{4}\b/g, '')
  .replace(/nonce="[^"]*"/gi, '')
  .replace(/ver=\d+[\d.]*/gi, '')
  .replace(/csrf[^"']*["'][^"']*["']/gi, '')
  .replace(/\s+/g, ' ')
  .trim();
let huella;
try { huella = require('crypto').createHash('sha256').update(limpio).digest('hex').slice(0, 16); }
catch (e) { let h = 5381; for (let i = 0; i < limpio.length; i++) { h = ((h * 33) ^ limpio.charCodeAt(i)) >>> 0; } huella = String(h) + '-' + limpio.length; }
const sospechas = [];
if (/<iframe[^>]*(display\s*:\s*none|width=["']?0)/i.test(html)) sospechas.push('iframe oculto');
if (/eval\s*\(\s*(atob|unescape|String\.fromCharCode)/i.test(html)) sospechas.push('eval ofuscado');
if (/[A-Za-z0-9+\/=]{300,}/.test(html)) sospechas.push('bloque base64 muy largo');
if (/(viagra|casino|payday loan|カジノ|таблетки)/i.test(html)) sospechas.push('spam SEO inyectado');
if (/window\.location\s*=\s*["']https?:\/\/(?!(www\.)?tudominio\.com)/i.test(html)) sospechas.push('redirección externa');
const primeraVez = !fila.huella;
const cambiado = !primeraVez && fila.huella !== huella;
const alarma = cambiado || sospechas.length > 0;
const mensaje = `⚠️ Cambio detectado en ${fila.url}\n` + (cambiado ? 'El contenido ha cambiado respecto a la última revisión.\n' : '') + (sospechas.length ? 'Señales sospechosas: ' + sospechas.join(', ') : '');
return [{ json: { url: fila.url, huella, alarma, cambios: sospechas.join(', '), mensaje, slug: fila.url.replace(/[^a-z0-9]/gi, '-').slice(0, 40), ultima_revision: new Date().toLocaleString('es-ES', { timeZone: 'Europe/Madrid' }) } }];
```

## Cómo probarla
- Primera ejecución: la hoja se rellena con las huellas y no debe avisarte de nada (`primeraVez`).
- Edita una de esas páginas en WordPress (cambia una palabra) y ejecuta otra vez: te debe llegar el Telegram.
- Cambia `tudominio.com` en la regla de redirección por tu dominio real, o te saltará siempre.

## Qué puede salir mal
- **Avisos cada 30 minutos por nada**: tu página tiene elementos dinámicos (contador de visitas, «hace 3 horas», productos aleatorios). Añade más `replace` a la limpieza o vigila solo el bloque `<head>` con `html.split('</head>')[0]`.
- **La caché te da HTML antiguo**: añade `?nocache={{ $now.toMillis() }}` a la URL.
- **Cambios legítimos tuyos**: te avisará cada vez que publiques; es el precio, y basta con confirmar mentalmente «he sido yo». La huella se actualiza sola.
- **No detecta cambios en la base de datos ni en archivos PHP**: esto solo mira el HTML público. Complétalo con un `find . -mtime -1 -name '*.php'` por SSH si quieres ir en serio.
- **Se llena Drive de copias**: añade un paso mensual que borre archivos de más de 90 días en esa carpeta.

## Cuánto cuesta
- Gratis con n8n auto-alojado. En n8n Cloud gratuito, 48 ejecuciones al día se comen el cupo: sube el intervalo a 6 horas.
- Sheets, Drive y Telegram: gratis.
