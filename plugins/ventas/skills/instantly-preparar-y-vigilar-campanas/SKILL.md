---
name: instantly-preparar-y-vigilar-campanas
description: Prepara una campaña de email en frío en Instantly con volumen prudente, revisa la lista y los textos, y repasa rebotes, bajas y respuestas cada vez que se lo pidas. Úsala antes de lanzar y durante la campaña. Nunca pulsa lanzar ni sube el volumen por su cuenta.
---

# Preparar y vigilar campañas de email en frío en Instantly

Esta skill no busca esquivar filtros de spam. Busca que no mandes lo que no debes y que lo que mandes llegue de forma normal, a gente a la que tienes derecho a escribir.

## Esta skill no vigila sola
- La IA (Claude, Codex, Gemini o una IA local) solo revisa cuando se lo pides o cuando programas la revisión. Entre una revisión y otra, nadie mira la campaña.
- Pide la revisión cada día durante la primera semana y después cada semana.
- Activa en Instantly las pausas automáticas por rebotes si existen [COMPRUEBA EN LA AYUDA DE INSTANTLY SI TU PLAN LAS TIENE].

## Riesgos, dichos claros
- Legal. En España, los correos comerciales no solicitados pueden chocar con la LSSI (artículo 21). Las sanciones pueden ser serias. Si el email identifica a una persona, entra también el RGPD. Que lo revise un abogado antes de lanzar.
- Tu correo. Si el dominio se quema, tu correo normal deja de llegar. Usa un dominio secundario, nunca el de tu web ni el de tu correo de siempre.
- Tus cuentas. El calentamiento de buzones usa envíos automáticos. Google, Microsoft o Instantly pueden suspender buzones o cuentas por spam o por incumplir sus normas de uso [COMPRUEBA SUS CONDICIONES ACTUALES]. No uses ninguna cuenta que necesites para trabajar.
- Reglas de Gmail y Yahoo. A quien envía mucho le exigen SPF, DKIM, DMARC y baja fácil, y vigilan las quejas por spam. Google pide mantener las quejas por spam por debajo del 0,1 % y no llegar al 0,3 % [COMPRUEBA LAS CIFRAS ACTUALES EN LA AYUDA PARA REMITENTES DE GOOGLE]. Se miran en Google Postmaster Tools, una herramienta de Google para ver tu reputación de envío. Instantly no las da [COMPRUÉBALO EN SU AYUDA].
- Dinero. La herramienta, los dominios y los buzones se pagan [COSTE ACTUAL]. Cada proveedor de correo tiene límites diarios de envío [LÍMITE DE TU PROVEEDOR]. No los superes.

## Valores de partida (orientativos, a comprobar en la ayuda de Instantly)
- Límite diario por buzón: empieza con pocos envíos, por ejemplo entre 10 y 20 al día. Sube despacio y solo si el usuario lo decide. No superes nunca el límite de tu proveedor.
- Umbral de rebotes: propón pausar si los rebotes pasan de entre un 2 % y un 3 % en un mismo envío. Empieza por el 2 %.
- Días de calentamiento: los que recomiende Instantly para tus buzones. No lances antes de que acaben.
- Estos valores se escriben en la ficha de campaña y el usuario los confirma o los cambia antes de lanzar. Son una referencia, no una regla.

## Lo que haces tú, una sola vez
- Guarda este texto en `.claude/skills/instantly-preparar-y-vigilar-campanas/SKILL.md`.
- Conecta Instantly con un conector MCP (un enlace que deja a la IA usar tu cuenta) o con su acceso por clave y mira con `/mcp` que aparece. Comprueba qué permite hoy. Si no puede crear campañas, la skill te dará los textos y los ajustes para ponerlos a mano.
- Pide a quien gestione tu dominio que configure SPF, DKIM y DMARC (tres comprobaciones técnicas del correo). Usa el calentamiento de buzones de Instantly y respeta los días que recomiende.

## Qué preguntar antes de empezar
1. ¿Qué ofreces y a quién?
2. ¿De dónde sale la lista y con qué base legal se escribe a esas personas? Si no sabe responder, para aquí.
3. ¿Cuántos contactos hay y están verificados?
4. ¿El dominio y los buzones son secundarios? ¿Están configurados SPF, DKIM y DMARC?
5. ¿Quién firma los correos (nombre y empresa)? Debe saberse quién escribe.
6. ¿Quién aprueba y pulsa lanzar?
7. ¿Aceptas los valores de partida de arriba (límite diario, umbral de rebotes y calentamiento) o prefieres otros? [VALORES QUE ELIJAS]

## Paso a paso
1. Comprueba la conexión. Si no hay herramientas de Instantly, trabaja solo con textos y ajustes escritos. No simules que has hecho cambios.
2. Revisa la lista: duplicados, direcciones sin verificar, direcciones genéricas, personas que ya son clientes y personas que dijeron que no. Quítalas y cuenta cuántas.
3. Escribe una secuencia de tres correos como máximo. Cortos. Cada uno dice quién eres, por qué escribes a esa persona (solo con datos reales), una propuesta y cómo decir que no. Sin adjuntos, sin enlaces acortados, sin promesas.
4. Prepara la campaña en Instantly sin activarla: lista, secuencia, buzones, horario y un límite diario bajo (el valor de partida de arriba, confirmado por el usuario).
5. Haz una prueba: un correo a una dirección del usuario para ver cómo llega y dónde cae.
6. Rellena la lista de comprobación de abajo. Cada casilla que falle, avísala.
7. Para y espera. La skill nunca pulsa lanzar. Lo hace el usuario.
8. Con la campaña en marcha, cuando el usuario pida la revisión (cada día la primera semana y luego cada semana), mira enviados, entregados, rebotes, respuestas y bajas. Las quejas por spam pídeselas al usuario desde Google Postmaster Tools. Compara con el umbral. Si se pasa, recomienda pausar y no sigas enviando.
9. Clasifica las respuestas: interesado, no ahora, no o baja, fuera de oficina, rebote. Las bajas se aplican ya y esa persona pasa a la lista de exclusión.
10. Para las respuestas con interés, redacta un borrador de contestación. No lo envíes.

## Qué devolver
1. Ficha de campaña: objetivo, nº de contactos, qué se quitó y por qué, buzones, límite diario, umbral de rebotes y días de calentamiento (confirmados por el usuario).
2. La secuencia completa.
3. Lista de comprobación antes de lanzar, con [ ] y [x]: base legal, lista limpia, dominio secundario, SPF, DKIM y DMARC, baja fácil, identificación del remitente, límite diario, prueba hecha.
4. Informe de revisión en tabla: Fecha o semana | Enviados | Rebotes | Respuestas | Bajas | Quejas | Recomendación.
5. Borradores de respuesta.

## Qué NO hacer
- No lances, reactives ni subas el volumen por tu cuenta.
- No uses el dominio principal ni un buzón personal.
- No uses listas compradas, raspadas o sin base legal.
- No ocultes quién escribe ni uses asuntos engañosos (un «Re:» falso, «factura pendiente»).
- No inventes datos de personalización.
- No sigas escribiendo a quien dijo que no o se dio de baja.
- No cambies de dominio ni de buzones para saltarte bloqueos o quejas. Si te bloquean, paras y entiendes por qué.
- No digas que estás vigilando la campaña si nadie ha pedido la revisión.
- No prometas resultados.

## Cuándo parar y llamar a una persona
- Antes del primer envío.
- Queja formal, requerimiento de la AEPD o reclamación de alguien.
- Rebotes o quejas que se disparan.
- Aviso de suspensión de un buzón o de una cuenta.
- Sectores con normas propias (salud, finanzas) o destinatarios menores de edad.
- Cualquier respuesta con interés real. Esa conversación la lleva una persona.

## Qué revisa una persona antes de usar el resultado
- El usuario o su asesor revisa la base legal y los textos.
- Quien gestiona el dominio confirma la configuración técnica.
- El usuario confirma los valores de partida y activa las pausas automáticas si existen.
- Si la campaña es para un cliente, la base legal y la revisión del abogado quedan por escrito antes de lanzar, y hay contrato de encargado del tratamiento si tratas sus datos.
- El usuario lee cada respuesta antes de enviarla.
