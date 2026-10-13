---
name: prospeccion-b2b-apollo
description: Prepara y revisa listas de prospección B2B con Apollo (empresas, cargos que deciden y contactos) y las entrega ordenadas, sin enviar mensajes. Se activa cuando el usuario pide buscar clientes empresa, localizar decisores o montar una lista de ventas con Apollo.
---
<!-- Instalación: guarda este archivo como .claude/skills/prospeccion-b2b-apollo/SKILL.md dentro de tu proyecto, o en ~/.claude/skills/prospeccion-b2b-apollo/SKILL.md para usarlo en todos. -->
# Prospección B2B con Apollo
## Qué hace
Te ayuda a montar una lista de empresas y de personas que deciden la compra, usando la cuenta de Apollo del usuario. Prepara la lista y la revisa. No envía mensajes, no llama y no escribe a nadie.
## Qué necesita
- Una cuenta de Apollo del usuario. Los límites y los créditos dependen de su plan: [CRÉDITOS DE TU PLAN]. Algunas acciones, como ver o exportar emails y teléfonos, pueden gastar créditos. Que lo compruebe en su cuenta.
- Apollo conectado a Claude Code por MCP. Escribe /mcp para ver qué hay conectado. Si no aparece Apollo, no inventes herramientas: pide al usuario que exporte un CSV desde Apollo y trabaja con ese archivo.
## Antes de empezar, pregunta
1. ¿Qué vendes y a quién? Una frase.
2. ¿Qué empresas buscas? Sector, país o provincia, tamaño aproximado por empleados y, si importa, [FACTURACIÓN].
3. ¿Qué cargos deciden o influyen en la compra? ¿Y cuáles NO quieres?
4. ¿Cuántos contactos como máximo? Propón empezar por una lista pequeña de prueba, por ejemplo 20.
5. ¿Cuántos créditos estás dispuesto a gastar? Avisa de que las búsquedas grandes pueden agotarlos.
6. ¿Cómo piensas contactar: correo, teléfono, LinkedIn, carta, en persona? Cambia las reglas legales, mira el apartado de abajo.
## Paso a paso
1. Resume los criterios en una ficha de 6 líneas y pide confirmación antes de buscar nada.
2. Busca primero empresas, no personas. Di cuántas salen. Si salen miles, propón afinar los criterios en vez de seguir.
3. Enseña 5 empresas de ejemplo y pregunta si encajan. Ajusta y repite.
4. Busca los cargos acordados dentro de esas empresas. Máximo [CONTACTOS POR EMPRESA] por empresa.
5. Antes de gastar créditos en emails o teléfonos, di cuántos calculas gastar y espera un sí claro.
6. Revisa la lista: duplicados, empresas que ya son clientes del usuario, competidores, cargos que no encajan y campos vacíos. Apunta el estado del email que indique Apollo (verificado o no) sin darlo por bueno.
7. Ordena por encaje usando solo criterios que el usuario haya aprobado (sector, tamaño, cargo). Explica el motivo en una frase por fila. No inventes puntuaciones.
8. Entrega la tabla y el resumen. Guarda un CSV solo si el usuario lo pide, con nombre prospectos-[FECHA].csv y en la carpeta que él diga.
## Qué devolver
Una tabla con estas columnas: Empresa | Web | Sector | País o provincia | Empleados (rango) | Persona | Cargo | Estado del email según Apollo | Por qué encaja | Fuente (Apollo) y fecha.
Debajo, un resumen corto: cuántas empresas, cuántos contactos, créditos gastados si la herramienta lo muestra, y las dudas que quedan. Recuerda que los datos de Apollo pueden estar desactualizados: recomienda mirar a mano la web de la empresa antes de contactar con los más importantes.
## Qué NO hacer
- No envíes ni programes correos, mensajes o llamadas. Esta skill termina en la lista.
- No automatices mensajes en LinkedIn ni uses herramientas que lo hagan: va contra sus normas y pueden restringir o cerrar la cuenta del usuario.
- No gastes créditos sin avisar antes.
- No inventes contactos, emails, cargos ni teléfonos. Si Apollo no lo devuelve, deja el campo vacío.
- No des por bueno un email sin verificar. Enviar a direcciones que rebotan daña la reputación del dominio desde el que escribes.
- No recojas datos que no necesites (domicilio personal, redes personales, edad). Solo datos profesionales.
- No subas la lista a ningún servicio que el usuario no haya elegido ni la dejes en carpetas compartidas.
- No te saltes los límites de Apollo ni rastrees webs por tu cuenta para completar datos.
## Límites legales en España (léelos antes de contactar a nadie)
- Un nombre y un cargo, aunque sean profesionales, son datos personales (RGPD y LOPDGDD). La prospección B2B suele apoyarse en el interés legítimo, pero hay que decir al primer contacto de dónde has sacado los datos y atender cualquier baja al momento. Fija un plazo para borrar la lista: [PLAZO DE CONSERVACIÓN].
- Correo comercial en frío: la LSSI prohíbe en general enviar publicidad por correo electrónico sin consentimiento previo, salvo a clientes actuales con productos parecidos. Según la lectura más habitual, no hace excepción para empresas. Consúltalo con [TU ASESOR] antes de enviar.
- Llamadas comerciales: comprueba antes las listas de exclusión publicitaria (por ejemplo, Lista Robinson) y las normas de telecomunicaciones vigentes.
- Si haces esto para otra empresa, eres encargado del tratamiento y necesitáis un contrato (art. 28 del RGPD). Que lo prepare [UN ABOGADO].
- Revisa las condiciones de uso de Apollo sobre qué puedes hacer con los datos exportados.
## Cuándo pedir ayuda a una persona
- Si el cliente quiere comprar listas para envíos masivos o contactar a gente fuera de España.
- Si el sector es regulado (salud, finanzas, abogacía) o si las listas incluyen autónomos con datos personales.
- Si Apollo devuelve un error o resultados raros dos veces seguidas: para y avisa, no insistas gastando créditos.
