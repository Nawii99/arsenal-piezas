# Leer facturas escaneadas en lote con n8n…

**Tipo:** Receta de automatización · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Sube facturas escaneadas, n8n lee y extrae datos (fecha, proveedor, IVA, total) a una hoja de cálculo automáticamente.

## Qué es y qué hace

Es una receta de n8n que lee facturas escaneadas o en PDF y extrae fecha, proveedor, base, IVA y total a una hoja de cálculo. Entran los archivos que dejas en una carpeta de Google Drive; salen filas listas en Google Sheets en unos minutos. El OCR puede ser Tesseract en tu equipo o un modelo de visión por API de pago por uso. Las facturas llevan NIF y datos personales, así que necesita permiso del cliente.

## Cómo usarla

1. Crea la carpeta de entrada y la hoja
2. Monta los nodos en orden desde el disparador de Drive
3. Prueba con diez facturas y revisa los totales. Que lo revise un profesional

## Cuándo usarla

Cuando recibes facturas o albaranes en papel o PDF escaneado y los metes a mano en una hoja cada mes.

## Cómo ganar dinero con ella

Automatización de entrada de facturas para una gestoría o un taller: 300-600 euros el montaje y 30-50 al mes por mantenerlo.

- Entrada automática de facturas para una gestoría que hoy pasa datos a mano cada mes.
- Lectura de albaranes de un taller para llevar el control de compras sin teclear.
- Mantenimiento mensual del flujo con revisión de errores y ajustes del OCR.

**Precio orientativo:** 300–600 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Que consigues: dejas un PDF o una foto de factura en una carpeta de Google Drive y a los pocos minutos aparece una fila en tu hoja de calculo con fecha, proveedor, base, IVA y total.

Cuentas necesarias y su limite gratuito:
- n8n. Version gratis instalada en tu ordenador, sin limite de ejecuciones. La version en la nube son unos 20 euros al mes.
- Google Drive y Google Sheets. Gratis con los 15 GB de tu cuenta de Google.
- Para el OCR, dos caminos: Tesseract instalado en tu equipo (gratis, sin limite, acierta peor con fotos torcidas) o un modelo de vision por API (mas preciso, entre 1 y 3 centimos por pagina).

Nodos, en orden:

1. Disparador: Google Drive Trigger. Modo «File Created», carpeta «Facturas entrada», cada 5 minutos. Es el que arranca todo cuando dejas un archivo.
2. Google Drive - Download File. Descarga el archivo que acaba de aparecer, en binario.
3. Switch. Mira la extension: si es PDF de texto va por una rama, si es JPG, PNG o PDF escaneado va por la rama de OCR.
4. Rama texto: Extract From File. Saca el texto directo, sin coste ni OCR.
5. Rama imagen: Execute Command con Tesseract (o nodo HTTP Request hacia el modelo de vision que uses). Devuelve el texto reconocido.
6. Edit Fields (Set). Junta las dos ramas en un unico campo «texto_factura».
7. Nodo de IA (Basic LLM Chain). Le pasas el texto y le pides un JSON con: fecha, proveedor, CIF, numero de factura, base imponible, tipo de IVA, cuota e importe total. Instruccion clave: «si un dato no aparece, deja el campo vacio, no lo deduzcas».
8. Code o Edit Fields. Convierte comas decimales a puntos y comprueba que base mas cuota es igual al total. Si no cuadra, marca la fila con «revisar: si».
9. IF. Si «revisar» es si, va al paso 11. Si no, al paso 10.
10. Google Sheets - Append Row. Anade la fila a la hoja «Facturas 2026».
11. Google Sheets - Append Row en una segunda hoja llamada «Para revisar», mas un Gmail o Telegram que te avise.
12. Google Drive - Move File. Mueve el archivo a la carpeta «Procesadas» para que no se vuelva a leer.

Como probarla sin liarla:
- Crea primero una carpeta «Facturas prueba» y una hoja de calculo vacia. No apuntes a tus carpetas reales hasta que funcione.
- Mete 3 facturas: una limpia, una escaneada torcida y una que sepas que da problemas.
- Ejecuta el flujo a mano con el boton «Test workflow» antes de activarlo. Asi no se dispara solo.
- Revisa a mano las 20 primeras filas comparandolas con el papel. El OCR se come ceros y confunde 1 con 7.
- Solo cuando salgan bien las 20, activa el disparador automatico.

Limites y avisos que tienes que tener en cuenta:
- Las facturas llevan datos de empresas y a veces de personas (autonomos, nombres, direcciones). Si son de un cliente tuyo, no las pases por ningun servicio externo sin su permiso por escrito, y dile cual usas.
- Si eliges OCR por API, ese proveedor ve el contenido de la factura. Con Tesseract en local no sale nada de tu equipo.
- Esto no sustituye a tu gestor ni presenta impuestos. Es entrada de datos: alguien tiene que revisar los importes antes de que vayan a la contabilidad.
- Coste real si tiras de API: 500 facturas al mes son entre 5 y 15 euros. Con Tesseract, cero euros y mas correcciones a mano.
