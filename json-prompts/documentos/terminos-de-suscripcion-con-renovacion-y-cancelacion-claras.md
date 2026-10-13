# Términos de suscripción con renovación y cancelación claras…

**Tipo:** JSON prompt · **Área:** Documentos · **Licencia:** CC BY 4.0

Redacta los términos de tu servicio por suscripción o membresía: planes, cobros, renovación automática, bajas y reembolsos.

## Qué es y qué hace

Plantilla JSON que redacta los términos y condiciones de un servicio por suscripción o membresía dirigido a consumidores en España. Recibe el proveedor, qué incluye, planes y precios, periodo y día de cobro, prueba gratuita, permanencia, política de baja y reembolsos, y devuelve las cláusulas de alta, renovación automática, subidas de precio con preaviso y cancelación. Funciona con Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Define planes, precios y periodo de cobro
2. Indica la forma de baja y el preaviso
3. Revisa renovación y reembolsos en el texto
4. Que lo revise un profesional.

## Cuándo usarla

Úsalo cuando vendas una cuota mensual, una membresía, una app o un servicio recurrente y necesites reglas claras de cobro y baja.

## Cómo ganar dinero con ella

Reduce impagos, devoluciones de cargos y discusiones por renovaciones, porque el cliente acepta condiciones que puede entender.

- Términos de membresía para academias, comunidades o apps de pago mensual con reglas de baja claras.
- Revisión de condiciones de suscripción para evitar cobros que el cliente no reconoce.
- Actualización de términos cuando se suben precios o se cambia la prueba gratuita.

**Precio orientativo:** 60–150 € por servicio. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Redactar los términos y condiciones de un servicio por suscripción o membresía dirigido a consumidores en España",
  "proveedor": {
    "razon_social": "[NOMBRE O RAZÓN SOCIAL]",
    "nif": "[NIF O CIF]",
    "email_soporte": "[EMAIL DE SOPORTE]"
  },
  "entradas": {
    "que_incluye": "[DESCRIPCIÓN DEL SERVICIO Y QUÉ NO INCLUYE]",
    "planes_y_precios": "[PLANES, PRECIOS E IVA]",
    "periodo_de_cobro": "[MENSUAL / ANUAL] Y [DÍA DE COBRO]",
    "prueba_gratuita": "[SÍ / NO Y DURACIÓN]",
    "permanencia": "[SÍ / NO Y DURACIÓN]",
    "politica_de_baja": "[CÓMO SE DA DE BAJA Y CON CUÁNTA ANTELACIÓN]",
    "reembolsos": "[POLÍTICA DE DEVOLUCIONES]",
    "soporte": "[HORARIO Y TIEMPO DE RESPUESTA COMPROMETIDO]"
  },
  "instrucciones": [
    "Estructura en cláusulas: objeto, alta y cuenta, planes y precios, facturación y renovación automática, subidas de precio con preaviso, prueba gratuita y su conversión, cancelación, reembolsos, uso aceptable, disponibilidad y soporte, propiedad intelectual, datos personales, responsabilidad y ley aplicable",
    "Explica el desistimiento de 14 días para servicios digitales y cuándo se pierde por haber empezado a usar el servicio con consentimiento expreso",
    "Deja claro qué pasa con los datos y contenidos del cliente al cancelar: plazo de exportación y borrado",
    "Regula el impago: reintentos de cobro, suspensión y baja, sin penalizaciones desproporcionadas",
    "Exige recordatorio previo antes de cada renovación anual y una vía de baja tan fácil como el alta",
    "Añade al final un resumen en tabla de lo que más pregunta el cliente: precio, cuándo se cobra, cómo se cancela y qué se devuelve"
  ],
  "restricciones": [
    "Prohibido dificultar la baja o exigir llamada telefónica como único medio",
    "Nada de renovaciones sin aviso ni subidas de precio sin preaviso razonable",
    "No prometer disponibilidad ni tiempos de respuesta que no se hayan declarado",
    "Lenguaje claro: cláusulas de menos de cinco líneas"
  ],
  "formato_salida": {
    "bloque_1": "términos completos con cláusulas numeradas",
    "bloque_2": "tabla resumen en lenguaje claro para mostrar antes de contratar",
    "bloque_3": "texto de la pantalla de contratación con el aviso de renovación automática",
    "bloque_4": "lista de puntos que conviene revisar con un abogado"
  },
  "criterios_calidad": [
    "Renovación, precio y cancelación se entienden sin releer",
    "Ninguna cláusula impide ejercer derechos del consumidor",
    "El resumen coincide exactamente con el articulado",
    "Todos los datos no facilitados quedan
```
