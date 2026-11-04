---
name: formulario-por-pasos-feathery
description: Diseña un formulario por pasos para Feathery (qué pantallas, qué preguntas, textos, lógica, consentimiento RGPD y pruebas). Úsala cuando necesites recoger datos de clientes o leads sin que el formulario espante a nadie.
---

# Formulario por pasos para Feathery

## Qué hace
Te lleva de «necesito recoger datos de mis clientes» a un formulario por pasos terminado. Define qué pantallas hay, qué se pregunta y en qué orden, con qué texto, adónde van las respuestas y cómo se prueba.
Feathery es un editor sin código de formularios por pasos, con lógica y conexión a otras herramientas [comprueba qué incluye tu plan: envíos, integraciones y API]. Si Feathery está conectado y permite crear formularios, lo monta como borrador. Si no, te da un plano para montarlo tú en su editor.

## Dónde se guarda y cómo se usa
- Guarda este texto como `SKILL.md` en `.claude/skills/formulario-por-pasos-feathery/` dentro de tu proyecto.
- Para usarla escribe, por ejemplo: «Usa la skill formulario-por-pasos-feathery para un formulario de presupuesto de reformas».

## Pregunta antes de empezar
1. ¿Para qué es el formulario? (pedir presupuesto, reservar, cualificar un lead, alta de cliente, encuesta)
2. ¿Quién lo rellena y desde dónde? Si es sobre todo desde el móvil, pantallas con pocas preguntas.
3. ¿Qué vas a hacer con cada dato? Si no sabes para qué sirve un dato, no se pide.
4. ¿Adónde tienen que llegar las respuestas? (email, hoja de cálculo, CRM, n8n)
5. ¿Hay datos sensibles? (salud, DNI, IBAN, menores). Si los hay, para y consulta antes con un profesional.
6. ¿Quién es el responsable del tratamiento, tú o tu cliente, y cuál es la dirección de la política de privacidad? [URL DE LA POLÍTICA DE PRIVACIDAD]

## Paso a paso
1. Resume el objetivo en una frase y la acción que debe ocurrir al terminar.
2. Haz la lista de datos mínimos. Para cada uno: para qué sirve y si es obligatorio. Quita lo que no tenga un uso claro.
3. Agrupa en pasos. Una idea por pantalla, de 1 a 3 preguntas por pantalla, lo fácil primero y lo más personal (email, teléfono) al final.
4. Escribe el texto de cada pantalla: título, pregunta, ayuda de una línea, texto del botón y mensajes de error en lenguaje normal.
5. Define la lógica en una tabla «si respondo X, entonces veo Y».
6. Escribe la pantalla final: qué ha pasado, qué pasa ahora y el plazo real de respuesta. [PLAZO]
7. Añade el consentimiento: casilla sin marcar, enlace a la política y texto informativo (modelo más abajo).
8. Indica a qué campo del destino va cada respuesta.
9. Si hay conexión y permiso, créalo en Feathery como borrador sin publicar. Si no, entrega el plano.
10. Plan de pruebas con datos ficticios: un camino completo, uno con errores, uno desde el móvil, uno con el email mal escrito y uno sin marcar la casilla. Comprueba que cada envío llega bien al destino.

## Texto informativo de partida (adáptalo con tu gestor o abogado)
Responsable: [NOMBRE Y NIF]. Finalidad: [PARA QUÉ USAS LOS DATOS]. Base legal: [CONSENTIMIENTO O CONTRATO]. Destinatarios: [QUIÉN LOS RECIBE, INCLUIDA LA HERRAMIENTA DE FORMULARIOS]. Derechos: acceso, rectificación, supresión y otros, escribiendo a [EMAIL]. Más información: [URL DE LA POLÍTICA].

## Qué devolver y con qué formato
Un documento en Markdown con estas partes, en este orden:
1. Objetivo en una frase.
2. Tabla de campos: campo, para qué sirve, obligatorio, destino.
3. Pantallas con sus textos.
4. Tabla de lógica.
5. Texto de consentimiento.
6. Plan de pruebas con una casilla de resultado por prueba.
7. Lista de dudas para mí.

## Qué revisa una persona antes de publicar
- Tú, tu gestor o un abogado leéis el texto legal y la política de privacidad. El modelo de arriba es un punto de partida, no un texto definitivo.
- Comprueba con la herramienta dónde se guardan los datos, qué garantías ofrece si salen de la Unión Europea y si tiene contrato de encargado del tratamiento.
- Rellena tú el formulario en tu móvil y mira que llega a su destino.

## Qué NO hacer
- No publiques el formulario. Déjalo como borrador.
- No pidas datos «por si acaso».
- No pongas la casilla marcada de antemano. Y no mezcles aceptar la política con aceptar recibir publicidad: son dos consentimientos distintos.
- No pidas datos de salud, DNI, IBAN o de menores sin consultar antes.
- No presentes el texto legal como definitivo.
- No inventes funciones de Feathery. Si no sabes si existe, escribe «compruébalo en el editor».
- No uses datos reales en las pruebas.
- No prometas cuánto subirá la conversión. Se mide con tus envíos reales.
