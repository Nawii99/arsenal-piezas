# Publicar el portfolio gratis y vigilar que no se caiga…

**Tipo:** Receta de automatización · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Publicas el portfolio gratis en Cloudflare Pages y montas un flujo en n8n que comprueba cada hora que el enlace responde y que carga rapido.

## Qué es y qué hace

Es una receta para publicar tu portfolio (un index.html) gratis en Cloudflare Pages desde un repositorio público de GitHub, con HTTPS incluido. Además, un flujo de n8n comprueba cada hora que el enlace responde y que carga rápido, y te avisa por Telegram si falla. Entra un HTML y sale una web en línea con vigilancia. Se usa para el enlace del currículum y de LinkedIn; el flujo corre en n8n autoalojado o en n8n Cloud.

## Cómo usarla

1. Sube el index.html a un repositorio público de GitHub
2. Conéctalo en Cloudflare Pages (preset None, sin comando de build)
3. Crea en n8n un flujo horario que pida el enlace y mida el tiempo de respuesta
4. Configura el aviso en un bot de Telegram

## Cuándo usarla

Cuando ya tienes el index.html hecho y vas a poner el enlace en el curriculum y en LinkedIn, donde no te puedes permitir un 404.

## Cómo ganar dinero con ella

Publicacion mas vigilancia para otro candidato: 60 EUR de alta y 5 EUR al mes. Poco dinero, pero es un cliente que vuelve.

- Publicación y vigilancia de portfolios para candidatos tech: alta única más una cuota mensual de monitorización.
- Montaje de webs gratuitas en Cloudflare Pages para autónomos o pequeños negocios, con guía para conectar dominio.
- Servicio de monitorización de disponibilidad con n8n para webs de clientes, con informe mensual de caídas y tiempos de carga.

**Precio orientativo:** 60–90 € por alta. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

RECETA: publicar el portfolio gratis y enterarte antes que nadie si se cae.

PARTE 0. Publicarlo (esto se hace una vez, a mano, 15 minutos)

Cuentas necesarias, todas gratis:
- GitHub. Repositorio publico, sin limite de repos.
- Cloudflare. Plan Free de Pages: 500 despliegues al mes, ancho de banda sin limite, HTTPS incluido.
- n8n. Autoalojado es gratis y sin limite de ejecuciones. En n8n Cloud la prueba es de 14 dias y luego se paga; si vas a autoalojar, con una Raspberry o un VPS de 5 EUR sobra.
- Telegram. Un bot gratis para los avisos.

Pasos:
1. Crea un repositorio publico en GitHub llamado `portfolio` y sube dentro tu `index.html`. Desde el movil puedes hacerlo con "Add file > Upload files" en la web de GitHub.
2. Entra en Cloudflare > Workers & Pages > Create > Pages > Connect to Git. Autoriza GitHub y elige el repo `portfolio`.
3. Framework preset: None. Build command: vacio. Output directory: `/`. Dale a Save and Deploy.
4. En un minuto tienes `https://portfolio-xxx.pages.dev`. Cada vez que subas un cambio a GitHub, se republica solo.
5. En Settings > Builds & deployments > Deploy hooks, crea uno llamado `redeploy`. Copia la URL: es un POST que vuelve a publicar. La guardas, la vas a usar luego.
6. Alternativa si prefieres GitHub Pages: Settings > Pages > Deploy from a branch > main > /root. Es igual de gratis, pero tiene tope de 100 GB de trafico al mes y 10 publicaciones por hora.

Aviso antes de seguir: abre tu enlace con los datos moviles y el wifi apagado. Si tarda mas de 3 segundos en verse, quita el 3D o bajalo de nivel. Un portfolio que tarda espanta al reclutador mas que uno feo.

PARTE 1. El flujo de n8n, nodo a nodo

Nodo 1 - Schedule Trigger
- Trigger Interval: Hours.
- Hours Between Triggers: 1.
- Con una vez por hora sobra. Cada minuto solo te gasta ejecuciones.

Nodo 2 - HTTP Request (renombralo "Pedir portfolio")
- Method: GET.
- URL: la tuya, por ejemplo `https://portfolio-xxx.pages.dev`.
- Options > Response > Include Response Headers and Status: activado.
- Options > Response > Never Error: activado. Sin esto, un 404 rompe el flujo y no te avisa nadie.
- Options > Timeout: 15000.
- Settings > On Error: Continue (using error output). Asi un fallo de red tambien llega al aviso.

Nodo 3 - Code (renombralo "Medir")
- Mode: Run Once for All Items.
- Codigo:
  const r = $input.first().json;
  const estado = r.statusCode || 0;
  const cuerpo = typeof r.body === 'string' ? r.body : JSON.stringify(r.body || '');
  const ms = Date.now() - new Date($execution.startedAt || Date.now()).getTime();
  const tieneContacto = cuerpo.includes('Contacto');
  const kb = Math.round(cuerpo.length / 1024);
  return [{ json: { estado, ms, kb, tieneContacto, ok: estado === 200 && tieneContacto } }];
- El `tieneContacto` es el truco importante: comprueba que la pagina se ha servido entera, no solo que el servidor conteste.

Nodo 4 - IF (renombralo "Esta bien?")
- Condicion 1: Boolean > `{{ $json.ok }}` is true.
- Condicion 2: Number > `{{ $json.kb }}` larger than 5.
- Combine: AND.
- Salida true = todo correcto. Salida false = hay problema.

Nodo 5 (rama false) - Telegram > Send Message
- Chat ID: el tuyo (te lo da el bot @userinfobot).
- Text: `PORTFOLIO CAIDO. Estado {{ $('Medir').item.json.estado }}, {{ $('Medir').item.json.kb }} KB. Enlace: https://portfolio-xxx.pages.dev`
- Si no quieres Telegram, usa Gmail > Send Message al mismo correo.

Nodo 6 (despues del 5) - HTTP Request (renombralo "Republicar")
- Method: POST.
- URL: el Deploy hook de Cloudflare que guardaste en la Parte 0.
- Body: vacio.
- Con esto, si se cayo por un despliegue a medias, se arregla solo mientras tu lees el aviso.

Nodo 7 (rama true) - IF (renombralo "Va lento?")
- Condicion: Number > `{{ $json.ms }}` larger than 2500.
- Salida true: otro nodo Telegram con el texto `El portfolio tarda {{ $json.ms }} ms. Baja el 3D o quita imagenes.`
- Salida false: nodo No Operation. Fin. El silencio es buena senal.

PARTE 2. Como probarla sin liarla

1. No actives el flujo todavia. Deja el interruptor Active en apagado.
2. Dale a "Execute Workflow" a mano. Debe salir por la rama true y terminar en el No Operation.
3. Ahora cambia la URL del nodo 2 por `https://portfolio-xxx.pages.dev/no-existe` y ejecuta otra vez. Te tiene que llegar el mensaje de Telegram. Si no llega, el fallo esta en el bot, no en el flujo.
4. Desconecta el nodo "Republicar" mientras haces esta prueba, o te comeras despliegues del cupo de 500.
5. Devuelve la URL buena, vuelve a conectar el nodo 6 y ejecuta una vez mas para confirmar.
6. Ahora si, activa el flujo.
7. Vuelve en 24 horas a Executions y mira que se hayan ejecutado 24 veces y ninguna haya fallado.

AVISOS HONESTOS
- Esto vigila que la pagina responda, no que este bonita. Si publicas un cambio que rompe el diseno, el flujo dira que todo va bien.
- Si autoalojas n8n en tu propio servidor y el servidor se cae, se cae el vigilante tambien. No te enteras de nada. Para dormir tranquilo, anade un chequeo externo gratis tipo UptimeRobot (50 monitores gratis) como segunda red.
- Un dominio propio (`tunombre.com`, unos 10 EUR al ano) da mejor impresion que `pages.dev` y, sobre todo, no te ata: si cambias de hosting, el enlace del curriculum sigue funcionando.
