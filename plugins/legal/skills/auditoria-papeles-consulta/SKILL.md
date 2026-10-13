---
name: auditoria-papeles-consulta
description: Audita la documentación legal de una consulta sanitaria (consentimientos, RGPD, citas, facturas) y produce un informe de hallazgos vendible. Se activa cuando el usuario pide revisar, auditar o poner al día los papeles de una clínica, consulta o profesional sanitario.
---

## Qué hace

Convierte un montón de documentos sueltos de una consulta en un informe ordenado con tres columnas: qué está bien, qué falta y qué hay que arreglar primero. Ese informe es el producto que se cobra: sirve como diagnóstico inicial y como base para vender la puesta al día después.

No sustituye a un abogado ni a un delegado de protección de datos. Lo que hace es preparar el terreno para que, si hace falta uno, llegue con el trabajo hecho y cobre menos horas.

## Qué preguntar antes de empezar

Hazle estas preguntas al usuario y no arranques hasta tener respuesta. Si no sabe alguna, apúntala como [PENDIENTE] en el informe.

1. Tipo de consulta: fisioterapia, psicología, dental, estética, nutrición, otra. Cambia lo que se exige.
2. ¿Quién ejerce? Un autónomo solo, o un centro con varios profesionales o empleados. Si es centro, la ley obliga a tener delegado de protección de datos (LOPDGDD art. 34.1.l); si es un profesional a título individual, no.
3. ¿Tiene autorización sanitaria de la comunidad autónoma y número de registro de centro? Pide el número o márcalo como pendiente.
4. ¿Qué documentos puede enviar ahora? Pide todo lo que tenga: modelos de consentimiento, hoja o cartel de protección de datos, contratos con el software de citas y con la gestoría, un ejemplo de factura, el formulario de alta de paciente y cómo guarda las historias clínicas.
5. ¿Con qué herramientas trabaja? Agenda, mensajería con pacientes, dónde guarda los archivos, quién le lleva la contabilidad.

## Paso a paso

### 1. Consentimientos informados

- Comprueba si existe un modelo por cada tratamiento con riesgo. La Ley 41/2002 exige consentimiento por escrito en intervenciones quirúrgicas, procedimientos invasivos y los que tengan riesgos notables. Para el resto vale verbal, pero conviene dejar constancia.
- Revisa que cada modelo tenga: nombre del tratamiento, en qué consiste, riesgos frecuentes y graves, alternativas, posibilidad de revocar, datos del profesional, fecha y firma del paciente.
- Comprueba cuándo se firma. Si se firma en la camilla justo antes de empezar, anótalo como riesgo: el paciente debe tener tiempo para leerlo.
- Menores y personas con tutela: comprueba si hay modelo para quien firma por ellos.

### 2. Protección de datos

Los datos de salud son categoría especial (RGPD art. 9). Aquí es donde más se falla y donde las multas son reales. Revisa:

- Información al paciente: hoja o cartel con quién trata los datos, para qué, cuánto tiempo, y cómo ejercer los derechos. Debe entregarse antes de la primera consulta.
- Registro de actividades de tratamiento (RGPD art. 30). Casi ninguna consulta pequeña lo tiene. Si falta, va arriba en la lista.
- Contratos de encargado de tratamiento con cada proveedor que toca datos de pacientes: software de citas, gestoría, almacenamiento en la nube, quien mande recordatorios. Sin contrato firmado, cada proveedor es un hallazgo.
- Canal de mensajería: si envía datos de salud por WhatsApp personal o por correo sin cifrar, márcalo. Recordatorios de cita sin detalle clínico son un riesgo menor; resultados o diagnósticos por WhatsApp es un riesgo alto.
- Conservación de historias clínicas: mínimo 5 años desde el alta de cada proceso (Ley 41/2002 art. 17). Algunas comunidades exigen más: [comprobar en la normativa autonómica].
- Personal: si hay empleados, comprueba si han firmado un compromiso de confidencialidad.
- Análisis de riesgos y evaluación de impacto: para datos de salud a gran escala es obligatoria. Para una consulta pequeña suele bastar con un análisis de riesgos documentado. Si no hay nada escrito, anótalo.

### 3. Citas

- Cómo se recoge la cita: qué datos se piden y si se piden más de los necesarios.
- Recordatorios: quién los envía, por qué canal, y si el paciente ha aceptado ese canal.
- Cancelaciones: si cobra por no presentarse, comprueba que esa política esté escrita y que el paciente la haya visto antes de reservar.
- Lista de espera y agenda compartida: quién tiene acceso.

### 4. Facturas

- Contenido obligatorio (RD 1619/2012): número correlativo, fecha, NIF y datos del emisor y del cliente, descripción, importe y régimen de IVA.
- IVA: los servicios sanitarios de diagnóstico, prevención y tratamiento prestados por profesionales sanitarios titulados están exentos (Ley del IVA art. 20.Uno.3). Los tratamientos estéticos sin finalidad terapéutica no lo están. Si la consulta mezcla ambos, comprueba que factura cada cosa con su régimen. Si hay dudas, deriva al gestor: no decidas tú.
- Sistema de facturación: comprueba si el programa cumple con Verifactu [comprobar fecha vigente de obligación para su caso].
- Facturas a mutuas o aseguradoras: comprueba si hay contrato y qué datos del paciente se envían.

### 5. Prioriza

Ordena todos los hallazgos en tres niveles:

- Rojo: puede acabar en multa o en un problema con un paciente mañana. Sin registro de actividades, sin información RGPD, datos de salud por WhatsApp, sin consentimiento escrito en tratamientos invasivos.
- Naranja: hay que arreglarlo este trimestre. Contratos de encargado sin firmar, modelos de consentimiento incompletos, política de cancelación sin escribir.
- Verde: mejoras. Plantillas más claras, orden de archivos, automatizar recordatorios.

## Qué devolver

Un archivo Markdown llamado `informe-auditoria-[NOMBRE-CONSULTA].md` con esta estructura:

1. Resumen en 5 líneas para que el dueño de la consulta lo lea sin abrir el resto.
2. Ficha de la consulta: tipo, forma jurídica, número de registro sanitario, herramientas.
3. Tabla de hallazgos con columnas: área, hallazgo, nivel (rojo/naranja/verde), qué hay que hacer, quién lo hace (tú, el gestor, un abogado o DPO).
4. Lista de documentos que faltan, para usarla directamente como presupuesto de la fase siguiente.
5. Lista de [PENDIENTE]: lo que no se pudo comprobar por falta de información.
6. Aviso final, siempre: este informe organiza y detecta; no es asesoramiento jurídico. Los modelos legales deben ser revisados por un profesional.

## Cómo se cobra esto

Ofrécelo como diagnóstico cerrado a precio fijo: [PRECIO] euros más IVA por consulta, entrega en [X] días. El informe con la lista de documentos que faltan es la puerta a la fase dos (puesta al día), que se cobra aparte. No regales la auditoría: si es gratis, el cliente no la lee.

## Qué NO hacer

- No redactes cláusulas legales definitivas. Puedes proponer borradores marcados como tal, pero el informe debe decir que los revise un abogado o DPO.
- No inventes artículos de ley ni plazos. Si no estás seguro de un plazo autonómico, escribe [comprobar].
- No digas que la consulta cumple. Di qué has comprobado y qué no.
- No pidas historias clínicas reales ni datos de pacientes para la auditoría. Se revisa con modelos en blanco o con datos tapados.
- No guardes los documentos del cliente fuera de la carpeta del proyecto ni los subas a servicios de terceros sin avisar.
- No metas más de 15 hallazgos rojos. Si salen más, agrúpalos: un informe con 40 rojos no lo lee nadie.
