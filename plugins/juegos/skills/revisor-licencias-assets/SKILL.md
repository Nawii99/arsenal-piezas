---
name: revisor-licencias-assets
description: Revisa las licencias de los assets (arte, musica, sonido, codigo, fuentes) que usa tu juego y te dice si puedes venderlo sin problema legal.
---

# Revisor de licencias de assets

Antes de publicar tu juego en Steam, itch.io o Google Play, hay que comprobar que cada asset que usas (sprites, musica, fuentes, plugins) tiene una licencia que permite uso comercial. Esto puede llevar horas revisando a mano decenas de assets; esta skill lo hace en minutos a partir de una lista.

## Que preguntar antes de empezar
- Pide la lista de assets: nombre, origen (Unity Asset Store, itch.io, Freesound, Kenney, OpenGameArt, generado con IA, comprado, propio) y, si la tiene, el texto de la licencia o el enlace.
- Pregunta si el juego se va a vender de pago, es gratis con donaciones, o gratis con publicidad: el tipo de licencia que necesitas cambia segun esto.
- Pregunta si vas a modificar los assets (recolorear, remezclar audio) porque algunas licencias no lo permiten.

## Paso a paso
1. Clasifica cada asset en: libre para uso comercial sin atribucion, libre con atribucion obligatoria, licencia de pago con limite de copias o de ingresos, licencia dudosa o sin encontrar, y generado con IA (revisa aparte: muchas plataformas de venta piden declarar contenido con IA).
2. Para cada asset con atribucion obligatoria, anota el texto exacto que hay que poner y donde (creditos del juego, pagina de tienda, o ambos).
3. Senala en rojo cualquier asset con licencia "solo uso personal", "no comercial" o sin licencia encontrada: estos bloquean la venta hasta que se resuelvan.
4. Si detectas un asset de IA generado con una herramienta cuyos terminos reclaman derechos sobre el contenido generado, marcalo como riesgo alto.
5. Genera una tabla final: asset, origen, tipo de licencia, atribucion necesaria, riesgo (ninguno/medio/alto), y que hacer antes de publicar.

## Que devolver
Una tabla en markdown con las columnas anteriores, un resumen con el numero de assets en riesgo alto, y un parrafo final con el texto exacto de atribucion que hay que copiar en los creditos o en la pagina de tienda.

## Que NO hacer
- No des por valida una licencia que no has visto: si el usuario dice "creo que es libre" pero no aporta enlace ni texto, marcalo como "sin verificar", no como "ninguno".
- No asumas que pagar por un asset da permiso automatico para reventa o para incluirlo en un asset pack propio: cada tienda tiene condiciones distintas.
- No sustituyas una consulta legal real si hay dinero serio en juego o dudas sobre una licencia compleja (por ejemplo, musica con sample de terceros); dilo explicitamente.
