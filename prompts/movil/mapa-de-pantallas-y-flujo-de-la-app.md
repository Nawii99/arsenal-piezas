# Mapa de pantallas y flujo de la app…

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Dibuja en texto todas las pantallas de tu app, qué hay en cada una y cómo se llega de una a otra, antes de que nadie toque el diseño.

## Qué es y qué hace

Prompt para cualquier chat de IA que dibuja en texto el mapa de pantallas de una app. Con la descripción de la app, lista cada pantalla, su contenido y cómo se navega de una a otra, listo para pasar a Figma o a código. Ejemplo: mapa de 12 pantallas de una app de reservas.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con la app y su usuario
3. Revisa el mapa y pásalo a tu diseñador o a Figma

## Cuándo usarla

Úsalo cuando ya sepas qué hace la app y necesites ver las pantallas completas y el recorrido del usuario antes de diseñar, maquetar o encargar el desarrollo.

## Cómo ganar dinero con ella

Detectar pantallas que faltan sobre papel cuesta cero; detectarlas cuando ya está programada se paga en horas de desarrollo rehechas.

- Mapas de pantallas y flujos para apps de negocios pequeños…
- Preparación de diseño para freelance de UX…
- Especificación previa a maquetar en Figma o código…

**Precio orientativo:** 120–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como diseñador de producto móvil especializado en apps pequeñas, con experiencia en pasar ideas a mapas de pantalla que luego se maquetan en Figma o directamente en código.
Objetivo: que yo pueda ver mi app entera antes de que exista, pantalla por pantalla, con lo que hay dentro de cada una y cómo se navega.
CONTEXTO:
- Qué hace la app: [DESCRIPCIÓN EN 3 O 4 FRASES]
- Acción principal que el usuario debe completar: [ACCIÓN CLAVE, POR EJEMPLO: RESERVAR UNA CITA]
- Tipos de usuario: [CLIENTE / PROFESIONAL / ADMINISTRADOR / SOLO YO]
- ¿Hace falta registrarse? [SÍ / NO / SOLO PARA GUARDAR COSAS]
- Plataforma: [IPHONE / ANDROID / AMBAS]
- Estilo de navegación que prefiero, si tengo preferencia: [BARRA INFERIOR DE PESTAÑAS / MENÚ LATERAL / FLUJO LINEAL / NO LO SÉ, DECIDE TÚ]
PASOS:
1. Propón la estructura de navegación (máximo 5 secciones principales) y explica en una línea por qué esa y no otra.
2. Lista TODAS las pantallas necesarias, incluidas las que la gente olvida: pantalla de carga, registro, recuperar contraseña, vacío sin datos, error de conexión, permisos del sistema, ajustes, perfil, confirmación, y pantalla de éxito tras la acción principal.
3. Por cada pantalla describe: nombre, objetivo en una frase, elementos visibles de arriba abajo, acciones posibles, a qué pantalla lleva cada acción, y qué se ve si aún no hay datos.
4. Dibuja el recorrido principal (el camino más corto desde abrir la app hasta completar la acción clave) contando cuántos toques hacen falta. Si son más de 5, propón cómo reducirlos.
5. Dibuja 2 recorridos secundarios importantes, por ejemplo el de usuario que vuelve y el de usuario que se equivoca.
6. Marca los momentos delicados: dónde pedimos permisos (notificaciones, cámara, ubicación), dónde pedimos datos personales y dónde pedimos dinero. Propón en qué pantalla exacta pedir cada cosa y por qué ahí.
7. Señala las pantallas que se pueden eliminar o fusionar para simplificar la versión 1.
RESTRICCIONES:
- Nada de diseño visual (colores, tipografías): esto es estructura y contenido.
- Usa nombres de pantalla cortos y estables, en mayúscula inicial, que sirvan para hablar con el desarrollador.
- Respeta las convenciones del móvil: acción principal accesible con el pulgar, retroceso siempre disponible, nada de menús escondidos para la acción clave.
- No metas más de 5 elementos importantes por pantalla; si hay más, propón dividir.
FORMATO DE SALIDA:
1) MAPA GENERAL (esquema en texto con indentación por niveles y flechas ->)
2) FICHA DE CADA PANTALLA (tabla o bloques con: Nombre | Objetivo | Contenido | Acciones y destino | Estado vacío)
3) RECORRIDO PRINCIPAL PASO A PASO CON NÚMERO DE TOQUES
4) RECORRIDOS SECUNDARIOS
5) MOMENTOS DELICADOS (permisos, datos, pago) Y DÓNDE COLOCARLOS
6) SIMPLIFICACIONES PROPUESTAS PARA LA VERSIÓN 1
CRITERIOS DE CALIDAD:
- No puede haber ninguna pantalla sin salida ni ninguna acción que lleve a un sitio no descrito.
- Toda pantalla que muestre una lista tiene definido su estado vacío y su estado de error.
- El recorrido principal se entiende leyéndolo en voz alta a alguien que no conoce la app.
- Si detectas que la app necesita menos pantallas de las que yo creía, dilo sin miedo y explica el ahorro.
```
