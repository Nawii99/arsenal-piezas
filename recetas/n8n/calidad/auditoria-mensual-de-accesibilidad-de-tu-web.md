# Auditoría mensual de accesibilidad de tu web…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Analiza cada mes tus páginas principales y te lista los fallos de accesibilidad concretos: contraste, imágenes sin descripción, botones sin nombre y formularios sin etiqueta.

## Qué es y qué hace

Flujo de n8n que cada mes pasa la API de PageSpeed Insights (motor de Lighthouse) por tus URLs clave y extrae los fallos de accesibilidad: contraste, imágenes sin texto alternativo, botones sin nombre y formularios sin etiqueta. Entra tu clave gratuita y la lista de URLs; sale un informe ordenado por impacto en lenguaje sencillo. No sustituye una auditoría manual.

## Cómo usarla

1. Crea la clave gratuita de PageSpeed Insights
2. Rellena la hoja Accesibilidad con tus URLs
3. Programa el informe mensual
4. Que lo revise un profesional (normativa de accesibilidad)

## Cuándo usarla

Úsalo cuando vendas online o tengas una web de empresa y quieras cumplir la normativa europea de accesibilidad, dejar de perder clientes mayores o con baja visión y ganar puntos en Google.

## Cómo ganar dinero con ella

Una auditoría de accesibilidad cuesta 600-2.000 €. Esto te da el 80% de los fallos gratis y te dice cuáles arregla el desarrollador en una tarde.

- Informe mensual de accesibilidad para tiendas online que quieren cumplir la normativa europea.
- Diagnóstico previo a una auditoría completa, para reducir horas de consultoría.
- Mantenimiento técnico de webs corporativas con revisión de fallos y propuesta de arreglos.

**Precio orientativo:** 40–80 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**: pasa la auditoría de accesibilidad de Lighthouse (la misma que usa Google) por tus URLs clave usando la API pública de PageSpeed Insights, traduce los fallos a lenguaje llano y los ordena por lo que más afecta a tus clientes. Para tiendas, webs de servicios y cualquier negocio afectado por la Ley de accesibilidad europea.
**Para quién no es**: si tu web es una página estática de tres líneas sin formularios ni imágenes.

### Lo que necesitas antes
- **Clave gratuita de PageSpeed Insights**: entra en `console.cloud.google.com`, crea un proyecto, activa «PageSpeed Insights API» y crea una clave en Credenciales. Sin clave funciona pero con muy poco límite; con clave son 25.000 consultas al día gratis.
- **n8n** con credenciales de **Google Sheets** y **Gmail**.
- **Hoja «Accesibilidad»** con pestaña `urls` (columna `url` y columna `nombre`) y pestaña `informe` (`fecha`, `url`, `puntuacion`, `problema`, `elementos`, `prioridad`, `como_se_arregla`).
- **Tus 6-10 páginas clave**: portada, categoría, ficha de producto, carrito, checkout, contacto, formulario de presupuesto.

### Los nodos, en orden
**1. Schedule Trigger** — Months, día 1 a las 4:00. Timezone `Europe/Madrid`.
**2. Google Sheets** — Get Row(s) de `urls`.
**3. Loop Over Items** — Batch Size 1 (el análisis es lento, entre 20 y 60 segundos).
**4. HTTP Request** («Analizar») — GET `https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url={{ encodeURIComponent($json.url) }}&category=ACCESSIBILITY&category=BEST_PRACTICES&strategy=mobile&key=TU_CLAVE`. Options: Timeout `120000`, Never Error activado. Settings: Retry On Fail 2 intentos, 10.000 ms de espera.
**5. Code** («Traducir fallos»):
```js
const r = $json;
const url = $('Loop Over Items').first().json.url;
const cat = r.lighthouseResult && r.lighthouseResult.categories ? r.lighthouseResult.categories.accessibility : null;
const puntuacion = cat ? Math.round(cat.score * 100) : null;
const audits = (r.lighthouseResult && r.lighthouseResult.audits) || {};
const traduce = {
  'color-contrast': ['El texto no contrasta lo suficiente con el fondo', 'ALTA', 'Oscurece el texto o aclara el fondo hasta una relacion de 4.5 a 1. Compruebalo en webaim.org/resources/contrastchecker'],
  'image-alt': ['Hay imagenes sin texto alternativo', 'ALTA', 'Anade el atributo alt describiendo la imagen. En WordPress se pone en la biblioteca de medios'],
  'link-name': ['Enlaces sin texto que se pueda leer', 'ALTA', 'Los enlaces que solo son un icono necesitan aria-label con el destino'],
  'button-name': ['Botones sin nombre accesible', 'ALTA', 'Anade texto dentro del boton o aria-label'],
  'label': ['Campos de formulario sin etiqueta', 'ALTA', 'Cada input necesita su etiqueta label asociada; el placeholder no vale'],
  'html-has-lang': ['La pagina no declara el idioma', 'MEDIA', 'Anade lang="es" en la etiqueta html'],
  'document-title': ['La pagina no tiene titulo', 'ALTA', 'Anade una etiqueta title descriptiva'],
  'heading-order': ['Los encabezados estan desordenados', 'MEDIA', 'No saltes de H2 a H4; usa el orden logico'],
  'meta-viewport': ['Impides hacer zoom en el movil', 'ALTA', 'Quita user-scalable=no y maximum-scale del meta viewport'],
  'aria-required-attr': ['Elementos ARIA mal usados', 'MEDIA', 'Que lo revise quien hizo la plantilla'],
  'list': ['Listas mal construidas', 'BAJA', 'Los li deben estar dentro de ul u ol']
};
const salida = [];
for (const [id, info] of Object.entries(traduce)) {
  const a = audits[id];
  if (a && a.score !== null && a.score < 1) {
    const nElems = a.details && a.details.items ? a.details.items.length : 0;
    salida.push({ json: { url, puntuacion, problema: info[0], prioridad: info[1], como_se_arregla: info[2], elementos: nElems } });
  }
}
if (!salida.length) salida.push({ json: { url, puntuacion, problema: 'Sin fallos detectados en las comprobaciones automaticas', prioridad: '-', como_se_arregla: 'Haz igualmente una prueba manual con el teclado', elementos: 0 } });
return salida;
```
**6. Google Sheets** — Append Row en `informe` con `fecha` = `{{ $now.format('dd/MM/yyyy') }}`. Conecta de vuelta al Loop.
**7. Code** («Resumen») desde `done` — cuenta cuántos problemas de prioridad ALTA hay y la puntuación media.
**8. IF** — si hay algún problema ALTA o la puntuación media baja de 90.
**9. Gmail** — Subject: `Accesibilidad: {{ $json.altas }} fallos importantes, nota media {{ $json.media }}/100`. Cuerpo: la lista de los tres primeros con su explicación en cristiano y el enlace a la hoja.

### Cómo probarla
- Ejecuta con una sola URL. Compara el resultado con lo que te dice `pagespeed.web.dev` a mano para esa misma página: deben coincidir.
- Prueba con una web que sepas mala (muchas webs de restaurante lo son) para ver el informe lleno y entender el formato.
- **Complementa siempre con dos pruebas manuales de 5 minutos**: recorre tu formulario de contacto usando solo el tabulador, y amplía la web al 200% con Ctrl y la rueda del ratón. Lo automático detecta un tercio de los problemas reales.

### Qué puede salir mal
- **La API tarda o devuelve 500** en páginas pesadas: sube el Timeout a 120.000 ms y activa los reintentos. Si insiste, prueba `strategy=desktop`.
- **Páginas detrás de login** (el checkout, el área de cliente) no se pueden analizar así. Para esas, usa la extensión gratuita **axe DevTools** en Chrome, a mano, una vez al trimestre.
- **Puntuación que sube y baja sola**: Lighthouse tiene variabilidad. Fíjate en la lista de fallos concretos, no en el número.
- **Arreglos que rompen el diseño**: pásale la columna `como_se_arregla` a quien te lleve la web; son cambios de CSS y atributos, no rediseños.

### Cuánto cuesta
- PageSpeed Insights API: **0 €** con clave gratuita (25.000 consultas diarias).
- n8n auto-alojado, Sheets y Gmail: **0 €**. Total **0 €/mes** frente a los 600-2.000 € de una auditoría externa.
