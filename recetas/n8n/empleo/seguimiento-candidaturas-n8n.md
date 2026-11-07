# Seguimiento de candidaturas enviadas…

**Tipo:** Receta de automatización · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Avisa por Telegram cuando pasan 7 días sin respuesta a una candidatura registrada en una hoja de Google Sheets.

## Qué es y qué hace

Flujo de n8n que lee una hoja de Google Sheets con las candidaturas enviadas y, si una lleva 7 días o más sin marcarse como Respondido, te manda un aviso a Telegram para hacer seguimiento. Entra la hoja con fecha de envío y estado, y sale un mensaje por cada candidatura vencida. Requiere cuenta de Google, un bot de Telegram y n8n; revisa el límite de ejecuciones de tu plan de n8n Cloud (tiene prueba gratuita temporal y después es de pago) antes de usarlo a diario.

## Cómo usarla

1. Prepara la hoja con fecha y estado
2. Crea el bot con BotFather y apunta el chat id
3. Monta el disparador diario en n8n
4. Prueba con una fila de hace 7 días

## Cuándo usarla

Envías muchas candidaturas y se te pasa hacer seguimiento. La hoja te avisa por Telegram cuando una lleva 7 días o más sin respuesta.

## Cómo ganar dinero con ella

Móntala como servicio de organización de la búsqueda de empleo para quien manda muchas candidaturas: cobras la puesta en marcha y un mantenimiento mensual ([TU PRECIO]). El aviso solo recuerda; la persona decide a quién escribe y qué dice.

- Aviso de seguimiento de candidaturas montado para un candidato, en su propio bot y su hoja.
- Recordatorios de seguimiento para autónomos que mandan presupuestos y olvidan volver a escribir.
- Pack de avisos de seguimiento para bolsas de empleo que gestionan varios procesos abiertos.

**Precio orientativo:** 50–90 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Seguimiento de candidaturas enviadas

Qué hace: cada vez que se revisa una hoja de Google Sheets con las candidaturas que has enviado, si una candidatura lleva 7 días o más sin marcar como "Respondido", te manda un aviso a Telegram para que hagas seguimiento.

Cuentas necesarias:
- Cuenta de Google, para Google Sheets. Gratis.
- Cuenta de Telegram y un bot creado con @BotFather. Gratis.
- Cuenta de n8n, self-hosted (Community Edition, gratis) o n8n.cloud (prueba gratuita temporal y después planes de pago; revisa el límite de ejecuciones de tu plan antes de depender de esto para el día a día).

Nodos, en orden:
1. Google Sheets Trigger: revisa la hoja de candidaturas cada [INTERVALO, POR EJEMPLO CADA HORA] y dispara el flujo si hay cambios.
2. Nodo IF: comprueba si la columna "Estado" está vacía o dice "Enviado" (no "Respondido" ni "Descartado").
3. Nodo Date & Time: calcula cuántos días han pasado desde la fecha de la columna "Fecha de envío" hasta hoy.
4. Nodo IF (segundo): comprueba si esos días son 7 o más.
5. Nodo Telegram: si se cumple la condición, envía un mensaje con el nombre de la empresa, el puesto y los días pasados.
6. Nodo Google Sheets (Update), opcional: marca una columna "Aviso enviado" para no repetir el mensaje al día siguiente por la misma fila.

Cómo probarla sin liarla:
- Antes de activarla, mete una fila de prueba con fecha de hace 8 días y estado vacío.
- Ejecuta el flujo a mano desde n8n con el botón "Execute workflow", no lo dejes en automático hasta ver que el mensaje de Telegram te llega bien.
- Cambia el estado de esa fila de prueba a "Respondido" y vuelve a ejecutar a mano para comprobar que ya no te avisa.
- Cuando funcione con la fila de prueba, bórrala de la hoja y activa el disparador automático.

Riesgos y qué NO hacer: no compartas el token del bot de Telegram con nadie ni lo subas a un repositorio público. Si usas n8n.cloud, revisa el límite de ejecuciones de tu plan: si lo superas, la automatización deja de avisarte sin que te enteres.
