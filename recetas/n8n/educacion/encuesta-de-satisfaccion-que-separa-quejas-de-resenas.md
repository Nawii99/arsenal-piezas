# Encuesta de satisfacción de fin de curso con reseña para todos…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Manda la encuesta al acabar el curso, pide la reseña en Google a todos los alumnos por igual y, si la nota es baja, abre además un aviso urgente para que lo llames.

## Qué es y qué hace

Dos días después de terminar el curso envía una encuesta de satisfacción con nota del 0 al 10. Con cualquier nota, el alumno recibe la misma petición de reseña en Google; si la nota es 7 u 8 pide además una sugerencia concreta; si es 6 o menos te avisa al momento con la respuesta completa para que le llames. Calcula el NPS mensual y lo guarda en una hoja de Google Sheets para ver la evolución.

## Cómo usarla

1. Crea el Google Form y la hoja Matriculas
2. Pega el enlace de reseñas de tu ficha
3. Conecta Gmail y Sheets en n8n
4. Revisa las alertas de notas bajas

## Cuándo usarla

Úsalo cuando no sabes qué opinan tus alumnos hasta que ves una reseña de una estrella en Google.

## Cómo ganar dinero con ella

Multiplica las reseñas, que es lo que trae matrículas nuevas, y te deja atender antes a quien sale descontento. Una queja sin atender en una academia local cuesta matrículas.

- Puesta en marcha de encuesta y reseñas para academias, con NPS mensual en una hoja.
- Gestión mensual de reseñas y alertas para un centro que recibe valoraciones de varios cursos.
- Plantilla de encuesta de cierre de curso para autónomos de formación que quieren más reseñas en Google.

**Precio orientativo:** 120–280 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
A los 2 días de terminar el curso manda una encuesta corta (nota del 0 al 10 y un campo libre). Un segundo email con el enlace directo de reseña en Google sale a todos por igual, sea cual sea su nota (Google y las tiendas prohíben pedirla solo a quien está contento). Además, si la nota es 7 u 8, le pide una sugerencia concreta; si es 6 o menos, te avisa a ti al momento por Slack o email con la respuesta entera para que lo resuelvas y le llames.
Además calcula tu NPS mensual y lo apunta en una hoja para ver la evolución.

## Lo que necesitas antes
- Hoja `Matriculas` con: `nombre`, `email`, `curso`, `fecha_fin`, `encuesta_enviada`, `nota`, `comentario`, `seguimiento`.
- Un Google Form con: Email, Nota del 0 al 10 (escala lineal), «¿Qué es lo que más te ha servido?» y «¿Qué cambiarías?». Vinculado a una hoja `Respuestas`.
- El enlace corto para dejar reseña en tu ficha de Google: entra en tu Perfil de Empresa, botón «Pedir reseñas», y copia la URL.
- Credenciales de Sheets y Gmail. Opcional: un webhook de Slack (api.slack.com > Incoming Webhooks).

## Los nodos, en orden
**Flujo A: enviar la encuesta**
1) **Schedule Trigger** — Cron `0 10 * * *`, Timezone `Europe/Madrid`.
2) **Google Sheets** (Get Rows) — hoja `Matriculas`, Return All.
3) **Code** — selecciona a quien terminó hace exactamente 2 días y no tiene encuesta enviada. Código abajo.
4) **Gmail** (Send Message) — Subject `{{ $json.nombre }}, ¿cómo ha ido el curso?`, cuerpo breve con el enlace del formulario y `?usp=pp_url&entry.XXXX={{ $json.email }}` para prerrellenar (el `entry.XXXX` lo sacas del código fuente del formulario o del enlace prerrellenado).
5) **Google Sheets** (Update Row) — marca `encuesta_enviada` con la fecha.
**Flujo B: enrutar la respuesta**
6) **Google Sheets Trigger** — On Row Added, hoja `Respuestas`, Poll Every Minute.
6b) Desde el nodo 6, en paralelo y sin pasar por el Switch: **Wait** de 1 hora y **Gmail** (Send Message) con el asunto `Un favor de 30 segundos` y el enlace de reseña de Google. Sale el mismo correo a todas las notas.
7) **Switch** (Mode: Rules) — Rule 1: `{{ Number($json.Nota) }}` >= 9 → `promotor`. Rule 2: >= 7 → `pasivo`. Fallback → `detractor`.
8) En `promotor`: **Gmail** (Send Message) con un agradecimiento breve. La petición de reseña no sale de aquí, sino del nodo 6b.
9) En `pasivo`: **Gmail** con `¿Qué nos falta para el 10?` y una pregunta abierta con respuesta directa a tu correo.
10) En `detractor`: **Slack** (Operation: Send Message) al canal `#alertas` con nota, nombre, curso y comentario completo; y **Gmail** a ti con el asunto `URGENTE: nota {{ $json.Nota }} de {{ $json['Dirección de correo electrónico'] }}`.
11) **Google Sheets** (Append or Update Row) — vuelca nota y comentario en `Matriculas`, Matching Column `email`.
**Flujo C: NPS mensual**
12) **Schedule Trigger** — Cron `0 9 1 * *`.
13) **Google Sheets** (Get Rows) + **Code** con la fórmula del NPS. Código abajo.
14) **Gmail** — informe mensual a dirección.

## El código del nodo 3
```js
const hoy = new Date();
const diff = (f) => Math.floor((hoy - new Date(f)) / 86400000);
return items.filter(i => i.json.fecha_fin && diff(i.json.fecha_fin) === 2 && !i.json.encuesta_enviada);
```

## El código del NPS
```js
const mes = new Date().getMonth();
const notas = items.map(i => Number(i.json.nota)).filter(n => !isNaN(n));
const prom = notas.filter(n => n >= 9).length;
const det = notas.filter(n => n <= 6).length;
const nps = notas.length ? Math.round(((prom - det) / notas.length) * 100) : 0;
return [{ json: { respuestas: notas.length, promotores: prom, detractores: det, nps, media: notas.length ? (notas.reduce((a,b)=>a+b,0)/notas.length).toFixed(1) : 0 } }];
```

## Cómo probarla
- Rellena el formulario tres veces con nota 10, 8 y 4. Comprueba que cada una toma su camino y que las tres reciben la petición de reseña.
- Cambia la fecha de fin de un alumno de prueba a hace 2 días y lanza el flujo A a mano.
- Comprueba que el prerrelleno del email funciona: si no, el flujo B no sabrá de quién es cada respuesta.

## Qué puede salir mal
- **Pedir reseña solo a los contentos**: es el error, y Google y las tiendas lo prohíben. La petición de reseña sale a todos por el nodo 6b; el Switch solo decide el resto.
- **El alumno no pone su email**: activa «Recoger direcciones de correo» en el formulario y hazlo obligatorio.
- **Comentarios negativos que se te pasan**: el aviso por Slack tiene que ir a un canal que mires. Si no usas Slack, manda un SMS con Twilio.
- **Encuesta enviada dos veces**: la marca `encuesta_enviada` es imprescindible; sin ella, cada día vuelve a mandarla.

## Cuánto cuesta
- Todo gratis: Forms, Sheets, Gmail y Slack en su plan libre.
- n8n auto-alojado gratis; en Make cabe en el plan gratuito con menos de 300 alumnos al mes.
