# licencia-y-declaracion-de-ia…

**Tipo:** JSON prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Redacta la licencia de uso de tus assets y la declaracion de contenido generado con IA que piden los marketplaces, sin jerga legal inutil.

## Qué es y qué hace

JSON prompt que redacta la licencia de uso de tus assets y la declaración de contenido generado con IA. Entran tipo de asset, plataforma y qué parte usó IA; sale un texto de licencia sin jerga legal inútil y una declaración adaptada al marketplace o cliente. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el JSON en un chat de IA
2. Rellena los [corchetes] con tus assets y herramientas
3. Revisa los textos con las normas de cada plataforma
4. Que lo revise un profesional

## Cuándo usarla

Úsalo antes de publicar assets o de entregar trabajo hecho con ayuda de IA, y cuando un marketplace o un cliente te pregunte que licencia aplicas.

## Cómo ganar dinero con ella

Evita que te retiren fichas ya publicadas, permite cobrar aparte la licencia extendida y da seguridad al cliente empresa que necesita saber que puede usar.

- Textos de licencia estándar y extendida para vendedores de assets…
- Declaraciones de uso de IA para fichas de marketplace…
- Documentación de procedencia para entregas a empresas…

**Precio orientativo:** 40–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Redactar la licencia de uso de un asset 3D o de un pack, y la declaracion de contenido generado con IA exigida por marketplaces y clientes",
  "contexto": {
    "quien_lo_usa": "Creador que vende assets o entrega trabajo a clientes y usa herramientas de IA en parte del proceso",
    "momento": "Antes de publicar o de firmar la entrega",
    "realidad": "Cada plataforma pide declarar el uso de IA de forma distinta y ocultarlo puede costar la retirada de la ficha o de la cuenta"
  },
  "entradas": {
    "asset": "[QUE ES]",
    "donde_se_publica": "[FAB / CGTRADER / SKETCHFAB / ITCH / VENTA DIRECTA / ENTREGA A CLIENTE]",
    "uso_de_ia": "[NADA / IDEAS Y REFERENCIAS / TEXTURAS GENERADAS / MALLA GENERADA / TODO GENERADO]",
    "herramientas_usadas": "[LISTA DE HERRAMIENTAS Y EN QUE PASO]",
    "origen_de_los_materiales": "[FOTOS PROPIAS / TEXTURAS DE BANCOS / MODELOS BASE COMPRADOS / ESCANEOS PROPIOS]",
    "modelo_de_licencia_deseado": "[USO COMERCIAL SIN LIMITE / SOLO USO PERSONAL / EXCLUSIVA PARA EL CLIENTE]"
  },
  "conocimiento_del_oficio": {
    "lo_que_toda_licencia_debe_decir": "Que se puede hacer, que no, si se puede usar en producto comercial, si se puede modificar, si se puede redistribuir y que pasa si el comprador cierra su proyecto",
    "la_prohibicion_clave": "Casi ninguna licencia de asset permite revender el archivo tal cual ni incluirlo en otro pack de assets: eso siempre se prohibe expresamente",
    "estandar_frente_a_extendida": "La estandar cubre uso en un producto propio; la extendida cubre reventa integrada, uso en plantillas o proyectos de terceros y se cobra aparte",
    "exclusiva": "Si el cliente quiere exclusividad, deja de poder venderse a nadie mas y eso multiplica el precio; ponlo por escrito con fecha y ambito",
    "declaracion_ia": "Se declara en que paso concreto se uso IA: concepto, textura, malla, animacion o solo limpieza. Frases vagas del tipo asistido por IA suelen no bastar",
    "trazabilidad": "Guarda los prompts, las fuentes de las fotos y las facturas de los modelos base: es lo unico que te defiende ante una reclamacion",
    "marcas_y_personas": "No incluyas logos, marcas registradas, caras reconocibles ni recreaciones de personajes con derechos, aunque lo haya generado la IA"
  },
  "pasos": [
    "1. Mapear cada paso del proceso y marcar donde intervino la IA y donde no",
    "2. Comprobar el origen de fotos, texturas y modelos base y descartar lo que no puedas justificar",
    "3. Elegir el tipo de licencia y su precio relativo",
    "4. Redactar la licencia en lenguaje claro con secciones de permitido y prohibido",
    "5. Redactar la declaracion de IA con el nivel de detalle que pide la plataforma indicada",
    "6. Preparar la version corta de una linea para la ficha y la version larga para el archivo de licencia",
    "7. Añadir el aviso de que no se incluyen marcas ni personajes con derechos",
    "8. Dejar una lista de lo que hay que archivar como respaldo"
  ],
  "errores_tipicos": [
    "Copiar la licencia de otro creador sin adaptar el nombre ni el alcance",
    "No declarar el uso de IA y que retiren la ficha despues de tener ventas",
    "Vender como exclusiva algo que ya se ha vendido a otro cliente",
    "Usar texturas de bancos que prohiben la redistribucion dentro de un asset",
    "Prometer al cliente todos los derechos sin saber que significa"
  ],
  "restricciones": [
    "Lenguaje claro, sin latinajos ni parrafos de cien palabras",
    "Deja constancia de que esto no es asesoramiento juridico y de que un contrato importante lo revise un abogado",
    "No afirmes lo que dice la ley de un pais concreto si no se te indica"
  ],
  "formato_salida": {
    "1_mapa_del_proceso": "Tabla: paso | herramienta | hecho por IA o por ti | origen del material",
    "2_licencia": "Texto completo con secciones PERMITIDO, PROHIBIDO, ALCANCE y DURACION",
    "3_declaracion_ia": "Version corta para la ficha y version larga",
    "4_alertas": "Riesgos detectados en el material de origen",
    "5_archivo_de_respaldo": "Lista de lo que guardar y donde"
  },
  "criterios_calidad": [
    "La licencia responde sin ambiguedad a: puedo venderlo dentro de mi juego, si o no
```
