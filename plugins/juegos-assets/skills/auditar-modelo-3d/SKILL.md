---
name: auditar-modelo-3d
description: Audita un modelo 3D (escala, topología, normales, UVs, materiales, nomenclatura) antes de entregarlo, venderlo o importarlo a un motor, y devuelve una lista de comprobación de apto/no apto con arreglos concretos. Úsala cuando el usuario vaya a entregar, vender o importar un asset 3D, o pregunte si un modelo está «bien hecho», limpio o listo para juego.
---

# Auditar un modelo 3D antes de entregarlo

## Qué hace
Te da un control de calidad de un modelo 3D con criterios de estudio: qué mirar, en qué orden, cómo comprobarlo en Blender sin saber programar y cómo se arregla cada fallo.

## Cuándo se activa
Cuando el usuario dice que va a entregar, vender o importar un modelo; cuando pregunta si su .fbx/.glb/.obj está bien; cuando le han rechazado un asset y no sabe por qué.

## Qué preguntar si falta información
1. ¿Para qué es el modelo: juego en tiempo real, render/imagen, impresión 3D o web?
2. ¿Qué formato tienes y de dónde sale (Blender, escaneo, IA tipo Meshy/Tripo, comprado)?
3. ¿Motor o destino final: Unity, Unreal, Godot, web con three.js, impresión?
4. ¿Tiene que animarse o es estático?
Si no contesta, asume: juego en tiempo real, Blender, formato glb, estático, y dilo en la respuesta.

## Método (en este orden, no lo cambies)
1. **Escala y unidades.** Un personaje humano mide 1,7-1,8 m; una puerta 2,1 m; una taza 0,10 m. En Blender, mira N > Dimensiones. Si el objeto mide 170 o 0,017, la escala está en centímetros o milímetros. Arréglalo escalando y aplicando (Ctrl+A > Escala).
2. **Transformaciones aplicadas.** Escala debe ser 1,1,1 y rotación 0. Si no, en el motor aparecen luces y físicas raras.
3. **Origen y orientación.** El origen va en la base del objeto (o en su centro de gravedad si cuelga), y el frente mira hacia -Y en Blender (+Z arriba). Unity usa Y arriba: exportar a FBX con Y-up.
4. **Normales.** Activa Superposiciones > Normales de cara o el modo de comprobación de caras. Caras azules bien, rojas invertidas. Arreglo: Shift+N (recalcular fuera) y, si hay huecos, revisar a mano.
5. **Geometría sucia.** Busca vértices sueltos y dobles (M > Combinar por distancia, 0,0001), caras de longitud cero, caras interiores que no se ven y nunca se verán.
6. **Topología.** Para tiempo real, cuads y triángulos son válidos; los n-gons (más de 4 lados) sólo se toleran en superficies planas. Si el modelo se deforma con huesos, hacen falta bucles de aristas limpios en codos, rodillas, hombros y boca.
7. **Densidad de polígonos.** Comprueba que el detalle está donde se ve. Miles de triángulos escondidos bajo la ropa o dentro de un cofre son coste puro.
8. **UVs.** Abre el editor UV: no debe haber islas superpuestas (salvo simetría intencionada), ni islas fuera del cuadro 0-1, y la densidad de téxeles debe ser parecida en todo el modelo (referencia habitual: 512 a 1024 píxeles por metro).
9. **Materiales y texturas.** Cuenta materiales: cuantos menos, mejor (idealmente 1-3 por asset). Texturas en potencia de dos (1024, 2048), y nunca 4096 si el objeto ocupa media pantalla como mucho.
10. **Nombres.** Nada de "Cube.001" ni "material.003". Usa un patrón: SM_Cofre_A, T_Cofre_A_BaseColor, T_Cofre_A_Normal, M_Cofre_A.
11. **Prueba de fuego.** Exporta e importa en el destino real (o abre el glb en un visor). Si al importar cambia de tamaño, gira o pierde texturas, el fallo está en el exportador, no en el motor.

## Errores típicos que verás una y otra vez
- Modelos de IA generativa: malla densa e irregular, sin UVs útiles, textura pintada encima. Sirven para render, casi nunca para animar; hay que retopologizar.
- Escaneos y modelos de bancos gratuitos con escala en centímetros.
- Normales invertidas sólo en algunas caras: se nota porque partes del objeto se ven negras o transparentes.
- Texturas enlazadas por ruta absoluta del ordenador: al enviar el archivo, el cliente ve el modelo gris.
- Exportar FBX con la opción "Only Selected" desactivada y meter dentro cámaras, luces y la basura de la escena.

## Formato exacto de la respuesta
1. **Veredicto**: APTO, APTO CON ARREGLOS o NO APTO, en una línea.
2. **Tabla de comprobación**: una fila por punto del método con estado (OK / Revisar / Falla) y qué se ha visto.
3. **Arreglos ordenados por impacto**: máximo 8, cada uno con la acción concreta y dónde se hace.
4. **Ficha de entrega**: nombres de archivo propuestos, formato, escala, número de materiales y tamaño de texturas.
5. **Qué decirle al cliente**: dos frases para el email de entrega.

## Avisos honestos
- Sin ver el archivo sólo puedo guiarte para que lo compruebes tú: pídeme que te dé los pasos exactos en Blender y dime lo que ves.
- Un modelo puede estar perfecto para render y ser inservible para un juego: la auditoría cambia según el destino.
- Retopologizar un escaneo o un modelo de IA es trabajo real, de horas, no un botón. Si lo vas a vender, cuéntalo en el precio.
