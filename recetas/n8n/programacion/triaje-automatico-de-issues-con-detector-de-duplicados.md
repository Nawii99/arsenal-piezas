# Triaje automático de issues con detector de duplicados…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cuando alguien abre una incidencia en GitHub, busca automáticamente si ya existe una parecida, la etiqueta por tipo y responde con un mensaje útil.

## Qué es y qué hace

Recibe por webhook de GitHub cada incidencia nueva, la compara con las últimas cien del repositorio por similitud de palabras y, si supera un umbral, comenta el enlace al posible duplicado y aplica la etiqueta por tipo (bug, mejora, duda). Entra el evento Issues en JSON y salen un comentario y etiquetas por API. Se monta en n8n y la misma lógica puede replicarse en Make o Zapier.

## Cómo usarla

1. Crea el webhook en GitHub
2. Configura un token con permiso Issues
3. Ajusta el umbral con incidencias reales
4. Prueba con una incidencia duplicada

## Cuándo usarla

Cuando tu repo o tu producto recibe suficientes issues como para que responder y clasificar te coma la mañana.

## Cómo ganar dinero con ella

Ahorra entre 10 y 20 minutos por incidencia repetida; con 30 issues al mes son varias horas recuperadas.

- Gestionar la bandeja de incidencias de proyectos open source de clientes por una cuota mensual.
- Implantar triaje de soporte técnico para software interno de una pyme con revisión semanal.
- Auditoría y configuración del flujo de etiquetas e incidencias para equipos de desarrollo pequeños.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

### Qué hace y para quién
Recibe el webhook de «issue abierta», compara el texto con las últimas cien incidencias del repo usando similitud de palabras, y si supera el umbral comenta el enlace al posible duplicado y pone la etiqueta correspondiente.
Para mantenedores de un proyecto o equipos de soporte técnico pequeños.

### Lo que necesitas antes
- Repo en GitHub y permiso de administración para crear el webhook.
- n8n accesible desde internet.
- Token fine-grained con `Issues: Read and write`.
- Etiquetas creadas en el repo: `bug`, `mejora`, `duda`, `posible-duplicado`.

### Los nodos, en orden
1. **Webhook** — Method `POST`, Path `issue-triage`. En GitHub: Settings → Webhooks → Add webhook, pega la Production URL, Content type `application/json`, marca solo el evento `Issues`, y pon un `Secret`.
2. **IF** (nombre: «¿Es apertura?») — String `{{ $json.body.action }}` `equals` `opened`.
3. **HTTP Request** (nombre: «Issues recientes») — `GET https://api.github.com/repos/{{ $json.body.repository.full_name }}/issues?state=all&per_page=100&sort=created&direction=desc`, Header Auth con tu token.
4. **Code** (nombre: «Comparar y clasificar») — calcula similitud y decide etiqueta.
5. **HTTP Request** (nombre: «Poner etiquetas») — `POST https://api.github.com/repos/{{$json.repo}}/issues/{{$json.numero}}/labels`, body `{{ JSON.stringify({ labels: $json.etiquetas }) }}`.
6. **IF** — Condition: Number `{{ $json.mejorParecido }}` `larger` `0.45`.
7. **HTTP Request** (nombre: «Comentar duplicado») — `POST https://api.github.com/repos/{{$json.repo}}/issues/{{$json.numero}}/comments`, body `{{ JSON.stringify({ body: $json.comentario }) }}`.
8. **Google Sheets** — Operation `Append`, histórico de triaje (fecha, número, etiquetas, parecido, duplicado_de) para medir si te está ayudando.

### El código del nodo «Comparar y clasificar»
```javascript
const evt = $('Webhook').first().json.body;
const nueva = ((evt.issue.title || '') + ' ' + (evt.issue.body || '')).toLowerCase();
const limpiar = t => t.toLowerCase().replace(/```[\s\S]*?```/g, ' ').replace(/[^a-záéíóúñ0-9 ]/g, ' ').split(/\s+/).filter(p => p.length > 3);
const vacias = new Set(['para','cuando','esto','pero','como','desde','hasta','error','issue','with','that','this','from']);
const conj = t => new Set(limpiar(t).filter(p => !vacias.has(p)));
const A = conj(nueva);
const jaccard = (a, b) => { const inter = [...a].filter(x => b.has(x)).length; const uni = new Set([...a, ...b]).size; return uni ? inter / uni : 0; };
let mejor = { score: 0, numero: null, titulo: '' };
for (const it of $input.all().map(i => i.json)) {
  if (it.number === evt.issue.number || it.pull_request) continue;
  const s = jaccard(A, conj((it.title || '') + ' ' + (it.body || '')));
  if (s > mejor.score) mejor = { score: s, numero: it.number, titulo: it.title };
}
const etiquetas = [];
if (/error|falla|crash|no funciona|excepci/.test(nueva)) etiquetas.push('bug');
else if (/sería genial|propongo|feature|mejora|podríais/.test(nueva)) etiquetas.push('mejora');
else etiquetas.push('duda');
if (mejor.score > 0.45) etiquetas.push('posible-duplicado');
const comentario = `Puede que esto ya esté recogido en #${mejor.numero} («${mejor.titulo}»). Si no es lo mismo, dilo y le quitamos la etiqueta. 🤖`;
return [{ json: { repo: evt.repository.full_name, numero: evt.issue.number, etiquetas, mejorParecido: Number(mejor.score.toFixed(2)), duplicadoDe: mejor.numero, comentario } }];
```

### Cómo probarla
- Abre una issue de prueba con un título calcado a otra existente: debe comentar y etiquetar.
- Abre otra completamente distinta: debe etiquetar por tipo pero sin comentar.
- En GitHub → Webhooks → Recent Deliveries puedes reenviar un evento con «Redeliver» sin abrir issues nuevas.

### Qué puede salir mal
- **Falsos duplicados**: sube el umbral de 0.45 a 0.6 durante la primera semana y revisa el histórico en Sheets.
- **Issues en inglés y español mezclados**: la lista de palabras vacías debe incluir ambos idiomas, como en el código.
- **Repos con miles de issues**: cien no bastan; añade un `HTTP Request` a `GET /search/issues?q=repo:...+{palabras clave}` en vez del listado.
- **Bucle infinito**: el bot comenta, y si tuvieras otro workflow escuchando comentarios podrías encadenar; filtra siempre por `action = opened`.
- **Firma del webhook sin verificar**: en el nodo Webhook activa `Header Auth` o valida la cabecera `X-Hub-Signature-256` en un Code antes de actuar.

### Cuánto cuesta
- 0 €: GitHub API gratuita, n8n auto-alojado gratuito.
- Si quisieras similitud semántica de verdad con embeddings de OpenAI, unos 0,50 €/mes con este volumen. La versión por palabras funciona sorprendentemente bien y no cuesta nada.
