---
name: rig-personaje-para-animar
description: "Prepara un personaje 3D para rigging automático y retargeting de animaciones (Mixamo, rigs humanoides de motores): pose, escala, limpieza de malla, corrección de pesos y ajustes de exportación. Úsala cuando el usuario tenga un modelo de personaje y quiera que ande, corra o actúe sin animar a mano, o cuando su personaje con rig se deforme mal."
---

# Poner tu personaje a andar sin ser animador

## Qué hace
Deja tu personaje listo para el rigging automático, te guía en el proceso y te enseña a detectar y corregir las deformaciones feas en codos, hombros, rodillas y cuello.

## Cuándo se activa
Cuando el usuario tiene un personaje y quiere animarlo, menciona Mixamo, huesos, rig, esqueleto, retarget, o dice que a su personaje "se le rompe el hombro" al moverse.

## Qué preguntar si falta información
1. ¿El personaje es humanoide (dos brazos, dos piernas) o una criatura rara?
2. ¿De dónde sale: Blender, IA generativa, escaneo, comprado?
3. ¿Motor de destino: Unity, Unreal, Godot, o sólo render en Blender?
4. ¿Lleva ropa suelta, capa, pelo largo o accesorios que cuelguen?

## Método paso a paso
1. **Comprueba que es riggeable.** Debe ser una malla cerrada o casi, sin piezas flotando lejos del cuerpo, sin brazos pegados al torso y sin dedos fusionados en un bloque si quieres que agarre cosas.
2. **Pose de partida**: T-pose (brazos rectos en cruz) o A-pose (brazos a 45 grados). Piernas ligeramente separadas, palmas hacia abajo, sin rotación de muñeca. Si el modelo vino en pose de acción, hay que posarlo antes.
3. **Escala y orientación**: 1,7-1,8 m de alto, mirando al frente, en el origen del mundo, con transformaciones aplicadas y modificadores aplicados (o al menos el espejo).
4. **Unifica la malla**: junta cuerpo, ropa y accesorios en un solo objeto si vas a usar rigging automático (Mixamo funciona mucho mejor con una sola malla).
5. **Limpia**: sin vértices dobles, sin caras interiores, sin partes desconectadas dentro del cuerpo. Los ojos como esferas separadas suelen dar problemas: mejor unirlos o riggearlos aparte después.
6. **Exporta FBX** con escala aplicada, sin cámaras ni luces, con las texturas incrustadas si el servicio las acepta.
7. **Rigging automático**: sube a Mixamo, coloca los marcadores de barbilla, muñecas, codos, rodillas e ingle con cuidado (aquí se juega el 80% del resultado), elige el nivel de dedos y espera.
8. **Prueba con una animación agresiva**, no con la de estar quieto: elige una de baile o de correr. Los fallos aparecen en poses extremas.
9. **Mira estos cuatro puntos**: hombro (¿se hunde el pecho al levantar el brazo?), codo (¿se estrecha como un espagueti?), rodilla (¿pierde volumen?), cuello y mandíbula (¿se estira la cara?).
10. **Arregla pesos en Blender**: modo Pintar pesos, pincel suave, valores 0,1-0,3, y suaviza en las zonas de transición. Regla básica: en una articulación cada vértice reparte su peso entre dos huesos, y la suma da 1.
11. **Descarga las animaciones** que necesites: idle, andar, correr, saltar, ataque, muerte. En Mixamo, para el motor descarga sin piel (Without Skin) todas menos la primera, y usa una sola malla.
12. **En Unity**: importa, pon el Rig como Humanoid, comprueba el mapa de huesos en Configure y activa el bucle en las animaciones cíclicas. En Unreal usa el IK Retargeter contra el esqueleto del Mannequin.
13. **Ajusta la raíz**: si el personaje patina al andar, el problema es el movimiento de raíz (root motion) activado o desactivado donde no toca.

## Errores típicos
- Ropa suelta o capa incluida en el rig automático: se queda pegada a las piernas. Se resuelve con huesos extra o simulación de tela.
- Modelo generado con IA con malla densa y sin bucles en las articulaciones: se dobla como plastilina. La solución real es retopologizar el torso y los brazos.
- Personaje en pose de acción exportado tal cual: el rigging automático coloca los huesos torcidos.
- Escala en centímetros: Mixamo lo acepta y luego en Unity aparece un gigante o una hormiga.
- Manos con dedos pegados: el rig les mete huesos que no puede separar.
- Dos personajes con proporciones muy distintas compartiendo animación sin retarget: los pies atraviesan el suelo.

## Formato exacto de la respuesta
1. **Diagnóstico de riggeabilidad**: apto, apto con arreglos o hay que retopologizar.
2. **Lista de preparación** ordenada, con la acción exacta en Blender.
3. **Guía del rigging automático** con los ajustes concretos a elegir.
4. **Chequeo de deformación**: los cuatro puntos, qué mirar y cómo arreglar cada uno.
5. **Lista de animaciones** recomendada para el tipo de juego que tenga.
6. **Ajustes de importación** en su motor, campo por campo.

## Avisos honestos
- El rigging automático es bueno para humanoides normales. Para criaturas, monstruos con cuatro brazos o personajes muy estilizados hay que riggear a mano.
- Los servicios online de rigging cambian de condiciones y de disponibilidad; si el que uses no está, la alternativa en Blender es un complemento de rig automático.
- Los dedos y la cara siguen siendo trabajo fino: el rig automático te da un personaje que se mueve, no un personaje que actúa.
