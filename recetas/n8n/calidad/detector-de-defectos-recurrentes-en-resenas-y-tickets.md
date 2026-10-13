# Detector de defectos recurrentes en reseñas y tickets…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Junta cada semana tus reseñas y correos de incidencias, los clasifica por tipo de problema y te avisa cuando una categoría crece de golpe. Encuentra el defecto antes de que se haga bola.

## Qué es y qué hace

Cada semana reúne reseñas y quejas de una hoja de entradas, las clasifica con una IA de texto (Claude, Codex, Gemini o una IA local) en categorías fijas como envío, defecto, tallas o cobro, cuenta cada una y la compara con la media de las cuatro semanas anteriores. Si una categoría se dispara, avisa. Entrada: hoja entradas; salida: hoja defectos y alerta. Se monta en n8n.

## Cómo usarla

1. Prepara las hojas entradas y defectos
2. Guarda la clave de la IA en n8n
3. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando recibes quejas sueltas que parecen casos aislados y quieres saber si en realidad son el mismo fallo repitiéndose.

## Cómo ganar dinero con ella

Detectar un defecto de producto o de proceso dos semanas antes evita devoluciones, reseñas de una estrella y trabajo repetido.

- Detección de problemas repetidos para una tienda con reseñas de varios canales.
- Análisis semanal de quejas para un restaurante o taller con opiniones dispersas.
- Informe de defectos para un fabricante pequeño que recibe incidencias por correo.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recoge las reseñas y los mensajes de incidencia de la semana, hace que la IA los clasifique en categorías fijas de problema (envío, producto defectuoso, tallas, instrucciones, cobro, atención), cuenta cuántos hay de cada una y compara con la media de las cuatro semanas anteriores. Si algo se dispara, avisa.
Para tiendas, restaurantes, clínicas y talleres que reciben opiniones y quejas por varios canales y no las cruzan nunca.

## Lo que necesitas antes
- n8n.
- Una hoja `entradas` donde vayan cayendo las reseñas y quejas, con columnas: `fecha`, `canal`, `texto`. Puedes llenarla a mano, o con un flujo que meta los correos de tu buzón de soporte y las reseñas que copies de Google.
- Una hoja `defectos` con columnas: `semana`, `categoria`, `cuantos`, `ejemplos`.
- Clave de API de Anthropic guardada como credencial `Header Auth` (`x-api-key`).
- Gmail conectado.

## Los nodos, en orden
1. **Schedule Trigger**. Cron `0 10 * * 1`.
2. **Google Sheets** `Get Row(s)` de `entradas`.
3. **Code** (filtra la última semana y prepara el envío):
```javascript
const limite = new Date(Date.now() - 7 * 86400000);
const textos = $input.all()
  .filter(i => new Date(i.json.fecha) >= limite && (i.json.texto || '').length > 20)
  .map((i, n) => ({ n: n + 1, canal: i.json.canal, texto: String(i.json.texto).slice(0, 600) }));
if (textos.length === 0) return [];
return [{ json: { total: textos.length, lote: JSON.stringify(textos) } }];
```
4. **HTTP Request**. `POST` a `https://api.anthropic.com/v1/messages`. Headers `anthropic-version` = `2023-06-01` y `content-type` = `application/json`. Body JSON:
```json
{ "model": "claude-opus-5-5", "max_tokens": 16000, "system": "Clasificas quejas y resenas de un negocio espanol. Categorias permitidas exactamente: envio_retraso, envio_danado, producto_defectuoso, producto_no_corresponde, tallas_medidas, instrucciones_confusas, cobro_facturacion, atencion_cliente, precio, otro. Devuelves SOLO un array JSON, un objeto por mensaje, con: n, categoria, severidad (baja/media/alta) y frase_clave (maximo 12 palabras citando el problema).", "messages": [ { "role": "user", "content": "Clasifica: {{ $json.lote }}" } ] }
```
5. **Code** (agrupa y compara):
```javascript
const texto = ($input.first().json.content || []).filter(b => b.type === 'text').map(b => b.text).join('');
const datos = JSON.parse(texto.replace(/^```(json)?/i, '').replace(/```$/, '').trim());
const conteo = {};
for (const d of datos) {
  if (!conteo[d.categoria]) conteo[d.categoria] = { categoria: d.categoria, cuantos: 0, altas: 0, ejemplos: [] };
  conteo[d.categoria].cuantos++;
  if (d.severidad === 'alta') conteo[d.categoria].altas++;
  if (conteo[d.categoria].ejemplos.length < 3) conteo[d.categoria].ejemplos.push(d.frase_clave);
}
const semana = new Date().toISOString().slice(0, 10);
return Object.values(conteo)
  .sort((a, b) => b.cuantos - a.cuantos)
  .map(c => ({ json: { semana, categoria: c.categoria, cuantos: c.cuantos, altas: c.altas, ejemplos: c.ejemplos.join(' / ') } }));
```
6. **Google Sheets** `Append Row` en `defectos`.
7. **Google Sheets** `Get Row(s)` de `defectos` (histórico) > **Code** que calcule, para cada categoría, la media de las 4 semanas previas y marque `alerta = true` si esta semana supera esa media por más del 50% y hay al menos 3 casos.
8. **IF** sobre `alerta` > **Gmail** `Send` con asunto `Sube el problema: {{ $json.categoria }}` y el cuerpo con los ejemplos citados.
9. Siempre: **Gmail** `Send` con el ranking semanal completo, aunque no haya alerta.

## Cómo probarla
- Carga en `entradas` 30 quejas reales antiguas y ejecuta: las categorías deben cuadrar con lo que tú ya sabes que pasa.
- Añade 5 quejas inventadas de la misma categoría con fecha de esta semana y comprueba que salta la alerta.
- Si la IA usa categorías que no están en la lista, refuerza el `system` con «no inventes categorías nuevas, usa `otro`».

## Qué puede salir mal
- **Pocos datos**: con menos de 15 mensajes por semana el porcentaje engaña. Pasa a periodicidad quincenal.
- **Estacionalidad**: en rebajas o Navidad suben los retrasos de envío sin que sea un defecto nuevo. Compara con la misma época del año anterior si tienes histórico.
- **Datos personales en las reseñas**: limpia nombres y correos en el Code antes de enviar nada.
- **Categorías mal elegidas**: revísalas cada trimestre; si `otro` supera el 20%, te falta una categoría.

## Cuánto cuesta
0 € las herramientas. La API de Anthropic con `claude-opus-5-5` cuesta unos 0,10-0,40 € por análisis semanal según volumen de texto.
