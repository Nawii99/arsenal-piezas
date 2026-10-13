# Mockups de producto generados solos al subir el diseño…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

En cuanto dejas un arte final en una carpeta de Drive, genera automáticamente los mockups (camiseta, taza, cartel, packaging) y te los devuelve en otra carpeta.

## Qué es y qué hace

Cuando aparece un PNG nuevo en una carpeta de Drive, lo envía a un servicio de mockups por API (Dynamic Mockups, Placid o Mediamodifier), recibe las imágenes de camiseta, taza, cartel o packaging y las guarda en una carpeta de entregas, avisando por Slack. Se monta con n8n, Make o Zapier y necesita una cuenta de mockups con plantillas.

## Cómo usarla

1. Crea las carpetas de artes y mockups en Drive
2. Diseña un Mockup Set y copia sus identificadores
3. Conecta la API key y Slack
4. Sube un arte de prueba y revisa los resultados

## Cuándo usarla

Cuando presentas propuestas de merchandising, packaging o rotulación y pierdes la tarde colocando el diseño en plantillas de Photoshop una por una.

## Cómo ganar dinero con ella

Cada presentación con 8 mockups son 45-60 minutos de Photoshop. A 40 €/hora, unos 35 € por propuesta y varias horas al mes recuperadas.

- Presentaciones de merchandising con mockups listos en un día…
- Paquete mensual de mockups para marcas con catálogo de productos…
- Set de mockups de packaging para propuestas de estudios de diseño…

**Precio orientativo:** 50–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta de Google Drive; cuando aparece un PNG nuevo, lo manda a un servicio de mockups por API con varias plantillas y guarda las imágenes resultantes en una carpeta de entregas, avisándote por Slack.
Es para diseñadores gráficos que hacen merchandising, packaging o propuestas visuales y repiten el mismo montaje una y otra vez.
## Lo que necesitas antes
Dos carpetas en Google Drive: `01-artes-finales` y `02-mockups`. Apunta el ID de cada una (está en la URL después de `/folders/`).
Cuenta en dynamicmockups.com (también valen Placid o Mediamodifier, la lógica es igual). En su panel crea un «Mockup Set» con las plantillas que uses y copia el `mockup_uuid` y el `smart_object_uuid` de cada una. La API key está en Settings > API.
En n8n: credencial «Google Drive OAuth2 API» y credencial «Header Auth» con Name `x-api-key` y Value tu clave de Dynamic Mockups. Credencial de Slack opcional.
## Los nodos, en orden
**1. «Google Drive Trigger»** — Trigger On: Specific Folder, Folder: `01-artes-finales`, Event: File Created, Poll Times: Every Minute.
**2. «Google Drive»** (nómbralo Enlace público) — Resource: File, Operation: Share, File ID `{{ $json.id }}`, Permissions: Role `reader`, Type `anyone`. El servicio de mockups necesita poder descargar la imagen.
**3. «Set»** (Edit Fields) — crea el campo `url_diseno` con valor `https://drive.google.com/uc?export=download&id={{ $('Google Drive Trigger').first().json.id }}` y `nombre` con `{{ $('Google Drive Trigger').first().json.name }}`.
**4. «Code»** — genera un item por cada plantilla que quieras (código abajo).
**5. «Split In Batches»** — Batch Size 1.
**6. «HTTP Request»** (nómbralo Render) — POST a `https://app.dynamicmockups.com/api/v1/renders`, Authentication: Header Auth. Body Content Type: JSON, Specify Body: Using JSON, con: `{ "mockup_uuid": "{{ $json.mockup_uuid }}", "export_label": "{{ $json.etiqueta }}", "export_options": { "image_format": "jpg", "image_size": 1500 }, "smart_objects": [ { "uuid": "{{ $json.smart_object_uuid }}", "asset": { "url": "{{ $json.url_diseno }}" } } ] }`. Settings: Retry On Fail, 3 intentos.
**7. «HTTP Request»** (nómbralo Descargar) — GET a `{{ $json.data.export_path }}`, Response Format: File, Put Output in Field `data`.
**8. «Google Drive»** — Operation: Upload, File Name `{{ $('Split In Batches').first().json.nombre_salida }}`, Parent Folder: `02-mockups`, Input Data Field Name `data`.
**9. «Slack»** — mensaje al canal: `Listos los mockups de {{ $('Set').first().json.nombre }}`.
**10.** Conecta la salida de vuelta a «Split In Batches» para la siguiente plantilla.
## El trozo de código (nodo «Code»)
```javascript
const base = $input.first().json;
const plantillas = [
  { etiqueta: 'camiseta-blanca', mockup_uuid: 'PEGA_AQUI_UUID_1', smart_object_uuid: 'PEGA_AQUI_SO_1' },
  { etiqueta: 'taza', mockup_uuid: 'PEGA_AQUI_UUID_2', smart_object_uuid: 'PEGA_AQUI_SO_2' },
  { etiqueta: 'cartel-calle', mockup_uuid: 'PEGA_AQUI_UUID_3', smart_object_uuid: 'PEGA_AQUI_SO_3' },
  { etiqueta: 'tarjeta', mockup_uuid: 'PEGA_AQUI_UUID_4', smart_object_uuid: 'PEGA_AQUI_SO_4' }
];
const limpio = String(base.nombre).replace(/\.[^.]+$/, '').replace(/[^a-zA-Z0-9-_]+/g, '-').toLowerCase();
return plantillas.map(p => ({ json: { ...p, url_diseno: base.url_diseno, nombre: base.nombre, nombre_salida: `${limpio}_${p.etiqueta}.jpg` } }));
```
## Cómo probarla
Sube un PNG de 2000x2000 px con fondo transparente a `01-artes-finales` y espera un minuto. Deberían aparecer cuatro JPG en `02-mockups`.
Si el mockup sale con el diseño torcido o recortado, el problema está en el smart object de la plantilla, no en la automatización: ajústalo en el panel del servicio.
## Qué puede salir mal
El trigger de Drive tarda hasta un minuto en detectar; si tienes prisa, ejecuta el workflow a mano.
Si el arte final pesa más de 25 MB, la descarga desde Drive puede fallar. Trabaja con PNG optimizados a 1500-2500 px de lado.
Los enlaces públicos de Drive son públicos de verdad: usa una carpeta dedicada y no metas ahí nada confidencial. Alternativa: sube el archivo a un bucket temporal.
Si el arte es un PDF o AI, no vale: el servicio necesita PNG o JPG. Añade un paso previo de conversión o exporta tú el PNG.
## Cuánto cuesta
n8n y Drive gratis. Dynamic Mockups tiene un plan gratuito con unos 10-20 renders al mes; los planes de pago arrancan sobre 19-29 $/mes con cientos de renders. Sale a cuenta desde la segunda propuesta del mes.
