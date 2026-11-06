# Cookie Banner That Won't Get You in Trouble

**Type:** Prompt · **Area:** Web · **License:** CC BY 4.0 · [Spanish original](../../../prompts/web/banner-cookies-aepd.md)

Prompt asking Claude for cookie banner text and settings that follow AEPD guidance, with Reject as prominent as Accept, plus a classification of each cookie by category.

## What it is and what it does

Prompt to paste into Claude that requests the text and configuration of a cookie banner compliant with the AEPD cookie guide (Spain), with Reject at the same level as Accept. It classifies cookies as technical, analytics, personalization, and advertising, and returns the content of each button. Useful when your current banner is not compliant.

## The prompt (copy it whole)

```text
Act as a privacy consultant for a small website in Spain. I need the content and configuration of a cookie banner that complies with the AEPD's Guide on the Use of Cookies (2023 version, applicable from January 2024) and Article 22.2 of the LSSI (Spain's Information Society Services Law).

My website's details:
- Type of website: [ONLINE STORE / SERVICES SITE / BLOG / LANDING PAGE]
- Owner: [NAME OR COMPANY NAME]
- Cookie management tool I use: [COMPLIANZ / COOKIEBOT / IUBENDA / OTHER / NONE YET]
- Cookies or tools I load: [GOOGLE ANALYTICS 4, META PIXEL, YOUTUBE, GOOGLE MAPS, CHAT, OTHERS]
- Website languages: [SPANISH / SPANISH AND ENGLISH]
- Brand tone: [FRIENDLY / NEUTRAL / FORMAL]

I want you to return to me, in this order:

1. Classification of each cookie or tool I gave you into one of these categories: technical (does not need consent), analytics, personalization, advertising. If you don't know one, say so and don't classify it.

2. Text of the banner's first layer. Maximum 60 words. It must say who sets the cookies, what they are used for, and link to the cookie policy. Three buttons of the same size and at the same visual level: Accept all, Reject all, Configure. The AEPD requires that rejecting be as easy as accepting: without hiding the reject button in a small link or on a second screen.

3. Text of the second layer (the configuration panel): a description of one or two sentences per category, with the technical ones checked and locked, and the rest unchecked by default.

4. Configuration checklist for my tool: that no non-technical cookie is loaded before the user chooses, that the choice is saved and can be changed from a link in the footer, that the consent expires after 24 months at most and is requested again if the cookies change.

5. The texts also in English if I indicated more than one language.

Rules:
- Do not use the formula "by continuing to browse you accept." It is prohibited: continuing to browse is not consent.
- Do not make the reject button gray, smaller, or on another screen.
- Do not propose a cookie wall (forcing acceptance to enter) without warning that the AEPD only allows it if there is an equivalent alternative, such as paying, and that for a small website it is better to avoid it.
- If Google Analytics is on the list, remind me that it cannot be loaded without prior consent, and that there is the option of anonymizing IP or using an alternative that needs no banner, without naming specific products you don't know.
- If something depends on my tool and you don't know how it is configured, tell me instead of making it up.

Write in plain English, short sentences, with no technical terms that a non-programmer would not understand.
```
