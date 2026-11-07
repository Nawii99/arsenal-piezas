---
name: localizar-juego
description: "Prepara un juego pequeño para varios idiomas: extracción de cadenas a claves, reglas de traducción, expansión de la interfaz, fuentes y caracteres especiales, plurales y variables, localización de la página de tienda y lista de comprobación de LQA. Úsala cuando el usuario quiera publicar un juego o app 3D en más idiomas, o su interfaz traducida se desborde y se rompa."
---

# Traducir tu juego sin romperlo

## Qué hace
Te organiza los textos, te dice cómo traducirlos bien y qué se rompe siempre al cambiar de idioma, con la prueba final para no publicar un desastre.

## Cuándo se activa
Cuando el usuario habla de traducir su juego, idiomas, localización, i18n, o cuando el texto se le sale de los botones.

## Qué preguntar si falta información
1. ¿Cuántos textos tiene el juego, más o menos: 50 frases, 500, 20.000 de diálogo?
2. ¿Motor y si ya usas un sistema de idiomas o los textos están escritos dentro del código y de las escenas?
3. ¿Qué idiomas te interesan y por qué?
4. ¿Hay voces grabadas o sólo texto?

## Qué idiomas primero (criterio práctico)
Para un juego pequeño con presupuesto corto: inglés siempre, luego chino simplificado, español latinoamericano/español, alemán, portugués de Brasil, ruso, francés y japonés según el género. Cada idioma añade mantenimiento: es mejor cuatro bien hechos que diez con traducción automática sin revisar.

## Método paso a paso
1. **Saca los textos del código.** Cada frase pasa a una clave en un archivo (CSV, JSON o el sistema del motor): ui.boton.jugar, dialogo.herrero.001, item.espada.nombre, item.espada.desc. Sin esto, cada cambio te obliga a tocar el juego entero.
2. **Nunca construyas frases juntando trozos.** "Has ganado" + numero + "monedas" no funciona en otros idiomas. Usa una frase completa con variable: "Has ganado {n} monedas".
3. **Plurales**: define reglas por idioma. Hay idiomas con una forma, dos o seis. Si tu sistema no lo soporta, escribe frases que esquiven el plural ("Monedas: 1").
4. **Espacio en pantalla**: el alemán y el español pueden ocupar un 30% más que el inglés; el ruso más aún; el chino y el japonés bastante menos. Diseña botones con margen o con texto que se autoajuste, y prohíbe textos pegados al borde.
5. **Fuente**: comprueba que tu tipografía tiene ñ, acentos, ¿, ¡, ü, ç y las cedillas. Para chino, japonés o coreano necesitas fuentes específicas y, en Unity, atlas dinámicos porque son miles de caracteres.
6. **Contexto para el traductor**: junto a cada clave, una nota de contexto y una captura si es un botón. Sin contexto, "Fire" se traduce como "fuego" cuando era "disparar". Es el error clásico.
7. **Glosario**: nombres propios, objetos y habilidades con su traducción fija, y lo que NO se traduce (el nombre del juego, marcas). Se pasa a todos los traductores.
8. **Traducción**: humano nativo del idioma para textos de venta y narrativa; traducción automática sólo como borrador para textos de interfaz, y siempre revisada por alguien que hable el idioma. Un juego con traducción automática visible recibe reseñas negativas.
9. **Formatos locales**: fechas, decimales (coma en español, punto en inglés), moneda y unidades. Nunca escribas precios a mano en el juego.
10. **Localiza también la ficha de tienda**: título, descripción corta, etiquetas y capturas con texto. Muchas veces la ficha traducida rinde más que el juego traducido.
11. **Prueba con textos falsos**: antes de traducir, sustituye cada texto por su versión alargada un 40% y llena de acentos. Todo lo que se rompa, se rompe también en alemán.
12. **LQA**: alguien juega el juego entero en cada idioma haciendo capturas de todo lo que se salga, se corte o no tenga sentido. Es la fase que todo el mundo se salta y la que se nota.

## Errores típicos
- Textos escritos directamente en las escenas y en los botones del motor: rehacerlo cuesta más que el resto de la localización junta.
- Imágenes con texto dentro (carteles, tutoriales dibujados): hay que rehacer la imagen por idioma. Evítalo desde el principio.
- Traducir con IA y publicar sin revisión nativa: en chino y japonés se nota muchísimo y lo dicen en las reseñas.
- Olvidar el saltarse el idioma del sistema: da siempre la opción de cambiar de idioma en el menú, no lo fuerces por región.
- Cadenas con género o número que no se pueden traducir bien: cambia el diseño de la frase, no busques trucos.
- Traducir la interfaz y dejar los tutoriales en inglés: peor que no traducir.

## Formato exacto de la respuesta
1. **Diagnóstico**: si su proyecto está listo para localizar o hay que extraer textos primero.
2. **Estructura de claves** propuesta, con 10 ejemplos reales de su juego.
3. **Archivo de idiomas** de muestra en el formato de su motor.
4. **Glosario inicial** con lo que no se traduce.
5. **Reglas de diseño** de interfaz para que aguante la expansión.
6. **Plan de idiomas** por orden y coste aproximado de esfuerzo (no de dinero).
7. **Checklist de LQA** para marcar mientras se juega.

## Avisos honestos
- No puedo garantizar la calidad de una traducción a un idioma que no vas a poder revisar: si nadie lo comprueba, es una apuesta.
- Traducir tiene coste de mantenimiento: cada actualización de textos hay que propagarla a todos los idiomas.
- Si tu juego tiene mucho texto narrativo, localizar es un proyecto en sí mismo; empieza por la interfaz y la ficha de tienda, y valora la narrativa aparte.
