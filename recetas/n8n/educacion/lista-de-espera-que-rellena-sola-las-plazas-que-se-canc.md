# Lista de espera que rellena sola las plazas que se canc…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Cuando alguien cancela una clase o un taller, avisa por orden a los de la lista de espera y da la plaza al primero que responda, cerrando el hueco en minutos.

## Qué es y qué hace

Cuando alguien cancela, un formulario dispara n8n, que toma la lista de espera de ese taller por antigüedad y envía un correo con un enlace de aceptación válido 45 minutos. Si no responde, pasa al siguiente. El que acepta queda inscrito, se añade al evento de Google Calendar y se cierra la plaza. Entran cancelaciones y salen correos e inscripciones en Airtable, para talleres y tutorías con aforo limitado.

## Cómo usarla

1. Crea las tablas de sesiones y lista de espera en Airtable
2. Conecta Gmail y Calendar en n8n
3. Prueba el flujo con dos personas de prueba
4. Revisa los tiempos de caducidad del enlace

## Cuándo usarla

Úsalo si llenas talleres, clases presenciales o tutorías con aforo limitado y las cancelaciones de última hora te dejan sillas vacías que ya estaban pagadas.

## Cómo ganar dinero con ella

Rellenar 4 plazas al mes de 40 euros son 160 euros recuperados sin mover un dedo, y la lista de espera deja de ser una hoja muerta.

- Montaje de lista de espera automática para academias y talleres con aforo limitado, con prueba incluida.
- Gestión mensual de cancelaciones y reubicación de plazas para centros de formación, por cuota.
- Plantilla de lista de espera vendida a tutores y profesores que dan talleres presenciales.

**Precio orientativo:** 200–400 € por centro. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un formulario de cancelación dispara el flujo. Coge la lista de espera de ese taller ordenada por antigüedad, manda un email al primero con un enlace de aceptación válido 45 minutos y, si no contesta, pasa al siguiente. El que acepta queda inscrito, se le añade al evento del calendario y la plaza se cierra.

## Lo que necesitas antes
- n8n instalado y accesible desde internet (el Webhook lo necesita: con n8n Cloud ya lo es; auto-alojado, usa un dominio con HTTPS o un túnel).
- Airtable gratis con dos tablas: `Sesiones` (`nombre`, `fecha`, `plazas`, `ocupadas`) y `EsperaInscritos` (`email`, `nombre`, `sesion`, `estado` con opciones `espera`/`ofrecida`/`confirmada`/`caducada`, `fecha_alta`, `token`).
- Personal Access Token de Airtable: airtable.com/create/tokens, permisos `data.records:read` y `write` sobre tu base.
- Credencial de Gmail y de Google Calendar en n8n.

## Los nodos, en orden
1. **Webhook** (nodo 1 del flujo A) — método `POST`, path `cancelacion`. Aquí apuntas tu formulario de cancelación (Tally, Google Forms con Apps Script, o un enlace en el email de confirmación).
2. **Airtable** (`Update Record`) — marca al que cancela como `cancelada` y resta 1 a `ocupadas` de la sesión.
3. **Airtable** (`Search Records`) — tabla `EsperaInscritos`, fórmula `AND({sesion}='...', {estado}='espera')`, orden por `fecha_alta` ascendente, límite 1.
4. **Code** — genera un token aleatorio y la hora de caducidad.
5. **Airtable** (`Update Record`) — estado `ofrecida`, guarda `token` y `caduca`.
6. **Gmail** (`Send`) — asunto `Se ha liberado una plaza en {{ $json.sesion }}`, con el enlace `https://TU-N8N/webhook/aceptar?token={{ $json.token }}`.
7. **Wait** — `Resume: After Time Interval`, 45 minutos.
8. **Airtable** (`Get Record`) — relee el registro. **IF**: si el estado sigue en `ofrecida`, márcalo `caducada` y vuelve al paso 3 (conecta la salida al mismo nodo Search: n8n permite el bucle).
9. Flujo B: **Webhook** con path `aceptar`, método `GET`. **Airtable** (`Search Records`) por token. **IF** que comprueba estado `ofrecida` y `caduca` mayor que ahora. **Airtable** (`Update Record`) a `confirmada`. **Google Calendar** (`Update Event`) añadiendo al asistente. **Respond to Webhook** con un HTML de `Plaza confirmada`.

## El código del nodo Code
```javascript
const token = [...Array(24)].map(() => Math.random().toString(36)[2]).join('');
const caduca = new Date(Date.now() + 45 * 60000).toISOString();
return [{ json: { ...$json, token, caduca } }];
```

## Cómo probarla
- Crea una sesión de prueba, mete tres emails tuyos con alias (`tucorreo+1@gmail.com`, `+2`, `+3`) en la lista de espera.
- Lanza el webhook de cancelación con Postman o con `curl -X POST https://TU-N8N/webhook-test/cancelacion -d '{"sesion":"Taller prueba"}' -H 'Content-Type: application/json'`.
- Comprueba que llega al `+1`. No hagas clic, baja el Wait a 2 minutos para la prueba y verifica que pasa al `+2`.

## Qué puede salir mal
- **Ejecuciones largas**: el nodo Wait mantiene viva la ejecución. En n8n auto-alojado, activa el modo `queue` o al menos no reinicies el contenedor con esperas en curso.
- **Doble aceptación**: dos personas con el enlace a la vez. El IF que comprueba `estado = ofrecida` lo evita, porque el segundo ya lo verá `confirmada`.
- **Enlace caducado**: devuelve una página clara diciendo que la plaza ya se ha dado, no un error feo.
- **Airtable gratis**: 1.000 registros por base. Archiva sesiones pasadas cada trimestre.

## Cuánto cuesta
- Airtable: gratis hasta 1.000 registros y 1.000 llamadas API al mes.
- Gmail y Calendar: gratis.
- n8n auto-alojado con dominio: 0-6 euros/mes de VPS.
