# Fábrica de exámenes y test desde tus propios apuntes…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Coges un PDF o un documento de tu temario, y el flujo genera un banco de preguntas tipo test con respuestas y explicaciones, y monta el examen directamente en un Google Form corregible.

## Qué es y qué hace

Flujo de n8n que coge un PDF de la carpeta Temario nuevo de Google Drive, extrae su texto y genera 25 preguntas tipo test con cuatro opciones, la correcta y una explicación breve. Guarda el banco en una hoja y crea un Google Form ya configurado como cuestionario autocorregible. Entra el PDF; sale el banco y el examen.

## Cómo usarla

1. Crea las carpetas Temario nuevo y Temario procesado en Drive
2. Ajusta la dificultad en el prompt
3. Genera el banco con Claude, Codex, Gemini o una IA local
4. Revisa cada pregunta antes de usarla en un examen

## Cuándo usarla

Úsalo cuando cada nuevo tema te obliga a inventarte 20 preguntas a mano y acabas reutilizando siempre las mismas.

## Cómo ganar dinero con ella

Un banco de 30 preguntas por tema te lleva 2 horas a mano. Con 10 temas al trimestre son 20 horas, unos 800 € de tu tiempo, por menos de 2 € de API.

- Bancos de test para academias de oposiciones que preparan temas nuevos cada año.
- Evaluaciones iniciales y finales para formadores de empresa con temarios que cambian.
- Material de autoevaluación para creadores de cursos que quieren entregar test con cada módulo.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Dejas un PDF en una carpeta de Drive llamada `Temario nuevo`. El flujo extrae el texto, genera 25 preguntas tipo test con 4 opciones, la correcta y una explicación breve, las guarda en una hoja y crea el Google Form ya configurado como cuestionario autocorregible.
Sirve igual para test de repaso, evaluación inicial y examen final: solo cambias la dificultad en el prompt.

## Lo que necesitas antes
- Carpeta en Google Drive llamada `Temario nuevo` y otra `Temario procesado`.
- Credenciales de Google Drive y Google Sheets en n8n (OAuth2).
- Clave de OpenAI.
- Un proyecto de Google Apps Script con un despliegue como aplicación web (Implementar > Nueva implementación > Aplicación web, ejecutar como Yo, acceso Cualquier usuario). Es lo que crea el formulario, porque la API de Forms no permite crear preguntas desde n8n de forma sencilla.

## Los nodos, en orden
1) **Google Drive Trigger** — Event: File Created, Folder: `Temario nuevo`, Poll Times: Every Hour.
2) **Google Drive** (Operation: Download File) — File `{{ $json.id }}`.
3) **Extract From File** (Operation: Extract From PDF) — Input Binary Field `data`. Devuelve el texto en `{{ $json.text }}`.
4) **Code** (Run Once for Each Item) — parte el texto en trozos de 6.000 caracteres para no pasarte de contexto. Código abajo.
5) **Split In Batches** (Batch Size 1) — recorre los trozos.
6) **OpenAI** (Message a Model) — Model `gpt-4o`, Response Format: JSON. System: «Eres un profesor español que crea test. A partir del texto genera preguntas tipo test de dificultad media-alta. Cada pregunta debe poder responderse SOLO con el texto dado. Nada de preguntas ambiguas ni de opciones tipo todas las anteriores. Devuelve JSON: {preguntas:[{enunciado, opciones:[4 strings], correcta:índice 0-3, explicacion}]}» User: `Genera 6 preguntas de este fragmento: {{ $json.trozo }}`.
7) **Code** — aplana todas las preguntas de todos los trozos en una lista y quita duplicados por enunciado. Código abajo.
8) **Google Sheets** (Append Row) — hoja `Banco de preguntas`, columnas: tema, enunciado, opcion_a, opcion_b, opcion_c, opcion_d, correcta, explicacion, fecha.
9) **HTTP Request** — Method POST, URL la de tu Apps Script, Body Content Type JSON, con `{ titulo, preguntas }`. El script crea el Form como cuestionario y devuelve su enlace.
10) **Google Drive** (Operation: Move File) — mueve el PDF a `Temario procesado` para no reprocesarlo.
11) **Gmail** (Send Message) — a ti, con el enlace del formulario y el recuento de preguntas.

## El código del nodo 4
```js
const texto = ($json.text || '').replace(/\n{2,}/g, '\n').trim();
const tam = 6000;
const trozos = [];
for (let i = 0; i < texto.length; i += tam) { trozos.push({ json: { trozo: texto.slice(i, i + tam), parte: trozos.length + 1 } }); }
return trozos.slice(0, 8);
```

## El código del nodo 7
```js
const vistas = new Set();
const out = [];
for (const it of items) {
  const datos = JSON.parse(it.json.message?.content ?? it.json.text);
  for (const p of datos.preguntas) {
    const clave = p.enunciado.toLowerCase().slice(0, 60);
    if (vistas.has(clave)) continue;
    vistas.add(clave);
    out.push({ json: { enunciado: p.enunciado, opcion_a: p.opciones[0], opcion_b: p.opciones[1], opcion_c: p.opciones[2], opcion_d: p.opciones[3], correcta: 'ABCD'[p.correcta], explicacion: p.explicacion } });
  }
}
return out;
```

## Cómo probarla
- Empieza con un PDF corto, de 4 o 5 páginas. Comprueba que las respuestas correctas están realmente en el texto: lee 5 preguntas al azar y búscalas en el temario.
- Si el PDF es un escaneo, el Extract From File devolverá vacío. Pásalo antes por el OCR gratuito de Google Drive (abrir con Documentos de Google).
- Prueba el Apps Script solo, con Postman o con un nodo HTTP Request manual, antes de encadenarlo.

## Qué puede salir mal
- **PDF escaneado sin texto**: añade un **IF** tras el paso 3 que compruebe que `{{ $json.text.length }}` es mayor que 500 y te avise si no.
- **Preguntas repetidas entre trozos**: lo cubre el filtro por enunciado del nodo 7, pero revisa el banco cada trimestre.
- **Alucinaciones**: la instrucción «solo con el texto dado» reduce mucho el problema, aunque conviene revisar el examen antes de darlo por bueno. Nunca lo publiques a ciegas.
- **Límite de Apps Script**: unas 20.000 llamadas al día en cuenta gratuita, de sobra.

## Cuánto cuesta
- Drive, Sheets, Forms y Apps Script: gratis.
- OpenAI `gpt-4o`: alrededor de 0,15 € por temario de 40 páginas. Con `gpt-4o-mini` bajas a 0,01 € con algo menos de calidad.
- n8n auto-alojado: gratis.
