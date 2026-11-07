# Primera revisión del Pull Request hecha por IA…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cuando abres un Pull Request, una IA lee el diff y deja un comentario con posibles bugs, riesgos de seguridad y cosas a simplificar antes de que lo mire un humano.

## Qué es y qué hace

Al abrir un Pull Request, descarga el diff, lo envía a un modelo de IA con instrucciones de revisor y publica un comentario en el PR con posibles bugs, riesgos de seguridad y mejoras ordenadas por gravedad. No bloquea nada: es una segunda opinión. Se monta con n8n, Make o Zapier y necesita un token de GitHub y una clave de API de un modelo de IA.

## Cómo usarla

1. Crea el webhook en el repositorio
2. Crea el token de GitHub con permisos de Pull Requests
3. Añade la clave de Claude, Codex, Gemini o una IA local
4. Abre un PR de prueba y revisa el comentario

## Cuándo usarla

Cuando trabajes solo o en pareja y no tengas a nadie que te revise el código antes de subirlo a producción.

## Cómo ganar dinero con ella

Cazar un bug en el PR en vez de en producción ahorra horas de urgencia. Unos céntimos por PR frente a 20-30 €/mes de herramientas tipo CodeRabbit.

- Revisión automática de código como servicio para desarrolladores en solitario…
- Segunda revisión de PR para agencias que entregan código a clientes…
- Configuración de revisión asistida para equipos pequeños sin proceso formal…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Al abrir un Pull Request, descarga el diff, se lo pasa a un modelo de IA con instrucciones de revisor senior y publica un único comentario en el PR con los hallazgos ordenados por gravedad. No bloquea nada: es una segunda opinión rápida.
Para desarrolladores en solitario, equipos de dos y agencias que entregan código de clientes sin proceso de revisión.
## Lo que necesitas antes
- Token de GitHub con permisos de lectura de `Pull requests` y `Contents` y escritura en `Pull requests` (para comentar).
- Clave de API de Anthropic (console.anthropic.com) u OpenAI. Con 5 € de saldo tienes para cientos de PRs.
- n8n accesible desde internet para recibir el webhook.
## Los nodos, en orden
1) **Webhook**: POST, path `revisa-pr`. En el repo: Settings > Webhooks, evento «Pull requests». Protégelo: configura un *Secret* en el webhook de GitHub, valida la cabecera `X-Hub-Signature-256` en un nodo Code con ese secreto leído de una variable de entorno y descarta entregas repetidas por `X-GitHub-Delivery`.
2) **IF**: String `{{ $json.body.action }}` «is equal to» `opened`. Si quieres revisar también las actualizaciones, añade una condición OR con `synchronize`.
3) **HTTP Request** (traer el diff): GET `{{ $json.body.pull_request.url }}`, Header Auth `Authorization: Bearer TU_TOKEN` y además la cabecera `Accept: application/vnd.github.v3.diff`. En Options > Response, Format `Text`.
4) **Code** (recortar diffs enormes y quitar ruido):
```javascript
let diff = $json.data || '';
const bloques = diff.split(/^diff --git /m).filter(Boolean);
const utiles = bloques.filter(b => !/(package-lock\.json|yarn\.lock|\.min\.js|dist\/|\.svg)/.test(b.split('\n')[0]));
let texto = utiles.map(b => 'diff --git ' + b).join('');
if (texto.length > 60000) texto = texto.slice(0, 60000) + '\n[...diff recortado...]';
return [{ json: { diff: texto, pr: $('Webhook').first().json.body.number, repo: $('Webhook').first().json.body.repository.full_name, titulo: $('Webhook').first().json.body.pull_request.title } }];
```
5) **HTTP Request** (la IA): POST `https://api.anthropic.com/v1/messages`. Authentication: Generic Credential Type > Header Auth, con una credencial de n8n (Name `x-api-key`, Value tu clave de Anthropic); el nodo usa esa credencial. No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él. Cabeceras normales: `anthropic-version: 2023-06-01`, `content-type: application/json`. Body:
```json
{ "model": "claude-sonnet-5-5", "max_tokens": 1500, "messages": [{"role": "user", "content": "Eres un revisor de código senior. Revisa este diff del PR '{{ $json.titulo }}'. Responde en español de España y en Markdown, con tres apartados: 1) Bugs probables (con el archivo y la línea), 2) Seguridad (secretos, inyección, validación), 3) Simplificaciones. Máximo 8 puntos, ordenados de más grave a menos. Si no ves problemas, dilo en una línea y no te inventes nada.\n\n{{ $json.diff }}"}] }
```
6) **GitHub**: Resource `Issue`, Operation `Create Comment` (un PR es una issue para la API). Issue Number `{{ $('Code').item.json.pr }}`, Body:
`🤖 **Revisión automática**\n\n{{ $json.content[0].text }}\n\n_Generado automáticamente. No sustituye a una revisión humana._`
## Cómo probarla
- Abre un PR de prueba con un fallo evidente a propósito (una variable sin definir, una clave de API escrita en el código) y comprueba que lo detecta.
- Prueba con un PR de 1 línea y con otro de 40 archivos para ver que el recorte del Code funciona.
- Mira el coste real en el panel de la API tras 5 PRs y multiplica por tu ritmo mensual.
## Qué puede salir mal
- **PRs gigantes**: superas el contexto o pagas de más. El filtro de lockfiles y el corte a 60.000 caracteres son obligatorios.
- **Comentarios duplicados**: si activas `synchronize`, comentará en cada push. Limítalo a `opened` o añade un IF que solo comente si han pasado más de X commits.
- **Falsos positivos**: la IA a veces avisa de cosas correctas. Deja claro en el comentario que es orientativo para que nadie se lo tome como norma.
- **Fuga de código**: si el repo es de un cliente con confidencialidad, pide permiso antes de mandar el código a una API externa, o usa un modelo local con Ollama.
## Cuánto cuesta
- n8n auto-alojado: gratis. GitHub: gratis.
- Anthropic o OpenAI: entre 0,01 € y 0,08 € por PR según tamaño. Con 100 PRs al mes, unos 3 €.
- Alternativa comercial: CodeRabbit desde unos 22 €/desarrollador al mes.
