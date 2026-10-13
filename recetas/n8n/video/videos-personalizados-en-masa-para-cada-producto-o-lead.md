# Vídeos personalizados en masa para cada producto o lead…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

A partir de una hoja con nombres, textos e imágenes, renderiza automáticamente un vídeo distinto para cada fila usando una plantilla y te devuelve el enlace de cada uno.

## Qué es y qué hace

Lee una hoja donde cada fila es un vídeo (producto, titular, precio, imagen), llama a una API de render que aplica esos datos sobre una plantilla diseñada una vez, espera el resultado y guarda el MP4 en Drive con su enlace en la hoja. Entran la hoja y la plantilla; sale un vídeo por fila. Para ecommerce, inmobiliarias y agencias que necesitan decenas de piezas casi iguales.

## Cómo usarla

1. Diseña la plantilla en Creatomate y anota sus IDs
2. Sube las imágenes a un alojamiento público
3. Rellena una fila de prueba
4. Lanza el lote y revisa dos vídeos

## Cuándo usarla

Cuando necesitas 50 vídeos casi iguales: un reel por producto del catálogo, un vídeo de bienvenida con el nombre de cada cliente o fichas de inmuebles.

## Cómo ganar dinero con ella

Un editor cobra 20-40 € por vídeo simple. Cincuenta vídeos pasan de 1.500 € a unos 25 € de créditos de render.

- Vídeos de producto automáticos para tiendas online con catálogo de cientos de referencias…
- Fichas de inmuebles en vídeo para inmobiliarias pequeñas con precio y foto…
- Vídeos de bienvenida personalizados para clientes de un negocio o programa de fidelidad…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee una hoja de cálculo donde cada fila es un vídeo (titular, precio, foto, logo), llama a una API de render con esos datos sobre una plantilla que has diseñado una sola vez, espera a que termine y guarda el MP4 en Drive con el enlace de vuelta en la hoja. Para ecommerce, inmobiliarias y agencias.

## Lo que necesitas antes
- Cuenta en Creatomate (creatomate.com, plan gratis de prueba) o Shotstack. En Creatomate: crea una plantilla en su editor visual, marca los elementos como «dinámicos» y anota el `template_id` y los nombres de los elementos.
- API key de Creatomate: Project Settings → API Key.
- Hoja «Vídeos a generar» con columnas: producto, titular, precio, url_imagen, estado, url_video.
- Las imágenes deben estar en URLs públicas (Drive con enlace público no vale bien; usa Cloudinary gratis o tu propio hosting).

## Los nodos, en orden
1. **Schedule Trigger** — cada 30 minutos. O **Webhook** si prefieres lanzarlo a mano.
2. **Google Sheets** (Get Many) — Filtro: estado = «pendiente».
3. **Split In Batches** — Batch Size 5 (los renders van en cola, no satures).
4. **HTTP Request** — POST https://api.creatomate.com/v1/renders, header `Authorization: Bearer TU_API_KEY`, body JSON con template_id y `modifications`.
5. **Wait** — 45 segundos («After Time Interval»).
6. **HTTP Request** — GET https://api.creatomate.com/v1/renders/{{ $json.id }} para consultar el estado.
7. **IF** — si `status` no es «succeeded», vuelve al nodo 5 (conecta la salida false otra vez al Wait: eso es el bucle de reintento).
8. **HTTP Request** — GET a la `url` del render, Response Format «File», para bajarte el MP4.
9. **Google Drive** (Upload) — carpeta «Vídeos generados».
10. **Google Sheets** (Update) — pon estado = «listo» y url_video con el enlace de Drive.
11. **Gmail** — al terminar el lote, correo con la lista de vídeos generados.

## El body del nodo 4
```json
{
  "template_id": "TU_TEMPLATE_ID",
  "modifications": {
    "Titular": "{{ $json.titular }}",
    "Precio": "{{ $json.precio }} €",
    "Imagen.source": "{{ $json.url_imagen }}"
  }
}
```

## Cómo probarla
Deja solo dos filas en «pendiente» y lanza. Mira el vídeo resultante entero: los fallos típicos (texto que se sale de la caja, imagen deformada) solo se ven mirándolo. Ajusta en la plantilla el ajuste automático de tamaño de fuente antes de lanzar las 50.

## Qué puede salir mal
- **Textos largos**: en la plantilla activa «Auto-fit» en los cuadros de texto o corta el titular a 60 caracteres en un nodo Code.
- **Imágenes no accesibles**: si la URL requiere login, el render sale con hueco negro. Comprueba abriendo la URL en una ventana de incógnito.
- **Bucle infinito**: pon un contador en el bucle del nodo 7 y aborta a los 10 intentos, o un render atascado te deja el workflow girando.
- **Duplicados**: marca la fila como «en curso» nada más cogerla, no al final.

## Cuánto cuesta
Creatomate: plan gratis con marca de agua para probar, luego desde 41 $/mes por unos cientos de renders; Shotstack tiene 20 minutos de render gratis al mes. n8n, Drive y Sheets, gratis.
