# Detector de fotos duplicadas y casi iguales…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Revisa tu archivo, encuentra las fotos repetidas o casi idénticas y te da una lista con cuáles borrar y cuánto espacio recuperas. Para discos y nubes reventados de copias.

## Qué es y qué hace

Recorre una carpeta de Drive y calcula una huella por imagen: primero tamaño y checksum exacto, después parecido visual. Agrupa las coincidencias y escribe en una hoja qué archivos son copias y cuál conviene conservar, con el espacio que se recupera. No borra nada: solo deja la lista para que decidas.

## Cómo usarla

1. Crea la hoja Duplicados
2. Conecta Drive y Sheets
3. Lanza la primera pasada sobre una carpeta pequeña
4. Revisa los grupos antes de borrar

## Cuándo usarla

Cuando pagas por almacenamiento en la nube y sospechas que la mitad son copias de lo mismo, o tienes ráfagas de 20 fotos casi iguales.

## Cómo ganar dinero con ella

Recuperar 300 GB te ahorra los 9,99 €/mes de un plan de 2 TB. Y te quita horas de revisar carpetas.

- Limpieza de duplicados en Drive para fotógrafos y agencias con archivo desordenado.
- Auditoría de almacenamiento para empresas que pagan planes de nube de más.
- Revisión trimestral de copias para estudios que trabajan con grandes volúmenes de fotos.

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recorre una carpeta de Drive, calcula una huella de cada imagen (primero por tamaño y checksum exacto, después por parecido visual), agrupa las coincidencias y te deja en una hoja qué archivos son copias y cuáles conviene conservar.
Para fotógrafos con archivo desordenado, agencias con material duplicado y cualquiera harto de pagar almacenamiento por nada.

## Lo que necesitas antes
- Credencial Google Drive OAuth2 y Google Sheets OAuth2.
- Hoja Duplicados con columnas: Grupo, Archivo, ID, TamanoMB, Accion.
- Paciencia: la primera pasada sobre 10.000 fotos tarda un rato. No borres nada de forma automática.

## Los nodos, en orden
1) **Manual Trigger**.
2) **Google Drive** (Search). Query String: `'ID_CARPETA' in parents and mimeType contains 'image/' and trashed = false`. En Options > Fields: `id,name,size,md5Checksum,imageMediaMetadata`. Return All: activado.
3) **Code** (Agrupar por checksum). Ver abajo. Este paso ya pilla las copias exactas sin descargar nada, que es lo rápido.
4) **IF** (¿Quedan sospechosas?). Para las que tienen tamaño parecido pero distinto checksum, sigue la segunda vuelta.
5) **Split In Batches** (Batch Size: 20) > **Google Drive1** (Download) > **Edit Image** con Operation: Resize a 16x16 y Format: png. Esa miniatura es la base de la huella visual.
6) **Extract from File** (Binary to Base64) y **Code1** que calcula un hash perceptual sencillo comparando el brillo de cada casilla contra la media.
7) **Code2** (Comparar huellas). Agrupa las que difieren en menos de 6 bits.
8) **Google Sheets** (Append Rows) con un grupo por bloque, marcando Accion = CONSERVAR en la de más tamaño y REVISAR en las demás.
9) **Gmail** con el resumen: cuántos grupos, cuántos GB en juego.

## El trozo de código (nodo Code de agrupación exacta)
```javascript
const porHash = {};
for (const item of $input.all()) {
  const f = item.json;
  const clave = f.md5Checksum || ('sz-' + f.size);
  if (!porHash[clave]) porHash[clave] = [];
  porHash[clave].push(f);
}
const salida = [];
let grupo = 0;
for (const clave of Object.keys(porHash)) {
  const lista = porHash[clave];
  if (lista.length < 2) continue;
  grupo++;
  lista.sort((a, b) => Number(b.size) - Number(a.size));
  lista.forEach((f, i) => {
    salida.push({ json: {
      Grupo: 'G' + grupo,
      Archivo: f.name,
      ID: f.id,
      TamanoMB: Math.round(Number(f.size) / 1048576 * 10) / 10,
      Accion: i === 0 ? 'CONSERVAR' : 'REVISAR'
    }});
  });
}
return salida;
```

## Cómo probarla
Prepara una carpeta con 20 fotos donde tú ya sepas que hay 3 copias exactas y 4 de una misma ráfaga. Comprueba que las exactas caen en el mismo grupo y que las de la ráfaga aparecen juntas en la segunda vuelta. Si mete juntas fotos que no lo son, sube la exigencia de 6 a 3 bits.

## Qué puede salir mal
- **Borrado accidental**: no conectes nunca un nodo de Delete directamente. Deja siempre la revisión humana en la hoja y, como mucho, un flujo aparte que mueva a una carpeta PAPELERA.
- **RAW sin miniatura**: Drive no genera vista previa de algunos RAW; el flujo los tratará solo por checksum.
- **Memoria**: con 20.000 archivos, el Return All revienta n8n. Trocea por carpeta o por año.
- **Fotos legítimamente parecidas** (retratos de la misma pose): por eso la acción por defecto es REVISAR, no BORRAR.

## Cuánto cuesta
0 € con n8n autoalojado y cuentas gratuitas. Las herramientas comerciales de deduplicación cuestan 30-60 € de licencia; esto lo hace igual de bien si eres paciente.
