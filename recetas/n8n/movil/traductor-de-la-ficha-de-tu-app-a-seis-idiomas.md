# Traductor de la ficha de tu app a seis idiomas…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Coge el título, subtítulo, descripción y palabras clave de tu app y los traduce con DeepL respetando los límites de caracteres de Apple.

## Qué es y qué hace

Flujo de n8n que lee desde Google Sheets tus textos de ficha en español (título, subtítulo, palabras clave y descripción), los traduce con DeepL a los idiomas que elijas y comprueba que cada campo respeta el límite de caracteres de la App Store. Entran los textos y sus límites; sale una hoja con cada traducción lista para pegar. Necesita una clave gratuita de DeepL API Free.

## Cómo usarla

1. 1. Crea la hoja Ficha con las pestañas origen y traducciones
2. 2. Pon tu clave de DeepL en Header Auth
3. 3. Pega las traducciones en la ficha de cada idioma y revisa el resultado

## Cuándo usarla

Úsalo cuando quieras publicar tu app en más países y te frene el trabajo de traducir y recortar textos para cada idioma.

## Cómo ganar dinero con ella

Una traducción profesional de ficha ronda 40-80 € por idioma. Aquí sale gratis o casi, y lo tienes en diez minutos en vez de una semana.

- Localización de fichas de apps para desarrolladores que quieren probar mercados en varios idiomas sin pagar traductor.
- Traducción con límites de caracteres para agencias que publican apps de clientes en varios países.
- Plantilla de ficha multilingüe para estudios que lanzan en España, Latinoamérica y Alemania.

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee tus textos en español desde una hoja, los traduce a los idiomas que elijas y devuelve cada versión ya recortada a los límites que exige la App Store, lista para copiar y pegar.
Para quien va a internacionalizar su app y no quiere pagar traducciones antes de saber si funciona en esos mercados.

## Lo que necesitas antes
Cuenta de DeepL API Free: date de alta en deepl.com/pro-api, plan Free, y copia tu clave (acaba en `:fx`). Son 500.000 caracteres gratis al mes, muchísimo para fichas.
En n8n, Credentials > Header Auth: Name = `Authorization`, Value = `DeepL-Auth-Key TU_CLAVE:fx`.
Hoja `Ficha` con dos pestañas: `origen` (columnas: campo, texto, limite) y `traducciones` (columnas: idioma, campo, texto, caracteres).
En `origen` mete cuatro filas: titulo (limite 30), subtitulo (limite 30), keywords (limite 100), descripcion (limite 4000).

## Los nodos, en orden
1. **Manual Trigger** (esto se lanza cuando tú quieres, no hace falta horario).
2. **Google Sheets** (Get Row(s)): pestaña `origen`.
3. **Code**: multiplica cada texto por cada idioma. Código abajo.
4. **Split In Batches**: Batch Size = 1.
5. **HTTP Request**: POST a `https://api-free.deepl.com/v2/translate`, Authentication = Generic Credential Type > Header Auth (la que creaste). Body en JSON: `{ "text": ["{{ $json.texto }}"], "target_lang": "{{ $json.idioma }}" }`. Headers: `Content-Type: application/json`.
6. **Code** (segundo): saca la traducción y la recorta al límite sin partir palabras. Código abajo.
7. **Google Sheets** (Append): pestaña `traducciones`.
8. Vuelve al **Split In Batches**.

## Primer nodo Code
```javascript
const idiomas = ['EN-US', 'FR', 'DE', 'IT', 'PT-PT', 'NL'];
const salida = [];
for (const item of $input.all()) {
  for (const idioma of idiomas) {
    salida.push({ json: { idioma, campo: item.json.campo, texto: item.json.texto, limite: Number(item.json.limite || 4000) } });
  }
}
return salida;
```

## Segundo nodo Code
```javascript
const traducciones = ($input.first().json.translations || []);
const texto = traducciones.length ? traducciones[0].text : '';
const origen = $('Split In Batches').item.json;
let recortado = texto;
if (recortado.length > origen.limite) {
  recortado = recortado.slice(0, origen.limite);
  const corte = recortado.lastIndexOf(' ');
  if (corte > 10) { recortado = recortado.slice(0, corte); }
}
return [{ json: { idioma: origen.idioma, campo: origen.campo, texto: recortado, caracteres: recortado.length } }];
```

## Cómo probarla
Empieza con un solo idioma y solo la fila `titulo`. Comprueba que la traducción llega y que `caracteres` no pasa de 30.
Fíjate en las keywords: tradúcelas como lista separada por comas y luego revisa a mano, porque las palabras clave literales rara vez son la traducción directa.

## Qué puede salir mal
Si usas la clave de pago, la URL cambia a `https://api.deepl.com/v2/translate`; con la Free tiene que ser `api-free`.
El límite de 30 caracteres del título es duro: si la traducción no cabe, acórtala tú a mano; el recorte automático es solo una red de seguridad.
DeepL Free limita las peticiones por minuto; con Batch Size 1 y un **Wait** de 1 segundo vas sobrado.
No traduzcas nombres de marca: envuélvelos en la etiqueta `<x>Mi Marca</x>` y añade `"tag_handling": "xml", "ignore_tags": ["x"]` al body.

## Cuánto cuesta
DeepL Free: 500.000 caracteres al mes gratis, sin tarjeta obligatoria en la mayoría de países (piden verificación). Todo lo demás, gratis.
