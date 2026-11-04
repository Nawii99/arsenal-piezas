---
name: cv-desde-plantilla
description: Rellena una plantilla de CV (LaTeX, Typst, HTML o Word) con los datos de un cliente y la deja lista para entregar. Se activa cuando el usuario pide montar, adaptar o traducir un currículum sobre una plantilla existente.
---

# Qué hace esta skill

Coge los datos de una persona (experiencia, formación, idiomas) y una plantilla de CV, y devuelve el archivo terminado y compilado. Está pensada para quien hace CVs por encargo y cobra por ello, así que el resultado tiene que poder entregarse a un cliente sin retoques.

## Antes de empezar, pregunta siempre

1. ¿De dónde sale la plantilla y qué licencia tiene? Si es MIT, Apache o CC BY, se puede modificar y usar en un trabajo cobrado. Si es CC BY-NC (no comercial) o una plantilla comprada en Etsy o Envato con licencia de uso personal, NO se puede revender el resultado: dilo claro y ofrece buscar una alternativa con licencia libre.
2. ¿En qué formato quiere el cliente el entregable final? Casi siempre es PDF, pero pregunta si además quiere el archivo editable (el .docx, el .typ o la página de Notion duplicable).
3. ¿Los datos del cliente están completos? Pide como mínimo: nombre, puesto objetivo, experiencia con fechas, formación e idiomas. Si falta algo, para y pídelo. No sigas con huecos.
4. ¿El CV es para España? Si lo es, recuerda al usuario que aquí no es obligatorio poner foto ni fecha de nacimiento, y que muchos procesos pasan por filtros automáticos (ATS) que leen mal las tablas y las columnas dobles.

## Paso a paso

1. Lee la plantilla entera antes de tocar nada y localiza dónde va cada dato. En LaTeX y Typst suelen ser comandos tipo \name{} o variables al principio del archivo; en HTML, etiquetas con texto de ejemplo; en Word, texto de relleno tipo 'Lorem ipsum'.
2. Sustituye SOLO el contenido. No cambies fuentes, colores ni márgenes salvo que el usuario lo pida.
3. Reescribe cada punto de experiencia como logro medible cuando el cliente haya dado cifras ('subí las ventas un 20%'). Si no hay cifras, describe la responsabilidad tal cual, sin inflarla.
4. Compila o abre el resultado: en Typst ejecuta typst compile, en LaTeX usa latexmk o pdflatex, en HTML abre el archivo y genera el PDF con la impresión del navegador. Si la compilación falla, arréglala antes de dar nada por terminado.
5. Repasa el PDF final: que quepa en una página (dos como mucho si hay más de 10 años de experiencia), que no haya texto de ejemplo olvidado y que fechas y tildes estén bien.

## Qué devolver

- El archivo fuente modificado y el PDF final, con nombre tipo CV_NombreApellido_2026.pdf.
- Una lista corta de lo que has cambiado respecto a los datos que dio el cliente (frases reescritas, cosas que has quitado por irrelevantes), para que el usuario pueda justificarlo si el cliente pregunta.
- Un aviso final con la licencia de la plantilla usada y qué obliga (por ejemplo, CC BY obliga a citar al autor original).

## Qué NO hacer

- No inventes NUNCA experiencia, títulos, fechas ni cifras que el cliente no haya dado. Un dato falso en un CV puede costarle el puesto y al usuario su reputación como profesional.
- No uses una plantilla cuya licencia no hayas podido comprobar. Ante la duda, se descarta.
- No metas la dirección postal completa ni el DNI del cliente en el CV: con ciudad y provincia basta.
- No entregues un archivo sin haberlo compilado o abierto tú mismo. 'Debería funcionar' no vale cuando hay dinero por medio.
