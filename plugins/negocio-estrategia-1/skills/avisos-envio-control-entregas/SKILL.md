---
name: avisos-envio-control-entregas
description: Revisa el estado de los envíos de un negocio, señala pedidos parados o con incidencia y redacta los avisos al cliente para que una persona los apruebe. Se activa cuando el usuario habla de seguimiento de paquetes, estado de entregas, confirmaciones de envío, transportistas o U301.
---

# Avisos de envío y control de entregas

Esta skill ayuda a ver, día a día, qué pedidos van bien, cuáles están parados y a quién hay que escribir. Redacta los avisos al cliente. No cambia pedidos ni habla con la transportista sin que el usuario lo apruebe.

## Sobre U301

La ficha de origen presenta U301 como un servicio de seguimiento y logística. No está comprobado qué datos entrega ni si se puede conectar de forma automática. [COMPRUEBA EN LA WEB DE U301 si permite exportar envíos a Excel o CSV, o conectarse por API.] Esta skill funciona igual con cualquier otra fuente: la exportación de la tienda, un Excel o el panel de la transportista (Correos, Correos Express, SEUR, MRW, GLS, DHL, UPS u otra). Si U301 no resulta ser un servicio de envíos, úsala con tus propios datos.

## Antes de empezar, pregunta

- ¿De dónde salen los datos de envíos? U301, la tienda online, un Excel o los correos de la transportista.
- ¿Qué campos hay? Número de pedido, contacto del cliente, transportista, número de seguimiento, fecha de salida, estado y fecha estimada.
- ¿Qué plazo de entrega se promete al cliente?
- ¿Cómo se avisa hoy a los clientes (email, WhatsApp, SMS) y con qué textos?
- ¿Cuántos días sin movimiento se consideran un problema? Si no lo sabe, propón [N] días y pide confirmación.
- ¿Qué se hace ante una incidencia (reenvío, reembolso, reclamación a la transportista) y quién decide?

## Paso a paso

1. Carga los datos del archivo o de lo que pegue el usuario. Pídele que quite las columnas que no hagan falta (importes, DNI, datos de pago). Cuanto menos dato personal, mejor.
2. Unifica los estados en seis: preparando, recogido, en tránsito, en reparto, entregado e incidencia. En incidencia entran ausente, dirección incorrecta, retenido en aduana y devuelto al origen. Enseña la tabla de equivalencias que has aplicado para que una persona la corrija.
3. Calcula alertas: sin movimiento más de [N] días, fecha estimada superada, incidencia abierta y pedido sin número de seguimiento pasados [N] días desde la compra.
4. Propón una acción para cada alerta: avisar al cliente, reclamar a la transportista o revisar a mano. Marca lo que necesita decisión humana, sobre todo si hay dinero de por medio o el pedido es de valor alto.
5. Redacta los avisos por caso: envío confirmado (con seguimiento y enlace), en reparto hoy, retraso, incidencia (qué se necesita del cliente) y entregado (con una vía de contacto por si hay algún problema).
6. Escribe cada aviso en versión email y en versión corta para WhatsApp o SMS. Tono claro, sin culpar a nadie y sin prometer fechas que no controlas: «la transportista estima…».
7. Prepara el resumen del día con lo que hay que hacer, por orden de urgencia.
8. Si el usuario quiere automatizarlo, describe el recorrido en palabras: cada mañana, leer los envíos, sacar las alertas, preparar los borradores, revisión humana y envío. Si lo pide, pásalo después a una receta de n8n.

## Qué devolver

- Tabla de control con las columnas: pedido, transportista, estado unificado, días sin movimiento, alerta, acción propuesta y quién decide. Usa el número de pedido, no el nombre del cliente.
- Lista «Hoy hay que hacer», con diez puntos como máximo.
- Borradores de los avisos, uno por caso.
- Lista de datos que faltan, marcados como «sin dato».

## Qué NO hacer

- No cambies estados, no cierres pedidos, no reclames, no reembolses ni reenvíes sin aprobación.
- No inventes estados, fechas ni números de seguimiento.
- No prometas una fecha de entrega que no depende de ti.
- No metas ofertas ni publicidad en un aviso de envío. Un aviso de pedido es un mensaje de servicio. Con publicidad pasa a ser comercial y necesita permiso.
- Usa solo el canal que el cliente dio para ese pedido.
- No culpes a la transportista ni al cliente en los textos.
- No pegues más datos personales de los necesarios (nombre, dirección, teléfono). Si el usuario trabaja para un cliente, antes de tocar sus datos hace falta un contrato de encargado de tratamiento (RGPD, artículo 28).
- No des consejo legal sobre plazos ni reclamaciones.

## Qué revisa una persona antes de usar el resultado

- Los textos, antes de que salga ningún aviso.
- Cualquier decisión de dinero: reembolso, reenvío, compensación.
- Los plazos. Si no se pactó otro, la ley española fija un máximo de 30 días naturales para entregar [confirma con tu asesor]. Si hay retrasos graves, el cliente puede tener derechos que conviene mirar con un asesor.
- Que los datos de los clientes se tratan según el RGPD.

## Dónde se guarda

Guarda este texto como SKILL.md en la carpeta .claude/skills/avisos-envio-control-entregas/ de tu proyecto.
