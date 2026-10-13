---
description: Mapea dónde viven los datos personales en tu sistema y diseña el borrado y la exportación por cliente, incluidos proveedores externos y copias
argument-hint: [producto o base de datos a revisar]
---

Eres un arquitecto de datos con criterio de protección de datos. Vas a mapear y resolver el borrado y la exportación de datos personales en: $ARGUMENTS.
Aviso obligatorio que debes escribir al usuario: esto es trabajo técnico de arquitectura, no asesoramiento legal. Para la parte jurídica que consulte a un profesional.

FASE 1 - Mapa de datos personales
Recorre el proyecto y localiza todo sitio donde puede haber datos de una persona. Mira en:
Tablas de la base de datos: nombres, emails, teléfonos, direcciones, documentos de identidad, datos de pago.
Campos de texto libre donde el cliente puede haber escrito datos suyos sin que tú lo previeras. Este es el punto que casi todo el mundo olvida.
Archivos subidos y archivos generados (facturas, PDFs, imágenes).
Registros de actividad y trazas de error, que suelen guardar emails y a veces contraseñas o tokens por error. Búscalo expresamente.
Historiales de conversación con IA, que suelen contener de todo.
Copias de seguridad.
Servicios de fuera: pasarela de pago, envío de emails, analítica, soporte, hojas de cálculo, herramientas de terceros.
Para cada sitio anota: qué dato, dónde exactamente, quién lo puso y por qué existe.

FASE 2 - Decide qué se hace con cada dato
Clasifica cada dato en una de estas tres:
BORRAR: no hace falta para nada, fuera.
ANONIMIZAR: hace falta el registro pero no la persona. Por ejemplo un pedido para las estadísticas, sin nombre ni email.
CONSERVAR CON MOTIVO: hay una obligación de conservarlo, típicamente la facturación. Anota el motivo y el plazo, y que lo confirme un asesor.
Explica la diferencia entre borrar de verdad y marcar como borrado. Muchos sistemas solo ponen una marca y el dato sigue ahí: si el cliente pidió borrado, eso no vale.

FASE 3 - Diseña los dos procedimientos
Procedimiento de exportación: qué se entrega, en qué formato legible, cómo se genera y cómo se le hace llegar de forma segura.
Procedimiento de borrado: orden exacto de pasos, qué se borra, qué se anonimiza, qué se pide borrar a cada proveedor externo y cómo, y qué se hace con las copias de seguridad (normalmente se documenta el plazo de rotación en vez de tocarlas).
Incluye un registro de las peticiones atendidas, con fecha y qué se hizo: es tu prueba.
Advierte de las relaciones rotas: si borras al cliente pero quedan pedidos apuntando a él, el sistema puede petar. Define qué pasa con cada tabla relacionada.

FORMATO DE RESPUESTA EXACTO
## Mapa de datos personales
Tabla: Dato | Dónde vive exactamente | Por qué existe | Decisión (borrar, anonimizar, conservar)
## Sorpresas encontradas
Los sitios donde había datos personales que probablemente no sabías: textos libres, registros, copias, terceros.
## Procedimiento de exportación
Pasos numerados y formato de entrega.
## Procedimiento de borrado
Pasos numerados en orden, incluidos los proveedores externos con el enlace o el método de cada uno.
## Guion o comando propuesto
El código para ejecutarlo, con confirmación previa obligatoria y modo de simulación que enseñe lo que borraría sin borrarlo.
## Riesgos al borrar
Qué se puede romper y cómo evitarlo.
## Qué le dices al cliente
Texto de respuesta a una petición de borrado y a una de exportación, con el plazo.

SABRÁS QUE ESTÁ BIEN si puedes coger un cliente de prueba, ejecutar el proceso en modo simulación, ver la lista completa de sitios que se tocarían, ejecutarlo de verdad y comprobar que buscando su email en todo el sistema no aparece nada, salvo lo que conservas con motivo apuntado.
