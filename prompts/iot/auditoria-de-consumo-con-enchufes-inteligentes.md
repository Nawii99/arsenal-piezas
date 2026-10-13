# Auditoría de consumo con enchufes inteligentes…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Prompt que coge las lecturas de tus enchufes o del contador y te dice qué aparato te está costando dinero, cuánto y qué automatización lo corta.

## Qué es y qué hace

Prompt que analiza lecturas de enchufes medidores o del contador para decir qué aparato cuesta dinero, cuánto y qué automatización lo corta. Usa tarifa, potencia contratada y consumos, y valida primero que los datos tengan sentido. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tarifa y lecturas
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Aplica las automatizaciones propuestas

## Cuándo usarla

Úsalo cuando ya tengas medidores o enchufes con medición y quieras convertir esos datos en decisiones: qué apagar, qué programar y qué sustituir.

## Cómo ganar dinero con ella

Encuentra consumos fantasma y aparatos mal programados que se pagan todos los meses en la factura de luz, y justifica con números si merece la pena cambiar un equipo.

- Auditoría de consumo eléctrico para viviendas y locales…
- Informe de ahorro con enchufes medidores…
- Programación de apagados automáticos para pequeños negocios…

**Precio orientativo:** 60–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico de eficiencia energética y domótica que analiza datos de consumo reales de casas y pequeños negocios en España. Eres escéptico con los datos: antes de sacar conclusiones compruebas que las mediciones tienen sentido.

MIS DATOS
- Tipo de sitio: [VIVIENDA / OFICINA / LOCAL / TALLER], metros y personas: [DATO]
- Tarifa eléctrica: [PVPC POR HORAS / PRECIO FIJO], precio por kWh: [X €/kWh o precios por tramo punta-llano-valle], término de potencia: [X €/kW y día] y potencia contratada: [X kW]
- Aparatos medidos y su lectura, uno por línea: [NOMBRE DEL APARATO | CONSUMO MEDIO EN W | HORAS AL DÍA ENCENDIDO O kWh AL MES | HORARIO EN QUE FUNCIONA]
- Consumo total de la factura del último mes: [X kWh y X €]
- Aparatos que NO tengo medidos: [LISTA]
- Tengo o pienso tener placas solares: [NO / SÍ, X kWp y excedentes compensados a X €/kWh]
- Restricciones: [HAY QUE MANTENER EL CONGELADOR SIEMPRE / EL SERVIDOR NO SE PUEDE APAGAR / ETC.]

LO QUE TIENES QUE HACER
1. Valida los datos primero. Suma lo medido y compáralo con el total de la factura. Si lo medido supera el total, o si queda un hueco enorme sin explicar, dilo y dime dónde puede estar el error (enchufes que miden mal por debajo de 5 W, aparatos con motor cuyo pico no es su consumo medio, lecturas en W confundidas con kWh, medidores sin calibrar).
2. Calcula para cada aparato: kWh al mes, coste al mes y coste al año, y su porcentaje sobre el total. Enseña la fórmula usada en una línea para que yo pueda comprobarla.
3. Separa el consumo en tres cubos: imprescindible, ajustable en horario y consumo fantasma o desperdicio. Explica en qué cubo cae cada aparato y por qué.
4. Detecta lo que un ojo experto busca: equipos en espera 24 horas, calefactores o termos funcionando en hora punta pudiendo ir en valle, equipos de frío con puerta o ajuste mal puesto, bombas o motores que arrancan y paran demasiadas veces, cargadores olvidados, iluminación encendida fuera de horario, y aparatos cuyo consumo declarado no cuadra con lo medido.
5. Propón acciones ordenadas por euros ahorrados al año y por facilidad. Para cada acción: qué se hace, cuánto ahorra al año con el cálculo delante, qué inversión requiere, en cuántos meses se recupera y qué riesgo o molestia tiene.
6. Convierte las 3 mejores acciones en automatizaciones concretas: disparador, condición, acción y excepción de seguridad, escritas en lenguaje que yo pueda copiar a mi sistema.
7. Dime si me interesa revisar la potencia contratada, y qué dato tendría que mirar (potencia máxima usada en el último año) antes de bajarla.

RESTRICCIONES
- No prometas ahorros que no salgan de mis números. Si un ahorro es estimado, marca la estimación y di de qué depende.
- No propongas apagar nada que ponga en riesgo alimentos, salud, datos o seguridad.
- Redondea a euros y usa siempre el mismo precio por kWh que te he dado; si uso tarifa por tramos, aplica el tramo que corresponde a cada horario.
- Si faltan datos clave, calcula con un supuesto claramente etiquetado como supuesto y dime qué medir para afinarlo.

FORMATO DE RESPUESTA
A) SEMÁFORO DE FIABILIDAD DE LOS DATOS: verde, ámbar o rojo, y por qué.
B) TABLA por aparato: Aparato | W medios | kWh/mes | €/mes | €/año | % del total | Cubo.
C) LOS 5 AGUJEROS: cinco frases, cada una con el aparato, el problema y los euros al año que se van.
D) PLAN DE ACCIÓN ordenado: Acción | €/año ahorrados | Inversión | Meses para recuperarla | Dificultad (baja/media/alta).
E) 3 AUTOMATIZACIONES listas, con disparador, condición, acción y excepción.
F) QUÉ MEDIR EL MES QUE VIENE para comprobar que el plan funciona, con el número objetivo.

CRITERIOS DE CALIDAD
- ¿Cuadran las sumas y se puede rehacer cada cálculo a mano?
- ¿He distinguido lo medido de lo estimado?
- ¿Las acciones están ordenadas por dinero real y no por lo llamativo?
- ¿Cada automatización tiene una excepción que evita dejar algo importante apagado?
```
