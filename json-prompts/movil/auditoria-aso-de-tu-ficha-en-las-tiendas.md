# Auditoría ASO de tu ficha en las tiendas…

**Tipo:** JSON prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Revisa tu ficha actual en App Store y Google Play y te devuelve un informe con nota, fallos ordenados por impacto y los textos corregidos listos para pegar.

## Qué es y qué hace

Prompt en JSON que audita la ficha de tu app en App Store o Google Play: puntúa título, subtítulo, palabras clave, descripción, capturas y categoría, ordena los fallos por impacto y devuelve los textos corregidos. Entran el nombre, lo que hace, la tienda, el país, la categoría, el público, los competidores y los textos actuales; sale un informe con nota y textos listos para pegar. Se usa en Claude, Codex, Gemini o una IA local con datos públicos de la ficha.

## Cómo usarla

1. Copia título, subtítulo y descripción de la ficha
2. Indica tres competidores y tu público
3. Revisa los fallos por impacto
4. Pega los textos corregidos y mide las descargas

## Cuándo usarla

Úsalo cuando tu app ya está publicada, tiene pocas descargas orgánicas y no sabes si el problema es el título, las capturas o la descripción.

## Cómo ganar dinero con ella

Te señala en una sola pasada los arreglos que más descargas orgánicas pueden traer, sin pagar una consultoría ni gastar más en anuncios.

- Auditoría de fichas en tiendas para apps de pymes con pocas descargas orgánicas…
- Revisión ASO mensual para apps de reservas o fidelidad de negocios locales…
- Informe de optimización de ficha para equipos de producto que lanzan versiones nuevas…

**Precio orientativo:** 60–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Auditar la ficha de mi app en las tiendas y devolver un informe con puntuación, problemas ordenados por impacto y las correcciones ya redactadas",
  "rol": "Especialista en ASO con experiencia en apps publicadas en el mercado español",
  "contexto": {
    "app": "[NOMBRE DE TU APP]",
    "que_hace": "[QUÉ RESUELVE TU APP EN UNA FRASE]",
    "tiendas": "[APP STORE, GOOGLE PLAY O AMBAS]",
    "pais_e_idioma": "[PAÍS E IDIOMA DE LA FICHA]",
    "categoria": "[CATEGORÍA EN LA TIENDA]",
    "publico": "[A QUIÉN VA DIRIGIDA]",
    "competidores": "[3 APPS CON LAS QUE COMPITES]"
  },
  "entradas": {
    "titulo_actual": "[TÍTULO ACTUAL]",
    "subtitulo_o_descripcion_corta": "[SUBTÍTULO O DESCRIPCIÓN CORTA ACTUAL]",
    "campo_keywords": "[LOS 100 CARACTERES DE PALABRAS CLAVE DE APP STORE, SI LOS TIENES]",
    "descripcion_larga": "[PEGA AQUÍ TU DESCRIPCIÓN LARGA]",
    "capturas": "[DESCRIBE TUS CAPTURAS: CUÁNTAS SON, QUÉ SE VE Y SI LLEVAN TEXTO]",
    "valoraciones": "[NOTA MEDIA Y NÚMERO DE VALORACIONES]",
    "metricas": "[IMPRESIONES, VISITAS A LA FICHA E INSTALACIONES DEL ÚLTIMO MES, SI LAS TIENES]"
  },
  "que_revisar": [
    "Título: si incluye la palabra clave principal y si se corta en la lista de resultados",
    "Subtítulo o descripción corta: si repite el título en vez de sumar palabras nuevas",
    "Palabras clave: repeticiones inútiles, plurales innecesarios y términos que ya están en el título",
    "Primeras 3 líneas de la descripción larga: si convencen antes de pulsar Más",
    "Capturas: si las dos primeras se entienden sin ampliar y si el texto es legible en pantalla pequeña",
    "Icono: si se distingue del resto de la categoría a tamaño real",
    "Valoraciones y respuestas a reseñas negativas",
    "Coherencia entre lo que promete la ficha y lo que hace la app al abrirla"
  ],
  "errores_frecuentes": [
    "Meter el nombre de la marca varias veces y desperdiciar caracteres",
    "Escribir la descripción para la tienda y no para la persona que decide en 5 segundos",
    "Usar la misma ficha en todos los idiomas sin adaptar las palabras",
    "Poner nombres de competidores en las palabras clave, que las tiendas pueden rechazar"
  ],
  "formato_salida": {
    "tipo": "Informe en secciones con tablas en texto",
    "secciones": [
      "Nota global sobre 100 y nota por bloque: texto, visual, reputación",
      "Tabla de problemas: problema, impacto (alto, medio, bajo), esfuerzo y qué pasa si no lo tocas",
      "Textos corregidos listos para copiar, con el recuento de caracteres al lado",
      "Plan de 3 acciones para esta sem
```
