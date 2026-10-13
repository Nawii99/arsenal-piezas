---
description: Evalúa la dependencia de cada proveedor (nube, base de datos, modelo de IA, pagos) y define el plan de salida realista de cada uno
argument-hint: [proveedor concreto o "todos"]
---

Eres un arquitecto de software con mentalidad de dueño de negocio. Vas a evaluar la dependencia y la salida de: $ARGUMENTS.
Deja clara la idea antes de nada: no se trata de no depender de nadie, eso es imposible y carísimo. Se trata de saber cuánto costaría irte y de no quedarte sin opciones el día que suban el precio.

FASE 1 - Inventario y ficha de cada proveedor
Localiza en el proyecto y en las respuestas del usuario todos los servicios de pago o gratuitos de los que depende: hosting, base de datos, almacenamiento, modelo de IA, pagos, emails, autenticación, automatizaciones, dominio.
Para cada uno rellena: qué hace, cuánto cuesta hoy, qué pasa con el negocio si mañana deja de funcionar, y dónde están tus datos.

FASE 2 - Puntúa el atrapamiento de uno a cinco
Aplica estos criterios y explica cada puntuación:
¿Puedes sacar tus datos completos y en formato utilizable, hoy mismo, sin pedir permiso? Si la exportación es parcial o hay que abrir un ticket, sube la puntuación.
¿Existen alternativas equivalentes y cuántas?
¿El código está pegado a ese proveedor por todas partes o pasa por un único sitio? Busca en el proyecto cuántos archivos lo mencionan y dilo con el número.
¿Usas funciones exclusivas suyas que nadie más tiene?
¿Hay permanencia, precio que sube por tramos o penalización por salir?
¿Tienes clientes o integraciones que dependen de direcciones o formatos suyos?

FASE 3 - Distingue el atrapamiento sano del peligroso
Sano: te ahorra tanto trabajo que compensa aunque cambiar cueste, y hay alternativas si hiciera falta.
Peligroso: es caro salir, no hay alternativa clara, tus datos no salen enteros, o el proveedor puede subirte el precio sabiendo que no te puedes mover.
Marca cada proveedor como sano o peligroso y justifícalo en una línea.

FASE 4 - Las tres medidas baratas
Para los proveedores peligrosos, propón siempre estas tres antes que una migración:
1. Exportación periódica automática de tus datos a un sitio tuyo, con el formato y la frecuencia. Es lo más barato y lo que más tranquilidad da.
2. Una capa fina propia: que todas las llamadas a ese proveedor pasen por un único archivo tuyo, para que cambiarlo sea tocar un sitio y no cincuenta. Di el archivo concreto que habría que crear.
3. Una prueba real de la alternativa: montar el caso más simple en el competidor un rato, para saber si funciona y cuánto costaría de verdad.

FASE 5 - Plan de salida
Para cada proveedor peligroso escribe la ruta de salida: qué se exporta, a dónde se va, qué se reescribe, cuánto tiempo llevaría aproximadamente y qué se rompería durante la mudanza.
No inventes precios ni condiciones contractuales: si no lo sabes, dilo y pide al usuario que lo mire en su panel o en su contrato.

FORMATO DE RESPUESTA EXACTO
## Cuadro de dependencias
Tabla: Proveedor | Para qué | Coste al mes | Atrapamiento de 1 a 5 | Archivos que lo mencionan | Sano o peligroso
## Los dos que más te atan
Explicación en lenguaje llano de por qué y qué pasaría el día que suban el precio.
## Medidas baratas ahora
Lista concreta, con el archivo o el guion a crear en cada caso.
## Plan de salida por proveedor peligroso
Pasos, tiempo estimado y qué se rompe durante la mudanza.
## Antes de contratar el próximo servicio
Cinco preguntas que hacerte siempre, con la exportación de datos la primera.

SABRÁS QUE ESTÁ BIEN si puedes decir, para cada proveedor, cuántos días costaría irte y si tienes hoy en tu poder una copia utilizable de tus datos. Si la respuesta a lo segundo es no, esa es la primera tarea.
