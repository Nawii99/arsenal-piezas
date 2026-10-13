# Registro de Actividades de Tratamiento (art. 30)

**Tipo:** JSON prompt · **Área:** Legal y contratos · **Licencia:** CC BY 4.0

El registro obligatorio del RGPD con cada uso de datos de clientes, bases y plazos. Revisa un abogado.

## Qué es y qué hace

JSON prompt que guía a la IA para elaborar el Registro de Actividades de Tratamiento del art. 30 del RGPD. Entra el contexto de tu empresa, tus actividades con datos y tus herramientas; sale un registro tratamiento por tratamiento. Se usa en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Copia el JSON y rellena los [corchetes]
2. Pégalo en Claude, Codex, Gemini o una IA local
3. Revisa que cada tratamiento refleje lo que haces
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando montas la empresa, cuando un cliente grande te pide papeles de cumplimiento o cuando te das cuenta de que nunca has hecho el registro obligatorio.

## Cómo ganar dinero con ella

Evita la sanción por no tener el registro y te ahorra la factura de que un consultor lo escriba desde cero: tú llegas con el borrador hecho.

- Elaborar el registro RGPD de pymes y autónomos que nunca lo han hecho…
- Paquete de adaptación RGPD inicial para clínicas, tiendas online y asesorías…
- Actualización anual del registro de tratamientos como servicio recurrente…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Elaborar el Registro de Actividades de Tratamiento (RAT) del artículo 30 del RGPD, tratamiento por tratamiento, listo para enseñar en una inspección de la AEPD",
  "contexto": {
    "responsable": "[NOMBRE FISCAL DE TU EMPRESA]",
    "cif_y_direccion": "[CIF Y DIRECCIÓN COMPLETA]",
    "contacto_privacidad": "[EMAIL PARA ASUNTOS DE PRIVACIDAD]",
    "sector": "[SECTOR: p. ej. clínica dental, tienda online, asesoría]",
    "empleados": "[Nº DE EMPLEADOS]"
  },
  "entradas": {
    "actividades": "[LISTA LIBRE DE LO QUE HACES CON DATOS: clientes, empleados, currículums, newsletter, cámaras, proveedores, videollamadas]",
    "herramientas": "[HERRAMIENTAS Y PROVEEDORES: CRM, gestor de email, hosting, gestoría, pasarela de pago]",
    "datos_sensibles": "[¿TRATAS SALUD, DATOS DE MENORES, IDEOLOGÍA O ANTECEDENTES? SÍ/NO Y CUÁLES]"
  },
  "pasos": [
    "Agrupa la operativa en tratamientos reales, no en herramientas: cada tratamiento tiene una finalidad propia",
    "Para cada uno define finalidad, interesados, categorías de datos, base legítima del art. 6 (y art. 9 si hay datos especiales), destinatarios, transferencias fuera de la UE, plazo de conservación y medidas de seguridad",
    "Justifica la base legítima en una frase; si eliges interés legítimo, resume la ponderación",
    "Fija plazos de conservación citando la norma que los impone (fiscal, laboral, contable) o el criterio propio",
    "Marca los tratamientos que podrían necesitar Evaluación de Impacto (art. 35) y los que exigen contrato de encargado (art. 28)"
  ],
  "restricciones": [
    "No inventes datos: lo que falte se escribe como PENDIENTE DE CONFIRMAR indicando qué hay que preguntar",
    "No uses consentimiento como base legítima cuando hay contrato u obligación legal",
    "Lenguaje claro, sin copiar artículos enteros del reglamento"
  ],
  "formato_salida": {
    "estructura": "una ficha por tratamiento y una tabla resumen al final",
    "campos_ficha": ["nombre", "finalidad", "interesados", "categorías de datos", "base legítima", "destinatarios", "transferencias internacionales", "conservación", "medidas de seguridad", "riesgo bajo/medio/alto"],
    "cierre": "lista de tareas pendientes ordenadas por urgencia"
  },
  "criterios_calidad": [
    "Cada tratamiento tiene una finalidad clara y una base legítima defendible",
    "Ningún plazo de conservación dice indefinido",
    "Aparecen todos los proveedores que ven datos personales"
  ],
  "errores_frecuentes": [
    "Confundir herramienta con tratamiento",
    "Olvidar los datos de empleados y de candidatos a un puesto",
```
