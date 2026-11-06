# Del proyecto al README y a la entrevista…

**Tipo:** Prompt · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Convierte un proyecto técnico en una explicación llana, un README para tu portfolio y un relato corto con preguntas de entrevista, sin inventar nada.

## Qué es y qué hace

Prompt que convierte un proyecto técnico en tres textos: una explicación llana parte por parte, un README para tu portfolio y un relato corto de 90 segundos con preguntas de entrevista. Pides que lea tu carpeta o pegas el código, y te devuelve una revisión de lo que parece a medias. Sirve en Claude, Codex, Gemini o una IA local, o en Claude Code con acceso a la carpeta.

## Cómo usarla

1. Rellena tu nivel de programación y tu parte real
2. Pega el material o indica la carpeta
3. Revisa cada paso antes de pasar al siguiente

## Cuándo usarla

Cuando tengas que explicar un proyecto en una entrevista o escribir su README y no seas programador, o programes poco y no sepas contarlo.

## Cómo ganar dinero con ella

Ayudas a otras personas a documentar y contar sus proyectos de portfolio: README, relato de 90 segundos y preguntas de entrevista. Cobra por proyecto: [TU PRECIO].

- Documentación de proyectos de portfolio para personas que se presentan a puestos técnicos o creativos, por proyecto.
- Sesión para explicar un proyecto en entrevista con relato y preguntas de práctica.
- Revisión de README y textos para equipos pequeños que publican su código sin documentar.

**Precio orientativo:** 40–120 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como un compañero que me ayuda a explicar un proyecto técnico a reclutadores y a gente que no programa. Mi nivel de programación: [NADA / POCO / MEDIO / LO HIZO UNA IA].

El proyecto:
- Nombre: [NOMBRE DEL PROYECTO]
- Qué problema resuelve y para quién: [DESCRIPCIÓN]
- Mi parte real: [QUÉ HICE YO: IDEA, PRUEBAS, DISEÑO, TEXTOS, CÓDIGO...]
- Qué parte hizo una IA o una herramienta: [CUÁL]
- Puesto al que me presento: [PUESTO]
- Material: [PEGA EL CÓDIGO, LA LISTA DE ARCHIVOS O LA DESCRIPCIÓN. SI USAS CLAUDE CODE, DILE QUE LEA LA CARPETA]

Haz esto en orden. Entre un paso y otro, espera mi OK:
1. Explicación llana: qué hace el proyecto, parte por parte, en lenguaje de calle. Si usas una palabra técnica, defínela en la misma frase.
2. Revisión: lista de lo que no has podido comprobar o que parece a medias (funciones sin terminar, textos de prueba, avisos de seguridad evidentes). En este paso no digas «está bien» sin motivo.
3. README en Markdown con estas secciones: qué es, para qué sirve, cómo se usa (pasos para alguien que no programa), qué tecnologías usa, estado actual (qué funciona y qué no), qué aprendí y licencia [LICENCIA O PENDIENTE DE ELEGIR].
4. Relato de entrevista: 60 a 90 segundos en primera persona. Cuenta el problema, lo que hice yo, en qué me ayudó una IA y el resultado real.
5. Preguntas: las seis más probables sobre este proyecto en una entrevista para [PUESTO], con una respuesta modelo honesta para cada una, basada solo en lo que te he contado.

Límites:
- No inventes funciones, tecnologías, usuarios, cifras ni resultados. Si algo no está en el material, escribe [DATO QUE FALTA] y pregúntamelo.
- No me hagas pasar por autor de lo que hizo una IA o una herramienta. Si en la entrevista preguntan, la respuesta tiene que ser sincera: qué hice yo y qué hizo la herramienta.
- Antes de nada, avísame si el material parece incluir contraseñas, claves, archivos .env, datos de clientes o código de una empresa. En ese caso, párate y dime que lo quite. No lo copies en el README.
- Si el código no es mío o es de mi empresa, recuérdame que debo mirar la licencia o pedir permiso antes de enseñarlo en público.
- Si trabajas con Claude Code, solo lectura: no modifiques ni borres archivos. El README lo escribes como archivo nuevo y solo cuando yo lo apruebe.
- No me prometas que esto consigue entrevistas ni trabajo.
```
