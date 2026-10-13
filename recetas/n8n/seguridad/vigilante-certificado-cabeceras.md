# Vigilante del certificado y las cabeceras…

**Tipo:** Receta de automatización · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Avisos semanales si un certificado vence pronto o las cabeceras de tu web fallan.

## Qué es y qué hace

Es una receta de n8n que avisa cada semana si un certificado de web está a punto de caducar o si las cabeceras de seguridad fallan. Solo te avisa a tiempo, no protege por sí sola. Entran las URLs de tus webs y un canal de aviso como Gmail con contraseña de aplicación; sale un aviso semanal con el estado de cada sitio. Solo vale para webs propias o encargadas por escrito.

## Cómo usarla

1. Lista tus webs en una hoja
2. Monta el disparador semanal y las comprobaciones
3. Revisa el primer aviso y ajusta los días de margen

## Cuándo usarla

Cuando llevas varias webs propias o de clientes y te enteras de que ha caducado el certificado porque te lo dice un cliente enfadado.

## Cómo ganar dinero con ella

Argumento de venta de un mantenimiento web de 40 a 90 euros al mes por sitio, con el informe semanal como entregable visible.

- Mantenimiento web de [TU PRECIO] al mes por sitio, con el informe semanal como entregable.
- Vigilancia de certificados para clientes que ya han sufrido una caída de su web.
- Informe semanal visible para la agencia que quiere demostrar que vigila sus webs.

**Precio orientativo:** 40–90 € al mes por sitio. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

Receta de n8n: vigilar certificado y cabeceras de tus webs, una vez por semana.

Que resuelve: casi nadie mira las cabeceras despues de montar la web, y el certificado caduca siempre en domingo. Esto no protege nada por si solo; solo te avisa a tiempo. Vale unicamente para webs tuyas o de clientes que te han encargado el mantenimiento por escrito.

Cuentas necesarias y limite gratuito:
- n8n. Version gratuita instalada en tu equipo o en un servidor pequeno, sin limite de ejecuciones. En n8n Cloud el plan de inicio tiene limite mensual de ejecuciones; con una ejecucion semanal no te acercas.
- Una cuenta de correo para el aviso. Gmail sirve, con contrasena de aplicacion. Limite de envio de sobra para esto.
- Nada mas. No hace falta ningun servicio de pago de seguridad.

Nodos, en orden:

1. Schedule Trigger. Modo semanal, lunes a las 08:00, zona horaria Europe/Madrid. Empezar por semanal y no por diario: un aviso diario que nadie lee es peor que ninguno.

2. Code, llamalo "Lista de sitios". Devuelve un elemento por web, cada uno con dominio y nombre del cliente. Asi anades sitios sin tocar el resto del flujo. Ejemplo de salida: return [{json:{nombre:'Clinica X', url:'https://clinicax.es'}}, {json:{nombre:'Mi web', url:'https://miweb.es'}}].

3. HTTP Request. Metodo GET, URL tomada del paso anterior. En opciones activa "Full Response" para recibir las cabeceras, y "Never Error" para que un sitio caido no rompa el flujo entero. Tiempo de espera 15 segundos. Redirecciones activadas.

4. Code, llamalo "Revisar cabeceras". Comprueba si vienen strict-transport-security, content-security-policy, x-content-type-options, x-frame-options y referrer-policy. Monta una lista con las que faltan y un contador. Guarda tambien el codigo de estado de la respuesta.

5. HTTP Request, llamalo "Caducidad del certificado". Consulta un servicio publico de informacion de certificados por el dominio y quedate con la fecha de fin. Alternativa mas simple si te lias: en un nodo Execute Command usa openssl para leer la fecha. Si tu n8n corre en la nube y no tienes Execute Command, quedate solo con lo que ya sabes: si la peticion HTTPS del paso 3 falla por certificado, ya es aviso suficiente.

6. Code, llamalo "Semaforo". Marca rojo si el sitio no responde, si el codigo no es 200 o 3xx, o si al certificado le quedan menos de 15 dias. Marca ambar si faltan dos o mas cabeceras o al certificado le quedan menos de 30 dias. Verde en el resto.

7. IF. Condicion: hay al menos un sitio en rojo o en ambar. Si todo esta verde, el flujo termina sin enviar nada. Un correo semanal diciendo que todo va bien acaba en la papelera sin abrirse.

8. Gmail (Send Message) o SMTP. Asunto: "Revision semanal de webs: N avisos". Cuerpo con una linea por sitio, primero los rojos, con el dominio, que pasa y que hay que hacer.

9. Opcional, Google Sheets (Append Row). Guarda cada ejecucion con fecha, dominio, estado y cabeceras que faltan. Te da un historial que puedes ensenar al cliente y sirve de registro del mantenimiento.

Como probarla sin liarla:
- Primero desconecta el nodo de correo y usa "Execute Workflow" a mano. Mira los datos que salen de cada nodo antes de dejar que envie nada.
- Prueba con un solo dominio tuyo en la lista. Cuando funcione, anade los demas.
- Para comprobar que el aviso salta, mete en la lista un dominio inventado. Tiene que salir en rojo. Luego quitalo.
- Deja el disparador semanal solo cuando hayas visto dos ejecuciones manuales correctas seguidas.

Errores que se cometen aqui:
- Poner "Never Error" y olvidarse: si el nodo no falla, un sitio caido puede pasar como verde. Por eso el semaforo mira el codigo de estado a mano.
- Vigilar dominios de terceros por curiosidad. Peticiones repetidas a webs que no gestionas pueden tomarse como sondeo. Solo tus sitios y los de clientes con encargo.
- Creerse que esto es una auditoria. Solo mira lo que se ve desde fuera y sin entrar.

Limites y cuando hace falta una persona: esto no detecta intrusiones, ni codigo malicioso inyectado, ni contenido manipulado. Si la web muestra algo que tu no has puesto, si redirige a otro sitio, si el hosting avisa de actividad rara o si hay datos de clientes por medio, para la automatizacion y llama a un tecnico de seguridad el mismo dia. Si hay datos personales afectados, quien decide si toca notificar a la AEPD es un asesor en proteccion de datos, no un flujo de n8n.
