# Revisor de pull requests con IA que comenta el diff…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

En cuanto abres un pull request, una IA lee el diff completo y deja un comentario con riesgos, casos no contemplados y sugerencias concretas por fichero.

## Qué es y qué hace

Al abrir o actualizar un pull request, descarga su diff en texto plano y se lo pasa a un modelo de IA (Claude, Codex, Gemini o una IA local) con instrucciones de revisor exigente. Publica el resultado como comentario en el PR con riesgos, casos no contemplados y sugerencias por fichero. Sirve de primer filtro para programadores solos o equipos pequeños.

## Cómo usarla

1. Crear el token de GitHub con permisos de PR
2. Crear la clave del modelo de IA
3. Configurar el webhook de pull requests en n8n
4. Filtrar borradores y probar con un PR

## Cuándo usarla

Cuando programas solo o en pareja y nadie revisa tu código antes de fusionarlo, o quieres un primer filtro antes de la revisión humana.

## Cómo ganar dinero con ella

Un repaso previo cuesta unos céntimos y atrapa despistes que en producción costarían horas. Sustituye herramientas de revisión de 15-20 $/usuario/mes.

- Revisión automática de código para desarrolladores freelance sin compañero de revisión.
- Primer filtro de PR para equipos pequeños que quieren cribar errores obvios.
- Servicio de revisión previa de código vendido a startups como complemento a su equipo.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Se dispara al abrir o actualizar un PR, descarga el diff en texto plano, se lo pasa a un modelo con instrucciones de revisor exigente y publica el resultado como comentario en el PR.
Para el freelance sin compañero de revisión y para equipos que quieren cribar lo obvio antes de mirar el código.

## Lo que necesitas antes
- Token de GitHub con `Pull requests: Read and write` y `Contents: Read`.
- Clave de API de Anthropic.
- n8n con URL pública.

## Los nodos, en orden
**1. Webhook** — `POST`, Path `revisar-pr`, Respond `Immediately`. En GitHub: Settings > Webhooks, evento individual **Pull requests**. Valida la firma `X-Hub-Signature-256` con el Secret del webhook de GitHub y descarta entregas repetidas por `X-GitHub-Delivery`.
**2. IF** («¿Merece revisión?») — Condición 1: `{{ $json.body.action }}` `is one of` (usa el operador String > contains sobre `opened,reopened`) o simplemente igual a `opened`. Condición 2: `{{ $json.body.pull_request.draft }}` igual a `false` (Boolean). Condición 3: `{{ $json.body.pull_request.user.type }}` igual a `User`. Combinador `AND`.
**3. HTTP Request** («Bajar el diff») — `GET` `https://api.github.com/repos/{{ $json.body.repository.full_name }}/pulls/{{ $json.body.pull_request.number }}`, con Authentication: Generic > Header Auth con una credencial de n8n (Name `Authorization`, Value `Bearer TU_TOKEN`), headers `Accept: application/vnd.github.v3.diff`, `User-Agent: n8n`. Options > Response Format `Text`. No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él.
**4. Code** («Recortar y limpiar») — quita ficheros ruidosos y corta el tamaño.
**5. IF** («¿Hay algo que revisar?») — `{{ $json.vacio }}` igual a `false`.
**6. HTTP Request** («Revisar») — `POST` `https://api.anthropic.com/v1/messages` con el prompt de abajo, `max_tokens` 2000.
**7. HTTP Request** («Comentar en el PR») — `POST` `https://api.github.com/repos/{{ $('Webhook').item.json.body.repository.full_name }}/issues/{{ $('Webhook').item.json.body.pull_request.number }}/comments`, body `={{ JSON.stringify({ body: '🤖 **Revisión automática**\n\n' + $json.content[0].text }) }}`.

## El código del nodo 4
```javascript
const diff = $input.first().json.data || '';
const bloques = diff.split(/^diff --git /m).filter(Boolean);
const ignorar = /(package-lock\.json|yarn\.lock|pnpm-lock\.yaml|\.svg|\.png|\.jpg|dist\/|build\/|\.min\.js)/;
const utiles = bloques.filter(b => !ignorar.test(b.split('\n')[0]));
let texto = utiles.map(b => 'diff --git ' + b).join('');
if (texto.length > 60000) texto = texto.slice(0, 60000) + '\n\n[diff recortado por tamaño]';
return [{ json: { diff: texto, vacio: texto.trim().length < 50 } }];
```

## El cuerpo del nodo 6
```json
{ "model": "claude-sonnet-5-5", "max_tokens": 2000, "messages": [{"role":"user","content":"Eres un revisor de código veterano y directo. Revisa este diff y responde en español de España, tuteando, en Markdown. Estructura: 1) Resumen en dos frases de qué cambia. 2) Riesgos reales (errores, casos límite no cubiertos, fugas de datos, consultas sin índice, secretos en el código). 3) Sugerencias concretas citando fichero y línea aproximada. No comentes estilo ni formato. Si no encuentras nada grave, dilo claramente en una línea y no inventes problemas.\n\n{{ $json.diff }}"}] }
```

## Cómo probarla
1. Abre un PR de prueba en una rama con un cambio pequeño pero con un fallo evidente a propósito (una división sin comprobar el cero) y mira si lo pilla.
2. Abre un PR en borrador: no debe comentar nada.
3. Comprueba el gasto en console.anthropic.com tras dos o tres pruebas para calibrar.

## Qué puede salir mal
- **Diffs gigantes**: un PR de 5.000 líneas se come el contexto y el dinero. El recorte a 60.000 caracteres lo limita; si te pasa a menudo, añade un IF que descarte PR con más de 40 ficheros y comente «demasiado grande para revisar automáticamente».
- **Comentarios repetidos**: si añades el evento `synchronize`, comentará en cada push. O lo aceptas, o guardas el último SHA revisado en una hoja y comparas.
- **Secretos**: el diff se envía a un tercero. Si trabajas con código sensible bajo NDA, pide permiso al cliente o usa un modelo alojado por ti.
- **403 al comentar**: los tokens fine-grained necesitan explícitamente el permiso de escritura en Pull requests, no basta con Contents.

## Cuánto cuesta
GitHub gratis. Un PR mediano cuesta entre 0,02 y 0,10 € en IA: con 50 PR al mes, unos 3 €. n8n auto-alojado gratis.
