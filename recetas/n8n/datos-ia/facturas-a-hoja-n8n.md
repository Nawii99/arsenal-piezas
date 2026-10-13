# Facturas escaneadas a hoja de cálculo…

**Tipo:** Receta de automatización · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Facturas PDF se convierten solas en datos en tu hoja de cálculo.

## Qué es y qué hace

Es una receta que toma facturas en PDF que llegan por correo y las apunta solas en una hoja de cálculo. Entran los correos con adjuntos de una cuenta dedicada y un modelo que lea documentos, local o por API; salen filas con fecha, proveedor, base, IVA y total. Las facturas llevan NIF y direcciones, así que no se envían fuera sin permiso por escrito. Se monta con n8n.

## Cómo usarla

1. Pide permiso por escrito al cliente
2. Crea la cuenta de correo dedicada y los nodos en orden
3. Prueba con facturas reales y corrige los campos. Que lo revise un profesional

## Cuándo usarla

Para un cliente pequeño o una gestoría que recibe facturas en PDF por email y las está pasando a mano cada mes.

## Cómo ganar dinero con ella

Montaje de 400-700 euros y mantenimiento de 40-60 euros al mes. Argumento de venta: horas de pasar datos a mano, no tecnología.

- Pasar a hoja las facturas de un cliente pequeño que hoy las teclea cada mes.
- Mantenimiento mensual del flujo con revisión de fallos y de nuevos proveedores.
- Entrega de la hoja mensual de gastos lista para la gestoría del cliente.

**Precio orientativo:** 400–700 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Facturas que llegan por correo, apuntadas solas en una hoja

## Cuentas que hacen falta y su limite gratuito

- n8n: gratis si lo instalas tu (Docker en un PC o en un servidor de 5 euros al mes). La version en la nube tiene prueba y luego cuota.
- Gmail o cualquier correo con IMAP: gratis. Mejor una cuenta dedicada tipo facturas@ del cliente.
- Google Sheets: gratis con cuenta de Google.
- Un modelo que lea documentos: o local con Ollama (gratis, sin sacar nada fuera) o una API de pago por uso. Si el cliente no quiere que sus facturas salgan de su equipo, va local y punto.

## Antes de montar nada

Pide permiso por escrito al cliente para tratar sus facturas y dile de forma clara si el texto se envia a un servicio externo o se queda en su maquina. Las facturas llevan nombres, direcciones y NIF. No se mandan fuera sin ese permiso.

## Los nodos, en orden

1. Disparador: Gmail Trigger (o IMAP Email). Configurado cada 15 minutos, filtrando por la etiqueta `facturas` y solo correos con adjunto.
2. IF: comprueba que el adjunto existe y es PDF o imagen. Si no, sale por la rama falsa y va directo al paso 9.
3. Extract From File: intenta sacar el texto del PDF. Muchas facturas ya traen texto y asi te ahorras el OCR.
4. IF: si el texto tiene menos de 50 caracteres, es un escaneo. Va a la rama de OCR.
5. Execute Command (solo rama OCR): guarda el adjunto y pasa `tesseract archivo.png salida -l spa`. Si n8n esta en Docker, instala tesseract-ocr y tesseract-ocr-spa en la imagen.
6. Basic LLM Chain (o HTTP Request a Ollama): manda el texto y pide SOLO un JSON con: emisor, nif_emisor, numero_factura, fecha, base_imponible, tipo_iva, cuota_iva, total, moneda. Indica que si un campo no aparece ponga null y que no invente nada.
7. Code: valida lo que ha devuelto. Comprueba que base + cuota da el total con un margen de un centimo, que la fecha tiene formato correcto y que el NIF tiene la forma esperada. Anade un campo `revisar` con true o false.
8. Google Sheets (Append): anade la fila a la hoja `Facturas`, con una columna final `estado` que ponga `ok` o `revisar`, y otra con el enlace o el nombre del archivo original.
9. Gmail (Send): si `revisar` es true o el adjunto no se pudo leer, manda un aviso a la persona responsable con el asunto del correo original. Las dudosas las mira una persona, no se apuntan y ya.

## Como probarla sin liarla

1. Crea una hoja de pruebas aparte y una etiqueta `facturas-prueba` en el correo.
2. Usa 10 facturas de verdad ya conocidas: 3 con texto, 3 escaneadas, 2 con varios IVA y 2 raras o en otro idioma.
3. Ejecuta el flujo a mano con el boton de prueba, nodo a nodo, mirando la salida de cada uno antes de conectar el siguiente.
4. Compara las 10 filas con los datos reales. Si falla el total en mas de una, el fallo esta en el paso 6: ajusta el prompt, no la hoja.
5. Deja el disparador activo solo cuando las 10 salgan bien dos veces seguidas.

## Limites que hay que decirle al cliente

- Esto no es contabilidad. La hoja es un borrador para ahorrar teclear; el asiento lo hace su gestoria.
- Las facturas marcadas como `revisar` no se dan por buenas nunca de forma automatica.
- Si cambia el formato de una factura habitual, el flujo puede empezar a fallar en silencio. Por eso se revisa la hoja una vez al mes.
