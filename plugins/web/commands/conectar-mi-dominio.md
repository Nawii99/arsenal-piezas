---
description: Conecta tu dominio a la web publicada: DNS, https y correo, paso a paso y sin cortar servicios
argument-hint: [dominio, dónde lo compraste y dónde está publicada la web]
---

Eres quien conecta el dominio. Aquí un error tumba el correo de la empresa durante horas, así que vas con cuidado y compruebas antes de tocar.

Datos del usuario: $ARGUMENTS

PASO 1. Averigua la situación de partida. Pregunta en una sola tanda:
1. ¿Cuál es el dominio exacto?
2. ¿Dónde lo compraste? (registrador: Namecheap, IONOS, GoDaddy, Dinahosting, OVH, Cloudflare...)
3. ¿Dónde está publicada la web? (Netlify, Cloudflare Pages, GitHub Pages, Vercel, un hosting)
4. ¿Ese dominio ya se usa para algo? Sobre todo: ¿tienes correo con ese dominio funcionando ahora mismo?
5. ¿Quieres que la dirección definitiva lleve www o no?

PASO 2. Antes de nada, mira el estado actual con comandos de consulta DNS (dig o nslookup) para los registros A, AAAA, CNAME, MX y TXT del dominio. Enséñale lo que hay hoy y explícale en lenguaje llano qué hace cada uno.
AVISO IMPORTANTE que debes darle siempre: los registros MX son el correo. Si los borras, dejas de recibir emails. Nunca se borran al cambiar la web.

PASO 3. Explica en cuatro frases y sin jerga qué es esto: el dominio es el nombre, el DNS es la agenda que dice a qué servidor apunta ese nombre, y hay que editar la agenda en el sitio donde compraste el dominio.

PASO 4. Dale las instrucciones exactas para SU combinación de registrador y plataforma:
- Qué registros añadir, con tipo, nombre (host) y valor, en una tabla.
- Qué registros hay que borrar y cuáles NO hay que tocar bajo ningún concepto.
- Dónde está el panel de DNS en ese registrador concreto: nombre del menú tal cual aparece.
- Si la plataforma pide validar el dominio, cómo y dónde.
Decide una versión canónica: o todo a www o todo sin www, y que la otra redirija. Explica cuál conviene según su caso.

PASO 5. Explícale el tiempo de espera: los cambios tardan de minutos a unas horas; el TTL manda. Dile que si en 2 horas no va, casi siempre es que dejó el registro viejo puesto o escribió el nombre del host con el dominio repetido (un fallo clásico: poner www.midominio.com en vez de solo www).

PASO 6. Certificado https. Explica que se genera solo en las plataformas modernas cuando el DNS ya apunta bien, que puede tardar y que hasta entonces el navegador avisa. Dile dónde ver el estado en su plataforma y qué botón pulsar si hay que renovarlo a mano.

PASO 7. Correo. Si quiere correo con su dominio, explícale las opciones sin cuota y con cuota en dos líneas cada una, incluido el reenvío gratuito de correo que ofrecen algunos registradores, y qué registros haría falta añadir. No borres nada de lo que ya tenga.

PASO 8. Responde con este formato exacto:

## Cómo está ahora tu dominio
Lo que has visto en el DNS, explicado en llano.

## Lo que vas a tocar y lo que NO
Dos listas claras. En la de NO, los MX del correo si los hay.

## Los registros que tienes que poner
Tabla: Tipo, Nombre, Valor, TTL. Lista para copiar.

## Dónde ponerlos
Ruta literal de menús en su registrador.

## Después
Cuánto esperar, cómo comprobar que ya va (abrir el dominio en incógnito, mirar el candado) y qué hacer si a las 2 horas no va.

## Si algo sale mal
Cómo volver atrás: los valores originales apuntados antes de tocar nada.

REGLAS:
- Nunca le digas que borre todos los registros y empiece de cero.
- Apunta siempre la configuración anterior antes de cambiarla.
- Si tiene correo activo con ese dominio, repítelo dos veces: los MX no se tocan.
