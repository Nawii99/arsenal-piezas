# Cuánto durarán las pilas del sensor…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Calcula la autonomía real de un sensor a pilas o batería, te dice qué está chupando la energía y cómo estirar la duración sin cambiar de aparato.

## Qué es y qué hace

Prompt que calcula la autonomía real de un sensor a pilas o batería e identifica qué consume energía. Con capacidad, frecuencia de envío y tecnología, estima la duración, dice si es normal y ordena mejoras. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con pila, frecuencia y entorno
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Aplica primero la mejora mayor

## Cuándo usarla

Úsalo cuando montes o vendas sensores sin enchufe, o cuando te toque cambiar pilas cada dos por tres y quieras saber si es normal o hay algo mal.

## Cómo ganar dinero con ella

Cambiar pilas en casa de clientes es trabajo no cobrado; alargar la autonomía elimina visitas y te permite prometer plazos de mantenimiento realistas.

- Auditoría de consumo de sensores a pilas…
- Optimización de autonomía en instalaciones de clientes…
- Planes de mantenimiento con previsión de cambio de pilas…

**Precio orientativo:** 40–120 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como ingeniero de electrónica de bajo consumo. Has diseñado sensores que aguantan años con una pila y sabes que la autonomía casi nunca la mata el consumo cuando trabaja, sino el consumo cuando debería estar durmiendo.
Mi caso:
- Qué aparato es: [SENSOR COMPRADO / MONTAJE PROPIO CON PLACA]
- Qué mide y cada cuánto envía dato: [MAGNITUD Y FRECUENCIA]
- Alimentación actual: [PILAS AA / PILA DE BOTÓN / BATERÍA DE LITIO 18650 / PANEL SOLAR / NO LO SÉ]
- Capacidad indicada en la pila o batería: [MILIAMPERIOS HORA]
- Cuánto está durando ahora: [DÍAS O SEMANAS]
- Cuánto necesito que dure: [OBJETIVO]
- Dónde está instalado: [INTERIOR / EXTERIOR / FRÍO / CALOR / SITIO DE DIFÍCIL ACCESO]
- Tecnología de conexión: [WIFI / MALLA DE BAJO CONSUMO / RADIO LARGA DISTANCIA / BLUETOOTH]
Tu tarea: estimar la autonomía, decirme si mi caso es normal o anormal, y darme la lista de mejoras ordenada por lo que más gana con menos esfuerzo.
Trabaja así:
PASO 1. Explícame en lenguaje llano cómo se calcula la autonomía: consumo medio igual a lo que gasta despierto por el tiempo que está despierto, más lo que gasta dormido por el tiempo que duerme, todo dividido entre el ciclo completo. Luego autonomía igual a capacidad entre consumo medio, aplicando un descuento del 25 al 30 por ciento porque las pilas nunca dan lo que prometen y el frío las castiga.
PASO 2. Rellena ese cálculo con estimaciones razonables para mi tecnología de conexión, diciendo claramente que son órdenes de magnitud y no medidas exactas. Explica por qué una conexión wifi despierta mucho más rato que una malla de bajo consumo.
PASO 3. Compara el resultado con lo que me está durando de verdad. Si la diferencia es grande, dame la lista de sospechosos: la placa de desarrollo con su regulador y su chip de USB chupando corriente todo el rato aunque el programa esté dormido, un piloto led encendido, una resistencia mal puesta, el aparato que se despierta por cualquier ruido, una pila de mala calidad o ya usada, y frío extremo.
PASO 4. Mejoras ordenadas por relación entre lo que gano y lo que cuesta. Para cada una: qué hago, cuánto puedo ganar aproximadamente, y qué pierdo a cambio, porque enviar menos datos siempre es menos información.
PASO 5. Decisión de fuente de alimentación: cuándo compensa pila alcalina, cuándo pila de litio, cuándo batería recargable y cuándo panel solar pequeño. Para el panel solar, explícame cómo se dimensiona a ojo contando las horas de sol útiles del peor mes en [CIUDAD] y dejando margen para días nublados seguidos.
PASO 6. Aviso de seguridad sobre baterías de litio: qué no hacer nunca, dónde no instalarlas y qué protección necesitan.
PASO 7. Plan de mantenimiento: cada cuánto reviso, cómo aviso al cliente antes de que se agote, y por qué conviene que el propio sensor mande su nivel de batería.
Restricciones:
- Deja claro qué números son estimaciones y cuáles habría que medir de verdad.
- No prometas duraciones concretas como si fueran garantía.
- Si mi caso pide claramente alimentación por cable, dímelo sin rodeos.
Formato de la respuesta:
1) CÁLCULO paso a paso con mis datos, escrito para que lo pueda repetir yo solo.
2) VEREDICTO: normal o anormal, con el motivo.
3) TABLA DE MEJORAS: Mejora | Ganancia estimada | Esfuerzo | Qué pierdo.
4) RECOMENDACIÓN DE ALIMENTACIÓN para mi instalación.
5) AVISOS DE SEGURIDAD.
6) FRASE PARA EL CLIENTE explicando qué autonomía puede esperar y de qué depende, sin comprometerme de más.
Criterios de calidad: está bien si entiendo de dónde sale cada número, si sé qué medir para afinarlo, y si tengo al menos dos mejoras que puedo aplicar hoy sin comprar nada.
```
