---
description: Audita la usabilidad y la velocidad de una web en móvil y devuelve los arreglos ordenados por impacto, con el HTML y CSS necesario
argument-hint: [dirección de la web o archivo HTML a revisar]
---

Vas a auditar en móvil: $ARGUMENTS

Escribes en español de España y tuteas. La persona no es diseñadora: cada problema tiene que venir con su arreglo concreto, no con un consejo genérico.

PASO 1. Si te han dado archivos del proyecto, léelos. Si te han dado una dirección y no puedes abrirla, pide al usuario que te describa la página o que te pegue el HTML, y avisa de que sin verla solo puedes darle la lista de comprobación.

PASO 2. Revisa por bloques, y para cada punto di si pasa o falla y por qué:
- ZONA DEL PULGAR: los botones importantes deben estar en la mitad inferior de la pantalla o repetidos ahí. Nada crítico pegado a la esquina superior.
- TAMAÑO DE LO PULSABLE: mínimo 44 puntos en iPhone y 48 en Android, con al menos 8 píxeles de separación entre dos elementos pulsables. Enlaces de texto muy juntos son un fallo.
- TEXTO: cuerpo de 16 píxeles como mínimo. Si es menor, el iPhone hace zoom solo al enfocar un campo y descoloca la página.
- ANCHO: nada que obligue a desplazarse en horizontal. Comprueba imágenes y tablas sin límite de ancho.
- FORMULARIOS: cada campo con su tipo correcto para que salga el teclado adecuado (email, teléfono, número), autocompletado activado, y el botón de enviar visible cuando el teclado está abierto.
- VENTANAS EMERGENTES: nada que tape la pantalla nada más entrar, y si hay aviso de cookies, con la equis grande y pulsable.
- IMÁGENES: peso y tamaño adecuados, con ancho y alto declarados para que la página no salte mientras carga.
- VELOCIDAD: la parte principal debería aparecer en menos de dos segundos y medio en una conexión normal de móvil; la página no debe moverse sola mientras carga; el primer toque debe responder al instante.
- MENÚ: se llega a lo importante en un toque o dos. Si el menú esconde lo que más se busca, es un fallo.
- TELÉFONO Y WHATSAPP: si es un negocio, el número debe ser pulsable para llamar directamente.

PASO 3. Explica cómo comprobarlo sin herramientas de pago: abrir la web en el móvil real con datos móviles, no con wifi; usar la vista de móvil del navegador del ordenador para el ancho; y pasar la página por PageSpeed Insights para la velocidad, mirando solo la pestaña de móvil.

PASO 4. Ordena los hallazgos por impacto en tres grupos: ROMPE LA VENTA (impide comprar, llamar o enviar), FRENA (molesta y hace que algunos se vayan) y MEJORABLE (estético). Da el arreglo de cada uno con el CSS o el HTML exacto cuando sea posible.

PASO 5. Entrega la lista de los cinco arreglos que más van a notar, con el tiempo estimado de cada uno en minutos u horas, para que se puedan hacer en una tarde.

ERRORES TÍPICOS QUE DEBES BUSCAR SIEMPRE: el aviso de cookies imposible de cerrar con el pulgar, la imagen de cabecera de varios megas, el formulario con el botón debajo del teclado, el texto gris claro sobre fondo blanco, el menú desplegable que se cierra solo, y el vídeo que se reproduce con sonido al entrar.

CÓMO SABER SI ESTÁ BIEN: coge el móvil con una sola mano, en la calle, con brillo alto, y completa la acción principal de la web (comprar, pedir cita, llamar) en menos de un minuto. Si no puedes, no está bien.

FORMATO DE SALIDA: tabla con problema, gravedad, dónde está y arreglo; después los bloques de código listos para pegar; y al final la lista de los cinco arreglos prioritarios con su tiempo.
