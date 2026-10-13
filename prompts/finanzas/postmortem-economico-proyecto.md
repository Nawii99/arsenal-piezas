# postmortem-economico-proyecto…

**Tipo:** Prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Compara lo que presupuestaste con lo que de verdad costó un trabajo ya terminado y saca las reglas para no volver a quedarte corto.

## Qué es y qué hace

Prompt para cualquier chat de IA que hace la autopsia económica de un trabajo terminado. Compara el presupuesto con el coste real, explica la desviación y devuelve reglas concretas para presupuestar mejor. Ejemplo: proyecto cerrado a precio fijo que costó más horas de las previstas.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con presupuesto y costes reales
3. Guarda las reglas para tu próximo presupuesto
4. Que lo revise un profesional

## Cuándo usarla

Úsalo justo al cerrar un proyecto o un pedido grande, sobre todo si has tenido la sensación de haber trabajado más de lo previsto.

## Cómo ganar dinero con ella

Corregir la desviación te hace presupuestar mejor el siguiente encargo, así dejas de regalar horas y ajustas el precio con datos reales.

- Informe de desviaciones de proyectos para agencias y freelances…
- Revisión de presupuestos con reglas de mejora…

**Precio orientativo:** 60–180 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El prompt (cópialo entero)

```text
Actúa como jefe de proyecto y controller. Vamos a hacer la autopsia económica de un trabajo ya terminado: qué presupuesté, qué costó de verdad, por qué se desvió y qué regla me llevo para el próximo presupuesto.

DATOS DEL TRABAJO
- Qué era: [DESCRIPCIÓN DEL PROYECTO O PEDIDO]
- Cliente: [TIPO DE CLIENTE, NO HACE FALTA NOMBRE]
- Precio cerrado cobrado sin IVA: [IMPORTE]
- Presupuesto original: [PARTIDAS Y HORAS PREVISTAS]
- Fechas: [INICIO PREVISTO, FIN PREVISTO, FIN REAL]
- Horas reales dedicadas: [POR FASE SI LO SABES; SI NO, TOTAL APROXIMADO]
- Costes reales pagados a terceros o materiales: [LISTA CON IMPORTES]
- Cambios pedidos por el cliente durante el trabajo: [LISTA]
- Cosas que se cobraron aparte: [SÍ O NO, Y CUÁNTO]
- Mi coste por hora: [IMPORTE O 'NO LO SÉ']

PASOS
1. Reconstruye la cuenta real del proyecto: ingresos, costes directos, coste de mis horas, margen final en euros y en porcentaje.
2. Compara partida por partida presupuesto contra realidad y calcula la desviación en euros, en horas y en porcentaje.
3. Identifica las tres partidas que más se desviaron y para cada una di la causa concreta: mala estimación inicial, alcance que creció, cambios del cliente no cobrados, esperas y bloqueos, retrabajo por criterio poco claro, o coste de terceros que subió.
4. Calcula el coste del alcance regalado: horas dedicadas a cosas que no estaban en el presupuesto y no se facturaron, valoradas a mi precio hora. Dilo en euros.
5. Calcula el precio que debería haber puesto para haber alcanzado un margen del [MARGEN OBJETIVO, POR DEFECTO 40%] y dime el porcentaje de subida que representa.
6. Extrae el multiplicador de realidad: divide horas reales entre horas presupuestadas. Ese número es el que debo aplicar a mis próximas estimaciones de este tipo de trabajo. Dilo como regla.
7. Escríbeme las cláusulas que faltaban en el presupuesto para que esto no se repita: definición de alcance, número de revisiones incluidas, precio de la hora extra fuera de alcance, plazos de respuesta del cliente, hitos de pago y qué pasa si el proyecto se para.
8. Dame la checklist de presupuesto para la próxima vez: máximo diez comprobaciones antes de enviar un precio.
9. Termina con un veredicto en una frase: este proyecto fue rentable, apenas rentable o ruinoso, con la cifra.

REGLAS
- Mis horas siempre valoradas a coste, aunque sea yo quien las haga; si no, el margen es mentira.
- Separa lo que fue culpa de la estimación de lo que fue culpa de no gestionar al cliente: se arreglan de forma distinta.
- Sin reproches ni palmaditas: números y causas.
- Si faltan horas reales, pídeme una estimación por fases antes de calcular.

ERRORES TÍPICOS QUE DEBES BUSCAR
- Aceptar 'un cambio pequeño' cuatro veces sin cobrar ninguno.
- Presupuestar solo la ejecución y no las reuniones, la coordinación ni las correcciones.
- No poner límite de revisiones.
- Empezar sin anticipo y financiar el proyecto con mi dinero.
- No cobrar las esperas cuando el cliente se retrasa en darme material.

FORMATO DE LA RESPUESTA
1) VEREDICTO en una línea con el margen real.
2) TABLA COMPARATIVA: Partida | Presupuestado | Real | Desviación euros | Desviación %.
3) LAS TRES CAUSAS PRINCIPALES, una por bloque, con su coste.
4) ALCANCE REGALADO en euros.
5) PRECIO QUE DEBERÍA HABER PUESTO y multiplicador de realidad.
6) CLÁUSULAS QUE FALTABAN, redactadas y listas para pegar en mi plantilla de presupuesto.
7) CHECKLIST DE 10 PUNTOS.

CRITERIOS DE CALIDAD
- Las desviaciones suman y cuadran con el margen final.
- Cada causa lleva su importe.
- Las cláusulas están redactadas, no descritas.
```
