# Ficha de producto Amazon lista para publicar…

**Tipo:** JSON prompt · **Área:** Negocio · **Licencia:** CC BY 4.0

Te devuelve el título, los 5 bullets, la descripción y los términos de búsqueda ocultos de un producto, respetando los límites de Amazon.

## Qué es y qué hace

Prompt JSON que recibe marca, producto, categoría, palabras clave y datos técnicos, y devuelve la ficha completa para Amazon: título de 150 a 200 caracteres, cinco bullets, descripción y términos de búsqueda ocultos, respetando las reglas del canal. Sirve en Claude, Codex, Gemini o una IA local, y puede llevarse a una hoja de cálculo con n8n o Make para varios productos a la vez.

## Cómo usarla

1. Rellena marca, producto y datos técnicos
2. Genera la ficha con las reglas incluidas
3. Revisa cifras y certificaciones
4. Pega el resultado en Seller Central

## Cuándo usarla

Úsalo cuando vas a subir un producto nuevo a Amazon o cuando una ficha antigua no vende y quieres reescribirla entera.

## Cómo ganar dinero con ella

Una ficha bien escrita aparece en más búsquedas y convierte mejor, así que sacas más pedidos sin subir el gasto en publicidad.

- Fichas de Amazon por producto para pequeñas marcas que venden en España, Italia o Alemania.
- Reescritura de fichas antiguas que no venden, con antes y después y cambios priorizados.
- Lote de 10 fichas para el catálogo de una tienda que empieza a vender en Amazon.

**Precio orientativo:** 15–40 € por ficha. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Escribir la ficha completa de un producto para Amazon (título, bullets, descripción y términos de búsqueda backend) optimizada para posicionar y para convertir",
  "contexto": {
    "marca": "[NOMBRE DE TU MARCA]",
    "producto": "[PRODUCTO, MODELO Y VARIANTE]",
    "marketplace": "[AMAZON.ES / AMAZON.IT / AMAZON.DE]",
    "categoria": "[CATEGORÍA EN LA QUE LO PUBLICAS]",
    "precio_con_iva": "[PRECIO]",
    "cliente_objetivo": "[QUIÉN LO COMPRA Y PARA QUÉ LO USA]",
    "diferencias_reales": "[3 COSAS QUE TE HACEN DISTINTO, CON DATO CONCRETO]",
    "palabras_clave": "[5 A 10 BÚSQUEDAS QUE HACE TU CLIENTE]",
    "datos_tecnicos": "[MEDIDAS, MATERIAL, PESO, CONTENIDO DE LA CAJA, GARANTÍA]"
  },
  "reglas_del_canal": [
    "Título de 150 a 200 caracteres: marca + producto + rasgo clave + material o medida + cantidad + uso principal",
    "Sin emojis, sin palabras enteras en mayúsculas, sin precio, sin 'oferta', 'envío gratis' ni referencias a promociones",
    "5 bullets de 150 a 250 caracteres; cada uno empieza con un beneficio de 2 a 4 palabras en mayúsculas seguido de dos puntos",
    "Cada bullet une beneficio y prueba: primero qué gana el cliente, después el dato técnico que lo sostiene",
    "Prohibido decir 'el mejor', citar marcas ajenas o hacer promesas de salud, curación o adelgazamiento",
    "Términos de búsqueda backend: máximo 249 bytes, separados por espacios, sin comas, sin repetir palabras ya usadas en el título ni marcas de terceros"
  ],
  "pasos": [
    "Agrupa las palabras clave en principales (van al título), secundarias (a los bullets) y de cola larga (al backend)",
    "Escribe el título colocando la búsqueda principal dentro de los primeros 80 caracteres",
    "Ordena los bullets del beneficio que más pesa en la decisión al que menos; deja el de garantía o postventa el último",
    "Escribe la descripción en 3 o 4 párrafos cortos: para qué sirve, cómo se usa, qué incluye y qué pasa si algo falla",
    "Rellena el backend solo con sinónimos, errores de escritura frecuentes y usos que no hayan salido antes"
  ],
  "formato_salida": {
    "bloque_1": "TÍTULO + recuento de caracteres",
    "bloque_2": "Los 5 bullets numerados, cada uno con su recuento de caracteres",
    "bloque_3": "Descripción en texto plano",
    "bloque_4": "Términos de búsqueda backend en una línea + bytes usados",
    "bloque_5": "Tabla de 6 ideas de imagen: número de foto, qué se ve y qué texto lleva encima"
  },
  "criterios_calidad": [
    "La búsqueda principal aparece en el título y en al menos dos bullets, sin repetirse de forma forzada",
```
