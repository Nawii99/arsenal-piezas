# Auditoría semanal de contraste (WCAG) de tu paleta…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Revisa todas las combinaciones de color de tu marca y te avisa por correo de cuáles no cumplen el contraste mínimo para web, con la nota exacta de cada pareja.

## Qué es y qué hace

Lee la lista de colores de tu marca desde una hoja de cálculo, calcula el contraste de todas las parejas de texto y fondo según WCAG 2.1 en niveles AA y AAA, y te envía un correo solo con las que no cumplen. Cada aviso incluye el ratio exacto y la razón del fallo. Se monta con n8n, Make o Zapier y no requiere código.

## Cómo usarla

1. Prepara la hoja con los colores de marca
2. Conecta Google Sheets y Gmail en n8n
3. Define las parejas de texto y fondo que usas
4. Programa la ejecución semanal

## Cuándo usarla

Úsalo cuando entregues manuales de marca, webs o plantillas a clientes y no quieras que te devuelvan el trabajo por problemas de accesibilidad.

## Cómo ganar dinero con ella

Ahorra media hora de comprobaciones manuales por proyecto y evita rehacer pantallas ya aprobadas, que suele costar entre 200 y 500 € de tu tiempo.

- Auditoría de accesibilidad de paleta antes de entregar un manual de marca…
- Revisión trimestral de contraste para webs de clientes con mantenimiento…
- Informe de accesibilidad de color incluido en cada propuesta de identidad…

**Precio orientativo:** 60–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Coge la lista de colores de tu marca desde una hoja de cálculo, calcula el contraste de todas las parejas texto/fondo y te manda un correo con las que fallan según WCAG 2.1 (niveles AA y AAA).
Es para diseñadores de marca y freelance que entregan identidades o webs y no quieren comprobar cuarenta combinaciones a mano cada vez que cambia un color.
## Lo que necesitas antes
Una cuenta de n8n: sirve la prueba gratuita temporal de n8n Cloud o, para uso continuado gratis, auto-alojado con Docker (Community Edition) (`docker run -it --rm -p 5678:5678 -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n`).
Una cuenta de Google. En n8n crea las credenciales «Google Sheets OAuth2 API» y «Gmail OAuth2»: se sacan en console.cloud.google.com > APIs y servicios > Credenciales > Crear ID de cliente OAuth (tipo Aplicación web), pegando como URL de redirección la que te muestra n8n al crear la credencial. Activa también las APIs «Google Sheets API» y «Gmail API» en ese mismo panel.
Una hoja de Google llamada `Paleta` con tres columnas en la fila 1: `nombre`, `hex`, `uso`. En `uso` pon `texto`, `fondo` o `ambos`.
## Los nodos, en orden
**1. «Schedule Trigger»** — Trigger Interval: Weeks, Weeks Between Triggers 1, Trigger on Monday, Trigger at Hour 8, Minute 0. En Settings del workflow pon Timezone `Europe/Madrid` para que no se dispare a las 9 en verano.
**2. «Google Sheets»** — Resource: Sheet Within Document, Operation: Get Row(s). Document: elige por lista tu archivo. Sheet: `Paleta`. Options > Data Location on Sheet: Header Row 1, First Data Row 2. Devuelve un item por color.
**3. «Code»** — Mode: Run Once for All Items. Language: JavaScript. Aquí se hace todo el cálculo (código completo más abajo).
**4. «IF»** — Conditions: Number > `{{ $json.total_fallos }}` > larger than > 0. Así solo te escribe cuando hay algo roto.
**5. «Gmail»** (rama true del IF) — Resource: Message, Operation: Send. To: tu correo. Subject: `Contraste: {{ $json.total_fallos }} combinaciones fallan`. Email Type: HTML. Message: `{{ $json.html }}`.
## El trozo de código (nodo «Code»)
```javascript
const filas = $input.all().map(i => i.json);
function lum(hex) {
  const h = String(hex).replace('#','').trim();
  const full = h.length === 3 ? h.split('').map(c => c+c).join('') : h;
  const v = [0,2,4].map(i => parseInt(full.substr(i,2),16)/255);
  const c = v.map(x => x <= 0.03928 ? x/12.92 : Math.pow((x+0.055)/1.055, 2.4));
  return 0.2126*c[0] + 0.7152*c[1] + 0.0722*c[2];
}
function ratio(a,b){ const l1=lum(a), l2=lum(b); const hi=Math.max(l1,l2), lo=Math.min(l1,l2); return (hi+0.05)/(lo+0.05); }
const textos = filas.filter(f => ['texto','ambos'].includes(String(f.uso).toLowerCase()));
const fondos = filas.filter(f => ['fondo','ambos'].includes(String(f.uso).toLowerCase()));
const fallos = [];
for (const t of textos) {
  for (const f of fondos) {
    if (t.hex === f.hex) continue;
    const r = Math.round(ratio(t.hex, f.hex) * 100) / 100;
    if (r < 4.5) fallos.push({ texto: t.nombre, fondo: f.nombre, hex_texto: t.hex, hex_fondo: f.hex, ratio: r, nivel: r >= 3 ? 'solo vale para texto grande (24px+)' : 'no vale para nada' });
  }
}
fallos.sort((a,b) => a.ratio - b.ratio);
const html = '<h3>Combinaciones que no llegan a 4.5:1 (AA)</h3><table border=1 cellpadding=6><tr><th>Texto</th><th>Fondo</th><th>Ratio</th><th>Veredicto</th></tr>' + fallos.map(f => `<tr><td>${f.texto} (${f.hex_texto})</td><td>${f.fondo} (${f.hex_fondo})</td><td>${f.ratio}:1</td><td>${f.nivel}</td></tr>`).join('') + '</table>';
return [{ json: { total_fallos: fallos.length, fallos, html } }];
```
## Cómo probarla
Mete a propósito en la hoja un gris claro `#CCCCCC` marcado como `texto` y un blanco `#FFFFFF` como `fondo`. Pulsa «Execute Workflow» y comprueba que sale en la tabla con un ratio de 1.61.
Antes de activarla, desconecta el nodo Gmail y mira la salida del Code en el panel de la derecha para verificar los números.
## Qué puede salir mal
Colores escritos sin almohadilla o con nombre (`rojo`, `rgb(...)`): el código solo entiende hex. Añade una validación en la hoja o normaliza los valores antes.
Si la hoja tiene filas vacías al final, Google Sheets devuelve items con `hex` vacío y el cálculo da NaN. Añade `if (!f.hex) continue;` o borra las filas.
La zona horaria del workflow es UTC por defecto: si quieres el correo a las 8 de la mañana en España, fija `Europe/Madrid` en Settings.
## Cuánto cuesta
Gratis del todo: n8n auto-alojado no tiene límite de ejecuciones; n8n Cloud solo tiene prueba gratuita temporal y después es de pago, y esto gasta solo 4 ejecuciones al mes. Google Sheets y Gmail son gratis con tu cuenta normal (Gmail tiene un tope de 500 envíos diarios, aquí mandas uno).
