# ADR nuevo en formato MADR…

**Tipo:** JSON prompt · **Área:** Backend · **Licencia:** CC BY 4.0

Convierte una decisión técnica pendiente en un documento ADR completo, con contexto, opciones, decisión, consecuencias y plan de vuelta atrás.

## Qué es y qué hace

JSON prompt que convierte una decisión técnica pendiente en un ADR completo en formato MADR: contexto, opciones, decisión, consecuencias y plan de vuelta atrás. Entra el producto, el equipo y el stack; sale el documento listo para revisar. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el JSON
2. Describe producto, equipo, stack y decisión en los [corchetes]
3. Pégalo en la IA
4. Revisa el borrador con el equipo

## Cuándo usarla

Úsalo cuando tu equipo va a elegir una tecnología, un patrón o un proveedor y quieres dejar por escrito por qué, antes de empezar a programar.

## Cómo ganar dinero con ella

Evita rehacer trabajo por decisiones que nadie recuerda ni justificó, y acorta las discusiones repetidas en cada reunión.

- Redacción de documentos de decisión técnica para equipos…
- Servicio de documentación de arquitectura para startups…
- Plantillas ADR como entregable de proyectos de desarrollo…

**Precio orientativo:** 60–220 € por pieza. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Redactar un ADR (Architecture Decision Record) completo y listo para revisar, en formato MADR, a partir de una decisión técnica todavía sin tomar",
  "contexto": {
    "producto": "[QUÉ HACE TU PRODUCTO EN UNA FRASE]",
    "tamano_equipo": "[NÚMERO DE PERSONAS QUE TOCAN EL CÓDIGO]",
    "stack_actual": "[LENGUAJES, FRAMEWORKS Y BASE DE DATOS QUE YA USÁIS]",
    "decision_pendiente": "[QUÉ HAY QUE DECIDIR, EN UNA FRASE]",
    "por_que_ahora": "[QUÉ OBLIGA A DECIDIRLO ESTE MES]",
    "restricciones_reales": "[PRESUPUESTO, PLAZO, PERSONAS, NORMATIVA]",
    "quien_decide": "[NOMBRE O ROL DE QUIEN FIRMA]"
  },
  "entradas": {
    "opciones_consideradas": ["[OPCIÓN A]", "[OPCIÓN B]", "[OPCIÓN C O 'NO HACER NADA']"],
    "requisitos_no_funcionales": "[USUARIOS ESPERADOS, LATENCIA ACEPTABLE, DISPONIBILIDAD, DATOS SENSIBLES]",
    "experiencia_del_equipo": "[QUÉ DOMINA YA EL EQUIPO Y QUÉ NO]"
  },
  "pasos": [
    "1. Reformula la decisión como una pregunta cerrada y comprueba que es una sola decisión, no varias mezcladas",
    "2. Escribe el contexto con hechos y números, sin adjetivos ni opiniones",
    "3. Describe cada opción en 3-5 líneas: cómo funciona, qué cuesta operarla y qué exige saber al equipo",
    "4. Incluye siempre la opción de no cambiar nada como comparación honesta",
    "5. Elige una opción y justifícala enlazando cada motivo a una restricción del contexto",
    "6. Enumera consecuencias positivas y negativas, incluida la deuda técnica que asumes a sabiendas",
    "7. Define cómo se revierte la decisión y cuánto costaría revertirla",
    "8. Fija una fecha de revisión y la señal concreta que obligaría a reabrir el ADR"
  ],
  "restricciones": [
    "Máximo 2 páginas; si no cabe, es que hay más de una decisión dentro",
    "Nada de marketing de proveedores: solo lo que afecta a este equipo y este producto",
    "Si falta un dato clave para decidir, márcalo como PENDIENTE y di cómo obtenerlo en menos de una semana",
    "No inventes cifras de rendimiento ni precios: pide el dato o déjalo como supuesto explícito"
  ],
  "formato_salida": {
    "tipo": "markdown en un único bloque, listo para guardar como docs/adr/NNNN-titulo-en-minusculas.md",
    "secciones": ["Número y título", "Estado", "Fecha", "Contexto", "Opciones consideradas", "Decisión", "Justificación", "Consecuencias positivas", "Consecuencias negativas y riesgos", "Cómo revertir", "Fecha de revisión", "Supuestos y pendientes"],
    "extra": "Añade al final 3 preguntas que deberías hacer al equipo antes de aprobarlo"
  },
  "criterios_calidad": [
    "Alguien que entre a
```
