# Control de stock, caducidades y mantenimiento del centr…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Vigila tu inventario de material y suplementos, avisa de lo que caduca en 30 días o baja del mínimo, y te recuerda las revisiones de máquinas y aparatos.

## Qué es y qué hace

Cada lunes revisa en Google Sheets el inventario y el calendario de revisiones de equipos, y envía por Gmail una lista de lo que está bajo mínimo, lo que caduca en 30 días y las revisiones del mes con la lista de pedido redactada. Entrada: hojas Inventario, Equipos y Movimientos; salida: email de pedido. Se monta en n8n.

## Cómo usarla

1. Prepara las pestañas Inventario, Equipos y Movimientos
2. Programa el cron de los lunes
3. Que lo revise un profesional

## Cuándo usarla

Cuando te quedas sin guantes, aceite o vendas en mitad de la jornada, tiras producto caducado, o se te pasa la revisión del aparato de presoterapia.

## Cómo ganar dinero con ella

Un centro tira fácil 60-150 € al mes en producto caducado y pierde ventas por roturas de stock. Y una máquina sin revisar es una avería de 400 € o un problema de seguro.

- Control de stock y caducidades para un centro de estética con material fungible.
- Calendario de revisiones de aparatos para una clínica de fisioterapia.
- Pedidos automáticos a proveedor para un herbolario o una tienda de suplementos.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada lunes revisa tu hoja de inventario: te lista lo que está por debajo del stock mínimo, lo que caduca en los próximos 30 días y las revisiones de equipos que tocan este mes. Te lo manda todo junto en un email con la lista de pedido ya escrita para reenviar al proveedor.
Para centros de estética, clínicas de fisioterapia, gimnasios, spas, herbolarios y cualquier negocio de bienestar con material fungible y aparatos.

## Lo que necesitas antes
- Google Sheet `Inventario` con: producto, categoria, proveedor, email_proveedor, stock_actual, stock_minimo, lote, caduca (2026-11-30), precio_ud.
- Pestaña `Equipos`: equipo, marca, ultima_revision, meses_periodicidad, empresa_mantenimiento, telefono.
- Pestaña `Movimientos`: fecha, producto, cantidad, tipo (entrada/salida).
- Gmail y, opcionalmente, un bot de Telegram para dar salidas de stock desde el móvil.
- n8n.

## Los nodos, en orden
1. **Schedule Trigger** – Cron `0 8 * * 1`, Timezone Europe/Madrid.
2. **Google Sheets** – Read Rows de `Inventario`, Return All.
3. **Google Sheets** – Read Rows de `Equipos`, Return All.
4. **Code** – separa en tres listas: bajo mínimo, caduca pronto, revisión pendiente. Código abajo.
5. **IF** – `={{ $json.hay_algo }}` is true. Si no hay nada, mejor no mandar email; los emails vacíos se dejan de leer.
6. **Gmail** – Send a ti con el informe HTML de las tres listas.
7. **Split Out** – Field: `pedido_por_proveedor`. Un item por proveedor con sus productos.
8. **Gmail** – Send a cada proveedor con el borrador del pedido. Importante: ponlo en modo borrador la primera semana usando Operation: Create Draft en vez de Send, hasta que confíes en los números.
9. **IF** – si hay revisiones pendientes, **Google Calendar** Create Event con el nombre del equipo y el teléfono de la empresa de mantenimiento en la descripción, para la semana que viene.
10. **Telegram Trigger** (workflow dos, «Descontar stock») – recibe mensajes tipo `-3 guantes`.
11. **Code** – parsea cantidad y producto del mensaje.
12. **Google Sheets** – Update en `Inventario` restando del `stock_actual`, y Append en `Movimientos`.
13. **Telegram** – responde «Quedan X guantes» para que lo veas al momento.

## El código del nodo Code (paso 4)
```
const inv = $('Google Sheets').all().map(i => i.json);
const eq = $('Google Sheets1').all().map(i => i.json);
const hoy = new Date();
const enDias = f => Math.round((new Date(f) - hoy) / 86400000);
const bajos = inv.filter(p => Number(p.stock_actual) <= Number(p.stock_minimo));
const caducan = inv.filter(p => p.caduca && enDias(p.caduca) <= 30 && enDias(p.caduca) > -365).map(p => ({ ...p, dias: enDias(p.caduca) }));
const revisiones = eq.filter(e => { const u = new Date(e.ultima_revision); u.setMonth(u.getMonth() + Number(e.meses_periodicidad || 12)); return u <= new Date(hoy.getTime() + 30 * 86400000); });
const porProv = {};
bajos.forEach(p => { const k = p.email_proveedor || 'sin_proveedor'; (porProv[k] = porProv[k] || { email: k, proveedor: p.proveedor, lineas: [] }).lineas.push(`${p.producto}: pedir ${Math.max(Number(p.stock_minimo) * 2 - Number(p.stock_actual), 1)} uds`); });
let html = '<h3>Bajo mínimo</h3><ul>' + bajos.map(p => `<li>${p.producto}: quedan ${p.stock_actual} (mínimo ${p.stock_minimo})</li>`).join('') + '</ul>';
html += '<h3>Caducan pronto</h3><ul>' + caducan.map(p => `<li>${p.producto} lote ${p.lote}: ${p.dias} días</li>`).join('') + '</ul>';
html += '<h3>Revisiones</h3><ul>' + revisiones.map(e => `<li>${e.equipo} (${e.marca}) — ${e.empresa_mantenimiento} ${e.telefono}</li>`).join('') + '</ul>';
return [{ json: { hay_algo: bajos.length + caducan.length + revisiones.length > 0, html, pedido_por_proveedor: Object.values(porProv) } }];
```

## Cómo probarla
- Pon un producto con stock 2 y mínimo 5, otro que caduque dentro de 15 días y un equipo con última revisión de hace 13 meses y periodicidad 12.
- Ejecuta: los tres deben salir en el informe.
- Comprueba que el borrador al proveedor tiene la línea correcta y una cantidad razonable.
- Manda `-2 guantes` a tu bot y mira que el stock baja y se apunta el movimiento.

## Qué puede salir mal
- **Fechas en texto**: si la columna `caduca` está como texto en formato español, `new Date()` te dará valores raros. Fuerza el formato ISO en Sheets (Formato > Número > Fecha personalizada, año-mes-día).
- **Mandar pedidos de verdad por error**: por eso el paso 8 empieza como borrador. Cámbialo a Send solo cuando lleves un mes viendo que los números cuadran.
- **Productos con varios lotes**: si tienes el mismo producto en dos lotes, usa una fila por lote y agrupa por nombre en el informe. Si no, el stock mínimo se comparará mal.
- **Descuentos de stock que nadie apunta**: el flujo es tan bueno como los datos. Deja el bot de Telegram fijado en el móvil del mostrador y pon la norma de apuntar al abrir producto, no al terminarlo.
- **Equipos con normativa**: si tienes aparatos con obligación legal de revisión (por ejemplo, presoterapia o láser), guarda también el certificado escaneado en Drive y enlázalo en la hoja; el aviso solo te recuerda, no sustituye al papel.

## Cuánto cuesta
- 0 € con Sheets, Gmail, Telegram y n8n auto-alojado.
- Si prefieres leer códigos de barras, una app gratuita de escáner que escriba en la hoja de Google te vale; no hace falta software de almacén de 40 €/mes.
