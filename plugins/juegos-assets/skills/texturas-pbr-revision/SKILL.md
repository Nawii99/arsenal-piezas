---
name: texturas-pbr-revision
description: Diagnostica por qué los materiales PBR se ven de plástico, apagados o incorrectos (espacio de color, rangos de albedo, valores de metallic y roughness, orientación del normal map, texel density, mapas empaquetados) y da la corrección exacta para cada mapa. Úsala cuando un modelo 3D se vea bien en la aplicación de modelado pero mal en el motor o en el render final.
---

# Revisión de materiales PBR

## Qué hace

Diagnostica el motivo real por el que un material se ve mal. El 90 % de las veces no es el arte: es un espacio de color equivocado, un valor imposible o un mapa mal conectado.

## Cuándo se activa

Cuando el usuario dice que su modelo se ve de plástico, apagado, demasiado brillante, negro, sin relieve, o que se ve distinto en Blender y en Unity o Unreal.

## Qué preguntar

1. ¿Qué mapas tienes y cómo se llaman?
2. ¿Dónde se ve mal: en el motor, en el render, en el visor web?
3. ¿De dónde salen las texturas: Substance, escaneo, IA, descargadas?
4. ¿Hay HDRI de iluminación o solo luces puntuales?
5. Captura o descripción de qué se ve exactamente.

## Método: la lista de sospechosos, en orden

### 1. Espacio de color

Es el fallo número uno. El color base (albedo) va en sRGB. La normal, la rugosidad, la metalicidad, la oclusión y el desplazamiento van en lineal / datos crudos. Si pones un mapa de datos en sRGB, todo se vuelve extrañamente claro y falso; si pones el color base en lineal, se ve oscuro y sucio.

### 2. Valores del color base

- El albedo no debe tener negros puros ni blancos puros. Rango razonable en sRGB: entre 30-50 en lo más oscuro y 240 en lo más claro.
- El color base no lleva luz ni sombra pintada. Si tu textura viene de una foto o de un escaneo, tiene sombras horneadas: hay que quitarlas o el objeto tendrá doble sombra.
- No multipliques la oclusión ambiental dentro del color base. La oclusión va en su propio mapa.

### 3. Metalicidad

Es prácticamente binaria: 0 para todo lo que no sea metal puro, 1 para el metal. Los valores intermedios solo existen en el borde entre dos zonas o en pintura desconchada. Si has puesto 0,5 «para que brille un poco», por ahí viene el aspecto de plástico raro.

### 4. Rugosidad

- Casi nada en el mundo real es perfectamente liso. Rugosidad 0 solo en espejos y cristal muy pulido.
- Una rugosidad plana y uniforme es lo que hace que un objeto parezca de juguete. Añade variación: rozaduras, polvo, huellas, bordes más pulidos por el uso.
- Ojo con la inversión: algunos flujos usan glossiness (lo contrario). Si el objeto se ve espejo cuando debería ser mate, es esto.

### 5. Mapa de normales

- Hay dos convenciones: DirectX y OpenGL, que se diferencian en el canal verde invertido. Unreal y Unity usan una, Blender y muchos exportadores la otra. Si el relieve parece hundido en lugar de salido, invierte el canal verde.
- La normal nunca se comprime con pérdida agresiva ni se guarda como JPEG de baja calidad: aparecen manchas.
- Si el modelo tiene bordes negros feos, revisa el horneado: probablemente falta espacio entre islas de UV o la jaula está mal.

### 6. Densidad de texel y UVs

- Elige un estándar de densidad para todo el proyecto (por ejemplo, 1024 píxeles por metro) y aplícalo a todas las piezas. Mezclar densidades es lo que hace que una escena parezca amateur.
- Comprueba con una textura de cuadrícula: los cuadros deben verse del mismo tamaño en todas las superficies y no estirados.
- Costuras visibles: colócalas donde no se miren, en aristas duras o zonas ocultas.

### 7. Mapas empaquetados

Muchos motores usan un solo archivo con tres canales: por ejemplo oclusión en rojo, rugosidad en verde, metalicidad en azul. Si el orden no coincide con lo que espera el motor, el objeto sale metálico o rugoso donde no toca. Documenta siempre el orden que usas.

### 8. Iluminación

Antes de culpar al material, prueba el objeto con un HDRI neutro de estudio. Muchos «materiales feos» son escenas mal iluminadas.

## Formato de la respuesta

1. Diagnóstico ordenado: causa más probable primero, con el porqué.
2. Tabla de mapas: nombre del mapa, espacio de color correcto, valores esperados, qué está mal.
3. Correcciones concretas, paso a paso, con el nombre del ajuste en el programa que use.
4. Prueba de validación: qué mirar para confirmar que ya está bien (esfera de prueba, cuadrícula, HDRI neutro).

## Errores típicos

- Guardar el mapa de normales en sRGB.
- Pintar sombras y brillos en el color base.
- Poner metalicidad intermedia en todo.
- Usar JPEG comprimido para mapas de datos.
- Comparar el resultado en dos programas con iluminaciones distintas y sacar conclusiones.

## Avisos honestos

- Un material correcto en valores puede seguir siendo poco atractivo: la belleza está en la variación y el desgaste, y eso es trabajo de arte, no de ajustes.
- Cada motor interpreta los materiales de forma ligeramente distinta; el objetivo es que se vea bien en el motor final, no en el visor de tu programa.
