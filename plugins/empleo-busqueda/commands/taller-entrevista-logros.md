---
name: taller-entrevista-logros
description: "Prepara una candidatura de principio a fin: guarda la oferta, adapta tu CV a ella sin inventar nada, prepara la entrevista, la ensaya contigo y escribe tus historias de logros. Úsalo cuando tengas una oferta concreta o te bloquees al contar lo que has hecho."
---

# Taller de entrevista y relatos de logros

Cómo se instala: guarda este texto en `.claude/commands/taller-entrevista-logros.md`, dentro de la carpeta donde llevas tu búsqueda de empleo. Después escribe `/taller-entrevista-logros` seguido de una palabra: oferta, cv, entrevista, ensayo o historias.
Lo que ha escrito la persona: $ARGUMENTS
Si no ha escrito ninguna de esas palabras, pregunta qué quiere hacer y propón este orden: historias, oferta, cv, entrevista, ensayo.

## Qué hace
Trabaja con cinco palabras. Todo se guarda en archivos de texto dentro de una carpeta `empleo/`, para que la persona no repita datos: `perfil.md` (su historial), `historias.md` (sus relatos), `ofertas/` (una ficha por oferta) y `cv/` (un CV por oferta).

## Qué preguntar antes de empezar (si no consta ya en `empleo/perfil.md`)
1. Qué puesto busca y en qué sector.
2. Su historial: empresas, fechas y qué hacía en cada una. Si tiene un CV, que lo pegue.
3. Cifras reales que pueda dar: ventas, plazos, ahorro, personas a su cargo, clientes. Si no las sabe, el logro se queda sin cifra. No se estiman.
4. En qué idioma está la oferta y en cuál debe ir el CV.
5. Qué no quiere que aparezca: un empleo, un periodo, un dato personal.
6. Avisa de que lo que pegue se envía a Claude para procesarlo. Que no pegue DNI, cuentas bancarias, direcciones ni datos de otras personas: no hacen falta.

## Paso a paso según la palabra
**oferta**. Pide el texto de la oferta (si no puedes abrir el enlace, que lo pegue). Guarda `empleo/ofertas/EMPRESA-PUESTO.md` con: empresa, puesto, fecha de hoy, enlace, requisitos imprescindibles, requisitos deseables, palabras que se repiten, salario (o «no indicado») y dudas que conviene preguntar. Separa lo que dice la oferta literalmente de tu interpretación.
**cv**. Con `perfil.md` y la ficha de la oferta, escribe `empleo/cv/EMPRESA-PUESTO.md`. Usa solo hechos del perfil: reordena y destaca, no inventes. Máximo dos páginas y formato sencillo, sin columnas ni tablas, que muchos portales leen mal. Sin foto, DNI ni estado civil salvo que la persona los pida. Al final añade una tabla: requisito de la oferta, dónde lo cubre el CV y, si no lo cubre, la palabra «hueco». No tapes los huecos.
**entrevista**. Prepara una ficha con 8 preguntas probables: 3 sobre las funciones del puesto, 2 sobre motivación, 2 de «cuéntame un caso en que...» y 1 incómoda (huecos en el CV, motivo de salida o salario). Indica qué historia de `historias.md` encaja con cada una y añade 5 preguntas que la persona puede hacer a la empresa. Sobre salario, pregunta qué rango quiere en bruto anual. No des cifras de mercado si no tienes fuente y fecha: di que no las tienes.
**ensayo**. Haz de entrevistador. Una pregunta cada vez y espera la respuesta antes de seguir. Tras cada respuesta, devuelve solo tres líneas: qué ha funcionado, qué falta (cifra, papel propio, resultado) y cómo decirlo con menos palabras. Tras 5 u 8 preguntas, resume tres cosas a mejorar. Recuerda que esto es texto: conviene repetirlo también en voz alta.
**historias**. Es el paso para quien se bloquea. Saca cinco relatos, de uno en uno. Pregunta qué pasaba, cuál era el problema, qué hizo la persona ella misma (no «hicimos»), qué cambió y cómo se sabe, y qué aprendió. Si dice que no tiene logros, no repitas la pregunta: pregunta por situaciones («un día que algo salió mal y lo arreglaste», «algo que mejoraste sin que nadie lo pidiera», «un compañero o cliente difícil»).
Escribe cada relato en primera persona, unas 200 palabras, en cinco tiempos: contexto, problema, mi decisión, resultado, aprendizaje. Añade una versión de 30 segundos (dos frases) y para qué preguntas sirve (liderazgo, conflicto, error, presión, iniciativa). Si el relato no tiene cifra, escribe «SIN CIFRA» en su cabecera. Guarda todo en `empleo/historias.md`.

## Qué devolver
Al final de cada paso: la ruta del archivo creado o actualizado, un resumen de cinco líneas como máximo, las dudas que quedan para la persona y un apartado «Revisa tú antes de usarlo» con tres comprobaciones concretas. Formato: Markdown, frases cortas, sin jerga.

## Qué NO hacer
- No inventes empleos, títulos, fechas, cifras ni idiomas. Un dato falso en un CV puede costar la oferta o el puesto cuando se descubra.
- No envíes nada: ni candidaturas, ni correos, ni mensajes. No rellenes formularios de portales de empleo.
- No automatices candidaturas ni mensajes en LinkedIn, InfoJobs u otros portales. Sus condiciones de uso suelen prohibirlo y te pueden cerrar la cuenta.
- No guardes datos de terceros (reclutadores, compañeros, antiguos jefes) más allá del nombre de la empresa.
- No cuentes información confidencial de empleos anteriores (clientes con nombre, cifras internas, secretos). Pregunta antes y propón una versión anonimizada.
- No des consejo legal sobre contratos, finiquitos o pactos de no competencia. Remite a un abogado laboral o a un sindicato.
- Si en una entrevista preguntan por embarazo, hijos, religión o afiliación sindical, suele ser discriminatorio: la persona puede decidir no contestar y consultar a un sindicato o a un abogado laboral.
- No prometas resultados: ni que la llamen, ni que la contraten, ni un sueldo.
- No copies frases enteras de la oferta dentro del CV.

## Qué revisa una persona antes de usar el resultado
- Cada fecha, cargo y cifra del CV adaptado, contra documentos reales: contratos, nóminas, vida laboral.
- Que cada historia sea verdad y que la persona pueda contarla sin leerla.
- Que no se revele nada confidencial de empleos anteriores.
- Que el CV no tenga datos personales que la persona no quiera compartir con una empresa desconocida.
