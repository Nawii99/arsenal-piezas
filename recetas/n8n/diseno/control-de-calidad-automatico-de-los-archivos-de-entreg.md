# Control de calidad automático de los archivos de entreg…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Antes de mandar la carpeta al cliente, revisa que están todos los formatos pactados y te lista lo que falta.

## Qué es y qué hace

Recibe la carpeta de entrega de Google Drive y el tipo de paquete desde un formulario de n8n, lista todos los archivos y los compara con un checklist de Google Sheets que define el patrón de cada entregable. Devuelve un informe con lo que falta y lo que pesa demasiado antes de mandarlo al cliente. Útil para estudios de marca que entregan paquetes cerrados.

## Cómo usarla

1. Crear la hoja Checklist con patrones por paquete
2. Conectar Drive, Sheets y Gmail en n8n
3. Lanzar el formulario con carpeta y paquete
4. Revisar el informe antes de enviar

## Cuándo usarla

Cuando entregas paquetes de marca (logo en AI, EPS, SVG, PNG, JPG, versión positiva, negativa y monocroma) y siempre se te olvida alguno.

## Cómo ganar dinero con ella

Evita el correo de 'falta el SVG' tres días después: cada reapertura de un proyecto cerrado son 30-60 minutos de contexto perdido.

- Control de calidad de entregas de marca para estudios de diseño que mandan logos en varios formatos.
- Revisión de paquetes de packaging antes de imprimir o entregar a clientes.
- Plantilla de checklist de entregables que el diseñador vende como parte de su proceso de cierre.

**Precio orientativo:** 80–200 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Le dices la carpeta de entrega y el tipo de paquete, lista todos los archivos, los compara con tu checklist de entregables y te manda un informe con lo que está, lo que falta y lo que pesa demasiado. Para diseñadores de marca y estudios que entregan paquetes cerrados.

## Lo que necesitas antes
- Cuenta de n8n.
- Hoja `Checklist` con columnas: `paquete`, `patron`, `descripcion`, `obligatorio`. Ejemplo de filas: paquete `marca-basica`, patron `logo-principal-positivo\.svg`, descripción `Logo principal en SVG`, obligatorio `si`.
- Carpeta de Drive de la entrega y su ID.
- Credenciales de Google Drive, Google Sheets y Gmail en n8n.

## Los nodos, en orden
1. **n8n Form Trigger** — Campos: `carpeta_id` (Text), `paquete` (Dropdown con tus tipos: marca-basica, marca-completa, packaging), `cliente` (Text).
2. **Google Drive** (`Listar`) — Resource: File/Folder, Operation: Search. Search Method: Advanced (Query String). Query String: `'{{ $json.carpeta_id }}' in parents and trashed = false`. Options: Return All activado, Fields: `id,name,size,mimeType`.
3. **Google Sheets** — Get Row(s) de `Checklist`. Options, Filters: columna `paquete` igual a `{{ $('n8n Form Trigger').first().json.paquete }}`. Return All.
4. **Code** (`Comparar`) — Mode: Run Once for All Items. Código abajo.
5. **Google Docs** o directamente **Gmail** — Send. Subject: `Control de calidad de entrega — {{ $('n8n Form Trigger').first().json.cliente }}`. Email Type: HTML. Message: `{{ $json.informe }}`.
6. **IF** — `{{ $json.faltan }}` equals 0 → rama true → **Google Drive** Operation: Create Folder llamada `LISTO-PARA-ENVIAR` dentro de la carpeta, como marca visual de que ha pasado el control.

## El trozo de código (nodo Code del paso 4)
```javascript
const archivos = $('Listar').all().map(i => ({ nombre: i.json.name, kb: Math.round(Number(i.json.size || 0) / 1024) }));
const checklist = $('Google Sheets').all().map(i => i.json);
const ok = [], falta = [], opcionales = [];
for (const c of checklist) { const re = new RegExp(c.patron, 'i'); const encontrado = archivos.find(a => re.test(a.nombre)); if (encontrado) { ok.push(`${c.descripcion} — ${encontrado.nombre} (${encontrado.kb} KB)`); } else if (String(c.obligatorio).toLowerCase() === 'si') { falta.push(`${c.descripcion} (se esperaba algo tipo: ${c.patron})`); } else { opcionales.push(c.descripcion); } }
const patrones = checklist.map(c => new RegExp(c.patron, 'i'));
const sobran = archivos.filter(a => !patrones.some(re => re.test(a.nombre))).map(a => a.nombre);
const pesados = archivos.filter(a => a.kb > 20000).map(a => `${a.nombre} (${a.kb} KB)`);
const li = arr => arr.length ? '<ul>' + arr.map(x => `<li>${x}</li>`).join('') + '</ul>' : '<p>ninguno</p>';
const informe = `<h2>Control de calidad de entrega</h2><p><b>Archivos en la carpeta:</b> ${archivos.length}</p><h3>Correctos (${ok.length})</h3>${li(ok)}<h3>FALTAN (${falta.length})</h3>${li(falta)}<h3>Opcionales no incluidos</h3>${li(opcionales)}<h3>Archivos no reconocidos (revisa el nombre)</h3>${li(sobran)}<h3>Archivos de más de 20 MB</h3>${li(pesados)}`;
return [{ json: { informe, faltan: falta.length, total: archivos.length } }];
```

## Cómo probarla
- Crea una carpeta con tres archivos correctos y quita uno obligatorio a propósito: el informe debe listarlo en FALTAN.
- Mete un archivo llamado `Captura de pantalla 2026-09-01.png`: debe aparecer en no reconocidos.
- Prueba un patrón con expresión regular más suelta, por ejemplo `logo.*positivo.*\.svg`, para que tolere variaciones de nombre.

## Qué puede salir mal
- **Expresión regular mal escrita**: si un patrón tiene un paréntesis sin cerrar, el nodo Code peta. Envuelve la creación del RegExp en try/catch si vas a dejar que otros editen la hoja.
- **Subcarpetas**: la consulta solo mira el primer nivel. Si organizas por subcarpetas, haz primero una búsqueda de carpetas hijas y encadena con Split In Batches.
- **El tamaño no viene**: los Google Docs nativos no tienen `size`. El código los cuenta como 0 KB, no pasa nada.
- **Nombres con mayúsculas y tildes**: el RegExp lleva la bandera `i` para ignorar mayúsculas, pero no las tildes. Acuerda nombres de archivo sin acentos.

## Cuánto cuesta
- n8n auto-alojado: 0 euros. Drive, Sheets y Gmail: gratis.
- Coste real: 0 euros al mes.
