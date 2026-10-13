# Punto muerto y suelo de precios…

**Tipo:** Prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Calcula cuánto tienes que vender cada mes para no perder dinero y cuál es el precio por debajo del cual trabajas gratis.

## Qué es y qué hace

Prompt que actúa como analista de costes para micronegocios. Recibe precio, coste directo, gastos fijos, sueldo objetivo y ventas actuales; devuelve el punto muerto en unidades, el precio suelo y las cuentas paso a paso para repetirlas tú. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tus costes y precios
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Verifica los cálculos
5. Que lo revise un profesional

## Cuándo usarla

Úsalo antes de aceptar un encargo barato, de montar una promoción o cuando no sabes si tu negocio da para vivir.

## Cómo ganar dinero con ella

Saber el umbral exacto evita aceptar trabajos que te dejan en pérdidas y te da un argumento sólido para no bajar precios.

- Cálculo de punto muerto y precio mínimo para autónomos…
- Estudio de viabilidad de un servicio antes de lanzarlo…
- Revisión de tarifas con hoja de cálculo reutilizable…

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El prompt (cópialo entero)

```text
Actúa como un analista de costes especializado en micronegocios españoles. Tu trabajo es calcular el punto muerto (umbral de rentabilidad) y el precio suelo, y explicar cada paso con la cuenta a la vista para que alguien sin formación contable lo entienda y lo pueda repetir solo.

DATOS DEL NEGOCIO
- Qué vendo: [PRODUCTO O SERVICIO]
- Precio de venta actual por unidad o por trabajo: [IMPORTE, indica si con o sin IVA]
- Coste directo por unidad o por trabajo (materiales, subcontratas, envío, packaging, comisiones de pasarela o marketplace): [DETALLE POR CONCEPTO]
- Gastos fijos mensuales del negocio: [ALQUILER, CUOTA DE AUTÓNOMOS, ASESORÍA, SOFTWARE, SUMINISTROS, SEGUROS, INTERNET, TELÉFONO...]
- Lo que necesito sacar yo al mes para vivir, ya en el bolsillo: [IMPORTE]
- Horas que puedo trabajar de verdad al mes: [NÚMERO]
- Unidades o trabajos que vendo al mes ahora mismo: [NÚMERO]
- Régimen: [AUTÓNOMO / SL] y tipo de IVA que aplico: [21 % / 10 % / 4 % / EXENTO]

QUÉ TIENES QUE HACER
1. Aclara primero la diferencia entre coste fijo y coste variable con mis propios ejemplos, en dos frases, sin teoría de manual.
2. Trabaja siempre sin IVA. Si te he dado precios con IVA, conviértelos y dímelo. Recuerda que el IVA no es ingreso mío ni el IVA soportado es un gasto si me lo deduzco.
3. Calcula el margen de contribución por unidad: precio sin IVA menos coste variable por unidad. Y el margen en porcentaje.
4. Calcula el punto muerto puro: gastos fijos mensuales dividido entre el margen de contribución. Eso son las unidades que necesito vender para no perder dinero, sin cobrar yo nada.
5. Calcula el punto muerto con sueldo: añade a los gastos fijos mi retirada personal y una provisión de impuestos del 25-30 % sobre esa retirada. Ese es el número real que me interesa. Explica que la provisión es una regla práctica y que el porcentaje exacto lo confirma mi gestor.
6. Traduce esos números a lo que yo entiendo: unidades al mes, unidades a la semana, unidades al día laborable, y euros de facturación al mes.
7. Compara con lo que vendo ahora y dime la distancia exacta: cuántas unidades me faltan o me sobran.
8. Calcula mi precio suelo por hora: (gastos fijos + retirada + provisión de impuestos) dividido entre las horas facturables reales. Descuenta el 30 % de mis horas totales porque se van en administración, presupuestos y clientes que no salen. Si mi precio actual queda por debajo del suelo, dilo sin suavizarlo.
9. Haz un análisis de sensibilidad en tabla: qué pasa con el punto muerto si subo el precio un 10 %, si bajo el coste variable un 10 %, si los gastos fijos suben 200 euros al mes, y si me hacen un 20 % de descuento. Muestra en cada caso cuántas unidades más o menos necesito.
10. Cierra con las tres palancas ordenadas por impacto para mi caso concreto y con la advertencia clásica: una bajada de precio del 10 % no se compensa vendiendo un 10 % más.

RESTRICCIONES
- Enseña siempre la fórmula y luego el número, para que pueda rehacerlo en una hoja de cálculo.
- No mezcles nunca importes con IVA e importes sin IVA en la misma cuenta.
- No des por buenos los datos que huelan a error: si algo no cuadra (por ejemplo coste variable mayor que el precio), párate y avísame.
- Nada de promesas de ingresos ni de cifras del sector inventadas.

FORMATO DE LA RESPUESTA
1) MIS NÚMEROS ORDENADOS: tabla con precio sin IVA, coste variable, margen unitario, margen %, gastos fijos, retirada, provisión de impuestos.
2) LOS TRES NÚMEROS QUE IMPORTAN, en grande: punto muerto sin sueldo, punto muerto con sueldo, precio suelo por hora.
3) TRADUCCIÓN A MI DÍA A DÍA: al mes, a la semana, al día.
4) DÓNDE ESTOY HOY respecto al punto muerto.
5) TABLA DE SENSIBILIDAD con los cuatro escenarios.
6) LAS TRES PALANCAS y qué hago con cada una esta semana.
7) AVISOS: los datos que me faltan o que parecen mal metidos.

CRITERIOS DE CALIDAD
- Todas las divisiones y multiplicaciones aparecen escritas, no solo el resultado.
- Los números redondeados no rompen el cuadre: si redondeas, avisa.
- El precio suelo tiene en cuenta las horas no facturables, no las horas totales.
- Al final entiendo por qué un descuento pequeño puede comerse casi todo mi margen.
```
