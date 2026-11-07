# Separar pistas de audio automáticamente al subir una canción…

**Tipo:** Receta de automatización · **Área:** Música y audio · **Licencia:** CC BY 4.0

Subes canción, se separa voz e instrumental automáticamente, Telegram cuando listo.

## Qué es y qué hace

Flujo de n8n que vigila una carpeta de Google Drive, descarga cada canción nueva, la envía a una API de separación de pistas como Lalal.ai, espera a que termine, guarda la voz y el instrumental en Drive y avisa por Telegram. Entran archivos de audio y salen dos pistas listas para descargar. Requiere cuentas de n8n, Drive y del servicio de separación, cuyo plan gratuito tiene pocos minutos al mes.

## Cómo usarla

1. Crea una carpeta de entrada en Drive
2. Monta el disparador y la llamada a la API
3. Espera el resultado y guarda las pistas
4. Recibe el aviso en Telegram

## Cuándo usarla

Subes canciones a menudo para separar la voz del instrumental y te cansa abrir la web del servicio cada vez.

## Cómo ganar dinero con ella

Instálaselo a un estudio, a un profesor de canto o a un grupo de versiones que trabaja con muchas pistas. Cobra la puesta en marcha y, si quieres, un mantenimiento mensual [TU PRECIO].

- Separación de pistas por lote para un estudio de grabación pequeño…
- Karaoke automático para locales y academias de canto…
- Mantenimiento mensual de flujos de audio para un grupo de versiones…

**Precio orientativo:** 100–200 € por puesta en marcha (más 20-4. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué necesitas antes de empezar
- n8n: gratis si lo auto-alojas (Community Edition); n8n Cloud solo tiene una prueba gratuita temporal y después es de pago.
- Cuenta de Google Drive con una carpeta dedicada solo a esto, por ejemplo "Canciones para separar".
- Cuenta en un servicio de separación de pistas con API, por ejemplo Lalal.ai (tiene un plan gratuito con minutos limitados al mes; a partir de ahí cobra).
- Un bot de Telegram propio para recibir el aviso (se crea gratis hablando con @BotFather en Telegram).

## Nodos, en orden
1. **Google Drive Trigger**: dispara cuando se sube un archivo nuevo a la carpeta "Canciones para separar". Configúralo para que vigile solo esa carpeta, no todo el Drive.
2. **Google Drive (Download)**: descarga el archivo que acaba de subirse, usando el ID que entrega el nodo anterior.
3. **HTTP Request**: envía el audio a la API del servicio de separación (por ejemplo Lalal.ai). Necesitas la clave de API del servicio, que se guarda como credencial en n8n, nunca escrita a mano en el nodo.
4. **Wait** o **HTTP Request (consulta de estado)**: muchos servicios tardan unos minutos en procesar; añade una espera y una segunda llamada que pregunte si ya está listo antes de seguir.
5. **Google Drive (Upload)**: sube las pistas separadas (voz e instrumental) a una carpeta de resultados, por ejemplo "Pistas separadas".
6. **Telegram (Send Message)**: envía un aviso al usuario con el nombre de la canción procesada y el enlace a la carpeta de resultados.

## Cómo probarla sin liarla
Sube primero una canción corta (30 segundos) y de la que tengas derecho a usarla, para no gastar minutos del plan gratuito del servicio de separación en pruebas largas. Revisa que las pistas resultantes se suben a la carpeta correcta y que el mensaje de Telegram llega antes de dejarlo en marcha con canciones completas.

## Qué tener en cuenta
No proceses canciones con derechos de autor que no sean tuyas: el servicio de separación no comprueba de quién es la canción, y la responsabilidad de usarla legalmente es de quien la sube. Si el flujo falla a mitad, revisa primero la credencial de la API de separación: suele ser el paso que caduca o se queda sin minutos gratuitos disponibles.
