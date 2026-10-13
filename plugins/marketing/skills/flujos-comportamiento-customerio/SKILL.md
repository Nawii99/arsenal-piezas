---
name: flujos-comportamiento-customerio
description: Diseña y prepara en Customer.io mensajes automáticos según el comportamiento de cada persona y los deja en borrador con una lista de comprobación. Actívala cuando pidas segmentos, secuencias o revisar una campaña antes de lanzarla.
---

# Flujos por comportamiento en Customer.io

Un email enviado no se puede recoger. Por eso esta skill prepara, prueba y revisa. Lanzar lo hace siempre una persona.
Instalación: guarda este archivo como `.claude/skills/flujos-comportamiento-customerio/SKILL.md` en tu carpeta de trabajo. Se activa sola cuando lo pides, o la llamas con `/flujos-comportamiento-customerio`.

## Antes de empezar, pregunta (una cosa cada vez)
1. ¿Cuál es el objetivo, en una frase, y qué cifra lo mide (compra, activación, renovación)?
2. ¿Quién entra en el flujo? Qué hace o no hace la persona y en qué plazo. Ejemplo: se registró hace tres días y no ha completado su perfil.
3. ¿Qué datos recibe Customer.io? Pide la lista de eventos (lo que hace la persona: registrarse, comprar) y atributos (lo que sabemos de ella: nombre, plan). Si un dato no existe, no lo uses. No pegues listas ni exportaciones de contactos reales si tu empresa no ha aprobado usar IA con ellos: usa datos de ejemplo.
4. ¿Con qué base legal escribes a esa gente? Consentimiento, o clientes actuales con un producto parecido. ¿El mensaje es de servicio (pedido, recibo) o promocional?
5. ¿Solo email, o también SMS o notificaciones push (avisos en el móvil)? El SMS comercial suele exigir consentimiento previo y normalmente se paga por envío: confirma la norma con tu asesor y el coste con tu plan.
6. ¿Cuánta gente tendrá el segmento (el grupo de personas que entra en el flujo), más o menos? ¿Cuántos mensajes como máximo por persona y semana?
7. ¿Cuántas horas como mínimo deben pasar entre dos mensajes a la misma persona y cuántos días esperamos antes de medir los resultados? Si la persona no lo sabe, propón 24 horas y 7 días, y avísale de que son valores por defecto, no una recomendación para su caso.
8. ¿Cómo accedo? Con el conector (una conexión directa entre tu IA, sea Claude, Codex, Gemini o una IA local, y Customer.io) o la API (la vía técnica por la que los programas hablan entre sí) que tenga tu equipo, o con exportaciones. Pide que solo pueda crear borradores. Si no es posible limitarlo así, o no crea borradores, entrega el mapa y los textos para que una persona los monte en Customer.io. Nunca uses una conexión que pueda enviar.
9. ¿El dominio (la parte de tu email que va después de la @) desde el que envías tiene configurados SPF, DKIM y DMARC (ajustes técnicos que hacen que tus emails no caigan en spam; pregunta a quien gestione tu dominio)?

## Paso a paso
1. Dibuja el flujo en texto: ENTRA, ESPERA, ¿cumple la condición?, MENSAJE, SALE. Incluye siempre la condición de salida (si ya compró, deja de recibir).
2. Define el segmento primero con palabras y luego con las reglas del programa. Estima su tamaño antes de enviar. Si es muy distinto de lo que esperabas, para y avisa.
3. Escribe cada mensaje: dos opciones de asunto, texto de vista previa, cuerpo corto, un solo botón y pie con enlace de baja. Las variables (huecos que se rellenan solos, como el nombre) llevan valor por defecto (si falta el nombre: «Hola»).
4. Protecciones: excluye a quien se ha dado de baja y a quien recibió otro mensaje hace menos de 24 horas (o las horas acordadas en la pregunta 7). Fija horarios razonables y un tope de frecuencia.
5. Lista de comprobación previa: base legal, segmento, textos, enlaces, baja, remitente y dominio.
6. Prueba: envío de prueba a direcciones internas. Comprueba variables, enlaces, baja y cómo se ve en el móvil. Prueba con perfiles ficticios: con y sin nombre, que ya compró, que se dio de baja.
7. Lanzamiento: la campaña queda en borrador. Una persona pulsa el botón. Si el programa lo permite, empieza con una parte pequeña del público.
8. Medición: espera al menos 7 días (o los días acordados en la pregunta 7), y más si el ciclo de compra es largo. Las aperturas no son fiables (Apple Mail Privacy Protection las infla). Mira clics, conversiones, bajas y quejas. Con pocas personas no se puede concluir nada.
9. Si usas n8n (una herramienta para encadenar tareas automáticas, solo si ya la usas) para conectar cosas, que el flujo termine en «guardar borrador» o «esperar aprobación», nunca en «enviar».

## Qué devolver y con qué formato
- El mapa del flujo en tabla: paso | condición | espera | canal | objetivo.
- Los textos de cada mensaje, en bloques para copiar.
- La lista de comprobación previa, con casillas.
- El plan de prueba y el plan de medición.

## Qué NO hacer
- No lances ni programes un envío real. Deja todo en borrador.
- No importes listas compradas ni sacadas de internet.
- No pegues en el chat listas ni exportaciones de contactos reales si tu empresa no ha aprobado usar IA con ellos.
- No segmentes con datos sensibles (salud, religión, ideología, orientación sexual).
- No mandes promociones a quien no consintió. No disfraces una promoción de mensaje de servicio para saltarte la baja.
- No ocultes el enlace de baja ni lo hagas difícil de encontrar.
- No modifiques una campaña que ya está activa sin avisar y sin OK.
- No uses urgencia falsa ni prometas un porcentaje de mejora.
- No inventes resultados ni compares con cifras que no tengas.

## Qué revisa una persona antes de usar el resultado
- La base legal y el consentimiento (RGPD, protección de datos, y LSSI, comunicaciones comerciales por internet). Pregunta a tu asesor o a quien lleve la protección de datos.
- Los datos personales: Customer.io trata los datos como encargado, así que hace falta un contrato de encargado de tratamiento y mirar dónde se alojan los datos.
- El tamaño real del segmento.
- Los textos, sobre todo cualquier afirmación sobre precios, plazos o resultados.
- La entregabilidad (que tus emails lleguen a la bandeja de entrada): Google y Yahoo exigen a los remitentes de volumen autenticación, baja sencilla y pocas quejas. Comprueba los requisitos vigentes antes de enviar.

## Nota
Los menús y nombres de Customer.io cambian con el tiempo. Si algo no coincide con lo que ves, para y pregunta.
