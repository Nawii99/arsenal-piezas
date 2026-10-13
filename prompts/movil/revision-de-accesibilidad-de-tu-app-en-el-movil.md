# Revisión de accesibilidad de tu app en el móvil…

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Revisa tu app o tu web móvil para que se pueda usar con letra grande, poca luz, una sola mano o lector de pantalla, y te da los arreglos ordenados.

## Qué es y qué hace

Prompt que actúa como especialista en accesibilidad móvil y WCAG. Recibe público, pantallas, colores con su código y textos o HTML; devuelve el contraste calculado, los fallos con letra grande, una mano o lector de pantalla y los arreglos ordenados por prioridad. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con colores y pantallas
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Aplica los arreglos por orden de prioridad

## Cuándo usarla

Úsalo cuando tu público incluya personas mayores o quieras vender a administraciones y empresas que exigen accesibilidad, o si recibes quejas de 'no se ve' y 'no encuentro el botón'.

## Cómo ganar dinero con ella

Amplía el número de personas que pueden usar y pagar tu producto, y es requisito en muchos concursos públicos y en clientes grandes.

- Auditoría de accesibilidad móvil con lista de arreglos…
- Revisión de contraste y tamaños para webs y apps…
- Preparación para concursos públicos que exigen accesibilidad…

**Precio orientativo:** 200–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como especialista en accesibilidad digital centrado en móvil, que sabe explicar las pautas WCAG a alguien sin perfil técnico y traducirlas en cambios concretos.
No me des la norma entera: dime qué falla en lo mío y cómo se arregla.
CONTEXTO
Qué reviso: [APP / WEB EN EL MÓVIL] llamada [NOMBRE]
Público: [DESCRIBE, INCLUYE EDAD Y SI HAY PERSONAS MAYORES O CON POCA VISIÓN]
Pantallas principales: [LISTA]
Colores de marca con su código: [EJEMPLO: TEXTO #444444 SOBRE FONDO #F2F2F2, BOTÓN #1A73E8]
Tamaños de letra que uso: [SI LOS SABES]
Pego aquí mis textos o describo mis pantallas: [PEGA CAPTURAS DESCRITAS O EL CÓDIGO HTML SI LO TENGO]
¿Tengo que cumplir algún requisito legal? [NO / VENDO A ADMINISTRACIÓN PÚBLICA / CLIENTE GRANDE ME LO EXIGE]
TU TRABAJO, PASO A PASO
1. Comprueba el contraste de las combinaciones de color que te he dado: calcula la relación, di si pasa el mínimo de 4,5 a 1 para texto normal y 3 a 1 para texto grande, y propón el código de color más cercano que sí pase, manteniendo la marca.
2. Revisa el tamaño de los elementos que se tocan: mínimo recomendado y separación entre ellos; señala los sitios típicos donde falla (iconos de cerrar, casillas, enlaces dentro de un párrafo, botones en fila).
3. Revisa los textos: nivel de lectura, frases largas, palabras técnicas, textos escritos solo en mayúsculas, y enlaces que dicen 'aquí' o 'ver más' sin decir a dónde llevan. Reescribe los peores.
4. Comprueba lo que no debe depender solo del color: errores en rojo sin icono ni texto, estados marcados solo con un tono, gráficos sin etiqueta.
5. Dime qué necesita cada imagen y cada icono como texto alternativo, con ejemplos escritos para mis pantallas, y cuáles deben quedarse sin texto por ser decorativos.
6. Explícame cómo probarlo yo mismo en 20 minutos: activar el texto grande del móvil al máximo y ver qué se rompe, activar VoiceOver en iPhone o TalkBack en Android y recorrer una pantalla, usar la app con una sola mano, y mirarla al sol o con el brillo bajo.
7. Revisa el uso con una mano: qué acciones quedan fuera del alcance del pulgar y cómo reorganizarlas.
8. Entrega la lista de arreglos ordenada por impacto y esfuerzo, separando lo que puedo cambiar yo (textos, colores, tamaños) de lo que necesita a alguien que programe.
REGLAS
Nada de listas genéricas de buenas prácticas: cada punto va referido a algo mío.
Si te falta información de una pantalla, dime qué necesitas ver y sigue con el resto.
Los códigos de color propuestos deben ser exactos y comprobables.
Español de España, tuteo, sin siglas sin explicar.
FORMATO DE RESPUESTA
A) Tabla de contraste: combinación actual, ratio, pasa o no, color propuesto, nuevo ratio.
B) Lista de elementos táctiles problemáticos con la corrección.
C) Textos reescritos, antes y después.
D) Textos alternativos propuestos.
E) Guion de la prueba de 20 minutos, paso a paso.
F) Mapa del pulgar: qué mover y a dónde.
G) Plan de arreglos en tres bloques: hoy, esta semana, cuando toque tocar código.
CRITERIOS DE CALIDAD
Cada problema señalado tiene un arreglo concreto, no un consejo.
Los colores propuestos siguen pareciendo mi marca.
Con la lista final, una persona no técnica puede arreglar al menos la mitad sin ayuda.
```
