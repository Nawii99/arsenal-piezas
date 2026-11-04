---
name: cuaderno-de-lo-que-funciona
description: Guarda aprendizajes cortos del negocio, con un dato detrás, en un archivo del proyecto (aprendizajes.md) para que Claude los tenga presentes en cada sesión. Las ideas sin comprobar van a otro archivo que no se carga. Se activa cuando el usuario dice «apúntalo como aprendizaje», «guarda esto en el cuaderno», «esto funcionó» o «revisa el cuaderno».
---

# Cuaderno de lo que funciona

## Qué hace
Convierte una observación («este asunto abrió más») en una entrada corta, con su dato, su alcance y una fecha de revisión. Usa dos archivos en la carpeta del proyecto:
- `aprendizajes.md`: solo lo confirmado. Es el único que se carga en cada sesión.
- `aprendizajes-por-comprobar.md`: hipótesis, cosas probadas una sola vez y descartados. No se enlaza desde CLAUDE.md, así que no se carga.
Claude Code lee el archivo CLAUDE.md al empezar cada sesión. Esta skill se asegura de que CLAUDE.md enlace solo a `aprendizajes.md`, con la línea `@aprendizajes.md`.
Ojo: lo que guardas en `aprendizajes.md` condiciona a la IA en todas las sesiones. Una lección falsa se repite una y otra vez. Por eso solo entra lo que está confirmado.

## Antes de empezar, pregunta
1. Qué has aprendido, dicho en una frase.
2. Qué dato lo apoya: cifra, fechas, cuántas veces ocurrió. Si no hay dato, es una hipótesis y va al archivo por comprobar.
3. A qué se aplica: qué producto, canal o tipo de cliente. Un buen resultado en Instagram no vale para el email.
4. Cuánto te fías: hipótesis (una observación sin medir), probado una vez (medido una sola vez con cifra) o confirmado (repetido al menos [NÚMERO] veces o con más de [NÚMERO] casos).
5. Cuándo conviene volver a mirarlo ([FECHA O PLAZO]).

## Paso a paso
1. Abre `aprendizajes.md`. Si no existe, créalo con una cabecera y una sección: Vigentes. La cabecera dice: «Claude: aquí solo hay aprendizajes confirmados. Si ves una entrada marcada como hipótesis o descartada, no la apliques».
2. Abre `aprendizajes-por-comprobar.md`. Si no existe, créalo con dos secciones: A comprobar y Descartados.
3. Redacta la entrada en una sola línea con este formato: [APR-NÚMERO] [FECHA] | [LO APRENDIDO EN UNA FRASE] | Evidencia: [DATO CON NÚMERO] | Alcance: [PRODUCTO O CANAL] | Confianza: [HIPÓTESIS, PROBADO UNA VEZ O CONFIRMADO] | Revisar el: [FECHA].
4. Busca si ya hay una entrada parecida o que la contradiga, en los dos archivos. Si la hay, enséñasela a la persona y pregunta qué hacer: actualizar, sustituir o dejar las dos con sus condiciones.
5. Enseña la entrada propuesta y espera un sí claro antes de guardar. No guardes nada por tu cuenta.
6. Guarda en el archivo que toque. Confirmado: sección Vigentes de `aprendizajes.md`. Hipótesis o probado una vez: sección A comprobar de `aprendizajes-por-comprobar.md`. Un solo caso nunca entra en Vigentes.
7. Cuando una entrada de A comprobar se repita [NÚMERO] veces o con más de [NÚMERO] casos, propón subirla a Vigentes y pide permiso.
8. Comprueba CLAUDE.md. Si existe y no contiene la línea `@aprendizajes.md`, propón añadirla y pide permiso antes de tocarlo. Si no existe, propón crearlo con esa línea y pide permiso.
9. No enlaces nunca `aprendizajes-por-comprobar.md` ni `aprendizajes-archivo.md` desde CLAUDE.md: así no se cargan en cada sesión.
10. Cuando la persona diga «revisa el cuaderno», lista las entradas de los dos archivos con fecha de revisión vencida y pregunta una por una si siguen valiendo.
11. Si `aprendizajes.md` pasa de unas 100 líneas, propón pasar lo antiguo a `aprendizajes-archivo.md`. Se mueve, no se borra.
12. Para comprobar que funciona, abre una sesión nueva y pregunta: «¿qué aprendizajes del negocio tienes cargados?». Solo deben salir los confirmados.

## Qué devolver, con este formato
- La entrada propuesta, tal cual se guardaría, y en qué archivo y sección va.
- Si hay duplicados o contradicciones, cuáles y qué propones.
- Tras guardar, confirmación con el número de entradas por sección.
- En una revisión: lista de entradas caducadas con tu recomendación (mantener, bajar a hipótesis o descartar) y la decisión que falta.

## Qué NO hacer
- No guardes nada sin que la persona lo confirme.
- No guardes nombres, emails, teléfonos ni datos de clientes. Si hace falta, escribe «un cliente del sector [SECTOR]».
- No guardes contraseñas, claves de API, datos bancarios ni nada confidencial.
- No presentes una opinión como un hecho ni generalices a partir de un solo caso: un caso suelto se queda en el archivo por comprobar.
- No borres entradas: se pasan a Descartados (en `aprendizajes-por-comprobar.md`) con el motivo, o al archivo.
- No enlaces desde CLAUDE.md nada que no sea `aprendizajes.md`.
- No metas decenas de líneas: un cuaderno largo se lee peor y gasta espacio en cada sesión.
- Si el proyecto está en una carpeta compartida o en un repositorio, recuerda que otras personas podrán leer el cuaderno.

## Qué revisa una persona antes de usar el resultado
- El dueño del negocio revisa el cuaderno entero cada [PLAZO, POR EJEMPLO UN MES] y descarta lo que ya no se cumple.
- Si un aprendizaje afecta a promesas de resultados, salud, precios regulados o datos de clientes, lo mira antes alguien con criterio legal.

## Instalación (para ti, no para Claude)
Guarda este archivo como SKILL.md dentro de la carpeta .claude/skills/cuaderno-de-lo-que-funciona/ de tu proyecto.
