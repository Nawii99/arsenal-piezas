# Pruebas de humo de tu API cada 15 minutos sin falsos av…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Llama a los puntos críticos de tu API o tu web cada cuarto de hora, comprueba código y contenido, reintenta antes de alertar y solo avisa cuando cambia el estado.

## Qué es y qué hace

Flujo de n8n que lee de una hoja la lista de comprobaciones (URL, método, cabeceras, cuerpo, código esperado y texto que debe aparecer) y las ejecuta cada 15 minutos. Si una falla, espera 30 segundos y reintenta antes de avisar. Solo notifica por Telegram cuando el estado cambia, para no recibir mensajes repetidos durante una caída.

## Cómo usarla

1. Crea la hoja de chequeos
2. Crea el bot de Telegram
3. Define los criterios de éxito de cada endpoint
4. Activa el disparador de 15 minutos

## Cuándo usarla

Úsalo cuando tengas una API o una tienda en producción y quieras enterarte tú antes que el cliente de que algo devuelve 500 o de que el login dejó de funcionar.

## Cómo ganar dinero con ella

Sustituye a un servicio de monitorización de 20-50 euros al mes y reduce el tiempo de caída sin detectar de horas a minutos.

- Vigilancia de disponibilidad para tiendas online y APIs de clientes…
- Monitorización de login y checkout como servicio mensual…
- Alertas de caída para equipos de producto sin herramienta de pago…

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee de una hoja la lista de comprobaciones (URL, método, cuerpo, código esperado y un texto que debe aparecer), las ejecuta, y si algo falla espera 30 segundos y lo reintenta antes de dar la voz. Solo te escribe cuando el estado cambia: te avisa cuando se cae y cuando vuelve, no cada 15 minutos mientras está caído.
Para quien tiene servicios propios en producción y no quiere pagar una herramienta de monitorización ni recibir 40 mensajes por la misma avería.

## Lo que necesitas antes
- n8n auto-alojado (en la nube gratuita, ejecutar cada 15 minutos consume muchas ejecuciones del cupo mensual; auto-alojado es ilimitado).
- Una hoja «Chequeos» con columnas: activo, nombre, url, metodo, cabeceras_json, cuerpo_json, codigo_esperado, texto_esperado, estado_anterior.
- Bot de Telegram (token de @BotFather y tu chat_id).
- Si tu API pide autenticación, un usuario de solo lectura y un token de pruebas guardado como credencial en n8n, nunca en la hoja.

## Los nodos, en orden
1. **Schedule Trigger** — «Interval», cada 15 minutos.
2. **Google Sheets** — Get Row(s) de «Chequeos», con filtro columna `activo` = `si`.
3. **Split In Batches** — Batch Size 1.
4. **HTTP Request** («Llamada») — Method `{{ $json.metodo }}`, URL `{{ $json.url }}`, en Options «Timeout» 10000 ms, «Full Response» activado (necesitas el código de estado), «Ignore SSL Issues» desactivado. En Settings marca **Continue On Fail**, si no un 500 detiene el flujo. Cabeceras y cuerpo desde las columnas con expresiones `{{ JSON.parse($json.cabeceras_json || '{}') }}`.
5. **Code** («Evaluar»)
```javascript
const chequeo = $('Split In Batches').item.json;
const r = $input.first().json;
const codigo = r.statusCode || (r.error && r.error.status) || 0;
const cuerpo = typeof r.body === 'string' ? r.body : JSON.stringify(r.body || {});
let ok = String(codigo) === String(chequeo.codigo_esperado);
if (ok && chequeo.texto_esperado) ok = cuerpo.includes(chequeo.texto_esperado);
return [{ json: { nombre: chequeo.nombre, url: chequeo.url, codigo, ok, estado_anterior: chequeo.estado_anterior || 'ok', fila: chequeo.row_number } }];
```
6. **IF** («¿Falla?») — `{{ $json.ok }}` es falso.
7. **Wait** — 30 segundos (rama de fallo).
8. **HTTP Request** («Reintento») — copia exacta del nodo 4.
9. **Code** («Evaluar reintento») — mismo código del paso 5 apuntando al nodo de reintento.
10. **Switch** — tres salidas según comparación de `ok` y `estado_anterior`: «se ha caído» (ok falso y anterior ok), «sigue caído» (ok falso y anterior caido, no hace nada), «ha vuelto» (ok verdadero y anterior caido).
11. **Telegram** («Aviso caída») — Text `🔴 {{ $json.nombre }} no responde bien. Código {{ $json.codigo }}. URL {{ $json.url }}`.
12. **Telegram** («Aviso recuperación») — Text `🟢 {{ $json.nombre }} ha vuelto a funcionar`.
13. **Google Sheets** («Actualizar estado») — Operation: Update, «Row Number» `{{ $json.fila }}`, columna `estado_anterior` con `ok` o `caido`.
14. Conecta todas las salidas de vuelta al **Split In Batches** para pasar al siguiente chequeo.

## Cómo probarla
Añade un chequeo apuntando a `https://httpstat.us/500` con código esperado 200: en menos de un minuto debe llegarte el aviso rojo, y la hoja debe marcar `caido`. Cambia el código esperado a 500 y en la siguiente vuelta debe llegarte el verde de recuperación. Prueba también un chequeo con `texto_esperado` que no exista, para verificar que detecta páginas que devuelven 200 pero con error dentro.

## Qué puede salir mal
- **Avisos en cascada**: sin la columna `estado_anterior` recibirías un mensaje cada 15 minutos. Es la pieza clave de la receta, no la quites.
- **Tu propia red falla**: si el servidor de n8n pierde conexión, todo saldrá rojo. Añade un chequeo de control a `https://www.google.com`; si ese también falla, el Switch puede silenciar el resto.
- **Peticiones POST que crean datos**: usa siempre endpoints de solo lectura o un entorno de pruebas; una prueba de humo no debe generar pedidos reales.
- **Consumo de ejecuciones**: 96 ejecuciones diarias por 30 días son 2.880 al mes; con n8n Cloud gratuito te quedas sin cupo. Auto-alojado no tiene ese límite.

## Cuánto cuesta
Gratis con n8n auto-alojado en un VPS de 4-5 euros al mes, que además te sirve para el resto de recetas. Telegram y Sheets no cuestan nada. Un servicio equivalente tipo monitorización comercial ronda los 25 euros mensuales.
