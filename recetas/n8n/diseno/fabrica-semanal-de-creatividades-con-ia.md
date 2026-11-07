# Fábrica semanal de creatividades con IA…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Cada lunes lee tus ideas de post en una hoja, genera la imagen con IA aplicando el estilo de tu marca y te la deja lista en Drive con aviso por email.

## Qué es y qué hace

Cada lunes lee las ideas de post de una hoja de Google Sheets, genera cada imagen con un modelo de imagen aplicando el estilo y la paleta de tu marca, y guarda el resultado en Drive con aviso por correo. Entran las ideas y una clave de API de imagen; sale una carpeta de creatividades listas para revisar. Para diseñadores o marcas que publican cada semana con un estilo visual fijo.

## Cómo usarla

1. Crea una clave de API de imagen con saldo
2. Define el estilo y la paleta de marca en el prompt
3. Rellena la hoja de ideas de la semana
4. Revisa la primera tanda antes de publicar

## Cuándo usarla

Úsalo cuando publicas en redes cada semana, siempre con el mismo estilo visual, y se te va media mañana en abrir el editor y empezar la imagen desde cero.

## Cómo ganar dinero con ella

Sustituye 3-4 horas semanales de maquetación. Coste real: unos 0,04 € por imagen. Doce imágenes al mes salen por menos de 1 €.

- Creatividades semanales para redes de pymes con estilo de marca fijo…
- Servicio mensual de imágenes para redes de clientes con revisión humana…
- Configuración de un sistema de contenido visual para tiendas online…

**Precio orientativo:** 100–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Cada lunes a las 8:00 lee una hoja de Google Sheets con las ideas de post de la semana, genera cada imagen con IA aplicando tu estilo y tu paleta de marca, y guarda el resultado en una carpeta de Drive.
Para el diseñador freelance o el dueño de marca que publica en redes con un estilo fijo y no quiere partir del lienzo en blanco cada semana.

**Lo que necesitas antes**
- n8n: prueba gratuita temporal en n8n.cloud o auto-alojado gratis (Community Edition) con Docker en tu ordenador o en un VPS de 5 €/mes.
- Cuenta de Google con credencial OAuth para Sheets, Drive y Gmail. Se saca en console.cloud.google.com, apartado APIs y servicios, Credenciales, ID de cliente de OAuth tipo Aplicación web. La URL de redirección te la enseña n8n al crear la credencial.
- Clave de API de imagen: platform.openai.com, sección API keys, modelo gpt-image-1. Hay que meter saldo (5 € sobran para empezar).
- Una hoja de cálculo con estas columnas exactas: fecha, idea, texto_en_imagen, formato, estado, url_resultado.
- Tu ficha de marca escrita: dos frases de estilo visual, tres colores en hexadecimal y la tipografía.

**Los nodos, en orden**
1. **Schedule Trigger**: modo Cron, expresión `0 8 * * 1` (lunes a las 8). En Ajustes del flujo pon la zona horaria Europe/Madrid.
2. **Google Sheets**: operación Get Row(s). Elige el documento y la hoja. En Filters añade la columna `estado` con valor `pendiente`.
3. **Code** (Run Once for All Items): construye el prompt de cada fila mezclando la idea con tu estilo de marca.
```javascript
const marca = {
  estilo: 'fotografía de producto, luz natural suave, fondo de papel',
  paleta: '#0F3D3E, #F2E8DC, #E2725B',
  extra: 'composición limpia, espacio libre en la parte superior para el titular'
};
return items.map(i => {
  const d = i.json;
  return { json: { ...d, prompt: `${d.idea}. Estilo: ${marca.estilo}. Paleta dominante: ${marca.paleta}. ${marca.extra}. Formato ${d.formato}. Sin texto generado, sin marcas de agua, sin logotipos.` } };
});
```
4. **Split In Batches**: Batch Size 1. Así generas una imagen cada vez y no revientas el límite de la API.
5. **HTTP Request**: método POST, URL `https://api.openai.com/v1/images/generations`. En Authentication elige Predefined Credential Type y luego OpenAI. Body en JSON: `{ "model": "gpt-image-1", "prompt": "{{ $json.prompt }}", "size": "1024x1024", "n": 1 }`.
6. **Convert to File**: operación Convert to Binary, campo de origen `data[0].b64_json`, marca la casilla de que el dato viene en base64.
7. **Google Drive**: operación Upload File. Carpeta la que tengas de creatividades. Nombre del fichero: `{{ $('Google Sheets').item.json.fecha }}-{{ $('Google Sheets').item.json.idea.slice(0,30) }}.png`.
8. **Google Sheets** (segundo nodo): operación Update Row. Columna de coincidencia `idea`, pon `estado` a `hecho` y `url_resultado` con `{{ $json.webViewLink }}`.
9. Conecta la salida de vuelta al **Split In Batches** para que recorra todas las filas.
10. **Gmail**: operación Send Message, a tu propio correo, asunto «Creatividades de la semana listas» y en el cuerpo el enlace a la carpeta.

**Cómo probarla**
- Deja solo dos filas en `pendiente` y pulsa Test Workflow. Mira que las dos imágenes aparecen en Drive y que la hoja se marca como hecha.
- Revisa el nodo HTTP Request en la pestaña de ejecución: si la respuesta trae `error`, el mensaje te dice si falta saldo o si el prompt fue rechazado.
- Solo cuando dos rondas seguidas salgan bien, activa el interruptor Active de arriba a la derecha.

**Qué puede salir mal**
- Límite de peticiones de OpenAI: por eso está el Split In Batches. Si aun así falla, en Settings del nodo HTTP Request activa Retry On Fail con 3 intentos y 5000 ms de espera.
- Imágenes repetidas: si la columna `idea` se repite, el Update Row machaca la fila equivocada. Añade una columna `id` con números únicos y usa esa para la coincidencia.
- Zona horaria: si no la fijas, n8n usa UTC y el lunes te dispara a las 10:00 en España.
- La IA mete texto raro en la imagen: no le pidas texto, el rótulo se pone después en Canva o con el nodo Edit Image.

**Cuánto cuesta**
- n8n auto-alojado: gratis. n8n cloud: prueba gratuita temporal y después planes de pago desde 20 €/mes.
- Google Sheets, Drive y Gmail: gratis con tu cuenta normal.
- OpenAI imágenes: unos 0,03-0,04 € por imagen en calidad media. Veinte imágenes al mes, menos de 1 €.
