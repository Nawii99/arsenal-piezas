# Diario de hábitos por Telegram con racha y resumen sema…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Te pregunta cada noche por Telegram cómo has ido con tus hábitos, guarda las respuestas en una hoja y te manda el domingo un resumen con tu racha y tus porcentajes.

## Qué es y qué hace

Cada noche envía por Telegram botones para marcar tus hábitos del día y guarda cada respuesta en la pestaña Registro de Google Sheets; los domingos calcula cuántos días has cumplido cada uno, la racha actual y la mejor. Entrada: respuestas del bot; salida: registro y resumen. Se monta en n8n y sirve como servicio de coaching o nutrición.

## Cómo usarla

1. Crea el bot con @BotFather y obtén tu chat_id
2. Prepara la pestaña Registro
3. Programa el cron nocturno y el resumen del domingo
4. Que lo revise un profesional

## Cuándo usarla

Cuando quieres seguir hábitos (agua, entrenamiento, sueño, meditación) tuyos o de tus clientes sin pagar una app de suscripción ni rellenar nada a mano.

## Cómo ganar dinero con ella

Sustituye apps de seguimiento de 5-10 €/mes por cliente. Con 15 clientes de coaching son 100 €/mes ahorrados y un informe semanal que antes hacías tú en 20 minutos.

- Diario de hábitos por Telegram montado para cada cliente de un programa de coaching.
- Informe semanal de cumplimiento para nutricionistas que quieren seguimiento sin app.
- Plantilla de hábitos y resumen automático para retos de bienestar de 30 días.

**Precio orientativo:** 100–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada noche a las 21:30 te llega un mensaje de Telegram con botones para marcar tus hábitos del día; tú pulsas y queda registrado en Google Sheets con la fecha.
Los domingos a las 19:00 recibes un resumen: cuántos días has cumplido cada hábito, tu racha actual y tu mejor racha. Vale para ti mismo o para dárselo montado a cada cliente de coaching o nutrición.

## Lo que necesitas antes
- Cuenta de Telegram. Escribe a @BotFather, comando `/newbot`, ponle nombre y te da un token tipo `123456:AAxx...`.
- Tu chat_id: escríbele algo a tu nuevo bot y luego abre en el navegador `https://api.telegram.org/botTU_TOKEN/getUpdates`; el número que aparece en `chat.id` es el tuyo.
- Google Sheets con la pestaña `Registro` y columnas: fecha, habito, valor, chat_id.
- n8n con la credencial Telegram API (pega el token del BotFather).

## Los nodos, en orden
1. **Schedule Trigger** – Cron `30 21 * * *`, Timezone Europe/Madrid.
2. **Telegram** – Resource: Message, Operation: Send Message. Chat ID: el tuyo. Text: «Hábitos de hoy. Marca lo que hayas cumplido:». En Additional Fields > Reply Markup elige `Inline Keyboard` y crea botones con estos callback_data: `agua`, `deporte`, `sueno`, `meditacion`, `ninguno`.
3. **Telegram Trigger** (workflow número dos, llámalo «Recoger hábito») – Updates: marca `callback_query`. Este nodo se dispara cada vez que pulsas un botón.
4. **Code** – convierte la pulsación en una fila. Código abajo.
5. **Google Sheets** – Operation: Append. Hoja `Registro`. Mapea fecha, habito, valor, chat_id.
6. **Telegram** – Send Message: «Apuntado: {{ $json.habito }}». Así sabes que ha entrado.
7. **Schedule Trigger** (workflow número tres, «Resumen semanal») – Cron `0 19 * * 0`, Timezone Europe/Madrid.
8. **Google Sheets** – Read Rows de `Registro`, Return All activado.
9. **Code** – calcula porcentajes de los últimos 7 días y las rachas. Código abajo.
10. **Telegram** – Send Message con Parse Mode: `Markdown` y el texto que devuelve el Code.

## El código del paso 4
```
const cb = $json.callback_query;
const habito = cb.data;
const hoy = new Date().toLocaleDateString('sv-SE', { timeZone: 'Europe/Madrid' });
return [{ json: { fecha: hoy, habito, valor: habito === 'ninguno' ? 0 : 1, chat_id: cb.from.id } }];
```

## El código del paso 9
```
const filas = $input.all().map(i => i.json);
const hoy = new Date();
const dias = [];
for (let d = 6; d >= 0; d--) { const f = new Date(hoy); f.setDate(f.getDate() - d); dias.push(f.toLocaleDateString('sv-SE', { timeZone: 'Europe/Madrid' })); }
const habitos = ['agua', 'deporte', 'sueno', 'meditacion'];
let texto = '*Tu semana*\n';
for (const h of habitos) {
  const cumplidos = dias.filter(dia => filas.some(f => f.fecha === dia && f.habito === h && String(f.valor) === '1'));
  const pct = Math.round((cumplidos.length / 7) * 100);
  let racha = 0;
  for (let i = dias.length - 1; i >= 0; i--) { if (cumplidos.includes(dias[i])) racha++; else break; }
  texto += `\n${h}: ${cumplidos.length}/7 (${pct}%) · racha ${racha}`;
}
return [{ json: { texto } }];
```

## Cómo probarla
- Ejecuta el workflow 1 a mano: te debe llegar el mensaje con los botones.
- Activa el workflow 2 (el Telegram Trigger solo funciona con el workflow activo, no en modo test prolongado) y pulsa un botón. Mira que aparece una fila nueva en la hoja.
- Mete a mano 10 filas de días anteriores en la hoja y ejecuta el workflow 3: comprueba que los porcentajes cuadran contando tú.
- Pulsa dos veces el mismo botón: verás dos filas. Si te molesta, en el paso 5 usa Append or Update con una columna llave `fecha_habito` que montes en el Code como `fecha + '_' + habito`.

## Qué puede salir mal
- **Solo puede haber un Telegram Trigger activo por bot**: si montas varios flujos con el mismo token, se pisan. Usa un bot distinto por flujo o un solo trigger que reparta con un IF.
- **El botón se queda girando**: Telegram espera un `answerCallbackQuery`. Añade un nodo **Telegram** (Resource: Callback, Operation: Answer Query) con el `callback_query_id` y tu credencial de Telegram. No pongas el token en la URL de un HTTP Request: un flujo exportado se llevaría la clave.
- **Fechas desfasadas**: usa siempre `toLocaleDateString('sv-SE', {timeZone:'Europe/Madrid'})`, que da `2026-09-09` y ordena bien alfabéticamente.
- **n8n auto-alojado sin URL pública**: el Telegram Trigger necesita webhook accesible. Si estás en local, arranca n8n con el túnel (`n8n start --tunnel`) solo para probar, y para producción usa un dominio o n8n Cloud.
- **Esto no es un registro médico**: no metas síntomas ni medicación, solo hábitos. Y si lo usas con clientes, pídeles permiso por escrito para guardar sus datos.

## Cuánto cuesta
- Telegram: gratis, sin límite práctico.
- Google Sheets: gratis.
- n8n auto-alojado: 0 €. En la nube, el plan de entrada te cubre de sobra estas ejecuciones.
