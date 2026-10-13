# redirecciones-al-rehacer-la-web…

**Tipo:** Prompt · **Área:** Web · **Licencia:** CC BY 4.0

Plan de redirecciones 301 y página 404 útil para cambiar de web, dominio o direcciones sin perder las visitas ni las posiciones que ya tenías en Google.

## Qué es y qué hace

Prompt que actúa como consultor de migraciones web y prepara un plan de redirecciones 301 y una página 404 útil. Entra la lista de URLs antiguas y nuevas; sale una tabla de equivalencias, reglas de redirección y una lista de comprobaciones. Se usa en cualquier chat de IA al cambiar de web o dominio.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] y pega tus listas de URLs
3. Aplica las redirecciones en tu hosting o plataforma
4. Comprueba en Search Console que no hay errores

## Cuándo usarla

Úsalo antes de sustituir tu web por una nueva, cambiar de dominio, reordenar el menú o borrar páginas viejas que ya no te encajan.

## Cómo ganar dinero con ella

Rehacer la web sin redirecciones te puede tumbar el tráfico que ya tenías. Esto conserva los clientes que llegaban solos por Google.

- Migración SEO de webs de pymes al cambiar de plataforma o dominio…
- Plan de redirecciones 301 como servicio de cierre en rediseños web…
- Diseño de páginas 404 que reconducen a la venta…

**Precio orientativo:** 100–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como consultor de migraciones web. Has llevado docenas de cambios de web de negocios pequeños y sabes que el desastre típico no es el diseño: es perder las direcciones antiguas. Yo no soy técnico.

MI CASO
- Web antigua: [DOMINIO Y DÓNDE ESTÁ ALOJADA] · Web nueva: [DOMINIO Y PLATAFORMA]
- Tipo de cambio: [MISMO DOMINIO, DIRECCIONES NUEVAS / DOMINIO NUEVO / DE HTTP A HTTPS / DE CON WWW A SIN WWW / BORRO PÁGINAS]
- Fecha prevista del cambio: [FECHA]
- Tengo acceso a: [SEARCH CONSOLE / ANALÍTICA / PANEL DEL HOSTING / SOLO A LA PLATAFORMA]

LISTA DE DIRECCIONES
Antiguas: [PEGA LA LISTA DE URLS ACTUALES; SI NO LA TIENES, DIME CÓMO SACARLA]
Nuevas: [PEGA LA LISTA DE URLS DE LA WEB NUEVA]

LO QUE TIENES QUE HACER
1. Si no tengo la lista de direcciones antiguas, dime tres formas de sacarla ordenadas de más fácil a más técnica: sitemap, informe de páginas de Search Console y páginas con visitas en la analítica. Explica cómo exportarlas.
2. Haz el MAPA DE REDIRECCIONES: tabla con URL antigua, URL nueva, tipo de redirección y motivo. Regla de oro que debes aplicar y explicarme: cada página antigua va a la página nueva más parecida en contenido; mandar todo a la portada es el error más caro y hay que evitarlo.
3. Márcame en la tabla los casos especiales: páginas que desaparecen sin equivalente (qué hacer), páginas que se fusionan, y páginas con muchas visitas que hay que revisar a mano.
4. Explícame en dos líneas la diferencia entre 301 y 302 y por qué aquí casi siempre es 301.
5. Dame el código o los pasos exactos para MI plataforma: archivo de configuración de redirecciones, panel del hosting o el mecanismo que corresponda. Código completo y pegable, con un ejemplo de redirección simple y otro con comodín para una carpeta entera.
6. Cuida las cadenas: avísame de no encadenar redirecciones (A va a B y B va a C) y dime cómo detectarlas.
7. Diseña mi página 404: qué debe llevar para que no pierda a la visita (buscador, enlaces a las secciones importantes, contacto por WhatsApp o teléfono, tono humano). Dame el HTML listo y dime cómo activarla en mi plataforma.
8. Dame el calendario de la migración: qué hago la semana antes, el día del cambio y las cuatro semanas siguientes, incluyendo enviar el sitemap nuevo, avisar del cambio de dominio en Search Console si aplica, y no borrar la web antigua hasta pasado un tiempo prudente.
9. Dame los indicadores de vigilancia: qué mirar para saber si la migración va bien o mal, y a partir de qué señal debo dar marcha atrás.
10. Termina con la lista de errores clásicos: perder el archivo robots, dejar la web nueva bloqueada a buscadores tras las pruebas, olvidar redirigir imágenes o PDFs enlazados, y romper los enlaces de la firma del email o de las redes.

RESTRICCIONES
- Nada de teoría de SEO. Todo aplicado a mis direcciones concretas.
- Si la lista de URLs es larga, agrupa por patrones en vez de listar una por una, y dime la regla con comodín.
- Español de España, tuteando, sin emojis.

FORMATO DE RESPUESTA
A. CÓMO SACAR LA LISTA DE URLS (si hace falta)
B. MAPA DE REDIRECCIONES (tabla)
C. CASOS ESPECIALES
D. CÓDIGO O PASOS PARA MI PLATAFORMA (bloque completo)
E. HTML DE LA PÁGINA 404
F. CALENDARIO: ANTES, EL DÍA, DESPUÉS
G. QUÉ VIGILO Y CUÁNDO ME PREOCUPO
H. ERRORES CLÁSICOS

CRITERIO DE CALIDAD: está bien si, al pegar cualquier dirección antigua en el navegador, acabo en la página nueva equivalente y no en la portada ni en un error.
```
