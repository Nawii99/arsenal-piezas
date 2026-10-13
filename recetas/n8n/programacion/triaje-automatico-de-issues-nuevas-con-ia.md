# Triaje automático de issues nuevas con IA…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cada vez que alguien abre una issue en tu repo, una IA la clasifica, le pone etiquetas, estima la prioridad y deja un primer comentario pidiendo lo que falte.

## Qué es y qué hace

Al abrirse una issue, un webhook de GitHub envía su título y cuerpo a un modelo de IA (Claude, Codex, Gemini o una IA local), que devuelve en JSON el tipo, la prioridad, el área y lo que falta. El flujo aplica etiquetas y publica un comentario pidiendo los datos que falten, como la versión o los pasos para reproducir. Para mantenedores de proyectos y equipos con repo de soporte.

## Cómo usarla

1. Crear el token de GitHub con permiso Issues
2. Crear las etiquetas en GitHub
3. Configurar el webhook de issues en n8n
4. Probar con una issue de prueba

## Cuándo usarla

Cuando recibes issues de usuarios o de compañeros mal escritas, sin versión ni pasos para reproducir, y pierdes el tiempo pidiendo datos.

## Cómo ganar dinero con ella

Ahorra entre 5 y 10 minutos por issue en clasificar y responder. Con 40 issues al mes son 5 horas. El coste en IA ronda los 2 €.

- Triaje de issues para proyectos abiertos con muchas peticiones de usuarios.
- Filtro de soporte para equipos internos que reciben reportes sin datos.
- Servicio de organización de repositorios que el consultor entrega a startups.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Al abrirse una issue, manda su título y cuerpo a un modelo que devuelve un JSON con tipo, prioridad, área y qué información falta; el flujo aplica las etiquetas y publica un comentario educado pidiendo lo que falte.
Para mantenedores de proyectos abiertos y para equipos internos con un repo de soporte.

## Lo que necesitas antes
- Token de GitHub con permisos `Issues: Read and write` sobre el repo.
- Clave de la API de Anthropic (console.anthropic.com).
- Las etiquetas creadas de antemano en GitHub (Issues > Labels): `bug`, `mejora`, `duda`, `p1`, `p2`, `p3`, `falta-info`. Si la etiqueta no existe, la API la crea al vuelo pero sin color ni sentido; mejor créalas tú.
- n8n con URL pública para recibir el webhook.

## Los nodos, en orden
**1. Webhook** — `POST`, Path `issue-nueva`, Respond `Immediately`. En GitHub, Settings > Webhooks, evento individual **Issues**.
**2. IF** («Solo issues abiertas por humanos») — Condición 1: `{{ $json.body.action }}` igual a `opened`. Condición 2: `{{ $json.body.issue.user.type }}` igual a `User`. Combinador `AND`.
**3. HTTP Request** («Clasificar») — `POST` `https://api.anthropic.com/v1/messages`, headers `x-api-key`, `anthropic-version: 2023-06-01`, `content-type: application/json`, body JSON con el prompt de abajo.
**4. Code** («Parsear respuesta») — extrae el JSON del texto devuelto.
**5. HTTP Request** («Poner etiquetas») — `POST` `https://api.github.com/repos/{{ $('Webhook').item.json.body.repository.full_name }}/issues/{{ $('Webhook').item.json.body.issue.number }}/labels`, Body JSON `={{ JSON.stringify({labels: $json.etiquetas}) }}`, Header Auth con el token.
**6. IF** («¿Falta información?») — Boolean `{{ $json.falta_info }}` igual a `true`.
**7. HTTP Request** («Comentar») — `POST` `https://api.github.com/repos/.../issues/{{ ... }}/comments`, body `={{ JSON.stringify({body: $json.comentario}) }}`.

## El cuerpo del nodo 3
```json
{ "model": "claude-sonnet-5-5", "max_tokens": 700, "messages": [{"role":"user","content":"Clasifica esta issue de GitHub. Responde SOLO un JSON con las claves: tipo (bug|mejora|duda), prioridad (p1|p2|p3), falta_info (true|false) y comentario (texto en español de España, tuteando, máximo 5 líneas, pidiendo amablemente lo que falte: versión, pasos para reproducir, capturas; si no falta nada, cadena vacía).\n\nTítulo: {{ $json.body.issue.title }}\n\nCuerpo: {{ $json.body.issue.body }}"}] }
```

## El código del nodo 4
```javascript
const texto = $input.first().json.content[0].text;
const bruto = texto.slice(texto.indexOf('{'), texto.lastIndexOf('}') + 1);
let d;
try { d = JSON.parse(bruto); } catch (e) { d = { tipo: 'duda', prioridad: 'p3', falta_info: false, comentario: '' }; }
const etiquetas = [d.tipo, d.prioridad];
if (d.falta_info) etiquetas.push('falta-info');
return [{ json: { etiquetas, falta_info: !!d.falta_info, comentario: d.comentario } }];
```

## Cómo probarla
1. Abre una issue de prueba mal escrita («no me funciona») y comprueba que le pone `bug`, `p3` y `falta-info` y deja el comentario.
2. Abre otra bien escrita, con versión y pasos, y comprueba que NO comenta.
3. Mira en GitHub > Webhooks > Recent Deliveries que la respuesta sea 200; si es 5xx, tu n8n no es accesible desde fuera.

## Qué puede salir mal
- **Bucle infinito**: si tu bot comentara y eso disparara otro evento, entrarías en bucle. Aquí no pasa porque solo escuchamos `action = opened`, pero no añadas el evento «Issue comments».
- **La IA devuelve texto alrededor del JSON**: el recorte entre llaves del Code lo soluciona, y el `try/catch` evita que un fallo tumbe la ejecución.
- **Issues de bots** (Dependabot, Renovate): filtradas con `user.type = User`.
- **Idioma**: si recibes issues en inglés, añade al prompt «responde en el mismo idioma de la issue».
- **Coste descontrolado** si te llega una avalancha: pon `max_tokens` bajo y, si quieres, un nodo `Code` que corte cuerpos de más de 4.000 caracteres.

## Cuánto cuesta
GitHub gratis. La IA, unos 0,005 € por issue: con 400 issues al mes no llegas a 2 €. n8n auto-alojado gratis.
