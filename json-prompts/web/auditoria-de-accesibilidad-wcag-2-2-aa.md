# Auditoría de accesibilidad WCAG 2.2 AA…

**Tipo:** JSON prompt · **Área:** Web · **Licencia:** CC BY 4.0

Te devuelve un informe de los fallos de accesibilidad de una página, ordenados por impacto, con el arreglo concreto de cada uno.

## Qué es y qué hace

Es un prompt para Claude, Codex, Gemini o una IA local que audita una página según WCAG 2.2 nivel AA. Entran la URL o el HTML, el tipo de página, la tecnología, el público y quién hará los arreglos; sale un informe de fallos en texto alternativo, contraste de texto y de componentes, encabezados, etiquetas de formulario, teclado y foco, con cada incumplimiento ordenado por impacto y su corrección concreta. Es una revisión orientativa y la normativa exige un profesional.

## Cómo usarla

1. Pega la URL o el HTML y el tipo de página
2. Revisa texto, color, formularios y foco
3. Ordena los fallos por impacto
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando quieras saber en qué estado está tu web antes de contratar a nadie, o cuando un cliente o la normativa te pida cumplir accesibilidad.

## Cómo ganar dinero con ella

Evita pagar una auditoría externa para lo básico y te da una lista clara de trabajo, así no pagas horas de desarrollo a ciegas.

- Auditoría de accesibilidad previa a una licitación para webs de empresas.
- Informe de fallos con arreglos listos para programadores de agencias.
- Revisión de accesibilidad de tiendas online antes de la campaña de temporada.

**Precio orientativo:** 150–400 € por informe. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Audita la accesibilidad de una página web según WCAG 2.2 nivel AA y devuelve un informe de errores priorizado con la corrección concreta de cada uno",
  "contexto": {
    "url_o_codigo": "[PEGA AQUÍ LA URL O EL HTML DE LA PÁGINA]",
    "tipo_de_pagina": "[HOME / FICHA DE PRODUCTO / FORMULARIO DE CONTACTO / BLOG]",
    "tecnologia": "[WORDPRESS / SHOPIFY / HTML A MANO / WEBFLOW / OTRA]",
    "publico": "[QUIÉN LA USA: CLIENTES, PERSONAS MAYORES, PERSONAL INTERNO...]",
    "quien_arregla": "[YO SIN SABER PROGRAMAR / MI DESARROLLADOR / UNA AGENCIA]"
  },
  "criterios_que_debes_revisar": [
    "Texto alternativo en imágenes, y las decorativas marcadas como vacías",
    "Contraste de texto (4.5:1 normal, 3:1 grande) y de bordes de campos, iconos y botones (3:1)",
    "Jerarquía de encabezados h1 a h6 sin saltos y con un único h1",
    "Etiqueta visible asociada a cada campo de formulario y errores explicados en texto",
    "Todo operable con teclado, con foco visible y sin trampas de foco",
    "Enlaces con texto que se entiende fuera de contexto, nada de 'clic aquí'",
    "Idioma declarado en la etiqueta html y título de página único y descriptivo",
    "Zoom al 200% sin perder contenido y diseño usable a 320 px de ancho",
    "Vídeos con subtítulos y nada que se reproduzca solo con sonido",
    "Zonas pulsables de al menos 24x24 px y con separación suficiente"
  ],
  "metodo": [
    "Recorre la página de arriba abajo y anota cada problema una sola vez, agrupando las repeticiones",
    "Para cada problema indica el criterio WCAG concreto, con número y nombre",
    "Clasifica el impacto en bloqueante, alto, medio o bajo según a cuánta gente deja fuera",
    "Estima el esfuerzo: 5 minutos, 1 hora o requiere desarrollador",
    "Propón el arreglo con el fragmento de HTML o CSS ya corregido cuando sea posible"
  ],
  "formato_salida": {
    "tipo": "tabla markdown más lista de correcciones",
    "columnas": ["N", "Problema", "Dónde está", "Criterio WCAG", "Impacto", "Esfuerzo", "Cómo se arregla"],
    "extras": ["Resumen inicial de 5 líneas en lenguaje llano", "Los 3 arreglos que más ganan por menos trabajo", "Lo que no se puede verificar sin probar con lector de pantalla real"]
  },
  "restricciones": [
    "No inventes problemas que no se puedan ver en el material aportado",
    "Nada de jerga sin explicar: la primera vez que uses un término, defínelo en media línea",
    "No recomiendes plugins de accesibilidad tipo overlay como solución"
  ],
  "criterios_calidad": [
    "Cada problema tiene ubicación exacta y solución accionable",
    "Ningún
```
