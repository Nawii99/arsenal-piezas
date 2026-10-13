# Recepción de encargos de vídeo sin cadenas de emails…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

El cliente rellena un formulario, se le crea su carpeta en Drive, la tarea en Trello y recibe un email con instrucciones y el enlace para subir el material.

## Qué es y qué hace

Un formulario público recoge el encargo (cliente, tipo de vídeo, duración, fecha límite y referencias). Al enviarlo, crea la carpeta del proyecto en Drive con subcarpetas ordenadas, una tarjeta en Trello con checklist y fecha, y un correo al cliente con el enlace de subida. Entran los datos del formulario y las claves de Drive y Trello; salen carpeta, tarjeta y correo. Para videógrafos y productoras pequeñas.

## Cómo usarla

1. Crea la carpeta PROYECTOS y la plantilla de subcarpetas en Drive
2. Saca la API Key y el token de Trello
3. Localiza el ID de la lista Entrantes
4. Haz una prueba completa con un encargo ficticio

## Cuándo usarla

Cuando eres videógrafo o editor y cada encargo empieza con diez correos preguntando el brief, los archivos y la fecha de entrega.

## Cómo ganar dinero con ella

Quita 30-40 minutos de gestión por encargo y evita el retraso típico de esperar material. Con 10 encargos al mes son 6 horas.

- Gestión de encargos de vídeo para freelances, con carpeta y brief creados al instante…
- Sistema de recepción de proyectos para productoras que reciben muchas peticiones…
- Configuración de recepción de encargos para estudios de edición…

**Precio orientativo:** 150–350 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un formulario público recoge los datos del encargo (cliente, tipo de vídeo, duración, fecha límite, referencias). Al enviarlo se crea automáticamente la carpeta del proyecto en Drive con subcarpetas ordenadas, una tarjeta en Trello con checklist y fecha, y un correo al cliente con el enlace de subida. Para videógrafos, editores freelance y pequeñas productoras.

## Lo que necesitas antes
- n8n.
- El nodo **n8n Form Trigger** (viene incluido, no necesitas Typeform ni nada de pago).
- Credencial de Google Drive.
- Cuenta de Trello: saca tu API Key y Token en `trello.com/power-ups/admin` o en `trello.com/app-key`. Necesitas el ID de la lista «Entrantes»: abre el tablero, añade `.json` al final de la URL y busca el `id` de la lista.
- Una carpeta raíz en Drive llamada `PROYECTOS` y una plantilla mental de subcarpetas: `01-BRIEF`, `02-MATERIAL-CLIENTE`, `03-EDICION`, `04-ENTREGAS`.

## Los nodos, en orden
1. **n8n Form Trigger** — Form Title: `Nuevo encargo de vídeo`. Campos: `Tu nombre` (texto, obligatorio), `Email` (email, obligatorio), `Empresa` (texto), `Tipo de vídeo` (desplegable: Reel, Corporativo, Evento, Formación, Anuncio), `Duración aproximada` (desplegable: menos de 1 min, 1-3 min, 3-10 min, más de 10 min), `Fecha de entrega` (date), `Cuéntame el vídeo` (textarea, obligatorio), `Enlaces de referencia` (textarea), `Presupuesto` (desplegable por tramos). Copia la URL de producción que te da n8n y ponla en tu web o en tu bio.
2. **Code** — Genera el código de proyecto (`2026-032-ACME`) y limpia el nombre de la carpeta.
3. **Google Drive** — Operation: `Create Folder`. Name: `{{ $json.codigo }} - {{ $json.empresa }}`. Parent Folder: `PROYECTOS`.
4. **Code1** — Devuelve 4 items, uno por subcarpeta, con el ID de la carpeta padre.
5. **Google Drive1** — `Create Folder` para cada uno. Name: `{{ $json.sub }}`. Parent Folder ID: `{{ $json.padre }}`. Se ejecuta cuatro veces automáticamente.
6. **Google Drive2** — Operation: `Share` sobre la subcarpeta `02-MATERIAL-CLIENTE`. Role: `writer`, Type: `anyone`. Ese es el enlace de subida que mandas al cliente.
7. **Trello** — Resource: `Card`, Operation: `Create`. List ID: el de «Entrantes». Name: `{{ $('Code').item.json.codigo }} · {{ tipo }} · {{ empresa }}`. Description: el brief completo. Due Date: `{{ $('n8n Form Trigger').item.json['Fecha de entrega'] }}`.
8. **Trello1** — Resource: `Checklist`, Operation: `Create`. Card ID: `{{ $json.id }}`. Name: `Producción`. Después añade con `Checklist Item` los pasos: Brief confirmado, Material recibido, Guion, Montaje v1, Correcciones, Entrega final, Factura.
9. **Gmail** — Send al cliente. Asunto: `Tu proyecto {{ codigo }} ya está en marcha`. Cuerpo con el enlace de subida, qué material necesitas (bruto, logo en PNG con fondo transparente, música si tiene licencia) y la fecha comprometida.
10. **Gmail1** — Send a ti mismo con el resumen y el enlace a la tarjeta de Trello.

## El código del nodo Code (paso 2)
```javascript
const f = $json;
const hoy = new Date();
const semana = String(Math.ceil(((hoy - new Date(hoy.getFullYear(), 0, 1)) / 86400000 + 1) / 7)).padStart(3, '0');
const empresa = (f['Empresa'] || f['Tu nombre'] || 'CLIENTE').toUpperCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/[^A-Z0-9 ]/g, '').trim().slice(0, 20);
const codigo = hoy.getFullYear() + '-' + semana + '-' + empresa.replace(/ /g, '-');
return { json: { ...f, codigo, empresa } };
```

## El código del nodo Code1 (paso 4)
```javascript
const padre = $json.id;
const subs = ['01-BRIEF', '02-MATERIAL-CLIENTE', '03-EDICION', '04-ENTREGAS'];
return subs.map(sub => ({ json: { sub, padre } }));
```

## Cómo probarla
1. Rellena tú mismo el formulario con datos falsos y una fecha de la semana que viene.
2. Comprueba: carpeta creada con sus cuatro subcarpetas, enlace de subida que funciona desde una ventana de incógnito, tarjeta en Trello con la fecha y el checklist, y los dos correos.
3. Pide a un amigo que suba un archivo por el enlace para confirmar que puede escribir pero no ver el resto del proyecto.

## Qué puede salir mal
- **El enlace de escritura da acceso a esa subcarpeta y solo a esa**: nunca compartas la carpeta raíz del proyecto.
- **Trello devuelve 401**: el token caduca si lo generaste con caducidad. Genera uno «never expires» desde la página de la power-up admin.
- **Fechas al revés**: el campo `date` del formulario devuelve `YYYY-MM-DD`, que es lo que Trello espera. Si escribes la fecha a mano en formato español, falla.
- **Nombres de empresa con barras o dos puntos** rompen el nombre de carpeta: el `replace` del Code ya los quita.
- **Spam**: si publicas la URL del formulario, mete un campo trampa oculto o un **IF** que descarte envíos sin texto en el brief.

## Cuánto cuesta
Cero. Form Trigger va incluido en n8n, Trello tiene plan gratuito con tableros ilimitados y Drive y Gmail entran en tu cuenta de Google. Solo pagarías Drive si superas los 15 GB, algo probable con vídeo: 2,99 €/mes por 200 GB o 9,99 € por 2 TB.
