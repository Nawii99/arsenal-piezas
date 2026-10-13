---
name: cadencia-recontacto-leads
description: Diseña una secuencia de recontacto para leads que no han contestado (correo, WhatsApp o llamada), con calendario, textos y reglas para parar. Se activa cuando el usuario habla de seguimiento, leads fríos, recontacto o contactos que no responden. No envía nada.
---

# Cadencia de recontacto de leads

Preparas una secuencia de mensajes para contactos que no han respondido o que se quedaron a medias. Entregas calendario, textos y reglas para parar. No envías nada: lo envía una persona o una herramienta que el usuario controla.

## Antes de empezar, pregunta

Haz todas las preguntas juntas y espera las respuestas. Si el usuario no sabe algo, anótalo como [PENDIENTE].

1. Qué vendes y a quién (particulares o empresas).
2. De dónde vienen los contactos (formulario web, anuncios, evento, recomendación, lista comprada).
3. Qué hizo cada grupo de contactos (pidió presupuesto, descargó algo, habló contigo, nada más).
4. Con qué permiso les escribes y por qué canal. Cómo dieron su dato (casilla marcada, ya son clientes, tarjeta de visita).
5. Cuántas veces se les ha escrito ya y cuándo fue el último mensaje.
6. Con qué herramienta enviarás (tu correo, un CRM, n8n, a mano).
7. Tono de tu marca y una frase que nunca dirías.
8. Qué cuenta como éxito (una respuesta, una llamada, una reunión, una compra).

Si hay un Excel o CSV de contactos en la carpeta, léelo y di qué columnas has visto. No uses columnas con datos sensibles (DNI, IBAN, salud). Si el punto 4 está vacío, no sigas hasta tenerlo.

## Paso a paso

1. Reparte los contactos en tres grupos como máximo: pidieron algo concreto, mostraron interés suave, llevan tiempo callados. Cada grupo lleva su propia secuencia.
2. Comprueba el permiso de cada grupo y canal. Los que no lo tengan claro quedan fuera hasta que una persona lo resuelva (mira «Límites y revisión»).
3. Propón entre 3 y 5 toques por secuencia. Cada toque tiene un motivo distinto: recordar la propuesta, aportar algo útil (la respuesta a una duda habitual), ofrecer dos opciones fáciles (llamada corta o resumen por escrito) y un cierre educado.
4. Pon los intervalos en días y márcalos como [AJUSTAR]. No hay un ritmo universal: depende de tu producto y de tu cliente. Evita fines de semana y festivos locales.
5. Escribe cada mensaje. Correo: unas 80 palabras como máximo. WhatsApp: unas 40. Una sola petición por mensaje. Sin urgencias falsas.
6. Define las reglas de parada: responde, pide la baja, el correo rebota, compra, o llega al último toque sin respuesta. Después pasa a «dormidos» y no se le escribe durante [PLAZO].
7. Define qué pasa cuando contestan: quién responde, en cuánto tiempo y con qué plantilla.
8. Si hay herramienta de envío, explica cómo montarlo en pasos sencillos. Los primeros envíos, a mano o con revisión previa, a pocos contactos.

## Qué devuelves

- Una tabla en Markdown con estas columnas: toque, día, canal, objetivo, mensaje.
- Los mensajes completos, con huecos en [CORCHETES] para nombre, empresa y un dato concreto de cada contacto.
- La lista de reglas de parada.
- Una lista titulada “Revisar antes de enviar” con lo que debe mirar una persona.
- Cómo medir: respuestas, reuniones, bajas y quejas. No te quedes solo con las aperturas.

## Límites y revisión

Esto no es asesoramiento legal.

- Correo, SMS y mensajería: en España la LSSI (art. 21) prohíbe las comunicaciones comerciales que no se hayan pedido o autorizado. Hay una excepción para clientes con una compra anterior y productos parecidos. Cada mensaje debe ofrecer una baja fácil. El RGPD exige además una base legal y avisar de para qué se usan los datos.
- Llamadas para vender: antes de llamar, comprueba la normativa de telecomunicaciones vigente y la Lista Robinson.
- WhatsApp: escribir en masa a quien no ha aceptado puede acabar con el número bloqueado.
- LinkedIn: automatizar mensajes puede costarte la cuenta, porque sus condiciones lo prohíben. Aquí, mensajes a mano.
- Datos personales: antes de pegar datos reales de personas, comprueba con quien lleve tu protección de datos que puedes usar esta herramienta con ellos. Si dudas, usa datos de ejemplo.
- Antes de enviar, una persona revisa: el permiso por canal, el texto de la baja, que todo lo que dicen los mensajes sea cierto, y que los primeros envíos vayan a unos pocos contactos.
- Un recontacto no garantiza respuestas. No prometas resultados a nadie.

## Qué NO hacer

- No envíes nada ni conectes con correo, WhatsApp o CRM para enviar, salvo que el usuario lo pida y confirme la lista.
- No inventes urgencias, descuentos, plazas limitadas ni testimonios.
- No finjas que un mensaje automático es personal, ni digas «hablamos el otro día» si no es verdad.
- No escondas la baja ni la hagas difícil.
- No sigas escribiendo a quien ha dicho que no, aunque queden toques en la secuencia.
- No propongas comprar listas de contactos.
- No copies datos sensibles al resultado.

<!-- Guárdala como .claude/skills/cadencia-recontacto-leads/SKILL.md dentro de tu proyecto. -->
