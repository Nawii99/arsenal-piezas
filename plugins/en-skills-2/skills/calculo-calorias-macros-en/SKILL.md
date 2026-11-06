---
name: calculo-calorias-macros-en
description: Calculates maintenance calories (TDEE) and the macro split for a person from their basic data. Activates when someone asks how many calories they need or how to split protein, fat, and carbohydrates for a goal.
---

## What it does
Calculates an estimate of the daily calories a person needs (TDEE) and splits those calories into grams of protein, fat, and carbohydrates according to their goal (maintain weight, lose fat, or gain muscle).

## Before starting, ask
- Sex, age, weight (kg), and height (cm).
- Activity level: sedentary, light, moderate, active, or very active.
- Goal: maintain, lose weight, or gain muscle mass.
- Whether they have any illness, are pregnant, breastfeeding, or are a minor. If so, say it clearly: this skill is not suitable for those cases and a healthcare professional is needed.

## Step by step
1. Calculate basal metabolic rate with the Mifflin-St Jeor formula: men = 10×weight + 6.25×height − 5×age + 5; women = 10×weight + 6.25×height − 5×age − 161.
2. Multiply the result by the activity factor: sedentary ×1.2, light ×1.375, moderate ×1.55, active ×1.725, very active ×1.9.
3. That number is the TDEE, the maintenance calories.
4. Depending on the goal, adjust: to lose weight subtract between 15% and 20% of the TDEE (never more), to gain muscle add between 10% and 15%.
5. Split into macros: protein 1.6-2.2 g per kg of body weight, fat 0.8-1 g per kg of body weight, the remaining calories as carbohydrates (1 g of protein or carbohydrate = 4 kcal, 1 g of fat = 9 kcal).

## What to return
A simple table with: estimated TDEE, target calories, and grams of protein, fat, and carbohydrates per day. Always add the sentence: 'This is an estimate, not a diagnosis or medical guidance.'

## What NOT to do
- Don't apply it to minors, pregnant or breastfeeding women, or people with illnesses (diabetes, kidney problems, eating disorders, etc.). Redirect to a healthcare professional.
- Don't go below 1,200 kcal/day for women or 1,500 kcal/day for men without professional supervision, however low the calculation comes out.
- Don't present the figure as exact or clinical: it is an approximate formula with a margin of error.
- Don't suggest supplements, drugs, or restrictive diets.
