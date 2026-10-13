# Prompt: extraer datos de un CV pegando el texto…

**Tipo:** Prompt · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Prompt para pegar en cualquier chat de IA (Claude, Codex, Gemini o una IA local) junto con el texto de un CV, y recibir los datos ordenados en una tabla, sin necesidad de ninguna herramienta técnica.

## Qué es y qué hace

Prompt para Claude, Codex, Gemini o una IA local que, al pegar el texto de un CV, devuelve una tabla con nombre, teléfono, email, ciudad, último puesto, años de experiencia, formación e idiomas. Marca como no indicado lo que no aparece y avisa de posibles errores de lectura. Entra el texto y sale una tabla y una línea de experiencia completa. Ejemplo: un CV copiado de un PDF se convierte en una ficha ordenada. Son datos personales: que lo revise un profesional antes de usarlos.

## Cómo usarla

1. Copia el texto del CV
2. Pega el prompt y el texto en la IA
3. Revisa los avisos de lectura bajo la tabla
4. Que lo revise un profesional

## Cuándo usarla

Para alguien sin conocimientos técnicos que quiere sacar los datos de un CV usando solo el chat de una IA, copiando y pegando el texto.

## Cómo ganar dinero con ella

Cualquier chat de IA generalista (Claude, Codex, Gemini o una IA local)

- Fichas de candidatos para pequeñas agencias que usan solo un chat de IA…
- Extracción de CV para autónomos de RRHH sin herramientas técnicas…
- Plantilla de ficha de candidato para procesos de selección sencillos…

## El prompt (cópialo entero)

```text
Voy a pegarte el texto de un currículum (CV). Puede venir de copiar y pegar un PDF, o de una foto pasada por un lector de texto, así que puede tener algún error suelto.

Quiero que saques estos datos y me los devuelvas en una tabla, en este orden:
- Nombre completo
- Teléfono
- Email
- Ciudad
- Último puesto de trabajo y empresa
- Años de experiencia (aproximados si no lo pone directamente)
- Formación (título y centro)
- Idiomas y nivel, si aparecen

Reglas:
1. Si un dato no aparece en el texto, escribe "no indicado", no lo inventes.
2. Si ves algo que parece un error de lectura (una letra rara en un nombre, un teléfono con menos de 9 dígitos), déjalo tal cual pero avísame debajo de la tabla.
3. No me des ninguna opinión sobre si el candidato vale o no para un puesto, solo extrae los datos.
4. Al final añade una fila con "Experiencia laboral completa" listando cada puesto por separado (empresa, cargo, fechas), aunque ya hayas puesto el último puesto arriba.

Aquí está el texto del CV:
[PEGA AQUÍ EL TEXTO DEL CV]
```
