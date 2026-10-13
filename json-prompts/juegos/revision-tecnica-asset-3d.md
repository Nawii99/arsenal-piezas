# revision-tecnica-asset-3d…

**Tipo:** JSON prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Audita un modelo 3D antes de venderlo o entregarlo y te devuelve la lista de fallos concretos con su arreglo, ordenados por gravedad.

## Qué es y qué hace

JSON prompt que audita un modelo 3D antes de entregarlo o venderlo. Entran software, estadísticas y destino del archivo; sale una lista de fallos de escala, normales, UVs y materiales ordenada por gravedad, con el arreglo paso a paso. Se usa en cualquier chat de IA, con Blender u otro programa 3D.

## Cómo usarla

1. Copia el JSON en un chat de IA
2. Rellena los [corchetes] con tu modelo
3. Pégalo y aplica los arreglos por orden de gravedad
4. Vuelve a revisar antes de entregar

## Cuándo usarla

Úsalo cuando tengas un modelo 3D terminado y estés a punto de subirlo a un marketplace o enviárselo a un cliente, y no sepas si va a dar problemas al abrirlo.

## Cómo ganar dinero con ella

Evita devoluciones, rechazos del marketplace y revisiones gratis: los fallos de escala, normales y UVs son la causa más habitual de que te devuelvan un encargo ya cobrado…

- Revisión técnica de modelos 3D antes de entregarlos a clientes…
- Control de calidad previo a subir assets a marketplaces…
- Servicio de limpieza y corrección de modelos 3D…

**Precio orientativo:** 30–120 € por pieza. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Auditar un modelo 3D antes de publicarlo o entregarlo y devolver una lista de fallos concretos, cada uno con su arreglo paso a paso",
  "contexto": {
    "quien_lo_usa": "Persona sin perfil técnico que vende o entrega modelos 3D hechos con IA, escaneo o software 3D",
    "momento": "Justo antes de subir el archivo a un marketplace o de mandarlo al cliente",
    "software_disponible": "[BLENDER / MAYA / 3DS MAX / OTRO]",
    "nivel_del_usuario": "Sabe mover el visor y pulsar botones, no sabe programar ni leer jerga"
  },
  "entradas": {
    "nombre_del_modelo": "[NOMBRE]",
    "destino": "[MARKETPLACE / JUEGO EN UNITY / JUEGO EN UNREAL / RENDER / IMPRESION 3D / WEB]",
    "archivo": {
      "formatos": "[FBX, OBJ, GLB, BLEND...]",
      "triangulos": "[NUMERO]",
      "objetos_y_materiales": "[CUANTOS OBJETOS Y CUANTOS MATERIALES]",
      "texturas": "[RESOLUCION Y MAPAS QUE HAY: BASE COLOR, NORMAL, ROUGHNESS, METALLIC, AO]",
      "unidades": "[METROS / CENTIMETROS / NO LO SE]",
      "rig_o_animacion": "[SI / NO]"
    },
    "lo_que_veo_en_pantalla": "[DESCRIBE: ZONAS NEGRAS, CARAS QUE DESAPARECEN, TEXTURA ESTIRADA, MODELO GIGANTE O DIMINUTO...]"
  },
  "conocimiento_del_oficio": {
    "escala": "Un adulto mide 1,7-1,8 m, una puerta 2,0-2,1 m, una silla 0,45 m de asiento. Si el modelo entra en escena 100 veces mas grande o pequeño, casi siempre son unidades (cm frente a m)",
    "origen_y_pivote": "El origen va en la base y centrado, salvo puertas y ruedas, donde va en el eje de giro",
    "transformaciones": "Escala 1,1,1 y rotacion 0,0,0 aplicadas antes de exportar, o el objeto se deformara al importarlo",
    "topologia": "Cuadrangulos si el modelo se va a deformar o animar; triangulos son validos en props rigidos; nada de caras de mas de cuatro lados en algo que se anima",
    "geometria_sucia": "Vertices sueltos, caras dobles, normales invertidas y n-gonos son los fallos que mas devoluciones provocan",
    "uvs": "Islas sin solapes salvo simetria buscada, margen entre islas y densidad de texel parecida en las piezas que se ven de cerca",
    "materiales": "Nombres descriptivos, ninguno llamado Material punto 001, y texturas enlazadas con ruta relativa dentro de la carpeta del proyecto",
    "señal_visual": "Zonas negras o que se ven desde dentro igual a normales invertidas; textura estirada igual a UVs mal desplegadas; brillo raro plano igual a falta de mapa normal"
  },
  "pasos": [
    "1. Comprobar unidades y escala midiendo la pieza contra una referencia humana de 1,75 m",
    "2. Revisar posicion del origen y que escala y rotacion esten aplicadas",
    "3. Buscar geometria suelta: vertices huerfanos, caras dobles y agujeros",
    "4. Ver el modelo en gris sin texturas para detectar normales invertidas y sombreado sucio",
    "5. Abrir el mapa UV y comprobar solapes, margenes y estiramientos con una textura de cuadricula",
    "6. Revisar nombres de objetos, materiales y texturas, y que ningun mapa apunte a una ruta del disco del autor",
    "7. Contar triangulos y compararlos con el presupuesto del destino indicado",
    "8. Exportar a un formato de prueba y volver a abrirlo en limpio para confirmar que todo sobrevive"
  ],
  "errores_tipicos": [
    "Exportar sin aplicar escala y que el modelo entre deformado en el motor",
    "Texturas enlazadas a una carpeta del ordenador del autor: el cliente abre el archivo y lo ve rosa o gris",
    "Modelo con 40 materiales cuando bastan 2 o 3, lo que dispara el coste en un juego",
    "Poner mapa normal generado de la textura de color y que el relieve salga plano o al reves",
    "Publicar el modelo suelto sin las texturas dentro del paquete"
  ],
  "restricciones": [
    "No inventes cifras del archivo: si un dato falta, pidelo o marca el punto como NO COMPROBADO",
    "Explica cada arreglo con palabras del menu del software indicado, no con jerga",
    "Nada de recomendaciones genericas del tipo optimiza el modelo"
  ],
  "formato_salida": {
    "1_veredicto": "Una linea: LISTO PARA ENTREGAR, ARREGLOS MENORES o NO ENTREGAR TODAVIA",
    "2_tabla_de_fallos": "Columnas: gravedad (bloqueante, importante, menor) | que falla | como se nota | arreglo en pasos |
```
