---
name: auditoria-campanas-duplicadas-paradas
description: Audita campañas de email o de anuncios acumuladas, detecta duplicadas, paradas o que gastan sin dar resultados, y propone qué mantener, pausar o archivar. Úsala al hacer limpieza de cuentas o antes de revisar presupuestos. No borra nada ni toca presupuestos.
---

# Auditoría de campañas: duplicadas, paradas y sin dueño

## Qué hace
Junta las campañas de una o varias cuentas en una sola tabla, encuentra las que sobran o se han quedado colgadas y propone una acción para cada una. Es una auditoría: propone, no ejecuta por su cuenta. «Limpiar» aquí significa pausar o archivar, nunca borrar.
Dónde guardarla: en .claude/skills/auditoria-campanas-duplicadas-paradas/SKILL.md dentro de tu proyecto, o en ~/.claude/skills/ para todos. Si no sabes hacerlo, pídele a Claude que la guarde por ti.

## Cómo se conecta
- Exportar de cada plataforma (Google Ads, Meta Ads, Brevo, Mailchimp u otra) un CSV con nombre, estado, fecha de creación, último envío o última impresión, gasto y resultados. Dejar los CSV en la carpeta del proyecto.
- Si hay un conector MCP de la plataforma (/mcp muestra los instalados), usarlo solo en lectura. La escritura se deja para el último paso y con permiso.
- Las claves de acceso nunca van en el chat.

## Pregunta antes de empezar
1. ¿Qué plataformas y qué cuentas? ¿Son tuyas o de clientes? Si son de clientes, ¿hay permiso escrito para tocarlas?
2. ¿Desde cuándo cuenta una campaña como inactiva? Propón [90 días] y deja que la persona lo cambie.
3. ¿Hay campañas estacionales (rebajas, Navidad, vuelta al cole) o de marca que deban quedarse aunque estén paradas?
4. ¿Hay campañas que deban conservarse por contrato, por informes a clientes o por auditorías?
5. ¿Existe una norma de nombres? Si no, se propone una.
6. ¿Quién decide sobre el presupuesto? Esa persona aprueba las acciones.

## Paso a paso
1. Carga todos los CSV y di cuántas filas has leído de cuántas hay. Junta todo en una tabla: plataforma, cuenta, id, nombre, estado, creada, última actividad, gasto de 30 y de 90 días, resultados.
2. Primero el dinero: lista las campañas activas con gasto y cero resultados en el periodo. Son las más urgentes. Usa solo cifras de los datos; si falta una, «sin dato».
3. Inactivas: sin envíos ni impresiones en el periodo, borradores antiguos y programadas con fecha ya pasada.
4. Duplicadas: nombres casi iguales (copia, copy, v2, final, final2) o mismo público, misma oferta y mismas fechas. Antes de darlas por duplicadas, descarta pruebas A/B hechas a propósito y campañas separadas por país o idioma.
5. Asigna una acción a cada campaña: MANTENER, PAUSAR, ARCHIVAR o REVISAR CON PERSONA. Si dudas, REVISAR CON PERSONA. La acción BORRAR no existe.
6. Propón una norma de nombres del estilo plataforma_cliente_objetivo_fecha_versión. Solo como propuesta.
7. Con un «sí» escrito, y solo si hay conector con escritura: pausa o archiva en lotes de [10] como máximo y, tras cada lote, lee el estado para comprobarlo. Apunta cada cambio en un registro: id, estado anterior, estado nuevo y fecha. Con él se puede deshacer.
8. Aviso: reactivar una campaña de anuncios que lleva tiempo pausada puede hacer que la plataforma tenga que volver a aprender y rinda distinto al principio. Anota el motivo de cada pausa.

## Qué devolver
- Resumen: campañas revisadas, número por acción propuesta y gasto de los últimos 30 días de las campañas sin resultado, sumado a partir de los datos.
- Tabla completa, con las que gastan dinero arriba.
- Duplicadas agrupadas, con la razón de cada grupo.
- Lista «a revisar con persona», con la pregunta concreta que hay que contestar.
- Registro para deshacer, si se ejecutó algo.
- Propuesta de norma de nombres.

## Qué NO hacer
- No borres campañas, listas, audiencias ni plantillas. Pausar o archivar, como mucho, y con permiso.
- No toques presupuestos, pujas, audiencias ni fechas.
- No pauses una campaña que esté gastando sin avisar antes a quien responde del presupuesto.
- No des por inútil una campaña solo porque no tenga ventas directas: las de marca, notoriedad o temporada pueden servir.
- No mezcles cuentas de clientes distintos en una misma tabla que luego vaya a otro cliente.
- No toques cuentas ajenas sin permiso escrito.
- No estimes ahorros con cifras de internet. Solo gasto real de los datos.

## Qué revisa una persona antes de usar el resultado
- Quien responde del presupuesto aprueba cada pausa o archivo, sobre todo en campañas con gasto activo.
- Que ninguna campaña marcada para archivar es necesaria por contrato, por un informe pendiente o por una campaña de temporada próxima.
- Que los duplicados lo son de verdad.
- Si hay listas de personas suscritas implicadas, que no se pierde el registro de bajas: perderlo permitiría volver a escribir a quien pidió que no.

Normas y límites revisados en octubre de 2026. Comprueba que siguen vigentes antes de contar con ellos.
