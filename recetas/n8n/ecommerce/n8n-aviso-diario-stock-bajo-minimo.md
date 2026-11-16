# n8n: aviso diario de productos bajo mínimo desde tu hoja

**Tipo:** Receta de automatización · **Área:** Tienda por internet · **Licencia:** CC BY 4.0

Receta de n8n que cada mañana lee tu hoja de stock y te manda un correo con los productos por debajo del mínimo o agotados. Si no hay ninguno, no avisa.

## Qué es y qué hace

Flujo de n8n con cuatro nodos más el disparador: lee tu hoja de stock en Google Sheets, filtra los estados REPONER y AGOTADO, arma una lista y la envía por correo. Entra una hoja con las columnas SKU, Producto, Disponible, Punto de pedido, Estado y A pedir; sale un aviso diario solo cuando hay algo que reponer. No pide nada a proveedores.

## Cómo usarla

1. Prepara la hoja con las columnas indicadas
2. Crea el flujo con los cinco nodos de la receta
3. Prueba con una fila REPONER y con todo en OK
4. Activa el flujo

## Cuándo usarla

Cuando ya tienes una hoja de stock con estados y quieres enterarte sin tener que abrirla cada día.

## Cómo ganar dinero con ella

Instala y mantiene este aviso en tiendas pequeñas que llevan el stock en una hoja, cobrando por el montaje y por revisarlo cuando cambien sus columnas.


## La receta, paso a paso

QUÉ HACE
Cada mañana, el flujo lee tu hoja de stock, se queda solo con los productos en estado REPONER o AGOTADO y te manda un único correo con la lista. Si ese día no hay ninguno, no manda nada. No pide nada a los proveedores y no cambia la hoja.

QUÉ NECESITAS
- n8n (en la nube o instalado por ti). Mira en su web el plan y las condiciones.
- Una hoja de Google Sheets con una pestaña llamada Stock, con las cabeceras en la fila 1 y estas columnas: SKU, Producto, Disponible, Punto de pedido, Estado, A pedir. Si no la tienes, la skill «Hoja de stock para tu tienda» del Arsenal monta justo esa estructura. La columna Estado debe valer AGOTADO, REPONER, NO ROTA u OK.
- Una conexión de n8n con tu cuenta de Google (credencial de Google Sheets y de Gmail). Se crea desde el propio n8n, no se escribe nunca dentro de los campos del flujo. Sigue la guía de n8n para conectar Google.
- Un correo al que quieras recibir el aviso (el tuyo).

PASOS (nodo a nodo)
1. Schedule Trigger.
- Trigger Interval: Days. Days Between Triggers: 1. Trigger at Hour: 8. Trigger at Minute: 0.
- En los ajustes del flujo (Settings), pon la zona horaria Europe/Madrid para que las 8 sean las 8 de aquí.
2. Google Sheets. Resource: Sheet Within Document. Operation: Get Row(s).
- Credential: tu cuenta de Google.
- Document: elige tu hoja en la lista (From list). Sheet: Stock.
- Deja los filtros vacíos para leer todas las filas. Si tu catálogo es muy grande, mira en la ayuda de n8n cómo limitar las columnas.
3. Filter.
- Conditions: primera condición, valor {{ $json.Estado }}, tipo String, operador is equal to, valor REPONER. Segunda condición, el mismo valor, is equal to, AGOTADO.
- Combine: OR (cualquiera de las dos). Si el nodo muestra «Ignore Case», actívalo.
- Lo que no cumple se descarta. Si no queda ninguna fila, el flujo se detiene aquí y no se envía nada.
4. Code. Mode: Run Once for All Items. Language: JavaScript. Pega esto:
const filas = $input.all();
const lineas = filas.map(f => {
  const d = f.json;
  return `- ${d['Producto']} (${d['SKU']}): ${d['Estado']}, disponible ${d['Disponible']}, punto de pedido ${d['Punto de pedido']}, sugerido pedir ${d['A pedir']}`;
});
return [{ json: { total: filas.length, mensaje: lineas.join('\n') } }];
Qué hace, línea a línea: la primera recoge todas las filas que pasaron el filtro; la segunda recorre cada fila y construye una línea de texto con los nombres de columna exactos de tu hoja; la última devuelve un solo elemento con el número de productos y las líneas unidas con saltos de línea. Si renombras una columna en la hoja, cambia aquí el mismo nombre.
5. Gmail. Resource: Message. Operation: Send.
- To: tu correo. Subject: {{ 'Stock: ' + $json.total + ' producto(s) por reponer' }}. Email Type: Text.
- Message: {{ 'Estos productos han llegado a su punto de pedido o están agotados:\n\n' + $json.mensaje + '\n\nRevisa la hoja antes de pedir: la cantidad sugerida es un cálculo, no una orden.' }}
- Si prefieres otro canal, sustituye este nodo por Telegram (Send Message) o Send Email y pon el mismo texto; mira en la guía de n8n cómo se crea esa conexión.

CÓMO PROBARLO
1. Pon a mano una fila de prueba en la hoja con Estado REPONER (o fuerza el estado cambiando el stock de un producto).
2. En n8n pulsa Execute Workflow y mira la salida de cada nodo: Google Sheets debe traer filas, Filter debe dejar pasar la de prueba, Code debe mostrar total y mensaje.
3. Comprueba que llega el correo y que las cifras coinciden con la hoja.
4. Pon todos los estados en OK y ejecuta de nuevo: no debe llegar nada.
5. Deshaz la fila de prueba, activa el flujo (interruptor Active) y comprueba mañana a las 8.

ERRORES TÍPICOS
- No llega nada nunca: el Filter no encuentra coincidencias porque la columna se llama distinto o Estado lleva espacios. Mira la salida del nodo Google Sheets y copia el nombre exacto.
- Aparece «undefined» en el correo: has cambiado el nombre de una columna y el Code sigue buscando el antiguo.
- Llegan los avisos cada día de lo mismo: es lo esperado mientras no repongas o cambies el estado. Si te cansa, avísate solo los lunes cambiando el Schedule Trigger.
- El flujo no corre: comprueba que está activo y que n8n está encendido a esa hora (si lo tienes en tu ordenador, no corre apagado).
- Estado desactualizado: la hoja solo es tan fiable como los datos de ventas que pegues. Si no actualizas Ventas, el aviso no sabe nada nuevo.
- Si el flujo falla, no te avisa por sí solo: mira de vez en cuando la pestaña Executions o configura un flujo de error siguiendo la guía de n8n.

QUÉ NO HACER
- No metas claves ni contraseñas dentro de los campos: usa las credenciales de n8n.
- No automatices el pedido al proveedor: la decisión de comprar la toma una persona.
- No compartas el correo de aviso con alguien que no deba ver tu stock y tus costes.
