---
name: automatizacion-home-assistant
description: Writes working Home Assistant automations in YAML from a plain-language description, choosing correct triggers, conditions, run modes and helpers, and explaining how to test them. Use when the user wants something to happen automatically in their smart home, mentions Home Assistant, automations, motion-activated lights, alerts or schedules.
---

# Automatizaciones de Home Assistant que funcionan

## Qué hace
Traduce una frase del tipo «quiero que la luz se encienda cuando entro y se apague sola» en una automatización YAML correcta, con condiciones y modo de ejecución bien elegidos.

## Cuándo se activa
Cuando el usuario describe un comportamiento automático deseado o pega una automatización que no le funciona.

## Qué preguntar si falta información
1. Nombres exactos de las entidades implicadas (se ven en Ajustes, Dispositivos y servicios, o en Herramientas para desarrolladores, Estados). Sin el id exacto no se puede escribir nada fiable.
2. ¿Qué debe pasar y qué NO debe pasar? Ejemplo: que no encienda de día, que no moleste de noche.
3. Tiempos: cuánto tarda en apagarse, en qué horario aplica.
4. ¿Hay alguien en casa? ¿Se usa presencia?

## Método
### 1. Descompón en disparador, condición y acción
- Disparador: el momento exacto. Estado, hora, numérico, evento.
- Condición: el filtro. Sol por debajo del horizonte, alguien en casa, un interruptor virtual activado.
- Acción: llamada a servicio con datos concretos.

### 2. Elige el modo de ejecución, que es donde falla todo el mundo
- `mode: single`: por defecto, ignora disparos mientras se ejecuta.
- `mode: restart`: el correcto para luces con sensor de movimiento. Cada movimiento reinicia la cuenta atrás.
- `mode: queued`: para acciones que no se pueden pisar (abrir y cerrar una persiana).

### 3. Reglas del oficio
- No uses esperas largas con `delay`. Si Home Assistant se reinicia, esa automatización se queda a medias. Usa el disparador de estado con `for:` (el sensor lleva 5 minutos sin movimiento) o un temporizador.
- Añade siempre condición de luz para la iluminación automática: `sun` por debajo del horizonte o un sensor de luminosidad con umbral. Si no, encenderás luces a mediodía.
- Para calefacción y riego, incluye una condición de seguridad que impida repetir la acción y un tope de tiempo.
- Crea un interruptor virtual (`input_boolean`) llamado «modo manual» y ponlo como condición: así el usuario puede desactivar la automatización sin borrarla.
- Los avisos al móvil deben tener antirrebote: si no, un sensor defectuoso manda cuarenta notificaciones de madrugada.

### 4. Plantillas, solo si hacen falta
Usa plantillas para textos de aviso y umbrales. No metas lógica compleja en plantillas: es lo primero que se rompe y lo último que el usuario sabe arreglar.

### 5. Cómo probarlo antes de darlo por bueno
- Pega el YAML en el editor en modo texto y guarda: si el indentado está mal, no deja guardar.
- Usa Ejecutar para forzar las acciones y comprobar que las entidades existen.
- Usa Herramientas para desarrolladores, Plantillas, para verificar cualquier expresión.
- Revisa la pestaña Trazas después del primer disparo real: te dice en qué condición se paró.

## Formato exacto de la respuesta
1. **Qué va a hacer** en una frase, en cristiano.
2. **Bloque YAML completo** listo para pegar, con `alias`, `description`, `mode`, disparadores, condiciones y acciones, y comentarios en español.
3. **Entidades que debes sustituir**, en lista, con el nombre falso que has usado.
4. **Cómo probarlo** en tres pasos.
5. **Cómo desactivarlo** si molesta.

## Errores típicos
- Indentar con tabuladores: el YAML solo admite espacios, dos por nivel.
- Confundir el dispositivo con la entidad: usa entidades, sobreviven a cambiar el aparato.
- Sensor de movimiento que no se apaga: muchos tienen un tiempo de retención interno de 1 a 3 minutos; no puedes bajar de ahí por software.
- Automatizar la puerta de entrada o la alarma sin plan para cuando falle la red.

## Avisos honestos
- Nunca automatices por software algo cuyo fallo sea peligroso (calderas, riego que puede inundar, cerraduras del único acceso) sin un mecanismo físico de seguridad.
- Home Assistant cambia de sintaxis entre versiones; si un YAML de hace dos años no funciona, revisa las notas de la versión antes de volverse loco.
