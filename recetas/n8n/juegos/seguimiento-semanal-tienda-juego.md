# Seguimiento semanal de tienda para clientes de pago…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Receta de n8n que recoge cada semana reseñas y datos de la ficha de tienda de un juego y manda un informe por email, pensada para venderse como seguimiento mensual.

## Qué es y qué hace

Receta de n8n que cada semana consulta la API pública de Steam y SteamSpy para recoger reseñas y datos de la ficha de un juego, compara con los datos de la semana anterior guardados en Google Sheets y envía un informe por email. Entra el identificador del juego en Steam; sale un correo con reseñas nuevas, propietarios estimados y cambios en listas. Ejemplo: si las reseñas positivas suben un 3 por ciento, el informe lo marca. Se usa para seguir un lanzamiento sin revisarlo a mano.

## Cómo usarla

1. Crea la hoja de histórico en Google Sheets
2. Configura el Schedule Trigger semanal y las peticiones a Steam y SteamSpy con ritmo bajo
3. Compara con la semana anterior y genera el informe
4. Envía el email al cliente

## Cuándo usarla

Si trabajas con un estudio que acaba de lanzar en Steam y quiere ver cada semana cómo evolucionan reseñas y propietarios sin entrar a mirarlo a mano.

## Cómo ganar dinero con ella

Véndelo como seguimiento mensual de lanzamiento: el cliente recibe el informe por email y tú cobras una cuota recurrente, [TU PRECIO]. Añade una llamada corta al mes para comentar los datos.

- Seguimiento mensual de lanzamiento en Steam como cuota recurrente para un estudio…
- Informe semanal de reseñas y propietarios con una llamada corta al mes…
- Monitor de competencia de Steam para varios juegos de un mismo cliente…

**Precio orientativo:** 30–80 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Qué hace esta automatización
Cada semana recoge las reseñas y la posición en listas de tu juego en Steam (usando la API pública de Steam y SteamSpy, ambas gratis) y te manda un informe por email listo para reenviar a un cliente que te paga por seguimiento de su lanzamiento.

# Cuentas y límites gratuitos que necesitas
- Cuenta de n8n (la versión self-hosted es gratis; la de pago en la nube tiene un plan gratuito limitado en ejecuciones).
- Ninguna clave hace falta para la API pública de Steam de appdetails, pero respeta un ritmo bajo de peticiones para no acabar bloqueado.
- Cuenta en SteamSpy: gratis, pero limita a 1 petición por segundo, no la satures.
- Una hoja de Google Sheets gratuita para guardar los datos de la semana anterior y poder comparar.
- Una cuenta de Gmail (u otro proveedor de email) para enviar el informe final.

# Nodos, en orden
1. Schedule Trigger: dispara una vez a la semana, por ejemplo los lunes a las 9:00.
2. HTTP Request: llama a la API de Steam (appdetails) con el AppID del juego del cliente para sacar precio actual y nota media si está disponible.
3. HTTP Request: llama a SteamSpy con el mismo AppID para sacar el número estimado de propietarios y de reseñas.
4. Google Sheets (Read): lee la fila de la semana anterior en tu hoja de seguimiento para ese cliente.
5. Code (o Function): calcula la diferencia entre esta semana y la anterior (reseñas nuevas, cambio de nota, cambio de propietarios estimados).
6. Google Sheets (Append): guarda la fila de esta semana para poder compararla la próxima vez.
7. Code (o Function): monta el texto del informe en HTML sencillo, con los números de la semana y la comparación.
8. Gmail (Send Email): envía el informe a la dirección del cliente, con copia a tu propia cuenta para tener registro.

# Cómo cobrar esto
Véndelo como "seguimiento semanal de lanzamiento": una cuota mensual fija por juego, no por hora. El coste real para ti es casi cero (todo son APIs gratuitas), así que el margen depende de cuántos clientes lleves en paralelo con la misma automatización, cambiando solo el AppID y el email de destino.

# Cómo probarla sin liarla
Antes de mandar nada a un cliente real, prueba la automatización de principio a fin usando tu propio email como destinatario y un AppID de un juego cualquiera de Steam. Revisa que la hoja de Google Sheets no acumule filas duplicadas si ejecutas el flujo dos veces el mismo día, y desactiva el nodo de envío de email mientras haces pruebas para no mandar informes a medio hacer.
