---
name: preparar-pack-assets
description: Packages existing 3D/2D work into a sellable asset pack: folder structure, naming convention, formats, preview renders, store description, tags and licence. Use when the user wants to sell models, textures or sprites on Fab, itch.io, Gumroad, ArtStation or similar marketplaces.
---

# Convertir tus modelos en un pack que se vende

## Qué hace
Coge lo que ya tienes hecho y lo deja listo para publicar: qué incluir, cómo llamarlo, qué capturas hacen falta, qué poner en la ficha y qué licencia usar.

## Cuándo se activa
Cuando el usuario habla de vender assets, publicar un pack, subir modelos a una tienda, o pregunta por qué le han rechazado una subida.

## Qué preguntar si falta información
1. ¿Qué tienes exactamente y cuántas piezas?
2. ¿Tienda objetivo: Fab, itch.io, Gumroad, ArtStation, CGTrader?
3. ¿A qué público: desarrolladores de Unity/Unreal, ilustradores, impresión 3D?
4. ¿Todo es 100% tuyo y de origen limpio?
5. ¿Precio que tenías en mente?

## Qué hace que un pack se venda (y qué lo hunde)
- **Coherencia por encima de cantidad.** Diez props del mismo estilo y misma paleta valen más que cuarenta piezas sueltas que no pegan entre sí.
- **Un tema claro**: "taberna medieval", "cocina moderna", "kit de cañería industrial". Un pack llamado "Objetos variados" no lo busca nadie.
- **Utilidad**: piezas modulares que encajan en cuadrícula (0,25 / 0,5 / 1 m) se usan más y se recomiendan más.

## Método paso a paso
1. **Define el tema y la lista de piezas.** Si falta la pieza obvia del tema (la barra en una taberna, la cama en un dormitorio), hazla: es la primera que buscan.
2. **Unifica estilo**: misma densidad de téxeles, misma paleta, mismo tratamiento de bordes. Pasa todas las piezas por la auditoría de modelo.
3. **Estructura de carpetas** fija: /Models (FBX, OBJ, GLB), /Blender (fuente .blend), /Textures (por asset), /Previews, /Documentation, y en la raíz un README.txt y la licencia.
4. **Nombres consistentes**: SM_Taberna_Barril_A.fbx, T_Taberna_Barril_A_BaseColor.png, T_..._Normal.png, T_..._ORM.png. Nada de espacios, acentos ni mayúsculas aleatorias.
5. **Formatos**: FBX (compatibilidad universal), GLB (web y visores), OBJ sólo si el público es de impresión, más el archivo fuente. Texturas en PNG, potencia de dos.
6. **Escala y orientación** iguales en todas las piezas: metros, origen en la base, frente al mismo lado.
7. **Capturas**: mínimo una portada cuadrada legible en miniatura (el nombre del pack grande y 3-5 piezas), una lámina con todas las piezas sobre fondo neutro, una escena montada que enseñe para qué sirve, una captura de los wireframes y otra de las texturas. La imagen de wireframe genera confianza y casi nadie la pone.
8. **Ficha de tienda**: título con tema + tipo + estilo ("Taberna medieval - 32 props modulares - estilo estilizado"), primeras dos líneas con lo que incluye y para qué motor, luego lista de piezas con conteo de triángulos, y al final formatos y licencia.
9. **Etiquetas**: mezcla tema, estilo, motor y uso (medieval, taberna, props, modular, stylized, unity, unreal, low poly). Diez o doce, sin repetir.
10. **Licencia**: decide entre uso comercial con atribución, uso comercial sin atribución, o licencia extendida. Prohíbe explícitamente revender el asset tal cual y entrenar modelos de IA con él si eso te importa.
11. **Prueba de importación**: monta un proyecto vacío de Unity y otro de Unreal (o pide a alguien que lo haga) e importa el zip como lo recibiría el comprador. Si algo se ve rosa, magenta o gris, no está listo.
12. **Versiona**: v1.0 en el README con fecha y contenido. Cuando añadas piezas, sube versión y avisa a los compradores: eso genera reseñas buenas.

## Errores típicos
- Portada con letra pequeña que no se lee en la miniatura de la tienda.
- Texturas enlazadas con rutas de tu ordenador dentro del .blend.
- Meter un modelo descargado de un banco gratuito "para completar": es la vía rápida a la retirada del pack y al cierre de cuenta.
- Escalas mezcladas entre piezas hechas en semanas distintas.
- No decir el número de triángulos: el comprador de móvil se va sin preguntar.
- Precio por instinto: mira 10 packs parecidos de la tienda y colócate en el rango, no un 70% por debajo.

## Formato exacto de la respuesta
1. **Nombre del pack** y una frase de posicionamiento.
2. **Lista de piezas** con lo que falta por hacer marcado.
3. **Árbol de carpetas** exacto en bloque de código.
4. **Tabla de nombres** de archivo para las tres primeras piezas, como plantilla.
5. **Guion de capturas**: qué muestra cada imagen y cómo se monta.
6. **Texto de la ficha** listo para pegar (título, descripción, lista, etiquetas).
7. **Texto de licencia** en español y en inglés, corto.
8. **Checklist final** antes de subir.

## Avisos honestos
- Los requisitos concretos de cada tienda cambian; comprueba en su página de subida antes de publicar y avísame de las diferencias.
- Vender assets es un ingreso lento y acumulativo: el primer pack casi nunca paga las horas, el quinto empieza a hacerlo.
- No puedo revisar tus archivos si no me los describes; cuéntame qué tienes y te digo qué falta.
