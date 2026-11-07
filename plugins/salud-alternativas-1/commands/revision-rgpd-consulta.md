---
name: revision-rgpd-consulta
description: Repasa los 12 puntos mínimos de protección de datos de una consulta sanitaria en España, pregunta uno a uno, y devuelve una tabla con lo que falta ordenado por urgencia. Se activa con /revision-rgpd-consulta.
---

## Qué hace

Una consulta trata datos de salud, que son categoría especial (art. 9 RGPD). Eso quiere decir que las excepciones para pequeños negocios no te aplican: las multas y las obligaciones son las mismas que para una clínica grande. Este comando repasa lo mínimo, sin abogado, para saber dónde estás.

No sustituye una consultoría. Sirve para no empezar a ciegas y para saber qué preguntar cuando la contrates.

## Qué preguntar antes de empezar

Haz las preguntas de una en una, esperando respuesta. Acepta "sí", "no" o "no sé". "No sé" cuenta como "no".

1. ¿Eres un profesional solo (autónomo) o una clínica con varios profesionales o con empleados?
2. ¿Tienes un **registro de actividades de tratamiento**? (Un documento que lista: qué datos guardas, de quién, para qué, dónde, cuánto tiempo, quién accede.) Obligatorio siempre que trates datos de salud, aunque seas uno solo.
3. ¿Entregas al paciente una **hoja informativa de datos** en la primera visita y guardas constancia?
4. ¿Tienes **contrato de encargado del tratamiento** (art. 28 RGPD) firmado con cada empresa que ve datos de pacientes: programa de citas, programa de historias, gestoría, hosting de la web, servicio de email? Pregunta por cada uno que use.
5. ¿Dónde están las historias clínicas: papel, ordenador local, nube? Si es nube, ¿la empresa es europea o tiene cláusulas para transferencias fuera de la UE?
6. ¿El ordenador y el móvil donde hay datos de pacientes tienen contraseña o PIN, y el disco cifrado? ¿Hay copia de seguridad y la has probado a restaurar alguna vez?
7. ¿Usas WhatsApp personal para hablar con pacientes de temas clínicos? (Respuesta honesta.)
8. ¿Tienes un **delegado de protección de datos (DPD)**? Obligatorio para centros sanitarios (art. 34.1.l LOPDGDD). Si eres profesional individual, estás exento.
9. ¿Sabes qué hacer si pierdes el móvil, te roban el portátil o te entra un virus? Tienes 72 horas para notificar a la AEPD si hay riesgo para los pacientes.
10. ¿Tienes cámaras en la consulta? Si sí: ¿cartel informativo y las grabaciones se borran en un mes máximo?
11. ¿Tu web tiene formulario de contacto o de cita? ¿Tiene política de privacidad y aviso de cookies?
12. ¿Tus empleados o colaboradores han firmado un compromiso de confidencialidad y saben que no pueden mirar historias que no sean de sus pacientes?

## Paso a paso

1. Haz las 12 preguntas, en orden, de una en una.
2. Al terminar, clasifica cada respuesta en: **Hecho**, **Falta y urgente**, **Falta**, **No aplica**.
   - Urgente: registro de actividades, hoja informativa, contratos de encargado, cifrado y contraseñas, WhatsApp personal con datos clínicos, DPD si es clínica.
   - Falta: el resto.
3. Para cada "Falta", da una acción concreta de una frase y quién la hace (tú, tu gestoría, el proveedor del software).
4. Si en la pregunta 7 dice que sí, explica dentro de la tabla: WhatsApp personal no tiene contrato de encargado con tu consulta y mezcla datos de pacientes con tu vida privada. Alternativa: WhatsApp Business con la API oficial a través de un proveedor que firme contrato, o email desde tu dominio, o el propio programa de citas si tiene mensajería. Y en todo caso: nada clínico por mensaje, solo horas y avisos.
5. Si en la pregunta 5 dice "nube" y no sabe qué empresa, pídele que mire la política de privacidad del programa y busque "encargado" o "DPA". Si no aparece, marcarlo como urgente.

## Qué devolver y con qué formato

Una tabla Markdown con columnas: Punto | Estado | Qué hacer | Quién.

Debajo, un bloque "Empieza por aquí" con las 3 acciones más urgentes, numeradas.

Debajo, un bloque "Lo que no se puede hacer con IA" que diga claro: el contrato de encargado lo tiene que dar o firmar el proveedor, el DPD tiene que ser una persona o empresa real inscrita en la AEPD, y el registro de actividades lo puedo redactar como borrador pero lo tiene que revisar alguien.

Cierra siempre con: "Los datos de salud son categoría especial. Una denuncia de un paciente o una inspección de la AEPD no distingue entre una consulta de una persona y un hospital."

## Qué NO hacer

- No des por hecho ninguna respuesta. Pregunta aunque parezca obvio.
- No cites cuantías de multa concretas. No las inventes.
- No digas que "con esto ya cumple". Con esto sabe qué le falta.
- No recomiendes programas o proveedores concretos por nombre. Di qué tienen que tener (contrato de encargado, servidores en la UE, cifrado) y que lo compruebe.
- No trates el caso de una clínica con empleados como el de un autónomo solo. Si hay empleados, hay DPD obligatorio, confidencialidad firmada y control de accesos, y hay que decirlo.
- No saltes la pregunta de WhatsApp. Es la que más gente falla y la que más pruebas deja.
