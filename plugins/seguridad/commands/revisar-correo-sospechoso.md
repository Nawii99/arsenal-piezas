---
name: revisar-correo-sospechoso
description: Analiza un correo sospechoso a partir de sus cabeceras y su texto, dice si es suplantacion o phishing y que hacer, sin abrir enlaces ni adjuntos.
---

## Que hace

Toma un correo que te resulta raro y lo analiza en frio. No abre enlaces, no descarga adjuntos y no responde al remitente. Solo lee lo que le pegas y te da un veredicto con motivos.

El fallo mas comun no es caer en un correo muy elaborado: es contestar rapido desde el movil porque parece que lo manda el jefe o el banco y hay prisa. Este comando existe para meter treinta segundos de freno.

## Que preguntar antes

1. Pegame el texto completo del correo, sin recortar.
2. Pegame tambien las cabeceras originales. En Gmail: los tres puntos del mensaje, "Mostrar original". En Outlook: Archivo, Propiedades, Encabezados de Internet.
3. Que te pide exactamente: un pago, un cambio de numero de cuenta, meter la contrasena, firmar algo, abrir un fichero.
4. Esperabas ese correo, o ha llegado sin venir a cuento.
5. Si dice ser un proveedor o un compañero, tienes su telefono de siempre guardado aparte.

Si no tienes las cabeceras, sigue igualmente, pero avisa de que el analisis es parcial.

## Paso a paso

1. Separa el nombre que se muestra del correo real que hay detras. Casi todo el fraude vive en esa diferencia.
2. Comprueba el dominio letra a letra: guiones de mas, ceros por oes, .com por .es, subdominios largos que acaban en un dominio que no es.
3. En las cabeceras, mira SPF, DKIM y DMARC. Si alguna sale en "fail" o "none", dilo con esas palabras y explica que significa en una frase.
4. Mira el Reply-To. Si la respuesta se va a otro dominio distinto del remitente, es una señal fuerte.
5. Lista los enlaces en texto plano, sin abrirlos, y di a donde apuntan de verdad.
6. Busca las palancas de siempre: urgencia, amenaza de corte o multa, secreto ("no se lo digas a nadie"), cambio de cuenta bancaria, autoridad.
7. Marca los adjuntos peligrosos: .zip, .iso, .html, ficheros de Office que piden activar macros.
8. Da un veredicto en tres niveles: legitimo probable, dudoso, fraude casi seguro. Con el motivo principal en una linea.

## Que devolver

- Veredicto y nivel de confianza.
- Las tres señales que mas pesan, en lenguaje llano.
- Que hacer ahora, en orden y con verbos: no responder, no reenviar a compañeros, marcar como phishing, bloquear remitente, avisar al equipo por el canal interno.
- Si pedia dinero o un cambio de cuenta: verificar por telefono al numero de siempre, nunca al que viene en el correo.
- Si ya se hizo clic o se metio la contrasena: cambiar esa contrasena desde otro dispositivo, cerrar sesiones abiertas, revisar reglas de reenvio automatico del buzon y avisar al banco.

## Que NO hacer

- No abrir enlaces ni adjuntos para "comprobar".
- No responder al correo ni siquiera para preguntar si es real.
- No reenviarlo a compañeros sin avisar de que es sospechoso.
- No dar por bueno un correo solo porque el nombre que se ve es conocido.
- No prometer certeza absoluta: un analisis de texto y cabeceras no sustituye a mirar el buzon y los registros por dentro.

## Limites y cuando hace falta una persona

Esto sirve para decidir que haces con un correo. No sirve para saber si ya se han metido en tus sistemas.

Llama a un tecnico de seguridad o a tu asesoria el mismo dia si: ha salido dinero, se han metido credenciales de banca o de administracion, aparecen reglas de reenvio que no pusiste tu, hay clientes recibiendo correos en tu nombre, o el correo afecta a datos personales de terceros. En ese ultimo caso, en Espana puede haber obligacion de notificar a la AEPD en 72 horas, y eso lo valora una persona con responsabilidad profesional, no un comando.
