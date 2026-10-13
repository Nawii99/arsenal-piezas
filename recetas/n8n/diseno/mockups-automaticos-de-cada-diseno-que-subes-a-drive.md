# Mockups automáticos de cada diseño que subes a Drive…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Cuando dejas un diseño plano en una carpeta de Drive, lo compone dentro de plantillas de mockup (tarjeta, cartel, camiseta) y te devuelve las imágenes listas para presentar.

## Qué es y qué hace

Detecta un diseño nuevo en la carpeta 01-Para-mockup de Drive, lo envía a Placid con tres plantillas que tengan una capa llamada arte y guarda las imágenes en 02-Mockups-listos avisando por correo. Entrada: PNG; salida: tres mockups listos. Se monta en n8n con Placid y Google Drive.

## Cómo usarla

1. Crea tres plantillas en Placid con la capa arte
2. Copia el token de API
3. Crea las dos carpetas de Drive
4. Prueba con un PNG de muestra

## Cuándo usarla

Cuando presentas propuestas a cliente y pierdes media tarde metiendo el diseño en smart objects de Photoshop uno por uno.

## Cómo ganar dinero con ella

Ahorra 30-45 minutos por propuesta. A cuatro propuestas al mes son 3 horas recuperadas.

- Presentaciones de propuesta para diseñadores que muestran el arte en contexto.
- Mockups de packaging para estudios de identidad en fase de concepto.
- Mockups rápidos para freelances que presentan tres propuestas al cliente.

**Precio orientativo:** 50–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta un archivo nuevo en la carpeta `01-Para-mockup` de Drive, lo envía a Placid (servicio de composición de imágenes por API), genera tres mockups con tus plantillas y deja los resultados en `02-Mockups-listos`, avisándote por correo. Para diseñadores freelance y estudios pequeños que presentan mucho.

## Lo que necesitas antes
- Cuenta de n8n.
- Cuenta en placid.app: plan gratuito de pruebas; en el editor creas tres plantillas con una capa de imagen llamada exactamente `arte`. Cada plantilla tiene un `uuid` visible en su URL.
- Token de API de Placid: panel, Settings, API Tokens, botón Create token. Se usa como `Authorization: Bearer TU_TOKEN`.
- Dos carpetas en Google Drive y sus IDs (el trozo de la URL después de `/folders/`).
- Credencial de Google Drive y de Gmail en n8n (Google Cloud, activar Drive API y Gmail API, OAuth de aplicación web).

## Los nodos, en orden
1. **Google Drive Trigger** — Event: File Created. Watch: Specific Folder, la carpeta `01-Para-mockup`. Poll Times: Every Minute.
2. **Google Drive** — Operation: Share File. File ID: `{{ $json.id }}`. Permissions: Role `reader`, Type `anyone`. Placid necesita una URL pública para leer el arte.
3. **Set** (`Datos`) — Campos: `arte_url` = `https://drive.google.com/uc?export=view&id={{ $('Google Drive Trigger').item.json.id }}`, `nombre` = `{{ $('Google Drive Trigger').item.json.name }}`.
4. **Code** (`Plantillas`) — Mode: Run Once for All Items. `const uuids = ['UUID_TARJETA','UUID_CARTEL','UUID_CAMISETA']; return uuids.map(u => ({ json: { uuid: u, arte_url: $input.first().json.arte_url, nombre: $input.first().json.nombre } }));`
5. **HTTP Request** (`Crear mockup`) — Method: POST. URL: `https://api.placid.app/api/rest/{{ $json.uuid }}`. Authentication: Generic, Header Auth, Name `Authorization`, Value `Bearer TU_TOKEN`. Body: JSON, contenido `{ "layers": { "arte": { "image": "{{ $json.arte_url }}" } } }`.
6. **Wait** — Amount: 8, Unit: Seconds. Placid genera en segundo plano.
7. **HTTP Request** (`Recoger imagen`) — Method: GET. URL: `{{ $('Crear mockup').item.json.polling_url }}`. Misma cabecera de autorización.
8. **HTTP Request** (`Descargar`) — Method: GET. URL: `{{ $json.image_url }}`. Options, Response, Response Format: File, Put Output in Field: `data`.
9. **Google Drive** — Operation: Upload File. Input Data Field Name: `data`. File Name: `{{ $('Plantillas').item.json.nombre.replace(/\.[^.]+$/,'') }}-mockup-{{ $itemIndex }}.png`. Parent Folder: `02-Mockups-listos`.
10. **Gmail** — Send. Subject: `Mockups listos: {{ $('Datos').first().json.nombre }}`. Message: enlace a la carpeta de resultados.

## Cómo probarla
- Sube un PNG cuadrado de 2000 px a la carpeta de entrada y ejecuta el workflow con **Execute Workflow** en modo escucha.
- Si el mockup sale en blanco, abre la `arte_url` en incógnito: si pide permiso, el paso 2 no se ejecutó.
- Comprueba en el paso 7 que `status` es `finished`; si sale `queued`, sube el Wait a 15 segundos.

## Qué puede salir mal
- **Placid tarda más de lo previsto**: en vez de Wait fijo, mete un IF que compruebe `status` distinto de `finished` y devuelva el flujo al Wait (bucle de reintento, máximo 3 vueltas).
- **Archivos que no son imagen**: añade un IF tras el trigger con `{{ $json.mimeType }}` starts with `image/`, o el flujo fallará con PDFs.
- **Drive dispara dos veces**: si mueves archivos dentro de Drive puede volver a saltar. Filtra por `createdTime` de los últimos 10 minutos.
- **Enlaces públicos**: el paso 2 deja el arte accesible por URL. Si es material confidencial, añade al final un nodo Google Drive con Operation: Delete Permission.

## Cuánto cuesta
- n8n auto-alojado: 0 euros.
- Placid: prueba gratuita, luego desde 19 euros al mes. Alternativa gratis total: montar ImageMagick en el servidor y usar el nodo Execute Command con `composite`, pero requiere tocar consola.
- Google Drive y Gmail: gratis.
- Coste real: 0 euros en pruebas, 19 euros al mes si lo usas en producción.
