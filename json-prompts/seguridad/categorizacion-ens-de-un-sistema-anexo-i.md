# Categorización ENS de un sistema (Anexo I)

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Valora las cinco dimensiones de seguridad de tu sistema y te dice si el nivel ENS es BÁSICO, MEDIO o ALTO, con la justificación por escrito.

## Qué es y qué hace

JSON prompt que categoriza un sistema según el Esquema Nacional de Seguridad (RD 311/2022, Anexo I): valora las cinco dimensiones y justifica por escrito si el nivel es BÁSICO, MEDIO o ALTO. Entran organización y servicio. Se usa en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Copia el JSON y rellena los [corchetes]
2. Pégalo en Claude, Codex, Gemini o una IA local
3. Contrasta la categoría con tu responsable
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando vas a trabajar con administración pública y te piden certificación o declaración de conformidad con el ENS.

## Cómo ganar dinero con ella

Evita categorizar de más y cargarte con controles caros que no necesitas, o de menos y perder el contrato público.


**Precio orientativo:** 300–700 € por sistema. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Categorizar un sistema de información según el Esquema Nacional de Seguridad (Real Decreto 311/2022, Anexo I) y justificar el nivel resultante",
  "contexto": {
    "organizacion": "[NOMBRE DE TU EMPRESA]",
    "sistema": "[NOMBRE DEL SISTEMA O SERVICIO A CATEGORIZAR]",
    "que_hace": "[QUÉ SERVICIO PRESTA Y A QUIÉN]",
    "informacion_tratada": "[TIPOS DE INFORMACIÓN: DATOS PERSONALES, DATOS ESPECIALMENTE PROTEGIDOS, DATOS DE ADMINISTRACIÓN, ETC.]",
    "usuarios": "[NÚMERO Y TIPO DE USUARIOS]",
    "impacto_caida": "[QUÉ PASA SI EL SISTEMA ESTÁ CAÍDO 1 HORA, 1 DÍA Y 1 SEMANA]",
    "impacto_fuga": "[QUÉ PASA SI LA INFORMACIÓN SE FILTRA O SE ALTERA]",
    "relacion_administracion": "[QUÉ ORGANISMO PÚBLICO ES CLIENTE Y QUÉ EXIGE EN EL PLIEGO]"
  },
  "instrucciones": [
    "Valora por separado las cinco dimensiones: Confidencialidad, Integridad, Trazabilidad, Autenticidad y Disponibilidad",
    "Asigna a cada dimensión nivel BAJO, MEDIO o ALTO o la marca de no aplicable, siguiendo los criterios de perjuicio del Anexo I: sobre las funciones del organismo, sobre los activos, sobre terceros y sobre el cumplimiento legal",
    "Justifica cada nivel con un escenario concreto de daño, no con una frase teórica",
    "La categoría del sistema es la del nivel más alto entre las cinco dimensiones: explícalo para que se entienda",
    "Advierte de qué implica esa categoría en número aproximado de medidas del Anexo II y en tipo de auditoría (autoevaluación en BÁSICA, auditoría formal bienal en MEDIA y ALTA)",
    "Señala si el pliego del cliente público exige un nivel superior al que sale del análisis"
  ],
  "restricciones": [
    "No infles los niveles por prudencia: cada subida debe tener justificación de daño real",
    "No confundas el ENS con el RGPD, aunque los datos personales influyan en la valoración",
    "Si falta información para valorar una dimensión, dilo y pide el dato exacto"
  ],
  "formato_salida": {
    "1_ficha_sistema": "Nombre, responsable de la información, responsable del servicio, responsable de seguridad y alcance",
    "2_tabla_dimensiones": "Dimensión | Nivel | Escenario de daño | Criterio del Anexo I aplicado",
    "3_categoria": "Categoría final del sistema y frase de justificación para el acta",
    "4_consecuencias": "Qué obligaciones y tipo de auditoría trae ese nivel y qué preparar en los próximos 3 meses"
  },
  "criterios_calidad": [
    "Las cinco dimensiones están valoradas y justificadas por separado",
    "La categoría final se deduce correctamente del nivel más alto",
    "El texto sirve tal cual para el acta
```
