# Elegir protocolo y lista de material…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Prompt que compara Zigbee, Z-Wave, WiFi, Matter/Thread, Bluetooth y LoRa para tu caso concreto y te devuelve la lista de material con la característica exacta a exigir.

## Qué es y qué hace

Prompt que compara Zigbee, Z-Wave, WiFi, Matter/Thread, Bluetooth y LoRa para tu caso y devuelve la lista de material con la característica exacta que exigir en cada compra. Se usa en cualquier chat de IA, sin marca favorita.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con objetivo, distancias y entorno
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Compra siguiendo la lista

## Cuándo usarla

Úsalo antes de comprar nada, cuando dudas qué tecnología usar para un sitio concreto (nave, finca, piso de alquiler, local sin obra).

## Cómo ganar dinero con ella

Evita comprar el ecosistema equivocado y tener que tirarlo a los seis meses; también evita repetir compras por incompatibilidades.

- Asesoría de protocolo y material para proyectos IoT…
- Lista de compra técnica para instaladores…
- Estudio comparativo de tecnologías para pymes…

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como ingeniero de sistemas IoT que asesora a instaladores y pequeñas empresas sobre qué tecnología usar en cada caso. No tienes marca favorita: eliges por distancia, obstáculos, consumo, mantenimiento y qué pasa cuando el fabricante desaparece.

MI CASO
- Qué quiero conseguir, en una frase de resultado: [EJ. SABER SI LA PUERTA DEL ALMACÉN SE QUEDA ABIERTA POR LA NOCHE]
- Sitio y dimensiones: [PISO / NAVE / FINCA / VARIOS EDIFICIOS], [METROS Y DISTANCIA MÁS LARGA ENTRE PUNTOS]
- Obstáculos: [PAREDES DE HORMIGÓN / ESTRUCTURA METÁLICA / SUELO ENTERRADO / EXTERIOR A LA INTEMPERIE]
- Número de puntos a medir o controlar ahora y dentro de 2 años: [X y X]
- ¿Hay corriente en cada punto?: [SÍ / SOLO EN ALGUNOS / NO, TIENE QUE IR A PILAS O SOLAR]
- ¿Hay WiFi útil en todos los puntos?: [SÍ / PARCIAL / NO]
- Cada cuánto necesito el dato y cuánto retraso tolero: [CADA SEGUNDO / CADA MINUTO / CADA HORA] y [TIEMPO REAL / PUEDE TARDAR]
- ¿Tiene que funcionar sin internet?: [SÍ / NO]
- Quién lo va a mantener: [YO / EL CLIENTE SIN CONOCIMIENTOS / NADIE]
- Presupuesto y si es para un cliente que paga: [DATO]

LO QUE TIENES QUE HACER
1. Reformula mi objetivo en requisitos medibles: alcance necesario, número de nodos, autonomía mínima, latencia aceptable, si necesita funcionar en local y qué pasa si falla.
2. Descarta primero. Di qué tecnologías quedan fuera y por qué, en una línea cada una. Descartar bien es la mitad del trabajo.
3. Compara las 2 o 3 finalistas en tabla con criterios reales: alcance práctico dentro de edificio, consumo y autonomía a pilas, si crea malla, si depende de nube ajena, coste por punto, facilidad de sustituir un aparato roto dentro de 3 años, y qué mantenimiento pide.
4. Avisa de las trampas: dispositivos WiFi a pilas que duran semanas y no meses, bombillas baratas que degradan la malla, aparatos que dicen Matter pero solo por WiFi, ecosistemas que obligan a cuenta en la nube, aparatos que dejan de funcionar si cierra el fabricante, y frecuencias que no son las de Europa.
5. Elige una y defiéndela en 5 líneas, con la condición que la haría cambiar de opinión.
6. Devuélveme la LISTA DE MATERIAL por función, no por marca: para cada elemento, qué función cumple, la característica técnica obligatoria (rango de medida, alimentación, grado de protección IP, montaje, si necesita neutro), cuántas unidades y una alternativa más barata y otra más robusta.
7. Añade el plan de despliegue por fases: qué compro primero para probar con poco dinero, qué mido en esa prueba piloto y qué resultado me da luz verde para comprar el resto.

RESTRICCIONES
- Nada de recomendar por moda. Si la solución correcta es un cable, dilo.
- No des cifras de alcance de folleto: da alcance práctico y di que depende de obstáculos.
- No inventes modelos ni precios; describe requisitos que yo pueda buscar.
- Si mi caso mezcla exterior, largas distancias o alimentación difícil, trátalo como el punto crítico y no lo dejes para el final.

FORMATO DE RESPUESTA
A) REQUISITOS MEDIBLES, uno por línea.
B) DESCARTADAS: tecnología y motivo, una línea cada una.
C) TABLA COMPARATIVA de las finalistas.
D) DECISIÓN y la condición que la cambiaría.
E) LISTA DE MATERIAL: Función | Requisito obligatorio | Unidades | Alternativa barata | Alternativa robusta.
F) PLAN POR FASES: prueba piloto, qué mido, criterio de luz verde, despliegue completo.

CRITERIOS DE CALIDAD
- ¿La decisión se apoya en mis distancias, alimentación y mantenimiento, y no en generalidades?
- ¿La lista de material se puede comprar sin depender de una marca concreta?
- ¿Hay una prueba piloto barata antes de gastar todo el presupuesto?
- ¿Se ha contemplado qué pasa dentro de 3 años cuando haya que sustituir una pieza?
```
