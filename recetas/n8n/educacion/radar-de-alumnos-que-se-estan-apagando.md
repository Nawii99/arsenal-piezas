# Radar de alumnos que se están apagando…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Vigila cada semana quién ha dejado de entrar al curso, le pone una nota de riesgo y te avisa solo de los que aún puedes rescatar, con un email personalizado ya escrito.

## Qué es y qué hace

Cada lunes lee la hoja de progreso de los alumnos, calcula los días sin actividad y el porcentaje completado, y asigna un nivel de riesgo. Los de riesgo medio reciben un correo de reenganche según dónde se atascaron; los de riesgo alto llegan por Telegram para que alguien les llame. Entran datos de progreso y salen correos y avisos. Para cursos online con campus, con n8n, Sheets y Gmail.

## Cómo usarla

1. Define los niveles de riesgo y sus umbrales
2. Conecta la hoja de progreso con n8n
3. Escribe los correos de reenganche por bloque
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando vendas cursos online o formación con campus y notes que la gente se apunta, entra dos veces y desaparece sin que te enteres hasta el reembolso.

## Cómo ganar dinero con ella

Rescatar 3 alumnos al mes de un curso de 300 euros son 900 euros que ya estaban perdidos, sin que tú revises hojas de progreso a mano.

- Implantación de radar de riesgo para escuelas online con campus, con correos y avisos automáticos.
- Revisión semanal de riesgo y seguimiento de alumnos rescatables para formadores, por cuota.
- Plantilla de reenganche por bloques que se vende a creadores de cursos grabados.

**Precio orientativo:** 200–400 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada lunes lee la hoja de progreso de tus alumnos, calcula cuántos días llevan sin actividad y qué porcentaje del curso han completado, y les asigna un nivel de riesgo. A los de riesgo medio les manda un email de reenganche distinto según dónde se atascaron; a los de riesgo alto te los pasa a ti por Telegram para que llames tú.

## Lo que necesitas antes
- Cuenta de n8n (Cloud gratis o auto-alojado con Docker).
- Una Google Sheet llamada `Alumnos` con columnas: `email`, `nombre`, `curso`, `fecha_alta`, `ultimo_acceso`, `pct_completado`, `ultima_leccion`, `ultimo_aviso`.
- Credencial de Google Sheets en n8n: en Google Cloud Console creas un proyecto, activas Google Sheets API, creas credencial OAuth y pegas Client ID y Secret en n8n (Credentials > Google Sheets OAuth2).
- Credencial de Gmail OAuth2 en n8n (mismo proyecto de Google, activando Gmail API).
- Bot de Telegram: escribe a @BotFather, `/newbot`, copia el token. Escribe algo a tu bot y saca tu chat_id en `https://api.telegram.org/bot<TOKEN>/getUpdates`.
- Si tu plataforma es Moodle, Thinkific o Teachable, exporta el progreso a esa hoja con su propia integración o pega el CSV cada semana; el resto funciona igual.

## Los nodos, en orden
1. **Schedule Trigger** — modo `Cron`, expresión `0 8 * * 1` (lunes 8:00). En Settings del workflow pon Timezone `Europe/Madrid`.
2. **Google Sheets** (operación `Get Row(s)`) — documento `Alumnos`, hoja `Hoja 1`, devuelve todas las filas.
3. **Code** (Run Once for All Items) — calcula días de inactividad y riesgo. Código completo abajo.
4. **IF** — condición `{{ $json.riesgo }}` *equals* `alto`. Rama true a Telegram, rama false al siguiente IF.
5. **Telegram** (operación `Send Message`) — chat_id el tuyo, texto: `RIESGO ALTO: {{ $json.nombre }} ({{ $json.email }}) lleva {{ $json.dias }} días sin entrar en {{ $json.curso }}, al {{ $json.pct_completado }}%. Última lección: {{ $json.ultima_leccion }}.`
6. **IF** (segundo) — condición `{{ $json.riesgo }}` *equals* `medio`.
7. **Gmail** (operación `Send`) — Para: `{{ $json.email }}`, Asunto: `{{ $json.nombre }}, te dejé a medias en {{ $json.ultima_leccion }}`, cuerpo el que devuelve el Code en `{{ $json.mensaje }}`.
8. **Google Sheets** (operación `Update Row`) — busca por columna `email` y escribe en `ultimo_aviso` el valor `{{ $now.format('yyyy-MM-dd') }}` para no repetir el email la semana siguiente.

## El código del nodo Code
```javascript
const hoy = new Date();
const salida = [];
for (const item of $input.all()) {
  const a = item.json;
  if (!a.email) continue;
  const ultimo = new Date(a.ultimo_acceso);
  const dias = Math.floor((hoy - ultimo) / 86400000);
  const pct = Number(a.pct_completado) || 0;
  const avisado = a.ultimo_aviso ? new Date(a.ultimo_aviso) : null;
  const diasDesdeAviso = avisado ? Math.floor((hoy - avisado) / 86400000) : 999;
  let riesgo = 'ninguno';
  if (dias >= 21 && pct < 80) riesgo = 'alto';
  else if (dias >= 10 && pct < 80) riesgo = 'medio';
  if (diasDesdeAviso < 14) riesgo = 'ninguno';
  if (riesgo === 'ninguno') continue;
  const mensaje = `Hola ${a.nombre},\n\nVi que te quedaste en "${a.ultima_leccion}" del curso ${a.curso}. Es justo la parte donde más gente se atasca, así que no eres tú.\n\nSi respondes a este correo contándome dónde te trabaste, te contesto yo en persona con el atajo.\n\nY si esta semana no tienes hueco, dime qué día sí y te escribo ese día.\n\nUn abrazo`;
  salida.push({ json: { ...a, dias, riesgo, mensaje } });
}
return salida;
```

## Cómo probarla
- Duplica la hoja y deja solo 3 filas de prueba con tu propio email: una con `ultimo_acceso` de hace 5 días, otra de hace 12 y otra de hace 30.
- Pulsa `Execute Workflow` y comprueba que solo salen dos alumnos y con el riesgo correcto.
- Antes de activar, cambia el destinatario del Gmail a tu correo con `{{ 'tucorreo@ejemplo.com' }}` fijo y mira cómo llega el texto. Cuando te guste, devuélvelo a `{{ $json.email }}` y pulsa `Active`.

## Qué puede salir mal
- **Fechas raras**: si la hoja guarda `03/09/2026` en vez de `2026-09-03`, el cálculo falla. Formatea la columna como texto ISO o cambia el parseo en el Code.
- **Zona horaria**: sin Timezone `Europe/Madrid` el cron dispara a las 10:00 en verano. Se pone en Settings del workflow, no en el nodo.
- **Emails repetidos**: si te saltas el paso 8, el mismo alumno recibe el aviso cada lunes y te ve como spam. La columna `ultimo_aviso` es obligatoria.
- **Límite de Gmail**: 500 envíos al día en cuentas gratuitas, 2.000 en Workspace. Con más alumnos, mete un nodo **Split In Batches** de 50 y un **Wait** de 60 segundos.

## Cuánto cuesta
- n8n auto-alojado: 0 euros (o 4-6 euros/mes de un VPS pequeño). n8n Cloud tiene plan de inicio desde unos 20 euros/mes.
- Google Sheets y Gmail: gratis con cuenta personal. Telegram: gratis, sin límite práctico.
- Coste total realista: 0 euros si te auto-alojas.
