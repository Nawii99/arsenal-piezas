# Kit de producción de vídeo currículum para un cliente…

**Tipo:** JSON prompt · **Área:** Vídeo · **Licencia:** CC BY 4.0

Objeto JSON que, con el brief de un cliente y el guion aprobado, devuelve el kit de producción completo: guía de grabación con móvil, plan de edición en CapCut, lista de entregables y texto de acompañamiento.

## Qué es y qué hace

Objeto JSON que, con el brief de un cliente y el guion aprobado, devuelve el kit de producción completo: guía de grabación con móvil, plan de edición en CapCut, lista de entregables y texto de acompañamiento. Pensado para la parte de producción de un servicio de vídeo currículum. Sirve para entregar el pack sin escribir cada documento a mano.

## Cómo usarla

1. Rellena el brief y pega el guion aprobado
2. Genera el kit completo
3. Revisa entregables y texto
4. Envía al cliente tras tu revisión

## Cuándo usarla

Con el guion ya aprobado, quieres sacar de una vez la guía de grabación para el cliente y el plan de edición para ti.

## Cómo ganar dinero con ella

Es la parte de producción del servicio de vídeo currículum: vendes un pack que incluye la guía de grabación con móvil y la edición en CapCut, cobrado por pack [TU PRECIO]. Sirve a clientes que graban solos y no quieren ir a un estudio.

- Pack de producción de vídeo currículum para clientes que graban solos…
- Kit de grabación y edición como producto de precio cerrado…
- Acompañamiento por correo durante la grabación del vídeo…

**Precio orientativo:** 60–150 € por pack. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "rol": "Eres el productor de un servicio de vídeo currículum y vídeo de presentación profesional. El cliente graba con su móvil sin ayuda presencial y otra persona edita en CapCut. Escribes en español de España, tuteando, con frases cortas y sin promesas de resultados.",
  "tarea": "A partir del brief y del guion aprobado, genera el kit de producción completo para este cliente. No inventes datos: lo que falte lo marcas como [DATO PENDIENTE].",
  "brief_cliente": {
    "nombre": "[NOMBRE DEL CLIENTE]",
    "tipo_video": "[video_curriculum | presentacion_profesional]",
    "puesto_o_publico": "[OFERTA, PUESTO O TIPO DE CLIENTE AL QUE VA DIRIGIDO]",
    "plataforma_principal": "[linkedin | correo_reclutador | web_propia | infojobs]",
    "pack_contratado": "[basico | completo | dirigido]",
    "guion_aprobado": "[PEGA AQUÍ EL GUION CON SUS BLOQUES Y TIEMPOS]",
    "movil_del_cliente": "[ANDROID | IPHONE | NO LO SÉ]",
    "fecha_entrega_comprometida": "[DD/MM/AAAA]"
  },
  "salida_esperada": {
    "guia_grabacion_para_cliente": {
      "descripcion": "Documento que se envía al cliente tal cual. Debe poder seguirlo alguien que nunca ha grabado nada.",
      "secciones": [
        "Qué necesitas antes de empezar: móvil cargado, espacio libre de al menos 2 GB, soporte o pila de libros, ventana de frente, guion impreso o app de teleprompter",
        "Ajustes del móvil paso a paso para su sistema (Android o iPhone): resolución 1080p, 30 fps, bloqueo de exposición y enfoque tocando la pantalla, modo avión para que no entren llamadas, limpiar la lente",
        "Encuadre: orientación según plataforma, cámara a la altura de los ojos, cabeza y hombros con aire por encima, fondo limpio, cámara trasera mejor que la frontal",
        "Luz y sonido: ventana de frente y nunca detrás, sin luz de techo amarilla, habitación sin eco, grabar cuando no haya ruido de calle",
        "Cómo grabar cada bloque: tres tomas por bloque, dos segundos de silencio antes y después, decir el número de bloque y toma al principio, mirar a la lente y no a la pantalla",
        "Vestuario y aspecto: como iría a la entrevista o a ver a ese cliente, sin rayas finas ni logos, nada que brille",
        "Cómo enviarlo: subir todas las tomas a la carpeta compartida sin comprimir, nombrar archivos como bloque1-toma2, nunca por WhatsApp",
        "Errores que hacen repetir la grabación: leer con los ojos moviéndose de lado a lado, hablar muy rápido, cortar la toma nada más terminar la frase, cambiar de sitio entre bloques"
      ]
    },
    "plan_edicion_capcut": {
      "descripcion": "Instrucciones para quien edita, con el nombre exacto de la función en CapCut y el orden de trabajo.",
      "pasos": [
        "Crear proyecto con la relación de aspecto de la plataforma principal",
        "Importar tomas y marcar la mejor de cada bloque con criterio: la que suena natural, no la más perfecta",
        "Ordenar bloques según el guion, cortar los silencios y el número de toma al principio",
        "Subtítulos automáticos y revisión palabra por palabra: los nombres propios y las cifras se equivocan",
        "Rótulo inicial con nombre y puesto entre el segundo 1 y el 4, rótulo final con contacto en los últimos 5 segundos",
        "Ajuste de audio: normalizar voz, quitar ruido si hace falta, música solo del banco con licencia de CapCut y a volumen muy bajo, o ninguna",
        "Corrección básica de color si la piel sale amarilla o gris",
        "Exportar en 1080p, 30 fps, y una segunda versión con marca de agua para enviar antes del pago final"
      ],
      "reglas": [
        "Nada de transiciones llamativas ni efectos: es un vídeo currículum, no un reel",
        "Los cortes entre bloques se hacen en un cambio de frase, nunca a mitad de palabra",
        "Si una toma no vale y no hay otra, se pide regrabar ese bloque en vez de arreglarlo con trucos"
      ]
    },
    "entregables": {
      "descripcion": "Lista de archivos y textos que recibe el cliente, con el nombre de archivo exacto.",
      "incluir": [
        "Vídeo final en la relación de aspecto principal",
        "Segunda relación de aspecto solo si el pack es dirigido",
        "Miniatura en imagen
```
