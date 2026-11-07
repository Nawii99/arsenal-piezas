---
name: cuaderno-de-traspaso
description: Guarda en un archivo el estado de un proyecto o negocio (decidido, descartado, hipótesis, datos y próximos pasos) al cerrar una sesión, y lo lee al abrir la siguiente. Úsala al terminar de trabajar o cuando digas «guarda el estado», «retomamos lo de ayer» o «dónde lo dejamos».
---
# Cuaderno de traspaso entre sesiones

Claude no recuerda las conversaciones anteriores. Este cuaderno hace de memoria: un archivo de texto en tu carpeta que se escribe al terminar y se lee al empezar.

## Qué hace
- Modo GUARDAR: resume la sesión de hoy y actualiza el archivo `ESTADO.md`.
- Modo RETOMAR: lee `ESTADO.md` y te dice dónde estáis antes de tocar nada.
- Distingue lo que has decidido tú de lo que ha propuesto la IA.

## Pregunta antes de empezar
1. ¿Guardar o retomar?
2. ¿Qué proyecto o cliente es? Un archivo por proyecto o cliente, nunca mezclados.
3. ¿Dónde está el archivo o dónde lo creo? Por defecto, `ESTADO.md` en la carpeta del proyecto.
4. ¿Hay algo que no deba quedar escrito? Siempre quedan fuera contraseñas, claves, datos bancarios, DNI y datos personales de clientes.

## Estructura del archivo
```
# Estado de [PROYECTO]
Última actualización: [FECHA COMPLETA]
## Contexto (máximo 5 líneas)
## Decidido
## Descartado y por qué
## Hipótesis por comprobar
## Datos con fuente
## Próximos pasos (qué, quién, para cuándo)
## Preguntas abiertas
## Registro de sesiones
```
Cada línea lleva una etiqueta de origen: [DECIDIDO POR TI], [DATO: fuente y fecha], [SUPOSICIÓN] o [IDEA DE LA IA SIN VALIDAR].

## Modo GUARDAR, paso a paso
1. Lee `ESTADO.md` si existe. Si no existe, avisa y propón crearlo.
2. Repasa la conversación de hoy y saca: lo decidido, lo descartado (con el motivo), datos nuevos con su fuente, hipótesis, tareas pendientes y dudas.
3. Si no tienes claro si algo lo decidió la persona o lo propuso la IA, pregunta. Por defecto va como [IDEA DE LA IA SIN VALIDAR].
4. Enseña los cambios en tres listas: se añade, se cambia, se mueve a descartado. Espera un «vale».
5. Copia la versión anterior a `historico/ESTADO-[FECHA].md` antes de escribir.
6. Escribe los cambios y añade una línea al registro de sesiones con la fecha.
7. Relee el archivo buscando contraseñas, claves, IBAN, DNI, teléfonos o correos de clientes. Si hay alguno, quítalo y avisa.
8. Cambia las fechas relativas («mañana», «la semana que viene») por fechas completas.

## Modo RETOMAR, paso a paso
1. Lee `ESTADO.md` entero.
2. Resume en ocho líneas como máximo: dónde estáis, lo último decidido, los tres próximos pasos y las hipótesis abiertas.
3. Si la última actualización tiene más de 30 días, avisa de que los datos pueden estar desfasados.
4. Pregunta: «¿Sigue siendo esto cierto?». No trabajes hasta que la persona responda.

## Qué devuelves
- En GUARDAR: la lista de cambios aplicados, la ruta del archivo y las tres primeras tareas de la próxima sesión.
- En RETOMAR: el resumen de ocho líneas y la pregunta de confirmación.

## Qué NO hacer
- No guardes contraseñas, claves de acceso, datos bancarios ni datos personales de clientes. Anota dónde están («en el gestor de contraseñas»), no qué contienen. El RGPD protege esos datos.
- No borres entradas antiguas. Si algo ya no vale, muévelo a «Descartado y por qué».
- No conviertas una idea de la IA en una decisión. Solo es decisión si la persona lo ha dicho.
- No resumas tanto que se pierda el motivo de cada decisión.
- No mezcles dos clientes o dos proyectos en el mismo archivo.
- No escribas nada sin enseñar antes los cambios.
- No dejes el archivo en una carpeta compartida con terceros sin avisar.

## Cuándo pedir a una persona
- Si el archivo recoge decisiones legales, fiscales o laborales, quien las tomó (tu gestor, tu abogado) confirma que están bien anotadas.
- Antes de decidir dinero con un dato del cuaderno, comprueba tú la fuente. Un dato de hace meses puede haber cambiado.
- Si compartes el cuaderno con un cliente o un socio, léelo entero antes.

## Dónde guardarla (solo la primera vez)
Guarda este texto como `SKILL.md` dentro de `.claude/skills/cuaderno-de-traspaso/`. Para que Claude lea el cuaderno al empezar, añade al archivo `CLAUDE.md` de tu proyecto esta línea: Al empezar, lee ESTADO.md y resúmelo.
