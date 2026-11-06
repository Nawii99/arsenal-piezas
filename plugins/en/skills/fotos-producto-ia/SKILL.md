---
name: fotos-producto-ia
description: The professional language of photography with AI. Always use it when the user asks for an image prompt, a product photo, an image for social networks or ads, or mentions Midjourney, Flux, Ideogram, or image generators. It automatically applies the right shots, angles, lenses, lighting, and aspect ratios.
---

# AI product photos

When building any image prompt for marketing, ALWAYS combine these 6 ingredients in this order: subject → shot → angle → lens → lighting → style → format. The prompt is written in English; the explanation to the user, in the user's language.

## 1. Shot (how much is seen)
- `extreme close-up shot` — extreme detail: textures, logos, droplets.
- `close-up shot` — the product fills the image.
- `medium shot` — product with some context.
- `full shot` — complete scene or full body.
- `flat lay` — composition seen from above (combine with top-down).
- `macro photography` — for tiny details with a blurred background.

## 2. Angle (where the camera looks from)
- `eye level shot` — neutral, honest; the catalog standard.
- `low angle shot` — from below: the product looks important, imposing.
- `high angle shot` — from above: close, approachable.
- `top-down view / overhead shot` — overhead for flat lays and food.
- `three-quarter view` — the classic product angle (shows front and side).
- `dutch angle` — tilted: dynamism, for eye-catching ads.

## 3. Lens and camera (the look)
- `85mm f/1.8, shallow depth of field` — creamy blurred background, premium look.
- `35mm lens` — natural, reportage/lifestyle style.
- `100mm macro lens` — extreme sharpness in detail.
- `bokeh background` — blurred lights behind.
- `tilt-shift` — miniature effect.

## 4. Lighting (the mood)
- `soft studio lighting, softbox` — clean studio light, no harsh shadows.
- `golden hour lighting` — warm, sunset, lifestyle.
- `rim lighting` — a rim of light that separates the product from the background, premium.
- `dramatic side lighting` — strong shadows, character.
- `neon lighting` — modern, nighttime, tech.
- `natural window light` — homey, honest, artisanal.

## 5. Style
- `professional product photography` — the essential basic.
- `editorial style` — magazine, sophisticated.
- `lifestyle photography` — in use, with people.
- `UGC style photo, shot on iPhone` — believable homemade look for ads.
- `minimalist, clean background` — clean background for catalog.

## 6. Format by destination (critical — do not make up)
- Square feed: `--ar 1:1`
- Instagram vertical feed: `--ar 4:5`
- Stories / Reels / TikTok: `--ar 9:16`
- YouTube / horizontal web: `--ar 16:9`
- Pinterest: `--ar 2:3`
(`--ar` is Midjourney syntax; in other generators, write "vertical 9:16 format" in the text or choose the size in the interface.)

## Base template

`[product + surface/setting], [shot], [angle], [lens], [lighting], [style], high resolution --ar [ratio]`

Example: `amber glass skincare bottle on wet black slate, water droplets, close-up shot, three-quarter view, 85mm f/1.8 shallow depth of field, rim lighting, professional product photography, high resolution --ar 4:5`

## Rules

- Always ask for the image's destination if they do not say: the aspect ratio depends on it.
- One concept per image: do not mix golden hour with neon.
- For text inside the image (logos, legible labels) recommend Ideogram or Recraft, which do it better.
- Always offer 2-3 variants with a different concept, not the same one with synonyms.
