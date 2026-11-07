---
name: pack-assets-vender
description: "Convierte una carpeta de modelos 3D en un pack de assets vendible: nomenclatura, escala, pivotes, LODs, colisiones, presupuesto de texturas, escena de demostración, miniaturas y ficha de tienda. Úsala cuando el usuario tenga modelos 3D y quiera empaquetarlos y publicarlos en un marketplace de assets."
---

# Pack de assets 3D listo para vender

## Qué hace

Coge modelos sueltos y los convierte en un pack que un desarrollador puede meter en su proyecto sin pelearse. La diferencia entre un pack que se vende y uno que no suele ser la limpieza, no el arte.

## Cuándo se activa

Cuando el usuario menciona vender modelos 3D, packs de assets, Unity Asset Store, Fab, itch.io, Sketchfab o CGTrader.

## Qué preguntar

1. Qué modelos hay y si comparten estilo (mismo nivel de detalle, misma paleta, mismo tratamiento).
2. Motor objetivo: Unity, Unreal, Godot, genérico o web.
3. Estilo: realista PBR, estilizado, low poly plano.
4. ¿Tienes derechos sobre todo lo que hay dentro, incluidas texturas y referencias?

## Método

### 1. Coherencia del conjunto

Un pack es un conjunto, no un montón. Revisa: mismo estilo de silueta, misma densidad de texel (que un ladrillo se vea igual de nítido en todas las piezas), misma paleta y misma escala.

### 2. Higiene técnica, pieza a pieza

- Escala real: 1 unidad = 1 metro. Aplica transformaciones (escala 1,1,1 y rotación 0) antes de exportar.
- Pivote en el punto donde el objeto se apoya o se coloca: base de una mesa, bisagra de una puerta. Objeto centrado en el origen en X e Y.
- Eje: exporta con Y arriba para Unity, Z arriba en Blender y deja claro el ajuste. Prueba la importación tú mismo antes de vender.
- Normales hacia fuera, sin caras dobles, sin geometría interior invisible, sin n-gonos que revienten en el triangulado.
- UVs sin solapamientos salvo que sea intencionado; segundo canal UV para lightmaps si el pack es de escenario.
- Sin materiales duplicados: comparte atlas cuando puedas.

### 3. Nomenclatura y estructura

- Prefijos consistentes: SM_ para mallas estáticas, SK_ para esqueléticas, T_ para texturas, M_ para materiales.
- Sufijos de textura: _BC (base color), _N (normal), _ORM o _RMA según el empaquetado, _E (emisivo). Documenta cuál usas.
- Carpetas: Meshes, Textures, Materials, Prefabs, Demo, Documentation.
- Nada de «final_final_v3». Nombres en inglés, minúsculas o CamelCase, sin espacios ni acentos.

### 4. Optimización

- Presupuesto de triángulos por tipo: props pequeños en el orden de cientos a pocos miles; piezas grandes de escenario, más. Da siempre la cifra real en la ficha.
- Texturas: 2048 para piezas protagonistas, 1024 o 512 para props pequeños. No pongas 4K en todo «por si acaso»: infla el pack y molesta.
- LODs si el pack es de entorno: LOD0, LOD1 (~50 %), LOD2 (~25 %).
- Colisiones simples nombradas según la convención del motor de destino.

### 5. Presentación

- Escena demo montada y bonita: es lo que sale en las capturas y lo que decide la compra.
- 8-12 capturas: la escena general, cada pieza sobre fondo neutro, un wireframe, un desglose de texturas y una captura con la escala junto a un personaje de referencia.
- PDF corto: qué incluye, recuento de triángulos, tamaño de texturas, versión del motor probada y cómo importarlo.
- Descripción de tienda con lista literal de piezas y sus contadores.

## Formato de la respuesta

1. Auditoría de coherencia del conjunto: qué encaja y qué hay que rehacer o quitar.
2. Tabla por pieza: nombre propuesto, triángulos, texturas, LODs, pivote correcto sí o no.
3. Estructura de carpetas y convención de nombres completa.
4. Plan de la escena demo y lista de las capturas.
5. Texto de la ficha de tienda con la lista técnica.
6. Checklist de exportación previa a la subida.

## Errores típicos

- Mezclar escalas (una silla de 3 metros junto a una casa de 4).
- Normales invertidas que se ven bien en tu visor y negras en el motor.
- Pivote en el centro geométrico de un objeto que se apoya en el suelo.
- Meter texturas descargadas sin licencia comercial dentro del pack.
- Vender un pack de 3 objetos: los compradores buscan conjuntos que resuelvan una escena entera.

## Avisos honestos

- Las tiendas se quedan una comisión y el proceso de aprobación puede rechazarte por detalles técnicos. Cuenta con una o dos iteraciones.
- Un pack no se vende solo: los primeros suelen vender poco hasta que tienes catálogo y reseñas.
