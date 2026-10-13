# Runbook de despliegue · Prompt operativo…

**Tipo:** Prompt · **Área:** Infraestructura · **Licencia:** CC BY 4.0

Diseña despliegues en conversación; claridad sobre quién hace qué.

## Qué es y qué hace

Entra tu proceso de despliegue, los recursos y las restricciones, y la IA pide solo los datos imprescindibles. Sale una respuesta con resumen, tres riesgos, opciones comparadas, un entregable de preparación, ejecución, rollback y evidencias, y una primera acción de menos de 30 minutos. Funciona con Claude, Codex, Gemini o una IA local en una conversación, sin conectarse a tus servidores.

## Cómo usarla

1. Rellena los datos del despliegue
2. Responde las preguntas de la IA
3. Prueba la primera acción en un entorno de pruebas
4. Revisa el procedimiento con el equipo

## Cuándo usarla

Cuando quieras hacer despliegues repetibles y recuperables sin recibir una respuesta genérica.

## Cómo ganar dinero con ella

Conviértelo en una sesión guiada de runbook de despliegue o en un entregable recurrente para clientes.

- Sesión para diseñar un procedimiento de despliegue de una tienda online antes de una temporada alta.
- Consultoría para ordenar quién hace qué en las publicaciones de una pyme digital.
- Taller guiado de despliegues seguros para un equipo de desarrollo pequeño.

**Precio orientativo:** 80–200 € por sesión. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como especialista prudente en runbook de despliegue.

Objetivo: hacer despliegues repetibles y recuperables para equipo de operaciones.

Antes de empezar, pídeme únicamente los datos imprescindibles que falten. Distingue hechos, supuestos y dudas. No inventes cifras, fuentes, herramientas ni resultados. Explica los límites y no prometas resultados.

Trabaja en este orden:
1. Resume la situación y el resultado que debemos conseguir.
2. Señala los tres riesgos o huecos de información más importantes.
3. Propón opciones pequeñas y compara impacto, esfuerzo, coste y reversibilidad.
4. Crea el entregable: preparación, ejecución, rollback y evidencias.
5. Cierra con una lista de comprobación, una primera acción de menos de 30 minutos y qué medir.

Datos:
- Situación: [SITUACIÓN]
- Público o usuario: [PÚBLICO]
- Recursos disponibles: [RECURSOS]
- Plazo: [PLAZO]
- Restricciones: [RESTRICCIONES]

Escribe en español claro. Si algo requiere validación externa, indícalo de forma explícita.
```
