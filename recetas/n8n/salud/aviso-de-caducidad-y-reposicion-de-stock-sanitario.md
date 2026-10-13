# Aviso de caducidad y reposición de stock sanitario…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Vigila tu hoja de material y suplementos, y avisa cuando algo va a caducar en 60 días o baja del mínimo, con la lista de pedido ya montada.

## Qué es y qué hace

Lee cada lunes una hoja de Google Sheets con lote, caducidad, unidades y mínimo de cada producto. Filtra lo que caduca en 60 días o está bajo mínimo y envía por Telegram dos listas: consumir ya y pedir. Se monta en n8n con un nodo Code de clasificación y Gmail para el pedido al proveedor.

## Cómo usarla

1. Prepara la hoja Inventario con caducidades y mínimos
2. Conecta Telegram y Gmail en n8n
3. Programa el cron de los lunes a las 8:00
4. Que lo revise un profesional

## Cuándo usarla

Cuando manejas material fungible, cremas, suplementos, vendajes o test que caducan, y te has encontrado más de una vez tirando producto o quedándote sin lo básico un lunes por la mañana.

## Cómo ganar dinero con ella

Un centro pequeño tira entre 300 y 800 euros al año en producto caducado. Esto lo reduce casi a cero y te quita el inventario manual del mes.

- Montaje de control de inventario para clínicas o herbolarios con avisos automáticos de caducidad.
- Gestión mensual de pedidos y stock para centros de estética con informe de mermas.
- Plantilla de inventario y alertas para gimnasios con tienda de suplementos.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada lunes revisa el inventario, separa lo que caduca pronto de lo que está bajo mínimos y te manda dos listas: «úsalo ya» y «pide esto».
Para clínicas, centros de estética, herbolarios, gimnasios con tienda o cualquier consulta con material fungible.

## Lo que necesitas antes
- n8n instalado.
- Una hoja «Inventario» en Google Sheets con columnas: Producto, Lote, Caducidad (AAAA-MM-DD), Unidades, Minimo, Proveedor, Email proveedor, Precio unidad.
- Gmail conectado en n8n.
- Telegram: habla con @BotFather, escribe /newbot, copia el token. Luego escribe algo a tu bot y saca tu chat id abriendo https://api.telegram.org/bot TU_TOKEN /getUpdates. En n8n crea la credencial «Telegram API».

## Los nodos, en orden
1. **Schedule Trigger**: Cron 0 8 * * 1 (lunes a las 8:00), zona Europe/Madrid.
2. **Google Sheets** (Get Rows) sobre «Inventario».
3. **Code** (nombre: «Clasificar»): calcula días hasta caducidad y compara unidades con el mínimo. Devuelve un único item con dos listas y el total del pedido. Código abajo.
4. **IF**: si no hay nada en ninguna lista, manda un Telegram corto de «todo en orden» y termina.
5. **Telegram** (Send Message): mensaje con las dos listas en texto, para verlo desde el móvil nada más abrir el centro.
6. **IF** (segundo): si hay productos bajo mínimo con proveedor asignado, sigue.
7. **Item Lists** (Split Out) sobre la lista de pedido, para tener un item por producto.
8. **Code** (nombre: «Agrupar por proveedor»): junta los productos de cada proveedor en un solo pedido.
9. **Gmail** (Send Message): un correo por proveedor con la lista de referencias y cantidades. Ponlo en borrador la primera semana usando «Create Draft» hasta que te fíes.
10. **Google Sheets** (Append Row) en pestaña «Pedidos»: fecha, proveedor, productos e importe estimado.

## El código del nodo Code
```javascript
const hoy = new Date();
const caducan = [];
const reponer = [];
for (const item of $input.all()) {
  const f = item.json;
  const uds = Number(f.Unidades || 0);
  const min = Number(f.Minimo || 0);
  if (f.Caducidad) {
    const dias = Math.floor((new Date(f.Caducidad) - hoy) / 86400000);
    if (dias <= 60) caducan.push(f.Producto + ' lote ' + f.Lote + ': ' + dias + ' dias (' + uds + ' uds)');
  }
  if (uds <= min) {
    reponer.push({ producto: f.Producto, faltan: Math.max(min * 2 - uds, 1), proveedor: f.Proveedor, email: f['Email proveedor'], precio: Number(f['Precio unidad'] || 0) });
  }
}
const total = reponer.reduce((s, r) => s + r.faltan * r.precio, 0);
return [{ json: { caducan, reponer, total: total.toFixed(2), hayAlgo: caducan.length + reponer.length > 0 } }];
```

## Cómo probarla
- Pon un producto con caducidad dentro de 30 días y otro con Unidades 1 y Minimo 5. Ejecuta y comprueba que aparecen en la lista correcta.
- Deja el nodo de Gmail como «Create Draft» las dos primeras semanas y revisa los borradores antes de enviarlos.

## Qué puede salir mal
- **Fechas mal escritas**: si la columna Caducidad no está en formato AAAA-MM-DD, el cálculo da NaN. Formatea la columna entera en Sheets como texto plano con ese formato.
- **Pedidos duplicados**: si nadie actualiza las unidades tras recibir el pedido, el lunes siguiente vuelve a pedir. Añade una columna «Pedido pendiente» con SI/NO y filtra por ella.
- **Lotes distintos del mismo producto**: usa una fila por lote, no una por producto, o perderás la trazabilidad de caducidades.
- **Proveedor sin email**: el nodo Gmail fallará. Mete un IF que descarte las filas sin correo y las mande solo por Telegram.

## Cuánto cuesta
- Google Sheets, Telegram y Gmail: gratis.
- n8n auto-alojado: 0 euros; cloud desde 20 euros al mes.
