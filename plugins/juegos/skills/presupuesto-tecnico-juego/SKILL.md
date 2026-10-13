---
name: presupuesto-tecnico-juego
description: Defines a per-platform performance budget for a game or 3D experience (triangles, draw calls, texture memory, materials, lights) and turns it into per-asset limits the artist can follow. Use when starting a 3D project, when framerate drops, or when the user asks how detailed their assets can be.
---

# Presupuesto técnico: cuánto detalle te puedes permitir

## Qué hace
Convierte "quiero que se vea bien y vaya fluido" en números concretos por asset, para que no modeles nada que luego haya que tirar.

## Cuándo se activa
Al arrancar un proyecto 3D, cuando el juego va a tirones, cuando alguien pregunta cuántos polígonos puede tener un personaje, o antes de encargar assets a terceros.

## Qué preguntar si falta información
1. ¿Dónde se va a jugar: móvil gama media, PC, navegador, VR (Quest), consola?
2. ¿A cuántos fotogramas por segundo aspiras: 30, 60 o 72/90 en VR?
3. ¿Cuántos elementos habrá en pantalla a la vez (personajes, enemigos, props)?
4. ¿Qué motor: Unity, Unreal o Godot?
5. ¿Vista cenital lejana, tercera persona o primera persona con la cara pegada a las cosas?

## Cifras de partida (ajústalas, no las cites como ley)
- **Móvil gama media, 60 fps**: 100.000-300.000 triángulos visibles, 50-150 draw calls, memoria de texturas 100-200 MB, 1 luz dinámica + iluminación horneada.
- **PC modesto / navegador, 60 fps**: 1-3 millones de triángulos visibles, 500-1.500 draw calls, texturas hasta 2048.
- **VR Quest, 72 fps**: 200.000-400.000 triángulos, menos de 100 draw calls, casi todo horneado; aquí el presupuesto es sagrado porque se renderiza dos veces.
- Reparto típico por asset con presupuesto de 200.000: personaje jugable 20-40k, enemigo 8-15k, prop importante 2-5k, prop de relleno 200-1.500, entorno el resto.

## Método paso a paso
1. **Elige la máquina de referencia**, no la tuya. Un móvil de 150 euros de hace tres años es el listón real si vendes en móvil.
2. **Reparte el presupuesto por categorías** (personajes, entorno, efectos, interfaz) y déjate un 20% de colchón: siempre aparece algo.
3. **Traduce a reglas por asset**: máximo de triángulos, máximo de materiales, tamaño de textura y si lleva o no niveles de detalle (LOD).
4. **Draw calls antes que polígonos.** En móvil suele morir el juego por número de materiales distintos, no por triángulos. Une texturas en un atlas y comparte material entre props.
5. **Texturas**: prop pequeño 256-512, prop grande 1024, personaje principal 2048 como mucho. Regla de bolsillo: si el objeto nunca ocupa más de un tercio de la pantalla, 1024 sobra.
6. **LODs**: para cada asset repetido más de 10 veces, define LOD0 (100%), LOD1 (50%) y LOD2 (20%), y a qué distancia cambia.
7. **Luces**: hornea todo lo que no se mueva. Cada luz dinámica con sombra en móvil cuesta más que un personaje entero.
8. **Escribe el documento de presupuesto** y compártelo con quien te haga assets: sin él, cada colaborador inventa su propio criterio.
9. **Mide de verdad**: usa el estadístico del motor (Stats en Unity, stat unit en Unreal) en la escena más cargada, no en una vacía.
10. **Revisa el presupuesto una vez** a mitad de proyecto con datos reales y ajústalo; no lo toques cada semana.

## Errores típicos
- Presupuestar por el ordenador del desarrollador y descubrir el problema en la tienda, con reseñas de una estrella.
- Contar polígonos del archivo en vez de triángulos en pantalla: lo que cuesta es lo que se ve, multiplicado por cuántas copias hay.
- Personajes con 6 materiales distintos (piel, ojos, pelo, ropa, metal, tela) cuando cabrían en 2.
- Transparencias por todas partes: hierba, humo y partículas con alpha destrozan el móvil por sobredibujado.
- Poner LODs pero dejar las mismas texturas de 2048 en todos los niveles: no ahorras memoria.

## Formato exacto de la respuesta
1. **Máquina de referencia y objetivo de fps**, una línea.
2. **Tabla de presupuesto global**: triángulos, draw calls, memoria de texturas, luces dinámicas.
3. **Tabla por tipo de asset**: triángulos, materiales, tamaño de textura, LODs.
4. **Diez reglas de oro** para el equipo, en imperativo y sin jerga.
5. **Cómo medir**: pasos exactos en el motor elegido y qué número mirar.
6. **Qué recortar primero** si no llegas, en orden.

## Avisos honestos
- Estas cifras son puntos de partida del oficio, no garantías: el mismo número de triángulos rinde distinto según sombras, transparencias y resolución.
- Optimizar al final cuesta cinco veces más que presupuestar al principio.
- Si tu juego es 2D o de vista cenital con estilo sencillo, no necesitas casi nada de esto: dímelo y te doy una versión mínima.
