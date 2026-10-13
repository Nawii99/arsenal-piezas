# Registro de tratamientos y checklist RGPD…

**Tipo:** JSON prompt · **Área:** Legal y contratos · **Licencia:** CC BY 4.0

Registro de datos + checklist básico RGPD en lenguaje sin abogado. Revisa legal.

## Qué es y qué hace

JSON prompt que elabora el registro de actividades de tratamiento y un checklist de cumplimiento básico de protección de datos de una pyme española, en lenguaje sin jerga jurídica. Entran actividad, plantilla y si hay delegado. Se usa en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Copia el JSON y rellena los [corchetes]
2. Pégalo en Claude, Codex, Gemini o una IA local
3. Completa el checklist con lo que falte
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando guardas datos de clientes o empleados y no tienes papeles de protección de datos, o los tienes de hace años sin tocar.

## Cómo ganar dinero con ella

Te pone al día con lo mínimo exigible y te evita sustos con la inspección o con una reclamación de un cliente.

- Registro de tratamientos y checklist RGPD para pymes…
- Paquete de cumplimiento básico para autónomos…
- Revisión anual de documentación de protección de datos…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Elaborar el registro de actividades de tratamiento y el checklist de cumplimiento básico de protección de datos de una pyme española",
  "contexto": {
    "empresa": "[NOMBRE, CIF Y DIRECCIÓN]",
    "actividad": "[A QUÉ SE DEDICA]",
    "plantilla": "[NÚMERO DE EMPLEADOS]",
    "tiene_dpd": "[SÍ / NO / NO SÉ]",
    "trata_datos_especiales": "[SALUD, MENORES, ANTECEDENTES, BIOMETRÍA: SÍ O NO]"
  },
  "entradas": {
    "tratamientos": "[CLIENTES, PROVEEDORES, NÓMINAS, CANDIDATOS, NEWSLETTER, VIDEOVIGILANCIA, LISTA DE ESPERA]",
    "donde_se_guardan": "[PROGRAMA DE GESTIÓN, NUBE, EXCEL, PAPEL, CORREO]",
    "proveedores_que_acceden": "[GESTORÍA, AGENCIA DE MARKETING, HOSTING, PLATAFORMA DE CITAS]",
    "web_y_formularios": "[FORMULARIOS, COOKIES, CHAT, TIENDA]"
  },
  "metodo": [
    "Listar un tratamiento por cada finalidad distinta, no por cada fichero",
    "Para cada uno indicar finalidad, categorías de personas y de datos, base legal, plazo de conservación, destinatarios y medidas de seguridad aplicadas",
    "Marcar los tratamientos que necesitan consentimiento expreso y separarlos de los que van por contrato u obligación legal",
    "Revisar los deberes básicos: cláusulas informativas, contratos de encargado con los proveedores, atención a los derechos de acceso y borrado, aviso de brechas en 72 horas y formación del personal",
    "Señalar los puntos donde hace falta un abogado o asesor especializado, sin fingir que el documento sustituye su revisión",
    "Proponer un plan de subsanación de lo que falte, ordenado por riesgo"
  ],
  "restricciones": [
    "Explicar cada concepto legal con una frase en lenguaje llano justo después del término",
    "No afirmar que la empresa cumple: el resultado es un borrador de trabajo que debe validar un profesional",
    "No inventar bases legales: si hay duda, ofrecer las dos opciones y explicar cuándo aplica cada una",
    "Ceñirse al marco español y europeo vigente y avisar si algo debe verificarse por posibles cambios"
  ],
  "formato_salida": {
    "tipo": "tabla de registro más checklist y plan",
    "columnas_registro": ["Tratamiento", "Finalidad", "Personas afectadas", "Datos tratados", "Base legal", "Conservación", "Quién más lo ve", "Medidas de seguridad"],
    "anexos": ["Checklist de deberes con estado cumplido, a medias o pendiente", "Plan de subsanación por orden de riesgo", "Preguntas para llevar al asesor"]
  },
  "criterios_calidad": [
    "El registro se entiende sin ser jurista y sirve para enseñarlo tal cual",
    "Cada pendiente tiene acción, responsable y plazo",
    "Se distin
```
