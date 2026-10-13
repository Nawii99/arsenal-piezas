---
name: diagnostico-correos-que-caen-en-spam
description: Diagnostica por qué tus emails caen en spam, rebotan o no llegan, y devuelve un plan de arreglo ordenado por prioridad. Úsala cuando newsletters, facturas o pedidos no lleguen a la bandeja de entrada.
---
# Diagnóstico de correos que caen en spam
Dónde va: `.claude/skills/diagnostico-correos-que-caen-en-spam/SKILL.md`. Se activa al pedir algo parecido o empezando el mensaje con `/diagnostico-correos-que-caen-en-spam`.
## Qué hace
- Lee lo que le pegues (cabeceras de un correo, informe de rebotes, resultados de comprobadores) y separa tres problemas: el correo no sale, rebota o llega a spam.
- Explica en lenguaje llano qué significa cada cosa y qué hay que comprobar.
- Devuelve un plan ordenado: hoy, esta semana, este mes.
- Diagnostica, no arregla. Los cambios en el dominio (los registros DNS) los hace quien lo administra.
## Antes de empezar, pregunta
1. ¿Desde qué dirección y dominio envías, por ejemplo hola@tudominio.es?
2. ¿Con qué herramienta? Gmail o Google Workspace, Outlook, Brevo, Mailchimp, MailerLite, SendGrid, la de tu tienda u otra.
3. ¿Qué correos fallan: la newsletter, las facturas y pedidos, o las respuestas personales?
4. ¿Dónde fallan: Gmail, Outlook o Hotmail, Yahoo, todos? ¿Van a spam o no llegan?
5. ¿Desde cuándo? ¿Qué cambió antes: herramienta, dominio, lista, volumen o texto?
6. ¿Cuántos correos envías por día o por campaña?
7. ¿De dónde salió la lista y cómo se apuntó la gente? ¿Hay doble confirmación?
8. ¿Quién administra el dominio, es decir, quién puede cambiar sus registros DNS?
## Qué pedir que te peguen, y qué no
- Sí: las cabeceras completas de un correo que haya caído en spam (en Gmail, los tres puntos y Mostrar original), el texto de los rebotes con su código (como 550 5.7.1) y el resultado de comprobadores gratuitos (MXToolbox, mail-tester, Google Postmaster Tools).
- No: contraseñas, claves de API ni correos de clientes. Las cabeceras llevan direcciones de personas, así que usa un correo de prueba tuyo o tapa lo que sobre.
## Paso a paso
1. Localiza el fallo. No sale: error al enviar o la herramienta lo bloquea. Rebota: vuelve un aviso del servidor del destinatario. Llega a spam: aparece, pero en la carpeta equivocada.
2. Autenticación, que es el carnet de identidad de tu correo. SPF dice qué servidores pueden enviar en nombre de tu dominio. DKIM firma el mensaje para probar que nadie lo ha cambiado. DMARC dice qué hacer con lo que no cumpla y te manda informes. Comprueba que los tres existen y encajan con el dominio que ve el lector.
3. Errores típicos de autenticación: dos registros SPF para el mismo dominio (solo puede haber uno), un SPF con demasiadas consultas (el máximo es 10) o DKIM sin activar en la herramienta de envío.
4. Reglas de los grandes buzones. Gmail y Yahoo exigen a quien envía mucho (más de 5.000 correos al día a sus usuarios) SPF, DKIM y DMARC, baja con un clic y pocas quejas de spam, con tope en el 0,3%. Microsoft aplica reglas parecidas a Outlook y Hotmail desde 2025. [Verifica las cifras vigentes en las páginas oficiales: cambian.]
5. Rebotes. Duros (la dirección no existe, código 5.1.1): se quitan de la lista y no se vuelve a escribir. Blandos (buzón lleno o fallo temporal, códigos 4.x.x): se reintenta unos días y, si sigue, se retira. Bloqueo por política o reputación (5.7.1): pasa al punto siguiente.
6. Reputación y lista. Pregunta cómo se consiguió la lista. Una lista comprada, antigua o sin permiso es la causa más habitual de problemas. Mira la proporción de gente que no abre nunca: puede conviene separarla y escribirle menos o dejar de escribirle.
7. Contenido. Revisa asuntos engañosos, mayúsculas y signos de más, un correo que es solo una imagen, acortadores de enlaces públicos y enlaces a dominios con mala fama. Es lo último que se mira, no lo primero.
8. Separar tipos de correo. Facturas y pedidos desde un subdominio y la newsletter desde otro, para que los problemas de uno no arrastren al otro.
9. Si el dominio o la herramienta son nuevos, o has cambiado de herramienta: sube el volumen poco a poco en lugar de enviar todo de golpe.
10. Plan y recomprobación. Tras los cambios, espera de 7 a 14 días y repite las mismas pruebas. Compara antes y después.
## Qué devolver
Un informe con este formato:
```
1. Resumen en 3 líneas
2. Lo que se ve en los datos (hechos)
3. Causas probables, de más a menos probable (hipótesis, no certezas)
4. Lo que falta por comprobar y cómo
5. Plan: hoy / esta semana / este mes, indicando quién lo hace: tú, quien administra el dominio o el soporte de la herramienta
6. Cómo comprobar que ha mejorado
```
## Qué revisa una persona antes de usar el resultado
- Quien administra el dominio: cada cambio de DNS, antes de aplicarlo y con copia del valor anterior. Un SPF mal puesto puede dejar sin correo a toda la empresa.
- Tu asesor de protección de datos: si vas a subir tu lista a un servicio de limpieza de direcciones. Es un tercero que trata datos personales y necesita contrato.
- Tú: que la lista tiene permiso para recibir tus envíos. Si no lo tiene, el problema no es técnico.
## Qué NO hacer
- No prometas que los correos llegarán a la bandeja de entrada. Nadie puede asegurarlo.
- No inventes causas. Si faltan datos, di cuáles faltan y cómo conseguirlos.
- No toques el DNS ni pidas contraseñas o claves.
- No propongas trucos para esquivar filtros: cambiar de dominio, esconder texto o comprar listas para compensar. Empeoran el problema.
- No recomiendes subir la lista de clientes a servicios de terceros sin comprobar el contrato de tratamiento de datos.
- No envíes más correos a una lista con muchos rebotes o quejas hasta limpiarla y corregir el origen.
- Si el volumen es muy alto o el negocio depende del correo, pide ayuda a un especialista en entregabilidad o al soporte de tu herramienta.
