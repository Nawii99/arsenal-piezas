# Diagnóstico de red Zigbee o Z-Wave inestable…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Un análisis ordenado de por qué se caen o responden tarde los dispositivos inalámbricos de una instalación domótica, y qué cambiar en qué orden.

## Qué es y qué hace

Prompt que analiza por qué se caen o responden tarde los dispositivos Zigbee y Z-Wave: topología, interferencias, alimentación y firmware. Devuelve qué cambiar y en qué orden, explicado para no técnicos. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con red y dispositivos
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Aplica los cambios en el orden dado

## Cuándo usarla

Úsalo cuando bombillas, sensores o enchufes de una instalación se desconecten, tarden en responder o aparezcan como no disponibles.

## Cómo ganar dinero con ella

Convierte una avería que te haría volver gratis a casa del cliente en una visita diagnosticada y resuelta a la primera, y evita que devuelvan material que funcionaba.

- Reparación de redes malladas Zigbee y Z-Wave…
- Optimización de topología en viviendas y locales…
- Soporte remoto de domótica por suscripción…

**Precio orientativo:** 40–130 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como instalador de domótica con años de experiencia depurando redes Zigbee y Z-Wave en viviendas y locales reales. Sabes que casi ningún problema es del dispositivo: casi siempre es topología, interferencia, alimentación o firmware. Explicas las cosas a alguien que no es técnico.

CONTEXTO DE LA INSTALACIÓN
- Tecnología: [ZIGBEE / Z-WAVE / MATTER SOBRE THREAD / MEZCLA]
- Coordinador o pasarela: [MODELO EXACTO, POR EJEMPLO SONOFF ZBDONGLE-E, SKYCONNECT, CONBEE II, HUB DE MARCA]
- Software que lo gobierna: [HOME ASSISTANT + ZIGBEE2MQTT / ZHA / APP DE MARCA / OTRO]
- Dónde está físicamente el coordinador: [DESCRIPCIÓN: DENTRO DEL ARMARIO DEL ROUTER, PEGADO AL NAS, EN UN USB DEL MINIPC, ETC.]
- Número de dispositivos: [CUÁNTOS] de los cuales a corriente: [CUÁNTOS] y a pilas: [CUÁNTOS]
- Marcas y modelos mezclados: [LISTA]
- Superficie y plantas: [M2 Y NÚMERO DE PLANTAS], materiales de las paredes: [LADRILLO / PLADUR / HORMIGÓN / METAL]
- Síntoma exacto: [DESCRIPCIÓN: QUÉ DISPOSITIVOS FALLAN, A QUÉ HORA, CADA CUÁNTO, SI SE RECUPERAN SOLOS]
- Desde cuándo pasa y qué cambió antes: [RESPUESTA]
- Canal Zigbee actual si lo sabes: [NÚMERO], canales WiFi de mis routers: [NÚMEROS]

MÉTODO QUE DEBES SEGUIR
1. Clasifica el síntoma en una de estas familias y justifícalo: (a) dispositivo concreto que se cae, (b) zona entera que se cae, (q) toda la red que se cae a la vez, (d) lentitud generalizada, (e) fallos a horas concretas.
2. Descarta primero lo barato: distancia física entre coordinador y router WiFi, coordinador pinchado directamente al ordenador sin alargador USB, coordinador dentro de un armario metálico o pegado a un disco duro o a un cargador.
3. Analiza la interferencia con WiFi de 2,4 GHz. Explica en cristiano cómo se solapan los canales Zigbee con los WiFi, qué combinaciones son sanas y cuáles chocan, y dime qué canal debería usar según los canales WiFi que te he dado. Ten en cuenta también los routers de los vecinos.
4. Analiza la topología: cuenta cuántos dispositivos a corriente hacen de repetidor y si están bien repartidos por la casa. Señala si tengo zonas sin ningún repetidor intermedio.
5. Señala los repetidores conocidos por portarse mal (bombillas antiguas de algunas marcas, enchufes con firmware viejo) y qué hacer con ellos.
6. Revisa la alimentación: fuentes de 5 V flojas, alargadores USB de mala calidad, pasarelas alimentadas desde el puerto de un router.
7. Da un plan de acción numerado, ordenado de menos esfuerzo y coste a más, con el efecto esperado de cada paso y cómo comprobar si ha funcionado.
8. Termina con el orden correcto de emparejamiento cuando haya que reconstruir la red: primero los dispositivos a corriente cerca de su sitio definitivo, luego los de pilas, y por qué no se emparejan al lado del coordinador para luego moverlos.

RESTRICCIONES
- No me digas 'reinicia y prueba' como solución. Cada paso debe tener una causa detrás.
- No propongas cambiar de marca o de sistema entero salvo que expliques por qué lo demás no puede funcionar.
- Si cambiar de canal Zigbee implica volver a emparejar los dispositivos, avísame del coste en tiempo antes de recomendarlo.
- Si un paso puede dejar la instalación peor durante un rato, dilo y dime cuánto puede durar.

FORMATO DE LA RESPUESTA
1) 'Diagnóstico probable' en tres líneas, con un porcentaje de confianza y qué dato me falta para subirlo.
2) Tabla 'Causas candidatas': causa | señales que la apoyan | señales que la descartan | cómo comprobarla en 5 minutos.
3) 'Plan de acción' numerado: paso | qué hago | cuánto tardo | qué debo ver si ha funcionado.
4) 'Mapa de repetidores': cuántos hay, dónde faltan y qué compraría (tipo de dispositivo, no marca cara).
5) 'Errores típicos que no debo cometer': lista corta.
6) 'Si nada de esto funciona': los dos o tres siguientes pasos, incluyendo qué registro o log mirar y qué buscar en él.

CRITERIOS DE CALIDAD
- El plan tiene que empezar por algo que pueda hacer hoy y sin gastar dinero.
- Cada recomendación de canal o de posición debe explicar el porqué en una frase entendible.
- No des por buena la red hasta que el síntoma original haya dejado de aparecer durante al menos 48 horas: dilo así en el plan.
```
