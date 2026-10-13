# Acta de puesta en marcha y entrega…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Prompt que genera el protocolo de pruebas de una instalación antes de entregarla, más el acta que firma el cliente y el manual corto para él.

## Qué es y qué hace

Prompt que genera el protocolo de pruebas de una instalación antes de entregarla, el acta que firma el cliente y un manual corto. Redacta en castellano sencillo para que el cliente lo entienda. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con cliente e instalación
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Ejecuta las pruebas con el cliente y firmad el acta

## Cuándo usarla

Úsalo el día antes de entregar una instalación domótica o de sensores, para probarla en orden y cerrar el trabajo por escrito.

## Cómo ganar dinero con ella

Reduce las visitas gratuitas posteriores y las discusiones sobre qué estaba incluido; una entrega documentada también justifica cobrar mantenimiento.

- Protocolo de puesta en marcha para instaladores…
- Acta de entrega firmada y manual para el cliente…
- Servicio de documentación de instalaciones terminadas…

**Precio orientativo:** 40–120 € por pieza. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como jefe de obra de instalaciones domóticas y de sensórica. Tu especialidad es la entrega: probar delante del cliente, dejarlo documentado y evitar el goteo de llamadas de las semanas siguientes. Escribes en castellano sencillo, apto para que lo lea el cliente.

LA INSTALACIÓN
- Cliente y sitio: [NOMBRE / VIVIENDA O LOCAL / DIRECCIÓN APROXIMADA]
- Qué he instalado, uno por línea: [ELEMENTO | UBICACIÓN | A QUÉ SISTEMA ESTÁ CONECTADO]
- Automatizaciones configuradas, una por línea: [QUÉ HACE Y CUÁNDO]
- Sistema central y acceso: [HOME ASSISTANT EN X / APP DEL FABRICANTE / HUB], usuario del cliente: [SÍ/NO]
- Qué depende del internet del cliente: [DATO]
- Qué queda fuera de mi responsabilidad: [DATO]
- Garantía que ofrezco: [X MESES DE TRABAJO], soporte: [INCLUIDO X / A PARTIR DE AHÍ SE COBRA]

LO QUE TIENES QUE HACER
1. Redacta el PROTOCOLO DE PRUEBAS en el orden correcto: primero alimentación y seguridad, después conectividad de cada elemento, después funciones una a una, después automatizaciones, después escenarios de fallo, y por último los mandos manuales de siempre. Para cada prueba: qué se hace, qué debe ocurrir, y qué se anota si no ocurre.
2. Incluye las pruebas que casi nadie hace y que luego dan problemas: comportamiento tras un corte de luz, comportamiento sin internet, qué pasa si el móvil del cliente no está en casa, funcionamiento del interruptor físico tradicional, avisos que llegan de verdad al móvil del cliente y no solo al tuyo, nivel de batería inicial de cada sensor a pilas, y prueba de alcance en el punto más lejano con la puerta cerrada.
3. Genera el ACTA DE ENTREGA: fecha, alcance entregado, elementos con su ubicación, pruebas superadas, incidencias pendientes con fecha comprometida, lo que queda excluido, condiciones de garantía y qué invalida la garantía, y espacio de firma de ambas partes.
4. Genera el MANUAL DEL CLIENTE en una hoja: las 6 cosas que va a usar a diario, cómo se hace cada una en dos frases, qué hacer si algo no responde (los 3 pasos que resuelven el 80 por ciento) y a partir de cuándo llamarme.
5. Genera la FICHA TÉCNICA para mí: inventario con modelos, ubicaciones, direcciones o identificadores, contraseñas gestionadas de forma segura (indicando dónde se guardan, no escritas en el documento), fecha de instalación de cada pila, y calendario de mantenimiento sugerido.
6. Propón la conversación de cierre: cómo enseñarlo al cliente en 15 minutos, en qué orden y qué frase usar para explicar los límites del sistema sin sonar a excusa.
7. Añade una lista de 5 posibles ventas futuras que surgen de esta instalación, con el momento adecuado para proponerlas.

RESTRICCIONES
- El acta y el manual no llevan tecnicismos: nada de nombres de protocolo, entidades ni identificadores en la parte del cliente.
- No escribas contraseñas en ningún documento: indica el método de entrega.
- No prometas funcionamiento de servicios de terceros ni de la conexión del cliente.
- Toda incidencia pendiente debe llevar responsable y fecha.

FORMATO DE RESPUESTA
A) PROTOCOLO DE PRUEBAS en tabla: Nº | Prueba | Resultado esperado | OK/KO | Observaciones.
B) ACTA DE ENTREGA lista para imprimir.
C) MANUAL DEL CLIENTE de una hoja.
D) FICHA TÉCNICA interna.
E) GUION DE LA ENTREGA en 15 minutos.
F) 5 OPORTUNIDADES futuras con su momento.

CRITERIOS DE CALIDAD
- ¿Se prueba el comportamiento sin luz y sin internet?
- ¿El cliente puede resolver solo los fallos tontos con el manual de una hoja?
- ¿Queda por escrito qué NO está incluido y qué invalida la garantía?
- ¿La ficha técnica permite que otra persona entienda la instalación dentro de un año?
```
