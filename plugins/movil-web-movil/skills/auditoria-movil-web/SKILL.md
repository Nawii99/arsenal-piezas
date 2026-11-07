---
name: auditoria-movil-web
description: "Audita un sitio web tal como se vive en un móvil: velocidad de carga, zonas táctiles, formularios, elementos fijos, ventanas emergentes, legibilidad y recorrido de conversión, y devuelve una lista priorizada de arreglos. Úsala cuando una web funciona en escritorio pero convierte mal en móvil, cuando el rebote es alto en móviles o antes de una campaña de pago que envíe tráfico móvil."
---

# Auditoría de tu web en móvil

## Qué hace
Revisa la web con los ojos y el pulgar de un cliente en el móvil, en la calle y con prisa. Detecta lo que estorba, lo ordena por impacto y da el arreglo concreto de cada cosa.

## Cuándo se activa
Cuando el usuario dice que en móvil su web va lenta, se ve mal, no convierte, tiene rebote alto, o antes de lanzar publicidad que manda tráfico móvil.

## Qué preguntar
- URL de la página que más importa (no la portada, la que vende).
- ¿Qué quieres que haga el visitante: llamar, comprar, pedir presupuesto, reservar?
- ¿Con qué está hecha (WordPress, Shopify, HTML propio, constructor)?
- ¿De dónde llega la gente (Instagram, Google, WhatsApp)?
- ¿Tienes acceso para tocar la web o depende de alguien?

## Método
### 1. Prueba de campo, no de laboratorio
Abre la página en tu móvil, con datos móviles y no wifi, sujetándolo con una mano, y cronometra. Anota el segundo en el que puedes leer algo útil y el segundo en el que la página deja de moverse sola.

### 2. Velocidad: las tres cosas que la matan
- Imágenes gigantes sin comprimir. Arreglo: exportar a WebP, ancho máximo 1600 px, y carga diferida en todo lo que no se ve al entrar.
- Fuentes y scripts de terceros (chats, mapas, píxeles, ventanas de reseñas). Arreglo: cargar el chat solo tras interacción, mapa como imagen que se activa al pulsar.
- Vídeos de fondo y carruseles pesados. Arreglo: sustituir por imagen fija en móvil.
- Referencias útiles: apunta a que el contenido principal aparezca en menos de 2,5 segundos, que la página responda al primer toque en menos de 200 milisegundos y que no salte el diseño mientras carga. Mídelo con PageSpeed Insights en la pestaña de móvil.

### 3. Dedos y pantalla
- Botones de al menos 44 px de lado y separados entre sí.
- Nada importante escondido tras el menú hamburguesa: el teléfono o el botón de acción, siempre visibles.
- Texto de cuerpo de 16 px o más; menos de eso obliga a hacer zoom.
- Barra fija que no ocupe más de un 15 % de la pantalla.
- Nada de desplazamiento horizontal: si algo se sale, sobra.

### 4. Formularios
- Menos campos: nombre, teléfono o correo, y ya.
- Teclado correcto por campo (numérico para teléfono, correo para email).
- Autocompletar activado y etiquetas visibles, no solo el texto gris dentro.
- Botón de enviar visible sin que el teclado lo tape.
- Alternativa de WhatsApp o llamada al lado del formulario: en móvil convierte más.

### 5. Interrupciones
Ventanas emergentes al segundo, avisos de cookies que ocupan la pantalla entera, chat que salta solo, sonido automático. Cada una tiene un coste. Retrasa, reduce o elimina.

### 6. Camino de conversión
Recorre el camino entero desde el anuncio o el perfil hasta el final. Cuenta los toques necesarios. Si son más de tres para lo principal, hay trabajo.

## Formato exacto de la respuesta
1. Veredicto en 3 líneas y nota del 1 al 10 con justificación.
2. Tabla de hallazgos: Problema | Dónde | Impacto (alto/medio/bajo) | Esfuerzo | Arreglo concreto.
3. Los 5 arreglos de esta semana, ordenados por impacto entre esfuerzo.
4. Instrucciones de cada arreglo según su gestor de contenidos, paso a paso.
5. Antes y después esperado, en términos de experiencia, sin prometer porcentajes.
6. Cómo volver a medir dentro de 15 días.

## Errores típicos
- Optimizar la portada y dejar rota la página de producto o de contacto.
- Fiarse solo de la puntuación de PageSpeed y no abrir la web en un móvil real.
- Comprimir imágenes y volver a subir las pesadas al mes siguiente.
- Poner un chat que tapa el botón de comprar.
- Menús desplegables con submenús imposibles de tocar.
- Instalar cinco plugins de velocidad que se pisan entre ellos.

## Avisos honestos
- No prometas subidas de ventas: la velocidad ayuda, pero la oferta manda.
- Algunos arreglos requieren tocar la plantilla; si no tienes acceso, prioriza lo que se pueda hacer desde el panel.
- Haz copia de seguridad antes de tocar nada y cambia de una en una para saber qué rompió qué.
