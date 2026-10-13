# Revelado y entrega de fotos por lotes con n8n…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Tus lotes de fotos se revelan, redimensionan y el cliente recibe el enlace automáticamente.

## Qué es y qué hace

Es una receta de n8n que entrega lotes de fotos ya revelados: detecta la carpeta de entrada, redimensiona, comprime y envía al cliente un enlace automático. Entran las fotos que el fotógrafo deja en una carpeta por encargo; salen las versiones para cada uso y un correo con el enlace. Usa Google Drive y Gmail, y opcionalmente remove.bg para quitar fondos.

## Cómo usarla

1. Crea una carpeta por encargo
2. Monta el disparador, el redimensionado y el envío
3. Prueba la entrega con un lote pequeño antes de usarla

## Cuándo usarla

Cuando entregas sesiones de 50 o 200 fotos a negocios pequeños y se te va la tarde en recortar, renombrar, comprimir y mandar enlaces.

## Cómo ganar dinero con ella

No se vende sola: es tu margen. Te ahorra 1-2 horas por entrega.

- Entrega automática de sesiones de 50 a 200 fotos para negocios pequeños.
- Servicio de revelado y entrega para otros fotógrafos que no quieren perder la tarde.
- Mantenimiento mensual del flujo de entrega con cuota fija para estudios pequeños.

**Precio orientativo:** 250–400 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Receta de n8n: entrega de un lote de fotos ya revelado, ordenado y avisado.

Cuentas que hacen falta y su límite gratuito:
- n8n: gratis si lo instalas tú (autoalojado, sin límite de ejecuciones). La nube de n8n tiene prueba y luego es de pago.
- Google Drive: 15 GB gratis compartidos con Gmail. Un lote de 200 fotos en JPG ocupa 1-2 GB, así que vacía cada mes.
- Cuenta de correo para avisar (Gmail): unos 500 envíos al día, de sobra.
- Opcional, quitar fondo: remove.bg da 50 imágenes gratis al mes con marca de agua en alta; si vas a quitar fondos en serio, usa el nodo de imagen local en vez de una API de pago.

Nodos, en orden:
1. Disparador: Google Drive Trigger, evento 'archivo creado en carpeta'. Apunta a una carpeta llamada ENTRADA-CLIENTE. Consulta cada 5 minutos. Truco: en vez de disparar por foto, crea una subcarpeta por encargo y dispara por carpeta.
2. Wait de 2 minutos. Así te da tiempo a subir todas las fotos antes de que arranque el proceso y no se dispare cien veces.
3. Google Drive - Search: lista todos los archivos de esa subcarpeta. Filtra por tipo imagen.
4. Split In Batches, tamaño 10. Es lo que evita que se quede sin memoria con lotes grandes.
5. Google Drive - Download File: baja el archivo binario de cada foto.
6. Edit Image (nodo nativo de n8n), operación 'resize': largo mayor a 2000 px, calidad 85. Esta es la copia para web.
7. Edit Image otra vez, operación 'resize' a 1080 px, y si el cliente lo pide, operación 'composite' para poner su logo en una esquina con opacidad 40.
8. Code (JavaScript): renombra cada archivo con el patrón cliente-fecha-numero, por ejemplo panaderia-lopez-2026-03-14-007.jpg. Devuelve también el nombre original en un campo aparte para no perder la trazabilidad.
9. Google Drive - Upload: sube las dos versiones a dos subcarpetas, WEB y REDES, dentro de una carpeta ENTREGAS/nombre-del-cliente.
10. Google Drive - Share: comparte la carpeta de entrega con el correo del cliente, permiso de solo lectura.
11. Google Sheets - Append: apunta una fila por encargo con fecha, cliente, número de fotos, enlace y si está cobrado. Este es tu registro y tu factura.
12. Gmail - Send: correo al cliente con el enlace, cuántas fotos hay, qué hay en cada carpeta y hasta qué fecha estará disponible.
13. Rama de error (Error Trigger en un flujo aparte): si algo falla, correo a ti mismo con el nombre del encargo y el mensaje. Sin esto te enteras cuando se queja el cliente.

Cómo probarla sin liarla:
- Crea una carpeta de pruebas y un cliente falso con tu propio correo. No apuntes el disparador a la carpeta real hasta que dos lotes seguidos salgan bien.
- Empieza con 3 fotos, no con 200.
- Desactiva el nodo 11 y el 12 en las primeras pruebas: así no mandas correos ni ensucias la hoja.
- Pon el flujo en modo manual las dos primeras semanas y dale tú al botón. Cuando no falle, actívalo.

Límites y avisos:
- Las fotos de clientes son datos de otras personas. No las dejes en carpetas públicas ni con enlace abierto a cualquiera.
- Si en las fotos salen caras de clientes o empleados, hace falta su permiso antes de publicarlas en ningún sitio, y ese permiso lo recoge el negocio, no la automatización.
- Borra las carpetas de entrega pasados 60 días y avísalo en el correo. Menos riesgo y menos gigas.
- Este flujo no retoca ni juzga: si una foto está movida o mal expuesta, la entrega igual. La selección la haces tú antes de subir a ENTRADA-CLIENTE.
