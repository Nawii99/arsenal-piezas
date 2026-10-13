# Radiografía de estilo de la web del cliente en el onboa…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Le pasas la URL de un cliente nuevo y te devuelve su paleta real, sus tipografías y su logo, ordenados en un documento de partida.

## Qué es y qué hace

Recibe por formulario la URL de un cliente, descarga su página de inicio y sus hojas de estilo públicas, extrae los colores más repetidos, las familias tipográficas y el logo, y crea un Google Doc de partida para el proyecto. Entrada: URL; salida: documento con paleta, tipografías y logo. Se monta en n8n con Google Docs y Drive, sin API de pago.

## Cómo usarla

1. Crea el formulario en n8n
2. Conecta Google Docs y Drive
3. Prueba con la web de un cliente real
4. Revisa los colores extraídos antes de presentarlos

## Cuándo usarla

Cuando empiezas un rediseño o una identidad y necesitas saber qué colores y tipos usa el cliente hoy sin ir con el cuentagotas de Photoshop.

## Cómo ganar dinero con ella

Convierte 40 minutos de investigación por cliente en 20 segundos: con 10 clientes al año son casi 7 horas.

- Diagnóstico de marca para rediseños de webs de clientes con identidad desfasada.
- Onboarding de clientes para agencias que necesitan datos de partida sin reuniones.
- Análisis visual de competidores para estudios que preparan propuestas.

**Precio orientativo:** 60–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Rellenas un formulario con la URL del cliente, el flujo descarga la home y sus hojas de estilo, extrae los colores más repetidos, las familias tipográficas y el logo, y crea un Google Doc de arranque de proyecto. Para diseñadores de marca y agencias que hacen rediseños.

## Lo que necesitas antes
- Cuenta de n8n (el Form Trigger existe en la versión gratuita).
- Credencial de Google Docs en n8n (Google Cloud, activar Google Docs API y Google Drive API).
- Credencial de Gmail si quieres el aviso.
- Nada más: no hace falta API de pago.

## Los nodos, en orden
1. **n8n Form Trigger** — Form Title: `Onboarding de marca`. Campo 1: `url` (tipo Text, obligatorio). Campo 2: `cliente` (Text). Te da una URL pública para rellenarlo desde el móvil.
2. **HTTP Request** (`Bajar home`) — Method GET. URL `{{ $json.url }}`. Options, Response, Response Format: Text, Output Field: `data`. Options, Headers: `User-Agent` = `Mozilla/5.0` (muchas webs bloquean peticiones sin agente).
3. **Code** (`Buscar CSS`) — Mode: Run Once for All Items. `const html = $json.data; const base = new URL($('n8n Form Trigger').first().json.url); const links = [...html.matchAll(/<link[^>]+rel=["']stylesheet["'][^>]*href=["']([^"']+)["']/gi)].map(m => new URL(m[1], base).href).slice(0, 4); return links.map(u => ({ json: { css_url: u } }));`
4. **HTTP Request** (`Bajar CSS`) — GET `{{ $json.css_url }}`, Response Format: Text, Output Field `data`. Settings del nodo: On Error: Continue (using error output), para que un CSS caído no rompa el flujo.
5. **Code** (`Analizar`) — Mode: Run Once for All Items. Código abajo. Junta el HTML del paso 2 y todos los CSS del paso 4.
6. **Google Docs** — Operation: Create. Title: `Ficha de estilo — {{ $('n8n Form Trigger').first().json.cliente }}`. Folder: la que uses de proyectos.
7. **Google Docs** — Operation: Update. Doc ID: `{{ $json.documentId }}`. Actions: Insert, Text: `{{ $('Analizar').first().json.informe }}`.
8. **Gmail** — Send. Subject: `Ficha de estilo lista`. Message: enlace `https://docs.google.com/document/d/{{ $('Google Docs').first().json.documentId }}/edit`.

## El trozo de código (nodo Code del paso 5)
```javascript
const html = $('Bajar home').first().json.data || '';
const css = $input.all().map(i => i.json.data || '').join('\n');
const todo = html + '\n' + css;
const hex = [...todo.matchAll(/#([0-9a-fA-F]{6}|[0-9a-fA-F]{3})\b/g)].map(m => { let s = m[1].toLowerCase(); if (s.length === 3) s = s.split('').map(c => c + c).join(''); return '#' + s; });
const rgb = [...todo.matchAll(/rgba?\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)/g)].map(m => '#' + [m[1], m[2], m[3]].map(n => Number(n).toString(16).padStart(2, '0')).join(''));
const cuenta = {};
for (const c of [...hex, ...rgb]) { if (c === '#ffffff' || c === '#000000') continue; cuenta[c] = (cuenta[c] || 0) + 1; }
const paleta = Object.entries(cuenta).sort((a, b) => b[1] - a[1]).slice(0, 8);
const fuentes = [...new Set([...todo.matchAll(/font-family\s*:\s*([^;}"']+)/gi)].map(m => m[1].trim().split(',')[0].replace(/["']/g, '')))].slice(0, 8);
const google = [...new Set([...todo.matchAll(/fonts\.googleapis\.com\/css2?\?family=([^&"')]+)/g)].map(m => decodeURIComponent(m[1]).split(':')[0].replace(/\+/g, ' ')))];
const logo = (html.match(/<img[^>]*logo[^>]*src=["']([^"']+)["']/i) || html.match(/<img[^>]+src=["']([^"']*logo[^"']*)["']/i) || [])[1] || 'no encontrado';
const informe = ['FICHA DE ESTILO AUTOMÁTICA', '', 'PALETA DETECTADA (color y veces que aparece):', ...paleta.map(([c, n]) => `  ${c}  —  ${n} apariciones`), '', 'TIPOGRAFÍAS DECLARADAS:', ...fuentes.map(f => `  ${f}`), '', 'GOOGLE FONTS CARGADAS:', ...(google.length ? google.map(g => `  ${g}`) : ['  ninguna']), '', 'LOGO:', `  ${logo}`, '', 'Revisa a ojo: los colores más repetidos no siempre son los de marca (pueden ser grises de interfaz).'].join('\n');
return [{ json: { informe, paleta, fuentes, google, logo } }];
```

## Cómo probarla
- Rellena el formulario con la web de un cliente conocido y compara la paleta con lo que ves en pantalla.
- Prueba con una web hecha en Webflow o WordPress: suelen dar buen resultado. Con webs hechas solo en React el CSS va compilado y saldrán menos datos: es normal, avisa en el informe.
- Si el nodo `Bajar home` devuelve 403, añade también la cabecera `Accept-Language: es-ES`.

## Qué puede salir mal
- **Webs que cargan estilos por JavaScript**: no las lee. Solución rápida: guarda la página con Ctrl+S y sube el HTML a un nodo Read/Write Files, o usa el navegador para copiar el CSS calculado.
- **Colores de interfaz que ensucian**: el código ya descarta blanco y negro puros; añade a la lista los grises que veas repetirse.
- **Rutas relativas del logo**: si sale una ruta tipo `/img/logo.svg`, pégala detrás del dominio a mano.
- **Webs con protección Cloudflare**: devuelven un reto. Ahí toca hacerlo a mano, no hay atajo legal cómodo.

## Cuánto cuesta
- Todo gratis: n8n auto-alojado, Google Docs y Gmail con cuenta personal.
- Coste real: 0 euros.
