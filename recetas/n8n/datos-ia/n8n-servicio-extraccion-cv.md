# Servicio automático de extracción de CVs con n8n…

**Tipo:** Receta de automatización · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Flujo de n8n que vigila una carpeta de Google Drive, pasa los CVs nuevos por OCR y un modelo de extracción, y deja los datos listos en una hoja de cálculo para facturar el servicio.

## Qué es y qué hace

Flujo de n8n que vigila una carpeta compartida de Google Drive, pasa los CV nuevos por OCR si hace falta, extrae los datos con un modelo de lenguaje y los deja como fila en una hoja de Google Sheets que puede entregarse al cliente. Entra los CV subidos; sale una hoja actualizada sola. Ejemplo: un cliente sube cinco CV y en la hoja aparecen cinco filas. El coste por CV es de pago por uso. Son datos personales: que lo revise un profesional.

## Cómo usarla

1. Crea la carpeta compartida
2. Configura OCR, extracción y la hoja
3. Calcula el coste por CV antes de fijar precio
4. Que lo revise un profesional

## Cuándo usarla

Si un cliente sube CVs a una carpeta compartida y quieres que se procesen solos y acaben en una hoja de cálculo, sin repetir el trabajo cada vez.

## Cómo ganar dinero con ella

Véndelo como servicio recurrente de extracción de CVs a agencias de selección y autónomos de RRHH: cuota mensual por volumen, [TU PRECIO]. Una persona revisa los resultados, porque son datos personales y de empleo, y calcula el coste por CV antes de fijar el precio.

- Servicio recurrente de extracción de CV para agencias de selección…
- Cuota mensual por volumen de CV para autónomos de RRHH…
- Mantenimiento de la hoja de candidatos y revisión de resultados para un cliente…

**Precio orientativo:** 80–200 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Servicio automático de extracción de CVs con n8n

## Qué monta este flujo
Cada vez que un cliente sube un CV nuevo a una carpeta compartida de Google Drive, el flujo lo procesa solo: lo pasa por OCR si hace falta, extrae los datos con un modelo de lenguaje y los deja en una fila de una hoja de Google Sheets. Esa hoja es lo que le entregas (o le das acceso) al cliente que paga por el servicio.

## Cuentas necesarias y límites gratuitos
- Cuenta de Google (Drive y Sheets): gratis, con el límite de espacio normal de una cuenta gratuita (15 GB compartidos con Gmail y Fotos).
- OCR.space: capa gratuita de 25.000 peticiones al mes, con archivos de hasta 1 MB por PDF/imagen; si los CVs pesan más, hay que comprimirlos antes o pasar a un plan de pago.
- Cuenta de OpenAI o Anthropic para el nodo de extracción con modelo de lenguaje: de pago por uso (no tiene capa gratuita indefinida), calcula el coste por CV antes de fijar el precio del servicio.
- n8n: puedes usar n8n Cloud (con prueba gratuita temporal y después de pago) o self-hosted gratis (Community Edition) en tu propio servidor si quieres evitar la cuota del plan.

## Nodos, en orden
1. Disparador: nodo Google Drive Trigger, evento 'Archivo creado', apuntando a la carpeta compartida 'CVs entrantes'.
2. Nodo IF: comprueba la extensión del archivo. Si es .pdf con texto seleccionable, va por una rama; si es imagen (.jpg, .png) o PDF escaneado, va por la rama de OCR.
3. Rama OCR: nodo HTTP Request llamando a la API de OCR.space con el archivo, para sacar el texto plano.
4. Rama PDF con texto: nodo 'Extract from File' de n8n para sacar el texto directamente, sin pasar por OCR.
5. Ambas ramas se unen en un nodo Merge y siguen al mismo sitio.
6. Nodo del modelo de lenguaje (OpenAI o Anthropic): usa como instrucción el esquema de la pieza 'jsonprompt-extraccion-cv' de este mismo pack, pasándole el texto extraído.
7. Nodo Code (JavaScript): valida que la respuesta del modelo sea JSON válido y que tenga al menos el nombre o el email rellenos; si no, marca la fila como 'revisar_manual'.
8. Nodo Google Sheets, operación 'Append': añade una fila nueva con los campos extraídos más el nombre del archivo de origen y la fecha de proceso.
9. Nodo IF de aviso: si es el primer CV procesado del mes para ese cliente, o si se ha superado el número de CVs incluidos en su tarifa, dispara un nodo Gmail que te avisa a ti (no al cliente) para preparar la factura del mes.

## Cómo probarla sin liarla
1. Crea una carpeta de prueba en Drive, separada de la carpeta real del cliente, y sube 2 o 3 CVs inventados (no de personas reales) para el primer test.
2. Ejecuta el flujo manualmente desde n8n (botón 'Test workflow') en vez de dejarlo activo, para ver los datos paso a paso en cada nodo.
3. Revisa que la fila que aparece en Google Sheets tiene los datos bien colocados en cada columna, no todo mezclado en una sola celda.
4. Solo cuando el test con CVs inventados salga bien, activa el disparador sobre la carpeta real del cliente y avísale de que a partir de ese momento el servicio queda activo.
