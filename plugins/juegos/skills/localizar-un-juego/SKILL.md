---
name: localizar-un-juego
description: Prepares a game or app for translation: extracting hardcoded strings into keys, writing translator context, handling plurals, placeholders, text expansion, fonts and on-screen QA. Use when someone wants to publish in more languages or their texts are hardcoded in the code.
---

# Localizar tu juego a otros idiomas

## Qué hace
Ordena todos los textos del juego en un sistema traducible, genera el contexto que un traductor necesita y define la revisión final en pantalla para que no salgan cortes ni sinsentidos.

## Cuándo se activa
Cuando el usuario quiere añadir idiomas, ha recibido una traducción y no sabe cómo meterla, o le han dicho que su juego 'no está internacionalizado'.

## Qué preguntar
1. ¿Qué motor o tecnología usas: Unity, Godot, Unreal, HTML, Ren'Py?
2. ¿Cuántas palabras hay aproximadamente y cuánto es diálogo frente a interfaz?
3. ¿A qué idiomas y por qué esos? ¿Hay datos que lo justifiquen?
4. ¿Hay voces grabadas, textos dentro de imágenes o texturas con letras?
5. ¿Quién traduce: profesional, comunidad o máquina con revisión?

## Método paso a paso
1. **Saca los textos del código**: cada texto pasa a una clave estable y descriptiva. `menu.opciones.volumen_musica`, no `texto_23`. La clave nunca cambia aunque cambie el texto.
2. **Un fichero por idioma** en CSV, JSON o el formato del motor, con la misma lista de claves. El idioma origen es la referencia.
3. **Nada de frases montadas por trozos**. 'Has conseguido' + objeto + 'monedas' es imposible de traducir bien. Usa una frase completa con marcadores: `Has conseguido {cantidad} {objeto}`.
4. **Plurales y géneros**: define variantes por cantidad y evita construcciones que dependan del género del objeto si el sistema no lo soporta. Reformula: en vez de 'el {objeto} está roto', usa '{objeto}: roto'.
5. **Contexto para el traductor**: por cada clave, añade una columna con dónde aparece, límite de caracteres, si es botón o diálogo, y quién habla. Sin contexto, 'Fire' se traduce como 'fuego' cuando era 'disparar'.
6. **Prevé la expansión**: del inglés al español o al alemán el texto crece bastante. Diseña botones y cuadros con margen o texto que se ajusta, y prueba con la cadena más larga.
7. **Tipografías**: comprueba que la fuente tiene los glifos que necesitas (acentos, ñ, ç, cirílico, caracteres asiáticos). Si vas a chino, japonés o coreano, casi seguro necesitas otra fuente y otro salto de línea.
8. **Texto en imágenes**: cualquier letra dentro de una textura o de un logo hay que rehacerla por idioma; localízalas como capa aparte o evítalas.
9. **Formatos locales**: fechas, decimales con coma, unidades, moneda, orden de nombre.
10. **Revisión en pantalla (LQA)**: el paso que casi todo el mundo se salta. Recorre el juego en cada idioma buscando texto cortado, solapado, sin traducir o fuera de contexto.

## Detalles del español que conviene decidir
- Español de España o neutro para Latinoamérica: 'coger', 'ordenador', 'vosotros' marcan mucho. Elige y sé coherente.
- Tuteo o usted en la interfaz: en juegos, tuteo casi siempre.
- Verbos de botón en infinitivo ('Guardar') y no en imperativo mezclado.

## Errores típicos
- Traducir con máquina y publicar sin revisar: los jugadores lo detectan y lo dicen en las reseñas.
- Cambiar el texto original y no avisar a los traductores: quedan idiomas desincronizados.
- Usar la misma clave para dos sitios distintos porque 'pone lo mismo en inglés'.
- Olvidar los textos de la ficha de tienda, las capturas y la política de privacidad.
- No dejar el idioma cambiable dentro del juego y depender del idioma del sistema.

## Formato de la respuesta
1. Plan de localización con fases y orden.
2. Estructura de ficheros y ejemplo de las primeras claves bien nombradas.
3. Plantilla de tabla para el traductor: clave, texto origen, contexto, límite de caracteres, traducción.
4. Lista de textos problemáticos detectados (concatenaciones, texto en imágenes, plurales).
5. Checklist de revisión en pantalla, pantalla por pantalla.

## Avisos honestos
- Traducir cuesta dinero o tiempo y no garantiza ventas en ese país; empieza por uno o dos idiomas y mide.
- La traducción automática sirve para textos de interfaz simples si luego los revisa alguien que hable el idioma; para diálogo con tono, no.
- Localizar al final del desarrollo cuesta el triple que preparar las claves desde el principio.
