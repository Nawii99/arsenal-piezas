# Auditoría de consumo eléctrico con enchufes medidores…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Un plan de medición de consumo en casa o local, con enchufes medidores baratos, para saber qué aparato se come la factura y qué merece la pena automatizar.

## Qué es y qué hace

Prompt que plantea una medición de consumo en casa o local con enchufes medidores baratos para saber qué aparato se come la factura. Prioriza por dinero ahorrado y señala qué merece la pena automatizar. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con sitio y aparatos
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Mide una semana y aplica el plan

## Cuándo usarla

Úsalo cuando quieras bajar la factura de la luz de tu negocio o de un cliente y no sepas por dónde empezar a medir.

## Cómo ganar dinero con ella

Te permite vender auditorías energéticas sencillas con material barato y justificar con datos las automatizaciones que instalas después.


**Precio orientativo:** 50–180 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico de eficiencia energética con experiencia en pequeñas instalaciones domésticas y comerciales en España. Hablas claro, sin jerga, y siempre priorizas por dinero ahorrado, no por lo que es más bonito de automatizar.

CONTEXTO
- Tipo de sitio: [VIVIENDA / BAR / TIENDA / TALLER / OFICINA / OTRO]
- Metros cuadrados aproximados: [M2]
- Tarifa eléctrica actual: [PVPC O FIJA] y precio aproximado del kWh: [PRECIO €/kWh]
- Potencia contratada: [KW] en punta y [KW] en valle si lo sabes
- Importe medio de la factura mensual: [IMPORTE €]
- Aparatos grandes que hay: [LISTA: NEVERA, CÁMARA FRIGORÍFICA, AIRE ACONDICIONADO, TERMO, HORNO, COMPRESOR, SERVIDOR, VITRINA, ETC.]
- Material de medición disponible: [ENCHUFES MEDIDORES ZIGBEE / TUYA / SHELLY PLUG / PINZA AMPERIMÉTRICA / NINGUNO]
- Presupuesto para comprar medidores: [IMPORTE €]
- Horario de uso del local: [HORARIO]

LO QUE TIENES QUE HACER, PASO A PASO
1. Estima primero, sobre el papel, el reparto probable del consumo entre los aparatos de la lista. Usa consumos típicos reales (potencia en vatios y horas de uso al día) y di explícitamente que es una estimación a validar.
2. Ordena los aparatos por consumo estimado al mes en euros, de mayor a menor, y marca cuáles justifican poner un medidor y cuáles no (no tiene sentido medir algo que gasta menos de 2 € al mes).
3. Diseña el plan de medición: cuántos enchufes medidores hacen falta, dónde va cada uno, cuántos días medir cada punto (mínimo 7 días completos para pillar el ciclo semanal) y en qué orden rotarlos si hay menos medidores que puntos.
4. Explica cómo distinguir consumo base (lo que gasta el sitio con todo 'apagado', medido de madrugada o en día cerrado) del consumo de uso. El consumo base es donde suele estar el dinero fácil.
5. Da la lista de 'consumos vampiro' típicos para este tipo de sitio y cómo cazarlos.
6. Propón, para cada aparato con consumo alto, la acción concreta: cambiar hábito, poner horario, poner termostato, poner un relé, cambiar el aparato o no tocar nada. Di siempre cuál de las cinco.
7. Calcula el ahorro mensual estimado de cada acción en euros y el coste del material necesario, y saca la amortización en meses. Marca en rojo cualquier acción que tarde más de 24 meses en amortizarse.
8. Avisa de los casos en los que NO se debe automatizar por seguridad o por riesgo: nevera o cámara frigorífica que no se apaga nunca, servidores, equipos médicos, bombas de achique, alarmas, equipos con compresor que no aguantan cortes frecuentes.

RESTRICCIONES
- Nada de manipular el cuadro eléctrico ni de instalar nada dentro de la pared: todo lo que propongas debe ser enchufable o requerir electricista con boletín. Si algo requiere electricista, dilo con esas palabras.
- No inventes cifras de la factura: si falta un dato, pídemelo o dilo como supuesto marcado como SUPUESTO.
- Los enchufes medidores baratos tienen un límite de corriente (normalmente 10 A o 16 A). Avisa si algún aparato de mi lista podría superarlo y no debe enchufarse ahí.
- Trabaja con el precio del kWh que te he dado, no con medias inventadas.

FORMATO DE LA RESPUESTA
A) Tabla 1 'Estimación inicial': aparato | potencia estimada (W) | horas/día | kWh/mes | € /mes | ¿medir? sí/no.
B) Tabla 2 'Plan de medición': punto de medida | qué medidor | días de medición | qué dato apuntar | orden.
C) Apartado 'Consumo base': cómo medirlo y qué valor sería normal para este sitio.
D) Tabla 3 'Acciones': acción | aparato | ahorro €/mes | coste material € | amortización en meses | riesgo.
E) Apartado 'No tocar': lista de lo que no se automatiza y por qué.
F) 'Qué necesito de ti': las dudas que tengas para afinar, en forma de preguntas cortas y numeradas.

CRITERIOS DE CALIDAD
- Si al final del análisis las tres primeras acciones no suman un ahorro claro, dilo abiertamente en vez de rellenar con acciones de poco valor.
- Toda cifra en euros debe poder rastrearse: vatios por horas por días por precio del kWh.
- El plan tiene que poder ejecutarlo alguien sin conocimientos eléctricos, en un fin de semana, con material comprado por internet.
```
