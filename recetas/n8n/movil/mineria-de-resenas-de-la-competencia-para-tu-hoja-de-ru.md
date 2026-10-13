# Minería de reseñas de la competencia para tu hoja de ru…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Lee cada semana las reseñas de una y dos estrellas de tus rivales, agrupa las quejas por tema y te dice qué funciones les faltan.

## Qué es y qué hace

Receta de n8n que cada lunes descarga las reseñas recientes de las apps competidoras que indiques, conserva las de una a tres estrellas, las agrupa por temas con IA y entrega un informe con las cinco quejas más repetidas y las funciones que piden los usuarios. Entrada: IDs de App Store de los rivales. Salida: informe semanal de temas. Solo usa las reseñas públicas más recientes del RSS de Apple.

## Cómo usarla

1. Lista los IDs de los rivales
2. Define los temas y el umbral de estrellas
3. Lee el informe y decide qué construir

## Cuándo usarla

Cuando tienes que decidir qué construir el próximo trimestre y quieres basarte en lo que los usuarios ya están pidiendo a gritos en otras apps.

## Cómo ganar dinero con ella

Sustituye un estudio de mercado de 500-1.500 €. Sobre todo evita meses de desarrollo en una función que a nadie le importa.

- Investigación de producto para una app de nicho con tres rivales…
- Priorización de funciones para el próximo trimestre de una app…
- Análisis de quejas de la competencia antes de entrar en un mercado…

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Cada lunes descarga las reseñas recientes de las apps competidoras que elijas, se queda con las de una a tres estrellas, las agrupa por temas con IA y te entrega un informe con las cinco quejas más repetidas y las funciones que los usuarios piden. Para quien decide el producto y quiere priorizar con datos, no con corazonadas.

## Lo que necesitas antes
- Los **IDs de App Store** de tus competidores.
- Saber que el canal RSS público de Apple devuelve unas 50 reseñas por página y hasta 10 páginas, y que solo trae las más recientes. Es suficiente para ver tendencias.
- Clave de OpenAI (o de Anthropic con un nodo HTTP Request).
- Credencial de Google Docs en n8n (activa la Google Docs API en Google Cloud) o, si te resulta más fácil, escribe el informe en una hoja de Sheets.
- Credencial de Gmail o SMTP para mandarte el informe.
- Una lista fija de competidores dentro de un nodo Code o en una hoja `competidores`.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Weeks, Monday, Hour: 8.
2. **Code** (nombre: Generar URLs) — construye una salida por competidor y por página del RSS (páginas 1 a 5). Código abajo.
3. **Split In Batches** — Batch Size: 1, con un **Wait** de 2 segundos dentro del bucle.
4. **HTTP Request** — GET `{{ $json.url }}`. Response Format: JSON. Options → Never Error activado (algunas páginas devuelven vacío).
5. **Code** (nombre: Aplanar reseñas) — saca de `feed.entry` el título, el texto, la nota y la versión, ignorando la primera entrada que es la propia app.
6. **Filter** — Condition: Number `{{ $json.nota }}` «is smaller than or equal» 3.
7. **Aggregate** — Aggregate: All Item Data, para juntar todas las reseñas malas en un solo elemento.
8. **Code** (nombre: Preparar prompt) — recorta a las 150 reseñas más recientes y las une en un texto numerado, para no pasarte de tokens.
9. **OpenAI** — Model: gpt-4o (aquí sí merece el modelo bueno). System: «Eres analista de producto. A partir de estas reseñas negativas de apps competidoras, devuelve: 1) los 5 temas de queja más repetidos con el número aproximado de menciones, 2) las 5 funciones que los usuarios piden explícitamente, 3) 3 oportunidades concretas para una app rival, en español de España, en formato Markdown y sin inventar nada que no esté en el texto.»
10. **Google Docs** — Operation: Create, Title: `Informe reseñas competencia {{ $now.format('yyyy-MM-dd') }}`, y luego un segundo nodo Google Docs con Operation: Update → Insert para volcar el texto.
11. **Gmail** — Send con el resumen y el enlace al documento.

## El trozo de código (nodo Code «Generar URLs»)
```javascript
const COMPETIDORES = [
  { nombre: 'Rival A', id: '1234567890' },
  { nombre: 'Rival B', id: '9876543210' }
];
const PAIS = 'es';
const salida = [];
for (const c of COMPETIDORES) {
  for (let p = 1; p <= 5; p++) {
    salida.push({ json: {
      nombre: c.nombre,
      id: c.id,
      pagina: p,
      url: `https://itunes.apple.com/${PAIS}/rss/customerreviews/page=${p}/id=${c.id}/sortby=mostrecent/json`
    }});
  }
}
return salida;
```

## El segundo trozo de código (nodo Code «Aplanar reseñas»)
```javascript
const feed = $input.first().json.feed || {};
const entradas = Array.isArray(feed.entry) ? feed.entry : (feed.entry ? [feed.entry] : []);
const comp = $('Split In Batches').item.json.nombre;
return entradas.filter(e => e['im:rating']).map(e => ({ json: {
  competidor: comp,
  nota: Number(e['im:rating'].label),
  titulo: e.title?.label || '',
  texto: (e.content?.label || '').replace(/\s+/g, ' ').slice(0, 600),
  version: e['im:version']?.label || '',
  autor: e.author?.name?.label || ''
}}));
```

## Cómo probarla
- Ejecuta con un solo competidor y una sola página; deben salir entre 40 y 50 reseñas.
- Lee tú mismo 20 de esas reseñas y compáralas con lo que dice el informe: si la IA se inventa temas que no ves, endurece el prompt con «cita textualmente una frase de ejemplo por cada tema».
- Guarda el primer informe y compáralo con el del mes siguiente: ahí es donde está el valor.

## Qué puede salir mal
- **El RSS puede venir vacío** para apps con pocas reseñas o en páginas altas: por eso Never Error y el filtro de entradas sin nota.
- **Solo reseñas recientes**: no sirve para histórico largo. Si quieres serie temporal, guarda cada semana en Sheets y acumula tú.
- **Coste de tokens**: 150 reseñas de 600 caracteres son unos 25.000 tokens; con gpt-4o ronda 0,10-0,15 € por informe. No metas 1.000 reseñas de golpe.
- **Bloqueo por peticiones rápidas**: mantén el Wait de 2 segundos.
- **Sesgo**: las reseñas negativas exageran. Cruza siempre con las de 4 y 5 estrellas antes de tirar tu hoja de ruta a la basura.

## Cuánto cuesta
RSS de Apple gratis. Docs y Gmail gratis. IA: unos 0,50 € al mes con informe semanal. n8n auto-alojado 0 €. Total: menos de 1 € al mes.
