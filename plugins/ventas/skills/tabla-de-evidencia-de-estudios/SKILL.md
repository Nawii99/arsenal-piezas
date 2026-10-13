---
name: tabla-de-evidencia-de-estudios
description: Busca estudios científicos sobre una pregunta concreta, extrae sus datos clave en una tabla con la fuente de cada cifra y separa lo que se puede afirmar de lo que no. Úsala cuando pidan revisar literatura científica, estudios médicos o evidencia para un informe o un argumento de venta.
---

# Tabla de evidencia de estudios científicos

## Qué hace
Convierte una pregunta («¿funciona X para Y?») en una tabla de estudios con sus cifras, su calidad y una conclusión prudente.
Es un borrador de trabajo para ahorrarte horas de lectura. No es un dictamen médico ni una revisión sistemática formal.
Esto toca salud. Una persona con formación (médico, farmacéutico, nutricionista, investigador o bioestadístico) lo revisa antes de usarlo en un anuncio, una web, un informe a cliente o cualquier decisión.
Coste: leer muchos PDF gasta bastante de tu límite de uso en Claude. Empieza con [10-15] estudios y amplía si hace falta.

## Qué preguntar antes de empezar
Haz todas las preguntas juntas, en una lista corta, y espera la respuesta. Si falta algo, sigue con lo que haya y marca el hueco.
1. La pregunta exacta, en una frase. Si es vaga, ayuda a concretarla: quién (población), qué se hace o qué producto (intervención), con qué se compara y qué resultado se mide.
2. Para qué se usará: decisión interna, informe, texto de venta o publicidad. Cuanto más público el uso, más rigor y más revisión humana.
3. Años y idiomas a cubrir. Si no dice nada, propón los últimos [10] años en español e inglés y pide confirmación.
4. De dónde salen los estudios: PDF en una carpeta del proyecto, un servidor MCP de PubMed si lo tienes conectado, o búsqueda en web.
5. Máximo de estudios a incluir: [NÚMERO].
6. Qué conclusión espera el cliente. Anótalo solo para vigilar tu propio sesgo. No orientes la búsqueda hacia ella.

## Paso a paso
1. Reformula la pregunta y escribe los criterios de inclusión y exclusión (tipo de estudio, población, años, idioma). Pide el visto bueno del usuario antes de buscar.
2. Busca. Orden de preferencia: servidor MCP de PubMed si existe; si no, PubMed y Europe PMC (ambos gratuitos) y Cochrane para revisiones. Apunta las palabras de búsqueda, las fuentes y la fecha para poder repetirla.
3. Criba en dos pasadas: primero título y resumen, después texto completo. Anota cuántos descartas y por qué.
4. Extrae de cada estudio estos campos, siempre los mismos: cita completa, DOI o PMID, año, tipo de estudio, número de participantes, intervención, comparador, duración, resultado principal con su cifra y su unidad, intervalo de confianza o valor p, financiación y conflictos de interés, limitaciones.
5. Junto a cada cifra importante, copia la frase literal del artículo que la respalda y su página o tabla.
6. Clasifica el tipo de estudio, de más a menos sólido como orientación: revisión sistemática o metaanálisis, ensayo aleatorizado, estudio de cohortes, casos y controles, serie de casos, estudio en animales o en laboratorio, opinión. Es una guía, no una nota.
7. Marca las señales de alerta: artículo retractado (compruébalo en PubMed o en la base de Retraction Watch), preprint sin revisión por pares, muestra pequeña, financiado por quien vende el producto, resultado principal distinto del anunciado, efecto solo en un subgrupo, estudio en animales presentado como si fuera en personas.
8. Segunda pasada de verificación, mejor con un subagente revisor (pídele a Claude Code: «usa un subagente para comprobar cada cifra contra el texto original»). Etiqueta cada dato: verificado en texto completo, solo visto en el resumen, o no localizado.
9. Redacta la conclusión en tres columnas: se puede decir, se puede decir con cautela, no se puede decir.

## Qué devolver y con qué formato
- Resumen de 5 a 8 líneas en lenguaje llano.
- Tabla en Markdown con los estudios y, aparte, el mismo contenido en un CSV con punto y coma como separador para que Excel en español lo abra bien.
- Lista de estudios descartados con el motivo.
- La búsqueda realizada: términos, fuentes y fecha.
- Las tres columnas de conclusión (se puede decir, con cautela, no se puede decir).
- Preguntas abiertas para la persona que revise.

## Qué revisa una persona antes de usar el resultado
- Que las cifras importantes coinciden con el artículo original. Claude puede leer mal una tabla.
- Que la conclusión no va más allá de lo que dicen los estudios.
- Que el texto final cumple la normativa de publicidad sanitaria y de declaraciones de salud. Consúltalo con un asesor regulatorio o legal si va a ser público: [ASESOR].
- Que ninguna decisión sobre una persona concreta se toma con esta tabla. Eso lo decide un profesional sanitario.

## Qué NO hacer
- No inventes estudios, autores, DOI ni cifras. Si no localizas algo, escribe «no localizado».
- No cites un estudio que solo has visto por el título.
- No saltes muros de pago ni uses webs piratas de PDF. Si no tienes el texto completo, trabaja con el resumen y dilo.
- No des consejos médicos a personas ni interpretes casos concretos.
- No conviertas «asociación» en «causa» ni «en ratones» en «en personas».
- No mezcles dosis, poblaciones o duraciones distintas como si fueran lo mismo.
- No dejes fuera los estudios que contradicen la conclusión deseada.
- No redactes frases de venta con «cura», «previene» o «trata» sin revisión.
- No pegues datos de pacientes. Los datos de salud son categoría especial en el RGPD.
- No uses nombres ni correos de autores de los estudios para mandar emails comerciales sin base legal (RGPD y LSSI).

## Dónde guardarla
Guarda este archivo como `.claude/skills/tabla-de-evidencia-de-estudios/SKILL.md` en la carpeta de tu proyecto. Claude la usa cuando le pides algo parecido, o la llamas escribiendo `/tabla-de-evidencia-de-estudios`.
Texto revisado en octubre de 2026. Las herramientas y las normas cambian: comprueba lo que dependa de ellas.
