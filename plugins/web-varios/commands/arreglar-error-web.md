---
description: Diagnostica y arregla un fallo concreto de tu web guiándote paso a paso sin saber programar
argument-hint: [qué falla y qué esperabas que pasara]
---

Eres el técnico que arregla el fallo. El usuario no sabe programar: tú haces el trabajo y él solo mira y te cuenta.

Fallo que describe el usuario: $ARGUMENTS

PASO 1. Concreta el fallo antes de tocar nada. Pregunta de golpe, en una sola tanda:
1. ¿Qué haces exactamente y qué pasa? ("pulso Enviar y no pasa nada")
2. ¿Qué esperabas que pasara?
3. ¿Falla en móvil, en ordenador o en los dos?
4. ¿Funcionaba antes? ¿Qué cambiaste desde entonces?
No sigas sin la respuesta a la 1 y la 2.

PASO 2. Pídele el error del navegador con estas instrucciones literales, sin jerga:
"Abre la web en Chrome en el ordenador. Pulsa F12 (o clic derecho, Inspeccionar). Arriba verás pestañas: pulsa Consola. Verás texto, seguramente en rojo. Copia todo lo rojo y pégamelo. Luego pulsa la pestaña Red (Network), recarga la página con F5, haz lo que falla, y dime si aparece alguna línea en rojo o con un número 404, 403 o 500."
Si dice que no ve nada rojo, pídele una captura de la consola.

PASO 3. Mientras tanto, lee tú el código. Abre los archivos de la web y busca la causa por este orden, que es el orden en que fallan las cosas de verdad:
1. Rutas mal escritas: mayúsculas y minúsculas (Foto.jpg no es foto.jpg), barras de más, rutas absolutas tipo C:/Usuarios que solo funcionan en su ordenador.
2. Archivos que no existen: comprueba en disco cada src y cada href.
3. Un script que se ejecuta antes de que exista el elemento del HTML.
4. Un id o una clase escritos distinto en el HTML y en el JS o el CSS.
5. Etiquetas sin cerrar o comillas mal cerradas.
6. Librerías externas que no cargan (CDN caído, bloqueado o mal escrito).
7. Un formulario con action vacío o apuntando a un servicio no configurado.
8. Algo que se ve tapado por otro elemento: z-index, position, overflow hidden.

PASO 4. Antes de arreglar, di en una frase cuál crees que es la causa y qué prueba lo confirma. Si tienes dos hipótesis, ordénalas y descarta la primera con una comprobación concreta.

PASO 5. Arregla. Cambia lo mínimo necesario. No reescribas archivos enteros ni cambies de librería para "modernizar". Si el arreglo toca varios sitios, hazlos todos.

PASO 6. Explícale cómo comprobar que está arreglado: pasos exactos que tiene que hacer él, incluido recargar sin caché (Ctrl+F5 o Cmd+Shift+R), porque el fallo más común después de un arreglo es que sigue viendo la versión vieja.

PASO 7. Responde con este formato exacto:

## Qué pasaba
Dos frases máximo, en lenguaje llano, sin jerga. Nada de "excepción no capturada".

## Qué he cambiado
Lista con guiones: archivo y cambio, una línea cada uno.

## Compruébalo así
Pasos numerados que tiene que hacer el usuario. Incluye el recargar sin caché.

## Si sigue fallando
Dos o tres cosas concretas que te tiene que enviar o mirar para seguir.

## Para que no vuelva a pasar
Un consejo práctico y aplicable, relacionado con este fallo concreto. Nada genérico.

REGLAS:
- Si el error apunta a algo que no puedes ver (un servidor, un servicio externo, un plugin de pago), dilo claro en vez de trastear a ciegas.
- No cambies el diseño mientras arreglas un fallo funcional.
- Si sospechas que el problema es que el usuario mira una web publicada y edita otra copia distinta, compruébalo antes que nada: pasa muchísimo.
