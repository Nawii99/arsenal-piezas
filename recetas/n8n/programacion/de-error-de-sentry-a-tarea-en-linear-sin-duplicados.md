# De error de Sentry a tarea en Linear sin duplicados…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cuando Sentry detecta un error nuevo, crea automáticamente una tarea en Linear con el enlace y el stack trace, y si el error ya tiene tarea solo incrementa el contador en una hoja.

## Qué es y qué hace

Recibe por webhook las alertas de Sentry y, en una hoja de control de Google Sheets, comprueba si ese error ya tiene tarea en Linear. Solo crea la tarea la primera vez, con el enlace y el stack trace; las repeticiones suman al contador de frecuencia. Para equipos que usan Sentry y Linear y quieren que los errores entren en su tablero.

## Cómo usarla

1. Crear la API key de Linear y el teamId
2. Preparar la hoja errores
3. Configurar el webhook en Sentry
4. Probar con un error de prueba

## Cuándo usarla

Cuando tienes Sentry conectado pero los errores se quedan ahí y nunca llegan al tablero donde de verdad trabajas.

## Cómo ganar dinero con ella

Elimina el copiar y pegar de errores a tareas (2-3 minutos cada uno) y evita crear cinco tareas para el mismo fallo.

- Integración de errores con tablero de tareas para equipos de desarrollo pequeños.
- Reducción de duplicados en el seguimiento de bugs para proyectos con mucho tráfico.
- Configuración de Sentry y Linear que el técnico entrega como parte de la puesta en marcha.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recibe la alerta de Sentry por webhook, comprueba en una hoja de control si ese error ya tiene tarea, y solo crea una nueva en Linear la primera vez; las repeticiones suman a un contador de frecuencia.
Para equipos pequeños que usan Sentry (plan gratuito) y Linear y quieren que los errores entren solos en el flujo de trabajo.

## Lo que necesitas antes
- Cuenta de Sentry con un proyecto. En Settings > Alerts > Create Alert Rule, acción `Send a notification via an integration > Webhooks`, y en Settings > Integrations > WebHooks pones la URL de n8n.
- Clave de API de Linear: linear.app > Settings > API > Personal API keys. Apúntate también el `teamId`: se saca con una consulta GraphQL `{ teams { nodes { id name } } }` desde el propio nodo HTTP.
- Una hoja de Google Sheets `errores` con columnas: `huella`, `linear_id`, `veces`, `ultima_vez`.

## Los nodos, en orden
**1. Webhook** — `POST`, Path `sentry-error`, Respond `Immediately`. Verifica la firma `Sentry-Hook-Signature` con el Client Secret de la integración en un nodo Code.
**2. Code** («Sacar la huella») — construye un identificador estable del error.
**3. Google Sheets** («Buscar») — Operation `Get Row(s)`, Filters: columna `huella` igual a `={{ $json.huella }}`. En Settings del nodo activa `Always Output Data` para que un «no encontrado» siga adelante.
**4. IF** («¿Es nuevo?») — Condición: `{{ $json.linear_id }}` `is empty`.
**5. HTTP Request** («Crear en Linear») — rama verdadera. `POST` `https://api.linear.app/graphql`, Authentication: Generic Credential Type > Header Auth con una credencial (Name `Authorization`, Value tu API key de Linear, sin la palabra Bearer; va solo en la credencial, porque un flujo exportado se llevaría la clave) y header `Content-Type: application/json`, body JSON con la mutación de abajo.
**6. Google Sheets** («Registrar») — Operation `Append Row`: `huella`, `linear_id` = `={{ $json.data.issueCreate.issue.identifier }}`, `veces` = 1, `ultima_vez` = `={{ $now.toISO() }}`.
**7. Google Sheets** («Sumar repetición») — rama falsa. Operation `Update Row`, clave `huella`, `veces` = `={{ Number($json.veces) + 1 }}`, `ultima_vez` = `={{ $now.toISO() }}`.
**8. IF** («¿Muy repetido?») — si `veces` supera 20, un nodo `HTTP Request` que actualice la prioridad de la tarea en Linear a urgente.

## El código del nodo 2
```javascript
const b = $input.first().json.body || {};
const d = b.data && b.data.event ? b.data.event : b.event || b;
const titulo = d.title || d.metadata && d.metadata.value || 'Error sin título';
const culpable = d.culprit || (d.metadata && d.metadata.type) || 'desconocido';
const url = d.web_url || d.url || (b.url || '');
const proyecto = b.project_slug || d.project || 'proyecto';
const huella = (proyecto + '|' + culpable + '|' + titulo).slice(0, 180);
const entorno = d.environment || 'production';
return [{ json: { huella, titulo, culpable, url, proyecto, entorno } }];
```

## El cuerpo del nodo 5
```json
{ "query": "mutation CrearIssue($t: String!, $d: String!, $team: String!) { issueCreate(input: {title: $t, description: $d, teamId: $team}) { success issue { id identifier url } } }", "variables": { "t": "[Sentry] {{ $json.titulo }}", "d": "Error detectado en **{{ $json.proyecto }}** ({{ $json.entorno }}).\n\nOrigen: `{{ $json.culpable }}`\n\n[Ver en Sentry]({{ $json.url }})", "team": "TU_TEAM_ID" } }
```

## Cómo probarla
1. En Sentry, Settings > Integrations > WebHooks tiene un botón de prueba; úsalo y mira en n8n qué estructura llega exactamente (Sentry cambia el formato según el tipo de alerta: revisa el JSON crudo del Webhook y ajusta el Code).
2. Provoca un error real en tu app de pruebas y comprueba que aparece la tarea en Linear.
3. Provoca el mismo error otra vez: no debe crear tarea nueva, debe subir el contador a 2.

## Qué puede salir mal
- **La huella cambia sola**: si incluyes el mensaje completo con un ID variable dentro («usuario 4821 no encontrado»), cada error será nuevo. Usa `culprit` y `type`, no el mensaje entero.
- **Formato del webhook**: Sentry tiene varios (Legacy Webhooks, Internal Integrations). El Code de arriba cubre los dos más comunes con los `||`, pero verifica siempre con una entrega real.
- **Carrera de escritura**: si llegan dos errores idénticos en el mismo segundo, se pueden crear dos tareas. Con volumen alto, añade un nodo `Wait` aleatorio de 0-3 segundos o usa una base de datos con clave única en vez de Sheets.
- **Linear responde 200 con errores dentro**: GraphQL devuelve `errors` en el cuerpo con código 200. Añade un `IF` que compruebe `{{ $json.data }}` no vacío.

## Cuánto cuesta
Sentry tiene plan gratuito (5.000 errores/mes). Linear es gratis hasta 250 tareas activas. Google Sheets y n8n auto-alojado, gratis.
