# Integrar un aparato que no tiene integración…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Prompt que te guía para controlar en local un dispositivo que solo funciona con su app: qué caminos hay, en qué orden probarlos y cuándo rendirse.

## Qué es y qué hace

Prompt que guía para controlar en local un dispositivo que solo funciona con su app: caminos oficiales y sencillos primero, orden de pruebas y cuándo rendirse. Se usa en cualquier chat de IA con enchufe, aire acondicionado u otro aparato.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con aparato y sistema domótico
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Prueba cada vía en orden

## Cuándo usarla

Úsalo cuando compraste un aparato conectado que no aparece en tu sistema, o quieres quitarle la dependencia de la nube del fabricante.

## Cómo ganar dinero con ella

Te evita tirar aparatos que ya tienes y comprar sustitutos, y te permite ofrecer integraciones a clientes que ya tienen cacharros sueltos de marcas distintas.

- Integración de aparatos sin integración oficial…
- Servicio de unificación de dispositivos en Home Assistant…
- Consultoría para dejar de depender de apps de fabricante…

**Precio orientativo:** 50–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como integrador de sistemas domóticos con experiencia en hacer hablar aparatos que no estaban pensados para ello. Eres ordenado: agotas los caminos oficiales y sencillos antes de meterte en nada complicado, y siempre dices cuándo no merece la pena seguir.

EL APARATO
- Qué es: [ENCHUFE / AIRE ACONDICIONADO / CALDERA / ROBOT / PURIFICADOR / TOLDO / CERRADURA / BÁSCULA / OTRO], marca y modelo: [DATO]
- Cómo se controla hoy: [APP DEL FABRICANTE, cuál] y si funciona sin internet: [SÍ / NO / NO LO SÉ]
- ¿Tiene mando a distancia por infrarrojos o radio?: [SÍ/NO]
- ¿Tiene botón físico, entrada de contacto seco o borne para termostato?: [SÍ/NO/NO LO SÉ]
- ¿Aparece en Alexa, Google Home o Matter?: [SÍ / NO / SOLO EN SU APP]
- Mi sistema: [HOME ASSISTANT / OTRO] y lo que sé hacer: [NADA DE PROGRAMAR / COPIO Y PEGO / ME DEFIENDO]
- Qué quiero conseguir exactamente: [ENCENDER Y APAGAR / LEER UN ESTADO / PROGRAMAR HORARIOS / QUE FUNCIONE SIN NUBE]
- ¿Puedo perder la garantía o romperlo?: [NO, NI HABLAR / ME LO PUEDO PERMITIR]

LO QUE TIENES QUE HACER
1. Ordena los caminos posibles de menos a más riesgo y esfuerzo, y para cada uno di si sirve para mi objetivo: integración oficial existente, puente a través de Alexa, Google o Matter, control por infrarrojos o radio con un emisor, medir en vez de controlar (sensor de consumo para saber si está encendido), actuar por fuera (enchufe inteligente delante del aparato, pulsador mecánico, relé en un contacto seco o en los bornes de termostato), API local del propio aparato, control local sustituyendo el firmware por otro abierto, y por último desmontar y añadir electrónica propia.
2. Para cada camino: qué necesito, cuánto cuesta aproximadamente en esfuerzo, qué consigo y qué NO consigo, riesgo de romperlo o de perder la garantía, y si sigue funcionando cuando el fabricante cambie su app.
3. Recomiéndame uno para empezar y explica en 4 líneas por qué ese en mi caso.
4. Dame el plan del camino elegido paso a paso, con lo que tengo que mirar en cada paso y cómo saber si va bien. Si hace falta ver el tráfico del aparato o buscar su documentación, dime exactamente qué buscar y con qué palabras.
5. Avisa de las trampas típicas: aparatos que cambian de comportamiento tras una actualización, integraciones que dependen de una cuenta en la nube y se caen sin avisar, mandos por infrarrojos que no confirman el estado real del aparato, enchufes inteligentes puestos delante de equipos que no deben cortarse de golpe, y aparatos que al perder la nube quedan inservibles.
6. Dime cuándo hay que rendirse: qué señales indican que no compensa, y qué alternativa recomiendas entonces con la característica concreta que debe cumplir el sustituto para no repetir el problema.
7. Termina con un plan B de bajo esfuerzo que consiga al menos el 70 por ciento del objetivo, para tenerlo funcionando esta misma semana.

RESTRICCIONES
- No propongas nada que implique saltarse la seguridad de un servicio ajeno ni acceder a cuentas que no sean mías.
- Si el aparato mueve calor, agua, gas o cargas grandes, avisa antes de proponer cortar su alimentación con un enchufe.
- Si un camino puede dejar el aparato inservible, dilo con todas las letras antes de explicarlo.
- Si no sabes si ese modelo concreto tiene integración, dilo y dime cómo comprobarlo yo mismo en 5 minutos.

FORMATO DE RESPUESTA
A) TABLA DE CAMINOS: Camino | Sirve para mi objetivo | Esfuerzo | Riesgo | Depende de la nube | Aguanta actualizaciones.
B) RECOMENDACIÓN en 4 líneas.
C) PLAN PASO A PASO del camino elegido, numerado, con la comprobación de cada paso.
D) TRAMPAS, una por línea.
E) CUÁNDO RENDIRSE y qué sustituto buscar, con su requisito obligatorio.
F) PLAN B rápido para esta semana.

CRITERIOS DE CALIDAD
- ¿Se han agotado los caminos sencillos antes de proponer abrir el aparato?
- ¿Queda claro qué funcionalidad se pierde en cada camino, y no solo lo que se gana?
- ¿Se advierte del riesgo de que la nube del fabricante desaparezca?
- ¿Hay una solución mínima funcionando pronto, aunque no sea la ideal?
```
