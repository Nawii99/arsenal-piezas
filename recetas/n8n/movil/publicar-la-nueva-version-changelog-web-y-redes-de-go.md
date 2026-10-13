# Publicar la nueva versión: changelog, web y redes de go…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Cuando subes una build nueva a la tienda, coge los commits, escribe las notas de la versión en cristiano y las publica en tu web, tus redes y un correo a usuarios.

## Qué es y qué hace

Flujo de n8n que se activa al crear una etiqueta de versión en GitHub. Recoge los commits, pide a una IA de texto (Claude, Codex, Gemini o una IA local) que redacte las notas en lenguaje de usuario, actualiza un changelog en JSON de tu web y prepara la publicación en redes y en el correo de suscriptores. Entran los commits y la plantilla; sale el texto de la versión listo para publicar. Requiere permiso de webhooks en GitHub y tu lista de correo.

## Cómo usarla

1. 1. Crea el webhook de releases en GitHub
2. 2. Conecta la IA elegida y tu lista de correo
3. 3. Revisa el texto de la primera versión antes de que salga al público

## Cuándo usarla

Cuando cada lanzamiento te cuesta media tarde de escribir notas, actualizar la web y avisar, y acabas publicando la app sin contárselo a nadie.

## Cómo ganar dinero con ella

Convierte 2-3 horas por lanzamiento en 10 minutos de revisión. Si publicas una vez al mes, son más de 25 horas al año recuperadas.

- Notas de versión y avisos para apps que lanzan una vez al mes y no tienen tiempo de comunicarlo.
- Changelog público para estudios de juegos que quieren que su comunidad sepa lo que llega en cada parche.
- Automatización de lanzamientos para agencias que gestionan publicaciones de varias apps de clientes.

**Precio orientativo:** 150–350 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Al crear una etiqueta de versión en GitHub, genera las notas de la versión a partir de los commits, las traduce a lenguaje de usuario y las publica en tu web, en redes y por email.
Para el desarrollador o el equipo pequeño que publica versiones y siempre deja la comunicación para el final.

## Lo que necesitas antes
- Repositorio en GitHub y permiso para crear webhooks (Settings → Webhooks).
- Clave de API de OpenAI.
- Un fichero JSON en tu web (`/changelog.json`) o una tabla en Notion/Airtable donde volcar el historial.
- Cuenta de Brevo (antes Sendinblue) con una lista de suscriptores, o Mailchimp.
- Opcional: cuenta de X/Twitter con acceso a la API, o Buffer.

## Los nodos, en orden
1. **Webhook** — POST, ruta `release`. En GitHub: Settings → Webhooks → Add webhook, `Content type: application/json`, evento `Releases`.
2. **IF** — `{{ $json.body.action }}` igual a `published`.
3. **HTTP Request** — GET `https://api.github.com/repos/USUARIO/REPO/compare/{{ $json.body.release.target_commitish }}...{{ $json.body.release.tag_name }}` con credencial GitHub. Devuelve los commits desde la versión anterior.
4. **Code** («Limpiar commits») — quita los merges y los commits de mantenimiento.
5. **OpenAI** — prompt: «Convierte esta lista de commits en notas de versión para usuarios de una app móvil. Máximo 5 puntos, empezando por verbo, español de España, sin tecnicismos. Separa en Novedades y Correcciones. Devuelve JSON con claves `titulo`, `novedades` (array) y `correcciones` (array).»
6. **Set** — arma tres textos: uno largo para la web, uno de 280 caracteres para X y uno para el email.
7. **HTTP Request** («Guardar en web») — POST a tu CMS o commit en GitHub Pages actualizando `changelog.json`.
8. **HTTP Request** («Publicar en X») — POST `https://api.x.com/2/tweets` con body `{ "text": "{{ $json.tuit }}" }`.
9. **Brevo** — crea y envía una campaña a la lista `Usuarios app` con el asunto `Novedades de {{ $json.titulo }}`.
10. **Slack** — te avisa: «Versión {{tag}} publicada y comunicada».

## El código del nodo «Limpiar commits»
```javascript
const commits = $input.first().json.commits || [];
const utiles = commits
  .map(c => c.commit.message.split('\n')[0])
  .filter(m => !/^(merge|chore|ci|build|bump|wip)/i.test(m));
return [{ json: {
  tag: $('Webhook').first().json.body.release.tag_name,
  lista: utiles.join('\n- '),
  total: utiles.length
}}];
```

## Cómo probarla
- Crea una release de prueba en un repo vacío con 3 commits inventados y deja desconectados los nodos de publicación. Revisa el texto que sale.
- Publica primero solo en la web durante un par de versiones; cuando el texto te guste sin retocarlo, conecta X y el email.
- Añade un paso manual si quieres: un nodo **Gmail** que te mande el borrador y un **Wait** con `On Webhook Call` para aprobar antes de publicar.

## Qué puede salir mal
- Si tus mensajes de commit son del tipo «arreglos varios», la IA no puede inventar. Adopta commits descriptivos o escribe el resumen tú en el cuerpo de la release y usa ese texto como entrada.
- La API de X en su nivel gratuito permite muy pocas publicaciones al mes (100 al mes aproximadamente); para más volumen, Buffer sale mejor.
- GitHub reintenta el webhook si respondes tarde: pon un nodo **Respond to Webhook** al principio que conteste 200 al momento.
- Cuidado con publicar antes de que Apple apruebe la versión: dispara el flujo con la release de GitHub solo cuando la app ya esté «Ready for Sale», o añade un HTTP Request a App Store Connect que compruebe el estado.

## Cuánto cuesta
GitHub gratis, OpenAI céntimos por lanzamiento, Brevo gratis hasta 300 emails al día, X gratis con límite bajo. n8n auto-alojado gratis. Coste real: menos de 1 € por versión.
