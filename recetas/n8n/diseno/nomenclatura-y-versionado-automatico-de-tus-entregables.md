# Nomenclatura y versionado automático de tus entregables…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Renombra y ordena solo cada archivo que dejas en la carpeta de trabajo, siguiendo tu nomenclatura, numerando versiones y archivando las anteriores.

## Qué es y qué hace

Vigila una carpeta de entrada en Drive, lee el nombre de cada archivo que sueltas y lo renombra según tu convención cliente-proyecto-pieza, con versión y fecha. La versión anterior pasa a una carpeta _historico y la nueva se registra en Airtable. Sirve para saber siempre qué archivo está vigente. Se monta con n8n, Make o Zapier.

## Cómo usarla

1. Crea la carpeta buzon y una carpeta por cliente
2. Crea la base Registro en Airtable
3. Conecta Drive y Airtable
4. Suelta un archivo de prueba y revisa el registro

## Cuándo usarla

Cuando tienes ochenta archivos llamados «logo_final_final_v2_BUENO» y pierdes tiempo buscando cuál mandaste al cliente y cuál no.

## Cómo ganar dinero con ella

Recupera los 10-15 minutos diarios de buscar archivos y evita el error caro de mandar a imprenta una versión antigua.

- Gestión documental de entregables para estudios con muchos clientes…
- Organización de archivos para equipos creativos con revisiones frecuentes…
- Plantilla de nomenclatura y control de versiones para imprentas y agencias…

**Precio orientativo:** 60–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila la carpeta donde sueltas tus exportaciones, lee el nombre que le has puesto, lo traduce a tu nomenclatura oficial (`CLIENTE_PROYECTO_PIEZA_v03_20260909.pdf`), mueve la versión anterior a un subcarpeta `_historico` y apunta la nueva en un registro.
Es para el freelance o estudio pequeño que trabaja solo y no tiene un gestor documental, pero necesita saber en todo momento qué versión está viva.
## Lo que necesitas antes
En Drive: una carpeta `00-buzon` (donde sueltas), una carpeta por cliente y dentro `entregas` y `_historico`. Apunta los IDs.
Una base Airtable `Registro` con campos: `archivo`, `cliente`, `proyecto`, `pieza`, `version`, `fecha`, `enlace`.
La regla de nombrado que usarás al soltar: `cliente-proyecto-pieza`. Por ejemplo `panaderia-rebranding-cartel.pdf`. Todo en minúsculas y con guiones.
En n8n: credenciales «Google Drive OAuth2 API» y «Airtable Personal Access Token API».
## Los nodos, en orden
**1. «Google Drive Trigger»** — Specific Folder `00-buzon`, Event: File Created, Poll Every Minute.
**2. «Code»** — parte el nombre, valida el formato y arma el nombre nuevo (código abajo).
**3. «IF»** — Boolean: `{{ $json.valido }}` is true. Si es false, la rama false va a un nodo «Gmail» o «Slack» avisándote de que el archivo está mal nombrado.
**4. «Airtable»** (nómbralo Buscar versión) — Operation: Search, Filter By Formula `AND({cliente}='{{ $json.cliente }}', {proyecto}='{{ $json.proyecto }}', {pieza}='{{ $json.pieza }}')`, Sort por `version` descendente, Limit 1.
**5. «Code»** (nómbralo Calcular versión) — `const previa = $input.first().json.version || 0; const base = $('Code').first().json; return [{ json: { ...base, version: Number(previa) + 1 } }];`
**6. «Google Drive»** (nómbralo Archivar anterior) — Operation: Move, File ID `{{ $('Buscar versión').first().json.file_id }}`, Destination `_historico`. En Settings marca «Continue On Fail» (la primera versión no tiene anterior).
**7. «Google Drive»** (nómbralo Renombrar) — Resource: File, Operation: Update, File ID `{{ $('Google Drive Trigger').first().json.id }}`, Options > File Name: `{{ $json.nombre_final }}`.
**8. «Google Drive»** (nómbralo Mover) — Operation: Move, a la carpeta `entregas` del cliente. El ID de carpeta lo puedes resolver con un nodo «Google Drive» de búsqueda por nombre, o con un mapa fijo en el Code.
**9. «Airtable»** — Operation: Create, guarda archivo, cliente, proyecto, pieza, versión, fecha y el enlace `https://drive.google.com/file/d/{{ $('Google Drive Trigger').first().json.id }}/view`.
## El trozo de código (nodo «Code» del paso 2)
```javascript
const nombre = $input.first().json.name || '';
const ext = (nombre.match(/\.[^.]+$/) || ['.pdf'])[0].toLowerCase();
const sinExt = nombre.replace(/\.[^.]+$/, '');
const partes = sinExt.toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g,'').split('-').map(p => p.trim()).filter(Boolean);
if (partes.length < 3) {
  return [{ json: { valido: false, motivo: 'El nombre debe ser cliente-proyecto-pieza', nombre } }];
}
const [cliente, proyecto, ...resto] = partes;
const pieza = resto.join('-');
const hoy = new Date();
const fecha = hoy.getFullYear() + String(hoy.getMonth()+1).padStart(2,'0') + String(hoy.getDate()).padStart(2,'0');
return [{ json: { valido: true, cliente, proyecto, pieza, fecha, ext, plantilla: (v) => v, nombre_original: nombre } }];
```
Y en el paso 5, tras calcular la versión, añade: `nombre_final: [base.cliente, base.proyecto, base.pieza, 'v' + String(version).padStart(2,'0'), base.fecha].join('_').toUpperCase() + base.ext`
## Cómo probarla
Sube un archivo llamado `panaderia-rebranding-cartel.pdf` al buzón. Debe aparecer en `entregas` como `PANADERIA_REBRANDING_CARTEL_V01_20260909.PDF` y registrado en Airtable.
Vuelve a subir el mismo nombre: la versión debe subir a V02 y la anterior irse a `_historico`.
Sube uno mal nombrado (`prueba.pdf`) y comprueba que te llega el aviso en vez de romperse el flujo.
## Qué puede salir mal
Nombres con espacios o mayúsculas: el código los normaliza, pero acostúmbrate a soltar con guiones para que la separación sea la correcta.
Si dos archivos caen en el mismo minuto, el trigger los procesa como items separados y funciona, pero el cálculo de versión puede duplicarse. Pon un nodo «Wait» de 5 segundos tras el trigger o usa Batch Size 1.
Los IDs de carpeta de cliente hay que mantenerlos: guarda el mapa cliente-carpeta en Airtable en vez de a fuego en el código.
La extensión se pone en mayúsculas con `toUpperCase()`; si lo prefieres en minúsculas, aplica el toUpperCase solo a la parte del nombre.
## Cuánto cuesta
Gratis: Drive con tu cuenta habitual, Airtable plan gratuito, n8n auto-alojado. Si usas n8n Cloud gratuito, ojo: un trigger que sondea cada minuto consume muchas ejecuciones, ponlo cada 15 minutos.
