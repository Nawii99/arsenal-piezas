# Portero de despliegue: migraciones y resumen de cambios…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Cuando subes código a la rama principal, comprueba si hay migraciones de base sin aplicar y te manda el resumen de qué cambia antes de desplegar.

## Qué es y qué hace

Cuando haces push a main, compara los ficheros de migración del repositorio con las migraciones ya aplicadas en tu base de producción y te dice cuáles faltan. Además resume en lenguaje claro los commits de ese push. Entran el webhook de GitHub, un token y un usuario de solo lectura sobre la tabla de migraciones; sale un aviso con las pendientes y el resumen.

## Cómo usarla

1. Crea un token de GitHub con permiso repo
2. Da al usuario de solo lectura acceso a schema_migrations o equivalente
3. Añade el webhook push-main
4. Haz un push de prueba con una migración pendiente

## Cuándo usarla

Cuando despliegas tú solo o con un programador externo y alguna vez has subido código que pedía una columna que no existía todavía.

## Cómo ganar dinero con ella

Evita el despliegue que rompe producción y las dos horas de vuelta atrás. Además te deja el historial de cambios escrito sin esfuerzo.

- Control de migraciones para desarrolladores que despliegan sin equipo de operaciones…
- Aviso de cambios antes de desplegar para agencias con proyectos Rails o Laravel…
- Resúmenes de cambios para clientes que reciben entregas de código sin documentación…

**Precio orientativo:** 100–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
En cuanto haces push a `main`, compara la lista de ficheros de migración del repositorio con las migraciones ya aplicadas en tu base de producción y te dice cuáles faltan.
De paso te escribe en cristiano el resumen de los commits de ese push. Para quien despliega sin un equipo de operaciones detrás.

## Lo que necesitas antes
- Un repositorio en GitHub y permisos para crear webhooks (Settings > Webhooks > Add webhook).
- Un token clásico de GitHub con permiso `repo`: github.com > Settings > Developer settings > Personal access tokens.
- Que tu framework guarde las migraciones aplicadas en una tabla (`schema_migrations` en Rails, `_prisma_migrations` en Prisma, `migrations` en Laravel). Necesitas un usuario de solo lectura sobre ella.
- Un canal de Slack.

## Los nodos, en orden
1. **Webhook** — Method POST, Path `push-main`. Pega la URL en el webhook de GitHub eligiendo solo el evento «Pushes» y content type `application/json`.
2. **IF** — sigue solo si `{{ $json.body.ref }}` es igual a `refs/heads/main`.
3. **HTTP Request** — GET `https://api.github.com/repos/USUARIO/REPO/contents/db/migrations?ref=main` con cabecera `Authorization: Bearer TU_TOKEN` y `Accept: application/vnd.github+json`. Cambia la carpeta por la tuya.
4. **Postgres** — Execute Query: `SELECT version FROM schema_migrations;` (ajusta nombre de tabla y columna).
5. **Code** — cruza las dos listas y saca las pendientes y el resumen de commits.
6. **IF** — hay migraciones pendientes.
7. **Slack** — mensaje en rojo con la lista y la orden exacta que tienes que ejecutar.
8. **Slack** — en la otra rama, mensaje verde con el resumen de cambios del push.

## El código del cruce
```js
const ficheros = $('HTTP Request').all().map(i => i.json).flat();
const aplicadas = new Set($('Postgres').all().map(i => String(i.json.version)));
const enRepo = ficheros.filter(f => f.name && f.name.endsWith('.sql')).map(f => f.name);
const pendientes = enRepo.filter(n => !aplicadas.has(n.split('_')[0]));
const push = $('Webhook').first().json.body;
const commits = (push.commits || []).map(c => `- ${c.message.split('\n')[0]} (${c.author.name})`).join('\n');
return [{ json: {
  pendientes,
  hayPendientes: pendientes.length > 0,
  resumen: commits || 'sin commits',
  autor: push.pusher ? push.pusher.name : '?',
  orden: pendientes.length ? `npm run migrate  # aplica ${pendientes.length} migracion(es)` : ''
} }];
```

## Cómo probarla
- Crea un fichero de migración vacío en el repo y haz push: debe avisarte de que hay 1 pendiente.
- Aplícala en la base y haz otro push cualquiera: el aviso debe desaparecer.

## Qué puede salir mal
- **Cada framework nombra las migraciones a su manera.** El `split('_')[0]` funciona para nombres tipo `20260901_crea_pedidos.sql`. Ajústalo mirando qué guarda tu tabla exactamente.
- **Repos privados.** Necesitas el token sí o sí; sin él la API devuelve 404, no 403, y despista.
- **Webhook público.** Verifica la cabecera `x-hub-signature-256` con el secreto que pones en GitHub, igual que en la receta de la cola de webhooks.
- **Ramas de release.** Si despliegas desde otra rama, cambia el IF del paso 2.

## Cuánto cuesta
- GitHub: los webhooks y la API son gratis en repos públicos y privados del plan Free (5.000 peticiones por hora con token).
- El resto, gratis.
