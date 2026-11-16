# Primera revisión del Pull Request hecha por IA

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

- Revisión automática de código como servicio para desarrolladores en solitario.
- Segunda revisión de PR para agencias que entregan código a clientes.
- Configuración de revisión asistida para equipos pequeños sin proceso formal.

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
1) **Webhook**: POST, path `revisa-pr`. En el repo: Settings > Webhooks, evento «Pull requests». Protégelo: configura un *Secret* en el webhook de GitHub, valida la cabecera `X-Hub-Signature-256` en un nodo Code con ese secreto leído de una variable de entorno y descarta entregas repetidas por `X-GitHub-Delivery`. Ese Code se llama exactamente «Validar firma» (el nodo del paso 4 lo cita), va justo después del Webhook (modo Run Once for All Items) y devuelve repo y pr ya comprobados; si el aviso no es de un Pull request o la entrega está repetida no devuelve nada y el flujo se para, y si la firma no es válida falla. En el Webhook activa la opción de recibir el cuerpo en bruto (Raw Body), porque la firma se calcula sobre él, y en n8n define las variables de entorno `GITHUB_WEBHOOK_SECRET` (el Secret del webhook), `NODE_FUNCTION_ALLOW_BUILTIN=crypto` y `N8N_BLOCK_ENV_ACCESS_IN_NODE=false`.
2) **IF** (después de «Validar firma»; solo se conecta la salida true): String `{{ $json.body.action }}` «is equal to» `opened`. Si quieres revisar también las actualizaciones, añade una condición OR con `synchronize`.
3) **HTTP Request** (traer el diff): GET `https://api.github.com/repos/{{ $json.repo }}/pulls/{{ $json.pr }}` (repo y número ya comprobados por «Validar firma»; no uses la URL que trae el aviso), Header Auth `Authorization: Bearer TU_TOKEN` y además la cabecera `Accept: application/vnd.github.v3.diff`. En Options > Response, Format `Text`, y en Options desactiva que siga las redirecciones.
4) **Code** (modo Run Once for All Items), llámalo exactamente «Recortar diff» (el nodo del paso 6 lo cita) (recortar diffs enormes y quitar ruido):
```javascript
let diff = $json.data || '';
const bloques = diff.split(/^diff --git /m).filter(Boolean);
const utiles = bloques.filter(b => !/(package-lock\.json|yarn\.lock|\.min\.js|dist\/|\.svg)/.test(b.split('\n')[0]));
let texto = utiles.map(b => 'diff --git ' + b).join('');
if (texto.length > 60000) texto = texto.slice(0, 60000) + '\n[...diff recortado...]';
// repo y número salen de «Validar firma», que ya los ha comprobado
const v = $('Validar firma').first().json;
return [{ json: { diff: texto, pr: v.pr, repo: v.repo, titulo: v.body.pull_request.title } }];
```
5) **HTTP Request** (la IA): POST `https://api.anthropic.com/v1/messages`. Authentication: Generic Credential Type > Header Auth, con una credencial de n8n (Name `x-api-key`, Value tu clave de Anthropic); el nodo usa esa credencial. No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él. Cabeceras normales: `anthropic-version: 2023-06-01`, `content-type: application/json`. Body:
```json
{ "model": "claude-sonnet-5-5", "max_tokens": 1500, "messages": [{"role": "user", "content": "Eres un revisor de código senior. Revisa este diff del PR '{{ $json.titulo }}'. Responde en español de España y en Markdown, con tres apartados: 1) Bugs probables (con el archivo y la línea), 2) Seguridad (secretos, inyección, validación), 3) Simplificaciones. Máximo 8 puntos, ordenados de más grave a menos. Si no ves problemas, dilo en una línea y no te inventes nada.\n\n{{ $json.diff }}"}] }
```
6) **GitHub**: Resource `Issue`, Operation `Create Comment` (un PR es una issue para la API). Repository Owner (por nombre) `{{ $('Recortar diff').first().json.repo.split('/')[0] }}`, Repository Name `{{ $('Recortar diff').first().json.repo.split('/')[1] }}`, Issue Number `{{ $('Recortar diff').first().json.pr }}`, Body:
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

CÓDIGO DE LOS NODOS (el mismo que lleva el flujo importable)

Nodo Code «Validar firma»:
```js
// Valida que el aviso viene de GitHub (firma HMAC con tu secreto), descarta entregas repetidas
// y saca el repo y el número del PR ya comprobados (las URL se montan con host fijo, nunca con las del aviso)
const crypto = require('crypto');
// Opcional pero recomendado: pon aquí los repos que puede revisar este flujo, p. ej. new Set(['tu-usuario/tu-repo']). Vacío = cualquiera con la firma válida.
const REPOS_PERMITIDOS = new Set([]);
const secreto = $env.GITHUB_WEBHOOK_SECRET;
if (!secreto) throw new Error('Falta la variable de entorno GITHUB_WEBHOOK_SECRET (el mismo Secret que pusiste en el webhook de GitHub)');
const cab = $input.first().json.headers || {};
const crudo = await this.helpers.getBinaryDataBuffer(0, 'data');
const esperado = Buffer.from('sha256=' + crypto.createHmac('sha256', secreto).update(crudo).digest('hex'));
const recibido = Buffer.from(String(cab['x-hub-signature-256'] || ''));
if (esperado.length !== recibido.length || !crypto.timingSafeEqual(esperado, recibido)) throw new Error('Firma X-Hub-Signature-256 no válida: entrega descartada');
const body = JSON.parse(crudo.toString('utf8'));
if (!body.pull_request) return []; // otro evento (p. ej. el ping de GitHub): nada que revisar
const repo = body.repository && body.repository.full_name;
const pr = body.pull_request.number;
if (typeof repo !== 'string' || !/^[A-Za-z0-9_.-]+\/[A-Za-z0-9_.-]+$/.test(repo) || repo.split('/').some(p => p === '.' || p === '..')) throw new Error('repository.full_name no válido: entrega descartada sin llamar a GitHub');
if (!Number.isInteger(pr) || pr <= 0) throw new Error('pull_request.number no válido: entrega descartada sin llamar a GitHub');
if (REPOS_PERMITIDOS.size && !REPOS_PERMITIDOS.has(repo)) throw new Error('El repo ' + repo + ' no está en REPOS_PERMITIDOS: entrega descartada');
const entrega = cab['x-github-delivery'];
const st = $getWorkflowStaticData('global');
st.entregas = st.entregas || [];
if (entrega && st.entregas.includes(entrega)) return []; // entrega repetida
if (entrega) st.entregas = [...st.entregas, entrega].slice(-200);
return [{ json: { body, entrega, repo, pr } }];
```
