---
name: avisos-sms-azure
description: Te guía y genera el proyecto en Java para enviar SMS con Azure Communication Services, con pruebas en tu móvil, tope de gasto y control de consentimiento. Actívala cuando pidas enviar SMS automáticos, recordatorios o códigos de verificación.
---

# Avisos por SMS con Azure

## Qué hace
Te acompaña para enviar SMS desde Azure Communication Services. Claude escribe el programa en Java. Tú pones la cuenta, las claves y las pruebas.
Hay cuatro tipos de SMS con reglas distintas: aviso de servicio (tu pedido sale hoy), recordatorio (tu cita es mañana), código de verificación y publicidad.
Empieza en modo plan de Claude Code (Mayús+Tab cambia de modo) para que te enseñe lo que va a crear antes de tocar nada.

## Qué preguntar antes de empezar
1. ¿Qué tipo de SMS es: aviso, recordatorio, código de verificación o publicidad?
2. ¿Cuántos SMS al mes calculas y a qué países?
3. ¿De dónde salen los teléfonos y qué aceptaron esas personas?
4. ¿Tienes cuenta de Azure, un recurso de Communication Services y un remitente (número o nombre)?
5. ¿Cuál es el gasto máximo mensual que asumes? [EUROS]
6. ¿Quién paga la cuenta de Azure, tú o tu cliente?
7. ¿Hay ya un proyecto en Java? Si no, ¿vale otro lenguaje más simple? El SDK de Azure existe en varios.

## Lo que hace una persona a mano (Claude no debe hacerlo por ti)
- Crear la cuenta y el recurso en el portal de Azure.
- Comprobar en la documentación oficial si el tipo de remitente que quieres está disponible para enviar a España. Los requisitos cambian por país. No lo des por supuesto.
- Poner una alerta de presupuesto en Azure (Cost Management) antes del primer envío.
- Guardar la clave como variable de entorno. Nunca en el chat ni en un archivo que subas a GitHub.

## Paso a paso
1. Resume en 6 líneas lo que has entendido y espera el OK. Pregunta si un nodo de n8n o el proveedor de SMS que ya usa resuelve el caso con menos esfuerzo. Si es así, dilo.
2. Si es publicidad, comprueba el consentimiento antes de escribir código. Sin consentimiento, para.
3. Lee la documentación oficial actual del SDK de Azure para Java antes de escribir código. No te fíes de la memoria.
4. Crea un proyecto mínimo que lea la clave de una variable de entorno y los teléfonos de un archivo CSV.
5. Añade protecciones: tope de SMS por ejecución, parada si fallan [NÚMERO] seguidos, registro de cada envío (hora, destino con cifras ocultas, resultado) y nada de repetir un envío ya hecho.
6. Cuenta los caracteres del texto. Con tildes (á, í, ó, ú) o emojis, muchos envíos pasan a una codificación que admite 70 caracteres por mensaje en lugar de 160, y cada SMS largo se parte en trozos que se cobran aparte. Propón una versión con tildes y otra sin ellas, con su coste.
7. Pruebas en tres fases, cada una con OK expreso: tu móvil, tres personas que lo saben, un grupo pequeño real.
8. Explica que «enviado correctamente» solo significa que Azure lo aceptó, no que llegó al móvil. Para saber si llegó hace falta el informe de entrega. Pregunta si lo quiere.
9. Estima el coste: SMS al mes por precio de un SMS a España por trozos del mensaje. El precio es [PRECIO: mira la tabla oficial de precios de Azure Communication Services]. No lo inventes.
10. Pide a un subagente revisor que lea el código buscando claves escritas dentro, bucles sin tope y envíos duplicados.

## Si hay códigos de verificación
- Caducan pronto, valen una sola vez, tienen un máximo de [NÚMERO] intentos, no se guardan en claro y no se escriben en los registros.
- Limita los envíos por teléfono y por hora y restringe los países de destino. Si no, alguien puede disparar miles de SMS a tu cuenta (fraude conocido como SMS pumping) y el gasto es tuyo.
- El SMS no es el método más seguro: existen robos de SIM. Para banca, pagos o datos de salud no montes un sistema propio. Usa uno ya probado y que lo revise un experto en seguridad.

## Reglas de España
- El teléfono es un dato personal (RGPD y LOPDGDD).
- SMS publicitario: pide consentimiento previo (LSSI, art. 21), con excepciones limitadas para clientes actuales. Cada mensaje debe permitir darse de baja fácil y gratis. Consulta también la Lista Robinson.
- Un aviso de servicio no debe llevar publicidad. Si la lleva, cuenta como publicitario.
- No pongas datos de salud ni de pago en el texto. Ejemplo válido: «Recordatorio de tu cita mañana a las 10:00», sin motivo ni especialidad.

## Qué devolver
- Carpeta del proyecto con un LEEME en español sencillo: cómo ejecutarlo, cómo probarlo y cómo pararlo.
- Hoja de coste estimado con los supuestos a la vista.
- Lista de comprobación antes de enviar a gente real.
- Lista de lo que revisa una persona (abajo).

## Qué revisa una persona antes de usarlo con clientes
- Un abogado o tu gestoría: consentimiento, textos y sistema de baja.
- Alguien con conocimientos de seguridad, si hay códigos: almacenamiento de claves y límites.
- Quien paga la cuenta de Azure: que el tope de gasto y las alertas están activos.

## Qué NO hacer
- No pidas ni aceptes claves pegadas en el chat.
- No envíes a números reales sin pasar por las tres fases de prueba.
- No uses listas compradas ni teléfonos de gente que no los dio para esto.
- No pongas como remitente el nombre de otra empresa o de un banco. Es suplantación.
- No envíes de noche ni en bucle sin tope.
- No prometas tasas de lectura ni de conversión.
- No ocultes el coste al usuario.
