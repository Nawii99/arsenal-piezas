# revision-de-accesibilidad-basica…

**Tipo:** Prompt · **Área:** Web · **Licencia:** CC BY 4.0

Tu web vale para gente con poca vista, sin ratón y móviles viejos, con los arreglos claros.

## Qué es y qué hace

Prompt que audita la accesibilidad básica de una web según WCAG 2.2 nivel AA. Entra el HTML y CSS de la página; sale un informe con ratios de contraste calculados, fallos de estructura y el arreglo en código. Se usa en cualquier chat de IA antes de entregar una web.

## Cómo usarla

1. Copia el prompt en un chat de IA
2. Rellena los [corchetes] y pega el HTML y CSS
3. Aplica los arreglos de código propuestos
4. Vuelve a pasar el prompt para confirmar

## Cuándo usarla

Úsalo cuando termines una web o antes de presentarla a un cliente, y siempre que vendas a público general, mayores o administraciones públicas.

## Cómo ganar dinero con ella

Abre tu web a clientes que hoy no pueden comprarte y es requisito en muchos concursos públicos y clientes grandes: te deja optar a trabajos mejor pagados.

- Auditoría de accesibilidad básica para webs de pymes…
- Adaptación de webs para concursos públicos y clientes grandes…
- Revisión de contraste y teclado como extra al entregar webs…

**Precio orientativo:** 120–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como especialista en accesibilidad web (WCAG 2.2 nivel AA) que audita webs de negocios pequeños. Explicas sin siglas y das el arreglo en el código, no solo el diagnóstico. Yo no soy técnico.

LO QUE TE PASO
- Web: [URL] · Tipo de página: [PORTADA / FICHA DE SERVICIO / TIENDA / FORMULARIO]
- Público: [DESCRIBE QUIÉN TE COMPRA, INCLUYE EDAD SI ES RELEVANTE]
- Código: [PEGA AQUÍ EL HTML Y EL CSS DE LA PÁGINA, O LA PARTE QUE QUIERAS QUE REVISE]
- Colores de marca: [CÓDIGOS DE COLOR SI LOS TIENES]

LO QUE TIENES QUE HACER, EN ESTE ORDEN
1. Revisa el CONTRASTE de todos los pares texto-fondo que veas en el código. Da el ratio calculado, di si pasa el mínimo (4.5 a 1 para texto normal, 3 a 1 para texto grande y para bordes de elementos interactivos) y, si no pasa, propón el color más cercano al mío que sí pase, con el código hexadecimal.
2. Revisa la ESTRUCTURA: que haya un solo encabezado principal, que los niveles no salten, que existan las zonas de la página (cabecera, navegación, contenido principal, pie), y que haya un enlace para saltar al contenido.
3. Revisa las IMÁGENES: cuáles necesitan texto alternativo y cuáles deben llevarlo vacío por ser decorativas. Escríbeme el texto alternativo concreto de cada imagen, describiendo lo que aporta, no el nombre del archivo.
4. Revisa el TECLADO: si todo se puede usar sin ratón, si el foco se ve claramente, si el orden es lógico, y si hay trampas de foco en menús o ventanas emergentes. Propón el CSS del indicador de foco.
5. Revisa los FORMULARIOS: etiquetas unidas a cada campo, errores explicados con texto y no solo con color, instrucciones antes del campo y no dentro como pista que desaparece.
6. Revisa los ENLACES Y BOTONES: nada de textos como Pincha aquí o Leer más sueltos, área de pulsación suficiente en móvil, y distinguir cuándo debe ser enlace y cuándo botón.
7. Revisa MOVIMIENTO Y ZOOM: animaciones que respeten la preferencia de reducir movimiento, y que la página siga siendo usable al ampliar el texto un 200 por ciento.
8. Revisa el IDIOMA y el título de la página.
9. Devuélveme una tabla de hallazgos: problema, dónde está, a quién afecta en la práctica, gravedad (bloqueante, importante, menor) y esfuerzo de arreglo.
10. Dame el CÓDIGO CORREGIDO de los tres problemas más graves, mostrando el antes y el después.
11. Dame una LISTA DE COMPROBACIÓN MANUAL de 8 pruebas que puedo hacer yo en 15 minutos sin herramientas: navegar solo con el tabulador, ampliar el texto, quitar el sonido, mirar la web con el móvil al sol, etc.

RESTRICCIONES
- No me digas solo que algo falla: dime el arreglo exacto.
- No uses siglas sin explicarlas la primera vez.
- No inventes problemas que no estén en el código que te he pasado.
- Prioriza lo que afecta a que alguien pueda comprar o contactar, por delante de lo cosmético.
- Español de España, tuteando, sin emojis.

FORMATO DE RESPUESTA
RESUMEN: ¿puede una persona con discapacidad completar la acción principal de esta página? (sí, no, con dificultad) y por qué
TABLA DE HALLAZGOS (problema, ubicación, a quién afecta, gravedad, esfuerzo)
LOS 3 ARREGLOS PRIORITARIOS CON CÓDIGO ANTES Y DESPUÉS
PALETA DE COLORES CORREGIDA (si hace falta)
TEXTOS ALTERNATIVOS DE MIS IMÁGENES (uno por línea)
PRUEBAS MANUALES QUE PUEDO HACER YO

CRITERIO DE CALIDAD: está bien si puedo recorrer y completar el formulario de la página usando solo el teclado, viendo siempre dónde estoy, y si ningún texto importante queda por debajo del contraste mínimo.
```
