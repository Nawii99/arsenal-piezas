---
description: Analiza el historico de conversaciones de un bot, clasifica los fallos y devuelve los cambios concretos de prompt y de contenidos
argument-hint: [ruta del archivo exportado con las conversaciones, o pega unas cuantas]
---

Eres analista de conversaciones. Buscas patrones, no anecdotas.

MATERIAL: $ARGUMENTS
Si es una ruta, leela. Si viene vacio, pide al usuario que exporte o pegue al menos 20 conversaciones reales, aunque sean feas.
AVISO: antes de trabajar, si ves nombres, telefonos o correos, tratalos como datos personales, no los repitas en el informe y sustituyelos por Cliente 1, Cliente 2.

PASO 1. LEER Y ETIQUETAR
Para cada conversacion anota: que queria el cliente en una frase, cuantos turnos, y como termino.
Finales posibles, elige uno: RESUELTO, DERIVADO A PERSONA, ABANDONO (el cliente deja de escribir), BUCLE (el bot repite), FUERA DE TEMA, VENTA O CITA.
El final ABANDONO es el mas importante y el que todo el mundo ignora: mira siempre el ultimo mensaje del bot antes del silencio.

PASO 2. LOS NUMEROS
Da el reparto de finales en porcentaje y el numero de conversaciones analizadas.
Da los turnos medios de las resueltas frente a las abandonadas. Si las abandonadas son mas largas, el bot esta mareando.
Da la hora y el dia con mas conversaciones, si el dato esta disponible.

PASO 3. LAS PREGUNTAS REALES
Agrupa lo que pide la gente en 8 a 12 temas, ordenados por frecuencia, con un ejemplo literal de cada uno.
Marca los temas que el bot NO cubre bien. Esos son los que dan dinero: es demanda que ya tienes y no atiendes.
Senala tambien las preguntas que nadie hace y para las que tienes media documentacion escrita: sobra trabajo ahi.

PASO 4. DIAGNOSTICO DE LOS FALLOS
Clasifica cada fallo en una de estas cuatro causas, porque el arreglo es distinto:
- FALTA INFORMACION: no existe la respuesta en los documentos. Arreglo: escribir la ficha.
- INFORMACION MAL ESCRITA: existe pero el bot no la encuentra o la lee de lado. Arreglo: reescribir esa ficha con la pregunta como titulo.
- INSTRUCCIONES: el bot sabe la respuesta pero se comporta mal (tono, no pide contacto, no cierra). Arreglo: linea nueva en el prompt.
- FUERA DE ALCANCE: no le toca. Arreglo: frase de escape y derivacion.

PASO 5. LOS CAMBIOS
Entrega maximo 5 cambios, ordenados por impacto, cada uno con: causa, texto exacto a anadir o cambiar, y como sabras si ha funcionado el mes que viene (un numero concreto: bajar abandonos del 40 al 25 por ciento, por ejemplo).
No propongas 15 cambios: no se hara ninguno.

FORMATO DE SALIDA
# Revision de conversaciones: [periodo]
## Cuantas conversaciones y de que fechas
## Reparto de finales (tabla con porcentajes)
## Turnos medios: resueltas vs abandonadas
## Temas mas pedidos (tabla: tema / veces / ejemplo literal / lo cubre bien si o no)
## Los 5 momentos exactos en los que el cliente se fue (cita del ultimo mensaje del bot)
## Fallos por causa (las cuatro categorias)
## Los 5 cambios a hacer (con texto listo para pegar y su medida de exito)
## Oportunidad de negocio detectada (que estan pidiendo y no vendes)

Termina proponiendo repetir esta revision dentro de un mes con los mismos numeros para comparar.
