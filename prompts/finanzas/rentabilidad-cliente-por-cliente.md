# Rentabilidad cliente por cliente…

**Tipo:** Prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Identificas cuáles de tus clientes son rentables de verdad según horas y gastos, y a quién subirle precio.

## Qué es y qué hace

Prompt que actúa como asesor de rentabilidad para autónomos y analiza tu cartera de clientes. Recibe facturación, horas, gastos directos y días de cobro por cliente; devuelve la rentabilidad real por hora, un ranking y a qué clientes subir precio o dejar. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena una línea por cliente y los [corchetes]
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Contrasta los números con tu contabilidad
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando estés a tope de trabajo pero sin dinero en la cuenta, o antes de renovar tarifas con tus clientes.

## Cómo ganar dinero con ella

Detectar los clientes que dan pérdidas y reordenarlos sube el margen medio sin vender más ni trabajar más horas.

- Análisis de rentabilidad por cliente para autónomos y agencias…
- Revisión de tarifas antes de renovar contratos con clientes…
- Informe de clientes que dan pérdidas con plan de subida de precios…

**Precio orientativo:** 100–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El prompt (cópialo entero)

```text
Actúa como un asesor de rentabilidad para autónomos y micronegocios en España. Tu especialidad es coger la lista de clientes de alguien que va desbordado y enseñarle, con números, cuáles le están costando dinero aunque parezcan buenos.

CONTEXTO
- Mi negocio: [QUÉ HAGO Y PARA QUIÉN]
- Facturación de los últimos 12 meses (o de los meses que lleve): [IMPORTE]
- Horas que puedo trabajar de verdad al mes: [NÚMERO DE HORAS]
- Mis gastos fijos del negocio al mes: [IMPORTE]
- Lo que quiero cobrar yo al mes (mi sueldo objetivo, antes de impuestos): [IMPORTE]

DATOS POR CLIENTE (rellena una línea por cliente; si no sabes algo, pon una estimación y marca que es estimación)
Cliente | Facturado últimos 12 meses | Horas dedicadas al año (aproximadas) | Gastos directos que me genera (subcontratas, materiales, licencias, desplazamientos) | Días que tarda en pagarme | Nivel de follón del 1 al 5 (cambios, urgencias, mensajes fuera de horario)
[PEGA AQUÍ TUS CLIENTES]

QUÉ TIENES QUE HACER
1. Calcula mi coste-hora suelo: (gastos fijos del negocio al año + sueldo objetivo al año + provisión de impuestos del 25-30 % sobre lo que quiero cobrar) dividido entre las horas facturables reales del año. Ojo: las horas facturables no son todas las que trabajo; descuenta un 30 % para administración, presupuestos, formación y clientes que no salen. Enséñame la cuenta entera.
2. Para cada cliente calcula: margen bruto (facturado menos gastos directos), margen por hora (margen bruto entre horas), y compara ese margen por hora con mi coste-hora suelo.
3. Añade el coste oculto del follón: por cada punto de follón por encima de 2, súmale un 8 % de horas invisibles al cliente y recalcula. Explica que esto es una estimación, no un cálculo exacto.
4. Añade el coste financiero de cobrar tarde: los clientes que pagan a más de 45 días me obligan a adelantar dinero. Señálalos aunque su margen sea bueno.
5. Clasifica a cada cliente en cuatro grupos: ORO (margen por hora muy por encima del suelo y poco follón), SÓLIDO (por encima del suelo), A REPARAR (por debajo del suelo pero arreglable subiendo precio o recortando alcance), y SANGRÍA (por debajo del suelo, con follón alto o pagos tardíos).
6. Comprueba la concentración: qué porcentaje de mis ingresos viene del cliente más grande y de los tres más grandes. Si el mayor supera el 30 %, avísame de que eso es un riesgo y dime qué haría falta para bajarlo.
7. Para los A REPARAR, propón la palanca concreta: subida de precio con porcentaje, recorte de alcance, paso a paquete cerrado en vez de horas, o cambio de condiciones de pago.
8. Para los SANGRÍA, escríbeme dos versiones del mensaje: la subida de precio fuerte (si acepta, deja de ser sangría; si no, se va solo) y la despedida elegante con derivación a otro profesional.
9. Simula el escenario: si aplico todo lo que propones y pierdo a los clientes que probablemente digan que no, ¿cómo quedan mis ingresos, mis horas libres y mi margen medio? Muestra las tres cifras antes y después.

RESTRICCIONES
- Usa solo mis datos. Si un cliente tiene datos incompletos, calcúlalo igual pero márcalo como ESTIMACIÓN POCO FIABLE.
- No des consejo fiscal concreto: para cualquier duda de impuestos, remíteme a mi gestor.
- Nada de frases motivacionales ni de promesas de ingresos.
- Español de España, tuteando, sin tecnicismos de contabilidad sin explicar.

FORMATO DE LA RESPUESTA
1) MI COSTE-HORA SUELO, con la cuenta paso a paso y en euros.
2) TABLA DE CLIENTES ordenada de mejor a peor margen por hora, con columnas: Cliente | Facturado | Horas | Margen bruto | Margen/hora | Días de cobro | Follón | Grupo.
3) EL SEMÁFORO: tres listas cortas (subir precio, reordenar, soltar).
4) MENSAJES LISTOS PARA ENVIAR: subida de precio y despedida.
5) ESCENARIO DESPUÉS: ingresos, horas y margen medio comparados con hoy.
6) RIESGO DE CONCENTRACIÓN y qué hacer con él.

CRITERIOS DE CALIDAD
- Todos los clientes de mi lista aparecen clasificados, ninguno se queda fuera.
- Cada número que das se puede rastrear hasta un dato mío o hasta una fórmula que has enseñado.
- El escenario final no da por hecho que todos los clientes aceptan la subida: asume que una parte se va y dilo.
- Los mensajes son cortos, educados y no piden perdón por subir el precio.
```
