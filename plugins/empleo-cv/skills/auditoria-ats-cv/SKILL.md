---
name: auditoria-ats-cv
description: Audita un CV frente a una oferta de trabajo, detecta las palabras clave que faltan para pasar el filtro ATS y devuelve el CV reescrito con una puntuación de encaje. Se activa cuando el usuario pega un CV y una oferta y pide revisarlo, puntuarlo o adaptarlo.
---

# Auditoría ATS y adaptación de CV

## Qué hace
Compara un CV con el texto de una oferta de trabajo concreta. Detecta qué palabras clave y competencias pide la oferta y cuáles faltan en el CV. Calcula una puntuación de encaje del 0 al 100 orientada a cómo lo leería un sistema ATS (el filtro automático que usan las empresas antes de que un humano vea el CV). Entrega el CV reescrito con esos huecos cubiertos, sin inventar experiencia que el candidato no tiene.

## Antes de empezar, pregunta
- El texto completo de la oferta (pégalo tal cual, no un resumen).
- El CV actual, en texto plano o el archivo.
- Si el candidato tiene de verdad la experiencia que pide la oferta o si hay huecos reales (esto marca qué se puede reescribir y qué no).
- Si es para un cliente de pago, qué formato final necesita: solo el informe, el CV reescrito, o ambos.

## Paso a paso
1. Extrae de la oferta las palabras clave: puesto, skills técnicas, skills blandas, requisitos duros (idiomas, titulación, años de experiencia).
2. Compara cada una con el CV: presente, ausente, o presente pero con otro término que un ATS no reconoce como sinónimo.
3. Calcula la puntuación de encaje y explica en una frase por qué es esa nota, no solo el número.
4. Reescribe el CV: coloca las palabras clave que faltan solo donde son ciertas, ajusta el resumen inicial al puesto, ordena la experiencia relevante primero.
5. Señala aparte qué requisitos duros no cumple el candidato, sin disimularlos en el CV.

## Qué devolver
Un informe corto: puntuación de encaje, palabras clave que faltaban y ya están cubiertas, y requisitos que no cumple y no se pueden fingir. Después el CV completo reescrito, listo para copiar en el formato que pida el cliente.

## Qué NO hacer
No inventes experiencia, empresas, años o titulaciones que el candidato no tiene: eso se descubre en la entrevista y quema la confianza del cliente.
No prometas que el CV va a conseguir el trabajo ni que va a pasar seguro el ATS: cada empresa usa un sistema distinto y nadie lo controla al cien por cien.
No metas relleno de palabras clave a lo bruto: un reclutador humano lo detecta y descarta el CV directamente.
No cambies datos de contacto, fechas o formación sin confirmarlo con el candidato.
