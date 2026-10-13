# API falsa con n8n para probar flujos sin tocar el CRM real…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Levanta una URL que devuelve clientes inventados en JSON. Prueba tus flujos contra datos falsos antes de tocar el CRM de verdad.

## Qué es y qué hace

Receta de n8n que levanta una URL pública (webhook) y responde con clientes inventados en JSON. Recibe una petición GET, devuelve un array de registros generados por un nodo Code o Set, y no usa ninguna cuenta externa. Sirve para conectar tu flujo a una maqueta de CRM o tienda y cambiar después la URL por la real.

## Cómo usarla

1. Crea el webhook GET con ruta clientes-falsos
2. Añade un nodo Code con los datos inventados
3. Responde con Respond to Webhook
4. Cambia la URL cuando pruebes

## Cuándo usarla

Estás construyendo un flujo o una app que leerá un CRM o una tienda, pero todavía no quieres conectar los datos reales.

## Cómo ganar dinero con ella

Ofrécela como extra dentro de un proyecto de integración con n8n: el cliente ve el flujo funcionando contra una maqueta antes de conectar su sistema, y lo incluyes en el presupuesto del proyecto a [TU PRECIO].

- Maqueta de API para que un cliente vea su flujo funcionando antes de conectar su CRM…
- Entorno de pruebas incluido en proyectos de integración con n8n para pymes…
- Servicio de prototipado de integraciones cuando la API real aún no está disponible…

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué consigues
Una dirección web (una URL) que, cuando algo la llama, devuelve una lista de clientes inventados en JSON. Es una maqueta de API: se comporta como lo haría tu CRM o tu tienda, pero sin datos reales. Cuando el flujo que estás construyendo funcione contra la maqueta, cambias la URL por la real y listo.

## Cuentas que hacen falta
- n8n. Dos opciones: n8n Cloud, que tiene prueba gratuita limitada en días ([comprueba la duración actual en n8n.io/pricing]) y después es de pago; o n8n instalado en tu ordenador o servidor, gratis sin límite de ejecuciones. Para esta receta vale cualquiera de las dos.
- Nada más. Esta receta no usa ningún servicio externo.

## Nodos, en orden

### 1. Webhook (disparador)
- Método HTTP: GET.
- Path: `clientes-falsos`.
- Respond: `Using 'Respond to Webhook' Node`.
- Authentication: None mientras pruebas en local. Si lo dejas en n8n Cloud más de un día, pon `Header Auth` con una clave inventada; si no, cualquiera que adivine la URL puede llamarla y gastar tus ejecuciones.
- Al guardar, n8n te da dos URLs: la de Test (solo funciona mientras pulsas "Listen for test event") y la de Production (funciona cuando activas el flujo). Anota las dos.

### 2. Debug Helper
- Action: `Generate Random Data`.
- Data Type: `User Data`.
- Number of Items: 10 (o los que quieras devolver). No pases de 50: es una maqueta, no una base de datos.
- Seed: escribe una palabra cualquiera, por ejemplo `pruebas2026`. Con seed, cada llamada devuelve los mismos datos, y eso es lo que quieres para probar: si algo falla, puedes repetir exactamente el mismo caso.
- Este nodo saca nombres, emails y direcciones inventados con formato internacional (nombres anglosajones, teléfonos de EE. UU.). Para la mayoría de pruebas basta. Si necesitas formato español, sigue al nodo 3; si no, sáltalo.

### 3. Edit Fields (Set), opcional, para darle formato español
- Mode: Manual Mapping. Include Other Input Fields: desactivado.
- Añade estos campos (cada uno como String salvo donde se indica):
  - `id` (Number): `{{ $itemIndex + 1 }}`
  - `nombre`: `{{ $json.firstname }}`
  - `apellidos`: `{{ $json.lastname }}`
  - `email`: `{{ $json.firstname.toLowerCase() }}.{{ $json.lastname.toLowerCase() }}@example.es`
  - `telefono`: `600 000 0{{ String($itemIndex).padStart(2, '0') }}`
  - `ciudad`: `{{ ['Madrid','Barcelona','Valencia','Sevilla','Zaragoza','Bilbao','Málaga'][$itemIndex % 7] }}`
  - `estado`: `{{ $itemIndex % 5 === 0 ? 'moroso' : 'activo' }}`
  - `importe_eur` (Number): `{{ Math.round((($itemIndex * 137) % 4800 + 20) * 100) / 100 }}`
- Así los emails van todos a example.es (nunca llegan a nadie) y los teléfonos son claramente falsos.

### 4. Aggregate
- Aggregate: `All Item Data (Into a Single List)`.
- Put Output in Field: `clientes`.
- Esto junta las 10 filas en una sola respuesta, que es lo que haría una API de verdad.

### 5. Respond to Webhook
- Respond With: `JSON`.
- Response Body: `{{ JSON.stringify({ total: $json.clientes.length, clientes: $json.clientes }) }}`
- Response Code: 200.
- Opcional: en Response Headers añade `Content-Type` con valor `application/json`.

## Cómo probarla sin liarla
1. Guarda el flujo. No lo actives todavía.
2. Pulsa "Listen for test event" en el nodo Webhook. Copia la URL de Test.
3. Pégala en el navegador del ordenador o del móvil. Tienes que ver un JSON con `total` y la lista `clientes`. Si ves un error, mira qué nodo se ha puesto en rojo en n8n: casi siempre es una expresión mal copiada en el nodo 3.
4. Cuando funcione, activa el flujo (interruptor arriba a la derecha) y usa la URL de Production desde el flujo o la app que estás construyendo. En otro flujo de n8n la llamas con un nodo HTTP Request, método GET.
5. Para simular que la API falla (y comprobar que tu flujo lo aguanta), duplica el nodo Respond to Webhook, ponle Response Code 500 y conéctalo en lugar del original durante la prueba. Después vuelve a conectar el bueno.

## Lo que tienes que saber
- En n8n Cloud cada llamada a la URL consume una ejecución de tu cuota. Diez pruebas no son nada; un flujo que la llame cada minuto, sí.
- Desactiva el flujo cuando termines de probar. Una URL pública que devuelve datos, aunque sean falsos, no tiene por qué quedarse encendida.
- La maqueta devuelve siempre lo mismo. No sirve para probar volumen ni velocidad, solo para probar que tu flujo entiende bien el formato y reacciona bien a errores.
- Cuando cambies a la API real, revisa los nombres de los campos: tu CRM no los llamará `nombre` y `apellidos` igual que la maqueta. Ese es el momento en que más flujos se rompen.
