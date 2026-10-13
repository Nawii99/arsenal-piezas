# Sensorizar una máquina antigua de taller…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Prompt que diseña cómo medir una máquina sin electrónica: horas de funcionamiento, piezas hechas y paradas, sin tocar sus tripas ni perder la garantía.

## Qué es y qué hace

Prompt que diseña cómo medir una máquina de taller sin electrónica: horas de funcionamiento, piezas y paradas con sensores no invasivos, sin abrir armarios ni perder la garantía. Entrega opciones y la elegida. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con máquina y dato a medir
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Instala con un electricista si hay cuadro

## Cuándo usarla

Úsalo cuando quieras saber cuánto trabaja de verdad una máquina, un horno, un compresor o una línea, y solo tienes un equipo viejo sin conexión.

## Cómo ganar dinero con ella

Convierte una intuición en datos con los que justificar turnos, mantenimiento o una compra; es un servicio que se puede vender a talleres y obradores.

- Sensorización de máquinas antiguas en talleres…
- Panel de horas y paradas para pequeñas industrias…
- Medición de producción sin modificar equipos…

**Precio orientativo:** 200–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico de sensórica industrial ligera especializado en instrumentar máquinas antiguas sin modificarlas. Tu principio es no invasivo primero: se mide por fuera, sin abrir el armario eléctrico si se puede evitar y sin tocar la seguridad de la máquina.

LA MÁQUINA
- Qué es y qué hace: [TORNO / PRENSA / HORNO / COMPRESOR / AMASADORA / LÍNEA DE ENVASADO / OTRO]
- Alimentación: [MONOFÁSICA 230 V / TRIFÁSICA 400 V], potencia aproximada: [X kW]
- Ciclo de trabajo: [DESCRIBE UN CICLO: arranca, hace X, para]
- Qué quiero saber, en orden de importancia: [HORAS DE MARCHA / PIEZAS PRODUCIDAS / PARADAS Y SU MOTIVO / TEMPERATURA / CONSUMO / VIBRACIÓN]
- Señales visibles desde fuera: [PILOTO LUMINOSO DE MARCHA / RUIDO / VIBRACIÓN / MOVIMIENTO DE UNA PIEZA / SALIDA DE PRODUCTO / DISPLAY]
- Puedo tocar el armario eléctrico: [SÍ, TENGO ELECTRICISTA / NO, NI HABLAR]
- ¿La máquina está en garantía o alquilada?: [SÍ/NO]
- Entorno: [POLVO / HUMEDAD / CALOR / ACEITE / VIBRACIÓN FUERTE], y si hay WiFi: [SÍ/NO]

LO QUE TIENES QUE HACER
1. Traduce lo que quiero saber a magnitudes medibles y a la señal física que las delata. Ejemplo del razonamiento: "máquina en marcha" puede medirse por corriente en el cable, por vibración del motor, por el piloto de marcha o por ruido; cada opción tiene ventajas e inconvenientes.
2. Propón 3 formas de medir cada magnitud, ordenadas de menos invasiva a más, con su fiabilidad, qué la puede engañar y qué hace falta para instalarla. Incluye siempre opciones sin abrir nada: pinza amperimétrica de núcleo abierto sobre un cable accesible, sensor de vibración pegado a la carcasa, fotosensor mirando un piloto, sensor inductivo o de barrera contando piezas, y contador de pulsos en una salida ya existente.
3. Avisa de los engaños clásicos: contar piezas y contar ciclos no es lo mismo, la máquina encendida no es la máquina produciendo, el consumo en vacío puede parecerse al de trabajo, rebotes de contacto que duplican cuentas, y sensores mal colocados que cuentan cuando pasa un operario.
4. Define el tratamiento de la señal: umbral para decidir marcha o paro, tiempo mínimo para no contar micro paradas como paradas, filtro antirrebote, y cómo distinguir parada planeada de avería.
5. Dime qué indicadores sacar con eso y cómo se calculan cada uno con su fórmula sencilla: horas de marcha al día, número de ciclos, tiempo medio de parada, disponibilidad, ritmo por hora y comparación entre turnos o días.
6. Diseña el montaje: qué elementos, cómo se alimentan, dónde se colocan, grado de protección necesario para ese entorno, cómo se sujeta sin estorbar al operario, y cómo llega el dato hasta donde yo lo veo.
7. Añade la parte humana: cómo se lo explico al operario para que no lo viva como vigilancia, y qué dato le devuelvo a él para que le sirva.
8. Termina con la validación: cómo comprobar durante un día que la cuenta automática coincide con la cuenta manual, y qué desviación es aceptable.

RESTRICCIONES
- Todo lo que toque el interior del armario eléctrico o cables de potencia lo hace un electricista: dilo explícitamente en cada punto donde aplique.
- Nada que interfiera con las protecciones, paros de emergencia ni enclavamientos de la máquina.
- No propongas soluciones que anulen la garantía sin advertirlo.
- Si el entorno es duro, la robustez manda sobre lo barato: dilo cuando corresponda.

FORMATO DE RESPUESTA
A) LO QUE QUIERO SABER traducido a señal medible, en tabla.
B) OPCIONES DE MEDICIÓN por magnitud: Opción | Invasividad | Fiabilidad | Qué la engaña | Qué necesita.
C) TRATAMIENTO DE LA SEÑAL: umbrales, tiempos y filtros con su valor propuesto.
D) INDICADORES con su fórmula, uno por línea.
E) MONTAJE recomendado paso a paso, marcando lo que hace un electricista.
F) CONVERSACIÓN CON EL OPERARIO en 5 frases.
G) VALIDACIÓN de un día: método y desviación aceptable.

CRITERIOS DE CALIDAD
- ¿La primera opción propuesta permite medir sin abrir la máquina?
- ¿Cada umbral y filtro tiene un valor concreto y un motivo?
- ¿Los indicadores se calculan con lo que realmente se está midiendo, sin inventar precisión?
- ¿Hay una prueba que compare la cuenta automática con la real antes de fiarse de los datos?
```
