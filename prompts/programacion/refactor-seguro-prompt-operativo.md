# Refactor seguro · Prompt operativo…

**Tipo:** Prompt · **Área:** Programación · **Licencia:** CC BY 4.0

Refactor en conversación; explica riesgos y cómo revertir si sale mal.

## Qué es y qué hace

Prompt en texto libre que convierte una conversación con una IA en una sesión guiada de refactor seguro. Pide solo los datos imprescindibles que faltan, separa hechos de supuestos y entrega riesgos, opciones comparadas, pasos pequeños, pruebas, rollback, una lista de comprobación y una primera acción de menos de 30 minutos. Funciona en Claude, Codex, Gemini o una IA local, copiado tal cual en un chat.

## Cómo usarla

1. Copia el texto en una conversación nueva
2. Rellena situación, recursos y plazo
3. Pide el entregable en el orden indicado

## Cuándo usarla

Cuando quieras mejorar código sin cambiar el comportamiento esperado sin recibir una respuesta genérica.

## Cómo ganar dinero con ella

Conviértelo en una sesión guiada de refactor seguro o en un entregable recurrente para clientes.

- Sesión de consultoría de una hora para ordenar un refactor pendiente en un proyecto propio.
- Entregable mensual de refactor seguro para clientes con código heredado.
- Taller práctico para equipos que quieren aprender a cambiar código sin romper nada.

**Precio orientativo:** 30–90 € por sesión. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como especialista prudente en refactor seguro.

Objetivo: mejorar código sin cambiar el comportamiento esperado para equipo de desarrollo.

Antes de empezar, pídeme únicamente los datos imprescindibles que falten. Distingue hechos, supuestos y dudas. No inventes cifras, fuentes, herramientas ni resultados. Explica los límites y no prometas resultados.

Trabaja en este orden:
1. Resume la situación y el resultado que debemos conseguir.
2. Señala los tres riesgos o huecos de información más importantes.
3. Propón opciones pequeñas y compara impacto, esfuerzo, coste y reversibilidad.
4. Crea el entregable: riesgos, pasos pequeños, pruebas y rollback.
5. Cierra con una lista de comprobación, una primera acción de menos de 30 minutos y qué medir.

Datos:
- Situación: [SITUACIÓN]
- Público o usuario: [PÚBLICO]
- Recursos disponibles: [RECURSOS]
- Plazo: [PLAZO]
- Restricciones: [RESTRICCIONES]

Escribe en español claro. Si algo requiere validación externa, indícalo de forma explícita.
```
