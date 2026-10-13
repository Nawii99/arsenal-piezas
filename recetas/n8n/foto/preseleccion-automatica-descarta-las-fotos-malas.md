# Preselección automática: descarta las fotos malas…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Antes de sentarte a elegir, la IA revisa la tanda y aparta las borrosas, las mal expuestas y las de ojos cerrados en una carpeta de descartes.

## Qué es y qué hace

Recorre una carpeta con la tanda del día, envía las previas JPG a un modelo de visión que puntúa nitidez, exposición, encuadre y si los ojos están cerrados, y mueve a DESCARTES las fotos bajo el umbral. Las dudosas van a REVISAR. Entran previas de 1600 px y salen tres carpetas con la decisión. Para fotógrafos de eventos, bodas o deporte con mucho volumen, con n8n y Google Drive.

## Cómo usarla

1. Crea las tres carpetas de Drive y anota sus IDs
2. Exporta previas JPG desde tu editor
3. Ajusta el umbral con cien fotos ya revisadas
4. Revisa siempre la carpeta REVISAR

## Cuándo usarla

Úsalo cuando vuelves de un evento con 1.500 disparos y solo la criba inicial te come una tarde entera antes de empezar a editar de verdad.

## Cómo ganar dinero con ella

Quita el 30-40% del volumen antes de que lo mires. En una boda son 3-4 horas menos de criba por encargo.

- Criba automática de fotos para bodas y eventos, cobrada por encargo, con reparto de fotos dudosas.
- Preselección mensual para fotógrafos deportivos con muchos disparos por evento, por cuota.
- Plantilla de criba vendida a fotógrafos que quieren ahorrar horas de edición.

**Precio orientativo:** 150–300 € por encargo. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recorre una carpeta con la tanda del día, envía cada foto a un modelo de visión que puntúa nitidez, exposición, encuadre y si los ojos están cerrados, y mueve automáticamente a `DESCARTES` todo lo que baje del umbral. En `REVISAR` quedan las dudosas y en la carpeta original solo lo bueno.
Para fotógrafos de evento, boda, deporte o reportaje, donde el volumen es el problema.

## Lo que necesitas antes
- Tres carpetas de Drive: `TANDA`, `DESCARTES`, `REVISAR`. Apunta los tres IDs.
- Clave de API de Anthropic o de OpenAI.
- Importante: sube a `TANDA` **JPG de vista previa**, no los RAW. Exporta previas de 1600 px desde Lightroom o desde el propio software de la cámara. Después aplicas la decisión a los RAW por nombre de archivo.
- Hoja `Criba` con columnas: `archivo`, `nitidez`, `exposicion`, `encuadre`, `ojos`, `nota`, `decision`, `motivo`.

## Los nodos, en orden
1. **Manual Trigger** — la criba la lanzas tú cuando acabas de volcar.
2. **Google Drive** — Operation `Search` en la carpeta `TANDA`, filtro `mimeType contains 'image/'`. Limit: 500.
3. **Split In Batches** — Batch Size: 1.
4. **Google Drive** — `Download`, File ID `{{ $json.id }}`.
5. **Code** (`A base64`) — el patrón de siempre: `return { json: { b64: $input.item.binary.data.data, tipo: $input.item.binary.data.mimeType, id: $('Split In Batches').item.json.id, archivo: $('Split In Batches').item.json.name } };`
6. **HTTP Request** (`Puntuar foto`) — `POST` a la API de visión con el body de abajo.
7. **Code** (`Decidir`) — aplica los umbrales. Código abajo.
8. **Switch** — Mode `Rules`, sobre `{{ $json.decision }}`: salida 1 `DESCARTE`, salida 2 `REVISAR`, salida 3 `BUENA`.
9. **Google Drive** — en la salida 1, Operation `Move File`, Parent Drive/Folder `DESCARTES`. En la salida 2, a `REVISAR`. La salida 3 no toca nada.
10. **Google Sheets** — `Append Row` en `Criba` con todas las notas, para que puedas auditar por qué se descartó cada cosa.

## El cuerpo JSON del HTTP Request
```json
{
  "model": "claude-haiku-4-5",
  "max_tokens": 250,
  "messages": [{
    "role": "user",
    "content": [
      {"type": "image", "source": {"type": "base64", "media_type": "={{ $json.tipo }}", "data": "={{ $json.b64 }}"}},
      {"type": "text", "text": "Eres un ayudante de fotografo profesional haciendo la primera criba. Evalua esta foto y responde SOLO con JSON valido: {\"nitidez\": 0-10, \"exposicion\": 0-10, \"encuadre\": 0-10, \"ojos_cerrados\": true/false, \"hay_personas\": true/false, \"motivo\": \"maximo 12 palabras explicando el mayor defecto o virtud\"}. Nitidez baja significa movida o desenfocada. Exposicion baja significa quemada o subexpuesta sin recuperacion. Se estricto con la nitidez y generoso con el encuadre."}
    ]
  }]
}
```

## El código del nodo Decidir
```javascript
const raw = ($json.content?.[0]?.text || '{}').replace(/```json|```/g, '').trim();
let v;
try { v = JSON.parse(raw); } catch (e) { v = { nitidez: 5, exposicion: 5, encuadre: 5, ojos_cerrados: false, hay_personas: false, motivo: 'no se pudo evaluar' }; }
const d = $('Code').item.json; // el nodo A base64
const nota = (v.nitidez * 0.5 + v.exposicion * 0.3 + v.encuadre * 0.2).toFixed(1);
let decision = 'BUENA';
if (v.nitidez <= 3 || v.exposicion <= 2) decision = 'DESCARTE';
else if (v.hay_personas && v.ojos_cerrados) decision = 'DESCARTE';
else if (Number(nota) < 6.5) decision = 'REVISAR';
return { json: {
  archivo: d.archivo, id: d.id,
  nitidez: v.nitidez, exposicion: v.exposicion, encuadre: v.encuadre,
  ojos: v.ojos_cerrados ? 'CERRADOS' : 'OK',
  nota, decision, motivo: v.motivo
}};
```

## Cómo probarla
- Prepara una carpeta de prueba con 20 fotos donde tú sepas cuáles son malas: mete a propósito dos movidas, una quemada y una con ojos cerrados.
- Ejecuta y mira si acierta. Si descarta cosas buenas, baja el umbral de nitidez de 3 a 2. Si deja pasar basura, súbelo a 4.
- **Nunca borra nada.** Solo mueve. Revisa la carpeta `DESCARTES` la primera semana antes de fiarte del todo.

## Qué puede salir mal
- **La IA no ve el desenfoque fino.** A 1600 px una foto ligeramente movida puede parecer nítida. Si eres exigente, exporta las previas a 2400 px, aunque cueste un poco más.
- **Descartes creativos.** Un barrido intencionado o un desenfoque artístico te los va a tirar. Añade en el prompt: «si el desenfoque parece intencionado y artístico, puntúa nitidez 7».
- **Coste y tiempo.** 1.500 fotos a unos 0,0007 € son 1 €, y unos 40 minutos de proceso. Déjalo corriendo mientras comes.
- **Aplicar la decisión a los RAW.** Exporta la columna `archivo` de la hoja filtrada por `DESCARTE` y usa el buscador de tu sistema o de Lightroom para marcarlas por nombre. Nunca dejes que un flujo automático toque tus RAW originales.

## Cuánto cuesta
- Modelo de visión barato: menos de 1 € por cada 1.000 fotos.
- n8n y Drive: gratis.
- Programas de culling con IA como Aftershoot o Narrative Select cuestan de 10 a 30 €/mes; esta receta es más basta pero es tuya y no sube de precio.
