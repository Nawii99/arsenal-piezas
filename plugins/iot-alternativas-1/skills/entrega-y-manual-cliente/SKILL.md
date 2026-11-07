---
name: entrega-y-manual-cliente
description: "Produce el paquete de entrega de una instalación IoT o de hogar inteligente terminada: guion de pruebas de aceptación, manual de usuario en lenguaje llano, hoja de credenciales, documentación as-built y conformidad. Úsala el día en que se termine una instalación, antes de facturar el pago final, o cuando un cliente siga llamando porque no sabe usar el sistema."
---

# Entrega de la instalación al cliente

## Qué hace

Genera todo el paquete de cierre de proyecto: el guion de la prueba de aceptación con el cliente delante, el manual en lenguaje llano, la documentación técnica para el futuro y el acta que se firma. Es lo que separa un proyecto terminado de uno que sigue costándote dinero seis meses después.

## Cuándo se activa

- Has terminado la instalación y vas a pedir el pago final.
- El cliente te llama cada semana con dudas básicas.
- Vas a dejar de dar soporte a un sistema y hay que traspasarlo.

## Qué preguntar antes de responder

1. ¿Qué se ha instalado exactamente? Lista de dispositivos con ubicación.
2. ¿Qué automatizaciones hay y qué hacen, en lenguaje de persona normal?
3. ¿Quién va a usarlo a diario? ¿Es una persona mayor, un empleado, varios?
4. ¿Qué nivel técnico tiene? Escribe el manual para el que menos sabe.
5. ¿Qué cosas rutinarias tendrá que hacer solo? (reiniciar, cambiar pilas, añadir un usuario).
6. ¿Qué NO debe tocar bajo ningún concepto?

## Método paso a paso

### 1. Prueba de aceptación, con el cliente presente

Prepara una lista de comprobaciones que se ejecutan delante del cliente y se marcan una a una. Cada una: qué se hace, qué debe pasar, casilla de conforme. Ejemplos: pulsar el interruptor y ver que enciende la escena; abrir la puerta y ver que llega el aviso al móvil del cliente en menos de un minuto; cortar la luz del router y comprobar qué sigue funcionando en local. Este último punto vale oro: el cliente tiene que ver con sus ojos qué pasa sin internet.

### 2. Manual en lenguaje llano

Reglas de redacción: frases cortas, tuteo, cero jerga. Nada de «broker MQTT» ni «entidad». Estructura por tareas, no por dispositivos: «cómo apagar todo al salir de casa», «cómo cambiar la hora del riego», «qué hacer si una luz no responde». Con foto o captura real de la pantalla del cliente en cada paso. Máximo dos páginas de lo básico y un anexo para lo demás; un manual de 30 páginas no lo lee nadie.

### 3. La página de «si algo falla»

Una sola hoja, imprimible, pegada al cuadro o a la nevera: 1) apagar y encender el dispositivo, 2) reiniciar el hub, cómo y cuánto esperar, 3) reiniciar el router, 4) qué mirar antes de llamar, 5) tu teléfono y horario. Con esto desaparece la mitad de las llamadas.

### 4. Hoja de credenciales

Usuarios, contraseñas, dónde se guardan, quién tiene acceso. Se entrega al cliente y él decide si te deja copia. Si te la quedas, con permiso escrito y en un gestor de contraseñas, nunca en un cuaderno ni en el móvil.

### 5. Documentación técnica (para dentro de dos años)

Plano o croquis con ubicación de cada dispositivo, incluyendo los que quedan escondidos en falso techo o registros. Lista con modelo, número de serie, fecha de instalación y garantía. Tipo de pila de cada sensor. Direcciones IP fijas si las hay. Copia de la configuración exportada. Esto lo agradecerás tú mismo cuando vuelvas.

### 6. Formación en vivo, 30 minutos

Que el cliente haga las tres tareas más frecuentes con sus manos mientras tú miras, no que tú se lo enseñes. Si no es capaz de hacerlas solo, el diseño está mal y hay que simplificarlo, no formarle más.

### 7. Acta de entrega

Documento corto: fecha, alcance entregado, pruebas superadas, material entregado, garantía de mano de obra y su plazo, qué queda pendiente si hay algo, y firma de las dos partes. Con esto se emite la factura final.

## Formato exacto de la respuesta

1. **Guion de prueba de aceptación**: tabla con prueba, resultado esperado y casilla.
2. **Manual del usuario** por tareas, listo para imprimir.
3. **Hoja de emergencia** de una página.
4. **Hoja de credenciales** en blanco para rellenar.
5. **Documentación técnica** (inventario y croquis descrito).
6. **Acta de entrega** con el texto legal básico.
7. **Correo de entrega** para enviarlo todo, con el aviso de garantía y la oferta de mantenimiento.

## Errores típicos

- Entregar explicando por voz y sin dejar nada escrito.
- Manual escrito con vocabulario técnico que el cliente no entiende.
- No documentar dónde quedó el sensor escondido en el falso techo.
- No probar delante del cliente y descubrir el fallo dos semanas después.
- No hacer firmar nada y discutir después qué estaba incluido.
- Dejar tus credenciales personales como único acceso de administrador.

## Avisos honestos

- Si el cliente no sabe usar el sistema, el problema es el diseño. Simplifica: menos escenas, más automático, botones físicos donde haga falta.
- Deja escrito de qué dependen las funciones que usan la nube del fabricante: si esa empresa cierra el servicio, esa función desaparece y no es culpa tuya, pero tiene que saberlo antes.
- No prometas soporte ilimitado en el acta. Indica el plazo de garantía y remite a mantenimiento para lo demás.
