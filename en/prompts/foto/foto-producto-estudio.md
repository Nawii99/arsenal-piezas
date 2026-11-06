# Studio Product Photo

**Type:** Prompt · **Area:** Photo & image · **License:** CC BY 4.0 · [Spanish original](../../../prompts/foto/foto-producto-estudio.md)

Prompt for AI image generators that describes a studio-style product photo, covering framing, angle, lens, lighting, shadow and background for each platform.

## What it is and what it does

A prompt that asks an image AI for a studio-looking product photo: framing, angle, equivalent lens, light, shadow, and background, depending on where it will be published. Input: the product with its material and color, the brand, and the destination (listing, Instagram, or ad); output: a description ready to generate the image without invented text. Works with image generators and with the text AI that drives them.

## The prompt (copy it whole)

```text
Act as a product photographer. I want a realistic, catalog-style image, with no text inside the photo.

PRODUCT: [WHAT IT IS, MATERIAL AND COLOR, FOR EXAMPLE: 50 ml amber glass jar with a wooden stopper]
BRAND AND TONE: [SERIOUS AND PREMIUM / NATURAL AND ARTISAN / YOUNG AND COLORFUL]
WHERE IT IS PUBLISHED: [STORE LISTING / INSTAGRAM / META AD / AMAZON]

FRAMING AND OPTICS
- Shot: [PRODUCT ALONE ON A PLAIN BACKGROUND / PRODUCT IN ITS SETTING]
- Angle: [FRONTAL AT PRODUCT HEIGHT / THREE-QUARTER / OVERHEAD FROM ABOVE]
- Equivalent to an 85 mm lens, aperture f/8, whole product in focus from front to back.

LIGHT
- Large, soft key light at 45 degrees from the left, like a studio window.
- White bounce from the right to open up the shadow, without removing it entirely.
- A contact shadow under the product, short and with a soft edge, that grounds it on the surface.

BACKGROUND AND COLOR
- Background: [OFF-WHITE / CONCRETE GRAY / LIGHT WOOD / LINEN FABRIC]
- Product centered, with space around it so it can be cropped.
- Label legible and faithful to the original, without inventing text or logos.

OUTPUT FORMAT
- Aspect ratio: [1:1 FOR LISTING / 4:5 FOR INSTAGRAM / 16:9 FOR HEADER]
- Minimum long side 2000 px, sRGB color profile.

AVOID: odd reflections in the glass, hands, watermarks, invented text, two products where there is only one, distortions in the label's typography.

WARNINGS YOU MUST RESPECT
- If a person or a face appears, that person's permission is needed before using the image, and it must be indicated that the image is generated when it could mislead the buyer.
- The generated photo cannot show features that the real product does not have: that is misleading advertising and can end in returns or a complaint.
- Before publishing, compare with a real photo of the product and correct color and proportions.
```
