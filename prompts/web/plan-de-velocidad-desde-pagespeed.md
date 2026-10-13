# plan-de-velocidad-desde-pagespeed…

**Tipo:** Prompt · **Área:** Web · **Licencia:** CC BY 4.0

Le pegas el informe de PageSpeed o GTmetrix de tu web y te devuelve un plan priorizado: qué arreglar primero, cómo hacerlo y cuánto ganas con cada cosa.

## Qué es y qué hace

Prompt para cualquier chat de IA que actúa como especialista en rendimiento web. Pegas el informe de PageSpeed o GTmetrix y devuelve un plan priorizado: qué arreglar primero, cómo hacerlo y cuánto se gana con cada cambio, traducido para quien no es técnico.

## Cómo usarla

1. Copia el prompt
2. Pega la URL y el informe en los [corchetes]
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Aplica los arreglos por orden y vuelve a medir

## Cuándo usarla

Úsalo cuando tu web tarde en cargar, se te caiga el posicionamiento, la gente abandone antes de ver el producto, o simplemente al terminar una web nueva.

## Cómo ganar dinero con ella

Una web lenta pierde visitas antes de que lleguen a ver el precio. Acelerarla aprovecha el tráfico que ya pagas o ya te llega sin gastar más en publicidad.

- Optimización de velocidad de webs de negocios pequeños…
- Informe de rendimiento con plan de mejora priorizado…
- Mantenimiento mensual de velocidad y Core Web Vitals…

**Precio orientativo:** 60–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como especialista en rendimiento web (Core Web Vitals) que trabaja con negocios pequeños y traduce los informes técnicos a tareas concretas. Yo no soy técnico: no entiendo los nombres de las métricas y necesito saber por dónde empezar.

MI WEB
- URL: [DIRECCIÓN DE LA PÁGINA ANALIZADA]
- Hecha con: [HTML SUELTO / WORDPRESS + TEMA / SHOPIFY / CONSTRUCTOR VISUAL / GENERADA CON IA]
- Alojada en: [HOSTING O PLATAFORMA]
- Qué quiero que haga esa página: [VENDER, CAPTAR CONTACTOS, INFORMAR]
- Mi público entra sobre todo desde: [MÓVIL / ORDENADOR / NO LO SÉ]
- Tiempo que puedo dedicar: [HORAS DISPONIBLES] · Puedo tocar código: [SÍ, POCO / NO, SOLO PANELES]

INFORME
[PEGA AQUÍ EL INFORME COMPLETO DE PAGESPEED INSIGHTS, GTMETRIX O WEBPAGETEST: PUNTUACIONES, OPORTUNIDADES Y DIAGNÓSTICOS. SI NO TIENES INFORME, DESCRIBE QUÉ TARDA Y CUÁNTO.]

LO QUE TIENES QUE HACER
1. Explícame en 5 líneas, en llano, qué significan LCP, CLS e INP para MI página: LCP es cuánto tarda en aparecer lo importante, CLS es si los elementos bailan mientras carga, INP es si responde rápido al tocar. Dime en cuál estoy mal y qué nota me pone Google.
2. Diagnostica el cuello de botella principal. No me des los 30 avisos del informe: dime cuál es la causa raíz que arrastra a las demás (normalmente imágenes enormes, tipografías, scripts de terceros o un tema pesado).
3. Prioriza las acciones con esta tabla: acción, impacto estimado (alto/medio/bajo), esfuerzo (minutos u horas), riesgo de romper algo, y orden de ejecución. Ordena por impacto entre esfuerzo, no por lo que dice el informe.
4. Para cada acción del top 5, dame instrucciones ejecutables: qué archivo o panel toco, el código o ajuste exacto, y cómo compruebo que ha funcionado. Cubre cuando aplique: imágenes en formato moderno y a la medida real que se muestra, atributos de ancho y alto para que no salte el diseño, carga diferida salvo en la imagen principal, precarga de la imagen o tipografía crítica, tipografías locales con intercambio de fuente, eliminar scripts de terceros que no uses, retrasar los que no sean críticos, y activar compresión y caché en el hosting.
5. Señala las falsas alarmas: avisos del informe que en mi caso no merecen la pena y por qué, para que no pierda el tiempo.
6. Dime qué NO debo hacer: cambios que suben la puntuación pero empeoran la experiencia o rompen el seguimiento de conversiones.
7. Dame un plan en tres bloques: HOY (30 minutos), ESTA SEMANA, y SI CONTRATO AYUDA (qué pedir y cómo comprobar que lo han hecho).
8. Dime cómo medir el antes y el después de forma honesta: misma URL, mismo tipo de conexión, tres mediciones y quedarse con la mediana, y datos de campo cuando haya suficientes visitas.

RESTRICCIONES
- Prohibido copiar el texto del informe. Todo traducido a acción.
- Si una acción puede romper la web, dime antes cómo hago copia de seguridad y cómo revierto.
- No prometas puntuaciones concretas: habla de rangos y de qué depende.
- Español de España, tuteando, sin emojis.

FORMATO DE RESPUESTA
DIAGNÓSTICO EN UNA FRASE
QUÉ SIGNIFICAN MIS MÉTRICAS (5 líneas)
CAUSA RAÍZ Y POR QUÉ
TABLA DE PRIORIDADES (acción, impacto, esfuerzo, riesgo, orden)
TOP 5 CON INSTRUCCIONES PASO A PASO
FALSAS ALARMAS
LO QUE NO DEBO HACER
PLAN: HOY / ESTA SEMANA / SI CONTRATO AYUDA
CÓMO MIDO EL RESULTADO

CRITERIO DE CALIDAD: está bien si en 30 minutos puedo hacer la primera acción yo solo y si sé decir, con datos, si la web va más rápida que antes.
```
