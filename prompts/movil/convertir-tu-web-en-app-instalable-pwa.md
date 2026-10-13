# Convertir tu web en app instalable (PWA)

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Tu web aparece como icono en el móvil sin pasar por tiendas ni pagar nada.

## Qué es y qué hace

Prompt que actúa como desarrollador web y asesor honesto para convertir una web en app instalable (PWA). Recibe tu web, dónde está alojada y necesidades offline o de avisos; devuelve si conviene, el manifiesto, el service worker y los pasos, listos para pegar o pedir a una IA que programe. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu web
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Sube los archivos a tu hosting y prueba la instalación en el móvil

## Cuándo usarla

Úsalo cuando quieras que tus clientes tengan tu servicio como icono en el móvil pero no quieras pagar ni esperar a las tiendas de apps.

## Cómo ganar dinero con ella

Te ahorras las cuotas de desarrollador y el desarrollo de dos apps nativas, y ganas un canal directo con el cliente sin intermediarios.

- Conversión de webs de negocio en PWA instalables…
- Instalación de PWA con icono y modo offline básico…
- Alternativa económica a una app de tienda para clientes recurrentes…

**Precio orientativo:** 150–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como desarrollador web que explica a alguien sin perfil técnico cómo convertir una página web normal en una aplicación instalable en el móvil (PWA), y como asesor honesto sobre cuándo eso no es buena idea.
Todo lo que me des debe poder pegarse en archivos o pedirse a una IA que programe.
CONTEXTO
Mi web: [URL O DESCRIPCIÓN DE QUÉ HACE]
Con qué está hecha: [HTML SUELTO / WORDPRESS / SHOPIFY / UNA APP HECHA CON IA / NO LO SÉ]
Dónde está alojada: [GITHUB PAGES / NETLIFY / VERCEL / HOSTING NORMAL / NO LO SÉ]
Qué quiero que se pueda hacer sin conexión: [NADA / VER LO YA VISTO / RELLENAR FORMULARIOS Y ENVIAR LUEGO]
¿Necesito avisos push? [SÍ / NO]
Colores e icono de marca: [COLORES Y SI TENGO LOGO]
Público: [MAYORÍA IPHONE / MAYORÍA ANDROID / MEZCLA]
TU TRABAJO, PASO A PASO
1. Dime primero, con honestidad, si en mi caso conviene una web instalable o hace falta una app de tienda. Da tres motivos a favor y las tres limitaciones reales en iPhone (avisos limitados, sin aparecer en la tienda, instalación menos evidente).
2. Explícame en cinco frases qué es lo que convierte una web en instalable: el archivo de manifiesto, el trabajador de servicio y que se sirva por HTTPS.
3. Dame el archivo de manifiesto completo, relleno con mis datos, y dime en qué carpeta va y qué línea hay que añadir en la página.
4. Dame el trabajador de servicio en su versión más simple que funcione: qué guarda en el móvil, cómo se registra, y cómo se fuerza la actualización cuando publico cambios, que es el fallo que más quebraderos da.
5. Dime qué iconos necesito exactamente, con sus medidas, cuál se usa en Android y cuál en iPhone, y cómo generarlos gratis a partir de mi logo.
6. Escribe el aviso dentro de mi web que invita a instalar, con dos versiones: la de Android, que puede usar el botón del navegador, y la de iPhone, que exige explicar el gesto de compartir y añadir a pantalla de inicio. Textos exactos.
7. Dame la lista de comprobación para saber que ha funcionado: qué mirar en el móvil, cómo probar el modo sin conexión, y cómo comprobarlo desde el ordenador con las herramientas del navegador, explicado clic a clic.
8. Avísame de los errores típicos: no estar en HTTPS, guardar en caché la página principal y que nunca se actualice, iconos con fondo transparente que salen feos, y olvidar la ruta de inicio.
9. Cierra con qué medir: cuántos instalan, cuántos vuelven desde el icono, y si merece la pena dar el salto a una app de tienda más adelante.
REGLAS
Código completo y comentado en español, sin fragmentos a medias.
Si algo depende de la plataforma donde está mi web, dime la instrucción concreta para cada caso que he indicado.
Nada de recomendar servicios de pago para hacer esto: se puede hacer gratis.
FORMATO DE RESPUESTA
A) Recomendación honesta con motivos y limitaciones.
B) Explicación en cinco frases.
C) Archivos completos, uno por bloque, con su nombre y su ubicación.
D) Tabla de iconos.
E) Textos del aviso de instalación para Android y para iPhone.
F) Comprobaciones paso a paso.
G) Errores típicos y su solución.
CRITERIOS DE CALIDAD
Puedo seguir todos los pasos sin saber programar, copiando y pegando.
Se explica cómo publicar una versión nueva sin que los usuarios se queden con la antigua.
Queda claro qué NO voy a poder hacer con esto, sin adornos.
```
