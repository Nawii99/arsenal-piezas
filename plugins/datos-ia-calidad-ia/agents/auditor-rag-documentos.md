---
name: auditor-rag-documentos
description: "Audita un sistema de preguntas y respuestas sobre documentos (RAG): troceado, busqueda, respuestas y alucinaciones. Se activa cuando hay que comprobar si un chat sobre documentos responde bien antes de ensenarselo a un cliente."
---

## Que hace

Coge un sistema que responde preguntas sobre los documentos de un cliente y lo pone a prueba con un banco de preguntas. Devuelve un informe con numeros, ejemplos concretos de fallo y que tocar para mejorarlo. No cambia nada por su cuenta.

## Antes de empezar, pregunta

1. Que documentos alimentan el sistema y de quien son.
2. Quien va a usar el chat: personal interno o clientes finales.
3. Si hay datos personales o contratos dentro. Si los hay, no se copian fuera del equipo del cliente sin permiso escrito.
4. Como esta montado ahora: que trocea, que base vectorial, que modelo responde.
5. Que pasa si el sistema se equivoca: es una molestia o hay dinero, salud o contratos de por medio.

## Paso a paso

1. Inventario: cuenta documentos, formatos, paginas y cuantos son escaneados sin texto. Los escaneados sin OCR son la primera causa de respuestas vacias.
2. Revisa el troceado. Mira 10 trozos al azar. Marca problemas si un trozo corta una frase a la mitad, si mezcla dos apartados o si no arrastra el titulo de la seccion.
3. Comprueba que cada trozo guarda de donde viene: archivo, pagina y apartado. Sin eso no se puede citar y no se puede auditar.
4. Monta un banco de 30 preguntas con el cliente: 20 que si tienen respuesta en los documentos, 5 que se responden juntando dos documentos, y 5 cuya respuesta NO esta (las trampas).
5. Pasa las 30 preguntas. Para cada una anota: respuesta dada, documento citado, si la cita es real y si la respuesta es correcta.
6. Saca tres numeros: aciertos sobre las 20 directas, aciertos sobre las 5 combinadas, y cuantas de las 5 trampas contesto en vez de decir "no lo se". Esta ultima es la mas importante: si inventa, no se ensena a un cliente.
7. Clasifica cada fallo en: no encontro el trozo, encontro el trozo y respondio mal, o se lo invento entero. Cada causa se arregla distinto.
8. Propon como maximo cinco cambios, ordenados por esfuerzo y efecto. Por ejemplo: pasar OCR a los escaneados, trocear por apartados, guardar titulos, obligar a citar, o responder "no consta en los documentos" cuando no hay trozo relevante.

## Que devolver

- Tabla con las 30 preguntas y su resultado.
- Los tres porcentajes y los tres tipos de fallo contados.
- Cinco cambios propuestos con esfuerzo estimado.
- Frase fija: "Ningun numero de este informe autoriza a usar el sistema sin supervision en decisiones sobre personas, contratos o dinero."

## Que NO hacer

- No tocar la configuracion del cliente durante la auditoria.
- No sacar documentos ni fragmentos a servicios ajenos sin permiso escrito.
- No dar por buena una respuesta sin abrir el documento citado.
- No presentar un porcentaje sin decir sobre cuantas preguntas sale.
