---
name: calculo-calorias-macros
description: Calcula las calorías de mantenimiento (TDEE) y el reparto de macros de una persona a partir de sus datos básicos. Se activa cuando alguien pregunta cuántas calorías necesita o cómo repartir proteína, grasa e hidratos para un objetivo.
---

## Qué hace
Calcula una estimación de las calorías diarias que necesita una persona (TDEE) y reparte esas calorías en gramos de proteína, grasa e hidratos de carbono según su objetivo (mantener peso, perder grasa o ganar músculo).

## Antes de empezar, pregunta
- Sexo, edad, peso (kg) y altura (cm).
- Nivel de actividad: sedentario, ligero, moderado, activo o muy activo.
- Objetivo: mantener, perder peso o ganar masa muscular.
- Si tiene alguna enfermedad, está embarazada, en lactancia, o es menor de edad. Si es así, dilo claramente: esta skill no sirve para esos casos y hace falta un profesional sanitario.

## Paso a paso
1. Calcula el metabolismo basal con la fórmula de Mifflin-St Jeor: hombres = 10×peso + 6,25×altura − 5×edad + 5; mujeres = 10×peso + 6,25×altura − 5×edad − 161.
2. Multiplica el resultado por el factor de actividad: sedentario ×1,2, ligero ×1,375, moderado ×1,55, activo ×1,725, muy activo ×1,9.
3. Ese número es el TDEE, las calorías de mantenimiento.
4. Según el objetivo, ajusta: para perder peso resta entre un 15% y un 20% del TDEE (nunca más), para ganar músculo suma entre un 10% y un 15%.
5. Reparte en macros: proteína 1,6-2,2 g por kg de peso, grasa 0,8-1 g por kg de peso, el resto de calorías en hidratos de carbono (1 g de proteína o hidrato = 4 kcal, 1 g de grasa = 9 kcal).

## Qué devolver
Una tabla simple con: TDEE estimado, calorías objetivo, y gramos de proteína, grasa e hidratos al día. Añade siempre la frase: 'Esto es una estimación, no un diagnóstico ni una pauta médica.'

## Qué NO hacer
- No lo apliques a menores de edad, embarazadas, personas en lactancia o con enfermedades (diabetes, problemas renales, trastornos de la conducta alimentaria, etc.). Redirige a un profesional sanitario.
- No bajes de 1.200 kcal/día en mujeres ni de 1.500 kcal/día en hombres sin supervisión profesional, por bajo que salga el cálculo.
- No des la cifra como algo exacto ni clínico: es una fórmula orientativa con margen de error.
- No sugieras suplementos, fármacos ni dietas restrictivas.
