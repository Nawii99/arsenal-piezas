# Entrega de proyecto al cliente en un solo paso…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Marcas un proyecto como entregable en tu hoja y se crea la carpeta ordenada en Drive, se comparte con el cliente y sale el email de entrega con las condiciones de uso.

## Qué es y qué hace

Recorre una hoja de proyectos y, a los marcados como listos, crea en Drive una carpeta con subcarpetas estándar (Logo, Aplicaciones, Editables, Guía), mueve allí los archivos, la comparte con el cliente y envía el correo de entrega con enlace y condiciones de uso. Entrada: fila de proyecto; salida: carpeta compartida y email. Se monta en n8n con Drive, Sheets y Gmail.

## Cómo usarla

1. Crea la hoja Proyectos
2. Redacta el texto de entrega con la licencia
3. Prueba con un proyecto de ensayo
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando cierras proyectos de identidad o packs de piezas y pierdes media tarde ordenando archivos, subiendo a WeTransfer y escribiendo el correo de siempre.

## Cómo ganar dinero con ella

Ahorra 30-45 minutos por entrega y evita el ida y vuelta de «no me abre el enlace». Con 4 entregas al mes son unas 3 horas.

- Entregas ordenadas para diseñadores que cierran identidades y packs de piezas.
- Plantilla de cierre de proyecto para estudios pequeños con varios clientes.
- Automatización de entregas para freelances que trabajan con licencias de uso.

**Precio orientativo:** 60–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recorre una hoja con tus proyectos, y para los marcados como listos crea en Drive una carpeta con subcarpetas estándar (Logo, Aplicaciones, Editables, Guía), mueve allí los archivos, la comparte con el correo del cliente y envía un email de entrega con el enlace y las condiciones. Para diseñadores freelance y estudios pequeños.

## Lo que necesitas antes
- n8n instalado.
- Google conectado por OAuth con Drive API, Sheets API y Gmail API activadas en console.cloud.google.com.
- Una hoja «Proyectos» con columnas: `cliente`, `email_cliente`, `proyecto`, `carpeta_origen_id`, `estado`, `enlace_entrega`.
- Un texto de entrega tuyo, con la licencia de uso y qué incluye el pack.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Minutes, Minutes Between Triggers: 15.
2. **Google Sheets** — Operation: Get Row(s), hoja «Proyectos», Filters: Lookup Column `estado`, Lookup Value `entregar`.
3. **Split In Batches** («Loop Over Items») — Batch Size: 1.
4. **Google Drive** — Resource: Folder, Operation: Create. Folder Name: `={{ $json.cliente }} - {{ $json.proyecto }} - ENTREGA`. Parent Folder: tu carpeta «Entregas».
5. **Code** — Mode: Run Once for Each Item. Devuelve las cuatro subcarpetas a crear (código abajo).
6. **Google Drive** — Resource: Folder, Operation: Create. Folder Name: `={{ $json.sub }}`. Parent Drive Folder: `={{ $json.padre }}`. Se ejecutará cuatro veces, una por item.
7. **Google Drive** — Resource: File/Folder, Operation: Search. Search Method: Advanced, Query String: `'{{ $('Loop Over Items').item.json.carpeta_origen_id }}' in parents and trashed = false`.
8. **Google Drive** — Resource: File, Operation: Copy. File By ID `={{ $json.id }}`, Parent Folder: la carpeta de entrega creada en el paso 4 (`={{ $('Google Drive').first().json.id }}`).
9. **Google Drive** — Resource: File/Folder, Operation: Share. Item By ID: la carpeta de entrega. Permissions: Role Reader, Type User, Email Address `={{ $('Loop Over Items').item.json.email_cliente }}`. En Options activa Send Notification Email: false, para mandar tú el correo bonito.
10. **Gmail** — Operation: Send. To: `={{ $('Loop Over Items').item.json.email_cliente }}`. Subject: `Entrega final: {{ $('Loop Over Items').item.json.proyecto }}`. Message (HTML): tu texto con `<a href="{{ $('Google Drive').first().json.webViewLink }}">Descargar los archivos</a>`.
11. **Google Sheets** — Operation: Update Row, Matching Column `proyecto`: `estado` = `entregado`, `enlace_entrega` = el webViewLink.
12. Conecta de vuelta a **Loop Over Items**.

## El nodo Code
```javascript
const padre = $('Google Drive').first().json.id;
return ['01 Logo', '02 Aplicaciones', '03 Editables', '04 Guia de marca']
  .map(sub => ({ json: { sub, padre } }));
```

## Cómo probarla
Crea un proyecto falso con tu propio correo como cliente y cuatro archivos de prueba en la carpeta origen. Ejecuta en modo test y comprueba: carpeta creada con las cuatro subcarpetas, archivos copiados, enlace que abre desde una ventana de incógnito y correo recibido.

## Qué puede salir mal
- **El cliente no puede abrir el enlace**: usa Type `anyone` en el nodo Share si no quieres pedirle cuenta de Google, pero entonces cualquiera con el enlace entra.
- **Se entrega dos veces**: si el paso 11 falla, la fila sigue en `entregar`. Activa Retry On Fail en ese nodo y pon la actualización de la hoja como último paso, nunca antes del email.
- **Muchos archivos**: la copia uno a uno es lenta. Con más de 50 archivos, mejor mover la carpeta entera con Operation: Move en vez de copiar.
- **Cuota de Gmail**: con la cuenta gratuita, 500 correos al día; para entregas vas sobrado.

## Cuánto cuesta
Gratis por completo con n8n auto-alojado y una cuenta normal de Google. Si tu Drive se llena, 15 GB gratis y luego 1,99 €/mes por 100 GB.
