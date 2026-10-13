# Plan de idioma en 90 días a tu ritmo…

**Tipo:** JSON prompt · **Área:** Formación · **Licencia:** CC BY 4.0

Te monta un plan de estudio de 90 días para tu idioma, con objetivos por semana, sesiones diarias del tiempo que tengas y cómo medir si avanzas.

## Qué es y qué hace

Es un prompt JSON para una IA de texto (Claude, Codex, Gemini o una IA local). Indicas idioma, nivel actual y objetivo en el Marco Común Europeo, minutos al día, motivo y puntos flojos, y genera un plan de 90 días con objetivos por semana y sesiones diarias en cuatro bloques (entrada, vocabulario con repaso espaciado, producción y repaso de errores propios). Incluye cómo medir si avanzas.

## Cómo usarla

1. Indica idioma, nivel actual y objetivo MCER
2. Pon los minutos reales que puedes dedicar
3. Ejecútalo en tu IA
4. Revisa el avance cada semana con la prueba de medición

## Cuándo usarla

Úsalo cuando quieras aprender o retomar un idioma y no sepas por dónde empezar ni cuánto dedicarle cada día para llegar a un nivel concreto.

## Cómo ganar dinero con ella

Evita gastar meses y dinero en apps y academias sin rumbo: concentra tu tiempo en lo que de verdad te sube de nivel.

- Diseñar planes de idioma para profesionales que se mudan o viajan por trabajo…
- Vender planes de estudio personalizados por tramos de 90 días…
- Ofrecer planes de idioma para empleados de pymes con presupuesto de formación limitado…

**Precio orientativo:** 15–40 € por plan. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Diseñar un plan de estudio realista de 90 dias para pasar de mi nivel actual de [IDIOMA] al nivel objetivo, adaptado a los minutos reales que puedo dedicar",
  "contexto": {
    "idioma": "[IDIOMA]",
    "nivel_actual_mcer": "[A1, A2, B1, B2 o C1]",
    "nivel_objetivo_mcer": "[NIVEL AL QUE QUIERES LLEGAR]",
    "motivo_real": "[PARA QUÉ LO NECESITAS: reuniones con clientes, viajar, examen oficial, mudanza]",
    "minutos_dia": "[MINUTOS AL DÍA QUE PUEDES DEDICAR DE VERDAD]",
    "dias_semana": "[DÍAS A LA SEMANA]",
    "recursos_que_ya_tengo": "[APPS, LIBROS, PODCASTS, PROFESOR, SERIES]",
    "puntos_flojos": "[LO QUE PEOR SE TE DA: hablar, entender de oído, gramática, vocabulario]"
  },
  "metodo": [
    "Reparte cada sesion en cuatro bloques: entrada comprensible (escuchar o leer), vocabulario con repaso espaciado, produccion (hablar o escribir) y repaso de errores propios",
    "Fija objetivos por semana y no por dia, para que un dia perdido no rompa el plan",
    "Sube la dificultad solo cuando entiendas alrededor del 80 por ciento del material actual sin traducir",
    "Reserva al menos el 30 por ciento del tiempo a produccion oral, aunque sea hablando solo o grabandote",
    "Divide los 90 dias en tres bloques de 30 con un hito comprobable al final de cada uno"
  ],
  "restricciones": [
    "No propongas mas minutos de los indicados en minutos_dia ni actividades que exijan comprar nada nuevo salvo que lo digas como opcional y gratuito",
    "Nada de listas de 500 palabras: maximo 15 palabras nuevas por sesion",
    "Prohibido recomendar solo apps de gamificacion como plan completo",
    "Escribe en espanol de Espana, tuteando y sin tecnicismos de didactica"
  ],
  "formato_salida": {
    "tipo": "documento con secciones y tablas en texto",
    "secciones": [
      "Diagnostico de partida y que significa tu nivel objetivo en la practica",
      "Tabla de las 13 semanas con: semana, foco, objetivo medible y material",
      "Plantilla de la sesion tipo minuto a minuto para tus [MINUTOS AL DÍA]",
      "Los tres hitos de comprobacion (dia 30, 60 y 90) con la prueba concreta que debes superar",
      "Plan B para semanas malas: version de 10 minutos que mantiene el habito",
      "Errores tipicos que te haran abandonar y como evitarlos"
    ]
  },
  "criterios_calidad": [
    "Cada semana tiene un objetivo que se puede comprobar con un si o un no",
    "El total de minutos semanales cuadra con lo que he declarado que puedo dedicar",
    "Las actividades son concretas: no vale poner practicar escucha, hay que decir con que y cuanto rato",
```
