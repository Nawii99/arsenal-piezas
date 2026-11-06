# Anuncio automático de cada build nueva en Discord, itch…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

En cuanto publicas una release en GitHub, tu comunidad se entera: post en Discord con las notas de la versión, aviso en la devlog y correo a tu lista. Para quien publica builds.

## Qué es y qué hace

Cuando publicas una release en GitHub, el flujo convierte sus notas en un mensaje y lo publica en Discord, lo envía por email con Brevo y lo postea en Bluesky. Entrada: el evento de release; salida: tres publicaciones coordinadas. Se monta en n8n con un webhook de GitHub, y el esquema se puede replicar en Make o Zapier.

## Cómo usarla

1. Crear el webhook de GitHub y el de Discord
2. Conectar Brevo y Bluesky
3. Probar con una release de prueba
4. Revisar el texto generado antes de activar

## Cuándo usarla

Cuando lanzas parches o builds cada pocas semanas y avisar a mano en Discord, itch.io, X y la newsletter te lleva media hora cada vez.

## Cómo ganar dinero con ella

Ahorra 20-30 minutos por lanzamiento y evita el peor coste real: que tu comunidad no se entere de un parche y sigan pensando que el bug está sin arreglar.

- Gestionar los anuncios de parches de un estudio indie, cobrando una mensualidad por mantener los canales al día.
- Configurar el flujo de releases para proyectos de software libre que quieren avisar a su comunidad sin trabajo manual.
- Formar a un equipo de community managers para automatizar los anuncios de cada versión.

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Escucha el evento de nueva release en tu repositorio de GitHub, convierte las notas de versión en un mensaje limpio y lo publica en Discord, lo manda por email a tu lista de Brevo y lo postea en Bluesky. Para estudios indie con comunidad activa y ritmo de parches alto.

## Lo que necesitas antes
- Repositorio en GitHub donde crees Releases (aunque el código sea privado, la release vale).
- Un webhook de Discord: en tu servidor, Editar canal > Integraciones > Webhooks > Nuevo webhook > Copiar URL. No necesitas programar un bot.
- Cuenta gratuita de Brevo (antes Sendinblue): Settings > SMTP & API > Generate a new API key. El plan gratis permite 300 correos al día.
- Cuenta de Bluesky y una *App Password* (Ajustes > Contraseñas de aplicación). La API es gratis.
- n8n accesible desde internet para recibir el webhook (n8n Cloud, o auto-alojado con dominio y HTTPS; con `ngrok` vale para probar).

## Los nodos, en orden
1. **Webhook** — HTTP Method: `POST`. Path: `github-release`. Respond: `Immediately`. Copia la Production URL.
2. En GitHub: Settings > Webhooks > Add webhook. Payload URL: la de n8n. Content type: `application/json`. Secret: inventa uno largo. Which events: `Let me select individual events` > solo **Releases**.
3. **IF** (llamado `¿Publicada y no borrador?`) — condición 1: `{{ $json.body.action }}` equals `published`; condición 2 (AND): `{{ $json.body.release.draft }}` is false; condición 3: `{{ $json.body.release.prerelease }}` is false.
4. **Code** (llamado `Formatear notas`) — pasa el Markdown de GitHub a un texto que se lea bien en Discord, en email HTML y en 300 caracteres para Bluesky. Código completo abajo.
5. **HTTP Request** (llamado `Discord`) — Method: `POST`. URL: la del webhook de Discord. Body Content Type: `JSON`. Body: `{ "content": "@everyone {{ $json.titular }}", "embeds": [ { "title": "{{ $json.version }}", "description": "{{ $json.discord }}", "url": "{{ $json.url }}", "color": 5814783 } ] }`.
6. **HTTP Request** (llamado `Brevo campaña`) — Method: `POST`. URL: `https://api.brevo.com/v3/emailCampaigns`. Headers: `api-key: TU_CLAVE`, `content-type: application/json`. Body: `{ "name": "Build {{ $json.version }}", "subject": "{{ $json.titular }}", "sender": { "name": "Tu Estudio", "email": "hola@tuestudio.com" }, "type": "classic", "htmlContent": "{{ $json.html }}", "recipients": { "listIds": [2] }, "scheduledAt": "{{ $now.plus(10, 'minutes').toISO() }}" }`. Los 10 minutos de margen te dan tiempo a cancelarla si algo va mal.
7. **HTTP Request** (llamado `Bluesky sesión`) — POST a `https://bsky.social/xrpc/com.atproto.server.createSession`, body `{ "identifier": "tuusuario.bsky.social", "password": "TU_APP_PASSWORD" }`.
8. **HTTP Request** (llamado `Bluesky post`) — POST a `https://bsky.social/xrpc/com.atproto.repo.createRecord`. Header `Authorization: Bearer {{ $json.accessJwt }}`. Body: `{ "repo": "{{ $json.did }}", "collection": "app.bsky.feed.post", "record": { "text": "{{ $('Formatear notas').item.json.corto }}", "createdAt": "{{ $now.toISO() }}" } }`.

## El código de `Formatear notas`
```javascript
const r = $input.first().json.body.release;
const cuerpo = (r.body || '').trim();
const lineas = cuerpo.split('\n').filter(l => l.trim() !== '');
const bullets = lineas.filter(l => /^[-*]/.test(l.trim())).slice(0, 10);
const discord = (bullets.length ? bullets : lineas.slice(0, 8)).join('\n').slice(0, 1800);
const html = '<h2>' + r.name + '</h2><ul>' + (bullets.length ? bullets : lineas.slice(0, 8)).map(l => '<li>' + l.replace(/^[-*]\s*/, '') + '</li>').join('') + '</ul><p><a href="' + r.html_url + '">Descargar la build</a></p>';
const primera = (bullets[0] || lineas[0] || 'Novedades dentro').replace(/^[-*]\s*/, '');
return [{ json: {
  version: r.tag_name,
  titular: 'Nueva versión ' + r.tag_name + ' ya disponible',
  url: r.html_url,
  discord: discord,
  html: html.replace(/"/g, '\\"'),
  corto: ('Parche ' + r.tag_name + ': ' + primera).slice(0, 280) + ' ' + r.html_url
} }];
```

## Cómo probarla
- Crea una release de prueba con tag `v0.0.1-test` en un repositorio privado apuntando al mismo webhook y mira la pestaña Executions de n8n.
- Antes de conectar Brevo de verdad, cambia `listIds` por una lista con solo tu correo.
- Comprueba en GitHub > Webhooks > Recent Deliveries que la respuesta es 200. Si es 404, la URL que has pegado es la de Test y no la de Production.

## Qué puede salir mal
- **`@everyone` no funciona**: el webhook de Discord necesita que el rol tenga permiso de mencionar a todos; si no, quítalo y usa un rol propio tipo `<@&IDDELROL>`.
- **Markdown roto en el email**: GitHub permite HTML e imágenes en las notas. El código de arriba solo coge líneas de lista; si escribes notas con tablas, se perderán. Escribe las notas siempre en formato de guiones.
- **Doble disparo**: si editas la release, GitHub manda `action: edited`. El IF ya solo deja pasar `published`.
- **Comillas**: si en las notas escribes comillas dobles, romperías el JSON del nodo Discord. Por eso el código escapa comillas en `html`; haz lo mismo con `discord` si te da problemas, o usa el modo de body por campos en vez de JSON crudo.

## Cuánto cuesta
- GitHub, Discord y Bluesky: **gratis**.
- Brevo: gratis hasta 300 correos al día; su plan de pago arranca sobre 9 €/mes cuando pases de ahí.
- n8n: gratis auto-alojado. Consumo mínimo, solo se ejecuta cuando publicas.
