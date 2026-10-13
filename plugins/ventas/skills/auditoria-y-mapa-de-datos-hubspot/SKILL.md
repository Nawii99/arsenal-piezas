---
name: auditoria-y-mapa-de-datos-hubspot
description: Audita la calidad de datos del CRM de HubSpot (contactos, empresas, negocios, tickets), prepara cambios en lote con vista previa o diseña el mapa de campos para sincronizarlo con otra herramienta. Úsala cuando pidan limpiar, revisar o conectar HubSpot. No borra, fusiona ni envía nada.
---
# Auditoría y mapa de datos de HubSpot

## Para ti, que no programas
- Dónde guardarla: en la carpeta de tu proyecto crea la carpeta .claude/skills/auditoria-y-mapa-de-datos-hubspot/ y guarda este texto dentro con el nombre SKILL.md.
- Cómo se usa: escribe «Audita mi HubSpot» o «Hazme el mapa de campos entre HubSpot y [OTRA HERRAMIENTA]».
- Conexión: un conector de HubSpot (servidor MCP) en solo lectura, o una exportación a CSV desde HubSpot (contactos, empresas, negocios). Con el CSV funciona igual, pero los cambios los importas tú.

## Qué hace
Tiene tres modos. A, auditoría de la calidad de los datos. B, cambios en lote con una vista de ANTES y DESPUÉS. C, mapa de sincronización con otra herramienta, que es un documento. Montar el flujo después es otro trabajo.

## Antes de empezar, pregunta (todo en un mensaje)
1. ¿Qué modo: A, B o C?
2. ¿Qué acceso hay: conector en solo lectura o archivos exportados?
3. ¿Qué reglas tiene tu negocio? Qué es un lead, cuándo pasa a cliente, qué etapas tiene el embudo de negocios y quién es dueño de cada tipo de registro.
4. ¿Qué campos son imprescindibles en la práctica?
5. ¿Qué formatos usas? Teléfono con +34, importes en euros, fechas dd/mm/aaaa, provincias.
6. ¿Cuántos registros hay, más o menos? Si son más de [5.000], se trabaja con una muestra o con un export filtrado.
7. ¿Hay datos sensibles o de menores?
8. Solo en el modo C. ¿Con qué herramienta se conecta, qué dato se mueve (clientes, facturas, pedidos, formularios) y en qué sentido?

## Modo A. Auditoría
1. Define la muestra y dilo claramente.
2. Mide y cuenta: contactos sin email, sin propietario y sin empresa asociada. Duplicados por email, por nombre más empresa y por dominio. Negocios abiertos sin actividad en [DÍAS] días. Negocios sin importe o sin fecha de cierre. Negocios con fecha de cierre pasada que siguen abiertos. Tickets sin respuesta. Propiedades personalizadas duplicadas o sin uso.
3. Señala los registros dudosos (emails de prueba, rebotes, contactos de baja). Solo los señalas.
4. Clasifica cada hallazgo por gravedad (afecta a ventas o a dinero, afecta a informes, estético) y por esfuerzo.

## Modo B. Cambios en lote
1. Prepara los cambios en una tabla: ID del registro | Campo | Antes | Después | Motivo. Sin OK no se aplica nada.
2. Antes de aplicar, pide que se guarde un export del estado actual. Es la única copia de seguridad.
3. Aplica 5 registros de prueba. Si salen bien, sigue por lotes de [50] con OK en cada lote.
4. En los duplicados, propón qué registro conservar y por qué, pero NO fusiones. En HubSpot la fusión no suele poder deshacerse, así que la hace una persona.

## Modo C. Mapa de sincronización
1. Haz una tabla: Campo en HubSpot | Campo en la otra herramienta | Dirección (de un lado, del otro o de los dos) | Quién manda si no coinciden | Formato | Qué pasa si viene vacío.
2. Define la clave que identifica a cada persona o empresa (normalmente el email, o un identificador propio) para no crear duplicados al sincronizar.
3. Prevé tres cosas. Las bajas: si alguien se da de baja en un sitio, debe constar en el otro. Los bucles: A cambia B y B cambia A sin parar. Los errores: qué pasa cuando falla un envío.
4. Escribe un plan de prueba con 5 registros reales y qué mirar en cada herramienta.

## Qué devolver
- Un resumen de 5 líneas.
- Una tabla de calidad: Métrica | Cantidad | % | Gravedad | Esfuerzo.
- La tabla de cambios propuestos, si es el modo B.
- El mapa de sincronización, si es el modo C.
- Un apartado «Lo decide una persona» con todo lo que no se puede resolver con los datos.

## Qué NO hacer
- No borres ni fusiones registros. No cambies propietarios, etapas, importes ni fechas sin OK explícito por lote.
- No cambies el estado de suscripción ni el consentimiento de nadie. No vuelvas a suscribir a quien se dio de baja.
- No marques ni desmarques contactos de marketing. En HubSpot el precio del Marketing Hub suele depender del número de contactos de marketing, así que puedes cambiar la factura.
- No actives, edites ni pauses flujos de trabajo ni listas activas que alimenten envíos. Un cambio puede disparar correos a miles de personas.
- No inventes datos para rellenar huecos (emails, empresas, cargos).
- No tomes el importe de los negocios abiertos como ingresos.
- No crees propiedades nuevas sin preguntar.
- No saques datos personales fuera de este trabajo y no pegues claves en el chat.

## Qué revisa una persona antes de usar el resultado
- Ventas valida las reglas del negocio (qué es lead, cliente y etapa) y la tabla de cambios.
- Quien se ocupe de protección de datos valida todo lo que toque consentimiento, bajas y tiempo de conservación.
- Quien paga HubSpot mira cuántos contactos de marketing hay antes y después.
- Si trabajas para un cliente, necesitas contrato de encargado del tratamiento y el acceso mínimo posible.

Última revisión del texto: octubre de 2026. Los nombres de campos y menús de HubSpot cambian con las versiones. Si algo no coincide, dilo y no adivines.
