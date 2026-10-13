---
name: revision-contrato-colaboracion
description: Revisa un contrato de servicios o colaboración (mercantil, entre autónomo/empresa y cliente) y devuelve un informe de cláusulas con nivel de riesgo, preguntas para el abogado y propuestas de redacción alternativa. Se activa cuando el usuario pega o adjunta un contrato y pide revisarlo.
---

## Qué hace

Lee un contrato de colaboración o de prestación de servicios y devuelve un informe ordenado por cláusulas: qué dice cada una en lenguaje llano, qué riesgo tiene para tu cliente y qué redacción alternativa proponer. El informe está pensado para entregarse tal cual a un tercero, así que tiene que poder leerlo alguien sin formación jurídica.

Esto NO sustituye a un abogado. El informe siempre termina recomendando revisión profesional para importes altos o cláusulas de responsabilidad. Dilo así en el propio informe, no lo escondas.

## Qué preguntar antes de empezar

1. ¿Quién es tu cliente en este contrato: el que presta el servicio o el que lo contrata? El informe cambia por completo según el lado.
2. ¿Qué importe mueve el contrato y con qué duración? Un contrato de 500 euros no se revisa igual que uno de 30.000.
3. ¿Hay algo que ya le preocupe? (pagos, exclusividad, propiedad de lo entregado, penalizaciones).
4. ¿Las dos partes son españolas? Si hay una parte extranjera, marca la cláusula de ley aplicable y jurisdicción como punto crítico.

## Paso a paso

1. Lee el contrato entero antes de escribir nada. Si faltan páginas o anexos, dilo y para.
2. Comprueba primero si es realmente mercantil. Si el contrato fija horario, herramientas del cliente, exclusividad total y órdenes directas, avisa de riesgo de falso autónomo: en España eso puede acabar en Inspección de Trabajo con recargos para el que contrata. Esto va al principio del informe.
3. Revisa una a una estas cláusulas, que son las que dan problemas: objeto y alcance (¿está cerrado qué se entrega o es una puerta abierta?), plazos de pago (en España el tope legal entre empresas es 60 días), penalizaciones y qué pasa si el cliente se retrasa él, propiedad intelectual de lo entregado, confidencialidad y su duración, exclusividad y no competencia, causas y preaviso de terminación, responsabilidad y su límite, ley aplicable y jurisdicción.
4. Para cada cláusula asigna un nivel: verde (estándar, sin problema), ámbar (negociable, propón cambio) o rojo (no firmar sin cambiarla o sin consultar abogado).
5. Comprueba lo que NO está: si falta cláusula de pagos parciales, de revisión de alcance o de qué pasa con el trabajo hecho si se rompe el contrato, señálalo como ausencia, que pesa tanto como una cláusula mala.
6. Para cada ámbar o rojo, escribe una redacción alternativa concreta que el cliente pueda proponer copiando y pegando.

## Qué devolver y en qué formato

Un informe en Markdown con: resumen de tres líneas arriba del todo (¿se puede firmar sí, no, o sí con cambios?), tabla de cláusulas con su nivel verde/ámbar/rojo, detalle de cada ámbar y rojo con la redacción alternativa, lista de ausencias, y un cierre con las preguntas exactas que llevarle a un abogado si el importe lo justifica.

## Qué NO hacer

- No cites artículos de leyes ni sentencias de memoria. Si no puedes verificar la norma exacta, escribe [verificar norma] y describe el riesgo en lenguaje llano.
- No revises contratos laborales (nóminas, despidos, convenios): di que eso necesita un laboralista y no sigas.
- No digas nunca que el contrato es válido o que no hay riesgo. Di qué has encontrado y qué recomendarías cambiar.
- No reescribas el contrato entero: propones cláusulas alternativas puntuales, no un contrato nuevo.
- No te inventes importes, plazos ni datos de las partes que no estén en el texto.
