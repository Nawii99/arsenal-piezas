# Extraer datos de un CV pegado como texto…

**Tipo:** Prompt · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Prompt para pegar en un LLM junto con el texto de un CV (ya sacado de un OCR o copiado a mano) y obtener una ficha ordenada del candidato.

## Qué es y qué hace

Prompt para Claude, Codex, Gemini o una IA local que, junto al texto de un CV, devuelve una ficha ordenada del candidato sin inventar datos: nombre, email, teléfono, ciudad, últimos tres puestos, formación, idiomas y habilidades, con confianza alta, media o baja. Entra el texto y sale una ficha. Ejemplo: un texto con un teléfono incompleto se marca con baja confianza. Son datos personales: que lo revise un profesional.

## Cómo usarla

1. Pega el texto del CV en el prompt
2. Ejecuta la extracción en la IA
3. Revisa la confianza indicada
4. Que lo revise un profesional

## Cuándo usarla

Si ya tienes el texto de un CV, sacado de un OCR o copiado a mano, y quieres una ficha ordenada del candidato sin inventar datos.

## Cómo ganar dinero con ella

Sirve para ofrecer fichas de candidatos a pequeñas agencias o autónomos de RRHH que reciben CVs sueltos. Cobra por ficha o por paquete, [TU PRECIO], y que una persona revise cada una antes de usarla en una decisión de empleo.

- Fichas de candidatos para agencias pequeñas que trabajan con CV sueltos…
- Extracción de datos para autónomos de RRHH con un chat de IA…
- Plantilla de ficha para entrevistas de selección sencillas…

## El prompt (cópialo entero)

```text
Eres un asistente que ordena currículums para una agencia de selección. Te voy a pegar el texto de un CV, tal cual salió de un OCR, así que puede tener errores de reconocimiento (letras cambiadas, saltos raros).

Tu tarea:
1. Corrige solo los errores obvios de OCR (por ejemplo 'l' que debería ser '1', o palabras partidas por un salto de línea). No inventes ni cambies datos que no estén claros.
2. Saca una ficha del candidato con estos apartados: Nombre completo, Email, Teléfono, Ciudad, Años de experiencia (número aproximado), Últimos 3 puestos (con empresa y fechas), Formación (título y centro), Idiomas (con nivel si lo pone), Habilidades destacadas (máximo 8).
3. Si un dato no aparece en el texto, escribe 'No indicado' en ese apartado. No lo dejes en blanco ni lo rellenes con una suposición.
4. Al final, añade una línea 'Confianza de la extracción: alta / media / baja' según lo legible que estuviera el texto que te he pasado.
5. Si detectas que el texto está muy roto (frases sin sentido, muchas palabras sueltas), dilo antes de la ficha en vez de intentar rellenarla igualmente.

Responde solo con la ficha, sin explicaciones adicionales antes ni después.

Texto del CV:
[PEGA AQUÍ EL TEXTO DEL CV]
```
