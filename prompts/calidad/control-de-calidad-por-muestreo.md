# Control de calidad por muestreo…

**Tipo:** Prompt · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Revisa 200 textos generados por IA sin leértelos todos: muestra representativa, criterios de defecto y decisión de aceptar o rehacer el lote.

## Qué es y qué hace

Prompt que aplica muestreo estadístico sencillo al contenido generado por IA. Entran el prompt usado, el tipo de piezas y tres muestras; sale el tamaño y método de muestra, criterios de defecto y una regla de aceptar o rehacer el lote. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con tu lote
3. Revisa solo las piezas de la muestra
4. Aplica la regla de aceptar o rehacer

## Cuándo usarla

Úsalo cuando generes contenido en cantidad (fichas de producto, descripciones, traducciones, emails, subtítulos) y no puedas revisarlo todo a mano.

## Cómo ganar dinero con ella

Publicar en masa con errores repetidos daña ventas y posicionamiento; el muestreo te permite escalar sin leerlo todo ni pagar a un revisor.

- Control de calidad de fichas de producto generadas en masa…
- Revisión por muestreo de traducciones y subtítulos de clientes…
- Servicio de verificación antes de publicar catálogos con IA…

**Precio orientativo:** 80–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como inspector de calidad de producción, aplicando muestreo estadístico sencillo al contenido generado por IA. Tu criterio es el de una fábrica: no se revisa todo, se revisa una muestra bien elegida y se decide sobre el lote entero.

EL LOTE
- Qué he generado: [FICHAS DE PRODUCTO / DESCRIPCIONES / EMAILS / TRADUCCIONES / SUBTÍTULOS / POSTS]
- Cuántas piezas hay: [NÚMERO]
- Con qué prompt las generé: [PEGA EL PROMPT]
- De dónde salieron los datos de origen: [CATÁLOGO, CSV, FOTOS, NADA]
- Dónde se van a publicar: [WEB, MARKETPLACE, EMAIL, REDES]
- Qué es inaceptable en mi negocio: [INVENTARSE MEDIDAS, PROMETER PLAZOS, CAMBIAR EL NOMBRE DEL PRODUCTO, FALTAS DE ORTOGRAFÍA...]
- Tiempo que puedo dedicar a revisar: [MINUTOS U HORAS]
- Muestra: [PEGA AQUÍ 3 PIEZAS GENERADAS, TAL CUAL]

TU TRABAJO
1. Dime cuántas piezas debo revisar y cómo elegirlas para que la muestra sea representativa: nunca las primeras, sino repartidas por todo el lote y forzando la inclusión de los casos raros (productos con nombre largo, sin foto, con datos incompletos, categorías minoritarias). Dame el método exacto de selección, con números aplicados a mi lote.
2. Define el catálogo de defectos con tres niveles y ejemplos sacados de las piezas que te he pegado: CRÍTICO (dato falso, promesa que no puedo cumplir, nombre o medida equivocados, contenido que no corresponde al producto), MAYOR (falta de ortografía, frase sin sentido, repetición del mismo comienzo, tono equivocado, longitud fuera de rango) y MENOR (mejorable de estilo).
3. Fija la regla de decisión antes de mirar nada: cuántos defectos por nivel me obligan a rechazar el lote entero y volver a generar, cuántos permiten publicar corrigiendo solo los afectados, y cuántos son tolerables. Justifica los umbrales con sentido común de negocio.
4. Dame la hoja de inspección: una tabla lista para rellenar con una fila por pieza revisada y una columna por criterio, en formato que pueda copiar a una hoja de cálculo.
5. Revisa tú ahora las 3 piezas que te he pegado aplicando el catálogo, y muéstrame cómo se puntúa cada una, señalando el texto exacto que constituye el defecto y por qué.
6. Análisis de causa: cuando un defecto se repite, no es mala suerte, es el prompt. Dime qué defectos vienen del prompt, cuáles de los datos de origen y cuáles del modelo, y dame la corrección concreta del prompt para cada uno, escrita ya lista para pegar.
7. Dame los cinco defectos invisibles del contenido en masa que no se ven leyendo pieza a pieza: repetición del mismo esqueleto de frase, mismo adjetivo en todas, longitud sospechosamente idéntica, datos copiados de una pieza a otra y falta de la palabra clave del producto. Explícame cómo detectarlos mirando el lote de golpe en una hoja de cálculo.

RESTRICCIONES
- Nada de estadística complicada: reglas simples, números redondos y aplicables a mano.
- No revises el lote entero ni me pidas pegártelo entero.
- Cada defecto señalado debe citar el fragmento literal.

FORMATO DE RESPUESTA
A) Tamaño y método de la muestra, con números para mi lote.
B) Catálogo de defectos por nivel, con ejemplo real de mis piezas.
C) Regla de decisión aceptar / corregir / rehacer.
D) Hoja de inspección lista para copiar.
E) Inspección de mis 3 piezas, con puntuación y fragmentos citados.
F) Correcciones del prompt, listas para pegar.
G) Los 5 defectos invisibles y cómo cazarlos.

CRITERIOS DE CALIDAD
- La decisión sobre el lote se toma con una regla fijada de antemano, no con una impresión.
- Toda crítica va acompañada del texto exacto que la motiva.
- Directo al grano: empieza por el apartado A.
```
