---
name: ia-en-local-desde-cero
description: Elige que modelo de IA cabe en el ordenador del usuario y le guia para instalarlo con Ollama o LM Studio, sin programar y sin coste de uso.
---

## Que hace

Mira que ordenador tienes, te dice que modelos te van a funcionar de verdad y te acompana en la instalacion. Todo se queda en tu equipo: ningun texto sale a internet.

## Que preguntar antes

1. Sistema: Windows, Mac (con chip M o Intel) o Linux.
2. Memoria RAM en gigas.
3. Tarjeta grafica y cuanta memoria tiene (en Windows: Administrador de tareas, pestana Rendimiento, GPU).
4. Espacio libre en disco.
5. Para que lo quieres: resumir documentos, redactar, traducir, programar o hablar con tus archivos.

## Regla rapida de que cabe

La cuenta util es esta: un modelo cuantizado a 4 bits ocupa aproximadamente la mitad de gigas que miles de millones de parametros tiene. Un modelo de 8B ocupa unos 5 GB, uno de 14B unos 9 GB, uno de 32B unos 20 GB.

- 8 GB de RAM y sin grafica dedicada: modelos de 3B o 4B. Van lentos pero valen para resumir.
- 16 GB de RAM: modelos de 7B u 8B. Es el punto dulce para la mayoria.
- Mac con chip M y 16 GB: 8B comodo, 14B justo.
- Grafica con 8 GB de memoria: 8B rapido.
- Grafica con 24 GB o 64 GB de RAM: hasta 32B.

Si el modelo no cabe en la grafica, tira de RAM y va mucho mas lento, pero funciona.

## Paso a paso

1. Elige programa. LM Studio si quieres ventanas y botones. Ollama si te apanas con escribir una linea en la terminal y quieres conectarlo luego a n8n.
2. Descargalo de la web oficial (ollama.com o lmstudio.ai). Ambos gratis, sin cuenta obligatoria.
3. Descarga un modelo. Para empezar en espanol funciona bien un modelo de 8B de instrucciones en formato cuantizado Q4.
4. Haz una prueba tonta: pidele un resumen de un texto de dos folios y cuenta cuanto tarda.
5. Si tarda mas de un minuto en responder, baja de tamano de modelo o de nivel de cuantizacion.
6. Si te convence, dejalo como servicio en segundo plano y conecta n8n a la direccion local que te indique el programa.

## Que devolver al usuario

- Dos modelos concretos recomendados para su equipo, con el tamano en gigas.
- Los comandos o clics exactos para instalarlos.
- Una prueba de aceptacion: que le pida y que tiempo de respuesta es aceptable.

## Que NO hacer

- No le recomiendes un modelo que no le quepa: se quedara colgado y pensara que la IA local no sirve.
- No prometas que un modelo de 8B rinde como los modelos grandes de pago. Es peor razonando y se inventa mas cosas.
- No le digas que desactive el antivirus ni que descargue modelos de sitios que no sean las webs oficiales o Hugging Face.

## Coste y limites

Coste de uso: cero. Coste real: electricidad, unos 20-40 GB de disco y que el ordenador se caliente. Si lo que buscas es calidad maxima, un modelo local pequeno no la da; para documentos privados, aun asi compensa.
