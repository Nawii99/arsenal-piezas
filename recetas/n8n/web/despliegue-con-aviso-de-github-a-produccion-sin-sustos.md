# Despliegue con aviso: de GitHub a producción sin sustos…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Cuando subes cambios a la rama principal lanza el despliegue, espera a que termine, comprueba que la web sigue viva y te dice en Telegram si ha ido bien o mal.

## Qué es y qué hace

Un webhook de GitHub avisa a n8n cuando hay un push a la rama main. El flujo dispara el build en Netlify mediante su build hook, consulta cada 30 segundos el estado, comprueba que la portada devuelve 200 y contiene un texto acordado, y envía a Telegram el resultado con el mensaje del commit. Entrada: evento push y build hook. Salida: aviso de despliegue correcto o fallido. Se adapta a Vercel o a un script SSH en tu servidor.

## Cómo usarla

1. Crea el webhook de GitHub
2. Añade el build hook de Netlify
3. Define el texto que debe aparecer en la portada
4. Prueba con un cambio sin importancia

## Cuándo usarla

Úsalo cuando publicas cambios en tu web a mano y luego no sabes si el despliegue terminó, si rompiste algo o si el cliente ya está viendo lo nuevo.

## Cómo ganar dinero con ella

Te ahorra los 15-20 minutos de vigilar cada despliegue y, sobre todo, las horas de web rota sin que nadie se dé cuenta.

- Despliegues controlados para freelancers que publican webs estáticas desde Git.
- Configuración de CI/CD sencilla para pequeñas agencias con clientes en Netlify.
- Revisión de despliegues con comprobación de portada para tiendas que publican cambios a diario.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
En cuanto haces push a la rama `main`, GitHub avisa a n8n. El flujo dispara el build en Netlify (o Vercel, o un script por SSH en tu servidor), va preguntando cada 30 segundos si ha terminado, cuando acaba comprueba que la portada devuelve 200 y que aparece un texto que tú eliges, y te manda el resultado a Telegram con el mensaje del commit.
Para desarrolladores freelance y pequeños equipos con webs estáticas o de WordPress desplegadas desde Git.

## Lo que necesitas antes
- n8n con URL pública (para el webhook de GitHub).
- Repositorio en GitHub con permisos de administración.
- Cuenta de Netlify (plan gratuito) y un **Build Hook**: en Netlify, Site settings > Build & deploy > Build hooks > Add build hook. Copia la URL.
- Un **Personal Access Token** de Netlify: User settings > Applications > New access token.
- Bot de Telegram y chat_id.

## Los nodos, en orden
1. **Webhook** — Method `POST`, Path `deploy-github`. Copia la Production URL.
2. En GitHub: Settings del repo > Webhooks > Add webhook, pega la URL, Content type `application/json`, evento «Just the push event».
3. **IF** — `{{ $json.body.ref }}` *is equal to* `refs/heads/main`. Así los push a otras ramas no despliegan.
4. **HTTP Request** («Lanzar build») — POST a la URL del Build Hook de Netlify, sin cuerpo.
5. **Wait** — 45 segundos.
6. **HTTP Request** («Estado del deploy») — GET `https://api.netlify.com/api/v1/sites/TU_SITE_ID/deploys?per_page=1`, cabecera `Authorization: Bearer TU_TOKEN`.
7. **IF** — `{{ $json[0].state }}` *is equal to* `ready`. Si no, va a un **Wait** de 30 segundos que vuelve al nodo de estado (máximo 10 vueltas, lo controlas con un contador en un Code).
8. **HTTP Request** («Comprobar web») — GET a tu dominio, Response Format `Text`, `Never Error` y `Full Response` activados.
9. **Code** — verifica código 200 y que el HTML contiene una frase que sabes que está en tu portada (código abajo).
10. **Telegram** (*Send Message*) — mensaje con el resultado, el autor y el texto del commit.

## El nodo Code
```javascript
const resp = $('Comprobar web').first().json;
const push = $('Webhook').first().json.body;
const estado = $('Estado del deploy').first().json[0] || {};
const html = typeof resp.body === 'string' ? resp.body : '';
const codigo = resp.statusCode;
const marcador = 'Contacta con nosotros'; // un texto que siempre esta en tu portada
const okHtml = html.includes(marcador);
const ok = codigo === 200 && okHtml && estado.state === 'ready';
const commit = push.head_commit ? push.head_commit.message : '(sin mensaje)';
const autor = push.head_commit ? push.head_commit.author.name : 'desconocido';
const mensaje = (ok ? '✅ Despliegue OK' : '❌ Despliegue con problemas') +
  '\nCommit: ' + commit +
  '\nAutor: ' + autor +
  '\nEstado Netlify: ' + estado.state +
  '\nCodigo web: ' + codigo +
  (okHtml ? '' : '\n⚠️ No encuentro el texto de control en la portada');
return [{ json: { ok, mensaje } }];
```

## Cómo probarla
- Con el Webhook en modo test, haz un push cualquiera a `main` (con cambiar una coma en el README vale) y mira que llega el evento.
- Cambia a propósito el `marcador` por un texto que no exista y comprueba que te llega el mensaje rojo: así sabes que la comprobación funciona de verdad.
- Prueba un push a una rama que no sea `main` y verifica que no pasa nada.

## Qué puede salir mal
- **El build tarda más de lo que esperas**: por eso está el bucle de espera. Si tu build tarda 8 minutos, sube el Wait inicial a 3 minutos.
- **Caché de CDN**: Netlify sirve la versión nueva enseguida, pero si tienes Cloudflare delante puedes estar comprobando la versión vieja. Añade `?nocache={{ $now.toMillis() }}` a la URL de comprobación.
- **Secretos en el flujo**: guarda el token de Netlify como credencial de tipo Header Auth en n8n, no escrito a pelo en el nodo.
- **Webhook público**: cualquiera que sepa tu URL puede dispararlo. Configura en GitHub un *Secret* y valida la cabecera `X-Hub-Signature-256` con un nodo Code, o al menos usa un path largo y aleatorio.
- **Despliegues encadenados**: si haces cinco push seguidos se lanzan cinco flujos. Añade en Settings del workflow un límite de concurrencia o comprueba al inicio si ya hay uno corriendo.

## Cuánto cuesta
- Netlify: plan gratuito con 300 minutos de build al mes, suficiente para una web pequeña.
- GitHub: gratis.
- n8n: 0 € auto-alojado. Telegram: 0 €.
- Si usas Vercel el flujo es idéntico cambiando la API; si despliegas por SSH, sustituye el nodo de Netlify por el nodo **Execute Command** o **SSH** de n8n.
