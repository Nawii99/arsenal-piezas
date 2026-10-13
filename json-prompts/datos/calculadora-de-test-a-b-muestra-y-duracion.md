# Calculadora de test A/B: muestra y duración…

**Tipo:** JSON prompt · **Área:** Datos · **Licencia:** CC BY 4.0

Te dice cuánta gente y cuántos días necesitas para que un test A/B sea fiable, y cuándo pararlo. Incluye el semáforo de decisión.

## Qué es y qué hace

Recibe tu tasa actual, la mejora mínima que te compensa, tu tráfico semanal y el nivel de confianza, y devuelve el tamaño de muestra por variante, la duración estimada en días y la regla de decisión, explicada en lenguaje llano. Ejemplo: pasar de 2,4 % a 3,0 % requiere unos miles de visitas por variante. Lo calculas con Claude, Codex, Gemini o una IA local antes de lanzar la prueba en la web, los anuncios o el email.

## Cómo usarla

1. Anota la conversión actual y la mejora mínima
2. Indica el tráfico semanal
3. Fija la fecha de fin antes de empezar

## Cuándo usarla

Úsalo antes de lanzar cualquier prueba en tu web, anuncios o emails, para saber si tienes tráfico suficiente y no perder semanas midiendo humo.

## Cómo ganar dinero con ella

Evita tests eternos o sin validez que te llevan a cambiar la web basándote en ruido. Te dice antes de empezar si merece la pena hacerlo.

- Dimensionar pruebas de landing para una tienda con poco tráfico que no quiere perder semanas…
- Servicio de diseño de tests para agencias que llevan experimentos de conversión de sus clientes…
- Plantilla de calculadora de tests para equipos de marketing de pymes…

**Precio orientativo:** 40–100 € por test. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Dimensionar un test A/B antes de lanzarlo: calcular tamaño de muestra por variante, duración estimada y regla de decisión, explicando cada número en lenguaje llano",
  "contexto": {
    "negocio": "[QUÉ VENDES Y A QUIÉN]",
    "donde_se_hace_el_test": "[WEB / LANDING / EMAIL / ANUNCIOS / FICHA DE PRODUCTO]",
    "que_cambia_la_variante_B": "[DESCRIBE EL CAMBIO EN UNA FRASE]"
  },
  "entradas": {
    "metrica_principal": "[CONVERSIÓN A COMPRA / ALTAS / CLICS / RESERVAS]",
    "valor_actual_metrica": "[POR EJEMPLO 2,4 %]",
    "mejora_minima_que_me_compensa": "[EN PUNTOS O EN % RELATIVO, EJ. PASAR DE 2,4 % A 3,0 %]",
    "trafico_semanal_total": "[VISITAS, ENVÍOS O USUARIOS POR SEMANA]",
    "reparto_del_trafico": "[50/50 U OTRO]",
    "nivel_de_confianza": "95 %",
    "potencia": "80 %",
    "metricas_de_control": "[TICKET MEDIO, DEVOLUCIONES, BAJAS, MÁRGENES]"
  },
  "procedimiento": [
    "1. Comprobar que la métrica principal es una sola y es la que de verdad mueve el dinero; si el usuario da varias, elegir una y bajar el resto a secundarias",
    "2. Calcular el tamaño de muestra por variante para el efecto mínimo indicado, con la fórmula de proporciones, y mostrar el número redondeado hacia arriba",
    "3. Dividir entre el tráfico semanal para estimar semanas necesarias; redondear siempre a semanas completas para no mezclar días laborables y fines de semana",
    "4. Si la duración supera 6 semanas, avisar de que el test no es viable y proponer alternativas: efecto mínimo mayor, métrica más frecuente o cambio más agresivo",
    "5. Definir la regla de decisión escrita antes de empezar y las condiciones de parada por daño"
  ],
  "restricciones": [
    "No mirar resultados ni tomar decisiones antes de alcanzar la muestra planificada",
    "No cambiar la variante, el reparto de tráfico ni la métrica una vez arrancado el test",
    "No lanzar el test en semanas atípicas (rebajas, festivos, campaña puntual) salvo que se indique",
    "Explicar cada concepto estadístico con una frase de andar por casa, sin jerga sin traducir"
  ],
  "formato_salida": {
    "bloque_1": "Resumen en 5 líneas: métrica, efecto mínimo, muestra por variante, semanas necesarias y veredicto viable o no viable",
    "bloque_2": "Tabla con columnas: parámetro, valor, qué significa en cristiano",
    "bloque_3": "Ficha del test lista para pegar: hipótesis, variante A, variante B, métrica principal, métricas de control, fecha de inicio y fecha mínima de fin",
    "bloque_4": "Regla de decisión: qué haré si gana B, si gana A y si queda en empate",
    "bloque_5": "Tabla
```
