# Auditor de fichas de producto con IA: faltas, huecos y…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Revisa cada semana un lote de fichas de producto con inteligencia artificial y te devuelve faltas de ortografía, descripciones flojas, campos vacíos y textos duplicados.

## Qué es y qué hace

Lee tus fichas de producto de una hoja de Google Sheets por lotes y las envía a una IA de texto con una rúbrica fija que puntúa faltas, descripciones flojas, campos vacíos y textos duplicados. Puede usar Claude, Codex, Gemini o una IA local. Devuelve una tabla con nota, problemas y sugerencia por ficha. Entrada: hoja catalogo; salida: hoja auditoria. Se monta en n8n.

## Cómo usarla

1. Prepara las hojas catalogo y auditoria
2. Guarda la clave de la IA en n8n como credencial
3. Define la rúbrica
4. Revisa una muestra a mano antes de corregir

## Cuándo usarla

Úsalo cuando tienes muchas fichas escritas por gente distinta, o importadas del proveedor, y sospechas que la calidad es desigual.

## Cómo ganar dinero con ella

Revisar 200 fichas a mano son 6-8 horas. Con esto son unos 2-4 € de API y un informe listo para corregir.

- Auditoría de textos de catálogo para una tienda con fichas escritas por varias personas.
- Revisión de descripciones importadas de proveedor antes de publicarlas.
- Informe de calidad semanal de fichas para una tienda que cuida el SEO.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Coge tus fichas de producto desde una hoja o desde tu tienda, se las pasa por lotes a un modelo de IA con una rúbrica clara, y te devuelve una tabla con la puntuación de cada ficha y los problemas concretos encontrados.
Para tiendas y catálogos donde la calidad de los textos afecta directamente a la conversión y al SEO.

## Lo que necesitas antes
- n8n.
- Una clave de API de Anthropic: te registras en console.anthropic.com, cargas saldo (mínimo 5 $) y creas la clave en Settings > API Keys. Guárdala en n8n como credencial genérica `Header Auth` con nombre `x-api-key`.
- Credenciales de Google Sheets y Gmail.
- Una hoja `catalogo` con columnas: `id`, `titulo`, `descripcion`, `categoria`. Y una hoja `auditoria` con: `fecha`, `id`, `nota`, `problemas`, `sugerencia`.

## Los nodos, en orden
1. **Schedule Trigger**. Cron `0 7 * * 1` (lunes a las 7).
2. **Google Sheets** `Get Row(s)` de `catalogo`.
3. **Split In Batches**. Batch Size `10`. (Diez fichas por llamada: barato y no satura el contexto.)
4. **Code** (prepara el texto del lote):
```javascript
const fichas = $input.all().map(i => ({ id: i.json.id, titulo: i.json.titulo, descripcion: i.json.descripcion, categoria: i.json.categoria }));
return [{ json: { lote: JSON.stringify(fichas) } }];
```
5. **HTTP Request**. Método `POST`. URL `https://api.anthropic.com/v1/messages`. Authentication: la credencial Header Auth creada. Headers adicionales: `anthropic-version` = `2023-06-01`, `content-type` = `application/json`. Body Content Type `JSON`, y en Specify Body elige `Using JSON` con:
```json
{ "model": "claude-opus-5-5", "max_tokens": 16000, "output_config": { "effort": "low" }, "system": "Eres un revisor de calidad de fichas de producto de una tienda española. Devuelves SOLO un array JSON, sin texto alrededor y sin bloques de codigo. Para cada ficha devuelves: id, nota (0-10), problemas (array de cadenas cortas) y sugerencia (una frase). Marca como problema: faltas de ortografia o tildes, descripcion de menos de 40 palabras, ausencia de medidas o materiales cuando la categoria lo requiere, titulo sin la palabra clave principal, texto copiado literalmente del proveedor, promesas ilegales como 'cura' o 'garantizado 100%'.", "messages": [ { "role": "user", "content": "Revisa estas fichas: {{ $json.lote }}" } ] }
```
6. **Code** (interpreta la respuesta):
```javascript
const texto = ($input.first().json.content || []).filter(b => b.type === 'text').map(b => b.text).join('');
const limpio = texto.replace(/^```(json)?/i, '').replace(/```$/, '').trim();
let datos = [];
try { datos = JSON.parse(limpio); } catch (e) { return [{ json: { error: 'Respuesta no valida', bruto: limpio.slice(0, 500) } }]; }
const hoy = new Date().toISOString().slice(0, 10);
return datos.map(d => ({ json: { fecha: hoy, id: d.id, nota: d.nota, problemas: (d.problemas || []).join(' | '), sugerencia: d.sugerencia } }));
```
7. **Google Sheets** `Append Row` en `auditoria`.
8. Conecta la salida de vuelta al **Split In Batches** para el siguiente lote.
9. Al terminar (salida `done` del Split In Batches) > **Gmail** `Send` con el resumen: cuántas fichas por debajo de 6 y enlace a la hoja.

## Cómo probarla
- Empieza con 10 fichas y `Batch Size` 10. Lee el resultado tú mismo: ¿estás de acuerdo con las notas? Si no, ajusta el texto del `system`, que es donde manda la rúbrica.
- Mete a propósito una ficha con faltas y otra vacía: deben salir con nota baja.
- Comprueba el gasto en console.anthropic.com > Usage tras la primera pasada y multiplícalo por el número de lotes.

## Qué puede salir mal
- **La IA devuelve texto alrededor del JSON**: por eso el Code limpia los bloques de código. Si sigue fallando, endurece el `system` con «responde únicamente con el array».
- **Límite de peticiones (429)**: en Settings del HTTP Request activa *Retry On Fail* con 3 intentos y añade un nodo **Wait** de 3 segundos entre lotes.
- **Fichas larguísimas**: recorta la descripción a 1.500 caracteres en el Code del paso 4 antes de enviarla.
- **No te fíes ciegamente**: la IA propone, tú decides. Nunca sobrescribas la tienda automáticamente; usa la hoja como lista de tareas.

## Cuánto cuesta
n8n y Sheets, 0 €. La API de Anthropic con `claude-opus-5-5` cuesta 5 $ por millón de tokens de entrada y 25 $ por millón de salida: auditar 200 fichas ronda los 2-4 $. Si quieres abaratar, cambia el modelo a `claude-haiku-4-5` (1 $ / 5 $ por millón) asumiendo algo menos de finura.
