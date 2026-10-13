# Repaso espaciado por email a partir de tu propio temari…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Convierte tu temario en preguntas y se las va mandando al alumno con el ritmo justo para que no se le olvide: al día 1, 3, 7, 16 y 35 desde que vio cada lección.

## Qué es y qué hace

Convierte tu temario en un banco de preguntas y cada mañana calcula qué alumno toca repasar según la curva de 1, 3, 7, 16 y 35 días desde que vio cada lección. Le envía un correo con tres preguntas de esa lección y las respuestas ocultas al final. Entran el temario y las fechas de cada lección, y salen correos personalizados. Sirve como producto de recuerdo para cursos online, con n8n y Gmail.

## Cómo usarla

1. Carga el temario en una hoja por lección
2. Genera el banco de preguntas con una IA de texto y revísalo
3. Programa el envío diario según la curva
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tus alumnos terminen el curso y a las tres semanas no recuerden nada, o cuando quieras un producto de recuerdo que dé valor sin trabajo extra.

## Cómo ganar dinero con ella

Es un producto añadido que puedes cobrar aparte (10-15 euros al mes) o usar como argumento de venta, sin dedicar ni una hora a la semana.

- Montaje de repaso espaciado para academias que quieren retener a sus alumnos, cobrado como servicio puntual.
- Producto de recuerdo mensual para alumnos de cursos online, gestionado por ti y cobrado aparte.
- Paquete de repaso vendido a escuelas de idiomas y de oposiciones como complemento del curso.

**Precio orientativo:** 200–400 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Una vez generas un banco de preguntas a partir de tu temario. A partir de ahí, cada mañana el flujo mira qué alumno toca según la curva de repaso (1, 3, 7, 16 y 35 días desde que completó cada lección) y le manda un email con 3 preguntas de esa lección y las respuestas ocultas al final. No es un boletín: cada uno recibe lo suyo.

## Lo que necesitas antes
- n8n instalado.
- Hoja `Temario` con: `leccion`, `texto_resumen` (o el enlace al guion).
- Hoja `Preguntas` con: `leccion`, `pregunta`, `respuesta`. Se rellena sola con el flujo de preparación.
- Hoja `Progreso` con: `email`, `nombre`, `leccion`, `fecha_completada`.
- Credencial OpenAI y credenciales Google Sheets y Gmail en n8n.

## Flujo A, el de preparación (se ejecuta una vez)
1. **Manual Trigger**.
2. **Google Sheets** (`Get Row(s)`) sobre `Temario`.
3. **Split In Batches** — Batch Size 1.
4. **OpenAI** (`Message a Model`) — modelo `gpt-4.1-mini`. Sistema: `Eres profesor. A partir del texto, escribe 8 preguntas de repaso activo (nada de sí/no) con su respuesta de 2 frases. Devuelve JSON: {"items":[{"pregunta":"...","respuesta":"..."}]}`. Usuario: `{{ $json.texto_resumen }}`. Activa Output as JSON.
5. **Code** — expande el array en filas con la lección.
6. **Google Sheets** (`Append Row`) sobre `Preguntas`.

## Flujo B, el diario
1. **Schedule Trigger** — `0 7 * * *`, timezone `Europe/Madrid`.
2. **Google Sheets** (`Get Row(s)`) sobre `Progreso`.
3. **Google Sheets** (`Get Row(s)`) sobre `Preguntas`.
4. **Code** — decide a quién le toca hoy y monta el email. Código abajo.
5. **Gmail** (`Send`) — Para `{{ $json.email }}`, Asunto `Repaso de {{ $json.leccion }} (día {{ $json.dia }})`, cuerpo `{{ $json.html }}` en modo HTML.

## El código del nodo Code del flujo B
```javascript
const INTERVALOS = [1, 3, 7, 16, 35];
const progreso = $('Google Sheets').all().map(i => i.json);
const banco = $('Google Sheets1').all().map(i => i.json);
const hoy = new Date();
const salida = [];
for (const p of progreso) {
  if (!p.email || !p.fecha_completada) continue;
  const dias = Math.floor((hoy - new Date(p.fecha_completada)) / 86400000);
  if (!INTERVALOS.includes(dias)) continue;
  const pool = banco.filter(q => q.leccion === p.leccion);
  if (pool.length === 0) continue;
  const idx = INTERVALOS.indexOf(dias);
  const elegidas = [];
  for (let k = 0; k < 3; k++) elegidas.push(pool[(idx * 3 + k) % pool.length]);
  const preguntas = elegidas.map((q, i) => `<p><b>${i + 1}.</b> ${q.pregunta}</p>`).join('');
  const respuestas = elegidas.map((q, i) => `<p><b>${i + 1}.</b> ${q.respuesta}</p>`).join('');
  const html = `<p>Hola ${p.nombre}, tres preguntas de <b>${p.leccion}</b>. Respóndelas de cabeza antes de bajar.</p>${preguntas}<br><br><br><br><hr><p><i>Respuestas:</i></p>${respuestas}`;
  salida.push({ json: { email: p.email, nombre: p.nombre, leccion: p.leccion, dia: dias, html } });
}
return salida;
```

## Cómo probarla
- Mete en `Progreso` una fila tuya con `fecha_completada` de ayer: al ejecutar debe salir el repaso de día 1.
- Cambia la fecha a hace 3 días y comprueba que las preguntas son distintas a las del día 1.
- Revisa el email en el móvil: el bloque de saltos antes de las respuestas es lo que evita que se vean sin querer.

## Qué puede salir mal
- **Ejecución fallida un día**: ese repaso se pierde para siempre, porque solo se envía si `dias` cae justo en el intervalo. Cambia `includes(dias)` por una lógica con columna `ultimo_repaso` si te preocupa.
- **Lecciones sin preguntas**: el `continue` las salta en silencio. Añade un aviso a Telegram si `pool.length === 0`.
- **Preguntas malas de la IA**: revísalas a mano una vez en la hoja. Son tuyas para siempre, merece la pena la hora.
- **Marcado como spam**: manda desde tu dominio con SPF y DKIM configurados si envías a más de 50 personas al día.

## Cuánto cuesta
- Generar el banco: una vez, menos de 1 euro para 20 lecciones.
- Envío diario: gratis con Gmail hasta 500 correos/día. Por encima, un servicio como Brevo (300 emails/día gratis).
- n8n auto-alojado: 0 euros.
