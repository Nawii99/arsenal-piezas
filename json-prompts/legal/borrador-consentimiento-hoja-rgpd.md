# Borrador de consentimiento informado y hoja RGPD por tratami…

**Tipo:** JSON prompt · **Área:** Legal y contratos · **Licencia:** CC BY 4.0

Genera el borrador de consentimiento informado y la hoja informativa de protección de datos para un tratamiento concreto, listos para que los revise un abogado.

## Qué es y qué hace

Es un prompt en JSON que genera el borrador de un consentimiento informado y una hoja informativa de protección de datos para un tratamiento concreto, pensado para que un abogado o un delegado de protección de datos lo revise. Entra la consulta y el tratamiento; sale dos documentos separados y marcados como borrador.

## Cómo usarla

1. Rellena consulta, titular y tratamiento
2. Pega el JSON en tu IA
3. Pásalo a un abogado o delegado de protección de datos
4. Que lo revise un profesional

## Cuándo usarla

Una consulta necesita un consentimiento informado y una hoja de protección de datos para un tratamiento concreto, y no los tiene o están desfasados.

## Cómo ganar dinero con ella

Ofrece la redacción de documentación a clínicas de fisioterapia, psicología, dental o estética, y cobra por documento o por pack de tratamientos a [TU PRECIO]. Es salud y es legal: ningún borrador se entrega sin que lo revise un abogado o un delegado de protección de datos.

- Borradores por tratamiento para consultas que empiezan, por tratamiento…
- Paquete de documentos para un centro con varios profesionales, por centro…
- Actualización de borradores tras cambios normativos, por revisión…

**Precio orientativo:** 40–100 € por tratamiento. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "rol": "Redactor de documentación para consultas sanitarias en España. Preparas borradores claros para que un abogado o un delegado de protección de datos los revise. No eres tú quien da validez legal al documento.",
  "tarea": "Redactar dos documentos para el tratamiento indicado: un consentimiento informado y una hoja informativa de protección de datos para el paciente.",
  "consulta": {
    "nombre": "[NOMBRE DE LA CONSULTA]",
    "titular": "[NOMBRE Y APELLIDOS O RAZÓN SOCIAL]",
    "nif": "[NIF]",
    "direccion": "[DIRECCIÓN COMPLETA]",
    "email_contacto_datos": "[EMAIL PARA EJERCER DERECHOS]",
    "numero_registro_centro_sanitario": "[NÚMERO O PENDIENTE]",
    "tipo": "[FISIOTERAPIA / PSICOLOGÍA / DENTAL / ESTÉTICA / OTRA]",
    "tiene_dpo": "[SÍ / NO]",
    "contacto_dpo": "[EMAIL DEL DPO O VACÍO]"
  },
  "tratamiento": {
    "nombre": "[NOMBRE DEL TRATAMIENTO]",
    "en_que_consiste": "[DESCRIPCIÓN EN 3 O 4 FRASES, CON PALABRAS DE PACIENTE]",
    "duracion_sesion": "[MINUTOS]",
    "numero_sesiones_habitual": "[NÚMERO O RANGO]",
    "riesgos_frecuentes": ["[RIESGO 1]", "[RIESGO 2]"],
    "riesgos_graves_poco_frecuentes": ["[RIESGO 1]"],
    "contraindicaciones": ["[CONTRAINDICACIÓN 1]"],
    "alternativas": ["[ALTERNATIVA 1]", "[NO HACER NADA Y QUÉ SUPONE]"],
    "requiere_consentimiento_escrito": "[SÍ / NO / NO SÉ]",
    "precio_por_sesion_euros": "[PRECIO O VACÍO]",
    "aplica_iva": "[SÍ / NO / NO SÉ]"
  },
  "paciente": {
    "puede_ser_menor": "[SÍ / NO]",
    "puede_tener_tutor_legal": "[SÍ / NO]"
  },
  "datos": {
    "que_se_recogen": ["identificación", "contacto", "historia clínica", "[OTROS: FOTOS, VÍDEOS, ETC.]"],
    "finalidades": ["prestar la asistencia", "gestionar citas y recordatorios", "facturar", "[OTRA FINALIDAD O VACÍO]"],
    "canal_recordatorios": "[SMS / EMAIL / WHATSAPP / LLAMADA]",
    "proveedores_que_ven_datos": ["[SOFTWARE DE CITAS]", "[GESTORÍA]", "[NUBE]"],
    "plazo_conservacion_historia": "[5 AÑOS DESDE EL ALTA DE CADA PROCESO, O EL PLAZO AUTONÓMICO SI ES MAYOR]",
    "se_comparte_con_aseguradoras": "[SÍ / NO]"
  },
  "formato_salida": {
    "documento_1": {
      "titulo": "Consentimiento informado: [NOMBRE DEL TRATAMIENTO]",
      "secciones": [
        "Datos de la consulta y del profesional",
        "Datos del paciente y, si aplica, de quien firma en su nombre",
        "En qué consiste el tratamiento",
        "Beneficios esperados",
        "Riesgos frecuentes",
        "Riesgos graves poco frecuentes",
        "Contraindicaciones",
        "Alternativas",
        "Derecho a revocar el consentimiento en cualquier momento",
        "Declaración del paciente: he leído, he podido preguntar, entiendo",
        "Fecha, firma del paciente, firma del profesional"
      ],
      "reglas": [
        "Frases cortas. Nada de latinismos ni jerga clínica sin explicar.",
        "Los riesgos van en lista, no en párrafo.",
        "Si requiere_consentimiento_escrito es NO SÉ, añade al principio una nota en cursiva: [CONFIRMAR CON EL COLEGIO PROFESIONAL O ABOGADO SI ESTE TRATAMIENTO EXIGE CONSENTIMIENTO ESCRITO SEGÚN LA LEY 41/2002].",
        "Si puede_ser_menor es SÍ, incluye bloque de firma para el representante legal y una línea sobre la opinión del menor maduro."
      ]
    },
    "documento_2": {
      "titulo": "Información sobre el tratamiento de sus datos",
      "secciones": [
        "Quién trata sus datos (responsable) y cómo contactar",
        "Delegado de protección de datos, si lo hay",
        "Qué datos se recogen",
        "Para qué se usan",
        "Base legal: asistencia sanitaria y obligación legal para la historia clínica; consentimiento para lo que no sea imprescindible, como fotos o recordatorios por mensajería",
        "A quién se comunican los datos",
        "Cuánto tiempo se conservan",
        "Derechos: acceso, rectificación, supresión, limitación, oposición, portabilidad, y cómo ejercerlos",
        "Derecho a reclamar ante la Agencia Española de Protección de Datos",
        "Casillas de consentimiento separadas para lo que sea opcional"
      ],
      "reglas": [
        "Una casilla por finalidad opcional. Nunca una sola casilla para todo.",
```
