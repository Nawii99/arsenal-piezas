---
name: licencias-assets-juego
description: Audits every third-party asset in a game project - models, textures, music, SFX, fonts, plugins, AI-generated content - against its licence, and produces an inventory with required attributions and replacement actions. Use before publishing a game, demo or trailer, or before adding downloaded assets to a commercial project.
---

# Auditoría de licencias de un proyecto de juego

## Qué hace

Hace inventario de todo lo que no has creado tú dentro del proyecto, comprueba bajo qué licencia está y te dice qué puedes usar, qué tienes que atribuir y qué hay que sustituir antes de cobrar por el juego.

## Cuándo se activa

Cuando el usuario va a publicar un juego o una demo, ha descargado assets gratis, ha usado música o fuentes de internet, ha generado contenido con IA o le preocupa una reclamación de derechos.

## Qué preguntar

1. Lista de fuentes de las que ha sacado cosas: tiendas, webs de assets gratis, packs de humble bundle, generadores de IA.
2. ¿El juego se va a vender, va a ser gratis con anuncios o completamente gratis? Cambia qué licencias valen.
3. ¿Hay contenido de terceros en el tráiler y en las capturas, además del juego?
4. ¿Hay marcas, coches reales, canciones conocidas o personajes de otras obras?

## Método

### 1. Inventario

Recorre el proyecto por carpetas y anota cada asset ajeno: modelos, texturas, HDRIs, sonidos, música, fuentes tipográficas, plugins del motor, fragmentos de código y contenido generado con IA. Registra el nombre, de dónde salió, la URL y la licencia que decía en el momento de la descarga. Guarda una captura de la página de licencia: si años después cambia, esa captura es tu prueba.

### 2. Traducir las licencias

- CC0 / dominio público: úsalo sin atribuir. Lo más cómodo.
- CC-BY: puedes usarlo comercialmente pero DEBES atribuir con el nombre, el enlace y la licencia. Sin la atribución, estás infringiendo.
- CC-BY-SA: obliga a compartir derivados en la misma licencia. Peligroso en un proyecto comercial cerrado.
- CC-NC: prohibido uso comercial. Fuera de un juego que vendas o monetices.
- CC-ND: no permite modificarlo. Fuera si lo vas a retocar.
- Licencias de tienda (Unity, Fab, packs de assets): suelen ser por puesto de trabajo, no permiten redistribuir el asset suelto y a veces limitan el número de proyectos. Léelas de verdad.
- «Royalty free» no significa gratis ni libre: significa que pagas una vez y no pagas por copia vendida, dentro de los usos que indique el contrato.

### 3. Casos que se olvidan siempre

- Fuentes tipográficas: muchas gratuitas son solo para uso personal, o solo para escritorio y no para incrustar en un juego o en una app. Busca licencias tipo SIL Open Font License si quieres tranquilidad.
- Música: la licencia para el juego y la licencia para el tráiler de YouTube pueden ser distintas. Y el sistema de detección de YouTube reclama aunque tengas licencia; guarda el justificante.
- Sonidos de bancos comunitarios: cada archivo puede tener licencia distinta dentro de la misma web.
- Plugins y código: mira si son MIT, GPL u otras. GPL en un juego comercial cerrado da problemas.
- Marcas y parecidos: logos reales, nombres de coches, camisetas de equipos, canciones tarareadas. Rediseña.

### 4. Contenido generado con IA

- Anota qué herramienta se usó, con qué plan y qué dicen sus condiciones sobre uso comercial.
- Steam exige declarar el contenido generado con IA en el formulario de la tienda. Otras plataformas y concursos tienen sus propias reglas.
- Si un asset de IA reproduce un estilo o un personaje reconocible de otra obra, cámbialo.

### 5. Fichero de créditos

Monta un archivo de atribuciones dentro del juego y también en la página de tienda: nombre del asset, autor, enlace, licencia. Se hace en una tarde y te cubre.

## Formato de la respuesta

1. Tabla de inventario: asset, origen, licencia, uso comercial sí o no, atribución requerida, riesgo (alto, medio, bajo).
2. Lista de acciones: qué sustituir de forma urgente, qué atribuir, qué documentar.
3. Texto de créditos listo para pegar.
4. Checklist previo a publicar, incluida la declaración de contenido IA.
5. Carpeta sugerida de documentación de licencias y qué guardar dentro.

## Errores típicos

- Dar por hecho que «gratis» es «puedo venderlo».
- Usar una fuente descargada de una web de fuentes sin mirar la licencia.
- Poner música de un vídeo de YouTube etiquetado como «sin copyright».
- No guardar la prueba de la licencia en el momento de la descarga.
- Auditar el juego pero no el tráiler ni las capturas de la tienda.

## Avisos honestos

- Esto es una revisión práctica, no asesoramiento legal. Si hay dinero de por medio o dudas serias, consulta con un abogado de propiedad intelectual.
- Las condiciones de las herramientas de IA cambian con frecuencia: revisa la versión vigente el día que publiques, no la que leíste hace un año.
