# Escribir las reglas de automatización…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Convierte lo que quieres que pase en casa o en el negocio en reglas bien escritas (disparador, condiciones, acción, excepciones) listas para programarlas sin sustos.

## Qué es y qué hace

Prompt que convierte una idea del tipo «que la luz se encienda si...» en reglas de automatización bien escritas: disparador, condiciones, acción y excepciones. Pensado para app del fabricante o paneles como Home Assistant. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu idea y aparatos
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Copia las reglas al sistema y pruébalas

## Cuándo usarla

Úsalo antes de tocar la app o el panel de automatizaciones, cuando tengas una idea del tipo «que la luz se encienda si...» y quieras que no se vuelva loca.

## Cómo ganar dinero con ella

Evita automatizaciones que molestan al cliente y generan llamadas de soporte; unas reglas bien escritas se programan en un rato y no hay que rehacerlas.

- Diseño de automatizaciones domóticas para particulares…
- Configuración de reglas para locales y oficinas…
- Revisión de automatizaciones que molestan o fallan…

**Precio orientativo:** 40–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como diseñador de automatizaciones domóticas. Tu especialidad es que las reglas no molesten: sabes que una automatización que se dispara cuando no toca es peor que no tener ninguna, y que el usuario debe poder saltársela siempre.
Mi caso:
- Sitio: [CASA / LOCAL / OFICINA / ALMACÉN]
- Lo que quiero que pase, con mis palabras: [IDEA TAL CUAL LA PIENSO]
- Aparatos que ya tengo o voy a tener: [LISTA DE SENSORES Y APARATOS]
- Quién vive o trabaja allí: [PERSONAS, EDADES, MASCOTAS]
- Horarios reales del sitio: [HORARIOS]
- Sistema donde lo voy a programar: [APP DEL FABRICANTE / PANEL TIPO HOME ASSISTANT / ASISTENTE DE VOZ / NO LO SÉ]
Tu tarea: convertir mi idea en reglas escritas con precisión, con todas las excepciones pensadas, para que yo solo tenga que copiarlas al sistema.
Trabaja así:
PASO 1. Reescribe mi idea en la estructura de cuatro partes: CUÁNDO ocurre el disparador, SI se cumplen estas condiciones, ENTONCES pasa esto, SALVO QUE pase esto otro. Explícame por qué el «salvo que» es la parte que separa una automatización buena de una pesada.
PASO 2. Piensa los casos raros de mi caso concreto: qué pasa de noche, qué pasa si hay alguien durmiendo, qué pasa si el sensor se queda colgado, qué pasa si alguien ha apagado la luz a mano hace un minuto, qué pasa si hay dos personas y una entra y otra sale, qué pasa si se va la luz y vuelve, y qué pasa cuando el sitio está vacío una semana.
PASO 3. Añade a cada regla las protecciones estándar: tiempo mínimo entre disparos para que no se encienda y apague sin parar, retardo de apagado para que no deje a nadie a oscuras, prioridad del mando manual sobre la automatización durante un rato, y modo vacaciones o modo fiesta que desactiva todo.
PASO 4. Marca qué reglas deben funcionar aunque no haya internet y cuáles pueden vivir en la nube, y qué pasa exactamente si cae la conexión.
PASO 5. Ordena las reglas por valor: primero las que resuelven una molestia diaria, después las que ahorran energía, y al final las que son un capricho bonito. Dime cuáles montar la primera semana.
PASO 6. Para cada regla, escribe la prueba de aceptación: qué hago yo para provocarla a propósito y qué debe ocurrir exactamente.
PASO 7. Escribe la explicación para la persona que vive allí, en una línea por regla, sin jerga, del estilo «cuando entras al baño por la noche se enciende una luz suave y se apaga sola a los tres minutos».
Restricciones:
- Nada que dependa de que el usuario recuerde una orden de voz complicada.
- Ninguna regla que deje a alguien encerrado, a oscuras o sin calefacción por un fallo de sensor: incluye siempre el camino de seguridad.
- Máximo [NÚMERO] reglas en total: si tengo demasiadas ideas, elige las mejores y dime cuáles descartas y por qué.
- No des por hecho que tengo sensores que no he nombrado.
Formato de la respuesta:
1) TABLA DE REGLAS: Nombre corto | Cuándo | Si | Entonces | Salvo que | Funciona sin internet.
2) DETALLE por regla con las protecciones aplicadas y los tiempos concretos en minutos.
3) ORDEN DE MONTAJE por semanas.
4) PRUEBAS DE ACEPTACIÓN, una por regla.
5) HOJA PARA EL USUARIO: una línea por regla en lenguaje de calle.
6) LO QUE NO AUTOMATIZO y por qué.
Criterios de calidad: está bien si cada regla tiene su excepción pensada, si puedo probarlas todas en una tarde, y si alguien que no ha montado nada entiende leyendo la hoja de usuario qué va a pasar en su casa.
```
