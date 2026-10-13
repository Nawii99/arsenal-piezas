# Diagnóstico del LCP: por qué tarda en verse…

**Tipo:** JSON prompt · **Área:** Web · **Licencia:** CC BY 4.0

Te dice en qué fase se pierde el tiempo hasta que se ve lo importante de tu página y qué tocar exactamente para arreglarlo.

## Qué es y qué hace

Es un prompt para Claude, Codex, Gemini o una IA local que diagnostica por qué tarda en verse el elemento más grande de una página (LCP). Entran la URL, el tipo de página, la plataforma, el hosting, el tiempo de LCP en móvil, el elemento que señala PageSpeed y el desglose (TTFB, espera, descarga y pintado) con el HTML de la cabecera; sale la fase donde se pierde el tiempo, las causas frecuentes y un plan de arreglo ordenado por impacto para hosting, imagen o diseño.

## Cómo usarla

1. Indica URL, plataforma y el elemento LCP
2. Pega el desglose de tiempos
3. Revisa las causas más frecuentes
4. Aplica el arreglo de mayor impacto

## Cuándo usarla

Úsalo cuando PageSpeed te marca el LCP en rojo o naranja y quieres saber si el culpable es el hosting, la imagen de cabecera o el diseño.

## Cómo ganar dinero con ella

Menos abandono en móvil por páginas que tardan en aparecer y menos horas perdidas probando arreglos a ciegas.

- Diagnóstico de velocidad para la página principal de tiendas online.
- Asesoría de rendimiento para campañas de anuncios con landings lentas.
- Plantilla de diagnóstico de LCP para agencias que entregan webs.

**Precio orientativo:** 80–250 € por diagnóstico. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Diagnosticar por qué el LCP es lento en una página concreta y devolver un plan de arreglo ordenado",
  "contexto": {
    "url": "[URL DE LA PÁGINA MÁS IMPORTANTE]",
    "tipo_pagina": "[HOME / FICHA DE PRODUCTO / LANDING DE CAMPAÑA]",
    "plataforma": "[WORDPRESS / SHOPIFY / WEBFLOW / A MEDIDA]",
    "hosting": "[NOMBRE DEL HOSTING Y PLAN CONTRATADO]"
  },
  "entradas": {
    "lcp_movil": "[X segundos]",
    "elemento_lcp": "[QUÉ ELEMENTO SEÑALA PAGESPEED: IMAGEN DE CABECERA, TITULAR, VÍDEO O BANNER]",
    "desglose": "TTFB [X ms], espera hasta pedir el recurso [X ms], descarga del recurso [X ms], retardo de pintado [X ms]",
    "detalle_tecnico": "[PEGA EL HTML DE LA CABECERA O LA LISTA DE RECURSOS QUE BLOQUEAN EL PINTADO]"
  },
  "causas_frecuentes": [
    "La imagen principal lleva carga diferida y por eso el navegador la pide tarde",
    "La imagen pesa de más, no está en WebP o AVIF y no tiene tamaños adaptados a móvil",
    "Un carrusel o un banner decide con JavaScript qué imagen mostrar después de cargar la página",
    "Fuentes o CSS que bloquean el pintado y retrasan la aparición del titular",
    "TTFB alto por hosting lento, falta de caché de página o demasiadas consultas a la base de datos"
  ],
  "proceso": [
    "Di en qué fase se pierde más tiempo según el desglose y ataca solo esa fase primero",
    "Confirma si el elemento LCP es imagen o texto, porque el arreglo cambia por completo",
    "Propón arreglos con el atributo o la línea exacta a tocar, por ejemplo quitar la carga diferida, marcar prioridad alta o precargar la imagen",
    "Indica por arreglo el ahorro estimado en milisegundos y de dónde sale esa estimación",
    "Cierra con la comprobación: qué medir, con qué herramienta y en cuántos días se refleja en datos de usuarios reales"
  ],
  "restricciones": [
    "No propongas cambiar de plataforma ni rehacer la web salvo que el problema sea el TTFB y no tenga arreglo en el plan actual",
    "Marca qué se toca desde el panel de la plataforma y qué necesita tocar código",
    "Si falta el desglose por fases, dilo y explica cómo obtenerlo antes de continuar"
  ],
  "formato_salida": {
    "tipo": "diagnóstico en markdown",
    "secciones": [
      "Veredicto en una frase sobre dónde se va el tiempo",
      "Tabla con columnas: arreglo, fase que mejora, ahorro estimado, dificultad y quién lo hace",
      "Instrucciones paso a paso del primer arreglo",
      "Cómo comprobar que ha funcionado"
    ]
  },
  "criterios_calidad": [
    "Ninguna recomendación que no afecte al LCP de esta página concreta",
    "Cada arreglo i
```
