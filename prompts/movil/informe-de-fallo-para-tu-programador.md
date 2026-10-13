# Informe de fallo para tu programador…

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Convierte el «no me funciona» de un usuario en un informe de fallo reproducible que tu desarrollador pueda arreglar sin diez mensajes de ida y vuelta.

## Qué es y qué hace

Prompt que actúa como técnico de soporte móvil y transforma un mensaje vago de usuario en un informe de fallo reproducible. Recibe lo que dijo el usuario, su móvil y versión; devuelve hechos separados de suposiciones, datos que faltan, pasos para reproducir y la respuesta al usuario. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Pega el mensaje del usuario y rellena los [corchetes]
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Envía el informe al programador y la respuesta al usuario

## Cuándo usarla

Úsalo cuando un cliente o usuario te reporte que algo falla en la app y tengas que pasárselo al programador o a una IA que escribe el código.

## Cómo ganar dinero con ella

Un fallo bien descrito se arregla en una fracción del tiempo: pagas menos horas y el cliente vuelve a usar la app antes.

- Servicio de triaje de incidencias para apps de pequeños clientes…
- Plantillas de informe de fallos para equipos sin QA…
- Soporte de nivel 1 externalizado con informes para el programador…

**Precio orientativo:** 15–40 € por pieza. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico de soporte de aplicaciones móviles con experiencia haciendo de puente entre usuarios que no saben explicarse y programadores que necesitan datos exactos.
Objetivo: convertir lo que me ha contado un usuario en un informe de fallo que el desarrollador pueda reproducir y arreglar, y de paso escribirme la respuesta al usuario.
CONTEXTO:
- App: [NOMBRE] y qué hace: [DESCRIPCIÓN]
- Lo que me ha dicho el usuario, tal cual: [PEGA EL MENSAJE, RESEÑA O AUDIO TRANSCRITO]
- Lo que yo sé del usuario: [MODELO DE MÓVIL, SISTEMA, VERSIÓN DE LA APP, SI ES DE PAGO, DESDE CUÁNDO PASA]
- ¿He podido reproducirlo yo? [SÍ / NO / NO LO HE INTENTADO]
- Cambios recientes en la app: [ÚLTIMA ACTUALIZACIÓN Y QUÉ SE TOCÓ]
PASOS:
1. Separa los hechos de las interpretaciones: qué dice el usuario que hizo, qué dice que vio, y qué está suponiendo él sobre la causa.
2. Detecta qué información falta para reproducir el fallo y escríbeme las preguntas exactas para el usuario, redactadas para alguien no técnico y en un solo mensaje (máximo 5 preguntas, con opciones cuando se pueda para que responda rápido).
3. Formula de 2 a 4 hipótesis de causa ordenadas por probabilidad, cada una con la prueba que la confirmaría o descartaría, explicada como algo que puedo hacer yo con el móvil.
4. Escribe el informe de fallo con esta estructura exacta: título en una línea que diga qué falla y dónde; entorno (dispositivo, sistema, versión de la app, conexión); pasos para reproducir numerados y sin ambigüedad, empezando por 'con la app recién instalada' o 'con sesión iniciada como...'; resultado esperado; resultado real; frecuencia (siempre, a veces, una sola vez); gravedad (bloqueante, grave, molesto, cosmético); impacto en negocio (cuántos usuarios y si afecta a pagos); adjuntos necesarios (captura, vídeo, hora exacta del fallo para buscar en los registros).
5. Añade una sección de 'primeras comprobaciones' para el desarrollador: dónde miraría yo si fuese él, qué cambió en la última versión que pueda estar relacionado, y si conviene revisar registros del servidor o de la tienda.
6. Escribe también el mensaje de respuesta al usuario: agradecer, confirmar que se ha entendido el problema, decir qué va a pasar ahora, dar un plazo realista de contacto, y ofrecer una solución provisional si existe. Máximo 120 palabras, tono cercano y sin excusas técnicas.
7. Si el fallo afecta a más gente, redacta el aviso corto para publicar en la ficha de la tienda o en redes.
RESTRICCIONES:
- No adivines la causa técnica como si fuera segura: siempre en forma de hipótesis con su comprobación.
- No pidas al usuario cosas imposibles como registros del sistema o consolas.
- Los pasos para reproducir deben empezar desde un estado conocido y no saltarse ninguna pantalla.
- Español de España, tuteando al usuario, y trato profesional con el desarrollador.
FORMATO DE SALIDA:
1) HECHOS / INTERPRETACIONES
2) PREGUNTAS AL USUARIO (mensaje listo para enviar)
3) HIPÓTESIS ORDENADAS (tabla: hipótesis, probabilidad, cómo comprobarla)
4) INFORME DE FALLO (formato exacto del paso 4)
5) PRIMERAS COMPROBACIONES PARA EL DESARROLLADOR
6) RESPUESTA AL USUARIO
7) AVISO PÚBLICO, SI PROCEDE
CRITERIOS DE CALIDAD:
- Otra persona podría reproducir el fallo siguiendo solo los pasos escritos.
- La gravedad y el impacto están justificados, no puestos al tuntún.
- El mensaje al usuario no promete una fecha de arreglo que no puedo cumplir.
- Ninguna hipótesis se presenta como conclusión.
```
