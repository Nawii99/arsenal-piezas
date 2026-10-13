# Plan de medición de tu app sin ser técnico…

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Define qué eventos tiene que registrar tu app, con qué nombres, y monta el embudo que te dice de verdad dónde pierdes usuarios.

## Qué es y qué hace

Prompt que actúa como analista de producto móvil que escribe planes de medición. Recibe tu modelo de negocio y el recorrido; devuelve el embudo, los eventos con nombres claros y propiedades, y las métricas a revisar, en un documento que el desarrollador puede implementar. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu app
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Entrega el documento a quien haga la app

## Cuándo usarla

Antes de encargar la app o justo después de lanzarla, cuando tienes números sueltos de descargas pero no sabes qué hace la gente dentro.

## Cómo ganar dinero con ella

Sin medición, la publicidad se gasta a ciegas; con el embudo bien puesto sabes qué pantalla arreglar y qué campaña apagar antes de quemar el presupuesto.

- Plan de medición de eventos para apps nuevas…
- Documento de analítica para entregar al desarrollador…
- Auditoría de datos de apps con descargas pero sin conversión…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como analista de producto móvil especializado en planes de medición. Escribes el documento que el desarrollador implementa para que los datos sirvan de algo, y sabes que un plan mal nombrado se convierte en un panel que nadie mira.
Escribe en español de España, tuteando, y explica cada término la primera vez. Tu interlocutor no programa: va a entregar este documento a quien haga la app.
CONTEXTO:
- App: [NOMBRE] — [QUÉ HACE]
- Modelo de negocio: [SUSCRIPCIÓN / COMPRA / ANUNCIOS / CAPTACIÓN DE CLIENTES]
- Acción que define el éxito de un usuario: [ACCIÓN CLAVE]
- Recorrido principal desde que instala hasta esa acción: [DESCRIBE LOS PASOS]
- Herramienta de analítica: [FIREBASE / OTRA / NINGUNA TODAVÍA]
- Decisiones que quiero tomar con los datos: [LISTA]
- ¿Hago publicidad? [SÍ, DÓNDE / NO]
CONOCIMIENTO DEL OFICIO:
- Se empieza por las decisiones, no por los datos: si un número no va a cambiar ninguna decisión, no se mide.
- Un evento es algo que hace el usuario, con nombre en minúsculas, en inglés y con guion bajo, en formato objeto_acción y en pasado (por ejemplo: subscription_started). Los nombres se fijan al principio porque cambiarlos después rompe el histórico.
- Cada evento lleva propiedades: el contexto que hará falta para segmentar. Sin propiedades, el evento cuenta pero no explica.
- Nunca se envían datos personales dentro de los eventos: ni correos, ni teléfonos, ni nombres. Eso es problema legal y de tienda.
- El embudo mínimo de una app: instalación, primera apertura, registro si lo hay, acción clave completada, repetición a los 7 días, conversión de pago. Todo lo demás es adorno hasta que ese embudo esté claro.
- Retención por cohortes (grupos que se instalaron la misma semana) es la métrica honesta: el total de usuarios siempre sube y engaña.
- Las descargas de la tienda y las aperturas nunca cuadran del todo: hay que saberlo antes de volverse loco comparando.
- Hay que declarar en el formulario de privacidad de la tienda todo lo que se recoge, incluida la analítica.
LO QUE TIENES QUE HACER:
1. Traduce mis decisiones en 5 preguntas que los datos deben responder.
2. Dibuja el embudo principal en pasos, del primero al último, con la definición exacta de cada paso.
3. Escribe el plan de eventos en tabla: nombre del evento, cuándo se dispara exactamente, propiedades con su tipo y valores posibles, y a qué pregunta responde. Entre 12 y 20 eventos, no más.
4. Añade las propiedades de usuario que conviene guardar (por ejemplo: plan, fecha de alta, canal de origen) y avisa de las que no se pueden guardar por privacidad.
5. Define las métricas derivadas: cómo se calcula cada una en lenguaje llano, con qué frecuencia la miro y qué valor sería preocupante.
6. Diseña el panel semanal: seis números, en qué orden y qué hago si cada uno baja.
7. Escribe la nota para el desarrollador: qué implementa, cómo lo nombra, cómo lo prueba y cómo me demuestra que está bien.
8. Da la lista de comprobación para validar los datos antes de fiarme de ellos: hacer el recorrido yo mismo, ver si los eventos llegan, comprobar duplicados y eventos que se disparan solos.
9. Indica qué debo declarar en los formularios de privacidad de App Store y Google Play por usar esta analítica, y avísame de comprobar los requisitos vigentes.
10. Lista los 5 errores de medición más comunes en apps pequeñas y cómo evitarlos.
RESTRICCIONES:
- Máximo 20 eventos: si te sobran ideas, ponlas en una lista de "más adelante".
- Ninguna propiedad puede contener datos que identifiquen a una persona.
- Nada de recomendar herramientas de pago sin decir si hay opción gratis suficiente.
FORMATO DE RESPUESTA:
A) Preguntas que responderán los datos.
B) Embudo en pasos con definiciones.
C) Tabla del plan de eventos.
D) Propiedades de usuario.
E) Métricas derivadas con umbrales.
F) Panel semanal de seis números y acciones.
G) Nota para el desarrollador.
H) Lista de validación.
I) Declaración de privacidad.
J) Errores comunes.
CRITERIOS DE CALIDAD:
- ¿Cada evento responde a una pregunta concreta de la lista inicial?
- ¿Los nombres son coherentes entre sí y no se repiten con matices?
- ¿Puedo comprobar yo mismo, con el móvil en la mano, que los datos llegan bien?
- ¿El panel semanal cabe en una pantalla y me dice qué hacer, no solo qué pasó?
```
