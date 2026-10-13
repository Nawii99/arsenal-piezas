# Auditor de contraste de tu paleta (WCAG)

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Comprueba todas las combinaciones de color de tu marca, te dice cuáles son legibles y cuáles incumplen accesibilidad, y te manda el informe.

## Qué es y qué hace

Lee los colores de tu marca desde una hoja, calcula el ratio de contraste WCAG de todas las combinaciones posibles y devuelve una tabla con el veredicto: apto para texto normal, solo para titulares grandes o prohibido. Entran nombres y valores hexadecimales de la paleta; sale un informe de accesibilidad. Para diseñadores de marca que entregan manuales o webs con identidad de cliente.

## Cómo usarla

1. Crea la hoja paleta con columnas nombre y hex
2. Conecta Sheets en n8n
3. Ejecuta el cálculo sobre tu paleta actual
4. Ajusta los colores que no cumplen AA

## Cuándo usarla

Úsalo cuando defines o revisas una paleta de marca y quieres saber, con números y no a ojo, qué combinaciones de texto y fondo son legibles de verdad.

## Cómo ganar dinero con ella

Evita rehacer una web o un manual de marca por incumplir accesibilidad (jornada entera de trabajo) y te da un argumento sólido ante el cliente. Coste: 0 €.

- Auditoría de accesibilidad de paleta para marcas que entregan manual de identidad…
- Revisión de contraste para webs de clientes antes de lanzar…
- Informe de accesibilidad cromática para estudios que compiten en licitaciones…

**Precio orientativo:** 30–90 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Lee los colores de tu marca desde una hoja, calcula el ratio de contraste WCAG de todas las parejas posibles y devuelve una tabla con el veredicto: apto para texto normal, solo para titulares grandes, o prohibido.
Para diseñadores de marca que entregan manuales y quieren que la paleta aguante una auditoría de accesibilidad, y para quien monta webs con la identidad de un cliente.

**Lo que necesitas antes**
- n8n. No hace falta ninguna API de pago: el cálculo se hace dentro.
- Una hoja de Google Sheets `paleta` con columnas `nombre` y `hex` (por ejemplo: Verde principal / #0F3D3E).
- Credencial OAuth de Google para Sheets y Gmail.
- Saber la regla: WCAG AA pide 4.5 para texto normal y 3.0 para texto grande (más de 24 px, o 18,66 px en negrita). AAA pide 7.0.

**Los nodos, en orden**
1. **Manual Trigger** para lanzarlo tú (o **Schedule Trigger** mensual si quieres revisión periódica).
2. **Google Sheets**: Get Row(s) de la hoja `paleta`.
3. **Code** (Run Once for All Items): aquí está toda la chicha.
```javascript
function lum(hex) {
  const c = hex.replace('#', '').trim();
  const v = [0, 2, 4].map(i => parseInt(c.substr(i, 2), 16) / 255);
  const f = x => x <= 0.03928 ? x / 12.92 : Math.pow((x + 0.055) / 1.055, 2.4);
  return 0.2126 * f(v[0]) + 0.7152 * f(v[1]) + 0.0722 * f(v[2]);
}
function ratio(a, b) {
  const l1 = lum(a), l2 = lum(b);
  const hi = Math.max(l1, l2), lo = Math.min(l1, l2);
  return (hi + 0.05) / (lo + 0.05);
}
const colores = items.map(i => ({ nombre: i.json.nombre, hex: i.json.hex }));
colores.push({ nombre: 'Blanco', hex: '#FFFFFF' }, { nombre: 'Negro', hex: '#000000' });
const salida = [];
for (let i = 0; i < colores.length; i++) {
  for (let j = i + 1; j < colores.length; j++) {
    const r = ratio(colores[i].hex, colores[j].hex);
    const n = Math.round(r * 100) / 100;
    let veredicto = 'NO USAR para texto';
    if (r >= 7) veredicto = 'AAA: perfecto para todo';
    else if (r >= 4.5) veredicto = 'AA: vale para texto normal';
    else if (r >= 3) veredicto = 'Solo titulares grandes y bordes';
    salida.push({ json: { texto: colores[i].nombre, fondo: colores[j].nombre, hex_texto: colores[i].hex, hex_fondo: colores[j].hex, ratio: n, veredicto } });
  }
}
salida.sort((a, b) => b.json.ratio - a.json.ratio);
return salida;
```
4. **Google Sheets**: operación Append or Update en una hoja `resultado_contraste`, para tener la tabla ordenada.
5. **Code** (segundo, opcional): monta una tabla HTML con los colores de fondo reales para verlo de un vistazo, usando `<td style="background:${hex_fondo};color:${hex_texto}">Ejemplo</td>`.
6. **Gmail**: Send Message a tu correo, tipo HTML, con esa tabla pegada. Ese email lo puedes reenviar al cliente tal cual.

**Cómo probarla**
- Mete a propósito dos colores parecidos (por ejemplo #F2E8DC y #FFFFFF) y comprueba que salen como NO USAR con un ratio cercano a 1.1.
- Contrasta un caso conocido: negro sobre blanco debe dar 21.

**Qué puede salir mal**
- Hex de 3 dígitos (#0F3): el código espera 6. Añade una línea que expanda los cortos, o escribe siempre los seis dígitos en la hoja.
- Espacios o mayúsculas en la hoja: el `.trim()` los limpia, pero evita escribir `rgb(...)` o nombres de color.
- Transparencias: el cálculo no contempla opacidades; si usas un color al 60%, calcula antes el color resultante sobre el fondo.
- Interpretación: pasar AA no significa que sea bonito. Es un mínimo legal, no una decisión estética.

**Cuánto cuesta**
- Gratis del todo. Ni APIs de pago ni servicios externos.
