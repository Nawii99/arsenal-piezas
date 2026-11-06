---
name: elegir-y-revisar-graficos-en
description: Chooses the type of chart or table that best tells a specific set of data according to the message and the audience, and reviews charts that already exist (axes, colors, titles, mobile reading). Use it when the user has numbers to present or a chart that is not understood.
---

<!-- Installation: save this file as .claude/skills/elegir-y-revisar-graficos/SKILL.md inside your working folder. -->

# Pick the chart and review the one you already have

## What it does
Two jobs. First, deciding which chart or table best tells a set of data. Second, reviewing a chart that already exists and saying what confuses, what misleads, and how to fix it.
The user does not code. Do not give them code. Give them the steps, with clicks, in the tool they use (Excel, Google Sheets, Looker Studio, Power BI, Canva, or PowerPoint).

## What to ask before starting
Ask for whatever is missing, in short blocks.
1. What the person who sees it should think or do. One sentence.
2. Who will see it (client, investor, team, boss) and what they already know about the topic.
3. Where it will be seen. Slide, PDF, email, phone screen, or printed in black and white.
4. What data there is. Have them paste it, point to the file, or say where it is (with a connector to Google Sheets or Drive you can read it). For each column, what it is, in what unit, and for what period.
5. What tool they will build it with.
6. If there is already a chart, have them send the image or a screenshot. You can look at images.
7. Whether the data includes anything that must not leave the company (named customers, salaries, health). If so, work with aggregated or anonymized figures.

## Step by step
1. Write the message as one sentence that is a conclusion, for example "Online sales have exceeded in-store sales since May." If there is no clear conclusion, say so and propose what to look at.
2. Check the data before drawing. Empty values, incomplete periods (the last month half done), mixed units (euros with and without VAT), duplicates. Warn about what you see. Do not fix it silently.
3. Classify the question and choose the chart.
- How something changes over time. Lines.
- Comparing categories. Bars, horizontal if the names are long, sorted from highest to lowest.
- What share of the total each thing is. A single divided bar or a table. A pie chart only with two or three slices.
- How values are distributed, for example order amounts. Histogram.
- Whether two things rise or fall together. Points (scatter plot), without saying that one causes the other.
- Exact values or lots of data with few figures. Table, with the important figure highlighted.
- A single key figure. Big number with its comparison (last month or target).
4. Propose a main option and an alternative. In one sentence, why, and what you rule out and why.
5. Apply design rules. A title that states the conclusion and not just the topic. Bars with the axis at zero. One highlight color and the rest in gray. Labels attached to the data rather than a distant legend. Units (euros, %) always. Source and date at the bottom. If there are more than four lines, highlight one and leave the rest gray.
6. Think about accessibility. Do not depend on color alone (many people confuse red and green), use text that is legible on mobile and good contrast, and add a sentence that summarizes the chart for anyone who cannot see it.
7. If there is already a chart, do the review. Order the problems by severity. First the ones that mislead (truncated axis on bars, 3D, two axes that suggest a false relationship, a period chosen conveniently, percentages without a base). Then the ones that are hard to read (too many colors, a distant legend, extra decimals). Last the aesthetic ones. For each one, what happens, why it matters, and how to fix it in their tool.
8. Review the wording. If the data only shows that two things coincide, do not use "causes," "thanks to," or "triggers." If the sample is small, say so in the footer.

## What to return and in what format
Markdown, with these sections and in this order.
- The message in one sentence.
- Recommended chart, alternative, and why.
- Steps to build it in their tool.
- Suggested title and footer, with source and period.
- If there was a chart, the list of problems ordered by severity, each with its fix.
- Warnings about the data.
- What a person must review. See the next section.

## What a person reviews before showing it
- That the figures match the accounting or the original source. If it is for investors, clients, or banks, have whoever keeps the books (gestoría or finance lead) check them.
- That the chart does not exaggerate. Showing only the data that favors you to secure a sale or financing can end up being misleading, with legal consequences.
- That no customer names or other personal data are visible without permission.

## What NOT to do
- Do not invent, estimate, or fill in missing data. Mark [MISSING].
- Do not change the chart to make the result look better. Do not truncate axes, do not change the period, do not remove outliers without saying so.
- Do not use 3D, or pie charts with many slices, or two axes unless there is no other way.
- Do not choose a chart just because it looks flashy.
- Do not paste data with named customers or personal data into external tools without permission.
- Do not give code if the user does not code. Give them the steps in their tool.
- Do not make business decisions. The chart shows, the person decides.
