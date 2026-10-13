# Latido: avisa cuando una automatización deja de ejecuta…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Cada flujo tuyo manda una señal de vida al terminar. Si uno deja de dar señales, te avisa. Detecta los fallos silenciosos, que son los que más duelen.

## Qué es y qué hace

Cada automatización envía un latido corto al terminar bien. Un flujo vigilante revisa cada hora la hoja de latidos y, si algún flujo supera su tiempo máximo sin señal, avisa por correo o Telegram. Entrada: llamadas de latido y hoja latidos; salida: alerta de flujo parado. Se monta en n8n con Webhook y Google Sheets.

## Cómo usarla

1. Crea la hoja latidos con flujo, último latido y tiempo máximo
2. Añade el nodo de latido al final de cada flujo
3. Programa la revisión horaria
4. Prueba parando un flujo

## Cuándo usarla

Cuando ya tienes 3 o más automatizaciones funcionando y no te enteras si una se ha parado hasta que un cliente se queja o falta un pedido en la hoja.

## Cómo ganar dinero con ella

Un flujo parado dos semanas sin que nadie lo note cuesta pedidos, facturas o leads perdidos. Esto lo detecta en menos de una hora.

- Vigilancia de automatizaciones para un negocio que depende de pedidos y leads automáticos.
- Monitor de flujos para una agencia que gestiona automatizaciones de varios clientes.
- Mantenimiento de automatizaciones con informe de paradas para un autónomo.

**Precio orientativo:** 100–180 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada automatización que ya tienes montada envía un "latido" (una llamada corta) al terminar bien. Un vigilante revisa cada hora si algún flujo lleva demasiado tiempo sin dar señales y te avisa por correo o Telegram.
Es para quien ya depende de sus automatizaciones y necesita enterarse de que una se ha caído antes que sus clientes.

## Lo que necesitas antes
- n8n (gratis auto-alojado, o su plan Starter en la nube).
- Una cuenta de Google con Google Sheets y Gmail conectadas en n8n (Credenciales > Google OAuth2, se saca en console.cloud.google.com creando un proyecto y activando las API de Sheets y Gmail).
- Opcional: un bot de Telegram creado con @BotFather y tu chat_id (se saca escribiendo a @userinfobot).
- Una hoja de cálculo llamada `latidos` con las columnas: `flujo`, `ultimo_latido`, `max_minutos`, `estado`.

## Flujo A: el emisor de latidos (una línea en cada flujo que ya tengas)
1. **HTTP Request** al final de cada automatización existente. Método `POST`. URL: la del webhook del flujo B. En Body Parameters añade `flujo` con el nombre exacto del flujo (por ejemplo `pedidos-diarios`). Marca *Always Output Data* y en Settings pon *On Error: Continue* para que un fallo del latido no tumbe el flujo bueno.

## Flujo B: el receptor
1. **Webhook**. Método `POST`, ruta `latido`. Copia la Production URL.
2. **Google Sheets**. Operación `Append or Update Row`. Hoja `latidos`. Columna clave: `flujo`. Escribe `flujo` = `{{ $json.body.flujo }}` y `ultimo_latido` = `{{ $now.toISO() }}`.

## Flujo C: el vigilante
1. **Schedule Trigger**. Cada hora (`Interval: Hours`, valor 1).
2. **Google Sheets**. Operación `Get Row(s)`. Hoja `latidos`. Devuelve todas las filas.
3. **Code**. Modo `Run Once for All Items`. Pega esto:
```javascript
const ahora = new Date();
const alertas = [];
for (const item of $input.all()) {
  const f = item.json;
  if (!f.flujo) continue;
  const ultimo = new Date(f.ultimo_latido);
  const minutos = (ahora - ultimo) / 60000;
  if (minutos > Number(f.max_minutos || 1440)) {
    alertas.push({ json: { flujo: f.flujo, minutos: Math.round(minutos), limite: f.max_minutos } });
  }
}
return alertas;
```
4. **IF**. Condición: `{{ $items().length }}` *larger* `0`. (O simplemente deja que el nodo siguiente no reciba nada si no hay alertas: si el Code devuelve array vacío, el flujo se para solo.)
5. **Gmail**. Operación `Send`. Asunto: `Automatización parada: {{ $json.flujo }}`. Cuerpo: `Lleva {{ $json.minutos }} minutos sin dar señales (límite {{ $json.limite }}).`

## Cómo probarla
- Ejecuta a mano un flujo con latido y comprueba que la fila aparece en la hoja con fecha de hoy.
- Cambia a mano `ultimo_latido` de una fila poniendo una fecha de hace tres días y ejecuta el vigilante: debe llegarte el aviso.
- Devuelve la fecha buena y vuelve a ejecutar: no debe llegar nada.

## Qué puede salir mal
- **Zonas horarias**: guarda siempre en ISO con `$now.toISO()` y compara con `new Date()`. No mezcles formatos de fecha españoles (dd/mm) en esa columna o el cálculo dará NaN.
- **Falsos positivos de fin de semana**: si un flujo solo corre entre semana, pon `max_minutos` en 4320 (3 días) para ese flujo.
- **El vigilante también se puede caer**: dale a este flujo un latido externo gratuito con Healthchecks.io o UptimeRobot apuntando a un webhook suyo.
- **Duplicados en la hoja**: usa siempre `Append or Update` con columna clave `flujo`, nunca `Append`.

## Cuánto cuesta
n8n auto-alojado en un VPS de 5 €/mes o el plan gratuito de n8n Cloud. Google Sheets y Gmail, gratis. Telegram, gratis. Coste real: 0 € si ya tienes servidor.
