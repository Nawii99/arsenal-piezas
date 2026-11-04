---
name: consentimiento-informado-consulta
description: Redacta el consentimiento informado de un tratamiento y la hoja de información de protección de datos de una consulta sanitaria en España. Se activa cuando el usuario pide un consentimiento, una hoja de datos para pacientes o dice que abre consulta y no tiene papeles.
---

## Qué hace

Genera dos documentos separados, porque son cosas distintas y la gente las mezcla:

1. **Consentimiento informado** (Ley 41/2002 de autonomía del paciente): el paciente entiende qué le vas a hacer, qué riesgos tiene y acepta. Uno por tratamiento.
2. **Hoja informativa de protección de datos** (RGPD y LOPDGDD): qué datos guardas, para qué, cuánto tiempo y qué derechos tiene. Una sola para toda la consulta, se firma en la primera visita.

Para atender a un paciente NO necesitas su consentimiento RGPD: la asistencia sanitaria es base legal por sí misma (art. 9.2.h RGPD). Lo que sí necesitas es informarle. Solo pide consentimiento de datos para usos extra: enviarle promociones, hacer fotos de antes y después para redes, ceder datos a terceros no sanitarios.

## Qué preguntar antes de empezar

Si el usuario no lo ha dicho, pregunta todo esto de una vez y espera respuesta:

- Profesión y titulación (fisio, psicólogo, dentista, nutricionista, podólogo, médico de X). Cambia el tono y el riesgo.
- Tratamiento concreto para el consentimiento. Si dice "todos", pide que elija uno; se hace de uno en uno.
- ¿Es un procedimiento invasivo o con riesgos notorios? (punción, cirugía, sedación, infiltración, tratamiento con efectos secundarios frecuentes). Si sí, el consentimiento tiene que ser por escrito obligatoriamente (art. 8.2 Ley 41/2002). Si no, basta verbal y anotarlo en la historia, pero se recomienda escrito igual.
- ¿Trata menores? Marca la regla: 16 años o más deciden ellos salvo grave riesgo; menores de 16, firma el representante legal y se escucha al menor si tiene 12 o más.
- Nombre y forma jurídica del responsable: autónomo con su nombre y NIF, o sociedad con razón social y CIF. Dirección de la consulta.
- Qué programa usa para citas e historias (nombre) y si tiene gestoría. Son encargados del tratamiento y hay que nombrarlos en la hoja de datos.
- ¿Quiere enviar recordatorios de cita por email o SMS? ¿Promociones? Cada uso extra va en una casilla aparte.
- ¿Hace fotos clínicas? Si sí, casilla aparte para uso en historia y otra distinta para uso en redes o web.

## Paso a paso

1. Con las respuestas, redacta primero el **consentimiento informado** con esta estructura, en lenguaje que entienda alguien sin estudios sanitarios:
   - Título con el nombre del tratamiento.
   - Qué es y para qué sirve (3-5 frases).
   - Cómo se hace y cuánto dura.
   - Beneficios esperados sin prometer resultados.
   - Riesgos frecuentes y riesgos poco frecuentes pero graves. Si no conoces los riesgos concretos del tratamiento, deja `[RIESGOS ESPECÍFICOS: rellenar por el profesional]`. No inventes porcentajes.
   - Alternativas, incluida no hacer nada.
   - Contraindicaciones y qué debe contar el paciente antes (alergias, embarazo, medicación).
   - Declaración del paciente: he leído, he podido preguntar, sé que puedo revocar en cualquier momento.
   - Bloque de firmas: paciente o representante legal, profesional con número de colegiado, fecha, y espacio para revocación.
2. Redacta la **hoja informativa de protección de datos** con estos apartados obligatorios:
   - Responsable: nombre, NIF, dirección, email de contacto.
   - Finalidad: asistencia sanitaria, gestión de citas, facturación, historia clínica.
   - Base legal: asistencia sanitaria (art. 9.2.h RGPD y Ley 41/2002) y obligación legal para facturas.
   - Conservación: historia clínica mínimo 5 años desde el alta de cada proceso (art. 17 Ley 41/2002); indica `[comprobar plazo de tu comunidad autónoma, algunas exigen más]`. Facturas: los plazos fiscales.
   - Destinatarios: los encargados que dijo el usuario (programa de citas, gestoría) y Administración cuando obligue la ley. Nada de "terceros" en genérico.
   - Derechos: acceso, rectificación, supresión, limitación, portabilidad, oposición. Cómo ejercerlos (email) y que puede reclamar ante la AEPD.
   - Casillas separadas, cada una con su propio sí/no, para: recordatorios por email o SMS, comunicaciones comerciales, fotos para historia clínica, fotos para redes o web. Ninguna premarcada.
3. Añade al final una **nota de uso para el profesional** de 5 líneas: cuándo firmar cada documento, dónde guardarlo (en la historia del paciente), y que el paciente tiene derecho a copia.
4. Marca con `[CORCHETES]` todo lo que el usuario no haya dado. No rellenes con datos plausibles.

## Qué devolver y con qué formato

- Dos documentos en Markdown, uno detrás de otro, con títulos claros para copiar cada uno a un archivo de texto o Word.
- Al principio, una línea que diga si el consentimiento debe ser por escrito obligatoriamente o solo recomendado, y por qué.
- Al final, la lista de `[CORCHETES]` pendientes de rellenar.
- Aviso fijo, siempre: "Esto es un borrador. Revísalo con un abogado o con la asesoría jurídica de tu colegio antes de usarlo con pacientes."

## Qué NO hacer

- No escribas un consentimiento genérico que valga para todos los tratamientos. Un consentimiento que no dice qué se va a hacer no vale.
- No mezcles en un solo papel el consentimiento del tratamiento y el consentimiento de datos. Son leyes distintas y se revocan por separado.
- No pongas casillas premarcadas ni frases tipo "si no dice lo contrario, acepta". Eso invalida el consentimiento.
- No pidas consentimiento RGPD para la asistencia en sí. Confunde al paciente y, si luego lo revoca, te deja en un lío innecesario.
- No inventes riesgos, porcentajes ni plazos de conservación. Si no lo sabes, corchetes.
- No metas cláusulas de exención de responsabilidad del profesional. No sirven de nada legalmente y quedan mal.
- No uses lenguaje técnico sin explicarlo. Si el paciente no lo entiende, no ha consentido nada.
- No incluyas la cesión a "empresas del grupo" ni a "terceros colaboradores" sin nombre. Nómbralos o no los metas.
