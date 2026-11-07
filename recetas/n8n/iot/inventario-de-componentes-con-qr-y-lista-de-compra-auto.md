# Inventario de componentes con QR y lista de compra auto…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Pegas un QR en cada cajón de componentes; lo escaneas con el móvil al coger o reponer piezas y el stock se actualiza solo, con aviso cuando algo baja del mínimo.

## Qué es y qué hace

Cada cajón lleva un QR que abre una página con botones -1, -5 y +10. Al pulsarlo, n8n resta o suma stock en una hoja de Google Sheets y responde con el stock nuevo. Los lunes envía por correo lo que está por debajo del mínimo, con el enlace al proveedor. Entran escaneos y salen stock actualizado y listas de reposición, para talleres de electrónica y almacenes de piezas pequeñas.

## Cómo usarla

1. Crea la hoja con sku, stock, mínimo y proveedor
2. Genera un QR por referencia apuntando al webhook
3. Configura los botones de suma y resta
4. Activa el correo semanal de reposición

## Cuándo usarla

Cuando tengas taller de electrónica, reparaciones, instalaciones o cualquier almacén de piezas pequeñas y siempre te falte justo el relé que necesitas hoy.

## Cómo ganar dinero con ella

Un viaje urgente al proveedor o un envío exprés cuestan 20-60 € y medio día. Evitar dos al mes son unos 800 € al año en tiempo y portes.

- Implantación de inventario con QR para talleres o instaladores, con etiquetas y formación de uso.
- Gestión mensual del stock y de los pedidos de reposición para servicios técnicos, por cuota.
- Plantilla de inventario QR para vender a gremios o pequeñas empresas de mantenimiento.

**Precio orientativo:** 150–400 € por taller. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada referencia tiene un QR con una URL que apunta a un webhook de n8n. Al escanearlo con la cámara del móvil se abre una página mínima con botones «-1», «-5», «+10»; al pulsar, n8n resta o suma stock en la hoja y responde con el stock nuevo. Los lunes, un correo con todo lo que está por debajo del mínimo y el enlace directo al proveedor.
Para talleres de electrónica, instaladores, servicios técnicos y makers profesionales.

## Lo que necesitas antes
- Hoja de Google Sheets «Inventario» con columnas: sku, nombre, stock, minimo, ubicacion, enlace_proveedor.
- n8n accesible desde el móvil. Si el taller y n8n están en la misma wifi, con la IP local basta; si no, Cloudflare Tunnel gratuito.
- Una impresora de etiquetas cualquiera, o folios y celo.
- Credencial de Gmail en n8n.

## Los nodos, en orden (workflow 1: la página de cada pieza)
1. **Webhook**: GET, path `pieza`, Respond: Using 'Respond to Webhook' Node. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2. **Google Sheets** (Read, filtro `sku` igual a `{{ $json.query.sku }}`).
3. **IF**: `{{ $json.query.delta }}` is not empty.
4. Rama true → **Code** «Aplicar cambio»: calcula el nuevo stock → **Google Sheets** (Update).
5. Ambas ramas → **Code** «HTML»: genera la página con los botones.
6. **Respond to Webhook**: Respond With: Text, Response Code 200, header `Content-Type: text/html`.

## El trozo de código (nodo Code, «HTML»)
```js
const p = $json;
const url = 'https://tu-n8n/webhook/pieza?sku=' + encodeURIComponent(p.sku);
const btn = (d, txt) => `<a href="${url}&delta=${d}" style="display:inline-block;padding:18px 26px;margin:6px;background:#222;color:#fff;border-radius:10px;text-decoration:none;font-size:20px">${txt}</a>`;
const aviso = Number(p.stock) <= Number(p.minimo) ? '<p style="color:#c00;font-weight:bold">Por debajo del mínimo</p>' : '';
const html = `<html><head><meta name="viewport" content="width=device-width,initial-scale=1"></head><body style="font-family:sans-serif;text-align:center;padding:24px"><h2>${p.nombre}</h2><p>Ubicación: ${p.ubicacion}</p><h1>${p.stock}</h1>${aviso}<div>${btn(-1,'-1')}${btn(-5,'-5')}${btn(1,'+1')}${btn(10,'+10')}</div></body></html>`;
return [{ json: { html } }];
```
En el nodo Respond to Webhook pon como Response Body la expresión `={{ $json.html }}`.

## Cómo generar las etiquetas QR
1. **Schedule Trigger** manual o ejecución a mano.
2. **Google Sheets** (Read, Return All).
3. **Code**: para cada fila, monta `https://quickchart.io/qr?size=250&text=` + `encodeURIComponent('https://tu-n8n/webhook/pieza?sku=' + fila.sku)`.
4. **HTML** (nodo HTML, Operation: Generate HTML Template): una rejilla con la imagen del QR y el nombre debajo. Imprímela y recorta.

## Los nodos (workflow 2: lista de compra semanal)
1. **Schedule Trigger**: Cron `0 8 * * 1`.
2. **Google Sheets** (Read, Return All).
3. **Code**: filtra `stock <= minimo` y compone la lista con el enlace del proveedor.
4. **IF**: hay alguna → **Gmail** (Send).

## Cómo probarla
- Escanea un QR con el móvil: debe abrirse la página con el stock. Pulsa «-1» y comprueba que baja en la hoja y en la pantalla.
- Pon un artículo por debajo del mínimo y ejecuta el workflow 2 a mano: debe salir en el correo.
- Prueba con el móvil en datos móviles, no solo en la wifi del taller, para verificar el acceso externo.

## Qué puede salir mal
- **Dobles pulsaciones**: si el móvil recarga la página, se resta dos veces. Solución: tras aplicar el cambio, responde con un HTML sin `delta` en la URL (la página que devuelves ya apunta a la URL limpia), como hace el código de arriba.
- **Cualquiera con la URL puede tocar el stock**: añade `&t=TOKEN` a las URLs de los QR y un nodo IF que rechace lo que no coincida.
- **Stock negativo**: en «Aplicar cambio» usa `Math.max(0, stock + delta)`.
- **Sin cobertura en el almacén**: si el sótano no tiene wifi, monta un punto de acceso o apunta en papel y escanea al salir.

## Cuánto cuesta
0 € de software: Sheets, QuickChart QR y n8n autoalojado son gratis. Etiquetas y tinta, unos céntimos por referencia.
