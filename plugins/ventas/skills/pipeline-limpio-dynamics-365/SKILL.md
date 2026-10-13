---
name: pipeline-limpio-dynamics-365
description: Revisa en solo lectura tu pipeline (embudo de ventas) de Dynamics 365 Sales (cuentas, contactos, leads o posibles clientes, y oportunidades) y propone correcciones que tú apruebas. Actívala cuando pidas revisar oportunidades paradas, calidad de datos o preparar una reunión comercial.
---

# Pipeline limpio en Dynamics 365 Ventas

Esta skill revisa tu pipeline (el embudo de ventas: todas las oportunidades y en qué etapa están). Dynamics 365 es un sistema de empresa: lo usa más gente y tiene más permisos y más consecuencias. Por eso esta skill empieza siempre en solo lectura.
Instalación: guarda este archivo como `.claude/skills/pipeline-limpio-dynamics-365/SKILL.md` en tu carpeta de trabajo. Se activa sola cuando lo pides, o la llamas con `/pipeline-limpio-dynamics-365`.

## Antes de empezar, pregunta (una cosa cada vez)
1. ¿Es el entorno de pruebas o el de producción?
2. ¿Con qué usuario y rol accedo? Debe ser uno específico con permisos mínimos de lectura (leads o posibles clientes, contactos, cuentas y oportunidades). Nunca una cuenta de administrador.
3. ¿Cómo accedo? Si tu empresa tiene un conector MCP (una conexión directa entre tu IA, sea Claude, Codex, Gemini o una IA local, y Dynamics o Dataverse, la base de datos interna de Dynamics), ¿lo ha aprobado el departamento de sistemas? Si no, trabajamos con exportaciones.
4. ¿Hay una política interna sobre usar IA con datos de clientes? Si la hay, pídela y respétala.
5. ¿Qué buscas: revisión semanal del pipeline, calidad de datos, preparar una cuenta o un informe para dirección?
6. ¿Cómo se llaman tus etapas, cuántos días sin actividad consideráis «parada» una oportunidad, qué campos son obligatorios y en qué divisa trabajáis?
7. ¿Quién aprueba los cambios?

## Paso a paso
1. Solo lectura. No se escribe nada hasta el paso 6.
2. Pipeline: cuenta oportunidades e importes por etapa y por propietario. Los datos por propietario sirven solo para repartir trabajo. No sumes divisas distintas.
3. Oportunidades en riesgo: sin actividad durante los días que hayas indicado en la pregunta 6 (si no los dices, usa 30 y avisa), fecha de cierre ya pasada, sin siguiente paso, sin contacto que decida, sin importe, o en etapa avanzada sin movimiento.
4. Calidad de datos: duplicados probables, contactos sin email, cuentas sin sector, contactos sin cuenta.
5. Propuesta de correcciones en una tabla: tipo de registro | ID | campo | valor actual | valor propuesto | motivo | confianza.
6. Aplicar solo tras tu OK, en tandas pequeñas y solo en campos simples que existan en tu configuración (por ejemplo notas o fecha del siguiente paso, si la tienes). El usuario de solo lectura no puede escribir: pide aparte un rol con escritura limitada a esos campos, solo tras el OK. Si no lo hay, entrega la tabla para que una persona la aplique a mano. Si se aplica, vuelve a leer después y comprueba.
7. Preparar una reunión: ficha con historial, últimas actividades y preguntas para hacer. Marca claramente lo que no se sabe.
8. Informe para dirección: los números, tres a cinco observaciones y cómo se ha calculado cada cifra.

## Qué devolver y con qué formato
- Resumen del pipeline en una tabla por etapa.
- Lista de oportunidades en riesgo con el motivo.
- Tabla de correcciones propuestas.
- Lista «Decide tú» con duplicados y dudas.
- Informe de dirección en texto corto, con las cifras y su origen.

## Qué NO hacer
- Pedidos, facturas, presupuestos, listas de precios y descuentos son solo lectura. Una factura emitida no se modifica: la corrige una persona con una factura rectificativa.
- No elimines registros.
- No cambies propietarios ni reasignes cuentas.
- No califiques leads (posibles clientes): calificar crea registros nuevos y cierra el lead.
- No fusiones duplicados.
- No lances flujos automáticos ni envíos desde Dynamics.
- No toques importes, probabilidades ni fechas de cierre para que el pipeline se vea mejor. Si los datos parecen inflados, dilo.
- No valores el rendimiento de las personas ni propongas sanciones. Los datos por propietario son solo para repartir trabajo. Cualquier decisión sobre empleados la toma una persona (RGPD, protección de datos, y derecho laboral).
- No uses una cuenta de administrador.
- No saques datos de clientes de los sistemas aprobados por tu empresa.
- No inventes datos de cuentas o contactos.

## Qué revisa una persona antes de usar el resultado
- Cada cambio propuesto, antes de aplicarlo.
- El informe de dirección y de dónde sale cada cifra.
- Que el informe por propietario no se use para evaluar ni sancionar a nadie: cualquier decisión sobre empleados la toma una persona, con apoyo de recursos humanos o de tu asesoría laboral.
- Todo lo relacionado con facturas, pedidos y precios. En España, la facturación electrónica y Verifactu (el sistema de la Agencia Tributaria para registrar las facturas) tienen calendarios que cambian: pregunta a tu gestor.
- Que se cumple la política interna de datos y el RGPD.

## Nota
Los nombres de campos, etapas y menús dependen de cómo esté configurado tu Dynamics. Si algo no coincide con lo que ves, para y pregunta.
