# Filtro inteligente de errores de la app para no ahogart…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Recoge los fallos que reporta Sentry o Crashlytics, agrupa los repetidos, ignora el ruido conocido y solo te avisa cuando un error es nuevo o afecta a mucha gente.

## Qué es y qué hace

Receta de n8n que recibe los errores de tu app desde Sentry, comprueba si ya los conoce y cuántas veces han ocurrido hoy. Solo avisa en Slack y crea la incidencia en Linear cuando el error es nuevo o supera un umbral que tú fijas; los errores conocidos y tolerados se cuentan sin molestar. Entrada: webhook de Sentry y una hoja de errores ignorados. Salida: alertas filtradas e incidencias creadas.

## Cómo usarla

1. Conecta el webhook de Sentry
2. Define el umbral y los errores ignorados
3. Prueba con un error simulado y ajusta el filtro

## Cuándo usarla

Úsalo cuando tienes las alertas de errores desactivadas porque te llegaban cincuenta al día, o cuando un fallo que rompía el pago tardó una semana en detectarse.

## Cómo ganar dinero con ella

Evita que un fallo de checkout viva días sin que nadie lo vea. Y devuelve la utilidad a un canal de alertas que ya habías silenciado.

- Alertas filtradas para una app de reservas con pagos…
- Vigilancia de errores para una tienda con app móvil propia…
- Guardia técnica de bajo coste para apps de pequeñas empresas…

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Sentry te manda cada error a n8n. n8n mira si ese tipo de error ya lo conoce y cuántas veces ha pasado hoy. Si es nuevo, o si supera un umbral que tú pones, avisa en Slack y crea la incidencia en Linear.
Si es un error conocido y tolerado (por ejemplo, fallos de red de usuarios sin cobertura), lo cuenta pero no molesta a nadie.
Es para equipos pequeños que tienen app en producción y quieren dormir tranquilos.

## Lo que necesitas antes
n8n.
Cuenta de Sentry (plan gratuito con 5.000 errores al mes) con el SDK ya instalado en tu app. Si usas Firebase Crashlytics, la alternativa es exportar a BigQuery y consultar; con Sentry es mucho más directo.
Un token de Linear (Settings, API, Personal API key) o el gestor que uses.
Webhook de Slack.
Una hoja de Google Sheets «errores» con columnas: huella, primera_vez, veces_hoy, ignorar, fecha.

## Los nodos, en orden
1. «Webhook». Method POST, ruta /error-app. Copia la Production URL.
2. En Sentry: Settings del proyecto, Alerts, Create Alert Rule, condición «A new issue is created» o «An issue is seen more than X times», acción «Send a notification via webhook» apuntando a esa URL. También vale Integrations, WebHooks.
3. «Set» (extraer lo útil). Crea: titulo desde {{ $json.data.issue.title }}, cultura o plataforma, url desde {{ $json.data.issue.web_url }}, usuarios afectados y versión de la app. Los nombres exactos los ves en la primera ejecución.
4. «Code» (huella del error). Código completo:
```js
const j = $input.first().json;
const titulo = (j.titulo || '').trim();
const huella = titulo.toLowerCase().replace(/[0-9]/g, '').replace(/\s+/g, '-').slice(0, 80);
return [{ json: { ...j, huella } }];
```
5. «Google Sheets» (Lookup por columna huella).
6. «IF» número 1: ¿está marcado ignorar como TRUE? Si sí, solo «Google Sheets» (Update) sumando 1 a veces_hoy y fin.
7. «IF» número 2: ¿es nuevo (el Lookup vino vacío) o veces_hoy supera 20 o usuarios afectados supera 10? Si no, solo actualiza el contador y fin.
8. «Slack» (Send Message) al canal #alertas: «🐛 {{ $json.titulo }} · versión {{ $json.version }} · {{ $json.usuarios }} usuarios · {{ $json.url }}».
9. «Linear» (Create Issue) con el título, la descripción y prioridad alta si supera 50 usuarios. Añade un label «crash».
10. «Google Sheets» (Append or Update) guardando huella, primera_vez y contador.
11. Flujo aparte: «Schedule Trigger» cron 0 3 * * * más «Google Sheets» (Update) que pone veces_hoy a 0 en todas las filas cada madrugada.

## Cómo probarla
En Sentry, en la página de un issue, hay un botón para reenviar el webhook de prueba. Úsalo y comprueba que llega a n8n y que el Set extrae bien el título.
Prueba a marcar ignorar como TRUE en una huella concreta y reenvía: no debe llegar nada a Slack.

## Qué puede salir mal
Sentry manda formatos distintos según si el webhook es «legacy» o «internal integration». Mira siempre la salida real del Webhook antes de escribir el Set.
La huella basada en el título agrupa demasiado o demasiado poco. Si ves errores distintos mezclados, incluye también el nombre del fichero en la huella.
Si te llegan avalanchas de errores, mete un «Split In Batches» o Sheets te dará error de cuota: el límite de Google es 60 escrituras por minuto y usuario.
Cuidado con el reset a las 3:00: pon la zona horaria del workflow o se reiniciará a otra hora.

## Cuánto cuesta
n8n, Sheets y Slack: gratis. Sentry: 5.000 errores al mes gratis, luego desde 26 $. Linear: gratis hasta 250 incidencias.
