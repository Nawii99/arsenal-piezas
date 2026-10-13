# Planificar una cámara de vigilancia casera con ESP32-CAM…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Planifica una cámara casera: qué comprar, cómo montar, acceso seguro al móvil y qué permite la ley en España grabar.

## Qué es y qué hace

Es un prompt que planifica una cámara de vigilancia casera con una ESP32-CAM para alguien sin experiencia: qué comprar, cómo montarla, acceso seguro desde el móvil y qué permite la ley en España grabar. Entra el lugar a vigilar y el entorno; sale un plan por pasos con frases cortas. Se usa en cualquier IA.

## Cómo usarla

1. Indica qué vigilar y dónde
2. Pega el prompt en tu IA
3. Sigue el plan y revisa la parte legal
4. Que lo revise un profesional

## Cuándo usarla

Quieres vigilar la entrada, el trastero o la terraza con una cámara casera y no sabes qué comprar, cómo montarla ni qué puedes grabar según la ley en España.

## Cómo ganar dinero con ella

Úsalo para preparar la propuesta de una cámara a vecinos o pequeños negocios y cobrar el montaje a [TU PRECIO]. Lo que puedes grabar en zonas comunes o vía pública lo confirma un profesional del derecho antes de instalar nada.

- Planes de cámara para locales pequeños que no quieren cableado, por plan…
- Instalación de cámaras de vigilancia para comunidades de vecinos pequeñas, por instalación…
- Auditoría de privacidad de cámaras de particulares, por revisión…

**Precio orientativo:** 30–60 € por plan. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Quiero montar una cámara de vigilancia casera con una placa ESP32-CAM y nunca he hecho nada con placas ni programado. Vivo en España. Actúa como un técnico que enseña a principiantes y guíame con frases cortas, sin dar nada por sabido.

Mi situación:
- Quiero vigilar: [QUÉ, P. EJ. LA ENTRADA DE MI PISO / EL TRASTERO / LA TERRAZA]
- El sitio es: [INTERIOR / EXTERIOR CUBIERTO / EXTERIOR A LA INTEMPERIE]
- Desde la cámara se vería también: [NADA MÁS / EL PASILLO DE LA COMUNIDAD / LA CALLE / EL JARDÍN DEL VECINO]
- Quiero verla desde: [MI MÓVIL ANDROID EN CASA / TAMBIÉN FUERA DE CASA]
- Ordenador: [WINDOWS / MAC / LINUX]
- Quiero grabar o solo ver en directo: [SOLO DIRECTO / GUARDAR FOTOS CUANDO HAYA MOVIMIENTO / GRABAR VÍDEO]
- Presupuesto orientativo: [CANTIDAD EN EUROS]

Dame esto, en este orden:

1. Antes de nada, la parte legal en España, en cinco líneas como máximo. Dime qué puedo grabar y qué no según lo que he marcado arriba: si la cámara ve zonas comunes de la comunidad, vía pública o propiedad de un vecino, explícame qué obligación tengo (aprobación de la comunidad, cartel informativo, no captar más vía pública de la imprescindible) y remíteme a la guía de videovigilancia de la AEPD para el detalle. Si lo que he marcado no se puede hacer legalmente, dilo antes de seguir y propón cómo recolocar la cámara.

2. Lista de compra con los nombres exactos para buscar en una tienda española. Quiero saber si necesito la placa base ESP32-CAM-MB (con USB incluido) o un adaptador USB-TTL aparte, y por qué. Advierte de que la ESP32-CAM necesita una fuente de 5 V con corriente suficiente y de que con un cargador flojo se reinicia sola. No inventes precios: pon [consultar] donde no lo sepas.

3. Paso a paso para subir el programa de ejemplo CameraWebServer desde Arduino IDE: qué placa elegir (AI Thinker ESP32-CAM), qué línea del código cambiar para mi modelo, dónde poner el WiFi (solo 2,4 GHz), qué hacer si se queda en "Connecting" y cómo saber la IP de la cámara por el Monitor Serie.

4. Cómo verla desde el móvil Android en casa: la dirección que tengo que abrir en el navegador y qué significa cada opción de la página de la cámara. Dime qué resolución poner para que no se corte.

5. Si he marcado que quiero verla fuera de casa: explícame por qué NO debo abrir el puerto en el router (la imagen viaja sin cifrar y cualquiera que encuentre la IP puede mirar), y cómo hacerlo con una VPN sencilla tipo Tailscale o WireGuard instalada en un PC o Raspberry de casa y en el móvil. Si no he marcado verla fuera, sáltate este punto.

6. Si he marcado guardar fotos con movimiento: propón la forma más simple, que es que la cámara avise por webhook a n8n y n8n pida la foto a `http://IP_CAMARA/capture` y la mande a Telegram. No me propongas montar un servidor de grabación todavía.

7. Límites reales de este montaje, sin adornos: calidad de imagen, que no ve de noche sin luz, que si se va la luz o el WiFi no hay cámara, y que no sustituye a un sistema profesional ni sirve como prueba fiable ante un seguro.

8. Qué NO hacer: una lista de seis errores típicos de principiante con la ESP32-CAM (alimentación floja, antena tapada con el dedo o con la caja, dejar la contraseña por defecto, apuntar a la calle, exponer el puerto a internet, subir el código con el WiFi a GitHub).

Reglas: no uses palabras técnicas sin explicarlas en la misma frase. Si algo lo desconoces o depende del modelo exacto, ponlo entre corchetes en vez de inventarlo. Si lo que pido no es legal o no es seguro, dímelo primero y con claridad, aunque el resto del plan se quede en espera.
```
