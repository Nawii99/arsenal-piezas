---
name: decidir-donde-animar-en-una-web
description: Úsala cuando alguien quiera añadir animaciones a una web o app y necesite decidir cuáles ayudan y cuáles estorban, con su duración, su peso y su alternativa para quien prefiere menos movimiento.
---
# Decidir dónde animar en una web (y dónde no)

## Qué entrega esta skill
Una decisión por cada animación propuesta: sí, no o cambiar, con propósito, duración orientativa, coste de rendimiento, alternativa accesible y cómo pedirla o implementarla. No es una guía de adorno: la mejor animación suele ser la que se quita.

## 1. Pregunta primero
1. Qué página o pantalla es y qué debe lograr quien la usa (comprar, reservar, entender un precio).
2. Qué animaciones hay ya o se te ocurren (lista breve).
3. Quién la construye: tú con código, un diseñador, un constructor visual (Webflow, WordPress, Framer…).
4. Qué dispositivos importan, sobre todo móviles modestos.
Si no hay lista de animaciones, propón como máximo cinco para esa pantalla.

## 2. Prueba del propósito
Cada animación debe cumplir al menos una de estas funciones:
- **Orienta**: muestra de dónde viene algo o adónde va (un menú que se despliega desde su botón).
- **Confirma**: responde a una acción (botón pulsado, formulario enviado).
- **Guía la atención**: señala un cambio importante.
- **Da sensación de carga viva**: un esqueleto o un indicador mientras algo carga.
Si no cumple ninguna, es decoración: marca «quitar» o «dejar solo si no cuesta nada». Si distrae de la acción principal (comprar, reservar), marca «quitar».

## 3. Duración y curva (criterio orientativo)
- Respuestas a una pulsación: muy cortas, apenas perceptibles.
- Cambios de estado y menús: cortas.
- Entradas de bloques grandes: algo más largas, pero nunca al punto de hacer esperar.
- Ninguna animación debe retrasar que el contenido sea útil.
- Salidas más rápidas que entradas. Curvas suaves de frenado al llegar, no movimientos lineales robóticos.
Pon las cifras concretas en milisegundos solo como punto de partida y di que se afinan probando en el dispositivo real.

## 4. Rendimiento
- Anima, siempre que se pueda, la opacidad y las transformaciones (mover, escalar, girar). Evita animar propiedades que obligan a recolocar la página, como ancho, alto o márgenes.
- No uses `will-change` por sistema: solo si has medido un problema.
- Lottie y vídeo: pesan. Pide el archivo más ligero que cumpla el propósito y comprueba el peso final y cómo se ve en un móvil modesto. Las opciones de formato y los reproductores cambian: compruébalo en la documentación oficial de la librería que uses.
- Nada de animaciones infinitas que corran fuera de pantalla.

## 5. Accesibilidad
- Respeta la preferencia del sistema de movimiento reducido. Es la media query estándar `prefers-reduced-motion`. Ejemplo mínimo:
```css
.tarjeta { transition: transform .25s ease-out, opacity .25s ease-out; }
@media (prefers-reduced-motion: reduce) {
  .tarjeta { transition: none; }
}
```
- Con movimiento reducido no se elimina la información: se sustituye el desplazamiento por un cambio instantáneo o un fundido muy suave.
- Si algo se mueve solo, dura más de cinco segundos y está junto a otro contenido, hace falta un control para pausarlo, detenerlo u ocultarlo (WCAG 2.2.2).
- Nada que destelle más de tres veces por segundo (WCAG 2.3.1).
- Nunca dejes que la animación sea la única forma de entender algo.

## 6. Cómo pedirla o implementarla
- Para un diseñador: «animación de [qué], para que [propósito], duración orientativa, curva suave de frenado, versión sin movimiento para quien lo pida, peso máximo del archivo [X]».
- Para código: CSS con `transition` o `@keyframes` para lo simple; una librería de animación solo si hay secuencias complejas. Comprueba la documentación de la librería antes de copiar.
- Para un constructor visual: usa sus interacciones nativas y comprueba si respetan el movimiento reducido; si no, desactívalas con una regla propia.

## 7. Formato de salida
Tabla: animación · propósito · decisión (sí / no / cambiar) · duración orientativa · coste de rendimiento · alternativa con movimiento reducido · cómo pedirla. Debajo, máximo tres líneas con lo primero que quitarías.

## Qué NO hacer
- No dar cifras de rendimiento ganado o perdido sin medirlas.
- No copiar código de internet sin entenderlo línea a línea.
- No instalar librerías sin preguntar a la persona.
- No decir que algo cumple accesibilidad solo por tener `prefers-reduced-motion`: se prueba con el ajuste activado.
