---
name: odoo-oportunidades-presupuestos-prevision
description: Revisa el CRM y Ventas de Odoo para encontrar oportunidades paradas o incompletas, preparar borradores de presupuesto y estimar ingresos. Úsala cuando pidan revisar el embudo de Odoo, preparar un presupuesto o prever ventas. Solo lectura salvo que se confirme cada cambio.
---
# Odoo: oportunidades, presupuestos y previsión
Qué hace: lee las oportunidades (CRM) y los presupuestos (Ventas) de Odoo, dice cuáles necesitan atención y prepara borradores. No cambia nada en Odoo sin confirmación expresa, cambio por cambio.
Cómo se usa: se activa sola cuando le pides algo de este tema, o la llamas escribiendo /odoo-oportunidades-presupuestos-prevision. Versión de octubre de 2026: los menús de Odoo cambian entre versiones, así que si algo no coincide, pide una captura de pantalla en vez de suponer.
## Cómo accede a los datos (elige una vía)
- Exportación (la más segura): en Odoo abre la lista de oportunidades, marca las filas, entra en el menú de acciones (la rueda) y elige Exportar. Guarda el CSV en la carpeta del proyecto.
- Conector MCP de Odoo, solo si tu equipo ya lo tiene configurado: empieza con un usuario que solo pueda leer. Si no sabes si lo tienes, usa el CSV.
- No pidas contraseñas ni claves de API en el chat. Si hace falta una clave, la crea quien administra Odoo, con permisos mínimos.
## Pregunta antes de empezar
- ¿Qué versión de Odoo usas y es Community o Enterprise? Cambian los menús y los campos disponibles.
- ¿Qué necesitas hoy: revisar el embudo, preparar un presupuesto o estimar ventas?
- ¿Cuántos días sin actividad hacen que una oportunidad esté parada? Si no lo sabe, usa [N] días y anótalo como suposición.
- ¿Quién es el responsable de cada oportunidad y a quién va el informe?
- ¿Los importes de tu Odoo llevan IVA o van sin IVA? Confírmalo, no lo supongas.
## Paso a paso
1. Comprueba que el archivo trae lo necesario: oportunidad, cliente, comercial, etapa, ingreso esperado, probabilidad, fecha de cierre prevista, próxima actividad y fecha de creación. Di qué columnas faltan antes de seguir.
2. Marca como problema cada oportunidad que no tenga próxima actividad, tenga la fecha de cierre ya pasada, no tenga importe, no tenga comercial asignado o lleve más de [N] días en la misma etapa.
3. Para cada problema propón una acción concreta y quién debería hacerla. Ejemplo: llamar al cliente y fijar nueva fecha de cierre, o marcarla como perdida con su motivo.
4. Previsión: calcula dos cifras por separado. La primera es el total sin ponderar (suma del ingreso esperado). La segunda es la ponderada (ingreso esperado por la probabilidad que ya tiene cada etapa en tu Odoo). Usa las probabilidades de la empresa, no las inventes.
5. Si hay pocas oportunidades cerradas con las que comparar, escribe que la previsión es poco fiable. Nunca la presentes como un dato seguro.
6. Presupuestos: si piden uno, parte de los productos y la lista de precios que existan en Odoo. Pregunta lo que falte (cantidades, descuento, plazo de validez, condiciones de pago). Entrega un borrador en texto; no lo crees en Odoo.
7. Haz todas las sumas con un pequeño script o una hoja de cálculo y enseña el resultado. No calcules de cabeza. Al final repite las sumas desde cero y comprueba que cuadran.
8. Si piden aplicar cambios (mover de etapa, crear actividades), muéstralos en una lista con el antes y el después, espera un sí claro y aplícalos en tandas pequeñas.
## Qué devolver
1. Resumen en cinco líneas: oportunidades revisadas, importe total y cuántas tienen problemas.
2. Lista «Necesitan acción esta semana»: nombre, cliente, etapa, importe, días sin actividad, problema y acción propuesta.
3. Previsión sin ponderar y ponderada, con las suposiciones escritas debajo.
4. Datos que faltan o parecen raros: importes en cero, duplicados, fechas imposibles.
5. Cambios propuestos en Odoo, todos marcados como NO APLICADOS.
6. Si pidieron presupuesto: borrador con base, IVA y total en líneas separadas.
## Qué NO hacer
- No confirmes presupuestos: pasar a pedido de venta puede generar entregas y facturas. Tampoco envíes presupuestos por email ni cambies precios o descuentos sin orden expresa.
- No borres oportunidades, contactos ni presupuestos. Si hay duplicados, propón cuáles fusionar y que lo haga una persona.
- No inventes probabilidades, importes, tipos de IVA ni condiciones de pago. Lo que no conste se pregunta o va entre [corchetes].
- No copies datos personales de clientes a otros servicios. Son datos protegidos por el RGPD: usa solo lo necesario para el informe.
- No hagas cambios masivos sin que exista una copia de seguridad de Odoo.
## Quién revisa antes de usar el resultado
- El responsable comercial revisa la lista de acciones y la previsión antes de basar en ella decisiones de dinero (contratar, comprar stock, prometer plazos).
- Tu gestor o administración revisa IVA, descuentos y condiciones de pago de cualquier presupuesto antes de enviarlo.
- Quien administra Odoo aprueba los cambios masivos y confirma que hay copia de seguridad.
