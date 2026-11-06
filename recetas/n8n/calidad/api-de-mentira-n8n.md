# API de mentira en n8n…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Un flujo de n8n que se hace pasar por el CRM, la pasarela de pago o el servicio de email que aún no quieres tocar, y devuelve respuestas inventadas para probar tu flujo sin gastar.

## Qué es y qué hace

Flujo de n8n que imita un servicio externo (CRM, pasarela de pago, email) con un webhook que devuelve respuestas inventadas. Tu flujo principal lo llama igual que al real, así no gasta créditos ni crea contactos reales. Recibe un POST, aplica un nodo Set con la respuesta de prueba y la devuelve con Respond to Webhook.

## Cómo usarla

1. Crea el webhook POST mock-crm
2. Define la respuesta falsa en Set
3. Responde con Respond to Webhook
4. Cambia la URL en el flujo principal al pasar a real
5. Que lo revise un profesional

## Cuándo usarla

Cuando estás montando un flujo que llama a un servicio de pago o con límite de peticiones y cada prueba cuesta dinero o crea basura en la cuenta real. También si el cliente aún no te da acceso.

## Cómo ganar dinero con ella

Te permite construir y enseñar flujos antes de tener las credenciales del cliente. Reduce el tiempo de implantación y evita costes de API durante el desarrollo.

- Entorno de pruebas para integrar pagos sin cobrar durante el desarrollo…
- Simulador de API para equipos que aún no tienen credenciales del cliente…
- Mantenimiento de maquetas de API cuando el cliente cambia de proveedor…

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# API de mentira en n8n

## Qué resuelve
Tu flujo principal llama a un servicio externo (CRM, Stripe, Brevo, una API de IA). Cada prueba crea contactos reales, gasta créditos o choca con el límite de peticiones. Con esta receta montas un segundo flujo que responde como si fuera ese servicio, con datos inventados. Tu flujo principal no nota la diferencia.

## Cuentas necesarias
- n8n: autoalojado gratis (Docker o npm), o n8n Cloud con prueba gratuita de [DÍAS] y luego desde [PRECIO] al mes. Con la versión gratuita autoalojada basta.
- Nada más. No hace falta cuenta en el servicio que simulas: esa es la gracia.

## Flujo de la API de mentira, nodo por nodo
1. Webhook (disparador). Método POST. Ruta: `mock-crm` (o el nombre del servicio que simules). Respuesta: elige `Using Respond to Webhook node`. Copia la URL de test; la de producción aparece al activar el flujo.
2. Set (renombrar a `Leer entrada`). Guarda en variables lo que llega: `email`, `nombre`, `escenario`. El campo `escenario` es el truco: tu flujo principal lo envía para decirle a la API de mentira cómo comportarse. Valores: `ok`, `duplicado`, `error`, `lento`.
3. Switch (renombrar a `Elegir escenario`). Cuatro salidas según el valor de `escenario`. Si llega vacío, va por `ok`.
4. Salida `ok`: nodo Set con la respuesta que daría el servicio real cuando todo va bien. Ejemplo para un CRM: `{ "id": "contacto_{{ $now.toMillis() }}", "email": "{{ $json.email }}", "estado": "creado" }`. Copia el formato de la documentación del servicio real para que los campos se llamen igual.
5. Salida `duplicado`: nodo Set con la respuesta de error de contacto ya existente. Ejemplo: `{ "error": "CONTACT_EXISTS", "mensaje": "Ya existe un contacto con ese email" }`.
6. Salida `error`: nodo Set con un error genérico del servidor. Ejemplo: `{ "error": "INTERNAL_ERROR", "mensaje": "Servicio no disponible" }`.
7. Salida `lento`: nodo Wait de 8 segundos y luego el mismo Set que `ok`. Sirve para ver qué hace tu flujo principal cuando el servicio tarda.
8. Respond to Webhook (uno por rama, o une las cuatro ramas en uno solo). Tipo de respuesta: JSON. Código de estado: 200 en `ok` y `lento`, 409 en `duplicado`, 500 en `error`. Los códigos importan: tu flujo principal debe reaccionar distinto a cada uno.

## Cómo se conecta con tu flujo principal
- En el flujo principal, el nodo HTTP Request que llamaba al servicio real pasa a apuntar a la URL del webhook de mentira. Guarda la URL real en una nota dentro del flujo para no perderla.
- Añade al cuerpo de esa petición el campo `escenario` con el valor que quieras probar. Cuando pases a real, quita ese campo y vuelve a poner la URL verdadera. Solo esas dos cosas cambian.
- Si el flujo principal tiene un nodo Error Trigger o rama de error, ahora puedes verla funcionar de verdad enviando `escenario: error`.

## Cómo probarla sin liarla
1. Activa solo el flujo de la API de mentira. Desde el flujo principal, ejecuta con el botón de test y `escenario: ok`. Comprueba que la respuesta llega con los campos esperados.
2. Repite con `duplicado`, `error` y `lento`. Anota qué hace tu flujo en cada caso. Si con `error` sigue adelante como si nada, ahí tienes el fallo que en producción te habría costado un disgusto.
3. Usa datos falsos en todas las pruebas: emails `@example.com`, teléfonos con 555. Aunque la API sea de mentira, tu flujo principal puede tener otros nodos (una hoja, un email) que sí son reales.
4. Antes de volver al servicio real, revisa que has quitado el campo `escenario` y cambiado la URL. Hazlo con la checklist de la skill `entorno-de-pruebas`.

## Límites y avisos
- Esta API de mentira responde lo que tú le hayas escrito. No valida nada: si el servicio real rechaza un email mal formado y tu mentira no, la prueba te dará una falsa tranquilidad. Copia al menos dos errores reales de la documentación del servicio.
- Los webhooks de test en n8n solo escuchan mientras tienes el editor abierto y has pulsado ejecutar. Para pruebas repetidas, activa el flujo y usa la URL de producción del webhook.
- Si el flujo de mentira está activo en un n8n accesible desde internet, cualquiera que conozca la URL puede llamarlo. No pasa nada grave porque no hace nada, pero desactívalo cuando termines.
