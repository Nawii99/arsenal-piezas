---
description: Analiza el peso real de tu web y aplica los recortes que más rápido la hacen
argument-hint: "[carpeta de la web]"
---

Eres quien pone a dieta una web. Trabaja con datos reales de la carpeta, no con recomendaciones de manual.

Carpeta o contexto: $ARGUMENTS

PASO 1. Mide. Con comandos de sistema, lista el tamaño de todos los archivos de la carpeta ordenados de mayor a menor y suma el total. Separa imágenes, vídeos, fuentes, CSS y JS. Da el peso total de lo que se descarga al abrir la página de inicio.
Referencia honesta: por debajo de 1 MB la página va bien en móvil; por encima de 3 MB se nota mucho con datos móviles.

PASO 2. Señala a los culpables. Casi siempre son, por este orden:
1. Imágenes sin optimizar: fotos de 3000 píxeles de ancho puestas en un hueco de 400. Comprueba las dimensiones reales de cada imagen frente al tamaño en que se muestra en el CSS o el HTML.
2. Un vídeo de fondo en autoplay.
3. Fuentes: cada familia y cada grosor es una descarga. Tres familias con seis grosores es un despropósito.
4. Librerías enteras cargadas para usar una función: una librería de animaciones de 100 KB para un fade, un framework de CSS completo para tres botones, jQuery para un menú.
5. Iconos cargados como paquete completo de miles de iconos para usar cuatro.
6. Scripts de terceros: chats, mapas, píxeles, widgets de reseñas. Estos no pesan solo, además bloquean.

PASO 3. Aplica los arreglos que puedas hacer tú:
- Redimensiona las imágenes al doble del tamaño en que se ven como máximo, y conviértelas a WebP si hay herramienta disponible. Deja el original guardado.
- Añade loading="lazy" a todas las imágenes salvo la primera que se ve al abrir, que debe llevar fetchpriority="high" y NO lazy.
- Pon width y height en cada <img> para que la página no dé saltos al cargar.
- Reduce las fuentes a las estrictamente usadas y añade font-display: swap.
- Sustituye la librería usada para una tontería por CSS o JS propio, si el cambio es seguro.
- Carga los scripts de terceros con defer, o mejor solo cuando hagan falta (el chat, al pulsar un botón).
- Quita el CSS y el JS de la plantilla que ya no se usa, solo si compruebas que no se usa.

PASO 4. No hagas nunca esto, y dilo si el usuario lo pide: minificar a mano hasta dejar el código ilegible, quitar imágenes que sí hacen falta, o cambiar el diseño en nombre de la velocidad.

PASO 5. Vuelve a medir y compara.

PASO 6. Responde con este formato exacto:

## Antes
Peso total y los cinco archivos más pesados con su tamaño.

## Qué lo hacía lento
Lista ordenada por impacto real, con el peso que se lleva cada cosa.

## Lo que he hecho
Lista de cambios con el ahorro conseguido en cada uno.

## Después
Peso total nuevo y el porcentaje de reducción.

## Lo que tienes que hacer tú
Lo que requiere una decisión suya: quitar el vídeo de fondo, reducir a dos fuentes, retrasar el chat. Cada punto con el ahorro estimado y lo que pierde a cambio, para que decida.

## Compruébalo
Dile que abra pagespeed.web.dev, pegue su dirección y mire la pestaña de móvil, no la de escritorio, antes y después. Y que pruebe la web con los datos del móvil y el wifi apagado.

REGLAS:
- Nada de consejos sin número: cada recomendación con su peso o su efecto.
- No rompas el aspecto de la web por ganar 20 KB.
- Guarda siempre los originales de las imágenes antes de tocarlas.
