# Entrega de archivos al cliente en un clic…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Marcas un proyecto como listo en tu hoja y se genera la carpeta ordenada, el enlace de descarga y el email de entrega con las condiciones de uso.

## Qué es y qué hace

Cuando pones «entregar» en la columna de estado de un proyecto, crea en Drive la estructura de carpetas de entrega, mueve los archivos finales, ajusta los permisos de descarga y envía al cliente un correo con el enlace, el listado de lo incluido y las condiciones de uso. Entran la hoja proyectos y la carpeta de origen; sale la entrega completa. Para diseñadores y estudios que entregan identidades o packs. Las condiciones de uso deben revisarlas un profesional.

## Cómo usarla

1. Crea la hoja proyectos con sus columnas
2. Configura Drive, Sheets y Gmail en n8n
3. Redacta las condiciones de uso con un profesional
4. Haz una entrega de prueba a tu propia cuenta
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando terminas encargos de identidad o piezas gráficas y cada entrega te lleva media hora de ordenar carpetas, comprimir y escribir el mismo correo.

## Cómo ganar dinero con ella

Ahorra 20-30 minutos por entrega y evita el clásico «no encuentro el logo en vectorial» que te cuesta otro correo. Coste: 0 €.

- Entrega digital de identidades visuales para estudios de diseño con condiciones incluidas…
- Gestión de entregas para freelances con archivos ordenados y enlace de descarga…
- Configuración de un flujo de entrega para agencias con varios clientes…

**Precio orientativo:** 80–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Cuando pones `entregar` en la columna de estado de un proyecto, el flujo crea en Drive la estructura de carpetas de entrega, mueve ahí los archivos finales, ajusta permisos para que el cliente pueda descargar y envía un email de entrega con el enlace, el listado de lo incluido y las condiciones de uso.
Para diseñadores freelance y estudios pequeños que entregan identidades, packs de redes o piezas sueltas.

**Lo que necesitas antes**
- Credencial OAuth de Google con permisos de Drive, Sheets y Gmail (console.cloud.google.com, APIs y servicios, Credenciales).
- Una hoja `proyectos` con columnas: cliente, email_cliente, proyecto, carpeta_origen_id, estado, fecha_entrega, enlace_entrega.
- Una carpeta raíz en Drive llamada `Entregas` y su ID.
- Un texto tuyo de condiciones de uso y de qué incluye la entrega (lo pegas en el nodo de email).

**Los nodos, en orden**
1. **Schedule Trigger**: Cron `*/15 * * * *` para revisar cada cuarto de hora. Si prefieres pulsar tú, cámbialo por un **Webhook** y llámalo desde un marcador del navegador.
2. **Google Sheets**: Get Row(s) con filtro `estado` igual a `entregar`.
3. **Google Drive**: Create Folder, nombre `{{ $json.cliente }} - {{ $json.proyecto }}`, dentro de `Entregas`.
4. **Code**: define las subcarpetas estándar de la entrega.
```javascript
const sub = ['01_Logo_vectorial', '02_Logo_PNG', '03_Paleta_y_tipografias', '04_Redes_sociales', '05_Manual_de_marca'];
const padre = $('Google Drive').first().json.id;
return sub.map(nombre => ({ json: { nombre, padre } }));
```
5. **Google Drive**: Create Folder otra vez, nombre `{{ $json.nombre }}`, Parent Folder `{{ $json.padre }}`.
6. **Google Drive**: Search Files/Folders dentro de `carpeta_origen_id` para listar los archivos finales, y luego **Google Drive** con operación Move File (o Copy File si quieres conservar el original) hacia la subcarpeta que toque. Para repartirlos usa un **Switch** que mire la extensión: `.svg` y `.ai` a vectorial, `.png` a PNG, `.pdf` al manual.
7. **Google Drive**: operación Share, tipo `anyone`, rol `reader`, sobre la carpeta de entrega. Así el cliente descarga sin cuenta de Google.
8. **Gmail**: Send Message a `{{ $('Google Sheets').item.json.email_cliente }}`, asunto «Entrega final: {{ proyecto }}», cuerpo en HTML con el enlace `{{ $json.webViewLink }}`, la lista de lo que incluye y tus condiciones de uso.
9. **Google Sheets**: Update Row, `estado` a `entregado`, `fecha_entrega` con `{{ $now.format('dd/MM/yyyy') }}` y `enlace_entrega` con el enlace.

**Cómo probarla**
- Crea un proyecto ficticio con tu propio correo como cliente y cuatro archivos de mentira en la carpeta de origen. Ponlo en `entregar` y ejecuta con Test Workflow.
- Abre el enlace desde una ventana de incógnito: si te pide iniciar sesión, el nodo Share no se aplicó bien.

**Qué puede salir mal**
- Doble entrega: si el Update Row falla, la siguiente pasada vuelve a enviar el correo. Pon el nodo de Sheets ANTES del de Gmail para marcarlo primero.
- Archivos que no encajan en ninguna subcarpeta: añade una rama por defecto en el Switch hacia `06_Otros`.
- Permisos de empresa: si tu Drive es de Google Workspace con políticas, el enlace público puede estar bloqueado. Entonces comparte por email con el rol `reader` indicando el correo del cliente.
- Correo a spam: manda desde tu dominio con Gmail configurado, no desde una cuenta recién creada.

**Cuánto cuesta**
- Todo gratis con una cuenta de Google normal (15 GB). Si mueves muchos GB, Google One de 100 GB son 1,99 €/mes.
- n8n auto-alojado: 0 €.
