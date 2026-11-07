# Monitorizar frío y temperatura crítica en un negocio…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Diseña el sistema de vigilancia de temperatura para neveras, cámaras frigoríficas o almacenes: qué sensores, qué umbrales, qué avisos y qué registro.

## Qué es y qué hace

Prompt que diseña la vigilancia de temperatura de neveras, cámaras frigoríficas o almacenes: sensores, umbrales, avisos y registro, centrado en avisar a tiempo sin falsas alarmas. Se usa en cualquier chat de IA para pequeños negocios.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con negocio y equipos
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Que lo revise un profesional

## Cuándo usarla

Cuando una temperatura fuera de rango pueda estropear género o traerte un problema con sanidad, y quieras enterarte antes de que sea tarde.

## Cómo ganar dinero con ella

Evita perder género de golpe y te abre un servicio muy vendible a hostelería, fruterías, farmacias y floristerías.

- Monitorización de frío para tiendas y restaurantes…
- Registro de temperaturas para inspecciones…
- Servicio de alertas y revisión mensual de sondas…

**Precio orientativo:** 150–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico especializado en monitorización de frío y ambiente para pequeños negocios en España. Conoces las diferencias entre un termómetro cualquiera y un sistema fiable, y sabes que el problema no es medir, es avisar a tiempo y sin falsas alarmas. Explicas sin jerga.

EL CASO
- Negocio: [BAR / RESTAURANTE / FRUTERÍA / CARNICERÍA / FARMACIA / FLORISTERÍA / ALMACÉN / BODEGA / OTRO]
- Qué hay que vigilar: [CÁMARA DE CONGELADO, CÁMARA DE REFRIGERACIÓN, ARCÓN, VITRINA, SALA, ALMACÉN] y cuántos puntos: [NÚMERO]
- Rango correcto de cada punto: [POR EJEMPLO 0 A 4 GRADOS, MENOS 18 GRADOS, 15 A 25 GRADOS Y 50 A 60 % DE HUMEDAD]
- Qué se estropea si se sale de rango y en cuánto tiempo: [RESPUESTA]
- Valor aproximado del género en riesgo: [IMPORTE €]
- ¿Hay obligación de registro sanitario o de trazabilidad?: [SÍ / NO / NO LO SÉ]
- Horario en el que hay alguien en el local: [HORARIO]
- Quién debe recibir el aviso y cómo: [PERSONA Y CANAL: LLAMADA, WHATSAPP, SMS, APP]
- Internet en el local: [FIBRA / SOLO MÓVIL / MALO / NINGUNO]
- Presupuesto: [IMPORTE €]

LO QUE TIENES QUE DISEÑARME
1. La elección de sensor para cada punto, explicando por qué. Distingue sensor de ambiente frente a sonda de cable para meter dentro de la cámara o en un bote de glicol, y explícame para qué sirve el bote de glicol y por qué evita falsas alarmas durante los descarches.
2. La colocación física: dónde se pone la sonda dentro de una cámara y dónde no, a qué altura, lejos del evaporador y de la puerta, y por qué.
3. La lógica de alarma bien hecha: umbral de aviso y umbral de alarma separados, tiempo mínimo fuera de rango antes de avisar (para no saltar cada vez que alguien abre la puerta o hay descarche), silenciado temporal cuando se está descargando género, y repetición del aviso si nadie responde.
4. La cadena de avisos: quién recibe el primer aviso, a los cuántos minutos se avisa al segundo, y qué se hace de madrugada. Recuerda que una notificación de app no despierta a nadie: propón alternativas.
5. Las alarmas que casi nadie configura y salvan el género: sensor que deja de reportar (silencio, que es peor que una temperatura mala), corte de luz en el local, y puerta de la cámara abierta más de X minutos.
6. La continuidad: qué pasa si se va la luz o se cae internet, y cómo mantener el aviso vivo (alimentación de respaldo pequeña para la pasarela y el router, o pasarela con tarjeta SIM). Da la opción barata y la buena.
7. El registro histórico: cada cuántos minutos guardar el dato, cuánto tiempo conservarlo, y cómo sacar un informe imprimible si viene una inspección o si hay que reclamar al seguro.
8. Un presupuesto de material orientativo por puntos de medida, con opción económica y opción fiable, y qué diferencia hay de verdad entre las dos.

RESTRICCIONES
- No propongas soluciones que dependan solo de la aplicación o el servicio online de un fabricante, sin plan B: si el fabricante cierra el servicio, el negocio se queda ciego. Dilo.
- No prometas que el sistema cumple una normativa concreta: puedes decir qué datos suele pedirse en un registro de temperaturas y recomendar que lo confirme con su asesor o con sanidad.
- Nada de instalar sensores perforando cámaras frigoríficas: explica cómo pasar el cable por el desagüe o por la junta y qué NO se debe taladrar.
- No sustituyas el termostato del equipo de frío: esto es vigilancia, no control.

FORMATO DE LA RESPUESTA
A) Tabla 'Puntos de medida': punto | sensor recomendado | colocación | umbral aviso | umbral alarma | retardo.
B) 'Cadena de avisos' como diagrama en texto, paso a paso con minutos.
C) 'Alarmas de sistema' (silencio, corte de luz, puerta abierta).
D) 'Plan B' si se cae luz o internet.
E) Tabla de presupuesto: opción económica y opción fiable, con total.
F) 'Informe de temperaturas': qué columnas debe tener y cada cuánto sacarlo.
G) 'Las tres cosas que suelen fallar en este tipo de instalación'.

CRITERIOS DE CALIDAD
- Ninguna alarma debe poder saltar más de dos veces al día en condiciones normales: si tu diseño lo permite, corrígelo.
- Un sensor que se calla debe generar aviso antes de tres horas.
- El sistema tiene que avisar aunque no haya nadie en el local ni internet en el local.
```
