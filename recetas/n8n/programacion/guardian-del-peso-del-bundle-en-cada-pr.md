# Guardián del peso del bundle en cada PR…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cada vez que abres una pull request, mide cuánto ha engordado el JavaScript de tu web frente a la rama principal y deja un comentario en la PR con la diferencia.

## Qué es y qué hace

Un paso de tu CI mide el tamaño de la carpeta de build y lo envía a n8n por webhook; n8n lo compara con el último valor guardado de la rama principal y deja un comentario en la pull request con la diferencia en kilobytes. Se monta con n8n, Make o Zapier y necesita un token de GitHub con permiso para comentar en PRs.

## Cómo usarla

1. Crea el webhook de n8n accesible desde internet
2. Añade el paso de medición en GitHub Actions
3. Guarda el tamaño de main en Sheets
4. Abre una PR de prueba y revisa el comentario

## Cuándo usarla

Cuando tengas una web o app en React, Vue o Next y notes que carga cada vez más lenta sin saber qué versión la empeoró.

## Cómo ganar dinero con ella

Cada 100 KB extra de JavaScript se paga en conversión perdida; detectarlo en la PR cuesta minutos, detectarlo en producción cuesta semanas.

- Presupuesto de rendimiento para frontends de clientes en React o Next…
- Control de peso de JavaScript como servicio mensual para webs con tráfico…
- Revisión de rendimiento en cada pull request para equipos de producto…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

### Qué hace y para quién
Un pequeño paso en tu CI mide el tamaño de la carpeta de build y se lo manda a n8n; n8n lo compara con el último valor guardado de la rama principal y comenta la diferencia en la pull request.
Para quien mantiene un frontend en producción y quiere presupuesto de rendimiento sin contratar herramientas de monitorización.

### Lo que necesitas antes
- Un repo en GitHub con un `npm run build` que genere una carpeta (`dist`, `.next` o `build`).
- n8n accesible desde internet (n8n Cloud, o auto-alojado con dominio y HTTPS; con `localhost` no funciona porque GitHub Actions tiene que llegar).
- Token de GitHub fine-grained con `Pull requests: Read and write` para poder comentar.
- Una hoja de Google Sheets «Bundle» con columnas: `rama`, `commit`, `bytes`, `fecha`.

### Los nodos, en orden
1. **Webhook** — Method `POST`, Path `bundle-size`, Response Mode `When Last Node Finishes`. Copia la Production URL. Protégelo: configura un *Secret* en el webhook de GitHub, valida la cabecera `X-Hub-Signature-256` en un nodo Code con ese secreto leído de una variable de entorno y descarta entregas repetidas por `X-GitHub-Delivery`.
2. **Google Sheets** (nombre: «Base de referencia») — Operation `Get Row(s)`, filtro `rama = main`, Sort por fecha descendente, Limit 1.
3. **Code** (nombre: «Comparar») — calcula diferencia absoluta y porcentual y monta el comentario.
4. **IF** — Condition: String `{{ $json.rama }}` `equals` `main`. Rama true → guardar nueva referencia; rama false → comentar en la PR.
5. **Google Sheets** (rama true) — Operation `Append`, guarda rama, commit, bytes y fecha.
6. **HTTP Request** (rama false, nombre: «Comentar PR») — `POST https://api.github.com/repos/{{$json.repo}}/issues/{{$json.pr}}/comments`, Header Auth `Authorization: Bearer TU_TOKEN`, body JSON `{{ JSON.stringify({ body: $json.comentario }) }}`.

### El paso que añades a GitHub Actions
```yaml
- name: Medir bundle
  run: |
    BYTES=$(du -sb dist | cut -f1)
    curl -X POST https://TU-N8N/webhook/bundle-size \
      -H 'Content-Type: application/json' \
      -H "X-Webhook-Key: ${{ secrets.N8N_WEBHOOK_KEY }}" \
      -d "{\"bytes\":$BYTES,\"rama\":\"${GITHUB_HEAD_REF:-main}\",\"commit\":\"$GITHUB_SHA\",\"pr\":\"${{ github.event.number }}\",\"repo\":\"${{ github.repository }}\"}"
```

### El código del nodo «Comparar»
```javascript
const d = $('Webhook').first().json.body;
const ref = $input.first().json || {};
const base = Number(ref.bytes || 0);
const ahora = Number(d.bytes);
const dif = base ? ahora - base : 0;
const pct = base ? ((dif / base) * 100).toFixed(1) : '0.0';
const kb = n => (n / 1024).toFixed(1) + ' KB';
const icono = dif > base * 0.05 ? '🔴' : dif > 0 ? '🟡' : '🟢';
const comentario = `${icono} **Tamaño del bundle**\n\n| | |\n|---|---|\n| main | ${kb(base)} |\n| esta rama | ${kb(ahora)} |\n| diferencia | ${dif >= 0 ? '+' : ''}${kb(dif)} (${pct}%) |`;
return [{ json: { ...d, base, dif, pct, comentario } }];
```

### Cómo probarla
- Lanza el `curl` a mano desde tu terminal con un valor inventado de `bytes` y comprueba que n8n lo recibe en la pestaña Executions.
- Abre una PR de prueba que meta una librería pesada a propósito (por ejemplo `moment`) y mira si el comentario sale en rojo.
- Verifica que en un push a `main` no se comenta nada y sí se guarda la fila de referencia.

### Qué puede salir mal
- **`du -sb` no existe en macOS**: en el runner de GitHub (Ubuntu) sí; si usas runner propio de Mac, usa `du -sk dist | cut -f1` y multiplica por 1024.
- **Comentarios acumulados**: en vez de crear uno nuevo cada push, busca el comentario anterior con `GET .../issues/{pr}/comments` y usa `PATCH .../issues/comments/{id}`.
- **PRs de forks**: los secretos no están disponibles; el paso no puede mandar la cabecera de autenticación del webhook, así que acepta que solo funcione en ramas internas. No pongas ningún token en la ruta de la URL del webhook.
- **Webhook sin proteger**: añade en n8n autenticación `Header Auth` al nodo Webhook (credencial de n8n, Name `X-Webhook-Key`) y guarda ese valor como secreto del repositorio de GitHub (`N8N_WEBHOOK_KEY`); el `curl` lo lee de ahí. No lo escribas en el YAML ni en un nodo: un flujo o un repo exportado se llevaría la clave.
- **Primera ejecución sin referencia**: el código ya lo contempla poniendo base 0, pero el primer comentario será poco útil hasta que `main` guarde un valor.

### Cuánto cuesta
- GitHub Actions: 2.000 minutos/mes gratis en repos privados, ilimitado en públicos. Este paso añade segundos.
- n8n auto-alojado 0 €; en n8n Cloud (de pago tras la prueba gratuita) ojo si tienes muchas PRs al día, el límite de ejecuciones del plan se come rápido.
- Google Sheets gratis.
