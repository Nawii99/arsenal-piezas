# Radiografía de prompts de sistema…

**Tipo:** Prompt · **Área:** Infraestructura · **Licencia:** CC BY 4.0

Analiza uno o varios prompts de sistema (las instrucciones de fondo de un asistente), los compara y te ayuda a redactar el tuyo con tus propias palabras.

## Qué es y qué hace

Prompt para analizar uno o varios prompts de sistema, las instrucciones de fondo de un asistente, y comparar su estructura, tono y límites. Entra el texto que quieres estudiar y sale un análisis con las piezas que lo forman y una plantilla para redactar el tuyo con tus palabras. Sirve en Claude, Codex, Gemini o una IA local. Advierte de que un prompt filtrado no es fiable ni es una barrera de seguridad.

## Cómo usarla

1. Pega el prompt a estudiar sin datos sensibles
2. Pide el análisis por piezas
3. Redacta el tuyo con tus palabras
4. Que lo revise un profesional

## Cuándo usarla

Cuando vayas a escribir las instrucciones de un asistente, por ejemplo uno de soporte de sistemas, y quieras ver antes cómo lo resuelven otros productos sin copiarlos.

## Cómo ganar dinero con ella

Formación para equipos técnicos o de soporte: enseñas a leer, redactar y probar prompts de sistema, con ejemplos propios o públicos.

- Formación para equipos de soporte sobre cómo leer y redactar instrucciones de asistentes, a precio por sesión.
- Revisión de las instrucciones de un asistente de atención al cliente antes de publicarlo.
- Taller de buenas prácticas de instrucciones para empresas que montan su primer chatbot.

**Precio orientativo:** 80–200 € por sesión. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Vas a hacer de analista de prompts de sistema. Un prompt de sistema son las instrucciones de fondo que recibe un asistente antes de hablar con nadie. Quiero estudiar cómo están escritos para redactar el mío. No quiero copiar ninguno.

Antes de empezar, ten en cuenta tres cosas y recuérdamelas en dos líneas al comienzo de tu respuesta:
- Un prompt «filtrado» no se puede comprobar. Puede estar incompleto, desactualizado o inventado por un modelo. Es un ejemplo, no un dato.
- Puede ser confidencial o estar protegido por derechos de autor. Lo uso para aprender estructura y tono. No lo reproduzcas entero ni lo uses como base literal de nada que yo vaya a publicar o vender.
- Un prompt de sistema no es una barrera de seguridad. Quien insiste puede sacarlo o saltárselo. Nunca pongas en él contraseñas, claves ni permisos que dependan solo de que la IA obedezca.

Material a analizar:
PROMPT 1 (producto u origen: [PRODUCTO U ORIGEN]): [PEGA AQUÍ EL TEXTO]
PROMPT 2 (opcional): [PEGA AQUÍ EL TEXTO]
PROMPT 3 (opcional): [PEGA AQUÍ EL TEXTO]

Mi asistente: [QUÉ HARÁ, PARA QUIÉN Y EN QUÉ SISTEMAS TRABAJA. EJEMPLO: SOPORTE INTERNO DE INFORMÁTICA PARA UNA PYME]
Lo que podrá hacer por sí mismo: [SOLO RESPONDER / LEER ARCHIVOS / EJECUTAR ACCIONES]

Haz esto, por orden:
1. Radiografía: para cada prompt, una tabla con estas filas: rol, tono, alcance (qué hace y qué no), reglas innegociables, formato de respuesta, uso de herramientas, qué hace cuando no sabe, qué hace ante peticiones peligrosas y qué le falta. Una frase por celda.
2. Comparación: qué tienen en común, en qué se diferencian y qué decisiones de diseño explican esas diferencias.
3. Lo que me sirve: ideas de estructura y de tono que podría adaptar a mi asistente, dichas con tus palabras. Nada de frases largas copiadas.
4. Borrador propio: un prompt de sistema para mi asistente, con secciones cortas (rol, alcance, tono, reglas, formato, cuándo pasar a una persona). Marca con [CORCHETES] lo que debo decidir yo.
5. Pruebas: diez mensajes para probar el borrador. Al menos tres deben intentar que el asistente se salga de sus reglas y dos deben ser casos en los que tendría que decir «esto lo decide una persona».
6. Revisión: lista de cosas que debo comprobar antes de ponerlo en uso.

No hagas esto:
- No me ayudes a sacar o reconstruir prompts de sistema de un producto ajeno ni a saltarte sus protecciones.
- No pongas en el borrador nombres de clientes, direcciones internas, claves ni datos de empleados.
- Si mi asistente va a poder ejecutar comandos o cambiar configuraciones en servidores, el borrador debe exigir confirmación de una persona antes de borrar, reiniciar o modificar nada. Dímelo expresamente.
- No me digas que el borrador es seguro. Dime qué has probado y qué queda por probar.
```
