# Recompilar la web estática sola cuando cambia el conten…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Detecta cambios en la hoja de cálculo o el CMS que alimenta tu web estática, dispara la compilación en Netlify, Vercel o Cloudflare Pages, espera a que termine y te confirma si salió bien.

## Qué es y qué hace

Vigila una hoja de cálculo o un CMS que alimenta una web estática y, solo cuando cambia su contenido, lanza un build hook de Netlify, Vercel o Cloudflare Pages. Después consulta el estado del despliegue y confirma si terminó bien. Entrada: huella del contenido en una hoja auxiliar y URL del build hook. Salida: compilación y aviso de resultado. Se monta en n8n para webs hechas con Astro, Hugo o Eleventy.

## Cómo usarla

1. Crea el build hook en tu hosting
2. Guarda la huella en la hoja auxiliar
3. Prueba con un cambio de texto
4. Revisa el aviso si la compilación falla

## Cuándo usarla

Cuando has hecho una web estática (Astro, Hugo, Eleventy o HTML generado) que se nutre de un Google Sheets o un CMS, y el cliente quiere ver sus cambios sin llamarte.

## Cómo ganar dinero con ella

Elimina los 'súbeme esto a la web' que te comen 10 minutos cada vez. Con 3 cambios semanales son 26 horas al año recuperadas.

- Webs estáticas con contenido editable para clientes que no quieren llamarte por cada cambio.
- Mantenimiento de catálogos o directorios publicados desde hoja de cálculo.
- Configuración de publicación automática para agencias con varias webs estáticas.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila la fuente de contenido, y solo cuando algo ha cambiado de verdad lanza una compilación en el hosting estático.
Después espera y comprueba el resultado, para que un fallo de compilación no pase desapercibido y deje la web con contenido viejo.

## Lo que necesitas antes
- n8n.
- Un sitio ya desplegado en Netlify, Vercel o Cloudflare Pages.
- Un **build hook**: en Netlify, Site settings > Build & deploy > Build hooks > Add build hook; te da una URL tipo `https://api.netlify.com/build_hooks/XXXX`. En Cloudflare Pages, Settings > Builds > Deploy hooks. En Vercel, Settings > Git > Deploy Hooks.
- Un token personal de Netlify (User settings > Applications > Personal access tokens) para consultar el estado del despliegue.
- El Google Sheets que alimenta el contenido, y una hoja auxiliar `estado` con una celda para guardar la huella del contenido y otra para la hora de la última compilación.

## Los nodos, en orden
1. **Schedule Trigger** — `Minutes`, cada `10` minutos (o **Google Sheets Trigger** en modo `On Row Update` si prefieres reaccionar al cambio).
2. **Google Sheets** — `Get Row(s)` de la pestaña de contenido.
3. **Code** — calcula el hash del contenido completo y lo compara con el guardado (código abajo).
4. **IF** — `{{ $json.hay_cambios }}` es `true`.
5. **IF (antirrebote)** — `{{ $json.minutos_desde_ultima }}` mayor que `5`. Evita compilar 6 veces mientras el cliente escribe.
6. **HTTP Request** — POST vacío a la URL del build hook, que guardas como variable de entorno de n8n (`={{ $env.BUILD_HOOK_URL }}`) en vez de pegarla en el nodo: quien tenga esa URL puede lanzar compilaciones y un flujo exportado se la llevaría. Body: ninguno. Devuelve 200 al instante.
7. **Google Sheets** — `Update Row` guardando la nueva huella y la hora en la pestaña `estado`.
8. **Wait** — 90 segundos.
9. **HTTP Request** — GET a `https://api.netlify.com/api/v1/sites/TU_SITE_ID/deploys?per_page=1` con Authentication: Generic Credential Type > Header Auth, con una credencial de n8n (Name «Authorization», Value «Bearer TU_TOKEN»); el nodo usa esa credencial. No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él.
10. **IF** — `{{ $json[0].state }}` igual a `ready`.
11. Rama SÍ: **Slack** `La web se ha actualizado, {{ $json[0].deploy_time }} segundos`. Rama NO: **Slack** con el enlace a `{{ $json[0].admin_url }}` para ver el log del error.

## El nodo Code
```js
const crypto = require('crypto');
const filas = $input.all().map(i => i.json);
const texto = JSON.stringify(filas);
const hash = crypto.createHash('sha1').update(texto).digest('hex');
const estado = $('Leer estado').first().json;
const anterior = estado.huella || '';
const ultima = estado.ultima_compilacion ? new Date(estado.ultima_compilacion) : new Date(0);
const minutos = Math.floor((Date.now() - ultima.getTime()) / 60000);
return [{ json: { huella: hash, hay_cambios: hash !== anterior, minutos_desde_ultima: minutos, filas: filas.length } }];
```
Necesitas un nodo **Google Sheets** llamado `Leer estado` antes del Code, que lea la pestaña `estado`.

## Cómo probarla
- Cambia una celda de contenido y espera al siguiente ciclo: debe compilar una sola vez.
- Cambia tres celdas seguidas en un minuto: gracias al antirrebote debe compilar una sola vez.
- Rompe la compilación a propósito (mete una coma rara en un campo que use la plantilla) y confirma que el aviso de fallo llega a Slack con el enlace al log.

## Qué puede salir mal
- **Tormentas de compilación**: sin el antirrebote y sin el hash, compilarías cada 10 minutos y te comerías los minutos de compilación gratuitos.
- **Límites del plan gratuito**: Netlify da 300 minutos de compilación al mes en el plan gratuito; Cloudflare Pages, 500 compilaciones al mes. Si cada compilación tarda 1 minuto, con 4 cambios diarios vas sobrado; con 40, no.
- **Despliegue lento**: si el sitio tarda más de 90 segundos, el paso 9 verá `building`. Añade un bucle: IF `state` es `building` > Wait 60 s > vuelve al HTTP Request, con un máximo de 5 vueltas.
- **Contenido a medias**: si el cliente edita en directo, puede publicarse una fila incompleta. Añade una columna `publicar` y filtra en el paso 2 por `publicar = si`.

## Cuánto cuesta
0 € en los planes gratuitos de Netlify, Vercel o Cloudflare Pages para una web pequeña. n8n auto-alojado gratis. Vigila los minutos de compilación si el sitio es grande.
