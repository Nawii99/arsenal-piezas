---
name: parte-diario-alquiler-booqable
description: Prepara el parte diario de un negocio de alquiler que usa Booqable: salidas, devoluciones, retrasos, choques de reservas y mensajes a clientes en borrador. Úsala cuando pidas el parte del día, comprobar disponibilidad o redactar un aviso a un cliente de alquiler.
---
# Parte diario de reservas y devoluciones en Booqable
## Qué hace
Lee tus reservas y tu stock y te prepara el día: qué sale, qué vuelve, qué va tarde y qué choca. Deja redactados los mensajes a los clientes. No envía ni cambia nada sin tu sí.
No se conecta sola a Booqable. Mira si hay un conector (MCP) o un flujo de n8n con tu cuenta, empezando solo con permiso de lectura. Si no lo hay, exporta las reservas desde el panel (si tu plan lo permite) y pásalas como archivo.
## Pregunta antes de empezar (todo junto)
- Qué alquilas y cuántas unidades hay de cada cosa. Qué piezas van juntas (cámara, batería y tarjeta).
- Margen entre dos alquileres para limpiar o revisar: [HORAS DE MARGEN].
- Horario y lugar de recogida y devolución.
- Tus condiciones: fianza, retrasos, daños y cancelaciones. Pégalas. Si no existen por escrito, las marca como pendientes y no se las inventa.
- Qué conexión hay y con qué permisos.
- Cómo hablas con tus clientes: tuteo o usted, tono y firma.
## Paso a paso
1. Lee las reservas de hoy y de los próximos [DÍAS A VIGILAR] días.
2. Salidas de hoy: quién, qué, hora y qué falta por preparar.
3. Devoluciones de hoy: quién, qué, hora y revisión pendiente.
4. Retrasos: reservas vencidas sin devolver y días de retraso.
5. Choques: un artículo reservado más veces que unidades tienes, o sin el margen entre alquileres.
6. Mantenimiento: piezas con revisión pendiente o con incidencias anotadas.
7. Por cada punto con acción, un mensaje en borrador: confirmación, recordatorio de recogida, recordatorio de devolución, aviso de retraso o agradecimiento.
8. Si te piden fechas, comprueba el stock real con el margen. Si no hay, propone dos alternativas reales: otras fechas o un modelo parecido que sí esté libre.
9. Para cambiar algo en Booqable (crear, mover o cancelar una reserva, marcar devuelto, cambiar un precio), enseña el cambio exacto y espera tu sí. Sin permiso de escritura, te dice qué hacer a mano.
10. Si lo pides, informe semanal: ocupación por producto, ingresos del periodo, productos que casi no salen y retrasos que se repiten.
## Qué devuelve
Un parte con este orden:
- Salen hoy (tabla: hora, cliente, artículos, pendiente).
- Vuelven hoy (misma tabla).
- Retrasos.
- Choques de reservas.
- Acciones por urgencia, cada una con su mensaje en borrador.
- Dudas que solo puedes resolver tú.
Si un dato no se ha podido leer, lo pone como NO COMPROBADO. No lo rellena.
## Qué NO hacer
- No confirmes ni prometas disponibilidad sin comprobar stock y margen.
- No cobres, devuelvas ni retengas fianzas, ni cambies precios. Eso lo hace una persona.
- No envíes mensajes: deja el borrador. Nada de avisos masivos.
- No juzgues si hay daños ni culpes al cliente. Si hay disputa, se guardan fotos y decide una persona. Para reclamaciones, asesor.
- No guardes ni pegues copias de DNI, pasaportes o tarjetas. Pide solo los datos necesarios (RGPD).
- No canceles ni borres reservas, productos o clientes.
- No inventes condiciones de alquiler.
- No pegues claves de acceso en el chat. Van en el conector o en n8n.
- Cómo facturar fianzas, recargos y el IVA de cada alquiler, consúltalo con tu gestor.
## Qué revisa una persona antes de usar el resultado
- El parte entero antes de actuar. Los choques, mirando el calendario real.
- Cada mensaje, antes de enviarlo tú.
- Toda decisión con dinero (fianzas, recargos, reembolsos) y toda duda sobre daños.
- Que las condiciones que usa el parte son las vigentes y están por escrito.
Instalación: guarda este texto como .claude/skills/parte-diario-alquiler-booqable/SKILL.md dentro de tu carpeta de trabajo.
