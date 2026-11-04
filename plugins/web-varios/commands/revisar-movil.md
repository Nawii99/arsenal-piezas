---
description: Audita una página HTML para móvil, detecta los fallos de responsive típicos y entrega el CSS corregido
argument-hint: [ruta del archivo HTML o carpeta del proyecto]
---

Vas a auditar para móvil: $ARGUMENTS

Si no te han dado ruta, pregúntala y espera. Lee el HTML y todo el CSS asociado antes de opinar. Nada de conclusiones sin haber leído el código.

## Paso 1: comprobaciones estructurales
- ¿Existe <meta name="viewport" content="width=device-width, initial-scale=1"> en el head? Si falta, el móvil dibuja la página a 980 px y todo sale minúsculo. Es el primer fallo a mirar siempre.
- ¿Hay maximum-scale=1 o user-scalable=no? Quítalo: impide hacer zoom y es un problema de accesibilidad.

## Paso 2: caza el scroll lateral
Busca en el CSS y el HTML las causas habituales de que la página se desplace a los lados en móvil:
- Anchos fijos en píxeles: width: 1200px, min-width en contenedores.
- Imágenes sin max-width: 100%.
- Tablas anchas sin contenedor con overflow-x: auto.
- position: absolute con left o right negativos.
- Bloques de código o URLs largas sin overflow-wrap: anywhere.
- Padding grande sumado a width: 100% sin box-sizing: border-box.
Lista cada caso con archivo, selector y línea.

## Paso 3: legibilidad y uso con el dedo
- Texto del cuerpo por debajo de 16px: en móvil se lee mal y en iPhone hace zoom automático en los formularios. Sube a 16px como mínimo.
- Botones y enlaces con menos de 44x44 px de zona pulsable: se falla al tocar.
- Enlaces pegados unos a otros sin separación.
- Menú de navegación horizontal que no cabe: propón menú hamburguesa o enlaces apilados.
- Formularios con inputs estrechos o labels encima muy pequeños.
- Titulares gigantes que en móvil ocupan tres cuartos de pantalla: usa clamp() para que escalen.

## Paso 4: rendimiento visual en móvil
- Imágenes enormes servidas iguales en móvil: propón width y height en el HTML para evitar saltos de maquetación y loading="lazy" en las de abajo.
- Vídeos de fondo: en móvil consumen datos y batería; sugiere imagen fija.
- Fuentes web pesadas: propón font-display: swap.

## Paso 5: entrega
No reescribas la web entera. Cambia lo mínimo. Si el diseño usa flex o grid, respétalo y añade solo los media query necesarios en un bloque al final del CSS.
Usa el punto de corte 768px para tablet y 480px para móvil pequeño salvo que el proyecto ya use otros; si ya los usa, reutiliza los suyos.

## Formato de respuesta
1. Veredicto en una frase: se ve bien, tiene fallos menores o está roto en móvil.
2. Tabla: Problema / Dónde (archivo y línea) / Qué pasa al usuario / Gravedad (alta, media, baja).
3. Bloque de CSS corregido listo para pegar, con comentarios en español.
4. Cambios en el HTML si hacen falta, indicados por línea.
5. Cómo comprobarlo: abrir la web en el móvil real, girar la pantalla, deslizar con un dedo hacia los lados para ver si se mueve, y rellenar el formulario con el teclado abierto.

Pregunta antes de modificar archivos.
