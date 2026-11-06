# Aviso de licencias de assets a punto de caducar…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Flujo de n8n que revisa una hoja de calculo de licencias de assets y avisa por Telegram o correo antes de que caduquen.

## Qué es y qué hace

Flujo de n8n que lee una hoja de Google Sheets con las licencias temporales de cada asset (nombre, tipo de licencia, fecha de caducidad y responsable), calcula los días que faltan y envía un aviso por Telegram o Gmail solo cuando algo caduca en menos de 30 días. Se ejecuta con un Schedule Trigger semanal y funciona en n8n self-hosted o en n8n Cloud. Ejemplo: una música con licencia anual que vence en 20 días genera un aviso el lunes. Se usa en estudios de videojuegos o cualquier equipo que dependa de assets con licencia limitada.

## Cómo usarla

1. Crea la hoja licencias_assets con sus columnas
2. Configura el Schedule Trigger semanal
3. Calcula los días restantes en un nodo Code y filtra los que quedan por debajo de 30
4. Conecta Telegram o Gmail para el aviso
5. Que lo revise un profesional

## Cuándo usarla

En vez de recordar a mano que asset tiene licencia temporal y cuando vence, la hoja se revisa sola una vez a la semana y solo avisa cuando hay algo a menos de 30 dias de caducar.

## Cómo ganar dinero con ella

Uso interno del estudio; si se ofrece como servicio a otros estudios, se cobraría el montaje inicial del flujo, a definir según número de hojas y canales de aviso.

- Montar el aviso de licencias para estudios indie que usan música y plugins con suscripción…
- Vender el mantenimiento mensual del flujo y la revisión de la hoja de licencias a un estudio…
- Adaptar la misma automatización a productoras que gestionan licencias de música o stock…

**Precio orientativo:** 80–250 € por flujo montado. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Aviso de licencias de assets a punto de caducar

Guarda en una hoja de calculo cada asset con licencia temporal (musica con licencia anual, plugins con suscripcion, assets alquilados) y esta automatizacion avisa antes de que caduque, para no descubrirlo cuando ya esta caducada y el juego publicado con un asset sin licencia.

## Cuentas necesarias
- Cuenta de Google con Google Sheets (gratis).
- n8n (self-hosted gratis, o n8n Cloud con plan de prueba gratuito y despues de pago).
- Una cuenta de Telegram o un correo (Gmail) para recibir el aviso; ambos gratis.

## Nodos, en orden
1. Trigger: Schedule Trigger, configurado para ejecutarse una vez a la semana (por ejemplo, lunes a las 9:00).
2. Google Sheets (nodo "Get rows"): lee la hoja "licencias_assets" con las columnas nombre_asset, tipo_licencia, fecha_caducidad, responsable.
3. Function o Code: calcula los dias que quedan hasta fecha_caducidad para cada fila y filtra las que caducan en menos de 30 dias.
4. IF: si el resultado del paso anterior no esta vacio, sigue; si esta vacio, termina el flujo sin hacer nada.
5. Telegram (nodo "Send Message") o Gmail (nodo "Send Email"): envia la lista de assets a punto de caducar, con nombre, fecha y responsable.

## Como probarla sin liarla
1. Antes de activarla, crea una fila de prueba en la hoja con una fecha de caducidad dentro de 10 dias.
2. Ejecuta el flujo manualmente desde n8n (boton "Execute Workflow") en vez de esperar al Schedule Trigger.
3. Comprueba que llega el aviso a Telegram o al correo con los datos correctos de esa fila de prueba.
4. Solo despues de verlo funcionar con datos de prueba, activa el Schedule Trigger y borra la fila de prueba.
5. Revisa cada pocos meses que la hoja sigue teniendo todos los assets con licencia temporal: la automatizacion solo avisa de lo que esta anotado, no descubre assets nuevos por si sola.
