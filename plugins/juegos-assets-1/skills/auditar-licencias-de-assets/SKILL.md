---
name: auditar-licencias-de-assets
description: Audits every third-party asset in a game or 3D project (models, textures, sound, music, fonts, plugins, AI-generated content) against its licence, and produces the credits file plus the fixes needed before release. Use before publishing or selling a game, demo or 3D project built with downloaded or AI-generated resources.
---

# Auditoría de licencias de tu juego o proyecto 3D

## Qué hace
Recorre todo lo que hay en tu proyecto que no has hecho tú, comprueba qué permite cada licencia y te deja una lista de arreglos y el fichero de créditos.

## Cuándo se activa
Cuando el usuario va a publicar en Steam, itch.io, Google Play, App Store o va a vender un proyecto, y ha usado recursos descargados, comprados o generados con IA.

## Qué preguntar
1. ¿Dónde vas a publicar y vas a cobrar por ello?
2. ¿Tienes lista de fuentes de descarga o hay que reconstruirla?
3. ¿Has usado IA para arte, voces, música o texto?
4. ¿Has usado modelos de Mixamo, Sketchfab, bancos gratuitos, asset stores?
5. ¿Hay alguna marca, personaje o música reconocible?

## Método paso a paso
1. **Inventario**: lista todos los ficheros de arte, sonido, tipografías y complementos, y para cada uno anota origen exacto (URL o tienda), autor, licencia y fecha de descarga. Si no recuerdas el origen, va a la lista roja.
2. **Clasifica por licencia**:
   - CC0 / dominio público: uso libre, incluso comercial, sin atribución. Aun así, guarda la prueba de origen.
   - CC-BY: comercial permitido pero atribución obligatoria y con el formato que pide el autor.
   - CC-BY-NC: prohibido en cualquier cosa que genere dinero, incluida una demo con enlace a compra.
   - CC-BY-SA: obliga a compartir derivados con la misma licencia; peligroso en un juego comercial.
   - Licencias de tienda (Unity, Fab, Sketchfab de pago): normalmente permiten usar el asset dentro de tu juego, pero prohíben redistribuirlo como asset suelto o dentro de plantillas.
   - Tipografías: la SIL OFL permite uso comercial; muchas 'gratis para uso personal' no.
3. **Casos peligrosos concretos**: modelos rippeados de otros juegos, música de vídeos de YouTube, sonidos de bancos con licencia de suscripción caducada, texturas de fotos ajenas, personajes reconocibles.
4. **IA**: revisa las condiciones de la herramienta usada (quién es dueño de la salida, si hay restricciones comerciales en el plan gratuito) y ten en cuenta que Steam exige declarar el uso de contenido generado con IA en el cuestionario de la ficha.
5. **Voces y personas**: usar la voz o la cara de una persona real, incluso clonada, necesita permiso escrito.
6. **Arregla**: para cada asset problemático, decide sustituir, comprar licencia, pedir permiso por escrito o rehacer.
7. **Genera los créditos**: fichero CREDITOS.txt y pantalla de créditos dentro del juego, con autor, título, licencia y enlace.

## Cómo saber si estás cubierto
- Cada asset tiene origen documentado y una licencia guardada en copia.
- No hay ningún NC ni SA en un proyecto comercial.
- Los créditos son accesibles desde el propio juego, no solo en la web.
- Tienes guardadas facturas y capturas de las tiendas donde compraste.

## Errores típicos
- Pensar que 'gratis' significa 'libre'. Son cosas distintas.
- Creer que citar al autor arregla una licencia no comercial. No la arregla.
- Usar un asset de la Unity Asset Store dentro de una plantilla que luego se revende.
- Cambiar el modelo un poco y creer que ya es tuyo.
- Perder el rastro del origen y descubrirlo el día del lanzamiento.

## Formato de la respuesta
1. Tabla de inventario: fichero, origen, autor, licencia, uso comercial sí/no, riesgo.
2. Semáforo: verde (sin problema), ámbar (falta atribución o documentación), rojo (hay que sustituir).
3. Lista de acciones concretas ordenadas por urgencia.
4. Fichero CREDITOS.txt redactado y listo.
5. Nota sobre declaración de IA en la tienda de destino si aplica.

## Avisos honestos
- Esto es una revisión práctica de oficio, no asesoramiento legal. Si hay dinero serio en juego, consulta con un abogado especializado.
- Las condiciones de las tiendas y de las herramientas de IA cambian; comprueba la versión vigente en la fecha de publicación.
- Un asset en rojo hoy no significa que tu juego sea ilegal para siempre: casi siempre se arregla sustituyéndolo antes de publicar.
