# Detector de entregas calcadas dentro del mismo grupo…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Compara las entregas de un mismo ejercicio entre sí y te avisa cuando dos son sospechosamente parecidas, con el porcentaje y los párrafos que coinciden.

## Qué es y qué hace

Tras el plazo, descarga las entregas de una carpeta de Drive, las convierte a texto, las trocea en frases y compara cada par calculando el porcentaje de frases compartidas. Envía por Telegram solo los pares por encima del umbral, con ejemplos de frase idéntica. Entran archivos de entrega y salen avisos con el porcentaje. Para grupos de formación online donde se entrega el mismo ejercicio, con n8n.

## Cómo usarla

1. Crea una carpeta de Drive por ejercicio
2. Configura el bot de Telegram
3. Ajusta el umbral con entregas de prueba
4. Que lo revise un profesional

## Cuándo usarla

Úsalo en formación online con grupos, bootcamps o academias donde el mismo ejercicio se entrega en bloque y sospechas que circula la solución por el grupo de WhatsApp.

## Cómo ganar dinero con ella

Detectar copias a tiempo protege el prestigio de tu certificado, que es lo que realmente vendes, y te ahorra leer 30 entregas buscando patrones.

- Revisión de entregas en bloque para bootcamps y academias, con informe de pares sospechosos por ejercicio.
- Análisis de similitud por convocatoria para formadores con muchos grupos, cobrado por lote.
- Plantilla de comparación interna vendida a centros que quieren proteger la validez de sus certificados.

**Precio orientativo:** 200–400 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Una vez cerrado el plazo, descarga todas las entregas de una carpeta, las convierte a texto, las trocea en frases y compara cada par de entregas calculando el porcentaje de frases compartidas. Te manda al Telegram solo los pares por encima de tu umbral, con dos ejemplos de frase idéntica para que juzgues tú.

## Lo que necesitas antes
- n8n instalado.
- Carpeta de Drive por ejercicio, con una entrega por alumno y el nombre del alumno en el nombre del archivo.
- Credencial Google Drive OAuth2 en n8n.
- Bot de Telegram con token y tu chat_id (te lo da @BotFather y `getUpdates`).
- Hoja opcional `Similitudes` para dejar histórico.
- No necesitas ninguna API de antiplagio de pago: esto compara entre tus propios alumnos, que es donde ocurre el 90% de las copias.

## Los nodos, en orden
1. **Manual Trigger** (o **Schedule Trigger** el día después de cada fecha límite).
2. **Google Drive** (operación `Search Files/Folders`) — carpeta del ejercicio, devuelve todos los archivos.
3. **Split In Batches** — Batch Size 1, para no reventar memoria.
4. **Google Drive** (`Download`) — File ID `{{ $json.id }}`.
5. **Extract from File** — `Extract from PDF` o `Extract from Text` según el formato.
6. **Code** (Run Once for All Items) — normaliza, trocea en frases y compara todos contra todos. Código abajo.
7. **Filter** — `{{ $json.similitud }}` *larger* `35`.
8. **Telegram** (`Send Message`) — texto con los dos nombres, el porcentaje y las frases coincidentes.
9. **Google Sheets** (`Append Row`) sobre `Similitudes`.

## El código del nodo Code
```javascript
const docs = $input.all().map(i => ({
  nombre: i.json.fileName || i.json.name || 'sin nombre',
  texto: (i.json.data || i.json.text || '')
}));
const trocear = t => t.toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g,'').split(/[.!?\n]+/).map(s => s.replace(/\s+/g,' ').trim()).filter(s => s.split(' ').length >= 7);
const sets = docs.map(d => ({ nombre: d.nombre, frases: trocear(d.texto) }));
const salida = [];
for (let i = 0; i < sets.length; i++) {
  for (let j = i + 1; j < sets.length; j++) {
    const a = sets[i], b = sets[j];
    if (a.frases.length === 0 || b.frases.length === 0) continue;
    const setB = new Set(b.frases);
    const comunes = a.frases.filter(f => setB.has(f));
    const base = Math.min(a.frases.length, b.frases.length);
    const similitud = Math.round((comunes.length / base) * 100);
    if (similitud > 0) salida.push({ json: { alumno_a: a.nombre, alumno_b: b.nombre, similitud, ejemplos: comunes.slice(0, 2).join(' | ') } });
  }
}
return salida.sort((x, y) => y.json.similitud - x.json.similitud);
```

## Cómo probarla
- Sube tres archivos de prueba: dos con tres párrafos idénticos y uno distinto. Debe salir un solo par por encima del 35%.
- Sube dos entregas reales que sepas que son legítimas y ajusta el umbral hasta que no te dé falsos positivos: con enunciados muy guiados, sube el umbral al 50%.

## Qué puede salir mal
- **Falsos positivos por el enunciado**: todos copian la consigna. Filtra en el Code las frases que aparezcan en más de la mitad de las entregas y no las cuentes.
- **Entregas cortas**: con menos de 10 frases largas el porcentaje se dispara. Salta las que tengan menos de 10.
- **Memoria**: con 200 entregas son 20.000 comparaciones; sube la memoria del contenedor de n8n (`NODE_OPTIONS=--max-old-space-size=2048`).
- **No es una prueba**: es una señal. Habla con el alumno antes de acusar.

## Cuánto cuesta
- 0 euros. Todo es Drive gratuito, Telegram gratuito y procesamiento local en n8n.
- Solo pagas si usas n8n Cloud.
