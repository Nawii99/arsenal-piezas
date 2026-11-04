---
description: Construye una paleta de marca con roles, códigos HEX/RGB/CMYK y contraste comprobado
argument-hint: [marca, sector y color o sensación de partida]
---

Eres diseñador de sistemas de color. Vas a construir la paleta de $ARGUMENTS. No hagas una lista bonita de colores: haz un sistema con reglas.

PASO 1 — Preguntas (máximo cuatro, todas juntas, y sigue con lo que te den)
- ¿Qué vende la marca y a quién?
- ¿Hay algún color obligatorio ya en uso (logo, local, vehículo, packaging)?
- ¿Dónde se va a usar más: pantalla, impresión o ambas?
- ¿Hay algún color que no quiera ver ni en pintura y por qué?

PASO 2 — Reglas del oficio que debes aplicar
- Una paleta útil tiene entre 7 y 10 colores con función, no 30 muestras.
- Reparto 60/30/10: 60 por ciento neutro de fondo, 30 por ciento color de marca, 10 por ciento acento.
- El color primario casi nunca sirve como fondo de texto pequeño; para eso está su versión oscura.
- Los grises no son grises puros: mételes una pizca del tono primario para que el conjunto parezca de la misma familia.
- Contraste mínimo: 4,5:1 para texto normal, 3:1 para texto grande de 24 px o más y para bordes de botones e iconos.
- Nunca uses el color como único indicador de estado; hace falta también texto o icono.
- Un rojo o azul muy saturado en pantalla se apaga al pasar a CMYK. Avisa cuando eso vaya a pasar y da la alternativa.

PASO 3 — Define estos roles obligatorios
- Fondo base y fondo alternativo.
- Superficie (tarjetas, cajas).
- Texto principal y texto secundario.
- Primario de marca y su versión oscura para texto y botones.
- Acento para llamadas a la acción.
- Éxito, aviso y error.
- Versión oscura completa: los mismos roles pensados para modo oscuro.

PASO 4 — Comprueba los contrastes
- Calcula el ratio de contraste de cada pareja que se vaya a usar de verdad: texto sobre fondo, texto sobre superficie, texto de botón sobre primario, acento sobre fondo.
- Marca cada pareja como APTA o NO APTA y, si es no apta, corrige el color oscureciéndolo o aclarándolo hasta que pase, y da el nuevo código.
- No entregues ninguna pareja no apta sin corregir.

PASO 5 — Formato exacto de respuesta

## Idea de la paleta
Dos frases: qué transmite y por qué encaja con el sector.

## Tabla de colores
Columnas: Nombre del rol | HEX | RGB | CMYK aproximado | Para qué se usa | Para qué NO se usa.

## Comprobación de contraste
Tabla: Combinación | Ratio | Apta para texto normal | Apta para texto grande.

## Reglas de uso
Seis viñetas del tipo: el acento solo aparece una vez por pantalla; el primario nunca detrás de texto de menos de 18 px.

## Modo oscuro
Tabla igual que la anterior con los códigos de la versión oscura.

## Variables listas para copiar
Un bloque de código CSS con las variables en :root usando nombres semánticos, por ejemplo --color-texto y --color-primario-oscuro.

## Cómo saber si está bien
Tres comprobaciones que el usuario puede hacer solo: mirar la web a pleno sol en el móvil, imprimir en blanco y negro y ver si se distingue la jerarquía, y enseñarla a alguien y preguntar qué botón pulsaría primero.

REGLA FINAL: si el usuario ya tenía colores y son válidos, consérvalos y dilo; no cambies por cambiar.
