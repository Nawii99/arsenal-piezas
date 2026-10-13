---
name: lista-compra
description: Convierte un menú semanal ya escrito, o una lista de recetas sueltas, en una lista de la compra agrupada por sección de supermercado, con cantidades sumadas y sin duplicados, en formato checklist para llevar en el móvil. Se activa cuando el usuario pega un menú o unas recetas y pide "la lista de la compra".
---

# Comando: lista de la compra

## Qué hace
Coge el menú o las recetas que pega el usuario y devuelve una lista de la compra lista para usar en el súper, sin tener que repasar receta por receta a mano.

## Qué preguntar antes de empezar
- Si el usuario no ha pegado el menú o las recetas todavía, pídeselo antes de nada: sin eso no hay lista.
- Si tiene ya en casa productos de despensa habituales (sal, aceite, especias) que no quiere que aparezcan en la lista.
- Si prefiere la lista agrupada por sección de supermercado o por día de compra, por si va dos veces por semana.

## Paso a paso
1. Extrae todos los ingredientes de cada receta o comida del menú, con su cantidad.
2. Suma las cantidades de un mismo ingrediente cuando aparece en varias recetas (por ejemplo, si el pollo aparece en tres platos, se suma el total de gramos).
3. Quita de la lista lo que el usuario haya dicho que ya tiene en casa.
4. Agrupa los ingredientes por sección: frutería y verdulería, carnicería y pescadería, lácteos y huevos, despensa (arroz, pasta, legumbres, conservas), congelados, y otros.
5. Redondea las cantidades a la unidad en la que se compra de verdad (por ejemplo, si hacen falta 350 g de pasta y el paquete es de 500 g, indica "1 paquete de 500 g" cuando tenga sentido).

## Qué devolver
Una checklist en markdown (con guion y corchetes) organizada por secciones, para poder marcar directamente desde el móvil mientras se compra.

## Qué NO hacer
- No añadas productos que no estén en ninguna receta del menú, aunque "suelan hacer falta".
- No cambies la cantidad que se cocina de una receta para redondear si eso afecta a las calorías o macros ya calculados: redondea solo la unidad de compra, no la ración.
- No metas marcas comerciales concretas salvo que el usuario las pida.
- No mezcles en la misma lista la compra de dos semanas distintas si el usuario no lo pide.
