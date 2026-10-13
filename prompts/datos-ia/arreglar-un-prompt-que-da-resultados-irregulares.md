# Arreglar un prompt que da resultados irregulares…

**Tipo:** Prompt · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Por qué un prompt tuyo unas veces funciona y otras no, y cómo reescribirlo para que nunca falle.

## Qué es y qué hace

Prompt que depura otro prompt que da resultados irregulares. Entran el prompt actual, el resultado deseado y ejemplos buenos y malos; sale un diagnóstico contra una lista de fallos típicos y una versión reescrita más estable. Se usa en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Copia el prompt en tu IA
2. Rellena los [corchetes] con tu prompt y ejemplos
3. Revisa el diagnóstico y la versión reescrita
4. Prueba el nuevo prompt varias veces

## Cuándo usarla

Úsalo cuando tengas un prompt que usas a menudo y te dé resultados desiguales, demasiado largos, genéricos o fuera de formato.

## Cómo ganar dinero con ella

Convierte un prompt que te obliga a repetir 4 intentos en uno que sale a la primera, lo que se nota en horas y en gasto de la herramienta.

- Depuración de prompts de uso diario para equipos pequeños…
- Servicio de mejora de prompts para negocios…
- Biblioteca de prompts estables entregada a un cliente…

**Precio orientativo:** 40–150 € por pieza. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como especialista en depuración de prompts. Tu método es clínico: primero diagnosticas la causa, luego operas.

MATERIAL
Prompt actual (pégalo entero): [PEGA AQUÍ TU PROMPT]
Qué quiero conseguir exactamente: [RESULTADO DESEADO EN UNA FRASE]
Modelo donde lo uso: [CLAUDE, CODEX, GEMINI O UNA IA LOCAL / VARIOS]
Con qué frecuencia lo uso: [VECES POR SEMANA]
Ejemplo de respuesta MALA que me dio: [PEGA UNA]
Ejemplo de respuesta BUENA, si la tienes: [PEGA UNA O ESCRIBE 'NINGUNA']
Qué hago yo a mano después para arreglarlo: [DESCRÍBELO]

QUÉ TIENES QUE HACER
1. Diagnóstico: revisa el prompt contra esta lista de fallos y marca cuáles tiene. Papel ausente o vago. Objetivo implícito en vez de explícito. Falta de contexto de negocio. Sin criterios de calidad. Sin formato de salida. Sin longitud pedida. Instrucciones contradictorias. Palabras ambiguas como profesional, moderno, breve. Sin ejemplos. Sin decir qué hacer si falta información. Sin público objetivo. Pide varias cosas a la vez.
2. Para cada fallo detectado, cita el fragmento exacto del prompt que lo provoca y explica en una línea por qué produce la respuesta mala que te enseñé.
3. Reescribe el prompt completo corrigiendo todos los fallos, manteniendo mi intención original y mi tono.
4. Marca en la versión nueva, entre corchetes en mayúsculas, todo lo que yo tenga que rellenar cada vez.
5. Añade al prompt nuevo un bloque de criterios de calidad y un bloque de qué hacer si falta información.
6. Propón dos variantes cortas del prompt nuevo: una para cuando quiero algo rápido y otra para cuando quiero la versión larga y cuidada.

RESTRICCIONES
No alargues por alargar: si el prompt nuevo pasa de lo necesario, recórtalo.
No cambies mi objetivo ni añadas requisitos que yo no he pedido.
Nada de vocabulario técnico sin explicar: escribo sin perfil técnico.

FORMATO DE SALIDA
Sección DIAGNÓSTICO: tabla con Fallo | Fragmento culpable | Consecuencia en la respuesta.
Sección PROMPT NUEVO: bloque de texto plano listo para copiar, sin comentarios dentro.
Sección QUÉ HE CAMBIADO Y POR QUÉ: máximo 8 puntos, uno por cambio importante.
Sección CÓMO COMPROBAR QUE HA MEJORADO: 3 pruebas concretas que puedo lanzar y qué debo ver en la respuesta para dar por bueno el cambio.
Sección VARIANTES: la versión rápida y la versión larga.

CRITERIOS DE CALIDAD
El prompt nuevo funciona sin que yo tenga que explicar nada más por chat.
Todo lo variable está entre corchetes; nada de datos inventados de mi negocio.
Las pruebas de comprobación son observables: se ve a simple vista si pasan o no.
```
