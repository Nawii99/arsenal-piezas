# Cuánto te cuesta cada conversación de IA…

**Tipo:** Prompt · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Calcula el coste real por conversación o por tarea de tu asistente, compara modelos y te da tres palancas concretas para bajarlo sin perder calidad.

## Qué es y qué hace

Prompt que calcula el coste real por conversación o tarea de un asistente de IA. Entran herramienta, volumen y qué se manda en cada mensaje; sale la fórmula con tus números, escenario esperado y peor, comparación de modelos y tres palancas para bajar el gasto. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con tus datos de uso
3. Revisa el cálculo y el peor escenario
4. Aplica las palancas de ahorro

## Cuándo usarla

Úsalo antes de dejar un bot funcionando con clientes o cuando la factura de la herramienta de IA empiece a subir sin control.

## Cómo ganar dinero con ella

Te dice qué precio mínimo tienes que cobrar por un servicio con IA para no perder dinero, y suele recortar gasto cambiando lo que se manda en cada mensaje.

- Cálculo de costes de asistentes de IA antes de fijar precio…
- Optimización del gasto en IA de pequeños negocios…
- Presupuesto de mantenimiento mensual de bots…

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como analista de costes de proyectos con IA para pequeños negocios. Hablas claro y siempre pones el peor escenario al lado del esperado.

DATOS DE MI CASO
Qué hace el asistente: [DESCRIPCIÓN]
Herramienta o modelo que uso: [NOMBRE Y PLAN]
Precio que pago hoy: [SUSCRIPCIÓN MENSUAL O PRECIO POR USO QUE VEA EN MI PANEL]
Volumen esperado: [CONVERSACIONES O TAREAS AL DÍA]
Longitud típica: [CUÁNTOS MENSAJES POR CONVERSACIÓN Y SI ADJUNTO DOCUMENTOS]
Qué mando en cada mensaje: [INSTRUCCIONES FIJAS, CATÁLOGO ENTERO, HISTORIAL COMPLETO...]
Lo que cobro al cliente por esto, si lo cobro: [IMPORTE O 'USO INTERNO']

QUÉ TIENES QUE HACER
1. Explícame en lenguaje llano de qué depende el coste: lo que entra, lo que sale, cuántas veces se repite y qué parte se paga aunque el cliente no diga nada útil.
2. Con mis datos, monta el cálculo paso a paso y enséñame la fórmula con mis números metidos, no en abstracto.
3. Da tres escenarios: mes flojo, mes normal y mes de pico al triple. Pon el coste mensual de cada uno.
4. Si no tengo los precios exactos, dime qué dato concreto tengo que mirar y dónde, y deja la fórmula preparada con huecos.
5. Detecta los tres derroches más probables en mi montaje (mandar todo el catálogo cada vez, arrastrar el historial entero, usar el modelo caro para tareas tontas, reintentos por prompt malo) y cuantifica el ahorro aproximado de arreglar cada uno.
6. Propón un reparto por niveles: qué tareas van con modelo barato, cuáles con el caro y qué regla decide el salto.
7. Calcula el precio mínimo que debo cobrar por servicio para cubrir coste de IA, mi tiempo de revisión y un margen, y dime qué margen he supuesto.

RESTRICCIONES
No inventes tarifas de proveedores: si no las tengo, márcalas como dato pendiente.
No recomiendes cambiar de herramienta como primera solución: primero arregla lo que mando.
Nada de porcentajes de ahorro prometidos: da rangos y di de qué depende.

FORMATO DE SALIDA
Sección CÓMO SE PAGA ESTO: máximo 8 líneas en lenguaje llano.
Sección MI CÁLCULO: la fórmula con mis números y el resultado por conversación y por mes.
Tabla ESCENARIOS: Flojo | Normal | Pico, con volumen, coste y coste por conversación.
Tabla DERROCHES: Derroche | Por qué me pasa | Cómo lo arreglo | Ahorro aproximado.
Sección NIVELES: qué tarea va a qué modelo y la regla de salto.
Sección PRECIO MÍNIMO: el número, las suposiciones y el punto en el que dejo de ganar dinero.
Sección ALARMAS: tres señales que debo vigilar cada semana para que no se me dispare.

CRITERIOS DE CALIDAD
Todos los números aparecen con su suposición al lado.
Puedo rehacer el cálculo yo solo el mes que viene con la fórmula que me das.
Ninguna recomendación exige conocimientos técnicos que no tengo.
```
