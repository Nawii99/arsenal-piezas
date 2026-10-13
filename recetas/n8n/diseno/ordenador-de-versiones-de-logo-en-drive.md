# Ordenador de versiones de logo en Drive…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Renombra, ordena y cataloga cada archivo de logo que subes, con versión, formato y fecha, y mantiene una hoja índice para no perder nunca el original.

## Qué es y qué hace

Vigila la carpeta _entrada_logos de Drive; cada archivo nuevo lo analiza para detectar marca, formato y versión, lo renombra con un patrón fijo, lo archiva en la carpeta de esa marca y anota una fila en una hoja índice con enlace directo. Entran los logos subidos y las carpetas de Drive; sale un archivo ordenado y un índice de versiones. Para estudios y freelances con varias marcas activas.

## Cómo usarla

1. Crea las carpetas _entrada_logos y Marcas en Drive
2. Crea la hoja indice_logos
3. Define el patrón de nombre de versiones
4. Prueba con diez archivos antiguos

## Cuándo usarla

Úsalo cuando tienes veinte archivos llamados logo_final_final_v3_BUENO y ya no sabes cuál es el vectorial bueno ni qué versión mandaste al cliente.

## Cómo ganar dinero con ella

Evita rehacer un logo perdido (200-600 € de trabajo) y ahorra los 10 minutos diarios de buscar el archivo correcto. Coste: 0 €.

- Organización de archivos de marca para estudios de diseño con varios clientes…
- Archivo de versiones de identidad para empresas que cambian su logo cada temporada…
- Gestión de activos de marca para freelances con índice consultable…

**Precio orientativo:** 60–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Vigila la carpeta `_entrada_logos`; cada archivo que llega lo analiza (marca, formato, versión), lo renombra con un patrón fijo, lo archiva en la carpeta de esa marca y apunta la fila en una hoja índice con enlace directo.
Para estudios y freelances con varias marcas vivas, y para empresas con una identidad que van tocando cada temporada.

**Lo que necesitas antes**
- Credencial OAuth de Google (Drive y Sheets).
- En Drive: una carpeta `_entrada_logos` y una carpeta `Marcas` donde vivirá una subcarpeta por cliente. Apunta ambos IDs.
- Una hoja `indice_logos` con columnas: marca, version, formato, nombre_archivo, fecha, enlace, notas.
- Un acuerdo contigo mismo sobre el nombre de entrada: `marca_version.extension`, por ejemplo `panaderiasol_v3.svg`. Todo lo demás lo pone el flujo.

**Los nodos, en orden**
1. **Google Drive Trigger**: evento File Created sobre `_entrada_logos`.
2. **Code** (Run Once for All Items): parte el nombre y construye el nombre definitivo.
```javascript
return items.map(i => {
  const original = i.json.name;
  const ext = (original.split('.').pop() || '').toLowerCase();
  const base = original.replace(/\.[^.]+$/, '');
  const partes = base.split('_');
  const marca = (partes[0] || 'sinmarca').toLowerCase();
  const m = base.match(/v(\d+)/i);
  const version = m ? 'v' + m[1] : 'v1';
  const vectoriales = ['svg', 'ai', 'eps', 'pdf'];
  const tipo = vectoriales.includes(ext) ? 'VECTORIAL' : 'MAPA-DE-BITS';
  const fecha = new Date().toISOString().slice(0, 10);
  return { json: { id: i.json.id, marca, version, ext, tipo, fecha, nuevoNombre: `${marca}_${version}_${tipo}_${fecha}.${ext}` } };
});
```
3. **Google Drive**: Search Files/Folders con Query `{{ $json.marca }}` dentro de `Marcas`, para ver si ya existe la carpeta de esa marca.
4. **IF**: si el resultado está vacío, rama verdadera a **Google Drive** Create Folder con nombre `{{ $json.marca }}`; si no, sigue por la rama falsa.
5. **Google Drive**: operación Update File (o Move File) para renombrar a `{{ $json.nuevoNombre }}` y moverlo a la carpeta de la marca.
6. **Google Sheets**: Append Row en `indice_logos` con marca, version, tipo, nombre, fecha y `{{ $json.webViewLink }}`.
7. **IF** de aviso: si `tipo` es `MAPA-DE-BITS` y la versión es la más alta, manda un **Slack** (o Gmail) diciendo «Ojo: esta versión no tiene vectorial subido».

**Cómo probarla**
- Sube tres archivos de prueba: `pruebamarca_v1.svg`, `pruebamarca_v2.png` y `otra_v1.pdf`. Comprueba que se crean dos carpetas, que los nombres quedan limpios y que la hoja tiene tres filas.
- Sube un archivo mal nombrado, por ejemplo `logo bueno.png`, y mira que cae en `sinmarca` sin romper el flujo.

**Qué puede salir mal**
- Nombres con acentos o espacios: el Code node ya los tolera, pero conviene añadir `.normalize('NFD').replace(/[̀-ͯ]/g,'')` para quitar tildes.
- Dos archivos con la misma versión: Drive permite nombres repetidos, así que revisa el índice de vez en cuando y ordena por marca y versión.
- Carrera al crear carpeta: si subes diez archivos de la misma marca a la vez, se pueden crear carpetas duplicadas. Sube en tandas o añade un **Split In Batches** con tamaño 1 y espera de 2 segundos.
- El disparador de Drive no ve cambios de nombre, solo altas de archivo.

**Cuánto cuesta**
- Cero euros. Google Drive gratuito y n8n auto-alojado.
