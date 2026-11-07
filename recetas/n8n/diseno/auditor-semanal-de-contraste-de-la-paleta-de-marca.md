# Auditor semanal de contraste de la paleta de marca…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Coge los colores de tu manual de marca desde una hoja de cálculo, calcula el contraste de todas las combinaciones y te avisa de cuáles no cumplen accesibilidad WCAG.

## Qué es y qué hace

Lee tu paleta de marca desde Google Sheets, calcula el ratio de contraste de cada par de colores con la fórmula WCAG 2.1 y envía cada lunes un correo con las combinaciones válidas y las que no cumplen. Entrada: hoja Paleta con hex y usos; salida: tabla de contraste y correo. Se monta en n8n sin pagar herramientas de accesibilidad.

## Cómo usarla

1. Rellena la hoja Paleta con hex y usos
2. Configura Google Sheets y Gmail
3. Ejecuta una prueba manual
4. Revisa las combinaciones prohibidas antes de entregar

## Cuándo usarla

Úsalo cuando entregues identidades visuales o webs y quieras evitar que un cliente (o una administración) te devuelva el diseño por texto ilegible.

## Cómo ganar dinero con ella

Evita rehacer una identidad entera por un fallo de contraste: una auditoría manual de 40 combinaciones son 2 horas, aquí son 0 minutos.

- Auditoría de accesibilidad de color para identidades que se entregan a administraciones.
- Manual de marca con combinaciones aprobadas para estudios de diseño.
- Control de contraste para webs de clientes antes del lanzamiento.

**Precio orientativo:** 40–150 € por marca. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recorre todos los pares de colores de tu paleta (texto sobre fondo) y calcula el ratio de contraste según la fórmula oficial WCAG 2.1. Cada lunes te llega un correo con la tabla de combinaciones seguras y las prohibidas, para diseñadores y estudios que entregan manuales de marca.

## Lo que necesitas antes
- Cuenta de n8n (n8n.cloud solo tiene prueba gratuita temporal, o auto-alojado con Docker: `docker run -p 5678:5678 n8nio/n8n`).
- Una hoja de Google Sheets llamada `Paleta` con columnas: `nombre`, `hex`, `uso` (una fila por color, hex con almohadilla, por ejemplo `#0F4C81`).
- Credencial de Google Sheets en n8n: se crea en console.cloud.google.com, APIs y servicios, activar Google Sheets API, crear ID de cliente OAuth tipo Aplicación web y pegar el Redirect URI que te da n8n.
- Credencial de Gmail en n8n (mismo proyecto de Google Cloud, activando Gmail API).

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: Weeks, semana: Monday, hora 08:00. En Settings del workflow pon Timezone `Europe/Madrid`.
2. **Google Sheets** — Resource: Sheet Within Document, Operation: Get Row(s). Document: tu hoja. Sheet: `Paleta`. Options: Data Location on Sheet, Header Row 1. Devuelve un item por color.
3. **Code** — Mode: Run Once for All Items. Pega el código de abajo. Devuelve un item por cada par de colores con su ratio.
4. **Filter** — Condition: `{{ $json.aa_texto_normal }}` is false. Así te quedas solo con las combinaciones problemáticas.
5. **Code** (segundo, llámalo `Montar tabla`) — Mode: Run Once for All Items. Construye el HTML del correo: `const filas = $input.all().map(i => `<tr><td>${i.json.texto}</td><td>${i.json.fondo}</td><td>${i.json.ratio}</td></tr>`).join(''); return [{ json: { html: `<h3>Combinaciones que no cumplen AA</h3><table border=1 cellpadding=6><tr><th>Texto</th><th>Fondo</th><th>Ratio</th></tr>${filas}</table>` } }];`
6. **Gmail** — Operation: Send. To: tu correo. Subject: `Auditoría de contraste de marca`. Email Type: HTML. Message: `{{ $json.html }}`.

## El trozo de código (nodo Code del paso 3)
```javascript
const hex2rgb = h => { let s = h.replace('#','').trim(); if (s.length === 3) s = s.split('').map(c => c + c).join(''); return [parseInt(s.substr(0,2),16), parseInt(s.substr(2,2),16), parseInt(s.substr(4,2),16)]; };
const lum = rgb => { const a = rgb.map(v => { v = v / 255; return v <= 0.03928 ? v / 12.92 : Math.pow((v + 0.055) / 1.055, 2.4); }); return 0.2126*a[0] + 0.7152*a[1] + 0.0722*a[2]; };
const ratio = (a, b) => { const L1 = lum(hex2rgb(a)), L2 = lum(hex2rgb(b)); const hi = Math.max(L1, L2), lo = Math.min(L1, L2); return (hi + 0.05) / (lo + 0.05); };
const colores = $input.all().map(i => i.json).filter(c => c.hex && c.hex.includes('#'));
const salida = [];
for (const f of colores) { for (const b of colores) { if (f.hex.toLowerCase() === b.hex.toLowerCase()) continue; const r = ratio(f.hex, b.hex); salida.push({ json: { texto: `${f.nombre} (${f.hex})`, fondo: `${b.nombre} (${b.hex})`, ratio: Math.round(r * 100) / 100, aa_texto_normal: r >= 4.5, aa_texto_grande: r >= 3, aaa: r >= 7 } }); } }
return salida;
```

## Cómo probarla
- Pulsa **Execute Workflow** con 4 colores en la hoja: deben salir 12 pares.
- Comprueba a mano un par conocido: negro `#000000` sobre blanco `#FFFFFF` tiene que dar exactamente 21.
- Mete a propósito un gris claro `#CCCCCC` sobre blanco: debe aparecer en el correo como no apto (ratio 1.6).

## Qué puede salir mal
- **Hex sin almohadilla o con espacios**: el filtro del código los descarta en silencio. Añade validación de datos en la hoja o revisa que el contador de pares cuadre.
- **Zona horaria**: si no pones `Europe/Madrid` en los ajustes del workflow, el Schedule dispara en UTC y en verano te llega a las 10:00. Se arregla en Workflow Settings, Timezone.
- **Correo en spam**: si mandas a un dominio propio, añade tu correo a contactos la primera vez.
- **Paleta grande**: con 15 colores salen 210 pares y el correo se hace ilegible. Filtra en el paso 4 añadiendo condición `uso` contiene `texto`.

## Cuánto cuesta
- n8n auto-alojado: 0 euros. n8n Cloud: tras la prueba gratuita temporal es de pago (no tiene plan gratuito permanente).
- Google Sheets y Gmail: gratis con cuenta personal. Si usas Google Workspace ya lo pagas igual.
- Coste real: 0 euros al mes.
