---
name: reencuadre-multiformato
description: Adapta una imagen a todas las proporciones necesarias (1:1, 4:5, 9:16, 16:9, banners panorámicos) con reglas de punto focal, zonas seguras por plataforma, outpainting y nomenclatura de archivos, sin recortar el contenido clave ni deformarlo. Úsala cuando el usuario tenga una buena imagen y la necesite para el feed, Stories, cabecera web, anuncios o miniaturas.
---

# Una imagen, todos los formatos

## Qué hace
Convierte una imagen en el juego completo de formatos que necesitas, decidiendo qué se recorta y qué se amplía.

## Cuándo se activa
Cuando una imagen tiene que vivir en varios sitios, cuando la cabecera de la web corta la cabeza al modelo, o cuando un anuncio se rechaza por proporción.

## Método
### 1. Marca el punto focal y la zona intocable
Define en la imagen: el sujeto principal, el texto si lo hay y el margen mínimo que debe quedar alrededor. Todo lo que esté fuera de esa zona es sacrificable.

### 2. Elige la estrategia
- Recortar: si la imagen tiene aire de sobra. Es la primera opción, no pierde calidad.
- Ampliar el lienzo (outpainting o generación con más aire): cuando el formato es más alto o más ancho que el original. Se hace con IA o extendiendo un fondo liso.
- Regenerar nativo: si el cambio de proporción cambia la composición (un plano general no funciona en 9:16). Mejor volver a generar en vertical que estirar.
- Nunca deformar. Estirar un 5% ya se nota en caras y en círculos.

### 3. Proporciones y usos habituales
- 1:1 cuadrado: catálogo, ficha de producto, miniaturas de listado.
- 4:5 vertical: el que más ocupa en el feed de Instagram y Facebook.
- 9:16 vertical completo: Stories, Reels, TikTok, YouTube Shorts.
- 16:9 apaisado: YouTube, cabeceras, presentaciones.
- 3:1 o más ancho: banners de web y correo.

### 4. Zonas seguras
- En vertical de pantalla completa, la interfaz tapa una franja arriba y otra abajo bastante mayor: deja el 15% superior y el 20% inferior sin nada importante.
- En cabeceras web, el móvil recorta por los lados: centra el sujeto y no pongas texto en los extremos.
- En miniaturas, la esquina inferior derecha suele quedar tapada por la duración del vídeo.

### 5. Entrega
- Exporta cada formato a su medida en píxeles, no escales en el CMS.
- Nombra los archivos igual con sufijo de formato: producto-mesa-roble_1x1.jpg, _4x5.jpg, _9x16.jpg.
- Revisa cada versión al tamaño real en el móvil antes de publicar.

## Qué preguntar si falta información
- ¿Cuál es la imagen original y en qué resolución está?
- ¿En qué canales exactamente la vas a usar?
- ¿Lleva texto encima o el texto lo pone la plataforma?
- ¿Hay un elemento que no se puede cortar nunca (logo, cara, etiqueta)?

## Formato de la respuesta
1. Diagnóstico de la imagen: dónde está el punto focal y cuánto aire hay.
2. Tabla: formato, medida en píxeles, estrategia (recortar / ampliar / regenerar) y qué se pierde.
3. Instrucciones de recorte concretas para cada formato (por dónde cortar).
4. Prompt de outpainting o de regeneración cuando haga falta, en inglés.
5. Nomenclatura de archivos y checklist final.

## Errores típicos
- Dejar que la plataforma recorte por su cuenta: siempre corta por el centro geométrico, no por el sujeto.
- Ampliar una imagen pequeña para una cabecera: se ve blanda en pantallas buenas.
- Poner el texto en la misma posición en todos los formatos sin comprobar las zonas de interfaz.
- Generar el vertical estirando el horizontal: caras alargadas.
- Guardar todas las versiones con el mismo nombre y perder el rastro.

## Avisos honestos
- El outpainting inventa lo que no había. Revísalo: en fondos lisos va bien, en escenas con estructura (baldosas, estanterías, arquitectura) suele fallar en la continuidad de las líneas.
- Si la imagen de partida es mala, ningún reencuadre la salva. Antes de multiplicar formatos, asegúrate de que la original merece la pena.
- Las medidas recomendadas de cada red cambian; comprueba la vigente antes de una campaña grande.
