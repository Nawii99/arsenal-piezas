# Radar de reseñas: App Store y Google Play al Telegram…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Revisa cada hora las reseñas nuevas de tu app en las dos tiendas, las guarda en una hoja y te avisa al móvil solo de las de 1 a 3 estrellas.

## Qué es y qué hace

Flujo de n8n que cada hora consulta las reseñas nuevas de tu app en App Store y Google Play, las guarda en Google Sheets y avisa por Telegram solo de las de 1 a 3 estrellas. Entran el ID de tu app en App Store y una cuenta de servicio de Google Play con permiso de reseñas; sale una hoja con cada reseña y un aviso al móvil. Funciona en n8n Cloud o auto-alojado con Docker.

## Cómo usarla

1. 1. Obtén el ID de la app y la cuenta de servicio de Google
2. 2. Crea la hoja Reseñas y el bot de Telegram
3. 3. Activa el flujo y prueba con una reseña real

## Cuándo usarla

Úsalo cuando tengas una app publicada y te enteres tarde de las críticas malas, o cuando quieras un histórico de reseñas sin entrar cada día a las consolas.

## Cómo ganar dinero con ella

Ahorra 20-30 minutos diarios de revisar consolas y te deja responder una reseña mala en menos de una hora, cuando aún salva la nota media.

- Alerta de reseñas bajas para desarrolladores de apps que necesitan responder en la misma jornada.
- Histórico de reseñas en hoja para equipos de producto que quieren medir la calidad percibida por versión.
- Configuración de avisos de reseñas para agencias que gestionan varias apps de clientes.

**Precio orientativo:** 120–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila las reseñas nuevas de tu app en App Store y Google Play, las apunta en una hoja de cálculo y te manda un aviso al móvil cuando alguien puntúa bajo.
Es para el que tiene una app en el mercado y quiere responder rápido sin vivir pegado a las consolas de desarrollador.

## Lo que necesitas antes
- n8n autoalojado con Docker (gratuito, Community Edition) o n8n Cloud (prueba gratuita temporal y después planes de pago).
- El ID numérico de tu app en App Store: está en la URL de la ficha, `id123456789`.
- Para Android: una cuenta de servicio de Google Cloud con la API de Google Play Developer activada, invitada en Play Console (Usuarios y permisos) con permiso de «Ver reseñas y responder». Descarga el JSON de la clave.
- Una hoja de Google Sheets llamada `Reseñas` con columnas: `id`, `tienda`, `fecha`, `estrellas`, `titulo`, `texto`, `version`, `autor`.
- Un bot de Telegram: escribe a @BotFather, `/newbot`, guarda el token; escribe a tu bot y saca tu `chat_id` con @userinfobot.

## Los nodos, en orden
1. **Schedule Trigger** — modo `Interval`, cada 1 hora.
2. **HTTP Request** (renómbralo «Reseñas iOS») — GET a `https://itunes.apple.com/es/rss/customerreviews/id=123456789/sortBy=mostRecent/json`. Response Format: JSON. Sin autenticación.
3. **HTTP Request** («Reseñas Android») — GET a `https://androidpublisher.googleapis.com/androidpublisher/v3/applications/com.tuempresa.tuapp/reviews`. Authentication: `Predefined Credential Type` → `Google Service Account`, con el JSON de la clave.
4. **Code** («Normalizar») — junta las dos fuentes en un formato común.
5. **Google Sheets** — operación `Get Row(s)` sobre `Reseñas`, para traer los `id` ya guardados.
6. **Code** («Filtrar nuevas») — descarta las reseñas cuyo `id` ya está en la hoja.
7. **Google Sheets** — operación `Append`, hoja `Reseñas`, mapeo campo a campo.
8. **IF** — condición Number: `{{ $json.estrellas }}` `smaller or equal` `3`.
9. **Telegram** (rama true) — Send Message a tu `chat_id` con: `⚠️ {{$json.estrellas}}★ en {{$json.tienda}} (v{{$json.version}})\n{{$json.titulo}}\n{{$json.texto}}`.

## El código del nodo «Normalizar»
```javascript
const salida = [];
for (const item of $input.all()) {
  const d = item.json;
  if (d.feed && d.feed.entry) {
    for (const e of d.feed.entry.slice(1)) {
      salida.push({ json: {
        id: 'ios-' + e.id.label,
        tienda: 'App Store',
        fecha: e.updated.label,
        estrellas: Number(e['im:rating'].label),
        titulo: e.title.label,
        texto: e.content.label,
        version: e['im:version'] ? e['im:version'].label : '',
        autor: e.author.name.label
      }});
    }
  }
  if (d.reviews) {
    for (const r of d.reviews) {
      const c = r.comments[0].userComment;
      salida.push({ json: {
        id: 'and-' + r.reviewId,
        tienda: 'Google Play',
        fecha: new Date(Number(c.lastModified.seconds) * 1000).toISOString(),
        estrellas: c.starRating,
        titulo: '',
        texto: c.text,
        version: c.appVersionName || '',
        autor: r.authorName || 'Anónimo'
      }});
    }
  }
}
return salida;
```

## El código del nodo «Filtrar nuevas»
```javascript
const guardadas = $('Google Sheets').all().map(i => String(i.json.id));
return $('Normalizar').all().filter(i => !guardadas.includes(String(i.json.id)));
```

## Cómo probarla
- Pulsa `Execute Workflow` con el flujo desactivado y mira la salida de «Normalizar»: deben salir unas 50 reseñas de iOS.
- Ejecuta dos veces seguidas: la segunda vez «Filtrar nuevas» debe devolver 0 elementos. Si no, tienes duplicados mal filtrados.
- Baja temporalmente el IF a `smaller or equal 5` para comprobar que el mensaje de Telegram llega bien, y vuelve a dejarlo en 3.

## Qué puede salir mal
- El RSS de Apple solo devuelve las 50 últimas reseñas y solo del país que pongas en la URL (`/es/`). Si vendes en varios países, duplica el nodo HTTP con `/mx/`, `/us/`, etc.
- Google Play solo devuelve reseñas de los últimos 7 días con texto. Las puntuaciones sin comentario no aparecen: es normal.
- Si Sheets crece mucho, el nodo `Get Row(s)` se vuelve lento. Pon un `Filter` para leer solo la columna `id` o usa Airtable/Postgres a partir de unas 5.000 filas.
- Zona horaria: pon `Europe/Madrid` en Settings del workflow para que las fechas cuadren.
- Activa `Retry On Fail` (3 intentos, 5 s) en los dos HTTP Request: las APIs fallan de vez en cuando.

## Cuánto cuesta
Gratis del todo: n8n auto-alojado, RSS de Apple, API de Google Play y Telegram no cobran. Google Sheets gratis. Si usas n8n Cloud, tras la prueba gratuita necesitas un plan de pago (consulta el precio vigente en n8n.io) y esto consume unas 720 ejecuciones al mes.
