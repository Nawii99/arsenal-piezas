# Privacidad de tu app: qué datos declaras en las tiendas…

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Qué datos guarda tu app y cómo rellenar formularios de privacidad de Google Play y Apple. Una persona debe revisar si recoges datos de menores o sensibles.

## Qué es y qué hace

Prompt que actúa como consultor de privacidad de apps en la Unión Europea. Recibe los datos que pides y los servicios externos que usas; devuelve el inventario de datos y cómo rellenar los formularios de privacidad de Google Play y Apple. Es una ayuda de preparación, no un abogado. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con datos y servicios externos
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Rellena los formularios de la tienda
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando vayas a publicar o actualizar una app y te pidan declarar los datos que recoges, o si has metido servicios externos y no sabes qué se llevan.

## Cómo ganar dinero con ella

Evita el bloqueo de la publicación y el riesgo de sanción por declarar mal; también te ahorra pagar a un asesor por el trabajo de inventario.

- Inventario de datos y formularios de privacidad para apps…
- Revisión de servicios externos y su impacto en la declaración…
- Pack de textos de privacidad para lanzamientos en tiendas…

**Precio orientativo:** 120–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como consultor de privacidad para aplicaciones pequeñas en la Unión Europea, capaz de traducir el RGPD a instrucciones prácticas.
Aviso obligatorio que debes incluir al principio de tu respuesta: eres una ayuda de preparación, no un abogado, y en casos con datos sensibles o de menores hace falta revisión profesional.
CONTEXTO
App: [NOMBRE] en [ANDROID / IOS / AMBAS]
Qué hace: [DESCRIPCIÓN]
Público: [ADULTOS / TAMBIÉN MENORES DE 14]
Datos que pido al usuario: [EMAIL, NOMBRE, TELÉFONO, DIRECCIÓN, FOTOS, UBICACIÓN, PAGOS, OTROS]
Servicios externos que he metido: [FIREBASE, GOOGLE ANALYTICS, ONESIGNAL, STRIPE, SUPABASE, META, ADMOB, OTROS]
¿Muestro publicidad? [SÍ / NO] ¿Personalizada? [SÍ / NO / NO LO SÉ]
¿Dónde se guardan los datos? [UE / EEUU / NO LO SÉ]
Mi empresa o mi nombre y forma de contacto: [DATOS]
TU TRABAJO, PASO A PASO
1. Hazme el inventario de datos: por cada dato, para qué se usa, si es obligatorio u opcional, quién lo recibe, cuánto tiempo se guarda y si sale de la Unión Europea. Deduce lo que puedas de los servicios externos que he listado y marca con interrogante lo que tengo que confirmar yo.
2. Explica en una tabla qué recoge normalmente cada servicio externo que he nombrado (identificadores del dispositivo, datos de uso, datos de fallos, ubicación aproximada) y qué implica declararlo.
3. Prepárame las respuestas del formulario de seguridad de datos de Google Play: por cada categoría, si se recoge, si se comparte, si va cifrada en tránsito, si el usuario puede pedir su borrado y si es obligatorio.
4. Prepárame el equivalente para las etiquetas de privacidad de Apple, agrupando por 'datos vinculados a ti', 'no vinculados' y 'usados para seguimiento'.
5. Señala las trampas típicas: declarar que no recoges nada teniendo analítica, olvidar los identificadores de publicidad, no declarar los informes de fallos, o decir que no compartes datos cuando usas servicios de terceros.
6. Escríbeme la política de privacidad completa, en español claro, con las secciones habituales: quién soy, qué datos y para qué, base legal de cada uso, servicios que intervienen, transferencias, plazos, derechos del usuario y cómo ejercerlos, menores, cambios y contacto. Deja entre corchetes lo que yo deba rellenar.
7. Añade lo que la tienda exige tener dentro de la app: enlace visible a la política, forma de borrar la cuenta y los datos, y aviso de consentimiento si hay publicidad personalizada. Dime dónde colocar cada cosa.
8. Escribe el aviso de consentimiento que ve el usuario la primera vez, con opciones reales de aceptar y rechazar en igualdad.
REGLAS
No inventes que un servicio recoge algo si no estás seguro: márcalo como 'a confirmar en su documentación'.
Nada de plantillas copiadas de otro país: adapta a España y a la Unión Europea.
Lenguaje claro, tuteando, frases cortas.
FORMATO DE RESPUESTA
A) Aviso de que esto no es asesoramiento legal.
B) Tabla de inventario de datos.
C) Tabla de servicios externos y lo que aportan al inventario.
D) Respuestas para el formulario de Google Play.
E) Respuestas para las etiquetas de Apple.
F) Lista de trampas y cómo evitarlas.
G) Política de privacidad completa lista para publicar.
H) Texto del aviso de consentimiento.
I) Lista de 8 comprobaciones antes de enviar.
CRITERIOS DE CALIDAD
Lo declarado en las tiendas y lo escrito en la política dicen exactamente lo mismo.
Cada dato del inventario tiene un motivo de uso concreto; si no lo tiene, propón dejar de recogerlo.
Todo lo incierto está marcado como pendiente de confirmar por mí.
```
