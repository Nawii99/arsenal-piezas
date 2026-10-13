---
name: modelo-local-que-cabe
description: Calcula que modelo de IA puede ejecutar el equipo del usuario en local y lo deja instalado y probado. Se activa al hablar de Ollama, LM Studio, llama.cpp, cuantizacion, IA sin internet o IA privada.
---

# Que modelo de IA cabe en tu ordenador

## Que hace
Traduce las caracteristicas de tu equipo a una recomendacion concreta de modelo y cuantizacion, y te deja una prueba hecha para que veas la velocidad real antes de casarte con nada.

## Que preguntar antes
1. Sistema: Windows, Mac con chip Apple, Mac Intel o Linux.
2. Tarjeta grafica y su memoria dedicada. En Windows: Administrador de tareas, pestana Rendimiento, GPU. En Mac con chip Apple la memoria es compartida con el sistema.
3. Memoria RAM total.
4. Para que lo quieres: resumir, responder sobre documentos, escribir textos, programar o traducir. Cambia la eleccion.
5. Cuanto puedes esperar por respuesta: segundos o te da igual un minuto.

## Paso a paso
1. Calcula el presupuesto de memoria. Regla aproximada: un modelo cuantizado a 4 bits ocupa unos 0,6 GB por cada mil millones de parametros, mas 1 o 2 GB para el contexto. Un modelo de 8B en Q4 pide unos 6 GB; uno de 14B, unos 10 GB.
2. Reserva margen. Si el modelo entra justo en la grafica, parte se va a la RAM y la velocidad se hunde. Deja 2 GB libres.
3. Elige tamano antes que marca. Un modelo pequeno bien elegido y rapido se usa; uno grande que tarda dos minutos se abandona a la semana.
4. Elige cuantizacion. Q4_K_M es el equilibrio sensato para casi todo el mundo. Q8 solo si te sobra memoria. Q2 degrada tanto que no compensa: ese es el error clasico de querer meter un modelo enorme a la fuerza.
5. Instala Ollama si te apanas con la terminal, o LM Studio si prefieres ventanas y botones. Los dos son gratis.
6. Prueba con TUS textos, no con adivinanzas. Pasa tres documentos reales y tres preguntas reales.
7. Mide dos cosas: segundos hasta la primera palabra y si la respuesta sirve. Apuntalo.
8. Si va lento: baja de tamano antes que bajar de cuantizacion. Si responde mal: sube de tamano antes que cambiar de marca.
9. Ajusta la ventana de contexto. Ponerla al maximo consume memoria y ralentiza todo aunque no la uses. 8k basta para la mayoria de tareas.

## Que devolver
- Modelo y cuantizacion recomendados, con el tamano en GB.
- Un segundo modelo de reserva, mas pequeno.
- El comando o los pasos exactos de instalacion.
- Los tiempos medidos en la prueba.
- Que tareas NO conviene hacer en local con ese equipo.

## Limites
- La IA local es mas privada, no es mejor. Un modelo de 8B en tu portatil no rinde como los grandes de pago. Si alguien te vende lo contrario, miente.
- Sin internet, sin datos actualizados: responde con lo que aprendio, no con lo de hoy.
- Ventaja real: documentos con datos personales que no pueden salir de tu equipo. Ese es el caso que justifica el esfuerzo.

## Que NO hacer
- No bajes cinco modelos de 20 GB antes de medir nada.
- No copies la configuracion de un video sin mirar tu memoria.
- No uses el modelo local para decidir sobre una persona sin que alguien lo revise.
