---
name: buscar-skill-para-tarea-de-clase
description: Te ayuda a encontrar una skill ya hecha para una tarea de clase (fichas, rúbricas, presentaciones, documentos), a revisar que sea segura y tenga licencia, y a probarla antes de usarla. Se activa cuando pides una skill, preguntas si ya existe algo o quieres instalar la de otra persona.
---

# Buscar una skill para una tarea de clase

## Qué hace
Una skill es una carpeta con un archivo SKILL.md que enseña a Claude Code a hacer una tarea concreta. Esta skill no prepara tu material. Te ayuda a decidir si ya existe una skill que sirva, si es de fiar y si encaja con tu clase.
Dónde ponerla: guarda este texto como SKILL.md dentro de la carpeta .claude/skills/buscar-skill-para-tarea-de-clase/ de tu proyecto.
Cómo pedirla: «Busca una skill para hacer rúbricas en Word a partir de mis criterios de evaluación».

## Pregunta antes de empezar
1. ¿Qué tarea quieres resolver? Una frase. Ejemplo: «hacer una ficha de repaso en PDF a partir de un tema».
2. ¿Para qué curso y asignatura es?
3. ¿En qué formato lo quieres? Word, PDF, PowerPoint, Excel o texto.
4. ¿Va a haber datos de alumnos en el material? Si la respuesta es sí, se trabaja solo con datos inventados.
5. ¿Trabajas en un ordenador del centro? Puede que no te dejen instalar cosas. Pregunta a quien lleve la informática.
6. ¿Tienes una lista de skills (un enlace o una carpeta)? Si no la tienes, pídela. No te inventes enlaces.

## Paso a paso
1. Reformula la tarea en una frase y pide confirmación.
2. Mira lo que ya está instalado: la carpeta .claude/skills del proyecto y la de tu usuario. Si ya hay una que sirve, úsala y para aquí.
3. Abre la lista o el repositorio que te dé el usuario. Una lista curada es solo un índice. Nadie ha comprobado por ti que lo que enlaza sea bueno o seguro.
4. Agrupa lo que encuentres por tipo de tarea: documentos, presentaciones, hojas de cálculo, contenido, evaluación. Quédate con 3 candidatas como máximo.
5. Si leer las candidatas va a llenar la conversación, lanza un subagente por candidata. Cada uno la lee por separado y te devuelve un resumen.
6. De cada candidata, lee el SKILL.md entero y la lista de archivos de su carpeta. Anota qué hace, si trae scripts, si se conecta a internet y si pide claves.
7. Comprueba la licencia, quién la mantiene y la fecha de la última actualización. Sin archivo de licencia, por defecto no tienes permiso para reutilizarla ni venderla. Descártala o pregunta al autor.
8. Compara y recomienda una. Si ninguna sirve, dilo claro.
9. Solo si el usuario dice «sí», copia la carpeta dentro de .claude/skills/ del proyecto, no en la global. No ejecutes ningún script que no hayas leído.
10. Prueba con un caso inventado y enseña el resultado antes de usarla con material real.

## Qué devolver
Una tabla con una fila por candidata, y debajo la recomendación en 3 líneas como máximo.
| Candidata | Qué hace | Qué trae (scripts, internet, claves) | Licencia | Última actualización | Veredicto |
|---|---|---|---|---|---|
Ficha de registro de la elegida: URL original, licencia, fecha de comprobación [FECHA], y si es de código abierto, gratis o de pago.
Si el usuario quiere, un archivo mis-skills-de-clase.md con las skills ya revisadas, agrupadas por categoría. Si el archivo ya existe, añade al final y no borres nada.
Si no hay ninguna que sirva: dilo y propón escribir un prompt o una skill propia, con tus palabras y sin copiar texto ajeno.

## Qué NO hacer
- No instales ni ejecutes nada sin que el usuario lo apruebe.
- No inventes skills, enlaces ni nombres de repositorios. Si no puedes abrir la lista, pide que pegue su contenido.
- No te fíes de las estrellas ni de las descargas. No son una revisión de seguridad.
- No metas nombres, notas, fotos ni informes de alumnos. Muchos son menores, y el RGPD y la LOPDGDD mandan.
- No copies el texto de una skill ajena a una tuya para venderla.
- No uses el modo de Claude Code que se salta los permisos.

## Qué revisa una persona
El docente revisa el material antes de dárselo al alumnado: que sea correcto, que encaje con el currículo de [TU COMUNIDAD AUTÓNOMA] y que el nivel sea el adecuado.
Las notas y las evaluaciones las decide siempre el profesor. La skill solo ayuda con borradores.
Si el centro tiene normas sobre IA o sobre instalar programas, mandan esas.

Pieza revisada en octubre de 2026. Las listas y las licencias cambian: comprueba la fecha de cada cosa que instales.
