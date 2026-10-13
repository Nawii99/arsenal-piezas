# ficha-marketplace-3d…

**Tipo:** JSON prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Escribe la ficha completa de un modelo 3D para venderlo en un marketplace: titulo buscable, tags, descripcion, especificaciones y guion de las imagenes.

## Qué es y qué hace

JSON prompt que redacta la ficha completa de un asset 3D para un marketplace. Entran tipo de asset, formatos y comprador; sale título buscable, etiquetas, descripción, especificaciones y guion de imágenes de la galería. Se usa en cualquier chat de IA para Fab, CGTrader, Sketchfab, TurboSquid o itch.

## Cómo usarla

1. Copia el JSON en un chat de IA
2. Rellena los [corchetes] con tu asset
3. Pega el texto en la ficha del marketplace
4. Prepara las imágenes según el guion

## Cuándo usarla

Úsalo cuando tengas un asset 3D listo y vayas a publicarlo en Fab, CGTrader, Sketchfab, TurboSquid o itch, y no sepas que escribir ni que imagenes subir.

## Cómo ganar dinero con ella

Los assets se venden por busqueda: un titulo y unos tags bien puestos hacen que tu modelo aparezca frente a los de la competencia sin gastar en publicidad.

- Redacción de fichas de venta de assets 3D para creadores…
- Optimización de títulos y etiquetas de assets ya publicados…
- Pack de fichas bilingües para tiendas de assets…

**Precio orientativo:** 15–60 € por pieza. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Redactar la ficha de venta completa de un asset 3D para un marketplace, incluido el guion de las imagenes de la galeria",
  "contexto": {
    "quien_compra": "Desarrolladores indie, arquitectos, gente de video y aficionados a la impresion 3D que buscan por palabras muy concretas",
    "como_se_encuentra": "Casi todas las ventas llegan por buscador interno del marketplace y por la miniatura, no por tu nombre",
    "momento": "El asset ya esta acabado y revisado tecnicamente"
  },
  "entradas": {
    "marketplace": "[FAB / CGTRADER / SKETCHFAB / TURBOSQUID / ITCH / OTRO]",
    "que_es": "[DESCRIBE EL ASSET: PIEZA SUELTA, PACK, ENTORNO, PERSONAJE...]",
    "piezas_incluidas": "[LISTA]",
    "estilo": "[REALISTA / ESTILIZADO / LOW POLY / PIXEL 3D / OTRO]",
    "datos_tecnicos": "[TRIANGULOS, MATERIALES, TEXTURAS Y RESOLUCION, FORMATOS, SI TIENE LODs, SI ESTA RIGGEADO]",
    "origen_del_contenido": "[MODELADO A MANO / IA / ESCANEO / MEZCLA]",
    "precio_pensado": "[EUROS O NO LO SE]"
  },
  "conocimiento_del_oficio": {
    "formula_del_titulo": "Que es + estilo + palabra de uso + pack o cantidad. Ejemplo de estructura: Cajas de madera medievales low poly pack de 12",
    "tags": "Entre 10 y 20, mezclando el objeto, sinonimos, estilo, motor, genero de juego y uso. Nada de tags irrelevantes: penalizan",
    "primera_imagen": "Vende el 80 por ciento. Modelo grande, fondo limpio, contraste alto y legible en miniatura pequeña",
    "galeria_minima": "Vista general, detalle de cerca, wireframe, mapas de textura, escala junto a una figura humana y todas las piezas del pack juntas",
    "descripcion": "Primeras dos lineas visibles sin desplegar: para que sirve y que incluye. Despues bloque tecnico en lista",
    "precio": "Piezas sueltas simples de 3 a 15 euros, packs de 15 a 60, entornos completos por encima. Precio redondo y coherente con la competencia visible en la misma busqueda",
    "lo_que_hace_devolver": "Prometer PBR y no incluir todos los mapas, decir game ready sin LODs ni escala correcta, o enseñar renders con detalles que el modelo no tiene"
  },
  "pasos": [
    "1. Buscar en el propio marketplace el termino principal y anotar como titulan los 5 primeros resultados",
    "2. Elegir la palabra clave principal y dos secundarias que un comprador escribiria de verdad",
    "3. Montar el titulo con la formula, sin superlativos ni signos raros",
    "4. Escribir las dos primeras lineas de la descripcion como si fueran un anuncio",
    "5. Volcar el bloque tecnico en lista, campo a campo, sin adornar",
    "6. Generar los tags y quitar los que no describan el objeto",
    "7. Escribir el guion de las 6 imagenes de galeria, indicando encuadre y fondo de cada una",
    "8. Proponer precio con una linea de justificacion y una alternativa de lanzamiento"
  ],
  "errores_tipicos": [
    "Titulo poetico con el nombre de tu marca delante y el objeto al final",
    "Descripcion larga sin decir cuantas piezas incluye ni en que formatos",
    "Miniatura oscura o con el modelo pequeño en medio del encuadre",
    "Copiar los tags de otro asset distinto al tuyo",
    "No indicar si el contenido se hizo con IA cuando el marketplace lo exige"
  ],
  "restricciones": [
    "No prometas nada que el archivo no tenga: cada afirmacion tiene que verificarse abriendo el modelo",
    "Idioma de la ficha en ingles si el marketplace es internacional, con una version en español aparte",
    "Sin emojis ni mayusculas sostenidas en el titulo"
  ],
  "formato_salida": {
    "1_titulo": "Titulo principal y dos alternativas, con el numero de caracteres de cada uno",
    "2_descripcion": "Bloque corto de apertura y despues lista tecnica y lista de contenido",
    "3_tags": "Lista separada por comas, lista para pegar",
    "4_ficha_tecnica": "Tabla campo y valor",
    "5_guion_de_imagenes": "Seis lineas numeradas: que se ve, encuadre, fondo y para que sirve esa imagen",
    "6_precio": "Precio propuesto, precio de lanzamiento y una linea de motivo"
  },
  "criterios_calidad": [
    "El titulo contiene la palabra que escribiria el comprador, no la que te gusta a ti",
    "Las dos primeras lineas se entienden sin desplegar la descripcion",
    "To
```
