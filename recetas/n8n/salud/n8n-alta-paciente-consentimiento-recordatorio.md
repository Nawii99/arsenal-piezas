# Alta de paciente con consentimiento, registro y recordatorio…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Flujo en n8n que recoge el alta de un paciente nuevo, le envía la hoja de datos y el consentimiento antes de la cita, registra la aceptación y manda el recordatorio. Se monta una vez.

## Qué es y qué hace

Es un flujo de n8n que, al dar de alta a un paciente nuevo, le envía por email la hoja de protección de datos y el consentimiento, guarda en una hoja de cálculo qué se envió y cuándo, y manda un recordatorio sin datos clínicos 24 horas antes. Entra el alta; sale los envíos registrados.

## Cómo usarla

1. Conecta el formulario de alta y la hoja de cálculo
2. Prueba con un paciente ficticio
3. Revisa los datos que se guardan
4. Que lo revise un profesional

## Cuándo usarla

Tus pacientes nuevos llegan sin haber leído ni firmado nada y lo resuelves en la camilla. Con este flujo reciben los papeles antes de la cita y queda constancia de que se enviaron.

## Cómo ganar dinero con ella

Se vende dentro del paquete Completo de la propuesta: lo montas en la consulta una vez y cobras la instalación y una cuota mensual de mantenimiento de [TU PRECIO]. Maneja datos de salud, así que lo revisa un profesional de protección de datos y los textos legales, un abogado.

- Instalación del alta de pacientes para consultas que reciben papeles por email, por instalación…
- Cuota mensual de mantenimiento del flujo y sus registros, por mes…
- Formación de la recepción para usar el flujo, por sesión…

**Precio orientativo:** 200–400 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace

Cuando la consulta da de alta un paciente nuevo, el flujo le envía por email la hoja informativa de protección de datos y el consentimiento del tratamiento, guarda en una hoja de cálculo que se ha enviado y cuándo, y 24 horas antes de la cita manda un recordatorio con solo fecha, hora y dirección. Sin datos clínicos en el recordatorio.

Lo que resuelve: que el paciente reciba los papeles antes de entrar, no en la camilla, y que quede constancia.

## Antes de empezar: lo que hay que tener claro

- Los datos de un paciente son datos de salud. Todo lo que toque este flujo (n8n, correo, hoja de cálculo) necesita contrato de encargado de tratamiento con el proveedor. Google Workspace de pago lo incluye en sus condiciones; una cuenta de Gmail gratuita no sirve para esto. n8n Cloud ofrece condiciones de tratamiento de datos; si prefieres evitarlo, n8n se puede instalar en un servidor propio.
- No uses WhatsApp para enviar el consentimiento ni ninguna información clínica. Para el recordatorio de fecha y hora, solo si el paciente ha marcado esa casilla en la hoja de datos.
- La firma: este flujo envía el documento y registra que se ha enviado y que el paciente ha pulsado "he leído". Eso no es una firma. Para tratamientos que exigen consentimiento escrito, la firma se hace en la consulta en papel o tablet, o con un servicio de firma electrónica [precio por sobre o mensual: comprobar en Signaturit, Docusign o similar]. Deja esto por escrito en la propuesta al cliente.

## Cuentas necesarias

- n8n: Cloud [plan de inicio: comprobar precio actual; tiene prueba gratuita] o instalado en servidor propio (gratis, pero hay que mantenerlo).
- Google Workspace de pago para Gmail y Google Sheets [precio por usuario y mes: comprobar]. Con el contrato de encargado aceptado en la consola de administración.
- Un sitio donde alojar los PDF de la hoja informativa y el consentimiento: Google Drive del mismo Workspace, con enlace solo para quien lo tenga.

## Nodos, en orden

1. Disparador: **n8n Form Trigger**. Crea un formulario con estos campos: nombre y apellidos, email, teléfono (opcional), tratamiento (desplegable con los tratamientos de la consulta), fecha y hora de la cita, casilla "acepto recibir recordatorios por email", casilla "acepto recibir recordatorios por SMS o mensajería" (opcional). Este formulario lo rellena la recepción de la consulta, no el paciente. Así no expones un formulario público con datos de salud.

2. **Set** (Edit Fields): normaliza los datos. Pon el email en minúsculas, la fecha de cita en formato ISO, y crea un campo `id_alta` con la fecha y hora actual más las iniciales del paciente. Te servirá para buscar después.

3. **Switch** por el campo tratamiento: una salida por cada tratamiento. En cada salida, un nodo **Set** que añade el enlace al PDF del consentimiento correspondiente. Si un tratamiento no tiene consentimiento escrito, deja el enlace vacío.

4. **Google Sheets** (Append row) en una hoja llamada `registro_altas` con columnas: id_alta, fecha_alta, nombre, email, tratamiento, fecha_cita, consentimiento_enviado (sí/no), fecha_envio, leido (vacío por ahora), recordatorio_enviado (vacío por ahora). En esta hoja no se guarda nada clínico: ni motivo de consulta, ni notas.

5. **Gmail** (Send): asunto "Documentación previa a su cita en [NOMBRE CONSULTA]". Cuerpo en texto plano: saludo, fecha y hora de la cita, enlace a la hoja informativa de protección de datos, enlace al consentimiento si lo hay, y un enlace de confirmación de lectura (ver nodo 6). Sin adjuntos: mejor enlaces a Drive con acceso restringido que PDFs que se quedan en cualquier bandeja de entrada.

6. Segundo flujo, pequeño: disparador **Webhook** en n8n. El enlace de confirmación de lectura del correo apunta a esta URL con el parámetro `id_alta`. Cuando el paciente pulsa, este flujo hace **Google Sheets** (Update row) buscando por id_alta y pone `leido = sí` con la fecha. Luego un nodo **Respond to Webhook** que devuelve una página simple: "Gracias, hemos registrado que ha leído la documentación. Cualquier duda, pregúntenos en la consulta."

7. De vuelta al flujo principal, tras el Gmail: **Wait** con la opción "Resume: At specified time", calculando `fecha_cita menos 24 horas`. Si la cita es en menos de 24 horas, salta este paso con un **IF** previo y envía el recordatorio ya.

8. **IF**: ¿el paciente marcó "acepto recordatorios por email"? Si no, termina el flujo aquí. No se envía nada.

9. **Gmail** (Send): recordatorio. Solo fecha, hora, dirección y teléfono de la consulta. Nada del tratamiento. Una línea para cancelar o cambiar: "Si no puede venir, avísenos antes de [HORAS] horas en [TELÉFONO O EMAIL]". Si la consulta cobra por no presentarse, esa política tiene que estar en la hoja informativa, no solo aquí.

10. **Google Sheets** (Update row): `recordatorio_enviado = sí` con fecha.

11. Rama de error: activa en el flujo la opción de Error Workflow y crea un flujo aparte con un **Gmail** que avise a la consulta de que un alta ha fallado, con el id_alta. Sin esto, un correo que no sale no lo ve nadie.

## Cómo probarlo sin liarla

- Crea una hoja `registro_altas_pruebas` y apunta ahí los nodos de Sheets mientras pruebas. No toques la hoja real hasta que todo funcione.
- Usa tu propio email como paciente en todas las pruebas. Nunca datos de un paciente real.
- Para probar el Wait sin esperar 24 horas, pon una cita a 10 minutos vista y comprueba que llega el recordatorio.
- Pulsa el enlace de lectura y comprueba que la fila cambia a `leido = sí`.
- Prueba con un tratamiento sin consentimiento y comprueba que el correo sale sin el enlace vacío colgando.
- Desactiva el flujo de prueba antes de activar el real. Si dejas los dos activos, el paciente recibe dos correos.

## Cómo se cobra

- Instalación: precio cerrado [PRECIO] euros más IVA, que incluye montar los dos flujos, configurar el formulario, la hoja y los PDFs, y una sesión de una hora con recepción para enseñarles a usarlo.
- Mantenimiento: cuota mensual [PRECIO] euros más IVA que cubre revisar que sigue funcionando, añadir tratamientos nuevos y actualizar los documentos cuando cambien.
- Lo que no incluye y hay que decir: el coste de n8n y Google Workspace lo paga la consulta con sus propias cuentas. Así los datos de los pacientes están en cuentas suyas, no tuyas. Esto también te protege a ti.

## Qué NO hacer

- No montes esto en tu propia cuenta de n8n o de Google para varios clientes. Cada consulta con sus cuentas.
- No añadas al formulario campos como motivo de consulta o diagnóstico. Si la consulta lo pide, explica que eso va en su programa de historia clínica, no en una hoja de cálculo.
- No envíes el consentimiento por WhatsApp aunque el cliente insista. Deja por escrito que lo has desaconsejado.
- No borres la hoja de registro al final del año. Es la prueba de que se informó al paciente y se conserva mientras se conserve la historia clínica.
