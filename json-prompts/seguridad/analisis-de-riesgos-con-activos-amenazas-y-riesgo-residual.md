# Análisis de riesgos con activos, amenazas y riesgo residual…

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Genera el análisis de riesgos completo: inventario de activos, amenazas, probabilidad, impacto, riesgo residual y tratamiento aprobado.

## Qué es y qué hace

JSON prompt que elabora el análisis y tratamiento de riesgos de un SGSI ISO 27001 o un sistema ENS: inventario de activos, amenazas, probabilidad, impacto, riesgo residual y tratamiento. Entran organización, alcance y activos. Se usa en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Copia el JSON y rellena los [corchetes]
2. Pégalo en Claude, Codex, Gemini o una IA local
3. Valida probabilidades e impactos con tu equipo
4. Que lo revise un profesional

## Cuándo usarla

Úsalo al montar el SGSI o cuando toca la revisión anual del análisis de riesgos, que el auditor pide siempre actualizado.

## Cómo ganar dinero con ella

Te evita contratar el análisis de riesgos fuera y enfoca el gasto en seguridad donde hay riesgo de verdad.

- Análisis de riesgos ISO 27001 para pymes…
- Plan de tratamiento de riesgos para auditorías…
- Borrador de metodología de riesgos para consultoras…

**Precio orientativo:** 400–1200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Elaborar el análisis y tratamiento de riesgos de seguridad de la información para un SGSI ISO 27001 o un sistema ENS",
  "contexto": {
    "organizacion": "[NOMBRE DE TU EMPRESA]",
    "alcance": "[PROCESOS Y SISTEMAS INCLUIDOS]",
    "activos": "[LISTA DE ACTIVOS: APLICACIONES, SERVIDORES, PORTÁTILES, MÓVILES, BASES DE DATOS, WEB, CORREO, DOCUMENTACIÓN EN PAPEL, PERSONAS CLAVE]",
    "proveedores": "[PROVEEDORES CRÍTICOS Y QUÉ TOCAN]",
    "incidentes_pasados": "[QUÉ OS HA PASADO YA: PHISHING, CAÍDAS, PÉRDIDA DE PORTÁTIL, RANSOMWARE...]",
    "criterio_aceptacion": "[A PARTIR DE QUÉ NIVEL DE RIESGO HAY QUE ACTUAR]",
    "presupuesto": "[PRESUPUESTO ANUAL DISPONIBLE PARA SEGURIDAD]"
  },
  "instrucciones": [
    "Agrupa los activos por tipo siguiendo un enfoque tipo MAGERIT: información, servicios, aplicaciones, equipos, redes, soportes, instalaciones y personas",
    "Asigna a cada activo un propietario y valóralo en confidencialidad, integridad, disponibilidad, autenticidad y trazabilidad de 1 a 5",
    "Asocia a cada activo sus amenazas realistas (errores, fallos técnicos, ataques deliberados, desastres) y descarta las que no apliquen explicando por qué",
    "Calcula riesgo inherente = probabilidad x impacto en escala 1-5, aplica los controles ya existentes y calcula el riesgo residual",
    "Para cada riesgo por encima del criterio de aceptación, propón tratamiento: mitigar, transferir, evitar o aceptar, con el control del Anexo A o la medida ENS que lo cubre",
    "Prioriza acciones por reducción de riesgo conseguida frente a coste estimado, y respeta el presupuesto indicado"
  ],
  "restricciones": [
    "No listes más de 30 riesgos: agrupa los que comparten causa",
    "Nada de riesgos genéricos de manual: cada uno debe reconocerse en el negocio descrito",
    "Toda aceptación de riesgo debe indicar quién la aprueba"
  ],
  "formato_salida": {
    "1_inventario": "Tabla: Activo | Tipo | Propietario | Valoración CIDAT",
    "2_riesgos": "Tabla: ID | Activo | Amenaza | Vulnerabilidad | Probabilidad | Impacto | Riesgo inherente | Controles actuales | Riesgo residual | Tratamiento",
    "3_plan_tratamiento": "Acción | Control ISO o medida ENS | Responsable | Fecha | Coste estimado | Riesgo residual esperado",
    "4_mapa": "Descripción del mapa de calor por zonas: crítico, alto, medio y bajo"
  },
  "criterios_calidad": [
    "Todo riesgo por encima del umbral tiene tratamiento y responsable",
    "El sumatorio de costes no supera el presupuesto indicado",
    "La metodología queda explicada en un párrafo, para poder defenderla ante el
```
