---
name: calculadora-macros-tdee
description: Calculates a person's daily calorie expenditure (TDEE) and macronutrient split from their data, to build a diet or adjust a weight goal. It activates when someone asks "how many calories do I need," "calculate my macros," or similar.
---

# Macro and Calorie Calculator (TDEE)

## What it does
It calculates how many calories a person needs to eat per day (TDEE) and how to split them into protein, fat, and carbohydrates, according to their goal (lose fat, maintain, or gain muscle).

## What to ask before starting
- Current sex, age, height (cm), and weight (kg).
- Activity level: sedentary, light (1-3 days/week), moderate (3-5 days), high (6-7 days), or very high (physical job plus sport).
- Goal: lose fat, maintain weight, or gain muscle mass, and at what pace (for example, half a kilo per week).
- Whether they have any medical condition, are pregnant, are breastfeeding, or have had an eating disorder. If so, tell them this does not replace a registered dietitian-nutritionist or a doctor, and do not continue with the calculation.

## Step by step
1. Calculate the basal metabolic rate (BMR) with the Mifflin-St Jeor formula: men = 10×weight + 6.25×height − 5×age + 5; women = 10×weight + 6.25×height − 5×age − 161.
2. Multiply the BMR by the activity factor (1.2 / 1.375 / 1.55 / 1.725 / 1.9) to obtain the maintenance TDEE.
3. Adjust the TDEE according to the goal: subtract between 300 and 500 kcal to lose fat, add them to gain mass, leave it the same to maintain. Never go below 1200 kcal/day for women or 1500 kcal/day for men without warning that this is an indicative minimum and that below it professional supervision is needed.
4. Split the calories into macros: protein between 1.6 and 2.2 g per kg of body weight (higher if the goal is to gain muscle or there is aggressive fat loss), fat between 20% and 30% of total calories, and the rest in carbohydrates.
5. Convert each macro from grams to calories (protein and carbohydrates = 4 kcal/g, fat = 9 kcal/g) and check that the sum matches the adjusted TDEE.

## What to return
A table with: maintenance TDEE, target calories, and grams per day of protein, fat, and carbohydrates. Below it, two or three sentences explaining where the number comes from and that it is an estimate, not an exact figure.

## What NOT to do
- Do not diagnose or treat eating disorders: if you detect signs (extreme restriction, fear of eating, binge eating), recommend professional help and do not continue with the calculation.
- Do not prescribe supplements or drugs.
- Do not make up weight or height if the user does not provide them: ask for them, do not estimate by eye.
- Do not treat the result as an exact medical figure: it is a statistical formula with a margin of error of up to 10%.
