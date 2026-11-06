# Corrector de entregas con rúbrica y feedback en 5 minut…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Recoge las entregas de tus alumnos, las pasa por una rúbrica que tú defines, devuelve una nota justificada y un comentario personalizado por email, y deja todo registrado. Para formadores.

## Qué es y qué hace

Flujo de n8n que recoge las entregas de un formulario de Google, las evalúa con un modelo de IA según tu rúbrica y devuelve una nota por criterio, tres puntos fuertes y tres mejoras concretas. Envía el resultado al alumno por email con copia a ti. Entra el texto de la entrega y la rúbrica; sale la nota justificada. Pensado para trabajos de 300 a 3.000 palabras.

## Cómo usarla

1. Vincula el formulario a la hoja de entregas
2. Escribe la rúbrica con criterios, pesos y qué es un 10
3. Elige el modelo entre Claude, Codex, Gemini o una IA local y revisa las primeras correcciones
4. Que lo revise un profesional docente (datos de alumnos)

## Cuándo usarla

Úsalo cuando corriges textos largos a mano y tardas días en devolver el feedback, que es justo cuando deja de servir.

## Cómo ganar dinero con ella

Si corriges 40 entregas al mes y cada una te lleva 15 minutos, recuperas 10 horas. A 40 €/hora son 400 € de tu tiempo al mes por unos céntimos de API.

- Primer pase de corrección para academias que reciben trabajos escritos cada semana.
- Feedback rápido para formadores de empresa que evalúan informes y casos prácticos.
- Corrección asistida para escuelas de escritura o cursos de redacción profesional.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
El alumno entrega por un formulario de Google (texto pegado o enlace a un documento). El flujo lo evalúa contra tu rúbrica, saca una nota por criterio, escribe tres puntos fuertes y tres mejoras concretas, y se lo manda por email al alumno con copia a ti.
Está pensado para trabajos escritos de 300 a 3.000 palabras. No sustituye tu criterio: sustituye el primer pase de corrección.

## Lo que necesitas antes
- Un Google Form con campos: Email, Nombre, Módulo, Texto de la entrega (respuesta larga). En Configuración activa «Recoger direcciones de correo».
- Vincula el formulario a una hoja de cálculo (pestaña Respuestas > icono verde de Sheets).
- Clave de Anthropic desde console.anthropic.com > API Keys (funciona igual con OpenAI cambiando el nodo).
- Un documento tuyo con la rúbrica: criterios, peso y qué es un 10 en cada uno. Lo pegarás dentro del prompt.

## Los nodos, en orden
1) **Google Sheets Trigger** — Event: On Row Added, Document: la hoja de respuestas, Sheet: `Respuestas de formulario 1`, Poll Times: Every Minute.
2) **IF** — Condition: String, `{{ $json['Texto de la entrega'] }}` is not empty. Evita procesar filas a medias.
3) **Code** (Run Once for Each Item) — cuenta palabras y recorta si es enorme. Código abajo.
4) **Anthropic** (Operation: Message a Model) — Model `claude-sonnet-5-5`, Max Tokens 1500. System: pega aquí tu rúbrica completa y esta instrucción: «Eres profesor corrector. Evalúa la entrega según la rúbrica. Devuelve SOLO un JSON válido con las claves: notas (objeto con un número del 0 al 10 por cada criterio), nota_final (número con un decimal), fuertes (array de 3 frases), mejoras (array de 3 frases accionables), comentario (párrafo de 60 palabras, tuteando, tono cercano español).» User: `{{ $json.texto_limpio }}`.
5) **Code** (Run Once for Each Item) — parsea el JSON con try/catch y monta el HTML del email. Código abajo.
6) **Gmail** (Send Message) — To `{{ $('Google Sheets Trigger').item.json['Dirección de correo electrónico'] }}`, Cc tu correo, Subject `Corrección de {{ $('Google Sheets Trigger').item.json.Módulo }}`, Email Type HTML, Message `{{ $json.html }}`.
7) **Google Sheets** (Operation: Append or Update Row) — hoja `Notas`, Matching Column `email_modulo`, columnas: email, nombre, módulo, nota_final, fecha, texto del comentario.

## El código del nodo 3
```js
let t = ($json['Texto de la entrega'] || '').replace(/\s+/g, ' ').trim();
const palabras = t.split(' ').length;
if (palabras > 4000) { t = t.split(' ').slice(0, 4000).join(' ') + ' [...texto recortado]'; }
return { json: { texto_limpio: t, palabras } };
```

## El código del nodo 5
```js
const bruto = $json.content ? $json.content[0].text : $json.text;
let r;
try { r = JSON.parse(bruto.replace(/```json|```/g, '').trim()); }
catch (e) { return { json: { html: '<p>No se pudo corregir automáticamente. Revisar a mano.</p>', nota_final: '', error: true } }; }
const li = (a) => a.map(x => `<li>${x}</li>`).join('');
const filas = Object.entries(r.notas).map(([k, v]) => `<tr><td>${k}</td><td><b>${v}</b></td></tr>`).join('');
const html = `<p>${r.comentario}</p><table border=1 cellpadding=6>${filas}</table><h3>Nota final: ${r.nota_final}</h3><h4>Lo que has hecho bien</h4><ul>${li(r.fuertes)}</ul><h4>Para la próxima</h4><ul>${li(r.mejoras)}</ul><p><i>Corrección orientativa revisada por tu tutor.</i></p>`;
return { json: { html, nota_final: r.nota_final } };
```

## Cómo probarla
- Manda tú mismo dos entregas por el formulario: una buena y una floja. Las notas deben separarse al menos 3 puntos; si no, tu rúbrica es demasiado vaga.
- Prueba una entrega vacía y una de 6.000 palabras para ver que el IF y el recorte funcionan.
- Durante las dos primeras semanas quita el `To` del alumno y mándatelo solo a ti.

## Qué puede salir mal
- **El modelo devuelve texto extra alrededor del JSON**: por eso el Code limpia los ```json y usa try/catch. Si falla mucho, añade al System «No escribas nada fuera del JSON».
- **Inflación de notas**: los modelos son generosos. Añade a la rúbrica ejemplos de un 4, un 7 y un 9 reales tuyos.
- **Protección de datos**: avisa en el formulario de que la corrección usa una herramienta de IA. No metas datos de salud ni de menores identificables.
- **El trigger dispara dos veces**: si Sheets tarda en guardar la fila, puede leerse incompleta. El IF del paso 2 lo evita en casi todos los casos.

## Cuánto cuesta
- Formularios, Sheets y Gmail: gratis.
- Anthropic: entre 0,01 y 0,04 € por entrega larga. 40 entregas al mes son menos de 2 €.
- n8n auto-alojado gratis; con Make necesitarías el plan Core (unos 10 €/mes) por el volumen de operaciones.
