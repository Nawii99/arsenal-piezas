# Vigilancia semanal de dominio y aviso para registrar marca…

**Tipo:** Receta de automatización · **Área:** Legal y contratos · **Licencia:** CC BY 4.0

Comprobación semanal de tu dominio; Telegram te tira el aviso en cuanto esté disponible.

## Qué es y qué hace

Flujo de n8n que cada lunes consulta el estado de dos dominios (.es y .com) de un nombre que te interesa en el RDAP público, sin clave de API, y avisa por Telegram en cuanto cambian de ocupados a libres. Se monta con un Schedule Trigger, un nodo Set con las variables del dominio, un HTTP Request y un nodo de Telegram, con cuenta gratuita de n8n y un bot de BotFather.

## Cómo usarla

1. Programa el disparador semanal
2. Consulta RDAP para .es y .com
3. Avisa por Telegram al cambiar el estado

## Cuándo usarla

Cuando quieres un nombre concreto y el dominio está ocupado ahora mismo, pero puede quedar libre si no se renueva.

## Cómo ganar dinero con ella

Vigilancia de dominios como añadido gratis a un servicio de naming o registro de marca: cuesta montar el flujo una vez y funciona solo para todos los clientes que quieran…

- Vigilancia de dominios para clientes que esperan un nombre concreto…
- Alertas de dominios para agencias que proponen nombres a sus clientes…
- Servicio semanal de seguimiento de dominios para emprendedores en espera…

**Precio orientativo:** 40–80 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

Objetivo: cada semana comprueba si el dominio que quieres para tu marca sigue libre, y te manda un aviso por Telegram en cuanto cambie, para no tener que entrar tú a comprobarlo a mano.

Cuentas que hacen falta:
- Una cuenta de n8n (self-hosted gratis, o n8n Cloud con plan de prueba).
- Un bot de Telegram gratis, creado con @BotFather, y el chat_id donde quieres recibir el aviso.
- No hace falta ninguna API de pago: la comprobación de dominio se hace contra el RDAP público, que es gratis y sin clave.

Nodos, en orden:
1. Schedule Trigger: programa cada lunes a las 9:00. Es el disparador; sin él el flujo no se ejecuta solo.
2. Set: define dos variables, dominio_es con el nombre que quieres vigilar seguido de ".es", y dominio_com con el mismo nombre seguido de ".com".
3. HTTP Request (nodo 1): GET a https://rdap.nic.es/domain/{{ $json.dominio_es }} — comprueba primero en el navegador que esa URL responde antes de automatizarla, porque el endpoint puede cambiar.
4. HTTP Request (nodo 2): GET a https://rdap.verisign.com/com/v1/domain/{{ $json.dominio_com }} para el .com.
5. IF: si cualquiera de las dos peticiones devuelve error 404 (dominio no encontrado, es decir, libre), sigue por la rama de aviso; si devuelve 200 (dominio encontrado, ocupado), no hace nada esta semana.
6. Set: construye el mensaje, por ejemplo "El dominio [DOMINIO] está libre. Recuerda que esto no comprueba la OEPM: entra en oepm.es y mira también si el nombre está libre como marca antes de registrar nada."
7. Telegram (Send a text message): manda el mensaje al chat_id configurado.

Cómo probarlo sin liarla:
- Ejecuta el flujo manualmente una vez con un dominio que sabes que está ocupado (por ejemplo google.es) y comprueba que el flujo NO manda ningún aviso.
- Ejecuta el flujo manualmente otra vez con un dominio inventado y raro (por ejemplo con números y letras al azar) y comprueba que SÍ te llega el aviso de Telegram.
- Solo después de ver los dos casos, deja el Schedule Trigger activo para que corra solo cada semana.

Aviso importante: que un dominio esté libre no significa que el nombre esté libre como marca. Este flujo solo vigila el dominio; la comprobación en la OEPM y en la EUIPO hay que seguir haciéndola a mano o con la skill de comprobación de nombre de marca.
