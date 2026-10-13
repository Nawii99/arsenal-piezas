---
description: Guía paso a paso para configurar los registros DNS de un dominio: apuntar la web, subdominios, correo profesional y verificaciones
argument-hint: [dominio y dónde está alojada la web]
---

Vas a configurar el dominio: $ARGUMENTS

## Paso 0: preguntas obligatorias
Pregunta y espera respuesta antes de dar ningún registro:
1. Dominio exacto.
2. Dónde lo compró: registrador (por ejemplo Namecheap, IONOS, Dinahosting, GoDaddy, Cloudflare).
3. Dónde está la web: Cloudflare Pages, Netlify, Vercel, GitHub Pages, hosting tradicional o tienda tipo Shopify.
4. Si quiere correo con el dominio y con qué proveedor.
5. Si el dominio ya está en uso con algo (para no tumbarlo sin avisar).

## Paso 1: explica los tipos de registro en cristiano
Antes de nada, tres líneas de explicación:
- A: apunta el dominio a una dirección IP, un número.
- CNAME: apunta un nombre a otro nombre. Se usa para www y para servicios.
- MX: dice qué servidor recibe el correo del dominio.
- TXT: notas de verificación y seguridad del correo (SPF, DKIM, DMARC).

## Paso 2: la web
Da la tabla exacta de registros según el proveedor que te haya dicho:
- Regla general: el dominio raíz (arroba) con A o con ALIAS/ANAME si el proveedor lo soporta, y www con CNAME.
- Advierte: en el dominio raíz no se puede poner un CNAME normal; si su registrador no ofrece ALIAS, hay que usar A con las IP del proveedor o mover el DNS a Cloudflare.
- Decide con el usuario cuál es la versión buena, con www o sin www, y que la otra redirija. Tener las dos vivas duplica el contenido para Google.

## Paso 3: el correo
Si quiere correo profesional, explica las opciones y su coste aproximado sin prometer precios exactos: Google Workspace y Microsoft 365 de pago, Zoho Mail con plan gratuito limitado, o el correo incluido en su hosting.
Da los registros MX en orden de prioridad y explica que la prioridad más baja es la principal.
Explica SPF, DKIM y DMARC en una línea cada uno: sirven para que tus correos no acaben en spam y para que nadie escriba haciéndose pasar por ti.
Advierte de que solo puede haber un registro SPF; si ya hay uno, hay que fusionarlos, no añadir otro. Este es el error más repetido.

## Paso 4: avisos que tienes que dar siempre
- Los cambios tardan entre unos minutos y 48 horas en verse en todas partes. No hay que tocar diez veces mientras tanto.
- Si borra los MX, deja de recibir correo al instante.
- Si el registrador tiene activado un aparcamiento o redirección del dominio, hay que quitarlo o pisará la configuración.
- El certificado https suele emitirse solo, pero puede tardar un rato tras apuntar el dominio.

## Formato de respuesta
1. Resumen de lo que va a quedar montado, en tres líneas.
2. Tabla de registros: Tipo / Nombre / Valor / Prioridad / Para qué sirve.
3. Pasos numerados de dónde meterlos en su registrador concreto.
4. Qué borrar de lo que ya hay.
5. Cómo comprobar: abrir dnschecker.org y consultar el dominio, y enviarse un correo de prueba desde fuera.

Si algún dato depende del panel del proveedor y no lo puedes saber, dilo y explica dónde encontrarlo, sin inventar IP ni valores.
