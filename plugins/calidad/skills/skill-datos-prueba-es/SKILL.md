---
name: skill-datos-prueba-es
description: Genera archivos CSV o JSON de datos inventados (clientes, pedidos, facturas, leads) con formato español y sin datos que parezcan reales. Se activa cuando el usuario pide datos falsos, datos de prueba, datos de ejemplo, rellenar una tabla vacía o probar algo sin usar clientes reales.
---

# Datos de prueba con contexto español

## Qué hace
Crea un archivo de datos inventados para que puedas probar una hoja de cálculo, un flujo de n8n, una plantilla de email o un CRM sin exponer a clientes reales. El archivo se guarda en la carpeta que indique el usuario con un nombre que empiece por `PRUEBA_` para que nadie lo confunda con datos reales.

## Qué preguntar antes de empezar
Si el usuario no lo ha dicho, pregunta solo esto y sigue:
1. Qué tipo de registros quiere: clientes, pedidos, facturas, leads, productos u otro.
2. Cuántas filas. Si no lo sabe, propone 30. Más de 500 solo si lo pide explícitamente.
3. Formato: CSV (para Excel, Google Sheets) o JSON (para n8n, APIs). Si duda, CSV con punto y coma.
4. Si tiene ya una tabla o un archivo con las columnas que necesita. Si lo tiene, respeta sus nombres de columna exactamente.
No preguntes nada más. El resto lo decides tú con las reglas de abajo.

## Paso a paso
1. Define las columnas. Si el usuario no las da, usa estas por tipo:
   - clientes: id, nombre, apellidos, email, telefono, ciudad, provincia, codigo_postal, empresa, fecha_alta, estado
   - pedidos: id_pedido, id_cliente, fecha, producto, unidades, precio_unitario_eur, base_imponible_eur, iva_pct, total_eur, estado_pedido
   - facturas: numero_factura, fecha_emision, id_cliente, nif_cliente, base_imponible_eur, iva_pct, cuota_iva_eur, total_eur, estado_cobro
   - leads: id, nombre, email, telefono, origen (web, linkedin, referido, evento), fecha_contacto, interes (alto, medio, bajo), comercial_asignado
2. Genera los datos siguiendo las reglas de seguridad de más abajo. Sin excepciones.
3. Mete a propósito entre un 5% y un 10% de filas con errores típicos (email sin arroba, teléfono vacío, fecha imposible, importe negativo, duplicado exacto). Sirven para comprobar que el sistema del usuario los detecta.
4. Guarda el archivo como `PRUEBA_<tipo>_<fecha AAAA-MM-DD>.csv` o `.json`. En CSV: separador punto y coma, codificación UTF-8, coma decimal, fechas DD/MM/AAAA. En JSON: array de objetos, punto decimal, fechas AAAA-MM-DD.
5. Genera un segundo archivo `PRUEBA_<tipo>_<fecha>_LEEME.txt` con: cuántas filas hay, qué columnas, qué filas tienen errores intencionados y cuáles son esos errores.
6. Abre las 5 primeras filas y compruébalas a ojo antes de dar por terminado: que las columnas cuadren y que ningún dato parezca de una persona real.

## Reglas de seguridad de los datos (obligatorias)
- Emails solo con dominio example.com, example.es o example.org. Están reservados para pruebas y nunca llegan a nadie.
- Teléfonos con formato 600 000 0XX. Cambia solo las dos últimas cifras. Si necesitas más de 100 distintos, usa también 600 000 1XX.
- NIF/CIF: si el tipo de registro lo necesita (facturas), usa exclusivamente valores con ceros por delante tipo 00000001R o B00000001. No calcules letras de control reales para números aleatorios: podrías generar el NIF de una persona que existe.
- Nunca números de cuenta bancaria, IBAN ni tarjetas, ni falsos. Si el usuario lo pide, pon la columna con el texto literal `NO-GENERADO` y explícale por qué en el LEEME.
- Empresas inventadas con las palabras Demo, Pruebas o Ficticia en el nombre.
- Nombres y apellidos habituales en España, con algo de variedad de origen. Nada de famosos, políticos ni personajes.
- Ciudades, provincias y códigos postales reales y coherentes entre sí (el CP de Sevilla empieza por 41, el de Valencia por 46).
- IVA: usa 21% por defecto; 10% o 4% solo si el producto lo justifica (alimentación, libros). Los totales tienen que cuadrar: base + cuota = total.

## Qué devolver
Al terminar, un mensaje corto con:
- Ruta absoluta de los dos archivos creados.
- Número de filas y columnas.
- La lista de filas con errores intencionados.
- Una frase recordando que el archivo es de prueba y que hay que borrarlo antes de pasar el sistema a producción.

## Qué NO hacer
- No uses datos del usuario ni de su empresa aunque estén en la misma carpeta. Si ves un archivo que parece tener clientes reales, no lo abras para "inspirarte".
- No generes más de 500 filas sin que el usuario lo pida: los archivos grandes se cargan mal en Sheets gratis y no aportan nada en una prueba.
- No mezcles formatos: si es CSV con punto y coma, todas las filas igual.
- No pongas tildes ni eñes en los nombres de columna. En los valores sí.
- No inventes precios de productos reales de marcas reales. Productos genéricos: "Silla de oficina modelo A", "Consultoría mensual".
- No digas que los datos son "realistas" en el LEEME. Di que son inventados y para qué sirven.
