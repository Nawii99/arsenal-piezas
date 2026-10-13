# Novedades del producto para clientes desde tus releases…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Convierte cada publicación de una versión en GitHub en un aviso claro y sin tecnicismos para tus clientes, por correo y en una hoja de novedades.

## Qué es y qué hace

Flujo de n8n que se activa cuando publicas una release en GitHub. Lee sus commits, los agrupa en Novedades, Arreglos y Por dentro, traduce los prefijos convencionales (feat, fix, chore) a frases comprensibles y genera un borrador. Tras tu aprobación envía el correo a clientes y guarda una fila en una hoja de novedades.

## Cómo usarla

1. Usa commits convencionales en tu repo
2. Conecta GitHub y Gmail en n8n
3. Crea la hoja de novedades y la lista de clientes
4. Aprueba el primer borrador

## Cuándo usarla

Úsalo cuando entregues software a clientes o usuarios y te dé pereza escribir el «qué hay de nuevo» cada vez, con el resultado de que nadie se entera de las mejoras que pagan.

## Cómo ganar dinero con ella

Comunicar mejoras reduce bajas y justifica la cuota de mantenimiento: media hora ahorrada por versión y clientes que ven que el producto avanza.

- Comunicación de versiones para productos SaaS pequeños…
- Boletín de novedades para clientes de software a medida…
- Gestión de changelog y avisos para proyectos entregados a varios clientes…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cuando publicas una release en GitHub, el flujo lee sus commits, los agrupa en «Novedades», «Arreglos» y «Por dentro», traduce los prefijos técnicos a frases normales y te deja un borrador listo. Si lo apruebas, sale un correo a tu lista de clientes y se guarda una fila en la hoja de novedades que puedes publicar en tu web.
Para quien vende o mantiene un producto propio, un SaaS pequeño o un proyecto entregado a varios clientes.

## Lo que necesitas antes
- n8n con credencial de GitHub (token con permiso `repo`).
- Que uses mensajes de commit tipo convencional: `feat: ...`, `fix: ...`, `chore: ...`, `docs: ...`. Si no los usas, empieza hoy: es la única disciplina que pide esta receta.
- Credencial de Gmail en n8n.
- Una hoja «Novedades» con columnas: fecha, version, resumen, detalle_html, enviado_a.
- Una hoja o etiqueta con los correos de tus clientes.

## Los nodos, en orden
1. **GitHub Trigger** — Events: `release`, repositorio el tuyo. n8n te da la URL del webhook y la registra sola en GitHub al activar el workflow.
2. **IF** — condición: `{{ $json.action }}` igual a `published`, para no dispararte con borradores.
3. **HTTP Request** («Comparar versiones») — GET `https://api.github.com/repos/{{ $json.repository.full_name }}/compare/{{ $json.release.target_commitish }}...{{ $json.release.tag_name }}` con credencial GitHub. Si prefieres algo más simple, usa `https://api.github.com/repos/OWNER/REPO/commits?since=FECHA_RELEASE_ANTERIOR`.
4. **Code** («Agrupar y traducir») — el corazón de la receta.
```javascript
const commits = $input.first().json.commits || [];
const grupos = { novedades: [], arreglos: [], interno: [] };
for (const c of commits) {
  const linea = c.commit.message.split('\n')[0];
  const m = linea.match(/^(\w+)(\(.+\))?:\s*(.+)$/);
  if (!m) { grupos.interno.push(linea); continue; }
  const tipo = m[1].toLowerCase();
  let texto = m[3].charAt(0).toUpperCase() + m[3].slice(1);
  if (tipo === 'feat') grupos.novedades.push(texto);
  else if (tipo === 'fix') grupos.arreglos.push('Corregido: ' + texto.toLowerCase());
  else grupos.interno.push(texto);
}
let html = '';
if (grupos.novedades.length) html += '<h3>Novedades</h3><ul>' + grupos.novedades.map(t => '<li>' + t + '</li>').join('') + '</ul>';
if (grupos.arreglos.length) html += '<h3>Arreglos</h3><ul>' + grupos.arreglos.map(t => '<li>' + t + '</li>').join('') + '</ul>';
if (grupos.interno.length) html += '<p><small>Y ' + grupos.interno.length + ' mejoras internas de rendimiento y mantenimiento.</small></p>';
return [{ json: { html, total: commits.length, novedades: grupos.novedades.length } }];
```
5. **Gmail** («Borrador para ti») — Operation: Send, To tu propio correo, Subject `Revisar novedades {{ $('GitHub Trigger').item.json.release.tag_name }}`, cuerpo el HTML generado más una línea: «Si está bien, responde OK». Así revisas antes de mandarlo a clientes.
6. **Wait** — modo «On Webhook Call» con «Resume» por URL: n8n genera un enlace de reanudación que puedes incluir en ese correo como botón «Aprobar y enviar». Al pulsarlo, el flujo continúa.
7. **Google Sheets** («Clientes») — Operation: Get Row(s) de tu hoja de suscriptores, filtrando por columna `activo` igual a `si`.
8. **Gmail** («Envío a clientes») — Send, To `{{ $json.email }}`, Subject `Novedades de la versión {{ $('GitHub Trigger').item.json.release.tag_name }}`, cuerpo `{{ $('Agrupar y traducir').first().json.html }}`. Marca «BCC» si prefieres un solo envío y no uno por cliente.
9. **Google Sheets** («Guardar novedad») — Append en la hoja «Novedades» con fecha, versión, número de novedades y el HTML.

## Cómo probarla
Crea una release de prueba con la etiqueta `v0.0.1-test` en un repositorio de juguete con tres commits (`feat:`, `fix:`, `chore:`). Debes recibir el correo de revisión con los tres agrupados. Pulsa el botón de aprobación y comprueba que solo te llega a ti si la hoja de clientes está vacía o tiene únicamente tu correo.

## Qué puede salir mal
- **Commits sin prefijo**: caen todos en «interno» y el correo queda vacío de novedades. Se arregla escribiendo bien los mensajes o añadiendo palabras clave al regex.
- **El webhook no llega**: si tu n8n está en local, GitHub no puede alcanzarlo. Usa el túnel de n8n (`n8n start --tunnel`) solo para pruebas, y un dominio con HTTPS en producción.
- **Correos marcados como spam**: enviar a 200 clientes desde Gmail personal es mala idea y además el límite es de 500 al día. Si tienes lista grande, sustituye el nodo Gmail por un **HTTP Request** a Brevo o Mailjet, que tienen plan gratuito con dominio verificado.
- **La comparación de versiones falla** si la release apunta a un commit y no a una rama: usa entonces la variante por fechas.

## Cuánto cuesta
Gratis con Gmail hasta 500 correos diarios. Brevo regala 300 correos al día si te quedas corto. n8n y GitHub, sin coste.
