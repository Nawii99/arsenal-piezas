# Respuesta a un rechazo de la tienda…

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Interpreta el motivo por el que App Store o Google Play han rechazado tu app y redacta la respuesta al revisor y el plan de corrección.

## Qué es y qué hace

Prompt que interpreta el mensaje de rechazo de App Store o Google Play y lo convierte en acciones. Recibe el texto literal del rechazo, tu modelo de negocio y el historial; devuelve la explicación en llano, qué cambiar y la respuesta redactada para el revisor. Se usa en cualquier chat de IA tras un rechazo.

## Cómo usarla

1. Copia el prompt
2. Pega el mensaje literal de rechazo y rellena los [corchetes]
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Aplica los cambios y envía la respuesta al revisor

## Cuándo usarla

Úsalo cuando te rechacen una versión, te tumben una actualización o te suspendan la ficha y no entiendas qué te están pidiendo exactamente.

## Cómo ganar dinero con ella

Cada semana de rechazo es una semana sin vender: resolver a la primera acorta el bloqueo y evita pagar horas de consultoría.

- Gestión de rechazos de tienda con respuesta al revisor incluida…
- Revisión previa de apps para evitar rechazos habituales…
- Soporte puntual de publicación en App Store y Google Play…

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como consultor de publicación en tiendas de aplicaciones, con experiencia resolviendo rechazos de App Store Review y suspensiones de Google Play para apps pequeñas.
Objetivo: traducirme el rechazo, decirme exactamente qué cambiar y escribirme la respuesta al equipo de revisión.
CONTEXTO:
- Tienda: [APP STORE / GOOGLE PLAY]
- Texto literal del mensaje de rechazo: [PEGA AQUÍ EL MENSAJE COMPLETO, INCLUIDA LA GUÍA O NORMA CITADA]
- Qué hace mi app: [DESCRIPCIÓN]
- Modelo de negocio: [GRATIS / SUSCRIPCIÓN / PAGO ÚNICO / PAGOS FUERA DE LA APP]
- Es primer envío o actualización: [PRIMER ENVÍO / ACTUALIZACIÓN]
- Cambios de esta versión: [CAMBIOS]
- ¿He dado usuario y contraseña de prueba al revisor? [SÍ / NO]
- Intentos de reenvío previos y qué contesté: [HISTORIAL O 'NINGUNO']
PASOS:
1. Traduce el rechazo a lenguaje llano: qué norma dicen que incumplo y qué es lo que en la práctica les molesta.
2. Distingue si es un rechazo de contenido, de funcionamiento, de metadatos de la ficha, de privacidad, de pagos o de cuenta de usuario. Di cuál es y por qué lo deduces.
3. Enumera las causas probables ordenadas de más a menos likely, con la señal que apunta a cada una.
4. Por cada causa probable, dime la corrección concreta: qué se cambia, en qué pantalla o campo, y si requiere tocar la app o solo la ficha.
5. Comprueba las causas típicas que casi nadie mira: cuenta de prueba que no funciona o caducada, funciones detrás de un registro que el revisor no puede pasar, app que se queda en blanco sin conexión, pagos fuera del sistema de la tienda, enlaces rotos a política de privacidad, capturas que no coinciden con la app, mención de otras plataformas en el texto, contenido de ejemplo vacío, y permisos pedidos sin explicación.
6. Escribe el mensaje de respuesta al revisor: tono profesional, en inglés y también en español para que yo lo entienda, breve, agradeciendo, respondiendo punto por punto, indicando qué se ha corregido y en qué pantalla comprobarlo, con credenciales de prueba y pasos exactos para llegar a la función discutida. Máximo 250 palabras en la versión en inglés.
7. Si creo que el rechazo es un error, escribe también la versión alternativa: apelación argumentada, citando la norma y explicando por qué la app la cumple, sin sonar a bronca.
8. Cierra con el plan de reenvío: qué preparar antes de dar a enviar y en qué orden, y qué NO hacer (reenviar sin cambios, discutir, enviar varias versiones seguidas).
RESTRICCIONES:
- No inventes normas ni números de directriz que no aparezcan en el mensaje que te he pegado.
- Si el mensaje es ambiguo, dilo y pide la información que falta antes de asegurar nada.
- Nada de trucos para saltarse la revisión: solo cumplimiento real.
- Español de España para las explicaciones; inglés natural y correcto para el mensaje al revisor.
FORMATO DE SALIDA:
1) QUÉ TE ESTÁN DICIENDO, EN CRISTIANO
2) TIPO DE RECHAZO
3) CAUSAS PROBABLES ORDENADAS (tabla: causa, señal, corrección, ¿toca la app?)
4) COMPROBACIONES OLVIDADAS
5) MENSAJE AL REVISOR (inglés) + TRADUCCIÓN
6) VERSIÓN DE APELACIÓN, SI PROCEDE
7) PLAN DE REENVÍO Y QUÉ NO HACER
CRITERIOS DE CALIDAD:
- Cada corrección propuesta se puede verificar en una pantalla concreta.
- El mensaje al revisor responde a todos los puntos del rechazo, ninguno se queda sin contestar.
- No prometes cambios que no puedes demostrar en la versión que vas a enviar.
- Si la causa más probable exige cambiar el modelo de negocio, lo dices claramente en lugar de disimularlo.
```
