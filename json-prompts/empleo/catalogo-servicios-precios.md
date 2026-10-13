# Catalogo de servicios y precios…

**Tipo:** JSON prompt · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

JSON con el catalogo completo del servicio: cuatro paquetes, extras, condiciones, fiscalidad espanola y limites de lo que se promete.

## Qué es y qué hace

JSON prompt que genera el catálogo comercial completo de un servicio de ayuda a candidatos: cuatro paquetes, extras, condiciones, fiscalidad española y los límites de lo que se promete. Entra el público, las horas semanales, el canal de venta y los precios base, y sale un objeto JSON coherente que puedes usar en web, presupuestos y presentaciones. Se ejecuta en Claude, Codex, Gemini o una IA local; revisa el IVA y las condiciones con un profesional.

## Cómo usarla

1. Rellena público, horas y canal de venta
2. Ejecuta el prompt con tus precios base
3. Comprueba que coincide con la web y los presupuestos
4. Que lo revise un profesional (fiscalidad)

## Cuándo usarla

Cuando quieras regenerar o actualizar tu catalogo comercial completo de forma consistente, o pasarselo a otra IA como base.

## Cómo ganar dinero con ella

Es tu lista de precios en formato reutilizable: la pegas y sale el catalogo entero coherente, sin contradecirte entre la web y el presupuesto.

- Catálogo de precios coherente para un servicio de candidatos, listo para usar en web y presupuestos.
- Plantilla de catálogo para academias de formación que venden paquetes de preparación laboral.
- Revisión de precios y condiciones para autónomos que quieren ordenar su oferta comercial.

**Precio orientativo:** 40–60 € por catálogo. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Genera el catalogo comercial completo de un servicio de ayuda a candidatos tech en Espana: paquetes, precios, alcance, entregables y condiciones.",
  "idioma": "espanol de Espana, tuteando al cliente",
  "contexto_del_negocio": {
    "quien_lo_presta": "Persona sola, no programadora, que usa Claude Code y n8n para trabajar mas rapido",
    "publico": [
      "Junior sin experiencia que busca su primer puesto tech",
      "Persona que cambia de sector hacia tecnologia",
      "Perfil con experiencia que lleva meses sin respuestas"
    ],
    "canal_de_venta": "Pagina de ventas propia + LinkedIn + boca a boca",
    "horas_semanales_disponibles": 12,
    "promesa": "Se vende el trabajo hecho y la revision, nunca el resultado de la busqueda"
  },
  "paquetes": [
    {
      "id": "revision-express",
      "nombre": "Revision express de curriculum",
      "precio_eur_sin_iva": 49,
      "iva_21_incluido_eur": 59.29,
      "plazo_dias_habiles": 2,
      "revisiones_incluidas": 1,
      "horas_estimadas": 1.5,
      "para_quien": "Quien ya tiene curriculum y solo quiere saber que falla",
      "incluye": [
        "Lectura del curriculum contra una oferta real que envia el cliente",
        "Informe de 1 pagina con los 10 arreglos por orden de impacto",
        "Comprobacion de lectura por filtros ATS: formato, columnas, fuentes, palabras clave"
      ],
      "entregables": ["informe-revision.pdf", "checklist-arreglos.md"],
      "no_incluye": ["Reescritura del curriculum", "Carta de presentacion", "Postular por el cliente"]
    },
    {
      "id": "curriculum-y-carta",
      "nombre": "Curriculum y carta adaptados",
      "precio_eur_sin_iva": 120,
      "iva_21_incluido_eur": 145.2,
      "plazo_dias_habiles": 4,
      "revisiones_incluidas": 2,
      "horas_estimadas": 4,
      "para_quien": "Quien tiene claro el puesto y quiere el material listo",
      "incluye": [
        "Videollamada de 30 minutos para sacar logros medibles",
        "Curriculum reescrito en version ATS (docx) y version bonita (pdf)",
        "Carta de presentacion base mas dos variantes cortas para InfoJobs y LinkedIn",
        "Titular y extracto de LinkedIn reescritos"
      ],
      "entregables": [
        "curriculum-ats.docx",
        "curriculum.pdf",
        "carta-presentacion.md",
        "linkedin-titular-y-extracto.md"
      ],
      "no_incluye": ["Postular por el cliente", "Simulacros de entrevista", "Inventar experiencia que no existe"]
    },
    {
      "id": "candidatura-completa",
      "nombre": "Candidatura completa",
      "precio_eur_sin_iva": 250,
      "iva_21_incluido_eur": 302.5,
      "plazo_dias_habiles": 7,
      "revisiones_incluidas": 2,
      "horas_estimadas": 8,
      "para_quien": "Quien empieza de cero y no sabe ni por donde atacar",
      "incluye": [
        "Todo el paquete curriculum-y-carta",
        "Portfolio web de una pagina publicado gratis en GitHub Pages o Cloudflare Pages",
        "Lista de 40 empresas y portales donde postular, con el orden y el mensaje para cada uno",
        "Plantilla de seguimiento de candidaturas en hoja de calculo"
      ],
      "entregables": [
        "curriculum-ats.docx",
        "curriculum.pdf",
        "carta-presentacion.md",
        "portfolio-url.txt",
        "lista-empresas.csv",
        "seguimiento-candidaturas.xlsx"
      ],
      "no_incluye": ["Automatizar el envio masivo en LinkedIn", "Garantia de entrevistas o de puesto"]
    },
    {
      "id": "acompanamiento-4-semanas",
      "nombre": "Acompanamiento 4 semanas",
      "precio_eur_sin_iva": 490,
      "iva_21_incluido_eur": 592.9,
      "plazo_dias_habiles": 28,
      "revisiones_incluidas": 4,
      "horas_estimadas": 14,
      "para_quien": "Quien necesita que alguien le empuje cada semana",
      "incluye": [
        "Todo el paquete candidatura-completa",
        "Una videollamada de 45 minutos por semana, cuatro en total",
        "Dos simulacros de entrevista con informe de mejora",
        "Revision semanal de las candidaturas enviadas y ajuste del mensaje",
        "Guion de negociacion de sueldo con la horquilla bruta anual real del puesto en Espana"
      ],
      "entregables": [
```
