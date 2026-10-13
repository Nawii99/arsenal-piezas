# Onboarding: los primeros 60 segundos…

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Diseña lo que ve y hace el usuario nada más abrir tu app por primera vez para que llegue a su primer resultado y no la borre.

## Qué es y qué hace

Prompt para cualquier chat de IA que diseña los primeros 60 segundos de una app. Con la app y el nivel del usuario, define pantallas de bienvenida, registro mínimo y el camino más corto al primer resultado, para que no la borre el primer día. Ejemplo: onboarding de una app de hábitos.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con la app y el usuario
3. Aplica el flujo en el diseño o pásalo a tu programador

## Cuándo usarla

Úsalo cuando la gente descargue tu app pero la abandone el primer día, o antes de programar la pantalla de bienvenida y el registro.

## Cómo ganar dinero con ella

Cada usuario que se pierde en el primer minuto es dinero de captación tirado; arreglar el arranque rentabiliza la publicidad que ya pagas.

- Mejora de retención del día 1 para desarrolladores…
- Revisión de la primera experiencia de usuario…

**Precio orientativo:** 100–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como especialista en activación de usuarios en apps móviles, de los que trabajan la retención del día 1 y el 'momento aha'.
Objetivo: diseñar el primer minuto de mi app para que el usuario llegue cuanto antes a un resultado que le importe.
CONTEXTO:
- App: [NOMBRE] y qué hace: [DESCRIPCIÓN]
- Público y su nivel con la tecnología: [PERFIL]
- Qué es un usuario activado en mi app (el momento en el que dice 'esto me sirve'): [MOMENTO CLAVE, POR EJEMPLO: HA CREADO SU PRIMER PRESUPUESTO]
- Qué le pido hoy al abrir: [REGISTRO, PERMISOS, TUTORIAL, NADA]
- Datos que necesito de verdad para que funcione: [LISTA]
- Datos que pido hoy aunque no sean imprescindibles: [LISTA]
PASOS:
1. Confirma o corrige cuál debería ser el momento de activación y por qué. Si el que te he dado llega demasiado tarde, propón uno más cercano al primer minuto.
2. Diseña el recorrido de bienvenida pantalla a pantalla, con un objetivo por pantalla y el número de toques total hasta la activación.
3. Aplica estas reglas y justifica cada decisión: retrasar el registro hasta que el usuario haya recibido valor, pedir cada permiso justo cuando se necesita y explicándolo antes con una pantalla propia, no enseñar carruseles de bienvenida que nadie lee, precargar datos de ejemplo en vez de mostrar pantallas vacías, y no pedir tarjeta antes de demostrar nada.
4. Escribe los textos exactos: títulos, subtítulos, textos de botón, texto de la pantalla previa a cada permiso (por qué se lo pedimos y qué gana), y mensajes de error amables.
5. Diseña el estado de la app cuando el usuario todavía no ha hecho nada: qué ve, qué le invita a hacer y con qué ejemplo.
6. Propón una versión reducida para probar: cuál es el onboarding mínimo que se puede lanzar esta semana.
7. Define cómo sabré si funciona: 4 o 5 eventos que hay que medir y el porcentaje de caída aceptable entre pantallas, explicando cómo leer el embudo.
8. Lista los 6 fallos más comunes que matan la activación y comprueba si mi app los tiene según lo que te he contado.
RESTRICCIONES:
- Máximo 3 pantallas antes del primer resultado útil.
- Nada de textos de bienvenida largos ni jerga; cada texto de botón dice lo que va a pasar.
- No propongas gamificación, medallas ni rachas si no encajan con el uso real de la app.
- Español de España, tuteo, frases de menos de 12 palabras en la interfaz.
FORMATO DE SALIDA:
1) MOMENTO DE ACTIVACIÓN (confirmado o corregido, con motivo)
2) RECORRIDO DE BIENVENIDA (tabla: paso, objetivo, qué se ve, qué se pide, toques acumulados)
3) TEXTOS EXACTOS DE INTERFAZ (por pantalla, entrecomillados)
4) PANTALLAS DE PETICIÓN DE PERMISOS (texto previo y momento)
5) ESTADO SIN DATOS
6) VERSIÓN MÍNIMA PARA LANZAR YA
7) EVENTOS A MEDIR Y CÓMO LEER EL EMBUDO
8) FALLOS DETECTADOS EN MI CASO
CRITERIOS DE CALIDAD:
- Un usuario que abre por primera vez recibe algo útil sin haber creado cuenta, salvo que sea técnicamente imposible; si lo es, explícalo.
- Ningún permiso se pide en la primera pantalla.
- Cada texto de botón empieza por un verbo y no dice 'Continuar' dos veces seguidas.
- El embudo propuesto se puede medir con herramientas gratuitas.
```
