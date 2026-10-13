# Publicación diaria en Instagram desde una hoja de cálcu…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Preparas 30 fotos con su texto en una hoja y el sistema publica una cada día en Instagram a la hora buena, sin que toques el móvil.

## Qué es y qué hace

Lee una hoja de Google Sheets con la cola de publicaciones (URL de imagen, pie, hashtags, fecha y hora). Cada día, a la hora fijada, coge la primera fila pendiente y la publica en una cuenta profesional de Instagram con la API oficial de Meta. Entran filas de contenido y salen publicaciones programadas. Para fotógrafos, tiendas y creadores que quieren constancia sin publicar a rachas.

## Cómo usarla

1. Prepara la cola de treinta publicaciones en la hoja
2. Enlaza la cuenta profesional con una Página de Facebook
3. Genera el token de larga duración
4. Programa el disparo diario en n8n

## Cuándo usarla

Úsalo cuando publicas a rachas, te pasas dos semanas sin subir nada y luego cuelgas cinco fotos seguidas porque te acordaste.

## Cómo ganar dinero con ella

Sustituye 20-30 minutos diarios de «pensar qué subo». Un mes de contenido se prepara en una tarde.

- Configuración de publicación automática en Instagram para tiendas y fotógrafos, con cola mensual preparada.
- Gestión mensual de contenido y calendario de publicaciones para creadores, cobrada por cuota.
- Plantilla de cola de publicaciones vendida a agencias de redes sociales pequeñas.

**Precio orientativo:** 200–400 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lees una hoja de Google Sheets con la cola de publicaciones (URL de la imagen, pie de foto, hashtags, fecha y hora). Cada día a la hora fijada, el flujo coge la primera fila pendiente y la publica en tu cuenta profesional de Instagram usando la API oficial de Meta.
Para fotógrafos, tiendas y creadores que quieren presencia constante sin estar pegados al móvil.

## Lo que necesitas antes
- Cuenta de Instagram **Profesional** (Empresa o Creador) vinculada a una **Página de Facebook**. Sin esto la API no funciona, no hay atajo.
- App en developers.facebook.com: crea una app tipo `Business`, añade el producto `Instagram Graph API`, y en Herramientas > Explorador de la API genera un token con los permisos `instagram_basic`, `instagram_content_publish`, `pages_show_list` y `pages_read_engagement`.
- Convierte ese token en uno de larga duración (60 días) con la herramienta `Access Token Debugger` > `Extend Access Token`.
- Tu `Instagram Business Account ID`: en el Explorador, consulta `me/accounts` y luego `PAGE_ID?fields=instagram_business_account`.
- Las imágenes deben estar en una URL pública y accesible (Cloudinary, tu web, o Drive con enlace directo). Instagram las descarga él mismo; no acepta subida de archivo.
- Hoja `Cola Instagram` con columnas: `fecha`, `hora`, `url_imagen`, `pie`, `hashtags`, `estado`, `id_publicacion`.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 * * * *` (cada hora en punto). Zona horaria `Europe/Madrid`.
2. **Google Sheets** — `Get Row(s)` de la hoja `Cola Instagram`, filtro `estado` igual a `PENDIENTE`.
3. **Code** (`¿Toca ahora?`) — compara fecha y hora con el momento actual. Código abajo.
4. **IF** — `{{ $json.toca }}` es `true`. Si no, el flujo se para y ya está.
5. **HTTP Request** (`Crear contenedor`) — Method `POST`. URL: `https://graph.facebook.com/v21.0/TU_IG_ID/media`. Query Parameters: `image_url` = `{{ $json.url_imagen }}`, `caption` = `{{ $json.texto_completo }}`, `access_token` = tu token.
6. **Wait** — Amount: 30, Unit: `Seconds`. Instagram necesita ese rato para descargar y procesar la imagen.
7. **HTTP Request** (`Publicar`) — Method `POST`. URL: `https://graph.facebook.com/v21.0/TU_IG_ID/media_publish`. Query Parameters: `creation_id` = `{{ $json.id }}`, `access_token` = tu token.
8. **Google Sheets** — `Update Row`: pon `estado` a `PUBLICADO` e `id_publicacion` a `{{ $json.id }}`.
9. **Gmail** — te avisa: `Publicado en Instagram: {{ $('Code').item.json.pie }}`. Opcional.

## El código del nodo ¿Toca ahora?
```javascript
const ahora = new Date();
const hoy = ahora.toLocaleDateString('sv-SE', { timeZone: 'Europe/Madrid' }); // formato AAAA-MM-DD
const horaAhora = parseInt(ahora.toLocaleString('es-ES', { timeZone: 'Europe/Madrid', hour: '2-digit', hour12: false }), 10);
for (const item of $input.all()) {
  const d = item.json;
  const horaFila = parseInt(String(d.hora).split(':')[0], 10);
  if (String(d.fecha).slice(0,10) === hoy && horaFila === horaAhora) {
    const texto = `${d.pie}\n\n.\n.\n.\n${d.hashtags}`;
    return [{ json: { ...d, toca: true, texto_completo: texto.slice(0, 2200) } }];
  }
}
return [{ json: { toca: false } }];
```

## Cómo probarla
- Mete una sola fila con la fecha de hoy y la hora siguiente, y una imagen cuadrada de menos de 8 MB en JPG.
- Ejecuta el workflow a mano en esa hora. Si el paso 5 da error `The image is not accessible`, tu URL no es pública: ábrela en una ventana de incógnito para comprobarlo.
- Si el paso 7 da `Media ID is not available`, sube el Wait de 30 a 60 segundos.

## Qué puede salir mal
- **El token caduca a los 60 días.** Es el fallo número uno. Monta un segundo workflow con Schedule mensual que llame a `https://graph.facebook.com/v21.0/oauth/access_token?grant_type=fb_exchange_token&client_id=...&client_secret=...&fb_exchange_token=TOKEN_ACTUAL` y te mande el nuevo por email.
- **Límite de 25 publicaciones cada 24 horas.** De sobra para una al día.
- **Formatos.** Solo JPG. El PNG lo rechaza. Relación de aspecto entre 4:5 y 1.91:1.
- **Hora en verano.** Si n8n corre en UTC, en verano publicará una hora antes. Fija la zona horaria del workflow en Settings del propio workflow, no solo en la instancia.
- **Se publica dos veces.** Si el Schedule tarda más de una hora en ejecutar, puede repetir. Marca la fila como `EN CURSO` justo después del paso 4, antes de publicar.

## Cuánto cuesta
- La API de Instagram es gratuita.
- n8n auto-alojado: 0 €. Alojar las imágenes en Cloudinary gratis o en tu propia web: 0 €.
- Herramientas comerciales equivalentes (Later, Metricool de pago) van de 15 a 30 €/mes.
