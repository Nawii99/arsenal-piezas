# Cazador de tests inestables (flaky)

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Analiza el historial de tu integración continua para encontrar los tests que fallan y pasan sin que cambie el código, y te da el ranking de los peores.

## Qué es y qué hace

Consulta las ejecuciones de GitHub Actions de los últimos siete días con la API, detecta el mismo commit que ha fallado y luego ha pasado, extrae de los logs los nombres de los tests fallidos y genera un ranking semanal en una hoja. Entrada: token de solo lectura de Actions y el repositorio. Salida: tabla con test, veces y workflows afectados, más un aviso a Slack o Gmail. Se monta en n8n y sirve de base para un script en Claude Code.

## Cómo usarla

1. Crea el token de Actions
2. Crea la hoja Flaky
3. Ajusta el patrón de nombres de test en los logs
4. Revisa el ranking con el equipo cada viernes

## Cuándo usarla

Cuando tu equipo ya ha cogido la costumbre de relanzar el CI «porque a veces falla» y nadie sabe cuáles son los culpables.

## Cómo ganar dinero con ella

Un test inestable quema minutos de CI y confianza; el ranking te dice cuáles arreglar primero en vez de refactorizar a ciegas.

- Diagnóstico de CI para equipos de desarrollo que pierden tiempo relanzando pipelines.
- Informe semanal de salud de tests para startups con una suite que ya nadie se fía.
- Limpieza guiada de tests inestables: ranking, arreglo priorizado y seguimiento mensual.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

### Qué hace y para quién
Recorre las ejecuciones recientes de tus workflows de GitHub Actions, detecta los casos en que el mismo commit ha fallado y luego ha pasado (o los reintentos), extrae de los logs los nombres de los tests fallidos y monta un ranking semanal.
Para equipos de dos a diez desarrolladores con una suite de tests que ya no se fía nadie.

### Lo que necesitas antes
- Repo con GitHub Actions ejecutando tests.
- Token fine-grained con `Actions: Read-only` y `Contents: Read-only`.
- n8n.
- Hoja «Flaky» con columnas: `semana`, `test`, `veces`, `workflows`.
- Webhook de Slack o Gmail.

### Los nodos, en orden
1. **Schedule Trigger** — `Every Week`, Day `Friday`, hora `16`, timezone `Europe/Madrid`.
2. **HTTP Request** (nombre: «Ejecuciones») — `GET https://api.github.com/repos/USUARIO/REPO/actions/runs?per_page=100&created=>{{ $now.minus(7,'days').toFormat('yyyy-MM-dd') }}`, Header Auth con el token.
3. **Code** (nombre: «Detectar sospechosos») — busca commits con más de un intento y resultados distintos.
4. **Split In Batches** — Batch Size `5`, para no saturar la API de logs.
5. **HTTP Request** (nombre: «Trabajos del run») — `GET https://api.github.com/repos/USUARIO/REPO/actions/runs/{{ $json.run_id }}/jobs`.
6. **HTTP Request** (nombre: «Logs del job») — `GET https://api.github.com/repos/USUARIO/REPO/actions/jobs/{{ $json.job_id }}/logs`, Response Format `String`. Settings: `Continue On Fail` (los logs caducan a los 90 días).
7. **Code** (nombre: «Extraer tests») — saca los nombres de los tests fallidos del texto del log.
8. **Code** (nombre: «Ranking») — agrupa y ordena por número de apariciones.
9. **Google Sheets** — Operation `Append`, una fila por test y semana.
10. **Slack** — Operation `Send Message` con el top 5.

### El código del nodo «Detectar sospechosos»
```javascript
const runs = $input.first().json.workflow_runs || [];
const porCommit = {};
for (const r of runs) {
  const k = r.head_sha + '|' + r.name;
  (porCommit[k] = porCommit[k] || []).push({ run_id: r.id, conclusion: r.conclusion, intento: r.run_attempt, commit: r.head_sha, workflow: r.name });
}
const sospechosos = [];
for (const lista of Object.values(porCommit)) {
  const resultados = new Set(lista.map(l => l.conclusion));
  const hayReintento = lista.some(l => l.intento > 1);
  if ((resultados.has('failure') && resultados.has('success')) || hayReintento) {
    const fallido = lista.find(l => l.conclusion === 'failure');
    if (fallido) sospechosos.push({ json: fallido });
  }
}
return sospechosos;
```

### El código del nodo «Extraer tests»
```javascript
const log = String($input.first().json.data || '');
const nombres = new Set();
const patrones = [
  /●\s+(.+?)\n/g,                       // Jest
  /FAILED\s+([\w\/\.:]+::[\w:]+)/g,       // Pytest
  /\d\)\s+(.+?)\n/g,                     // Mocha
  /--- FAIL:\s+(\S+)/g                    // Go
];
for (const re of patrones) {
  let m;
  while ((m = re.exec(log)) !== null) {
    const n = m[1].trim();
    if (n.length > 3 && n.length < 160) nombres.add(n);
  }
}
return [...nombres].map(test => ({ json: { test, run_id: $('Split In Batches').first().json.run_id, workflow: $('Split In Batches').first().json.workflow } }));
```

### El código del nodo «Ranking»
```javascript
const items = $input.all().map(i => i.json);
const cuenta = {};
for (const it of items) {
  const k = it.test;
  cuenta[k] = cuenta[k] || { test: k, veces: 0, workflows: new Set() };
  cuenta[k].veces++;
  cuenta[k].workflows.add(it.workflow);
}
const ranking = Object.values(cuenta)
  .map(c => ({ test: c.test, veces: c.veces, workflows: [...c.workflows].join(', ') }))
  .sort((a, b) => b.veces - a.veces);
const semana = new Date().toISOString().slice(0, 10);
const texto = ranking.slice(0, 5).map((r, i) => `${i + 1}. ${r.test} — ${r.veces} caídas`).join('\n');
return ranking.map(r => ({ json: { ...r, semana, texto } }));
```

### Cómo probarla
- Ejecuta a mano sobre una semana en la que sepas que hubo relanzamientos; deberías ver al menos un sospechoso.
- Si la lista sale vacía, amplía el rango de `created=>` a 30 días para tener material.
- Comprueba un `run_id` a mano en la web de GitHub para confirmar que efectivamente hubo un segundo intento que pasó.

### Qué puede salir mal
- **Los logs caducan**: GitHub los borra a los 90 días (menos si tu retención está más baja); ejecuta semanalmente y guarda el histórico en Sheets.
- **Formato de log no reconocido**: añade tu patrón al array `patrones`; mira un log real y busca la línea exacta que marca el fallo.
- **Logs enormes**: algunos jobs devuelven megas de texto; si n8n se queda sin memoria, sube `NODE_OPTIONS=--max-old-space-size=2048` en el contenedor.
- **403 por límite de API**: 5.000 peticiones/hora sobran, pero si tienes muchos runs, sube el Batch Size a 3 y mete un `Wait` de 2 segundos.
- **Confundir flaky con roto**: un test que falla siempre no es inestable; el código solo cuenta los que tienen resultados distintos con el mismo commit.

### Cuánto cuesta
- 0 €: API de GitHub, Sheets y Slack en planes gratuitos.
- Lo que ahorras es minutos de GitHub Actions: por encima de los 2.000 gratuitos se pagan unos 0,008 $/minuto, y los relanzamientos por flaky son puro desperdicio.
