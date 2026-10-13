# Duelo de prompts con rúbrica…

**Tipo:** Prompt · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Compara dos versiones de un prompt con un método honesto: mismos casos, evaluación a ciegas, puntuación por criterios y decisión con datos.

## Qué es y qué hace

Prompt que compara dos versiones de un prompt con método. Entran los dos prompts, la tarea y qué es un buen resultado; sale una rúbrica de cinco criterios medibles, casos de prueba, evaluación a ciegas y una decisión con datos. Se usa en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Copia el prompt en tu IA
2. Rellena los [corchetes] con prompts A y B
3. Pasa los casos de prueba y puntúa con la rúbrica
4. Quédate con el prompt ganador

## Cuándo usarla

Úsalo cuando dudes entre dos formas de pedirle algo a la IA, o quieras mejorar un prompt que usas todos los días sin fiarte de la primera impresión.

## Cómo ganar dinero con ella

Un prompt que acierta más veces reduce las correcciones a mano de cada pieza; el ahorro se multiplica por todas las veces que lo usarás.

- Optimización de prompts de uso diario para pymes…
- Evaluación comparativa de prompts como servicio de consultoría IA…
- Informe de mejora de prompts con puntuaciones para clientes…

## El prompt (cópialo entero)

```text
Actúa como evaluador de sistemas de IA. Tu especialidad es comparar dos prompts sin engañarte: mismos casos de prueba, criterios definidos antes de mirar los resultados y evaluación a ciegas.

EL DUELO
- Tarea que hace el prompt: [QUÉ LE PIDO A LA IA]
- Cada cuánto lo uso: [VECES POR SEMANA]
- Qué me molesta del resultado actual: [LO QUE FALLA]
- PROMPT A (el que uso ahora): [PÉGALO ENTERO]
- PROMPT B (la alternativa): [PÉGALO ENTERO, O DIME «PROPÓN TÚ LA B»]
- Modelo o modelos donde lo uso: [CLAUDE, CODEX, GEMINI O UNA IA LOCAL]
- Cómo se ve que el resultado es bueno, en mis palabras: [DESCRÍBELO]

LO QUE TIENES QUE HACER
1. Antes de nada, convierte mi «se ve que es bueno» en 5 criterios medibles, cada uno con su escala de 0 a 3 y con la descripción de qué es un 0 y qué es un 3. Los criterios deben incluir al menos uno de exactitud (no se inventa nada), uno de formato (cumple la estructura pedida) y uno de utilidad (puedo usarlo sin retocar).
2. Ponles peso: no todos valen igual. Reparte 100 puntos entre los 5 criterios según lo que de verdad me importa y explica el reparto en una línea.
3. Diseña el banco de casos: 8 entradas de prueba distintas, incluyendo 2 fáciles, 4 típicas y 2 difíciles o con datos incompletos. Escríbelas literales para que yo las pueda pegar. Los mismos 8 casos van a los dos prompts, sin cambiar ni una coma.
4. Dame el protocolo: ejecutar cada caso en conversación nueva y limpia, guardar las respuestas en una tabla con etiquetas neutras (Resultado 1, Resultado 2) sin decir cuál viene de qué prompt, mezclarlas, y puntuar sin saber el origen. Explícame por qué esto es imprescindible: si sé cuál es «mi» prompt, lo puntúo mejor sin darme cuenta.
5. Añade la prueba de constancia: repetir 2 casos tres veces con cada prompt para ver si el resultado es estable o es una lotería. Un prompt que a veces borda y a veces falla es peor que uno mediano pero constante, y explícame por qué en mi caso.
6. Dame la hoja de puntuación en blanco lista para copiar a una hoja de cálculo, con las fórmulas de la media ponderada escritas en texto para que yo las meta.
7. Dime cómo leer el resultado sin engañarme: qué diferencia de puntos es significativa con solo 8 casos y cuál es ruido, qué hago si ganan empatados, y por qué a veces la respuesta correcta es quedarse con lo mejor de cada uno en un tercer prompt.
8. Si te he pedido que propongas tú la versión B, escríbela entera y explica en 5 líneas qué has cambiado y qué esperas mejorar de cada cambio, para que el duelo tenga una hipótesis y no sea a ciegas.

RESTRICCIONES
- No evalúes tú los prompts de memoria ni predigas quién ganará: monta el método para que lo ejecute yo.
- Ningún criterio puede ser «suena mejor» o «es más bonito».
- Los 8 casos deben ser realistas de mi negocio, no ejemplos genéricos.

FORMATO DE RESPUESTA
A) Los 5 criterios con su escala 0-3 y sus pesos.
B) Los 8 casos de prueba, literales.
C) Protocolo de ejecución a ciegas, paso a paso.
D) Prueba de constancia.
E) Hoja de puntuación lista para copiar.
F) Cómo leer el resultado y decidir.
G) Prompt B propuesto y qué cambia, si procede.

CRITERIOS DE CALIDAD
- Los criterios se fijan antes de ver ningún resultado; si no, la comparación no vale.
- Todo el proceso cabe en menos de una hora de trabajo mío.
- Español llano y directo. Empieza por el apartado A.
```
