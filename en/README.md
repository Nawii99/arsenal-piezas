# Arsenal del Marketer · English

147 hand-picked pieces translated from Spanish: the ones rated highest in the catalog, spread across types and areas. The other pieces are in Spanish (Claude understands them and can answer in English).

## Claude Code (100 skills, slash commands and subagents)

Small plugins (about 1,800 tokens each), so you only load what you need. First `/plugin marketplace add Nawii99/arsenal-piezas`, then:

- `/plugin install arsenal-en-skills-1@arsenal` — 20 skills (part 1 of 2) for marketing, sales, design and small business.
- `/plugin install arsenal-en-skills-2@arsenal` — 20 skills (part 2 of 2) for marketing, sales, design and small business.
- `/plugin install arsenal-en-commands@arsenal` — 30 slash commands for marketing, sales, design and small business.
- `/plugin install arsenal-en-agents-1@arsenal` — 15 subagents (part 1 of 2) for marketing, sales, design and small business.
- `/plugin install arsenal-en-agents-2@arsenal` — 15 subagents (part 2 of 2) for marketing, sales, design and small business.

## Prompts (20)

- [Shot and Sound Director for AI Video](../en/prompts/audio/director-planos-sonido-video-ia.md) — Music & audio. Prompt that turns your video idea and settings into shot-by-shot prompts for AI video generators, with camera, light and sound described for each scene.
- [Check Whether My Invoice (or Stripe's) Meets the Requirements](../en/prompts/backend/prompt-revisar-factura-legal-espana.md) — Backend. Prompt for pasting a Spanish invoice or Stripe receipt to check mandatory fields, spot what may be missing and list questions to take to the accountant.
- [Test Plan and Acceptance Report](../en/prompts/calidad/plan-de-pruebas-acta.md) — Quality & testing. Prompt that produces a plain-language test plan table and a one-page acceptance report for a client to sign before the final payment on any software or automation delivery.
- [Extract Data from a CV Pasted as Text](../en/prompts/datos-ia/prompt-extraer-cv-texto.md) — Data & AI. Prompt for any AI chat that turns pasted CV text into a candidate profile, with a confidence level for each extraction.
- [Shipping and Returns Policy Draft](../en/prompts/ecommerce/borrador-envios-devoluciones.md) — E-commerce. Prompt that drafts the shipping and returns policy for a Spanish online shop from the shop's real data, marked as a draft that a lawyer must review.
- [Presentation Script for a Class](../en/prompts/educacion/prompt-presentacion-clase.md) — Education. Prompt that asks an AI for a classroom slide script: what appears on each slide, what the teacher says and which questions to ask, sized to the available minutes.
- [Open-to-Offers Post Without Sounding Desperate](../en/prompts/empleo/abierto-a-ofertas-sin-desesperar.md) — Jobs & résumé. A prompt that writes the LinkedIn post announcing you are open to work, with a confident tone instead of a begging one, ready to paste.
- [Tax Calendar for a New Freelancer in Spain](../en/prompts/finanzas/calendario-fiscal-autonomo.md) — Finance. Prompt for any AI text model that builds a Spanish freelancer's quarterly and annual tax filing calendar in plain language, to verify with the tax agency.
- [Studio Product Photo](../en/prompts/foto/foto-producto-estudio.md) — Photo & image. Prompt for AI image generators that describes a studio-style product photo, covering framing, angle, lens, lighting, shadow and background for each platform.
- [System Prompt X-Ray](../en/prompts/infraestructura/radiografia-prompts-de-sistema.md) — Infrastructure. Prompt that analyzes one or more system prompts, compares their structure, tone and limits, and helps you write your own in your own words, with safety warnings.
- [Planning a Homemade Surveillance Camera with the ESP32-CAM](../en/prompts/iot/prompt-camara-vigilancia-esp32-cam.md) — IoT & hardware. Prompt that plans a DIY ESP32-CAM home camera for a beginner: parts, setup, secure phone access and what Spanish law allows recording.
- [Playable Demo Plan](../en/prompts/juegos/plan-demo-juego.md) — Games & 3D. Prompt that plans a playable demo for Steam or itch.io: what to include, what to cut and how it should end.
- [Terms of Sale: Draft for Review](../en/prompts/legal/asiento-condiciones-venta.md) — Legal & contracts. Prompt that drafts general sales conditions for a Spanish online shop, with blanks and clauses that need a lawyer. The output is a working draft only.
- [Ad with Real Urgency: Copy That Doesn't Deceive](../en/prompts/marketing/anuncio-urgencia-real.md) — Marketing. Prompt for Claude, Codex, Gemini or a local AI that writes urgency ads based only on real deadlines, stock and offers, with a compliance check table.
- [Secure Erase Checklist Before Selling Your Phone](../en/prompts/movil/checklist-borrado-seguro-movil.md) — Mobile. Prompt that produces the exact order of steps to sell, give away or recycle a phone with no recoverable data, based on its model, OS and accounts.
- [Voice of the Customer: What They Really Want, Based on What They Have Already Told You](../en/prompts/negocio/voz-del-cliente-analisis.md) — Business. Prompt for Claude, Codex, Gemini or a local AI that extracts needs, desires, objections and literal quotes from anonymised customer texts.
- [Goal-Based Training Plan, No Generic Template](../en/prompts/salud/plan-entrenamiento-por-objetivo.md) — Health & fitness. Prompt that asks an AI to act as a certified trainer and build a weekly plan from level, goal, schedule, equipment and limitations, with 48-hour muscle recovery.
- [Analyze a Suspicious Email Before Falling for It](../en/prompts/seguridad/analizar-correo-sospechoso.md) — Cybersecurity. Prompt that analyzes a suspicious email from pasted text alone, comparing the visible sender with the real address and flagging warning signs.
- [Editing Brief for a Recurring Format](../en/prompts/video/brief-edicion-formato-recurrente.md) — Video. Prompt that generates a fixed editing brief for a recurring video format, so the structure does not need deciding every time.
- [Cookie Banner That Won't Get You in Trouble](../en/prompts/web/banner-cookies-aepd.md) — Web. Prompt asking Claude for cookie banner text and settings that follow AEPD guidance, with Reject as prominent as Accept, plus a classification of each cookie by category.

## JSON prompts (17)

- [AI Music Sales Assistant Profile](../en/json-prompts/audio/ficha-asistente-comercial-musica-ia.json) — Music & audio. JSON profile for a sales-chat assistant for an AI music service, with service catalog, turnaround, rules against closing sales and placeholder prices.
- [Design a Service's Plans and Pricing to Charge with Stripe](../en/json-prompts/backend/diseno-planes-suscripcion-stripe.json) — Backend. JSON prompt turning a freelancer's service into three priced plans with VAT, inclusions and a table ready to create in Stripe, without promising results.
- [Test Dataset Generator](../en/json-prompts/calidad/generador-dataset-prueba.json) — Quality & testing. JSON specification with fields, rules, Spanish context and output format for asking Claude or n8n to produce invented datasets, reusable for every demo with the same schema.
- [Answer Auditor: Catching Fabrications](../en/json-prompts/datos-ia/auditor-respuestas-invenciones.json) — Data & AI. JSON prompt that checks an AI answer sentence by sentence against its sources, flags unsupported claims and says whether it can be sent, without rewriting it.
- [Structured Payment Gateway Comparator](../en/json-prompts/ecommerce/comparador-pasarelas-pago.json) — E-commerce. Structured JSON prompt that produces a decision table comparing Stripe, PayPal and Redsys with fixed criteria, and forces the sales volume to be asked first.
- [Kahoot-Style Review Quiz](../en/json-prompts/educacion/cuestionario-repaso-json.json) — Education. JSON prompt that generates a multiple-choice review quiz with one correct answer and three plausible distractors per question, ready to import into Kahoot, Quizizz or Forms.
- [Public Footprint Audit](../en/json-prompts/empleo/auditoria-huella-publica.json) — Jobs & résumé. A JSON prompt that makes an AI review your LinkedIn, GitHub and search footprint like a recruiter would, scoring it and ordering fixes by impact.
- [Spanish Invoice Data Extraction](../en/json-prompts/finanzas/extraccion-datos-factura.json) — Finance. JSON prompt that asks an AI to extract a Spanish invoice's fields (numbers, dates, issuer, lines, VAT, IRPF) into fixed fields, with null for missing data.
- [Product Photo Spec by Platform](../en/json-prompts/foto/ficha-foto-producto-plataforma.json) — Photo & image. Structured JSON prompt that describes a full product photo set, including lighting, angle, background and per-platform sizes, so each piece comes out consistent.
- [Technical Visit Sheet for an IoT Project](../en/json-prompts/iot/json-ficha-visita-tecnica-iot.json) — IoT & hardware. JSON prompt that guides a technical visit to a client's home and returns a structured sheet with existing items, gaps, recommended materials, risks and open questions.
- [Compliance Diagnosis · JSON Prompt](../en/json-prompts/legal/asiento-json-cumplimiento.json) — Legal & contracts. Structured JSON prompt for an orientative basic compliance check of a Spanish website, listing missing legal texts, personal data and cookie items by risk.
- [Outreach Email to Press and Creators](../en/json-prompts/marketing/pitch-prensa-creadores-juego.json) — Marketing. JSON prompt producing a short personalised pitch email for a streamer, YouTuber or outlet, with subject line and a seven-day follow-up, written without template feel.
- [JSON Brief: Simple Android App](../en/json-prompts/movil/brief-app-sencilla-android.json) — Mobile. JSON brief for an AI to build a simple single-file HTML app that runs offline in an Android phone browser, with fixed response format and requirements.
- [Nutrition Plan Calculation Schema for Automation](../en/json-prompts/salud/esquema-plan-nutricional.json) — Health & fitness. JSON schema defining exact input and output to calculate calorie and macro plans consistently in an automation, with flags for human review.
- [Data Inventory and GDPR Review](../en/json-prompts/seguridad/inventario-datos-rgpd.json) — Cybersecurity. Structured JSON prompt for a basic personal-data inventory and GDPR review of a small business, with risks, actions and deadlines, limited to authorized systems.
- [Structured Video Project Brief](../en/json-prompts/video/brief-proyecto-video.json) — Video. Structured JSON brief for a video editing job, with client, format, technical requirements and commercial terms.
- [Legal Diagnosis of My Website from Scratch](../en/json-prompts/web/diagnostico-legal-web-desde-cero.json) — Web. JSON prompt describing a website so Claude can explain in plain language which Spanish legal notices and privacy texts apply, citing LSSI, GDPR, LOPDGDD and AEPD cookie guidance.

## Automation recipes (10)

- [n8n: Split Tracks and Transcribe Lyrics on Audio Upload](../en/recipes/audio/automatizacion-separar-pistas-transcribir-letra.md) — Music & audio. n8n workflow that watches a Drive folder, filters audio files, sends them to a stem-separation API, polls for results and logs lyric transcriptions.
- [From CV Folder to Spreadsheet, Automatically](../en/recipes/datos-ia/cv-drive-a-sheets.md) — Data & AI. n8n recipe that takes each CV saved to a Drive folder, extracts its data with AI and appends a row to Google Sheets.
- [Automatic Sale Alert with Stripe Payment Links](../en/recipes/ecommerce/aviso-venta-stripe-payment-links.md) — E-commerce. n8n recipe that records each Stripe Payment Link sale in a spreadsheet and sends you an email and Telegram alert at the moment of payment.
- [Sell and Deliver Course Packages with n8n](../en/recipes/educacion/automatizacion-venta-paquetes-curso.md) — Education. n8n workflow that takes a course package order, charges via Stripe, generates course material with AI and emails it, with a human check before sending.
- [Onboarding and Payment for a CV Order in n8n](../en/recipes/empleo/alta-cobro-encargo-cv-n8n.md) — Jobs & résumé. An n8n automation that takes a client order, creates a Stripe payment, alerts you once it is paid and confirms to the client, until the human work starts.
- [Make (make.com): Overdue Invoice Reminder from a Sheet](../en/recipes/finanzas/make-recordatorio-facturas-vencidas-sheets.md) — Finance. Make.com scenario that checks an invoice sheet every Monday and drafts Gmail reminders for overdue invoices. It flags those 30+ days late for your own decision and never sends or collects payments.
- [Alert for Asset Licenses About to Expire](../en/recipes/juegos/n8n-aviso-caducidad-licencias-assets.md) — Games & 3D. n8n workflow that checks a spreadsheet of temporary asset licenses weekly and alerts via Telegram or email before they expire.
- [Client Onboarding with Contract and Remote Signature](../en/recipes/legal/n8n-alta-cliente-contrato-firma.md) — Legal & contracts. n8n recipe for client onboarding: a form generates a contract from a Google Docs template, sends it for e-signature and tracks who signed.
- [New App Repository from Template When an Order Comes In](../en/recipes/movil/crear-repo-app-nueva-desde-plantilla.md) — Mobile. An n8n recipe that, when a project order arrives through a form, creates a GitHub repository from your React Native or Flutter template and notifies you.
- [Automatic Onboarding and Payment for an Online Training Client](../en/recipes/salud/alta-cobro-automatico-cliente-entrenamiento.md) — Health & fitness. n8n workflow that, on a confirmed Stripe payment, reads the Typeform questionnaire, generates a training plan, emails it and logs the client in a sheet.

License: [CC BY 4.0](../LICENSE). Credit: *«Based on Arsenal del Marketer (https://github.com/Nawii99/arsenal-piezas), CC BY 4.0»*.
