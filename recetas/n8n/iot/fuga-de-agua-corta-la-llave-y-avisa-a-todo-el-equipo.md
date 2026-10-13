# Fuga de agua: corta la llave y avisa a todo el equipo…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Cuando un sensor detecta agua en el suelo, cierra la llave de paso automática al instante, avisa por Telegram a varias personas y deja un parte escrito por email.

## Qué es y qué hace

Cuando un detector de inundación en el suelo llama a n8n por webhook, n8n cierra la electroválvula de la llave general mediante un Shelly Plus 1, avisa por Telegram a varios teléfonos y envía por Gmail un parte para el seguro. Entrada: webhook del sensor; salida: corte de agua, avisos y parte. Se monta en n8n.

## Cómo usarla

1. Instala el detector y la válvula con un fontanero
2. Configura el webhook en el Shelly y los chat_id
3. Que lo revise un profesional

## Cuándo usarla

Cuando tengas local, oficina, vivienda de alquiler turístico o comunidad con riesgo de fuga en cocina, baño, sala de calderas o cuarto de contadores.

## Cómo ganar dinero con ella

Una fuga nocturna sin cortar son 3.000-15.000 € entre daños propios y del vecino de abajo, más la franquicia y la subida de la póliza.

- Corte automático de agua para un local con cocina o un piso turístico.
- Protección contra fugas para una comunidad con cuarto de contadores.
- Instalación de sensores y avisos para una oficina con riesgo de inundación.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un detector de inundación en el suelo llama a n8n en cuanto se moja; n8n cierra la electroválvula de la llave general, avisa por Telegram a todos los teléfonos de la lista y manda un correo con el parte para el seguro. Para locales, pisos turísticos y comunidades.

## Lo que necesitas antes
- Uno o varios **Shelly Flood** (unos 25 €) o **Shelly BLU H&T + sonda** en los puntos de riesgo: bajo el fregadero, junto a la caldera, en el cuarto de contadores.
- Una **válvula motorizada de corte** de 1/2" o 3/4" (30-70 €) gobernada por un **Shelly Plus 1**. La instala un fontanero en la entrada general.
- **n8n** accesible desde la red del local (los Shelly llaman por HTTP a la URL del webhook).
- Bot de **Telegram** y los `chat_id` de las 2-3 personas que deban enterarse.
- **Gmail** conectado en n8n.

## Los nodos, en orden
1. **Webhook** — GET, path `fuga`. En la app Shelly, en el detector: **Ajustes > Acciones > Alarma de inundación activa**, y pega la URL con `?zona=cocina`.
2. **HTTP Request** (llámalo *Cerrar llave*) — GET a `http://192.168.1.60/rpc/Switch.Set?id=0&on=true` (o `?turn=on` si es un Shelly de primera generación). En *Settings* activa **Retry On Fail**: 3 intentos, 2000 ms. Que la llave cierre es lo único que no puede fallar.
3. **Code** — prepara el mensaje y la lista de destinatarios:
```js
const zona = $('Webhook').item.json.query.zona || 'desconocida';
const hora = new Date().toLocaleString('es-ES', { timeZone: 'Europe/Madrid' });
const cerrada = JSON.stringify($json).includes('true');
const texto = '🚨 FUGA DE AGUA en ' + zona + ' a las ' + hora + '. Llave general: ' + (cerrada ? 'CERRADA automáticamente' : 'NO SE HA PODIDO CERRAR, ve corriendo') + '.';
const gente = ['111111111', '222222222', '333333333']; // chat_id de Telegram
return gente.map(chat_id => ({ json: { chat_id, texto, zona, hora, cerrada } }));
```
4. **Split In Batches** — tamaño **1**, para mandar los mensajes uno a uno sin chocar con el límite de Telegram (30 mensajes por segundo, pero mejor ir sobrado).
5. **Telegram** — *Send Message*, *Chat ID* = `{{ $json.chat_id }}`, texto = `{{ $json.texto }}`. Salida de vuelta al Split In Batches.
6. **Gmail** — al terminar el bucle, *Send*: asunto `Parte de incidencia: fuga de agua {{ $json.zona }} {{ $json.hora }}`, cuerpo con zona, hora, si se cerró la llave y una nota de "adjuntar fotos antes de secar". Mándatelo a ti y a tu correo del seguro si tienes uno.
7. **Respond to Webhook** — devuelve `ok`.

## Cómo probarla
- Prueba la llave sola: ejecuta solo el nodo *Cerrar llave* y comprueba en el grifo que no sale agua. Luego ábrela con `on=false`.
- Moja el detector con un dedo húmedo o media cucharada de agua en un plato. Debe sonar el pitido del Shelly, cerrarse la llave y llegar los tres Telegram en menos de 10 segundos.
- Repite la prueba **una vez al trimestre**. Una válvula que no se mueve en dos años se agarrota.

## Qué puede salir mal
- **La válvula se agarrota.** Añade un **Schedule Trigger** mensual que la cierre y la abra (a las 4 de la mañana) para ejercitarla.
- **n8n está caído justo ese día.** Configura también la acción directa del Shelly Flood al Shelly de la válvula (en la app: *Acciones > Activar dispositivo*), así el corte funciona sin n8n y n8n solo se ocupa de avisar.
- **Falsos positivos** por fregar el suelo. Coloca el detector sobre unos tacos de 2-3 mm y avisa a la limpieza.
- **No puedes volver a abrir la llave a distancia y no sabes por qué.** Deja siempre la llave manual accesible y señalizada.
- **El correo del seguro rebota.** Prueba el envío una vez a mano.

## Cuánto cuesta
Detector 20-30 €, válvula motorizada + Shelly 60-100 €, más la mano de obra del fontanero (unos 80-150 €). Software: **0 €/mes** con n8n auto-alojado, Telegram y Gmail.
