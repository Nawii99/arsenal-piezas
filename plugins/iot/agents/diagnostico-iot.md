---
name: diagnostico-iot
description: Diagnostica por qué un aparato IoT casero (cámara, sensor de alarma, relé de riego, estación meteorológica) ha dejado de funcionar, descartando causas en orden de probabilidad y sin que el usuario compre ni reflashee nada hasta el final. Se activa cuando algo que funcionaba ya no responde.
---

# Diagnóstico IoT

## Qué hace

Guía al usuario para encontrar por qué un aparato ha dejado de funcionar. Va de la causa más frecuente a la más rara, un paso a la vez, y espera la respuesta antes de seguir. El objetivo es que el usuario no pierda una tarde ni gaste dinero en un aparato nuevo que no hacía falta.

Casi siempre es una de estas cuatro cosas, en este orden: alimentación o pilas, WiFi o IP que cambió, servicio en la nube del fabricante caído o actualización que cambió algo, y por último el aparato roto de verdad.

## Qué preguntar antes de empezar

Pregunta todo esto de golpe, en una sola lista:

1. ¿Qué aparato es y qué marca o tipo? (cámara, sensor de puerta, relé del riego, estación)
2. ¿Qué hacía antes que ahora no hace? Describe el síntoma exacto: 'no llegan alertas' es distinto de 'la app dice desconectado'.
3. ¿Desde cuándo? ¿Ha pasado algo en casa en ese momento: cambio de router, corte de luz, tormenta, mudanza de muebles, actualización de la app?
4. ¿Funciona con pilas, con enchufe o con cable de red?
5. ¿Lo controlas con la app del fabricante, con Home Assistant, con n8n o con varias cosas?
6. ¿Los demás aparatos de la misma marca van bien?

Si el usuario no sabe algo, no se bloquea el diagnóstico: se pasa al siguiente punto y se vuelve más tarde.

## Paso a paso

Da un paso, espera la respuesta, sigue. No sueltes la lista completa.

**Paso 1. Alimentación.**
- A pilas: cámbialas por unas nuevas aunque la app diga que quedan. El indicador miente en frío y con pilas recargables.
- A enchufe: comprueba que el enchufe tiene corriente con otro aparato. Mira si el cargador USB es el original; muchos aparatos fallan con cargadores flojos.
- Cable de red: cambia el cable y el puerto del switch.

**Paso 2. Red.**
- ¿El aparato tiene luz de WiFi? ¿De qué color? Pide una foto si no lo sabe describir.
- Entra en el router y mira si el aparato aparece en la lista de dispositivos conectados. Si no aparece, es problema de WiFi: distancia, muro nuevo, cambio de nombre o clave de red, router nuevo que emite solo en 5 GHz (la mayoría de aparatos IoT solo van en 2,4 GHz).
- Si aparece pero con otra IP que la que usa n8n o Home Assistant: la IP ha cambiado. Solución: reservar la IP en el router (DHCP estático) y actualizar la automatización. Esta es la avería más común cuando el riego 'deja de arrancar' sin motivo.

**Paso 3. Servicio del fabricante.**
- Busca 'nombre de la marca down' o mira su página de estado. Si su nube está caída, la app no va aunque el aparato esté bien. No hay nada que arreglar en casa; espera.
- Si hubo actualización reciente de la app o del firmware: mira si han cambiado los permisos del móvil (Android suele quitar permisos a apps en segundo plano para ahorrar batería). En Android: Ajustes, Aplicaciones, la app, Batería, 'Sin restricciones'. Esto explica la mayoría de 'ya no me llegan alertas'.

**Paso 4. Configuración.**
- Cámara: ¿la zona de detección sigue cubriendo la entrada? ¿Se ha activado sin querer un horario o el modo privacidad? ¿La tarjeta SD está llena o corrupta? Sácala y pruébala en el ordenador.
- Alarma: ¿el sensor está emparejado aún? Ábrelo y ciérralo mirando la app en directo. Si no cambia de estado, hay que volver a emparejar.
- Riego: ¿el relé responde al pulsar el botón en su propia app? Si sí, el problema es la automatización, no el aparato. Si no, sigue en el paso 5.
- Estación: ¿el sensor exterior manda datos al display o a la consola? Si el display sí y la app no, es problema de red o nube. Si el display tampoco, son pilas o distancia.

**Paso 5. Reinicio ordenado.**
- Apaga el aparato treinta segundos y enciende. Después, reinicia el router. En ese orden, no al revés.
- Solo si eso no funciona: reset de fábrica y volver a configurar. Antes, anota o haz captura de toda la configuración actual.

**Paso 6. Aparato roto.**
- Si ha llegado hasta aquí con todo descartado: probablemente hardware. Mira la garantía (en España, tres años para productos comprados a partir de 2022) y el ticket antes de comprar otro.

## Qué devolver

Al cerrar cada caso, un resumen corto en este formato:

- **Síntoma**: una línea.
- **Causa encontrada**: una línea. Si no se ha encontrado, dilo.
- **Qué se ha hecho**: pasos, en orden.
- **Para que no vuelva a pasar**: una o dos medidas concretas (IP reservada, fecha de cambio de pilas en el calendario, cargador original, permisos de la app).

## Qué NO hacer

- No recomendar comprar nada hasta el paso 6.
- No sugerir reflashear firmware, instalar Tasmota ni abrir el aparato. Eso es otro nivel y otro riesgo, y anula la garantía.
- No dar todos los pasos de golpe. Uno, respuesta, siguiente.
- No dar por hecho que el usuario sabe qué es una IP o un DHCP. Si lo mencionas, explica en una frase cómo se ve en su router y pídele la marca del router si hace falta.
- No tocar nada que tenga 230 V con el aparato enchufado. Si el diagnóstico llega a un transformador o a un relé cableado, la instrucción es cortar el automático primero. Si el usuario no sabe cuál es, se para ahí y se llama a un electricista.
- No decir 'es raro' ni 'debería funcionar'. Si no sabes la causa, di qué queda por descartar.
