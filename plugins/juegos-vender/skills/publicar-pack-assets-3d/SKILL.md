---
name: publicar-pack-assets-3d
description: "Prepara un pack de assets 3D para marketplaces (Fab, Unity Asset Store, CGTrader, Sketchfab, TurboSquid): checklist técnica, nomenclatura, escala, LODs, texturas, miniaturas, descripción y precio. Úsala cuando alguien tenga modelos y quiera venderlos como pack en lugar de hacer encargos puntuales."
---

# Publicar y vender un pack de assets 3D

## Qué hace
Convierte una carpeta de modelos sueltos en un producto vendible: coherencia, requisitos técnicos, presentación y ficha de tienda.

## Cuándo se activa
Cuando el usuario quiere vender modelos 3D, menciona Fab, Unity Asset Store, CGTrader, TurboSquid, Sketchfab Store o Blender Market, o pregunta cómo ganar dinero con sus modelos.

## Qué preguntar
1. ¿Qué modelos tienes y qué tienen en común? Sin tema común no hay pack.
2. ¿En qué programa están hechos y con qué formatos puedes exportar?
3. ¿Están texturizados con PBR? ¿Con qué resolución?
4. ¿Alguno usa recursos de terceros (texturas descargadas, HDRIs, complementos)?
5. ¿Para qué motor es el público objetivo: Unreal, Unity, Blender genérico, arquitectura?

## Cómo se define un pack que se vende
- Un tema claro y estrecho: 'puesto de mercado medieval, 25 piezas' vende mejor que '25 objetos variados'.
- Coherencia de estilo: misma densidad de polígonos, misma escala de textura (texeles por metro parecidos), misma paleta.
- Modularidad: piezas que encajan entre sí en una rejilla, normalmente de 0,5 o 1 metro.
- Un número de piezas que se pueda enumerar en el título y que suene a completo.

## Checklist técnico que piden las tiendas
1. Escala real: una puerta mide unos 2,1 m de alto; un personaje adulto 1,7-1,8 m.
2. Transformaciones aplicadas: escala 1, rotación 0, y origen en la base de cada objeto o en un punto lógico.
3. Nombres limpios y sistemáticos: `SM_Barril_A`, `T_Barril_A_BaseColor`. Nada de `Cube.001`.
4. UV sin solapes salvo que sea intencionado, y sin islas fuera del cuadro 0-1.
5. Texturas PBR completas: color base, normal, rugosidad, metalicidad, oclusión; formato PNG, potencias de dos.
6. Normales exportadas correctamente y comprobadas en el motor de destino, no solo en tu render.
7. Formatos de entrega: FBX y GLB casi siempre, más el fichero nativo si lo permites; añade OBJ si el público es de arquitectura.
8. LODs si el pack es para videojuegos; si no puedes, dilo en la descripción.
9. Documento LEEME con recuento de triángulos por pieza, resolución de texturas y cómo importar.

## Presentación (aquí se gana o se pierde la venta)
- Imagen principal: la escena completa montada, iluminada, en 1920x1080, con el nombre del pack legible.
- Una imagen por grupo de piezas sobre fondo neutro.
- Una imagen de mallas en modo alambre y otra de las texturas.
- Un giro de 360 grados en vídeo corto si la tienda lo admite.
- Todas las capturas con la misma luz y el mismo encuadre: la coherencia da sensación de profesionalidad.

## Precio y licencia
- Mira 5 packs comparables del mismo tema y sitúate dentro de su rango, no por debajo del todo.
- Decide exclusividad: publicar en varias tiendas suele rendir más que la exclusividad salvo condiciones muy buenas.
- Comprueba que ninguna textura, HDRI o modelo base descargado prohíbe la redistribución dentro de un producto. Esto es lo que más rechazos causa.

## Errores típicos
- Enviar un pack con escala en centímetros y que los usuarios lo importen gigante.
- Incluir texturas de bancos gratuitos cuya licencia prohíbe revenderlas dentro de un asset.
- Capturas renderizadas con Cycles y luces de estudio que no se parecen a lo que ve el comprador en su motor.
- Nombres de fichero con acentos o espacios: rompen importaciones en algunos motores.
- No probar el pack importándolo desde cero en un proyecto nuevo.

## Formato de la respuesta
1. Definición del pack: nombre, tema, número de piezas, público.
2. Checklist técnico marcado, con lo que falta por arreglar.
3. Estructura de carpetas exacta del ZIP de entrega.
4. Texto de la ficha: título, descripción con lista de contenido, etiquetas.
5. Plan de capturas: lista de las imágenes concretas a renderizar.
6. Rango de precio razonado y decisión de exclusividad.

## Avisos honestos
- La mayoría de packs vende poco al principio; lo que funciona es publicar varios en el mismo nicho y que se alimenten entre ellos.
- Las tiendas revisan y rechazan; el rechazo más común es técnico y se arregla, no es personal.
- Vender assets es ingreso pasivo lento, no un sustituto inmediato de los encargos.
