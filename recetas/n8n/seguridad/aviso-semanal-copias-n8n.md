# Aviso semanal de copias de seguridad en n8n…

**Tipo:** Receta de automatización · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Recordatorio semanal de copias: quién las comprobó, cuándo, si testear una restauración.

## Qué es y qué hace

Es una receta de n8n que cada lunes te manda la lista de copias a comprobar. Respondes con un formulario corto y queda escrito quién lo comprobó y cuándo. Si pasan más de 90 días sin probar una restauración, el aviso sube de tono. Entran una hoja con sistemas y fechas, y un canal de aviso como Telegram o Gmail; sale un recordatorio semanal con registro. Es gratis con n8n propio y Google Sheets.

## Cómo usarla

1. Crea la hoja de copias con sistema, lugar y última comprobación
2. Monta el disparador semanal y el aviso
3. Prueba una restauración al mes

## Cuándo usarla

Cuando ya tienes copias pero nadie las mira, y quieres una rutina que deje rastro escrito sin montar nada complicado.

## Cómo ganar dinero con ella

Se instala dentro de un mantenimiento mensual de 60-120 euros; el registro escrito es lo que justifica la cuota.

- Rutina de copias para pymes que tienen copias pero nadie las mira.
- Registro de comprobaciones como entregable que justifica una cuota mensual.
- Aviso de restauraciones pendientes para gestorías con datos de muchos clientes.

**Precio orientativo:** 60–120 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

RECETA n8n: recordatorio y registro de copias de seguridad

QUÉ CONSIGUES
Cada lunes recibes un mensaje con la lista de copias a comprobar. Respondes rellenando un formulario de 30 segundos. Queda escrito quién lo comprobó y qué día. Si pasan más de 90 días sin probar una restauración, el aviso sube de tono.

CUENTAS NECESARIAS Y LÍMITE GRATUITO
- n8n: gratis si lo ejecutas tú en tu ordenador o en un servidor propio. La versión en la nube tiene prueba limitada y luego es de pago.
- Google Sheets: gratis con cuenta de Google normal.
- Telegram: gratis, sin límite práctico para estos volúmenes. Si prefieres correo, sustituye por Gmail (500 envíos al día en cuenta gratuita).

NODOS, EN ORDEN
1. Schedule Trigger (disparador). Modo Custom Cron, expresión 0 9 * * 1. Cada lunes a las 09:00.
2. Google Sheets - Get Rows. Hoja llamada copias. Columnas: sistema, dónde se guarda, última comprobación, última restauración probada, responsable.
3. Code (o Set, si no quieres tocar código). Calcula para cada fila los días transcurridos desde la última restauración probada y añade un campo nivel con el valor normal, atención (más de 90 días) o urgente (más de 180 días).
4. IF. Condición: ¿hay alguna fila con nivel distinto de normal?
5. Rama verdadera - Telegram Send Message. Texto: lista de sistemas con retraso, días acumulados y nombre del responsable. Añade la frase: hay que probar una restauración real, no basta con ver que el archivo existe.
6. Rama falsa - Telegram Send Message. Texto corto: copias al día, solo confirma que el archivo de esta semana existe.
7. Ambas ramas terminan en el mismo enlace a un formulario de Google que escribe en la misma hoja. Así la respuesta queda registrada sin que nadie edite la hoja a mano.

CÓMO PROBARLA SIN LIARLA
1. Duplica la hoja y trabaja sobre la copia mientras montas el flujo.
2. Cambia el disparador a cada 5 minutos, ejecuta, comprueba el mensaje y vuelve a dejarlo en lunes a las 09:00.
3. Mete una fila falsa con una fecha de hace un año para ver que el aviso urgente salta.
4. Usa Execute Workflow a mano las dos primeras semanas antes de dejarlo solo.

LÍMITES DE ESTO
- Este flujo no hace copias. Solo recuerda y deja registro. Las copias hay que tenerlas ya montadas.
- Una copia que nadie ha restaurado nunca no cuenta como copia. La prueba de restauración la hace una persona, a mano, y dura lo que dura.
- No metas en la hoja contraseñas, claves de cifrado ni rutas completas de acceso. Solo nombres y fechas.

CUÁNDO HACE FALTA UNA PERSONA CON RESPONSABILIDAD PROFESIONAL
Si las copias contienen datos de clientes, historiales médicos, nóminas o datos de menores, el sitio donde se guardan y cuánto tiempo se conservan lo define el responsable de protección de datos de la empresa, no esta automatización. Y si un día hace falta restaurar de verdad tras un incidente, para el flujo y que lo lleve un técnico: restaurar mal encima de un sistema comprometido puede borrar la única copia buena.
