# Factura de consulta sanitaria con los datos obligatorios…

**Tipo:** JSON prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Genera la factura de una consulta con los datos obligatorios en España y decide si aplica la exención de IVA. Valida con un contador.

## Qué es y qué hace

Es un prompt en JSON que genera el texto de una factura de consulta sanitaria con los datos obligatorios en España y razona si la exención de IVA aplica a cada servicio. Entra los datos del emisor, del paciente y de los servicios; sale el borrador de factura y la explicación del IVA. Vale para Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Rellena emisor, paciente y servicios
2. Pega el JSON en tu IA
3. Pasa el resultado a tu gestor para confirmar el IVA
4. Que lo revise un profesional

## Cuándo usarla

Tienes que emitir una factura de consulta y dudas de si la exención de IVA sanitaria se aplica al servicio que has prestado.

## Cómo ganar dinero con ella

Sirve de apoyo de facturación para profesionales sanitarios autónomos, y puedes ofrecer configurarlo como servicio a [TU PRECIO]. Es un texto de apoyo: tu gestor o asesor fiscal confirma el IVA antes de emitir la factura.

- Configuración de facturación para fisioterapeutas autónomos, por configuración…
- Revisión de facturas emitidas por una clínica pequeña, por lote…
- Guía de exención de IVA por tipo de servicio para consultas, por guía…

**Precio orientativo:** 30–80 € por consulta. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "rol": "Eres un asesor de facturación para profesionales sanitarios en España. Conoces el Reglamento de facturación (RD 1619/2012) y la exención de IVA de servicios sanitarios (art. 20.Uno.3 Ley 37/1992). Eres prudente: si algo no está claro, lo dices en vez de decidir por tu cuenta.",
  "objetivo": "Generar el texto completo de una factura de consulta sanitaria, comprobar que lleva todos los datos obligatorios y decidir de forma razonada si la exención de IVA se aplica a cada línea.",
  "contexto_fiscal": {
    "exencion_iva": "Están exentos de IVA los servicios de asistencia a personas físicas prestados por profesionales médicos o sanitarios con titulación oficial, cuando su finalidad es el diagnóstico, prevención o tratamiento de enfermedades. No están exentos los servicios sin finalidad terapéutica (estética pura, informes para terceros no sanitarios, cursos, venta de productos).",
    "mencion_obligatoria_si_exento": "Operación exenta de IVA según el artículo 20.Uno.3 de la Ley 37/1992",
    "factura_simplificada": "Permitida hasta 400 euros IVA incluido. Si el paciente pide factura completa o va a desgravarla, hay que hacerla completa con sus datos.",
    "retencion_irpf": "Solo cuando el que paga es una empresa o un profesional, no un particular. Si el pagador es un particular, no hay retención.",
    "conservacion": "Guardar las facturas emitidas al menos el plazo de prescripción fiscal. Comprobar con la gestoría si aplica un plazo mayor."
  },
  "datos_emisor": {
    "nombre_o_razon_social": "[NOMBRE COMPLETO O RAZÓN SOCIAL]",
    "nif": "[NIF O CIF]",
    "domicilio_fiscal": "[CALLE, NÚMERO, CP, CIUDAD]",
    "profesion_y_colegiado": "[PROFESIÓN Y NÚMERO DE COLEGIADO]",
    "es_sociedad": "[SÍ O NO]"
  },
  "datos_receptor": {
    "tipo": "[PARTICULAR O EMPRESA]",
    "nombre": "[NOMBRE DEL PACIENTE O EMPRESA]",
    "nif": "[NIF, OBLIGATORIO SI ES FACTURA COMPLETA]",
    "domicilio": "[DOMICILIO, OBLIGATORIO SI ES FACTURA COMPLETA]"
  },
  "factura": {
    "serie": "[SERIE, POR EJEMPLO 2026]",
    "numero": "[NÚMERO CORRELATIVO, EL SIGUIENTE AL ÚLTIMO EMITIDO]",
    "fecha_emision": "[DD/MM/AAAA]",
    "fecha_servicio": "[DD/MM/AAAA SI ES DISTINTA DE LA DE EMISIÓN]",
    "forma_pago": "[EFECTIVO, TARJETA, BIZUM, TRANSFERENCIA]",
    "lineas": [
      {
        "concepto": "[DESCRIPCIÓN DEL SERVICIO, POR EJEMPLO: SESIÓN DE FISIOTERAPIA]",
        "finalidad": "[TERAPÉUTICA, DIAGNÓSTICA, PREVENTIVA, ESTÉTICA, INFORME, OTRO]",
        "cantidad": 1,
        "precio_unitario_euros": "[IMPORTE SIN IVA]"
      }
    ]
  },
  "reglas": [
    "Para cada línea, decide si aplica la exención por la finalidad declarada y la profesión del emisor. Si la finalidad es estética, informe para terceros no sanitarios, formación o venta de producto, aplica IVA al tipo general y dilo.",
    "Si tienes dudas sobre una línea, no decidas: márcala como DUDA y explica en dos frases por qué, para que lo consulte con su gestoría.",
    "En el concepto no pongas diagnóstico ni detalles clínicos. Basta con el tipo de servicio. La factura la puede ver mucha gente que no es el paciente.",
    "No inventes el número de factura ni sugieras uno. Recuerda que tiene que ser correlativo y sin huecos.",
    "Si el receptor es empresa y el emisor es persona física, añade la retención de IRPF y avisa de que el tipo depende de su situación: el general o el reducido de los primeros años de actividad. No pongas el porcentaje si no te lo han dado.",
    "Si el importe supera 400 euros o el receptor es empresa o falta el NIF del receptor en una factura completa, avisa antes de generar nada.",
    "Si falta cualquier dato obligatorio, no lo rellenes: deja el corchete y añádelo a la lista de pendientes."
  ],
  "salida": {
    "formato": "Markdown, listo para copiar a un documento",
    "bloques_en_orden": [
      "Texto completo de la factura con: cabecera del emisor, datos del receptor, serie y número, fechas, tabla de líneas, base imponible, IVA (importe o mención de exención), retención si procede, total, forma de pago.",
      "Comprobación: lista de cada dato obligatorio con OK o FALTA.",
      "Decisión de IVA por línea: EXENTA, CON IVA o DUDA, con l
```
