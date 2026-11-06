---
name: auditoria-legal-web
description: Checks whether a website published in Spain meets the legal minimum (LSSI, GDPR, cookies, online sales, and accessibility) and returns a list of failures ordered by risk. It activates when the user asks whether their website or a client's "is compliant," before delivering a website, or to prepare a quote for legal compliance work.
---

# Quick legal audit of a website (Spain)

It is for reviewing a website in 20 minutes and coming away with a list of concrete things to fix. It is not a legal opinion: it is a filter so you do not deliver a website with textbook failures.

## What to ask for before starting

- The URL.
- Whether the owner is a freelancer (autónomo), a company, or a registered professional (profesional colegiado).
- Whether the site sells, collects data with forms, or only informs.
- Employees and approximate turnover of the owner (matters for accessibility, see step 6).
- If the user cannot paste the HTML, have them describe what they see or paste screenshots. It works for everything except step 4, which needs to inspect the cookies.

## Step by step

### 1. Legal notice (LSSI-CE, art. 10)
There is a page linked from the footer with: name or company name, tax ID (NIF), postal address, email, commercial registry details if it is a company, and professional association number if it is a regulated profession. Common failure: a "Contact" page with only a form, with no tax ID or address. It is a minor infringement of the LSSI (Spain's Information Society Services Law): up to €30,000.

### 2. Forms (GDPR)
On each form: first-layer information text (controller, purpose, rights, link to the policy) and a consent checkbox unchecked by default. If there is a newsletter, a checkbox separate from the contact one. A form with just a "Send" button is a failure.

### 3. Privacy policy
It exists, it belongs to this website (look for the names of other companies: copied ones are detected that way), it names the real processors (hosting, email marketing, payment gateway), it explains how to exercise rights and how to complain to the AEPD (Spain's data protection authority), and it has a last-updated date.

### 4. Cookies (LSSI art. 22.2 and AEPD guidance)
Open the website in an incognito window and check, in this order:
- Are Analytics, Meta Pixel, or YouTube cookies loaded BEFORE accepting? (F12, Application tab, Cookies). If so, it is the most frequent failure and the one the AEPD penalizes most.
- Does the banner have "Reject" at the same level as "Accept"? A big "Accept" and a small gray "configure" has not been valid since January 2024.
- Can you keep browsing without deciding? Closing the banner with the X is not consent.
- Is there a cookie policy with a table of the real cookies and a way to withdraw consent?
- If the website only uses technical cookies, no banner is needed. Adding one "just in case" is not a failure, but it is noise.

### 5. If it sells (e-commerce)
Final prices with VAT (IVA) included and shipping costs visible before paying. Terms of purchase with a 14 calendar-day right of withdrawal and a form to exercise it. A final button that says "Pay" or "Order with obligation to pay," not "Continue." Confirmation email with the terms.

### 6. Accessibility (Law 11/2023, applicable from June 28, 2025)
It applies to online shops, banking, passenger transport, telecommunications, and e-books. Service microenterprises are excluded: fewer than 10 employees and under 2 million euros in turnover. Public administration websites fall under another regulation (RD 1112/2018) and must always comply.
If it applies, the standard is WCAG 2.1 level AA and an accessibility statement must be published. Minimum check without tools: go through the website using only the Tab key, images with alt text, sufficient contrast, form fields with labels, videos with subtitles. For an automated pass: WAVE (wave.webaim.org) or Lighthouse in Chrome (F12, Lighthouse tab, Accessibility). Warn that automated checks detect roughly a third of the problems.

## What to return

A table with these columns: Failure · Where it is · Rule · Risk (high, medium, low) · How to fix it · Who does it (you, the client, or a lawyer).
Ordered by risk. High: cookies that load without consent, no legal notice, forms without consent, prices without VAT. Medium: text copied from another website, no date, no cookie table. Low: accessibility improvements when the law does not require them.
Below it, a 3-line paragraph to send to the client, without jargon, with the 3 urgent things and a closing sentence: "this is a technical review, not a legal report."

## What NOT to do

- Do not treat the website as "compliant" because it has the three legal pages. That they exist does not mean they are correct or that the banner blocks anything.
- Do not use the word "fine" to scare without stating the amount and which rule it comes from. If you do not know it, do not include it.
- Do not mark accessibility as a failure on a freelancer's informational website: it does not bind them. It goes in as an improvement.
- Do not recommend cookie plugins that only draw the banner and do not block cookies until they are accepted. That banner is useless.
- Do not replace a lawyer when the website processes health data, minors' data, or biometric data, or does profiling. That is flagged as "consult a professional" and left there.
