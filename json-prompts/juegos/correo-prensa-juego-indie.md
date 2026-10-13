# Correo a prensa y creadores de contenido con press kit mínim…

**Tipo:** JSON prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Prompt JSON que genera el correo corto para enviar tu juego a medios y youtubers, más el contenido mínimo del press kit (ficha, claves, capturas, contacto).

## Qué es y qué hace

Prompt JSON que pide a Claude un correo corto de presentación para medios y creadores de un juego, dos asuntos alternativos, la versión en inglés y el contenido mínimo del press kit (ficha, claves, capturas, contacto). Los datos que falten salen como [DATO PENDIENTE] en lugar de inventarse. Sirve para escribir muchos correos sin que parezcan plantilla.

## Cómo usarla

1. Rellena el bloque juego con datos reales
2. Indica el destinatario
3. Pide correo y press kit
4. Revisa que no haya datos inventados

## Cuándo usarla

Cuando tienes claves del juego o una demo y quieres escribir a prensa y creadores sin parecer spam ni dejarte datos fuera.

## Cómo ganar dinero con ella

Puedes ofrecerlo como servicio de «kit de prensa y primer envío» para indies que lanzan: press kit, lista de 20 contactos hecha a mano y correos redactados.

- Campaña de prensa para indies que lanzan en Steam o itch.io…
- Kit de prensa básico para estudios que van a un festival…
- Correos personalizados para creadores de contenido por lotes…

**Precio orientativo:** 30–150 € por lote. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "rol": "Escribes correos de presentación de videojuegos indie a medios y creadores de contenido. Escribes corto, concreto y sin adular. Sabes que un periodista o youtuber recibe decenas de correos al día y decide en cinco segundos.",
  "tarea": "Con los datos del juego, genera el correo de presentación, dos asuntos alternativos, la versión en inglés y el contenido mínimo del press kit. Si falta un dato, escríbelo como [DATO PENDIENTE] en lugar de inventarlo.",
  "juego": {
    "nombre": "[NOMBRE DEL JUEGO]",
    "gancho_en_una_frase": "[QUÉ HACE EL JUGADOR Y QUÉ LO HACE DISTINTO, SIN ADJETIVOS]",
    "genero": "[GÉNERO Y A QUÉ JUEGO SE PARECE]",
    "plataformas": "[WINDOWS / MAC / LINUX / NAVEGADOR / ANDROID]",
    "tienda": "[ENLACE A LA PÁGINA DE ITCH.IO O STEAM]",
    "fecha_lanzamiento": "[FECHA O 'YA DISPONIBLE']",
    "precio": "[PRECIO EN EUROS O 'GRATIS']",
    "duracion": "[HORAS APROXIMADAS]",
    "estado": "[DEMO / EARLY ACCESS / VERSIÓN FINAL]",
    "que_tiene_ya": "[TRÁILER SÍ/NO, NÚMERO DE CAPTURAS, GIF SÍ/NO]"
  },
  "quien_envia": {
    "nombre": "[TU NOMBRE]",
    "estudio": "[NOMBRE DEL ESTUDIO O 'DESARROLLADOR EN SOLITARIO']",
    "ciudad": "[CIUDAD, ESPAÑA]",
    "contacto": "[CORREO DE CONTACTO]",
    "redes": "[ENLACES A REDES O 'NINGUNA']"
  },
  "destinatario": {
    "tipo": "[MEDIO ESCRITO / YOUTUBER / STREAMER / PODCAST]",
    "nombre": "[NOMBRE DEL MEDIO O DE LA PERSONA]",
    "por_que_le_escribo": "[QUÉ HA CUBIERTO ANTES QUE SE PARECE A MI JUEGO; SI NO LO SÉ, PONER 'NO LO SÉ']",
    "idioma": "[ESPAÑOL / INGLÉS / LOS DOS]"
  },
  "claves": {
    "tengo_claves_para_regalar": "[SÍ / NO]",
    "como_las_doy": "[CLAVE EN EL PROPIO CORREO / ENLACE A KEYMAILER O SIMILAR / A PETICIÓN]"
  },
  "reglas_del_correo": {
    "longitud_maxima": "120 palabras en el cuerpo, sin contar firma",
    "estructura": [
      "Línea 1: quién eres y qué es el juego en una frase.",
      "Línea 2: por qué se lo mandas a esa persona en concreto. Si el campo por_que_le_escribo es 'NO LO SÉ', escribir en su lugar una frase honesta y corta sobre a quién va dirigido el juego, sin fingir que conoces su trabajo.",
      "Línea 3: qué hay disponible ahora mismo (demo, clave, tráiler) y enlace.",
      "Línea 4: si hay clave, la clave o cómo pedirla. Sin condiciones ni 'a cambio de'.",
      "Cierre: una línea. Nada de 'quedo a la espera de tu respuesta'."
    ],
    "prohibido": [
      "Adjetivos de venta: increíble, único, revolucionario, adictivo.",
      "Pedir que cubra el juego o que ponga una fecha.",
      "Adjuntar archivos pesados; todo va por enlace.",
      "Poner varios destinatarios en el mismo correo.",
      "Firmas largas o frases motivacionales."
    ]
  },
  "press_kit_minimo": {
    "que_es": "Una página web o carpeta pública (Google Drive o Notion valen) con todo lo que un medio necesita sin tener que preguntar.",
    "contenido_obligatorio": [
      "Ficha: nombre, estudio, fecha, precio, plataformas, enlace a tienda, contacto.",
      "Descripción corta (una frase) y larga (un párrafo).",
      "Tráiler descargable en 1080p, no solo enlace a YouTube.",
      "Mínimo 6 capturas a 1920x1080 en PNG, momentos de juego real.",
      "Logo del juego y del estudio en PNG con fondo transparente.",
      "Dos o tres GIF cortos de juego para redes.",
      "Historia del estudio en tres frases, sin épica.",
      "Línea de créditos y licencias de assets de terceros si los hay.",
      "Permiso explícito para monetizar vídeos con el juego. Sin esta línea muchos creadores no lo tocan."
    ]
  },
  "formato_salida": {
    "asuntos": "Dos asuntos alternativos de menos de 60 caracteres. Uno con el nombre del juego y el género; otro con el gancho.",
    "correo_espanol": "Texto completo listo para pegar, con [CLAVE] donde vaya la clave.",
    "correo_ingles": "Solo si idioma incluye inglés. Traducción natural, no literal.",
    "press_kit": "Lista de comprobación con lo que ya tiene el usuario marcado y lo que falta marcado como pendiente, según el campo que_tiene_ya.",
    "aviso": "Una línea recordando que enviar el mismo correo a muchos contactos a la vez, o usar herramientas de envío masivo, hace que acabe en spa
```
