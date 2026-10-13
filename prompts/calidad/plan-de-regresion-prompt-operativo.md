# Plan de regresión · Prompt operativo…

**Tipo:** Prompt · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Diseña pruebas en conversación; sabe cuándo parar.

## Qué es y qué hace

Entra la situación de tu producto, el equipo de calidad y las restricciones, y la IA pide solo los datos imprescindibles. Sale una respuesta con resumen, tres riesgos, opciones comparadas, matriz de pruebas, casos y criterio de salida, y una primera acción de menos de 30 minutos. Funciona con Claude, Codex, Gemini o una IA local en una conversación.

## Cómo usarla

1. Rellena los datos del producto
2. Responde las preguntas de la IA
3. Ejecuta la primera prueba prioritaria
4. Revisa el criterio de salida con el equipo

## Cuándo usarla

Cuando quieras probar lo importante según riesgo sin recibir una respuesta genérica.

## Cómo ganar dinero con ella

Conviértelo en una sesión guiada de plan de regresión o en un entregable recurrente para clientes.

- Sesión de diseño de pruebas para una app que quiere reducir errores antes de cada versión.
- Taller guiado de pruebas de regresión para un equipo de desarrollo pequeño.
- Consultoría para definir cuándo parar de probar antes de lanzar una web de cliente.

**Precio orientativo:** 80–200 € por sesión. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como especialista prudente en plan de regresión.

Objetivo: probar lo importante según riesgo para equipo de calidad.

Antes de empezar, pídeme únicamente los datos imprescindibles que falten. Distingue hechos, supuestos y dudas. No inventes cifras, fuentes, herramientas ni resultados. Explica los límites y no prometas resultados.

Trabaja en este orden:
1. Resume la situación y el resultado que debemos conseguir.
2. Señala los tres riesgos o huecos de información más importantes.
3. Propón opciones pequeñas y compara impacto, esfuerzo, coste y reversibilidad.
4. Crea el entregable: matriz, casos, datos y criterio de salida.
5. Cierra con una lista de comprobación, una primera acción de menos de 30 minutos y qué medir.

Datos:
- Situación: [SITUACIÓN]
- Público o usuario: [PÚBLICO]
- Recursos disponibles: [RECURSOS]
- Plazo: [PLAZO]
- Restricciones: [RESTRICCIONES]

Escribe en español claro. Si algo requiere validación externa, indícalo de forma explícita.
```
