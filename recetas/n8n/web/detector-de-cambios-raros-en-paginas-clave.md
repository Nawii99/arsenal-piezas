# Detector de cambios raros en páginas clave…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Guarda una huella del contenido de tus páginas críticas y te avisa si cambian sin que tú hayas tocado nada: hackeo, plugin roto o texto legal alterado.

## Qué es y qué hace

Cada 6 horas descarga tus páginas críticas (portada, precios, checkout, aviso legal), limpia las partes dinámicas, calcula una huella del texto y la compara con la anterior guardada en Google Sheets. Si cambia, te envía a Telegram las frases añadidas o quitadas. Útil para detectar defacement, plugins que rompen la maquetación o cambios de precio no autorizados.

## Cómo usarla

1. Preparar la hoja Vigilancia con url, huella y texto
2. Crear el bot de Telegram
3. Montar el flujo cada 6 horas en n8n
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando gestionas webs con varios usuarios o plugins que se actualizan solos, o temes inyecciones de spam en portadas y páginas de precios.

## Cómo ganar dinero con ella

Una inyección de spam sin detectar tumba tu posicionamiento durante meses. Vigilarlo a mano es imposible; esto cuesta 0 €.

- Vigilancia de precios y textos legales para tiendas con varios editores.
- Detección de defacement para webs de clientes con plugins que se actualizan solos.
- Servicio de integridad de contenidos incluido en el mantenimiento mensual.

**Precio orientativo:** 120–250 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién.** Cada 6 horas descarga tus páginas más importantes (portada, precios, checkout, aviso legal), limpia las partes que cambian solas (fechas, contadores, tokens), calcula una huella del texto y la compara con la anterior. Si la huella cambia, te manda a Telegram qué frases se han añadido o quitado.
Para desarrollador que mantiene webs de clientes y quiere enterarse de un defacement, un plugin que rompe la maquetación o un cambio de precio no autorizado.

**Lo que necesitas antes**
- n8n y una hoja `Vigilancia` en Google Sheets con columnas `url`, `huella`, `texto`, `actualizado`.
- Una fila por cada página a vigilar, con `huella` y `texto` vacíos la primera vez.
- Bot de Telegram (BotFather) y tu chat id.
- Nada de claves de pago: solo peticiones HTTP a tu propia web.

**Los nodos, en orden**
1. **Schedule Trigger** — Interval: Hours, Hours Between Triggers 6.
2. **Google Sheets** — Get Row(s) de `Vigilancia`, Return All.
3. **HTTP Request** (`Bajar`) — GET, URL `{{ $json.url }}`, Response Format `Text`, campo `data`, Options > Never Error activado, Header `User-Agent` = `n8n-vigilante`.
4. **Code** (`Limpiar y comparar`) — Mode: Run Once for All Items. Código abajo: quita scripts, estilos, comentarios, números y fechas, saca texto plano, calcula huella y compara con la guardada.
5. **IF** (`Ha cambiado?`) — Boolean `{{ $json.cambiado }}` `is true`.
6. **Telegram** — Send Message: `{{ $json.aviso }}`.
7. **Google Sheets** (`Actualizar huella`) — Operation: Update Row, Matching Column `url`, escribe `huella`, `texto` (recortado a 45.000 caracteres) y `actualizado` = `{{ $now.toISO() }}`. Conéctalo también desde la rama false para que se refresque la fecha.

**El código del nodo `Limpiar y comparar`**
```js
const filas = $('Google Sheets').all().map(i => i.json);
const huella = (s) => { let h = 5381; for (let i = 0; i < s.length; i++) { h = ((h * 33) ^ s.charCodeAt(i)) >>> 0; } return String(h); };
const limpiar = (html) => html
  .replace(/<script[\s\S]*?<\/script>/gi, '')
  .replace(/<style[\s\S]*?<\/style>/gi, '')
  .replace(/<!--[\s\S]*?-->/g, '')
  .replace(/<[^>]+>/g, ' ')
  .replace(/\d{1,4}[\/-]\d{1,2}[\/-]\d{1,4}/g, '#')
  .replace(/\d+/g, '#')
  .replace(/\s+/g, ' ')
  .trim();
const salida = [];
const items = $input.all();
for (let i = 0; i < items.length; i++) {
  const url = filas[i].url;
  const texto = limpiar(items[i].json.data || '');
  const nueva = huella(texto);
  const vieja = String(filas[i].huella || '');
  const antes = String(filas[i].texto || '').split(' ');
  const ahora = texto.split(' ');
  const nuevas = ahora.filter(p => p.length > 4 && !antes.includes(p)).slice(0, 25).join(' ');
  const cambiado = vieja !== '' && vieja !== nueva;
  salida.push({ json: { url, huella: nueva, texto: texto.slice(0, 45000), cambiado, aviso: `CAMBIO en ${url}\nPalabras nuevas: ${nuevas || '(solo se ha quitado contenido)'}` } });
}
return salida;
```

**Cómo probarla**
- Primera ejecución: no debe avisar de nada, solo rellenar la columna `huella`.
- Segunda ejecución sin tocar la web: tampoco debe avisar. Si avisa, hay algo dinámico que el limpiador no filtra (un token CSRF, un carrusel aleatorio): añade una regla `replace` más en el Code.
- Cambia una palabra en la página y comprueba que llega el Telegram con esa palabra en la lista.

**Qué puede salir mal**
- Falsos positivos por contenido rotativo (testimonios aleatorios, "quedan 3 en stock"): quita esa zona filtrando por un marcador HTML antes de limpiar, por ejemplo cortando el texto entre `<main` y `</main>`.
- Webs con caché agresiva devuelven versiones distintas según el nodo CDN: añade `?nocache={{ $now.toMillis() }}` a la URL.
- Sheets tiene un límite de 50.000 caracteres por celda: por eso recortamos a 45.000.
- Si la web está caída, `data` vendrá vacío y la huella cambiará. Añade un IF previo que descarte respuestas de menos de 500 caracteres.

**Cuánto cuesta**
- Gratis del todo. 4 ejecuciones al día por página; en n8n Cloud son unas 120 ejecuciones al mes, cabe en planes bajos.
