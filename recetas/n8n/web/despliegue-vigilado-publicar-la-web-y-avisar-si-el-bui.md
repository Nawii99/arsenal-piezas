# Despliegue vigilado: publicar la web y avisar si el bui…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Cuando subes cambios a GitHub, lanza el despliegue en Netlify o Cloudflare Pages, espera el resultado y te avisa por Telegram si la web se ha publicado o si el build ha reventado.

## Qué es y qué hace

Escucha los push a la rama principal de tu repositorio de GitHub, dispara el build hook de Netlify, consulta el estado del despliegue cada 20 segundos y te avisa por Telegram si se publicó o si el build falló. Si falla, envía el error resumido y ofrece restaurar el último despliegue correcto. Requiere repositorio y despliegue ya conectados.

## Cómo usarla

1. Crear el build hook y el token personal de Netlify
2. Configurar el webhook de GitHub
3. Montar el flujo en n8n con Telegram
4. Probar con un cambio pequeño

## Cuándo usarla

Úsalo cuando publiques cambios y no te enteres de si han salido bien, cuando tengas un desarrollador externo tocando el repo, o cuando quieras poder revertir en un clic.

## Cómo ganar dinero con ella

Evita tener la web rota horas sin saberlo. Ahorra la revisión manual de cada despliegue y el «no me carga la página» del cliente a las once de la noche.

- Vigilancia de despliegues para webs de clientes con desarrollador externo.
- Servicio de publicación controlada con aviso y restauración para equipos pequeños.
- Mantenimiento de despliegues en Netlify o Cloudflare Pages para agencias con varias webs.

**Precio orientativo:** 120–250 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Escucha los `push` a la rama principal de tu repositorio, dispara el build hook de Netlify, consulta cada 20 segundos el estado del despliegue y avisa cuando termina.
Si el build falla, te manda el error resumido y un botón para restaurar el último despliegue que funcionaba, para que la web nunca se quede rota más de dos minutos.

## Lo que necesitas antes
- Repositorio en GitHub con tu web y despliegue ya conectado a Netlify (o Cloudflare Pages, ver variante al final).
- Build hook de Netlify: en tu sitio, «Site configuration > Build & deploy > Build hooks > Add build hook». Te da una URL tipo `https://api.netlify.com/build_hooks/xxxx`.
- Token personal de Netlify: «User settings > Applications > Personal access tokens > New access token». Cópialo.
- El Site ID de Netlify: «Site configuration > General > Site information > Site ID».
- Bot de Telegram con tu chat ID y n8n con URL pública.

## Los nodos, en orden
1. **GitHub Trigger** — Authentication: Access Token; Repository Owner y Name: los tuyos; Events: `push`. (Alternativa sin credencial: nodo **Webhook** con Path `deploy` y pega esa URL en GitHub > Settings > Webhooks, content type `application/json`, evento `push`.)
2. **IF** (renómbralo «¿Rama principal?») — String: `={{ $json.body?.ref || $json.ref }}` is equal to `refs/heads/main`.
3. **HTTP Request** (renómbralo «Lanzar build») — Method: POST; URL: tu build hook; Body: none.
4. **Wait** — Amount: 45, Unit: Seconds.
5. **HTTP Request** (renómbralo «Estado del deploy») — GET `https://api.netlify.com/api/v1/sites/TU_SITE_ID/deploys?per_page=1`; Authentication: Generic > Header Auth con Name `Authorization` y Value `Bearer TU_TOKEN`.
6. **Code** (renómbralo «Leer estado») — ver código.
7. **IF** (renómbralo «¿Ha terminado?») — Boolean: `={{ $json.terminado }}` is false → salida true vuelve al **Wait** (paso 4) para seguir esperando; salida false sigue al paso 8. Para no dar vueltas infinitas, el código corta a los 10 intentos.
8. **Switch** — campo `={{ $json.estado }}`: salida `ready`, salida `error`, fallback `otros`.
9. **Telegram** (salida ready) — `✅ Web publicada\nCommit: {{ $('GitHub Trigger').item.json.head_commit.message }}\nURL: {{ $json.url }}\nTardó {{ $json.segundos }}s`.
10. **Telegram** (salida error) — `🔴 BUILD FALLIDO\n{{ $json.resumen_error }}\nRevisa: {{ $json.admin_url }}`.
11. **HTTP Request** (opcional, tras el aviso de error) — POST `https://api.netlify.com/api/v1/sites/TU_SITE_ID/deploys/{{ $json.id_anterior_ok }}/restore` con la misma cabecera de autorización, para volver a la última versión buena.

## El código de «Leer estado»
```js
const s = $getWorkflowStaticData('node');
s.intentos = (s.intentos || 0) + 1;
const d = Array.isArray($json) ? $json[0] : ($input.first().json[0] || $input.first().json);
const estado = d.state;
const terminado = ['ready', 'error', 'cancelled'].includes(estado) || s.intentos >= 10;
if (terminado) s.intentos = 0;
return [{ json: {
  terminado,
  estado: terminado ? estado : 'building',
  id: d.id,
  url: d.deploy_ssl_url || d.ssl_url,
  admin_url: d.admin_url,
  segundos: d.deploy_time || 0,
  resumen_error: (d.error_message || 'Sin detalle').slice(0, 500)
} }];
```

## Cómo probarla
- Haz un commit tonto (cambia una coma en el README) y súbelo a `main`: debe llegarte el Telegram verde en menos de dos minutos.
- Rompe el build a propósito: en `package.json` pon un script `build` que sea `exit 1`, haz push y comprueba que llega el aviso rojo. Luego arréglalo.
- Prueba el restore manualmente desde el panel de Netlify antes de fiarte del nodo automático.

## Qué puede salir mal
- **El GitHub Trigger no dispara**: comprueba en GitHub > Settings > Webhooks que la última entrega devolvió 200; si tu n8n es local, GitHub no llega, necesitas dominio público o un túnel.
- **Avisos duplicados**: si tienes protegida la rama y haces merge, se generan dos push; filtra en el IF con `{{ $json.body.commits.length > 0 }}`.
- **El deploy consultado no es el tuyo**: si hay varios seguidos, filtra por `?branch=main` y compara `commit_ref` con el `after` del push.
- **Se queda en «building» eternamente**: el corte a 10 intentos te avisa igualmente; sube el Wait a 60 s si tus builds son largos.
- **Cloudflare Pages en vez de Netlify**: cambia el paso 5 por GET `https://api.cloudflare.com/client/v4/accounts/{account_id}/pages/projects/{proyecto}/deployments` con cabecera `Authorization: Bearer` de un API Token con permiso «Cloudflare Pages: Read».

## Cuánto cuesta
- Netlify: plan gratuito con 300 minutos de build al mes; Cloudflare Pages: 500 builds/mes gratis.
- GitHub, Telegram y n8n auto-alojado: gratis.
- Si haces más de 20-30 despliegues al día tendrás que mirar los planes de pago del hosting (19 $/mes en Netlify).
