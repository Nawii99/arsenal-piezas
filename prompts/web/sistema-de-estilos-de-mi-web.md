# sistema-de-estilos-de-mi-web…

**Tipo:** Prompt · **Área:** Web · **Licencia:** CC BY 4.0

Convierte tus colores y tu tipografía en un archivo de estilos reutilizable para que todas tus páginas se parezcan entre sí y montar la siguiente sea rápido.

## Qué es y qué hace

Prompt que genera un archivo CSS base con variables para que todas tus páginas HTML compartan estilo. Entran marca, colores y tipografía; sale una paleta por roles con contraste comprobado, escala tipográfica y componentes base. Se usa en cualquier chat de IA al crear varias páginas.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con tu marca
3. Guarda el CSS resultante como archivo común
4. Enlázalo en cada página nueva

## Cuándo usarla

Úsalo cuando cada página que generas con IA te sale con un aspecto distinto, o antes de hacer la segunda o tercera página de tu web o de un cliente.

## Cómo ganar dinero con ella

Reutilizar un mismo sistema de estilos recorta el tiempo de cada página nueva y te permite entregar más webs de cliente con la misma calidad visual.

- Sistema de estilos reutilizable para webs de clientes…
- Guía de estilo CSS entregable junto con una landing…
- Normalización visual de webs hechas con IA que salen distintas…

**Precio orientativo:** 120–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como diseñador de sistemas de interfaz que trabaja para negocios pequeños. Tu objetivo hoy es darme un único archivo de estilos base que pueda pegar en cualquier página HTML mía y que todo quede coherente, moderno y legible sin que yo toque diseño.

MI MARCA
- Negocio: [NOMBRE Y A QUÉ SE DEDICA] · Público: [A QUIÉN LE VENDES]
- Sensación que quiero transmitir: [ELIGE 3: CERCANO, SERIO, TÉCNICO, LUJOSO, DIVERTIDO, SOBRIO, ARTESANAL, RÁPIDO]
- Colores que ya uso: [CÓDIGOS HEXADECIMALES O DESCRÍPCIÓN; SI NO TIENES, DILO Y PROPÓN TÚ]
- Tipografía: [LA QUE USAS O NINGUNA]
- Referencias que me gustan: [WEBS O MARCAS]
- Voy a usarlo en: [CUÁNTAS PÁGINAS Y DE QUÉ TIPO]

LO QUE TIENES QUE HACER
1. Define la PALETA con roles, no con nombres de colores: fondo, superficie elevada, texto principal, texto secundario, color de marca, color de acción, borde, éxito, aviso y error. Comprueba y dime el contraste de cada texto sobre su fondo; si alguno no llega a 4.5 a 1, corrígelo tú y avísame.
2. Define la ESCALA TIPOGRÁFICA con una proporción coherente: tamaño base de 16 píxeles como mínimo, y del tamaño 1 al 6, con su altura de línea y su grosor. Elige dos tipografías como mucho, disponibles gratis, e indica una alternativa del sistema por si no cargan.
3. Define la ESCALA DE ESPACIOS basada en múltiplos de 4 u 8 y explícame en dos líneas por qué usar siempre esos valores hace que todo parezca ordenado.
4. Define radios de esquina, sombras y anchura máxima de lectura (entre 60 y 75 caracteres por línea).
5. Escribe todo eso como variables CSS en la raíz, con nombres en español o en inglés pero consistentes, y con la versión para modo oscuro.
6. Dame los COMPONENTES BASE ya escritos con esas variables: botón principal, botón secundario, botón de peligro, tarjeta, campo de formulario con sus estados, aviso o mensaje destacado, cabecera con navegación que funcione en móvil, y pie de página. Cada uno con sus estados: normal, encima, pulsado, foco visible y deshabilitado.
7. Dame las utilidades mínimas: contenedor centrado, rejilla que se adapta sola sin escribir consultas de medios, separación vertical entre secciones y clase para ocultar visualmente pero dejar accesible.
8. Dame una PÁGINA DE MUESTRA en HTML que enseñe todos los componentes juntos, para que la abra y vea si me gusta antes de aplicarlo.
9. Escribe las REGLAS DE USO en 8 puntos: cuándo uso cada color, cuántos tamaños de letra por pantalla, cuándo un botón es principal y cuándo secundario, y qué no debo hacer nunca.
10. Dime cómo aplicarlo a una página que ya tengo, paso a paso, y cómo comprobar que no he roto nada.

RESTRICCIONES
- Un único archivo CSS, sin depender de librerías externas ni de conexión.
- Nada de degradados llamativos ni de efectos que envejezcan mal.
- Todo tiene que verse bien en móvil primero.
- Código completo, sin fragmentos incompletos.
- Español de España, tuteando, sin emojis.

FORMATO DE RESPUESTA
1. DECISIONES DE DISEÑO Y POR QUÉ (máximo 8 líneas)
2. VARIABLES CSS (bloque completo, claro y oscuro)
3. COMPONENTES BASE (bloque CSS completo)
4. UTILIDADES
5. PÁGINA DE MUESTRA (bloque HTML completo)
6. REGLAS DE USO (8 puntos)
7. CÓMO LO APLICO A UNA PÁGINA QUE YA TENGO

CRITERIO DE CALIDAD: está bien si al hacer mi siguiente página solo tengo que pegar este archivo y escribir el contenido, y si al cambiar un solo valor de color cambia toda la web de forma coherente.
```
