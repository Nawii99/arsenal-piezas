# Verificador de la copia de seguridad 3-2-1…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Cada semana compara cuántos archivos y cuántos bytes hay en tu disco de trabajo y en la copia en la nube, y te avisa si falta algo antes de que lo necesites.

## Qué es y qué hace

Cuenta archivos y bytes por carpeta de sesión en el disco local y en la carpeta espejo de Google Drive, compara sesión a sesión y envía un informe semanal: verde si cuadra, rojo con la diferencia exacta si no. Entran inventarios de carpetas y salen informes de cuadre. Para fotógrafos que aplican la regla 3-2-1 y quieren comprobar que la copia externa está completa, con n8n y acceso al disco.

## Cómo usarla

1. Ordena las sesiones con el mismo nombre en local y en Drive
2. Monta el disco en n8n
3. Programa el informe semanal
4. Revisa la primera diferencia antes de confiar

## Cuándo usarla

Úsalo cuando trabajes con material irrepetible (bodas, eventos, encargos) y confíes en una sincronización automática que nunca has comprobado que funcione.

## Cómo ganar dinero con ella

Perder una boda entera son 1.500-3.000 € de devolución más la reputación. Esta comprobación semanal es el seguro más barato que puedes montar.

- Verificación semanal de copias para estudios que trabajan con material irrepetible, cobrada por mes.
- Auditoría inicial de la regla 3-2-1 para fotógrafos de bodas, cobrada por puesta en marcha.
- Plantilla de informe de copias vendida a agencias de eventos con archivos grandes.

**Precio orientativo:** 150–300 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cuenta archivos y bytes por carpeta de sesión en tu disco local y hace lo mismo en la carpeta espejo de Google Drive. Compara sesión por sesión y te manda un informe: verde si cuadra, rojo con la diferencia exacta si no.
Es para cualquier fotógrafo que aplique la regla 3-2-1 (tres copias, dos soportes, una fuera de casa) y quiera saber que la copia de fuera está de verdad completa.

## Lo que necesitas antes
- n8n auto-alojado con acceso al disco donde guardas las sesiones (por ejemplo `/mnt/fotos/2026`), montado como volumen si usas Docker.
- Una carpeta en Google Drive con la misma estructura, sincronizada por la app de escritorio de Drive, rclone o lo que uses.
- Credenciales de Google Drive y Gmail en n8n.
- Estructura de carpetas idéntica en los dos sitios: una carpeta por sesión, sin subcarpetas raras. Si en local tienes `2026-05-12_Boda_Ana`, en Drive igual.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: `Weeks`, `Sunday` a las `22`.
2. **Execute Command** — Command: `find /mnt/fotos/2026 -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | while read d; do n=$(find "/mnt/fotos/2026/$d" -type f | wc -l); b=$(du -sb "/mnt/fotos/2026/$d" | cut -f1); echo "$d|$n|$b"; done`. Devuelve una línea por sesión con nombre, número de archivos y bytes.
3. **Google Drive** — Resource: `File/Folder`, Operation: `Search`, Search Method: `Advanced`, Query String: `'ID_DE_TU_CARPETA_2026' in parents and mimeType = 'application/vnd.google-apps.folder' and trashed = false`, Return All activado.
4. **Split In Batches** — Batch Size: `1`, sobre las carpetas de Drive.
5. **Google Drive** — Operation: `Search`, Query String: `'{{ $json.id }}' in parents and trashed = false`, y en Options › Fields añade `files(id,name,size)`. Return All activado.
6. **Code** — suma archivos y bytes de esa carpeta y guarda el resultado; vuelve al **Split In Batches**.
7. **Code** (desde «done») — cruza local contra nube y arma el informe (código abajo).
8. **Gmail** — Subject: `Copia de seguridad: {{ $json.estado }}`, Message: `{{ $json.informe }}`.

## El código del informe
```javascript
const salida = String($('Execute Command').first().json.stdout || '').trim();
const local = {};
for (const linea of salida.split('\n')) {
  const [nombre, n, b] = linea.split('|');
  if (nombre) local[nombre.trim()] = { archivos: Number(n), bytes: Number(b) };
}
const nube = {};
for (const item of $input.all()) {
  const j = item.json;
  if (j && j.carpeta) nube[j.carpeta] = { archivos: Number(j.archivos), bytes: Number(j.bytes) };
}
const lineas = [];
let problemas = 0;
for (const sesion of Object.keys(local).sort()) {
  const l = local[sesion];
  const c = nube[sesion];
  if (!c) { lineas.push('❌ ' + sesion + ' — NO EXISTE en la nube (' + l.archivos + ' archivos en local)'); problemas++; continue; }
  const faltan = l.archivos - c.archivos;
  const difMB = Math.round((l.bytes - c.bytes) / 1048576);
  if (faltan === 0 && Math.abs(difMB) < 2) lineas.push('✅ ' + sesion + ' — ' + l.archivos + ' archivos, cuadra');
  else { lineas.push('❌ ' + sesion + ' — faltan ' + faltan + ' archivos y ' + difMB + ' MB en la nube'); problemas++; }
}
for (const sesion of Object.keys(nube)) if (!local[sesion]) lineas.push('⚠️ ' + sesion + ' — está en la nube pero no en local (¿borrado por error?)');
return [{ json: { estado: problemas ? 'REVISAR (' + problemas + ' sesiones)' : 'todo correcto', informe: lineas.join('\n') } }];
```

## Cómo probarla
- Borra a propósito un archivo de una carpeta de la nube (uno del que tengas copia local) y lanza el flujo: debe salir en rojo con «faltan 1 archivos».
- Crea una carpeta nueva en local y no la sincronices: debe salir como «NO EXISTE en la nube».
- Comprueba que una sesión que sí está bien sale en verde, para no acostumbrarte a ver alertas y dejar de mirarlas.

## Qué puede salir mal
- **Los archivos de Google (Docs, Sheets) no tienen `size`**: si metes documentos en esas carpetas, el conteo de bytes se descuadra. Guarda solo fotos, o filtra por `mimeType contains 'image'`.
- **Diferencia de bytes pequeña**: normal, por eso el margen de 2 MB. Si te aparece siempre la misma diferencia, suele ser un `.DS_Store` o un `Thumbs.db` que no sube.
- **`du -sb` no existe en Mac**: usa `du -sk` y multiplica por 1024 en el código, o instala coreutils.
- **Carpetas anidadas**: la búsqueda de Drive del paso 5 solo mira el primer nivel. Si dentro de cada sesión tienes `RAW/` y `JPG/`, hay que recorrer también esas; alternativa más sencilla: cuenta también en local solo el primer nivel usando `-maxdepth 1` en el `find` interior.
- **Falsa tranquilidad**: que el número cuadre no significa que los archivos se abran. Una vez al trimestre, descarga tres fotos al azar de la nube y ábrelas. Esa parte no la automatices.

## Cuánto cuesta
- n8n auto-alojado: gratis (necesita acceso al disco, así que corre en tu ordenador o NAS).
- Google Drive: el espacio es el gasto real; 2 TB por unos 10 € al mes.
- Gmail: gratis. Total: el almacenamiento que ya pagas.
