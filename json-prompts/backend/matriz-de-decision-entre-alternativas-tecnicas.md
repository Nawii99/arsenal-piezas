# Matriz de decisión entre alternativas técnicas…

**Tipo:** JSON prompt · **Área:** Backend · **Licencia:** CC BY 4.0

Compara dos o tres opciones técnicas con criterios ponderados, te da una tabla puntuada y una recomendación con su punto débil declarado.

## Qué es y qué hace

JSON prompt que compara dos o tres alternativas técnicas con criterios ponderados, devuelve una tabla puntuada y una recomendación que declara su punto débil. Se usa en cualquier chat de IA. Ejemplo: elegir entre dos bases de datos o proveedores según escala y horizonte.

## Cómo usarla

1. Copia el JSON
2. Indica problema, horizonte, escala y alternativas en los [corchetes]
3. Pégalo en la IA
4. Ajusta los pesos con tu equipo

## Cuándo usarla

Úsalo cuando el equipo está atascado entre varias tecnologías o proveedores y necesitas una comparación ordenada para poder decidir.

## Cómo ganar dinero con ella

Reduce semanas de debate y pruebas dispersas, y ayuda a no pagar por una opción cara que no te aporta nada en tu caso.

- Informes comparativos de tecnologías para pymes…
- Asesoría puntual en elección de proveedores técnicos…
- Matrices de decisión como entregable de consultoría…

**Precio orientativo:** 80–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Comparar alternativas técnicas con una matriz de criterios ponderados y emitir una recomendación argumentada",
  "contexto": {
    "problema_a_resolver": "[QUÉ PROBLEMA CONCRETO RESUELVE ESTA ELECCIÓN]",
    "horizonte": "[CUÁNTO TIEMPO ESPERAS VIVIR CON ESTA DECISIÓN: 1 AÑO, 3 AÑOS...]",
    "escala_esperada": "[USUARIOS, PETICIONES POR MINUTO O VOLUMEN DE DATOS ESPERADO]",
    "equipo": "[NÚMERO DE PERSONAS Y QUÉ TECNOLOGÍAS DOMINAN]"
  },
  "entradas": {
    "opciones": ["[OPCIÓN A]", "[OPCIÓN B]", "[OPCIÓN C]"],
    "criterios_y_pesos": [
      {"criterio": "Coste total al año (licencias + infraestructura + mantenimiento)", "peso": "[1-5]"},
      {"criterio": "Curva de aprendizaje para el equipo actual", "peso": "[1-5]"},
      {"criterio": "Esfuerzo de operación y monitorización", "peso": "[1-5]"},
      {"criterio": "Riesgo de quedarte atrapado con el proveedor", "peso": "[1-5]"},
      {"criterio": "Encaje con lo que ya tenéis montado", "peso": "[1-5]"},
      {"criterio": "Madurez, comunidad y soporte a largo plazo", "peso": "[1-5]"}
    ],
    "criterios_propios": "[AÑADE AQUÍ CRITERIOS ESPECÍFICOS DE TU NEGOCIO]"
  },
  "pasos": [
    "1. Puntúa cada opción de 1 a 5 en cada criterio y explica la nota en media línea",
    "2. Calcula la puntuación ponderada y muestra el total por opción",
    "3. Señala los criterios donde la diferencia entre opciones es irrelevante para este caso",
    "4. Detecta criterios eliminatorios: si una opción falla uno, queda descartada aunque puntúe alto",
    "5. Recomienda una opción y declara abiertamente su mayor punto débil",
    "6. Propone una prueba corta (máximo 3 días) que confirmaría o tumbaría la recomendación"
  ],
  "restricciones": [
    "No des empates: si dos opciones empatan, desempata con el criterio de mayor peso y dilo",
    "No uses cifras de rendimiento que no puedas justificar; marca los supuestos con la etiqueta SUPUESTO",
    "Ignora modas: valora solo lo que afecta a este equipo, este presupuesto y este plazo"
  ],
  "formato_salida": {
    "bloque_1": "Tabla markdown con criterios en filas, opciones en columnas, pesos y totales",
    "bloque_2": "Párrafo de recomendación de máximo 120 palabras",
    "bloque_3": "Lista de riesgos aceptados al elegir la recomendada",
    "bloque_4": "Descripción de la prueba de 3 días con qué medir y qué resultado la tumbaría"
  },
  "criterios_calidad": [
    "Cada nota tiene su porqué en una línea, nada de números sueltos",
    "La recomendación seguiría siendo la misma si el lector cambia ligeramente los pesos, o se avisa de que no",
    "S
```
