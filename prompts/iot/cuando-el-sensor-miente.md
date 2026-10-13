# Cuando el sensor miente…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Método para averiguar si una lectura rara es un fallo del sensor, de la instalación o del sitio, y cómo calibrarlo o corregirlo sin cambiar el aparato.

## Qué es y qué hace

Prompt que separa el sensor, la instalación, el sitio y la expectativa para averiguar por qué una lectura es rara. Con la medida, la referencia y la colocación, clasifica el error y propone calibración o corrección sin cambiar el aparato. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con lectura, referencia y ubicación
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Cambia una cosa cada vez

## Cuándo usarla

Úsalo cuando un sensor dé valores que no cuadran, salte por nada, marque distinto que otro al lado o vaya desviándose poco a poco con el tiempo.

## Cómo ganar dinero con ella

Evita cambiar aparatos que estaban bien y evita decisiones tomadas con datos falsos; también salva tu credibilidad ante un cliente que te dice que su sensor no funciona.

- Diagnóstico de sensores con lecturas erróneas…
- Calibración y reubicación de sensores en instalaciones…
- Informe técnico para clientes con dudas sobre sus datos…

**Precio orientativo:** 40–120 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico de instrumentación acostumbrado a que le lleven aparatos «estropeados» que en realidad están mal colocados. Tu método es separar cuatro cosas que la gente confunde: el sensor, la instalación, el sitio y la expectativa del usuario.
Mi problema:
- Qué sensor es y qué mide: [TIPO DE SENSOR Y MAGNITUD]
- Qué está haciendo mal: [DESCRIPCIÓN DEL SÍNTOMA]
- Qué valor da y qué valor debería dar: [LECTURA Y REFERENCIA]
- Dónde está colocado exactamente: [UBICACIÓN, ALTURA, ORIENTACIÓN, QUÉ TIENE ALREDEDOR]
- Cómo está alimentado y conectado: [ALIMENTACIÓN Y CABLEADO]
- Desde cuándo pasa y si empeora con el tiempo: [HISTORIAL]
- Con qué comparo: [OTRO APARATO, TERMÓMETRO, SENSACIÓN, NADA]
Tu tarea: darme un método de descarte y, si el sensor es recuperable, la forma de corregirlo.
Trabaja así:
PASO 1. Clasifica el tipo de error, porque cada uno tiene causas distintas: desviación constante hacia arriba o abajo, error que crece con el valor medido, ruido y saltos bruscos, retraso en reaccionar, valores imposibles o congelados, y deriva lenta a lo largo de semanas. Dime en cuál cae mi síntoma y qué implica.
PASO 2. Descarta el sitio antes que el aparato. Repasa las trampas típicas según lo que mida: un sensor de temperatura al sol o encima de un aparato que calienta, un sensor de humedad demasiado cerca del suelo o de una fuente de vapor, un detector de presencia apuntando a una cortina o a una salida de aire, un sensor de calidad del aire pegado a una ventana, o un sensor de agua colocado donde nunca llegaría la fuga.
PASO 3. Descarta la instalación: cable demasiado largo o de mala calidad, alimentación insuficiente que hace que la lectura baile, el propio circuito calentando el sensor porque está pegado a la placa, falta de una resistencia obligatoria, o dos sensores compartiendo bus con el mismo identificador.
PASO 4. Prueba del sensor propiamente dicho: la comparación con una referencia. Explícame cómo hacer una comprobación casera decente, incluyendo la prueba de hielo derritiéndose y la de agua hirviendo para temperatura, con sus advertencias sobre altitud y sobre no meter el sensor donde no puede ir, y cómo comparar dos sensores dejándolos juntos varias horas antes de juzgar.
PASO 5. Corrección. Explica la diferencia entre corregir un desplazamiento fijo, que es sumar o restar un valor, y corregir una pendiente, que necesita dos puntos de referencia. Dime cuál necesita mi caso y cómo se anota esa corrección para no perderla.
PASO 6. Filtrado del ruido sin engañarme a mí mismo: media de varias lecturas, ignorar valores imposibles, y exigir que una condición se mantenga varios minutos antes de disparar una alarma. Advierte de que filtrar demasiado hace que me entere tarde de lo que importa.
PASO 7. Cuándo el sensor está para tirar: señales de que ha llegado al final y no merece la pena insistir.
PASO 8. Prevención: qué hago al instalar el próximo para no repetir esto, incluyendo dejar anotada la fecha de instalación y el valor de referencia inicial.
Restricciones:
- No supongas que tengo instrumentos de laboratorio: trabaja con lo que hay en una casa o en un taller pequeño.
- Cada prueba debe decir cuánto tiempo hay que esperar antes de sacar conclusiones.
- Si el sensor es de un tipo que simplemente no da la precisión que yo espero, dímelo claro en vez de buscarle arreglo.
Formato de la respuesta:
1) TIPO DE ERROR identificado y qué apunta.
2) ÁRBOL DE DESCARTE en pasos, con la respuesta que me hace pasar al siguiente.
3) PRUEBA DE REFERENCIA explicada paso a paso con lo que necesito.
4) CORRECCIÓN a aplicar, con el número concreto si se puede calcular.
5) FILTROS recomendados y sus riesgos.
6) FICHA DEL SENSOR: plantilla con fecha, ubicación, corrección aplicada y próxima revisión.
Criterios de calidad: está bien si al final sé si el problema era el aparato, el sitio o mi expectativa, y si tengo un número concreto de corrección o una razón concreta para cambiarlo.
```
