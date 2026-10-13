# Pruebas en el móvil antes de publicar…

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Genera la lista de comprobaciones que tienes que hacer con el móvil en la mano antes de enviar la app a la tienda, sin ser técnico.

## Qué es y qué hace

Prompt que actúa como responsable de QA móvil y genera un plan de pruebas manuales que puedes ejecutar con el móvil en la mano. Recibe funciones, pantallas, permisos y dispositivos; devuelve casos de prueba priorizados (dinero y datos primero) con qué hacer y qué debería pasar. Se usa en cualquier chat de IA antes de enviar la app a la tienda.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu app y la versión
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Ejecuta los casos y anota los resultados

## Cuándo usarla

Úsalo justo antes de enviar una versión a revisión o de entregar la app a un cliente, y cada vez que recibas una versión nueva del programador.

## Cómo ganar dinero con ella

Cazar los fallos antes de publicar evita rechazos de la tienda, valoraciones de una estrella y facturas de urgencia al programador.

- Revisión de calidad previa a publicación para apps de clientes…
- Checklist de pruebas personalizado por versión para equipos pequeños…
- Servicio de testeo manual de apps en varios móviles con informe…

**Precio orientativo:** 120–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como responsable de calidad (QA) de aplicaciones móviles, acostumbrado a guiar a fundadores sin perfil técnico para que prueben su propia app antes de publicarla.
Objetivo: darme un plan de pruebas manuales que yo pueda ejecutar con el móvil en la mano en menos de [TIEMPO DISPONIBLE, POR EJEMPLO 90 MINUTOS], anotando resultados.
CONTEXTO:
- App: [NOMBRE] y qué hace: [DESCRIPCIÓN]
- Funciones principales: [LISTA]
- Pantallas que existen: [LISTA]
- Usa: [CÁMARA / UBICACIÓN / NOTIFICACIONES / PAGOS / LOGIN / SUBIDA DE FOTOS / NADA DE ESO]
- Dispositivos con los que puedo probar: [MODELOS Y SISTEMAS]
- Qué cambió en esta versión: [CAMBIOS]
PASOS:
1. Prioriza qué probar: primero los caminos donde entra dinero o datos, luego lo que ha cambiado en esta versión, luego lo demás.
2. Escribe los casos de prueba del recorrido principal, uno por línea, en formato: qué hago, qué debería pasar, y una casilla de resultado.
3. Añade los casos que siempre se olvidan y que provocan rechazos y críticas: primera instalación limpia, cerrar y reabrir la app a medias, quedarse sin conexión en mitad de una acción, modo avión, batería baja, girar el móvil, texto del sistema en tamaño grande, modo oscuro, pantallas pequeñas y móviles con muesca, volver atrás desde cada pantalla, dejar la app en segundo plano 10 minutos y volver, recibir una llamada mientras se usa.
4. Añade los casos de datos raros: campos vacíos, nombres muy largos, tildes y ñ, emojis, números negativos, fechas pasadas, doble toque rápido en el botón de guardar o pagar.
5. Si hay cuenta de usuario: registro, recuperar contraseña, cerrar sesión, entrar en otro móvil, borrar la cuenta (obligatorio en las tiendas si se puede crear).
6. Si hay pagos: compra con cuenta de prueba, cancelación, restaurar compras, qué ve quien ya pagó al reinstalar.
7. Si hay permisos: probar aceptando, rechazando y rechazando para siempre, y comprobar que la app sigue siendo usable.
8. Dame la plantilla para anotar un fallo: título, pasos exactos para reproducirlo, qué esperaba, qué pasó, dispositivo y sistema, captura o vídeo, y gravedad (bloqueante, grave, molesto, cosmético).
9. Cierra con el semáforo de publicación: qué fallos impiden publicar sí o sí y cuáles se pueden dejar para la siguiente versión.
RESTRICCIONES:
- Todo debe poder hacerlo una persona sin conocimientos técnicos, solo con el móvil y la app instalada.
- Nada de herramientas de pago ni de configurar entornos.
- Ordena las pruebas para minimizar el ir y venir entre pantallas.
- Español de España, instrucciones en imperativo y en una sola línea cada una.
FORMATO DE SALIDA:
1) ORDEN DE PRUEBA Y TIEMPO ESTIMADO POR BLOQUE
2) TABLA DE CASOS (número, qué hago, qué debería pasar, resultado, gravedad si falla)
3) BLOQUES ESPECIALES QUE APLIQUEN (conexión, permisos, pagos, cuenta)
4) PLANTILLA PARA REPORTAR UN FALLO
5) SEMÁFORO DE PUBLICACIÓN
CRITERIOS DE CALIDAD:
- Cada caso se puede ejecutar sin interpretar nada y su resultado es sí o no.
- El plan cabe en el tiempo que te he dado; si no cabe, marca el bloque imprescindible.
- No hay ningún caso que requiera acceso al código o a paneles de administración.
- Se cubren los motivos de rechazo más habituales de las tiendas.
```
