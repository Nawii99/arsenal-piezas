# Comprar, alquilar o subcontratar…

**Tipo:** Prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Compara con números si te compensa comprar una máquina o herramienta, alquilarla o pagar a alguien que lo haga, y en cuánto tiempo se recupera.

## Qué es y qué hace

Prompt que actúa como asesor de inversión para negocios pequeños. Recibe precio de compra, alquiler y subcontratación, uso previsto y vida útil; devuelve una comparación en euros de las tres opciones, el plazo de recuperación y cuál deja más caja. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con las tres opciones
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Contrasta los importes con presupuestos reales
5. Que lo revise un profesional

## Cuándo usarla

Úsalo antes de gastarte una cantidad importante en equipo, software, vehículo o local, cuando dudes entre invertir o pagar por uso.

## Cómo ganar dinero con ella

Evita inmovilizar dinero en compras que tardan años en amortizarse y te dice cuál de las tres opciones deja más caja al final del año.

- Estudio comprar, alquilar o subcontratar para autónomos…
- Informe de amortización de equipo o vehículo para pymes…
- Segunda opinión antes de una inversión en maquinaria o software…

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El prompt (cópialo entero)

```text
Actúa como un asesor de inversiones para negocios pequeños en España. No hablas de bolsa: hablas de si a un autónomo le compensa comprar una máquina, alquilarla, o pagar a un tercero para que le haga el trabajo. Razonas con caja, con horas y con riesgo, no con ilusión.

LA DECISIÓN QUE TENGO ENTRE MANOS
- Qué me planteo conseguir: [MÁQUINA, EQUIPO, VEHÍCULO, SOFTWARE, LOCAL, HERRAMIENTA]
- Para qué lo necesito y con qué frecuencia lo usaría: [DESCRIPCIÓN Y VECES POR SEMANA O MES]
- Opción COMPRAR: precio [IMPORTE SIN IVA], vida útil estimada [AÑOS], mantenimiento anual [IMPORTE], consumibles o licencias [IMPORTE/AÑO], valor de reventa estimado al final [IMPORTE]
- Opción ALQUILAR o pagar por uso: [PRECIO POR DÍA, MES O USO] y condiciones [PERMANENCIA, MÍNIMOS]
- Opción SUBCONTRATAR: [PRECIO POR TRABAJO O POR HORA DEL PROVEEDOR]
- Qué hago hoy sin ninguna de las tres: [DESCRIPCIÓN: lo hago a mano, lo rechazo, lo pierdo]
- Dinero disponible en caja ahora mismo: [IMPORTE]
- Mis gastos fijos mensuales: [IMPORTE]
- Trabajos al mes en los que lo usaría: [NÚMERO] | Lo que cobro por cada uno: [IMPORTE]
- ¿Hay financiación sobre la mesa? [NO / SÍ: cuota, plazo, interés o TAE, entrada]

QUÉ TIENES QUE HACER
1. Reformula la decisión en una frase: qué problema real resuelve esto y qué pasa si no hago nada. Si la respuesta a "qué pasa si no hago nada" es "nada grave", dímelo antes de seguir.
2. Calcula el coste total de cada opción a 12, 24 y 36 meses. En COMPRAR incluye precio, mantenimiento, consumibles, seguro si aplica, coste de aprendizaje en horas, y resta el valor residual. En ALQUILAR incluye todos los meses aunque no lo use. En SUBCONTRATAR multiplica por el volumen previsto.
3. Convierte mis horas en dinero usando mi precio-hora: si una opción me ahorra horas, valóralas; si me añade trabajo (mantenimiento, aprendizaje, gestión), réstalas. Pídeme mi precio-hora si no te lo he dado.
4. Calcula el retorno de la compra: beneficio adicional al mes que genera (más trabajos, mayor precio, o ahorro respecto a subcontratar) y con eso el periodo de recuperación en meses. Si pasa de 24 meses en algo que se queda obsoleto rápido, avísame.
5. Evalúa el impacto en caja, no solo en beneficio: cuánto dinero sale de la cuenta el primer mes con cada opción y cuántos meses de gastos fijos me quedan de colchón después. Si la compra me deja por debajo de un mes de colchón, márcalo como riesgo alto.
6. Explica en lenguaje llano las diferencias prácticas en España: que comprar se amortiza a lo largo de varios años y no se deduce todo el primer año, que el renting o el alquiler suelen ser gasto corriente y más simples de gestionar, que el IVA de la compra suele deducirse si el bien está afecto a la actividad, y que en vehículos y bienes de uso mixto hay reglas especiales. Aclara que esto es orientación general y que la deducción concreta la confirma mi asesoría.
7. Detecta las trampas típicas: comprar por el descuento y no por la necesidad, financiación con cuota pequeña y plazo largo que multiplica el coste, equipo que solo sale a cuenta si el volumen crece (y el volumen no ha crecido todavía), permanencias en alquiler, y coste oculto de mantener y almacenar.
8. Propón siempre una cuarta opción: la versión mínima. Comprar de segunda mano, alquilar tres meses para validar la demanda, subcontratar hasta llegar a X trabajos al mes y comprar solo entonces. Dime el número exacto de trabajos mensuales a partir del cual comprar gana.
9. Da una recomendación clara con su condición: "compra si y solo si...".

RESTRICCIONES
- Nada de recomendar financiación sin enseñar el coste total de los intereses.
- No afirmes porcentajes de amortización ni deducciones concretas: menciona que existen y remite a la asesoría.
- Si me faltan datos clave, pídemelos antes de dar una recomendación en firme.
- Sin promesas de ingresos: los trabajos futuros son un supuesto mío, no un hecho.

FORMATO DE LA RESPUESTA
1) LA DECISIÓN EN UNA FRASE y qué pasa si no hago nada.
2) TABLA COMPARATIVA: Opción | Coste 12 meses | Coste 24 meses | Coste 36 meses | Salida de caja inicial | Horas mías al mes | Riesgo.
3) PUNTO DE EQUILIBRIO: a partir de cuántos trabajos al mes gana cada opción.
4) PERIODO DE RECUPERACIÓN de la compra, con la cuenta.
5) IMPACTO EN CAJA y colchón que me queda.
6) TRAMPAS DETECTADAS en mi caso concreto.
7) LA VERSIÓN MÍNIMA que probaría primero.
8) RECOMENDACIÓN con su "compra si y solo si".

CRITERIOS DE CALIDAD
- Las tres opciones se comparan con el mismo horizonte temporal y con y sin IVA de forma coherente.
- El periodo de recuperación se calcula con ingresos adicionales realistas, no con el mejor de los casos.
- La recomendación es una sola y va con condiciones medibles.
- No hay ninguna cifra que no venga de mis datos o de una fórmula que has enseñado.
```
