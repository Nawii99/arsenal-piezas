---
name: portfolio-3d
description: Genera un portfolio de una sola pagina con animaciones al bajar (Three.js, React Three Fiber o CSS+GSAP) en un unico archivo autonomo listo para publicar gratis.
---

# /portfolio-3d

Generas un portfolio web de una sola pagina, en un unico archivo `index.html`, con secciones que se animan segun el usuario baja.

## Antes de escribir nada, pregunta y espera respuesta

1. Nombre, titular en seis palabras y ciudad. Ejemplo: "Tu Nombre - Automatizo procesos con n8n e IA - Madrid".
2. Puesto exacto al que apunta. No vale "algo de tecnologia".
3. Que tres o cuatro proyectos entran y en que orden.
4. Enlaces reales: GitHub, LinkedIn, email y CV en PDF.
5. Nivel de 3D que quiere: `bajo`, `medio` o `alto`.
6. Si duda, pones `bajo`. Se ve bien y carga en un segundo.

## Que significa cada nivel

- `bajo`: cero 3D. Solo CSS con `IntersectionObserver`, y GSAP + ScrollTrigger por CDN si hace falta algo mas fino. Pesa menos de 100 KB.
- `medio`: un `<canvas>` fijo de fondo con particulas o una malla de puntos que gira lento segun el scroll. Three.js por CDN, geometria generada por codigo.
- `alto`: escena Three.js con una figura que rota y se transforma segun el porcentaje de scroll. Solo si el equipo del usuario va sobrado y el puesto es de front.
- React Three Fiber solo si el usuario ya tiene un proyecto React montado. Si no, no lo metas: obliga a `npm` y a build.

## Reglas de peso que no se negocian

- Objetivo: se ve en menos de 2 segundos en un movil con 4G.
- Un unico `index.html` autonomo. CSS y JS dentro. Sin `npm`, sin build, sin framework.
- Nunca superes 300 KB de JavaScript. Si te pasas, bajas de nivel de 3D.
- Nada de modelos `.glb`, ni texturas, ni HDRI. Todo geometria por codigo.
- Libreria externa solo por CDN y con version fija en la URL.
- Imagenes en `.webp`, ancho maximo 1200 px, con `loading="lazy"`.

## Como se construye, en orden

1. `<head>`: titulo con nombre y puesto, `meta description`, Open Graph (title, description, image) y favicon en emoji. El Open Graph importa: es lo que se ve cuando pega el enlace en LinkedIn.
2. Secciones en este orden: Portada, Que hago, Proyectos, Como trabajo, Sobre mi, Contacto.
3. Animacion de entrada de cada seccion con `IntersectionObserver`: de opacidad 0 a 1 y de `translateY(24px)` a 0, con 80 ms de retardo escalonado entre hijos.
4. Nivel `medio` o `alto`: el canvas va con `position: fixed`, `z-index: -1` y `pointer-events: none`. Un solo `requestAnimationFrame`. Pausas el bucle cuando el canvas no se ve.
5. Cada proyecto es una tarjeta con: problema en una linea, que hizo el candidato, resultado con numero, tecnologias y enlaces a demo y a codigo.
6. Contacto: email como `mailto:`, boton de descarga del CV y enlace a LinkedIn. Sin formulario, porque sin servidor no funciona.

## Accesibilidad y respaldo, obligatorios

- Toda animacion dentro de `@media (prefers-reduced-motion: reduce)` se queda quieta.
- Si el ancho es menor de 900 px o `navigator.hardwareConcurrency < 4`, no cargas el 3D: pones un degradado estatico.
- Si el CDN no responde, la pagina se lee entera igual. El 3D es decoracion, nunca contenido.
- Contraste minimo 4.5:1. El texto sobre el canvas siempre con una capa oscura por detras.
- Navegable con teclado y con textos alternativos en las imagenes.

## Que devuelves al terminar

1. El `index.html` completo, escrito en la carpeta que diga el usuario.
2. Como verlo en local: `python3 -m http.server 8000` y abrir `http://localhost:8000`.
3. La lista de datos que tiene que sustituir a mano (enlaces, foto, CV, cifras).
4. El peso total en KB y cuantas peticiones hace la pagina.

## Que NO haces nunca

- No inventas proyectos, empresas, clientes ni cifras. Lo que falte se queda como `[PENDIENTE]` visible.
- No metes pantalla de carga con porcentaje. Es la forma mas rapida de que cierren la pestana.
- No secuestras el scroll ni pones musica ni cursor personalizado.
- No pones "apasionado por la tecnologia" ni frases de coach.

## Aviso que le das al usuario al final, con estas palabras

Un portfolio 3D bonito que tarda 6 segundos en cargar convierte peor que un HTML sobrio que carga en 1. El reclutador abre cuarenta perfiles en una tarde, muchos desde el movil y con mala cobertura. Si tarda, cierra. Prueba tu propia web con los datos moviles y el wifi apagado antes de mandarla a nadie.
