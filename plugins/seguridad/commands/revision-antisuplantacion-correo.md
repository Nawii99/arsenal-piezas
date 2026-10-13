---
name: revision-antisuplantacion-correo
description: Revisa SPF, DKIM y DMARC de un dominio y entrega un informe con el riesgo de suplantación y los pasos para cerrarlo. Se activa cuando alguien pide comprobar si pueden enviar correos falsos en nombre de su negocio.
---

## Qué hace

Consulta los registros públicos de un dominio (SPF, DKIM, DMARC, MX) y explica, sin tecnicismos, si hoy alguien podría enviar correos haciéndose pasar por ese negocio. Devuelve un informe para el cliente y una lista de cambios para quien administre el dominio.

Solo lee datos públicos del DNS. No entra en buzones, no envía correos de prueba a terceros y no suplanta a nadie.

## Qué preguntar antes

1. Dominio o dominios a revisar.
2. Confirmación por escrito de que el cliente es el titular y autoriza la revisión (vale un correo suyo).
3. Quién gestiona el dominio: el propio cliente, una agencia, la empresa de la web.
4. Desde dónde se envían correos de verdad: gestor de correo, herramienta de envíos, facturación, formulario de la web.

Si falta la autorización escrita, no sigas.

## Paso a paso

1. Consulta los registros: `dig +short TXT dominio.com`, `dig +short TXT _dmarc.dominio.com`, `dig +short MX dominio.com`.
2. Lee el SPF: anota si existe, cuántas consultas encadena y cómo termina (`-all`, `~all`, `?all` o nada).
3. Comprueba si hay DKIM en los selectores habituales del proveedor de correo que use el cliente.
4. Lee el DMARC: si no existe, el riesgo es alto; si está en `p=none`, hay política pero no protege todavía.
5. Cruza la lista de remitentes reales del paso previo con lo que permite el SPF y apunta los que faltan.
6. Clasifica el riesgo en alto, medio o bajo con una frase que entienda el cliente.
7. Escribe el plan por fases: primero completar SPF y DKIM, después DMARC en `p=none` con informes, y solo cuando los informes salgan limpios subir a `quarantine` y luego a `reject`.
8. Añade la parte humana: cómo verifican por teléfono un cambio de número de cuenta y quién autoriza pagos.

## Qué devolver

- Tabla con el estado actual de cada registro y qué significa.
- Riesgo en una frase.
- Plan en tres fases con qué toca en cada una y el tiempo de espera entre fases.
- Los valores exactos a poner en el DNS, marcados como propuesta a validar.

## Qué NO hacer

- No envíes correos de prueba suplantando al dominio, ni siquiera como demostración.
- No toques el DNS tú mismo sin permiso explícito y una ventana acordada: un SPF mal puesto tumba el correo del negocio.
- No saltes a `p=reject` de golpe; se pierden facturas y pedidos.
- Si el cliente ya ha sufrido un fraude con dinero de por medio, dilo claro: eso es denuncia y aviso al banco, y lo lleva una persona responsable, no un informe.
