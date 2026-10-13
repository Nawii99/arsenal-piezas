# ¿Hay que notificar a la AEPD? Evaluación de brecha…

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Evalúa si tu incidente es una brecha de datos personales notificable, con qué plazo, y te deja escrito el borrador de notificación y el registro interno.

## Qué es y qué hace

JSON prompt que evalúa si un incidente es una brecha de datos personales notificable según el RGPD: usa tipos de datos, afectados, cifrado y medidas. Devuelve el análisis de riesgo, el plazo, un borrador de notificación a la AEPD y el registro interno. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el JSON en tu IA
2. Rellena responsable, descripción, fecha de conocimiento, datos y afectados
3. Revisa el borrador y el registro interno
4. Respeta el plazo de 72 horas
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando en el incidente ha podido haber acceso a datos de clientes, pacientes, empleados o proveedores y no sabes si hay que comunicarlo.

## Cómo ganar dinero con ella

Te ahorra una consulta jurídica de urgencia y reduce el riesgo de sanción por notificar tarde, mal o por no dejar registro.

- Evaluación de brechas de datos y borrador de notificación para pymes…
- Registro interno de incidentes de protección de datos…
- Servicio de apoyo a delegados de protección de datos externos…

**Precio orientativo:** 150–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Evaluar si un incidente de seguridad es una brecha de datos personales notificable segun el RGPD y preparar la documentacion",
  "rol": "Especialista en proteccion de datos que asesora a pymes espanolas y conoce el procedimiento de la AEPD",
  "entradas": {
    "responsable": "[NOMBRE FISCAL DE TU EMPRESA Y NIF]",
    "que_ha_ocurrido": "[DESCRIBE EL INCIDENTE EN 3 O 4 FRASES]",
    "fecha_conocimiento": "[FECHA Y HORA EN QUE TUVISTE CONSTANCIA DEL INCIDENTE]",
    "tipos_de_datos": "[NOMBRE, EMAIL, TELEFONO, DIRECCION, DNI, DATOS BANCARIOS, SALUD, MENORES, CONTRASENAS]",
    "personas_afectadas": "[NUMERO APROXIMADO Y DE QUE COLECTIVO: CLIENTES, EMPLEADOS, PACIENTES]",
    "estaban_cifrados": "[SI / NO / NO LO SE]",
    "tipo_de_afectacion": "[PERDIDA DE ACCESO, ROBO O COPIA, PUBLICACION, ALTERACION]",
    "medidas_ya_tomadas": "[QUE HAS HECHO PARA CONTENERLO]",
    "hay_encargados": "[PROVEEDORES QUE TRATAN ESOS DATOS: HOSTING, GESTORIA, CRM, EMAIL MARKETING]"
  },
  "instrucciones": [
    "Determina primero si hay datos personales implicados y si actuo como responsable o como encargado del tratamiento",
    "Valora el riesgo para los derechos y libertades usando cuatro factores: sensibilidad de los datos, volumen, facilidad de identificacion y consecuencias probables",
    "Concluye con una de tres opciones: no notificable (solo registro interno), notificable a la AEPD en 72 horas, o notificable ademas a las personas afectadas",
    "Calcula la fecha y hora limite exacta de las 72 horas desde la fecha de conocimiento",
    "Redacta el borrador de notificacion con los apartados que pide la AEPD: naturaleza, categorias y numero de afectados, consecuencias probables, medidas adoptadas y datos de contacto",
    "Redacta tambien la entrada del registro interno de brechas, obligatoria aunque no se notifique",
    "Lista las preguntas que debo trasladar a mis proveedores implicados y en que plazo"
  ],
  "restricciones": [
    "Deja claro que esto es una guia de preparacion y no sustituye al asesoramiento juridico ni al DPD si lo tengo",
    "No inventes articulos ni numeros de expediente; cita solo lo que sea seguro y en lenguaje llano",
    "Si falta un dato clave para decidir, pidemelo antes de concluir"
  ],
  "formato_salida": {
    "tipo": "Documento en markdown listo para copiar",
    "secciones": ["Decision y motivo en 3 lineas", "Fecha limite de notificacion", "Valoracion del riesgo por factores", "Borrador de notificacion a la AEPD", "Borrador de comunicacion a los afectados si procede", "Entrada del registro interno", "Preguntas a pr
```
