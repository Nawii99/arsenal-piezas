---
name: factura-consulta-sanitaria
description: Genera el contenido de una factura de servicios sanitarios en España (exenta de IVA o con IVA según el servicio) a partir de los datos mínimos. Se activa con /factura-consulta-sanitaria seguido de los datos, o sin datos para que los pida.
---

## Qué hace

Redacta el contenido completo de una factura con todos los campos obligatorios del Real Decreto 1619/2012, aplicando la exención de IVA del artículo 20.Uno.3 de la Ley 37/1992 cuando toca y avisando cuando no toca.
Devuelve texto para pegar en tu programa de facturación o plantilla. No emite la factura: eso lo haces tú desde tu programa, que es quien lleva la numeración.

## Qué preguntar antes de empezar

Si no vienen en el comando, pide estos datos en un solo mensaje:

1. Tus datos de emisor: nombre completo o razón social, NIF, dirección, profesión y nº de colegiado. (Solo la primera vez; luego dile que los guarde en un archivo de la carpeta del proyecto y que los lea de ahí.)
2. Datos del paciente: nombre, NIF, dirección. Si el paciente no da NIF y el importe es menor de 400 €, se puede hacer factura simplificada sin sus datos, pero muchos la piden con NIF para la aseguradora o para desgravar donde exista deducción. Pregunta.
3. Servicio: qué se hizo (sin detalle clínico: 'sesión de fisioterapia', no 'tratamiento de hernia L4-L5'), fecha, número de sesiones e importe por sesión.
4. Número y serie de factura: te los da tu programa. Si no tienes programa, déjalo en [NÚMERO] y avisa de que la numeración debe ser correlativa y sin huecos.

## Paso a paso

1. Decide si el servicio está exento de IVA. La regla: está exento la asistencia a personas físicas por profesionales médicos o sanitarios (titulados según la Ley 44/2003 de ordenación de las profesiones sanitarias) cuando consiste en diagnóstico, prevención o tratamiento de enfermedades. Ejemplos exentos: fisioterapia, podología, odontología, logopedia, psicología por psicólogo general sanitario o clínico, enfermería, dietista-nutricionista en tratamiento de salud. Ejemplos con IVA al 21 %: tratamientos puramente estéticos, coaching, talleres, venta de productos, informes para terceros que no son asistencia (peritajes).
2. Si hay duda, no la resuelvas tú: pon la factura como exenta con un aviso claro al final diciendo 'CONFIRMA CON TU GESTOR SI ESTE SERVICIO ESTÁ EXENTO'. Una factura mal hecha se rectifica; un criterio fiscal inventado sale caro.
3. Redacta la factura con estos campos, en este orden:
   - Número y serie.
   - Fecha de expedición y fecha de la operación si es distinta.
   - Emisor: nombre, NIF, dirección, profesión y nº de colegiado.
   - Destinatario: nombre, NIF, dirección.
   - Concepto: descripción sin datos clínicos, fechas, número de sesiones, precio unitario.
   - Base imponible.
   - IVA: si está exento, la línea dice exactamente 'Operación exenta de IVA según el artículo 20.Uno.3 de la Ley 37/1992'. Si no lo está, tipo 21 % y cuota.
   - Retención de IRPF: solo si el destinatario es una empresa o un profesional (una clínica que te subcontrata, una mutua). A un paciente particular nunca se le aplica retención. Tipo general 15 %; 7 % durante el año de alta como autónomo y los dos siguientes si lo has pedido.
   - Total a pagar.
   - Forma de pago y cuenta o método.
4. Añade al pie: 'Conserva esta factura. Las facturas se guardan al menos 4 años a efectos fiscales y 6 años según el Código de Comercio'.
5. Termina con dos avisos cortos dirigidos al usuario, no al paciente: (a) los programas de facturación deben cumplir el sistema Verifactu de Hacienda y [COMPRUEBA CON TU GESTOR DESDE QUÉ FECHA TE AFECTA]; una plantilla de Word o Excel puede dejar de valer; (b) si el pago es en efectivo, recuerda el límite legal de 1.000 € cuando una de las partes es profesional.

## Qué devolver

- La factura en texto plano, con los campos alineados, lista para copiar.
- Una línea diciendo: 'Exenta' o 'Con IVA 21 %' y por qué, en una frase.
- Los dos avisos del paso 5.

Nada más. No expliques la ley entera cada vez.

## Qué NO hacer

- No inventar el número de factura. Si no lo tienes, corchetes.
- No poner diagnósticos, patologías ni tratamientos concretos en el concepto. Es un dato de salud y la factura acaba en una aseguradora, en una empresa o en un cajón compartido.
- No aplicar retención de IRPF a particulares.
- No decidir tú si un servicio dudoso está exento. Avisar y seguir.
- No emitir facturas con fecha anterior a la última emitida.
- No sumar 'gastos de gestión' ni recargos que el usuario no haya dicho.
