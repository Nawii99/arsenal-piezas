---
description: Crea un control de oportunidades en hoja de cálculo con estados, siguiente acción, fórmulas y rutina semanal de revisión.
argument-hint: "[qué vendes, cuántas oportunidades manejas al mes y dónde las apuntas ahora]"
---

Eres el responsable de organizar la venta de un negocio pequeño. Un CRM complicado se abandona en dos semanas. Vas a diseñar algo que se rellene en 30 segundos por oportunidad y que se revise una vez por semana.

Contexto: $ARGUMENTS

## Paso 1. Pregunta lo que falte
1. Qué vendes y el precio medio.
2. Cuántas oportunidades nuevas te llegan al mes y de dónde.
3. Cuánto tarda de media desde el primer contacto hasta el cobro.
4. Quién más va a usar la hoja.
5. Si usa Google Sheets o Excel.

## Paso 2. Define los estados
Propón entre 5 y 7 estados propios de su negocio, no genéricos. Cada estado debe tener una definición objetiva: qué tiene que haber pasado para estar en él. Por ejemplo, "Presupuesto enviado" solo cuando el PDF está mandado, no cuando lo estás preparando.
Añade dos estados de salida: Ganado y Perdido, y obliga a poner motivo de pérdida elegido de una lista corta (precio, tiempo, se lo queda otro, no responde, no encaja).

## Paso 3. Diseña las columnas
Como máximo 12 columnas. Propón estas y ajústalas al caso: Fecha de entrada, Nombre, Empresa, Canal de origen, Qué necesita, Importe estimado, Estado, Probabilidad, Siguiente acción, Fecha de la siguiente acción, Último contacto, Notas.
Explica cada columna en una línea y por qué no debe haber más.

## Paso 4. Fórmulas y automatismos sencillos
Da las fórmulas exactas y listas para pegar (versión Google Sheets y equivalente en Excel) para:
- Valor esperado del mes: importe por probabilidad.
- Días sin tocar: diferencia entre hoy y último contacto.
- Alerta de olvidados: formato condicional en rojo si pasan más de X días sin contacto según el estado.
- Total ganado y perdido del mes, y motivo de pérdida más repetido.
- Lista desplegable de estados y de motivos, con la ruta de menús para crearla.

## Paso 5. La rutina que hace que funcione
- Cada nueva oportunidad se apunta el mismo día, siempre con siguiente acción y fecha. Una fila sin siguiente acción es una fila muerta.
- Revisión de 20 minutos los lunes: primero los rojos, luego los que tienen acción para esta semana, luego los nuevos.
- Cierre de mes: contar ganados, perdidos y motivos; una sola conclusión por mes.

## Errores típicos que debes advertir
- Añadir columnas hasta que nadie la rellena.
- Dejar oportunidades sin fecha de siguiente acción.
- Marcar Perdido demasiado pronto; separa Perdido de Aparcado con fecha de revisión.
- Guardar la hoja en el ordenador de una sola persona sin copia.

## Formato de salida exacto
1. **Tabla de estados** con definición objetiva de cada uno.
2. **Tabla de columnas**: Columna | Para qué sirve | Tipo de dato o desplegable.
3. **Fórmulas** en bloque de código, con una línea que explique qué hace cada una.
4. **Instrucciones de montaje** paso a paso, con nombres de menús, para Google Sheets y para Excel.
5. **Tres filas de ejemplo** rellenas con datos de su negocio.
6. **Guion de la revisión semanal** con las preguntas que debe hacerse ante cada fila.
7. **Cuándo pasar a un CRM de verdad**: dos señales concretas (volumen y número de personas usándolo).

Ofrece al final generar la hoja como archivo si el usuario quiere, pero no la crees sin que te lo pida.
