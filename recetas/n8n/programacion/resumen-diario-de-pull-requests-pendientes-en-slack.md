# Resumen diario de Pull Requests pendientes en Slack…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cada mañana recibes en Slack la lista de PRs abiertos de tus repos, ordenados por antigüedad y marcando cuáles llevan días parados esperando revisión.

## Qué es y qué hace

A una hora fija consulta todos los Pull Requests abiertos de los repositorios que indiques en GitHub, calcula los días que llevan abiertos y publica en un canal de Slack una lista ordenada, marcando en rojo los que superan 3 días sin revisar. Se monta con n8n, Make o Zapier y necesita un token de GitHub y un bot de Slack.

## Cómo usarla

1. Crea un token de GitHub de solo lectura
2. Crea una app de Slack con permiso de escritura
3. Invita al bot al canal
4. Fija la hora y los repositorios

## Cuándo usarla

Cuando trabajéis dos o más personas en el mismo repositorio y los Pull Requests se queden semanas abiertos sin que nadie los mire.

## Cómo ganar dinero con ella

Un PR parado 5 días es trabajo pagado sin entregar. Recuperar 2 horas semanales de coordinación son unas 100 € al mes. Todo con herramientas gratis.

- Seguimiento de revisiones de código para equipos de dos a cinco desarrolladores…
- Panel de PRs parados como servicio para agencias con varios repos de clientes…
- Configuración de flujo de revisión para proyectos freelance en equipo…

**Precio orientativo:** 60–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
A una hora fija consulta todos los Pull Requests abiertos de los repositorios que le digas, calcula cuántos días llevan abiertos y publica en un canal de Slack una lista ordenada, marcando en rojo los que llevan más de 3 días sin revisar.
Para equipos pequeños de desarrollo y agencias con varios repos de clientes donde nadie tiene la foto completa.
## Lo que necesitas antes
- Cuenta de GitHub y un Personal Access Token: github.com > Settings > Developer settings > Personal access tokens > Fine-grained tokens. Permisos de solo lectura sobre `Pull requests` y `Metadata` en los repos que te interesen.
- Workspace de Slack y una app propia: api.slack.com/apps > Create New App > From scratch. En OAuth & Permissions añade el scope `chat:write`, instala la app y copia el Bot User OAuth Token. Invita al bot al canal con `/invite @tu-bot`.
- n8n auto-alojado o Cloud.
## Los nodos, en orden
1) **Schedule Trigger**: modo `Cron`, expresión `0 9 * * 1-5` (9:00 de lunes a viernes). En Settings del workflow pon Timezone `Europe/Madrid`, si no te llegará a hora rara.
2) **Code** (lista de repos): devuelve un item por repositorio.
```javascript
return ['miempresa/web-cliente-a', 'miempresa/api-interna', 'miempresa/app-movil'].map(r => ({ json: { repo: r } }));
```
3) **HTTP Request**: método GET, URL `https://api.github.com/repos/{{ $json.repo }}/pulls?state=open&per_page=100`. Autenticación «Generic > Header Auth»: nombre `Authorization`, valor `Bearer TU_TOKEN`. Añade también la cabecera `Accept: application/vnd.github+json`. Activa «Split Into Items» en Options > Response para que cada PR sea un item.
4) **Code** (calcular días y filtrar borradores):
```javascript
const hoy = Date.now();
return $input.all()
  .filter(i => i.json.draft === false)
  .map(i => {
    const dias = Math.floor((hoy - new Date(i.json.created_at).getTime()) / 86400000);
    return { json: {
      titulo: i.json.title,
      url: i.json.html_url,
      autor: i.json.user.login,
      repo: i.json.base.repo.full_name,
      revisores: (i.json.requested_reviewers || []).map(r => r.login).join(', ') || 'nadie asignado',
      dias,
      alerta: dias >= 3 ? '🔴' : '🟢'
    }};
  })
  .sort((a, b) => b.json.dias - a.json.dias);
```
5) **IF**: comprueba que hay algo que contar. Number: valor 1 `{{ $items().length }}`, operación «larger», valor 2 `0`. Si no hay PRs, no publiques nada (nadie quiere un mensaje diario vacío).
6) **Slack**: Resource `Message`, Operation `Send`, canal `#desarrollo`, y en Text:
`*PRs abiertos ({{ $items().length }})*\n{{ $items().map(i => `${i.json.alerta} <${i.json.url}|${i.json.titulo}> · ${i.json.repo} · ${i.json.dias}d · rev: ${i.json.revisores}`).join('\n') }}`
## Cómo probarla
- Ejecuta el workflow a mano con «Test workflow» y mira el JSON del último Code antes de conectar Slack.
- Abre un PR de prueba en un repo y comprueba que aparece; ciérralo y comprueba que desaparece al día siguiente.
- Cambia temporalmente el cron a `*/5 * * * *` para verlo en vivo y luego devuélvelo a las 9:00.
## Qué puede salir mal
- **Límite de la API de GitHub**: 5.000 peticiones/hora con token. Con 20 repos y una ejecución diaria ni te acercas. Si añades muchos más, mete un nodo **Split In Batches** de 10 en 10 con un **Wait** de 2 segundos.
- **Repos privados que no aparecen**: el token fine-grained solo ve los repos que le marcaste; revísalos uno a uno.
- **Hora equivocada**: n8n usa UTC por defecto. Fija la zona horaria en Settings del workflow, no solo del servidor.
- **Mensaje demasiado largo**: Slack corta a 40.000 caracteres. Si tienes más de 50 PRs, filtra por `dias >= 2` en el Code.
## Cuánto cuesta
- GitHub: gratis, la API está incluida en cualquier plan.
- Slack: gratis. En el plan free el historial es de 90 días, suficiente.
- n8n auto-alojado: 0 €; en un VPS compartido que ya tengas, coste marginal cero.
