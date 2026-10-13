---
name: disenador-formularios-formsite
description: Diseña formularios y encuestas para Formsite (preguntas, orden, lógica, textos de privacidad y pruebas) y, si hay conexión, resume las respuestas. Úsala cuando necesites recoger solicitudes, inscripciones, presupuestos o encuestas de clientes.
---

# Diseñador de formularios y encuestas para Formsite

Instalación: guarda este archivo como .claude/skills/disenador-formularios-formsite/SKILL.md en tu proyecto. Claude Code la usará cuando le pidas un formulario o una encuesta. Si tu versión lo permite, también puedes lanzarla escribiendo /disenador-formularios-formsite.
Última revisión: octubre de 2026. Los planes y funciones de Formsite cambian. Compruébalos en su web y en tu cuenta.

## Qué hace
- Convierte lo que el usuario quiere saber en un formulario corto: preguntas, orden, lógica y textos.
- Prepara el aviso de privacidad y la casilla legal que hacen falta si se recogen datos personales.
- Deja una guía para montarlo a mano en el editor visual de Formsite, campo a campo.
- Si Formsite está conectado a Claude (por MCP, como los que ofrece Composio, o con n8n), primero comprueba qué acciones permite esa conexión y las enseña. No da por hecho que puede crear formularios. Si solo puede leer respuestas, lo dice.
- Con respuestas ya recogidas, hace un resumen sin datos personales.

## Qué preguntar antes de empezar
Pregunta de una en una y espera la respuesta. No avances con huecos.
1. ¿Para qué es el formulario y qué decisión vas a tomar con las respuestas? (presupuesto, inscripción, cita, encuesta de satisfacción...)
2. ¿Quién lo va a rellenar y desde dónde? Casi siempre es desde el móvil.
3. ¿Qué datos necesitas de verdad? Cada dato pedido necesita un motivo.
4. ¿Vas a pedir algo delicado? Salud, ideología, religión, orientación sexual, datos de menores, DNI o cuenta bancaria. Si es que sí, avisa de que hace falta que lo revise un asesor antes de seguir.
5. ¿Qué debe pasar al enviar? Aviso por correo a ti, confirmación a la persona, copia a una hoja de cálculo...
6. ¿Qué plan de Formsite tienes y qué límites (formularios, respuestas al mes, archivos adjuntos)? [MIRA EN TU CUENTA DE FORMSITE]. No lo supongas.
7. ¿Quién es el responsable de los datos (nombre o razón social, NIF, correo de contacto) y dónde está tu política de privacidad?

## Paso a paso
1. Escribe el objetivo en una frase: «Con este formulario quiero decidir [DECISIÓN]».
2. Haz la lista mínima de preguntas. Para cada una indica: texto, tipo (texto corto, párrafo, desplegable, opción única, casillas, fecha, archivo), si es obligatoria y para qué se usa. Si no se sabe para qué se usará, se quita.
3. Ordena: primero lo fácil. Al final, los datos personales y lo que más cuesta. Si hay varias pantallas, agrupa por temas.
4. Añade lógica solo donde ayude: «si responde X, muestra Y». Pocos saltos, y cada salto se prueba.
5. Escribe los textos: título, introducción de dos frases, mensajes de error claros y mensaje final de agradecimiento. El tiempo de rellenado se calcula contando las preguntas. No lo inventes.
6. Escribe el aviso de privacidad en dos capas. Una versión corta junto al botón (responsable, para qué se usan los datos, derechos y enlace) y el enlace a la política completa.
7. Si el usuario quiere usar los datos para enviar publicidad, eso va en una casilla aparte, sin marcar de antemano.
8. Montaje. Con conexión: di qué puedes hacer y qué no, enseña el plan y espera un «adelante» escrito. Sin conexión: entrega una guía para crear el formulario en el editor visual de Formsite, en el orden de la tabla.
9. Prueba antes de compartir. Tres envíos: uno completo, uno con lo mínimo y uno con un error a propósito. Míralo en el móvil y en el ordenador. Comprueba que llega el aviso por correo y que el mensaje final se ve bien. Borra después las respuestas de prueba.
10. Con respuestas reales: resumen sin nombres ni contactos. Cuántas hay, qué se repite en las respuestas abiertas, tres hallazgos y tres acciones.

## Qué devolver y con qué formato
- Una tabla Markdown con las columnas: nº, pregunta, tipo, obligatoria, para qué se usa, lógica.
- Los textos en bloques separados y listos para pegar: título, introducción, error, final y privacidad.
- Una lista de comprobación de la prueba, con casillas [ ].
- Un último apartado «Pendiente de revisión humana» con lo que no has podido comprobar.

## Qué NO hacer
- No pidas datos «por si acaso». Cada campo de más es un motivo para abandonar y un dato que luego hay que proteger.
- No premarques casillas de consentimiento.
- No recojas datos delicados sin que antes los revise un asesor.
- No escribas preguntas que empujen la respuesta, como «¿Qué te ha encantado de nuestro servicio?».
- No inventes funciones de Formsite. Si no sabes si el plan lo permite, escribe «compruébalo en tu cuenta».
- No pidas números de tarjeta ni claves en campos de texto. Si hay cobro, que lo gestione una pasarela de pago.
- No pegues en el chat listas con nombres, teléfonos o correos. Pide un resumen o una exportación sin datos personales.
- No publiques ni envíes el enlace del formulario a nadie. Eso lo hace el usuario.
- No imites formularios de organismos oficiales ni de bancos.

## Revisión humana antes de usar el resultado
Termina siempre recordando que una persona (el usuario, su gestoría o un asesor de protección de datos) revisa:
- El texto de privacidad y para qué se usarán los datos.
- Qué datos se recogen y si todos hacen falta.
- Dónde guarda los datos Formsite y si ofrece contrato de encargado de tratamiento. Se mira en su documentación.
- Quién accede a las respuestas y cuánto tiempo se guardan.
- Si el formulario es para menores, salud o dinero, el asesor no es opcional.
