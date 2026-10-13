# Conectar una máquina antigua…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Plan para sacar datos o control de una máquina, contador o instalación vieja sin abrirla ni tocar su cableado, usando sensores añadidos por fuera.

## Qué es y qué hace

Prompt que planifica cómo sacar datos de una máquina o contador antiguo sin abrirla: horas de uso, piezas, consumo o paradas, con sensores externos. Ordena las opciones de menos a más invasiva y elige la mejor. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con máquina, dato y presupuesto
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Valida con un electricista antes de tocar el cuadro

## Cuándo usarla

Úsalo cuando quieras saber si una máquina está funcionando, cuánto consume, cuántas piezas hace o cuándo se para, y no puedas o no debas modificarla.

## Cómo ganar dinero con ella

Es un servicio muy vendible a talleres, lavanderías, panaderías o naves: medir sin tocar la máquina no rompe garantías y se cobra como mejora de productividad.

- Digitalización de maquinaria antigua en talleres…
- Medición de horas y paradas en lavanderías y obradores…
- Paneles de producción sencillos para pequeñas naves…

**Precio orientativo:** 200–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico de digitalización de maquinaria antigua para pequeñas industrias y talleres. Tu regla número uno es no tocar por dentro nada que tenga garantía, seguro o riesgo eléctrico: mides desde fuera y punto.
Mi caso:
- Máquina o instalación: [QUÉ ES Y QUÉ HACE]
- Antigüedad aproximada y si tiene pantalla o electrónica: [DATOS]
- Qué quiero saber o controlar: [HORAS DE FUNCIONAMIENTO / PIEZAS PRODUCIDAS / CONSUMO / PARADAS / TEMPERATURA / ENCENDIDO A DISTANCIA]
- Para qué me sirve ese dato: [DECISIÓN QUE TOMARÉ CON ÉL]
- ¿Puedo tocar el cuadro eléctrico?: [SÍ CON ELECTRICISTA / NO / NO LO SÉ]
- Entorno: [POLVO / HUMEDAD / VIBRACIÓN / CALOR / ACEITE]
- Presupuesto: [EUROS]
Tu tarea: proponerme formas de medir desde fuera, ordenadas de menos invasiva a más, y elegir la mejor para mi caso.
Trabaja así:
PASO 1. Traduce mi pregunta de negocio a una señal física medible. Por ejemplo, «saber si está trabajando» puede medirse por consumo eléctrico, por vibración, por ruido, por calor, por movimiento de una pieza o por la luz de un piloto. Dame al menos cuatro caminos distintos para mi caso.
PASO 2. Para cada camino, explica el método sin jerga: pinza de medida que se abraza al cable sin cortarlo y detecta cuánta corriente pasa, sensor de vibración pegado a la carcasa, sensor óptico mirando un piloto que se enciende, detector de proximidad contando pasadas de una pieza metálica, sensor de temperatura pegado con cinta térmica, o micrófono para reconocer el ciclo por su sonido.
PASO 3. Valora cada camino en tabla: fiabilidad del dato, dificultad de instalación, riesgo de tocar la máquina, coste, y qué falsos positivos puede dar.
PASO 4. Elige el ganador para mi caso y explícame dónde exactamente se coloca, cómo se sujeta para que no se caiga con la vibración, y cómo se protege del entorno que he descrito.
PASO 5. Define la lógica de interpretación, que es la parte que casi nadie hace bien: a partir de qué valor consideramos que la máquina está trabajando, cuánto tiempo por debajo cuenta como parada, cómo distingo una parada de descanso de una avería, y cómo evito contar dos veces la misma pieza. Dame umbrales de partida y dime cómo ajustarlos observando un día real.
PASO 6. Plan de validación: durante [DÍAS] apunto a mano lo que hace la máquina y lo comparo con lo que dice el sistema. Explica qué porcentaje de acierto es aceptable antes de fiarme.
PASO 7. Qué hago con el dato: qué informe sale, quién lo mira, y qué decisión concreta cambia. Si no hay decisión que cambie, dímelo y ahórrame el proyecto.
PASO 8. Si además quiero encender o apagar la máquina a distancia, explícame por qué eso es otra liga: seguridad, arranque inesperado con alguien delante, necesidad de enclavamientos, y cuándo directamente no se debe hacer.
Restricciones:
- Nada de abrir cuadros ni pinchar cables: todo lo que sea 230 V o trifásico lo instala un electricista con su boletín.
- No propongas modificar la máquina si eso puede anular garantía o seguro.
- Si el dato que quiero no se puede obtener de forma fiable desde fuera, dilo claramente.
Formato de la respuesta:
1) SEÑALES POSIBLES: tabla con los caminos y su valoración.
2) SOLUCIÓN ELEGIDA con montaje descrito y foto mental de dónde va cada cosa.
3) LÓGICA DE INTERPRETACIÓN con umbrales de partida.
4) PLAN DE VALIDACIÓN con la tabla de comparación manual.
5) INFORME RESULTANTE: qué tres números verá el dueño cada semana.
6) LÍMITES Y RIESGOS, incluyendo lo que este sistema no puede saber.
Criterios de calidad: está bien si no hay que abrir la máquina, si el sistema distingue trabajo de parada con acierto comprobado, y si el dueño puede tomar una decisión concreta con el dato.
```
