# Fotos de producto con IA en lote desde una hoja…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Escribes en una hoja el producto y el escenario, y el flujo genera las imágenes con IA, las guarda en Drive y te deja el enlace en la misma fila.

## Qué es y qué hace

Rellenas en una hoja el producto, el escenario, la luz y el formato de cada imagen. n8n monta el prompt completo con lenguaje fotográfico, lo manda a un generador de imagen por API (Replicate), espera el resultado, guarda el PNG en Drive y deja el enlace en la misma fila. Entran filas de encargo y salen imágenes de producto y de ambiente para tiendas, catálogos y anuncios.

## Cómo usarla

1. Crea la hoja con las columnas del encargo
2. Consigue el token de Replicate
3. Conecta Sheets y Drive en n8n
4. Revisa las primeras imágenes antes de lanzar el lote

## Cuándo usarla

Úsalo cuando necesitas 30 imágenes de producto o de ambiente para una tienda, un catálogo o unos anuncios, y contratar sesión no sale a cuenta.

## Cómo ganar dinero con ella

Una sesión de estudio son 300-800 €. Aquí cada imagen cuesta entre 0,03 y 0,08 € y la tienes en dos minutos.

- Producción de imágenes de producto con IA para tiendas online pequeñas, cobrada por lote de veinte o treinta imágenes.
- Packs mensuales de ambientes para marcas que necesitan contenido constante, por cuota.
- Plantilla de generación en lote vendida a agencias que hacen catálogos para clientes pequeños.

**Precio orientativo:** 100–300 € por lote de imágenes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Rellenas una hoja con una fila por imagen: producto, escenario, luz, formato. El flujo monta el prompt completo con lenguaje fotográfico de verdad, lo manda a un modelo de imagen, espera a que termine, guarda el PNG en Drive y pega el enlace en la fila.
Para tiendas online, marcas pequeñas y agencias que necesitan volumen de imágenes coherentes sin montar un set.

## Lo que necesitas antes
- Cuenta en replicate.com. En Account > API tokens copia tu token. Carga 10 $ de saldo.
- Hoja `Generador Imagenes` con columnas: `producto`, `escenario`, `luz`, `formato`, `estado`, `prompt_final`, `enlace`, `coste`.
- Carpeta de Drive `IMAGENES-IA` con su ID apuntado.
- En n8n: credenciales `Google Sheets OAuth2` y `Google Drive OAuth2`.

## Los nodos, en orden
1. **Schedule Trigger** — cada 10 minutos, o usa un **Manual Trigger** si prefieres lanzarlo tú.
2. **Google Sheets** — `Get Row(s)`, filtro `estado` igual a `PENDIENTE`.
3. **Split In Batches** — Batch Size: 1. Importante: si mandas todo de golpe, Replicate te devuelve errores de cola.
4. **Code** (`Construir prompt`) — traduce lo que has escrito en lenguaje llano a un prompt fotográfico. Código abajo.
5. **HTTP Request** (`Lanzar generación`) — Method `POST`. URL: `https://api.replicate.com/v1/predictions`. Headers: `Authorization` = `Bearer TU_TOKEN`, `Content-Type` = `application/json`, y añade `Prefer` = `wait` para que espere hasta 60 segundos y te ahorres el sondeo. Body JSON abajo.
6. **IF** — comprueba `{{ $json.status }}` igual a `succeeded`. Si no, ve al paso 7.
7. **Wait** — 20 segundos, y luego un **HTTP Request** `GET` a `https://api.replicate.com/v1/predictions/{{ $json.id }}` que vuelve al IF. Es el bucle de espera para las lentas.
8. **HTTP Request** (`Descargar imagen`) — Method `GET`, URL `{{ $json.output[0] }}`, Response Format `File`, campo `data`.
9. **Google Drive** — Operation `Upload`, carpeta `IMAGENES-IA`, File Name `{{ $('Construir prompt').item.json.nombre_archivo }}.png`.
10. **Google Sheets** — `Update Row`: `estado` a `LISTA`, `enlace` a `{{ $json.webViewLink }}`, `prompt_final` al prompt que se usó.

## El código del nodo Construir prompt
```javascript
const d = $json;
const luces = {
  'estudio': 'softbox key light at 45 degrees, white fill card, seamless background, crisp product shadow',
  'natural': 'soft window light from the left, warm afternoon sun, gentle falloff, natural shadows',
  'dramatica': 'single hard rim light from behind, deep shadows, dark moody background, chiaroscuro',
  'plana': 'even flat lighting, no visible shadows, e-commerce white background'
};
const formatos = { 'cuadrado': '1:1', 'vertical': '4:5', 'historia': '9:16', 'horizontal': '3:2' };
const luz = luces[String(d.luz).toLowerCase()] || luces['estudio'];
const ratio = formatos[String(d.formato).toLowerCase()] || '1:1';
const prompt = `Professional commercial product photograph of ${d.producto}, ${d.escenario}, ${luz}, shot on 85mm lens at f/5.6, shallow depth of field, ultra sharp on the product, high-end advertising quality, photorealistic, no text, no watermark`;
const nombre = `${d.producto}-${d.escenario}`.toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g,'').replace(/[^a-z0-9]+/g,'-').slice(0,60);
return { json: { ...d, prompt, ratio, nombre_archivo: `${nombre}-${Date.now()}` } };
```

## El cuerpo JSON del HTTP Request
```json
{
  "version": "black-forest-labs/flux-1.1-pro",
  "input": {
    "prompt": "={{ $json.prompt }}",
    "aspect_ratio": "={{ $json.ratio }}",
    "output_format": "png",
    "safety_tolerance": 2
  }
}
```

## Cómo probarla
- Rellena tres filas muy distintas: un producto sobre mármol con luz de estudio, el mismo con luz natural, y uno en formato historia.
- Ejecuta a mano y compara. Si las imágenes salen planas, cambia en el Code el valor de `luz` a `dramatica` y vuelve a tirar.
- Guarda las combinaciones que funcionan: ese es tu recetario de prompts.

## Qué puede salir mal
- **La generación tarda más de 60 segundos.** Por eso está el bucle Wait del paso 7. No lo quites.
- **Textos ilegibles en la imagen.** Los modelos de imagen escriben mal. Si el producto lleva etiqueta, genera el fondo con IA y pon la etiqueta real encima con un editor, o usa Ideogram, que escribe mejor.
- **Enlaces caducados.** Las URL de salida de Replicate caducan en una hora. Por eso el flujo descarga y guarda en Drive en el mismo paso.
- **Coherencia entre imágenes.** Para que las 30 parezcan de la misma sesión, deja fija la parte de luz, lente y calidad en el Code y cambia solo producto y escenario.
- **Uso comercial.** Revisa la licencia del modelo concreto que uses. Flux Pro por API permite uso comercial; algunos modelos de la comunidad no.

## Cuánto cuesta
- Replicate: se paga por generación. Flux 1.1 Pro ronda 0,04 $ por imagen. 100 imágenes son unos 4 $.
- Alternativa más barata: Flux Schnell, unos 0,003 $ por imagen, calidad algo menor pero suficiente para bocetos.
- n8n, Drive y Sheets: gratis.
