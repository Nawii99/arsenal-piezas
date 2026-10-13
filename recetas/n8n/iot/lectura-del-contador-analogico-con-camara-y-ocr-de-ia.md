# Lectura del contador analógico con cámara y OCR de IA…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Una cámara ESP32 fotografía cada día tu contador de agua, luz o gas y una IA lee los números y los guarda, para que veas el consumo real sin depender de la compañía.

## Qué es y qué hace

Flujo de n8n que descarga cada día la foto de un contador tomada por una ESP32-CAM con un LED tenue y la envía a un modelo de visión que devuelve el número leído. Guarda la lectura, calcula el consumo del día y avisa si se dispara o si el OCR devuelve un valor raro. Entra la URL de la foto y la clave del modelo; sale el registro de consumo.

## Cómo usarla

1. Monta la ESP32-CAM con LED en el cuadro del contador
2. Configura la foto diaria por HTTP
3. Elige el modelo de lectura entre Claude, Codex, Gemini o una IA local
4. Revisa los primeros diez días a mano

## Cuándo usarla

Cuando tengas un contador que no se puede leer digitalmente (viejo, de la comunidad, de un pozo o de un submeter) y quieras control de consumo o repartir gastos.

## Cómo ganar dinero con ella

Detectar una fuga de agua o un consumo anómalo la misma semana en vez de en la factura del trimestre ahorra fácilmente 200-800 € por episodio.

- Control de consumo de agua o gas para comunidades de vecinos que reparten gastos comunes.
- Lectura automática de contadores para naves, pozos o submeters sin acceso digital.
- Monitorización de consumos para fincas y naves que quieren detectar fugas a tiempo.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Una ESP32-CAM con un LED enfocada al contador saca una foto cada día a la misma hora y la sirve por HTTP. El flujo la descarga, se la manda a un modelo de visión que devuelve el número leído, y lo apunta.
Compara con la lectura anterior, calcula el consumo del día y avisa si se dispara o si el OCR devuelve algo raro.

## Lo que necesitas antes
- Una ESP32-CAM (8-12 €) con ESPHome y el componente `esp32_camera` + `esp32_camera_web_server`, o el firmware CameraWebServer de ejemplo de Arduino. Sirve la imagen en `http://IP:8080/`.
- Un soporte impreso o de cartón y un LED blanco tenue; sin luz constante, el OCR falla.
- Wifi que llegue al cuarto de contadores. Si no llega, ESP32 con antena externa (2 €) o PLC.
- Clave de API de OpenAI (platform.openai.com → API keys) o de Google Gemini (aistudio.google.com → Get API key). Ambas tienen coste por uso, céntimos al mes con una foto diaria.
- n8n auto-alojado, Google Sheets y Telegram.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 7 * * *`, zona Europe/Madrid.
2. **HTTP Request** «foto» — GET a `http://192.168.1.80:8080/snapshot`. En Options → Response, pon Response Format «File» y nombre del campo binario `data`.
3. **HTTP Request** «OCR» — POST a `https://api.openai.com/v1/chat/completions`. Authentication: Generic → Header Auth, header `Authorization` con valor `Bearer TU_CLAVE`. Body JSON con el modelo de visión, la imagen en base64 y el prompt (ver abajo). Alternativa más cómoda: el nodo **OpenAI** de n8n, operación «Analyze Image», con el binario del paso anterior.
4. **Code** «validar lectura» — limpia la respuesta, comprueba que es un número plausible y calcula el consumo. Código abajo.
5. **IF** — `{{ $json.valida }}` igual a `true`.
6. **Google Sheets** — «Append» en hoja «contador»: fecha, lectura, consumo_dia, confianza.
7. **IF** — `{{ $json.consumo_dia }}` mayor que `{{ $json.umbral }}`.
8. **Telegram** — `💧 Consumo de ayer: {{ $json.consumo_dia }} unidades, muy por encima de tu media de {{ $json.media }}. Revisa si hay una fuga.`
9. Rama de lectura no válida: **Telegram** con la foto adjunta (Operation «Send Photo», binario `data`) y el texto `No he podido leer el contador, mira si se ha movido la cámara o falta luz.`

## El prompt para la IA (dentro del paso 3)
```text
Eres un lector de contadores. Devuelve SOLO un JSON con este formato exacto, sin texto alrededor:
{"lectura": 12345.678, "confianza": "alta|media|baja", "nota": ""}
Lee los dígitos de la ventana numérica del contador de izquierda a derecha. Los dígitos sobre fondo rojo o las esferas de aguja son decimales.
Si algún dígito está a medio girar, elige el inferior. Si no puedes leerlo con seguridad, pon confianza baja y explica por qué en nota.
```

## El trozo de código (nodo Code, paso 4)
```javascript
const UMBRAL_FACTOR = 2.5; // avisar si el día consume 2,5 veces la media
const bruto = $input.first().json;
const texto = bruto.message?.content || bruto.choices?.[0]?.message?.content || bruto.content || '';
let datos;
try {
  datos = JSON.parse(String(texto).replace(/```json|```/g, '').trim());
} catch (e) {
  return [{ json: { valida: false, motivo: 'la IA no ha devuelto JSON', crudo: texto } }];
}
const lectura = Number(datos.lectura);
const anterior = Number($('Google Sheets Anterior').first().json.lectura || 0);
const media = Number($('Google Sheets Anterior').first().json.media_consumo || 0);
const consumo = anterior ? lectura - anterior : 0;
const valida = !Number.isNaN(lectura) && lectura >= anterior && consumo < anterior * 0.1 && datos.confianza !== 'baja';
return [{ json: {
  valida,
  lectura,
  anterior,
  consumo_dia: Number(consumo.toFixed(3)),
  confianza: datos.confianza,
  media,
  umbral: media ? media * UMBRAL_FACTOR : 999999,
  nota: datos.nota || ''
}}];
```

## Cómo probarla
- Antes de automatizar nada, abre `http://IP:8080/` en el móvil y ajusta el enfoque girando la lente hasta que los números se lean claros. Es el 80% del trabajo.
- Manda tres fotos distintas a mano al modelo y comprueba que devuelve el JSON limpio.
- Apunta tú mismo el contador tres días y compara con lo que ha guardado el flujo. Si coincide, ya puedes fiarte.

## Qué puede salir mal
- **La lectura baja**: un contador nunca retrocede. La validación rechaza cualquier lectura menor que la anterior; suele ser un dígito mal leído.
- **Reflejos en el cristal**: pon el LED en ángulo, nunca de frente, o un difusor de papel vegetal.
- **La cámara se mueve**: fíjala con brida o silicona. Un giro de 5 grados y el OCR se vuelve loco.
- **Coste desbocado**: una foto al día son céntimos. Si te tienta hacer una cada 5 minutos, la factura de la API se multiplica por 288. No lo hagas.
- **Contadores de aguja pura**: si son esferas con manecillas, el acierto baja mucho. Ahí es mejor un sensor de pulsos magnético.

## Cuánto cuesta
- ESP32-CAM y soporte: 10-15 € una vez. n8n, Sheets y Telegram: 0 €.
- API de visión: alrededor de 0,003-0,01 € por imagen, así que 0,10-0,30 € al mes con una foto diaria.
- Gemini tiene una capa gratuita generosa que, a una foto al día, te deja el coste en 0 €.
