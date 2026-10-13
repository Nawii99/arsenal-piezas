# Contrato de API · Prompt operativo…

**Tipo:** Prompt · **Área:** Backend · **Licencia:** CC BY 4.0

Diseña una API en conversación; explica límites y qué pasa si falla.

## Qué es y qué hace

Entra la situación de tu API, sus usuarios y las restricciones, y la IA pide solo los datos imprescindibles. Sale una respuesta con resumen, tres riesgos, opciones comparadas por impacto y esfuerzo, endpoints, errores, permisos y pruebas, y una primera acción de menos de 30 minutos. Funciona con Claude, Codex, Gemini o una IA local en una conversación.

## Cómo usarla

1. Rellena los datos de la API
2. Responde las preguntas de la IA
3. Aplica la primera acción en un entorno de pruebas
4. Revisa el diseño con el equipo

## Cuándo usarla

Cuando quieras diseñar una API predecible y segura sin recibir una respuesta genérica.

## Cómo ganar dinero con ella

Conviértelo en una sesión guiada de contrato de api o en un entregable recurrente para clientes.

- Sesión de diseño de una API para un negocio que quiere conectar su web con su gestor de pedidos.
- Consultoría para definir errores y permisos antes de abrir una API a terceros.
- Taller guiado de contratos de API para un equipo backend pequeño.

**Precio orientativo:** 80–200 € por sesión. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como especialista prudente en contrato de api.

Objetivo: diseñar una API predecible y segura para equipo backend.

Antes de empezar, pídeme únicamente los datos imprescindibles que falten. Distingue hechos, supuestos y dudas. No inventes cifras, fuentes, herramientas ni resultados. Explica los límites y no prometas resultados.

Trabaja en este orden:
1. Resume la situación y el resultado que debemos conseguir.
2. Señala los tres riesgos o huecos de información más importantes.
3. Propón opciones pequeñas y compara impacto, esfuerzo, coste y reversibilidad.
4. Crea el entregable: endpoints, errores, permisos y pruebas.
5. Cierra con una lista de comprobación, una primera acción de menos de 30 minutos y qué medir.

Datos:
- Situación: [SITUACIÓN]
- Público o usuario: [PÚBLICO]
- Recursos disponibles: [RECURSOS]
- Plazo: [PLAZO]
- Restricciones: [RESTRICCIONES]

Escribe en español claro. Si algo requiere validación externa, indícalo de forma explícita.
```
