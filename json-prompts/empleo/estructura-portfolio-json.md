# Estructura completa de portfolio…

**Tipo:** JSON prompt · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Objeto JSON con todo el portfolio definido: secciones, fichas de proyecto, diseno, animacion al bajar, limites de peso y accesibilidad.

## Qué es y qué hace

JSON prompt que define un portfolio web de una sola página para un candidato que busca su primer empleo en tecnología en España: secciones, fichas de proyecto, diseño, animación al bajar, límites de peso y accesibilidad. Entrada: datos personales y enlaces, puesto objetivo, proyectos y nivel de 3D. Salida: especificación completa para generar el HTML. Se ejecuta en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Rellena datos y enlaces
2. Elige el nivel de 3D
3. Genera el HTML
4. Que lo revise un profesional

## Cuándo usarla

Cuando quieres que la IA te genere el portfolio entero de una vez y que no se invente ni la estructura ni las cifras.

## Cómo ganar dinero con ella

Es tu plantilla de produccion: rellenas los corchetes con los datos de cada cliente y sacas su portfolio en una tarde. 150 EUR por encargo.

- Especificación de portfolio por encargo para candidatos que quieren una web en una tarde.
- Plantilla de producción de portfolios para agencias pequeñas de empleo.
- Pack de portfolio y revisión para personas en reconversión profesional.

**Precio orientativo:** 120–180 € por encargo. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Disenar y escribir el portfolio web de una sola pagina de un candidato que busca su primer trabajo en tecnologia en Espana.",
  "idioma": "espanol de Espana, tuteando al lector, frases cortas",
  "candidato": {
    "nombre": "[TU NOMBRE Y APELLIDO]",
    "titular": "[QUE HACES EN 6 PALABRAS, EJ: AUTOMATIZO PROCESOS CON N8N E IA]",
    "ciudad": "[CIUDAD]",
    "disponibilidad": "[INMEDIATA / 15 DIAS]",
    "modalidad": ["presencial", "hibrido", "remoto"],
    "enlaces": {
      "github": "[URL]",
      "linkedin": "[URL]",
      "email": "[EMAIL]",
      "cv_pdf": "[URL DEL PDF]"
    },
    "es_reconversion": true,
    "de_donde_viene": "[SECTOR ANTERIOR, EJ: HOSTELERIA]"
  },
  "objetivo": {
    "puesto": "[PUESTO EXACTO DE LA OFERTA]",
    "empresa_tipo": "[STARTUP / CONSULTORA / PRODUCTO / ADMINISTRACION]",
    "quien_lo_lee": ["reclutador sin perfil tecnico", "responsable tecnico del equipo"],
    "que_tiene_que_pensar_en_10_segundos": "Este sabe hacer cosas y las ha terminado."
  },
  "estructura": {
    "orden_de_secciones": ["portada", "que_hago", "proyectos", "como_trabajo", "sobre_mi", "contacto"],
    "portada": {
      "elementos": ["nombre", "titular", "ciudad y disponibilidad", "dos botones"],
      "botones": [
        {"texto": "Ver proyectos", "destino": "#proyectos", "estilo": "principal"},
        {"texto": "Descargar CV", "destino": "[URL DEL PDF]", "estilo": "secundario"}
      ],
      "prohibido": ["frases de coach", "lema generico tipo apasionado por la tecnologia"]
    },
    "que_hago": {
      "formato": "tres bloques cortos",
      "bloques": [
        {"titulo": "[HABILIDAD 1]", "una_linea": "[QUE RESUELVES CON ELLA]"},
        {"titulo": "[HABILIDAD 2]", "una_linea": "[QUE RESUELVES CON ELLA]"},
        {"titulo": "[HABILIDAD 3]", "una_linea": "[QUE RESUELVES CON ELLA]"}
      ]
    },
    "proyectos": {
      "cuantos": 4,
      "orden": "el mas parecido a la oferta primero",
      "ficha": {
        "titulo": "[NOMBRE DEL PROYECTO]",
        "una_linea": "[QUE HACE, SIN TECNICISMOS]",
        "problema": "[QUE ESTABA MAL ANTES]",
        "que_hice_yo": ["[ACCION 1]", "[ACCION 2]", "[ACCION 3]"],
        "resultado": {
          "metrica": "[QUE SE MIDIO]",
          "antes": "[NUMERO ANTES]",
          "despues": "[NUMERO DESPUES]",
          "como_lo_se": "[DE DONDE SALE EL DATO]"
        },
        "tecnologias": ["[TECNOLOGIA 1]", "[TECNOLOGIA 2]"],
        "enlaces": {"demo": "[URL O null]", "codigo": "[URL O null]", "video_30s": "[URL O null]"},
        "que_aprendi": "[UNA FRASE HONESTA]",
        "es_real": true
      }
    },
    "como_trabajo": {
      "pasos": ["[COMO EMPIEZAS UN ENCARGO]", "[COMO LO PRUEBAS]", "[COMO LO ENTREGAS]"],
      "por_que_esta_aqui": "Demuestra criterio, no solo herramientas."
    },
    "sobre_mi": {
      "longitud_maxima_palabras": 90,
      "incluye": ["de donde vienes", "que sabes hacer hoy", "que buscas"],
      "prohibido": ["mentir sobre anos de experiencia", "titulos que no tienes"]
    },
    "contacto": {
      "email_visible": true,
      "formulario": false,
      "motivo": "Sin servidor no hay formulario que funcione. Un mailto no se cae."
    }
  },
  "diseno": {
    "estilo": "sobrio, mucho aire, una sola tipografia de sistema",
    "modo_oscuro": "respeta prefers-color-scheme",
    "color_de_acento": "[HEX, EJ: #4F8DF7]",
    "animacion_al_bajar": {
      "activada": true,
      "tecnica_preferida": "IntersectionObserver + transiciones CSS",
      "alternativas": ["GSAP ScrollTrigger", "Three.js solo como fondo"],
      "efecto": "opacidad 0 a 1 y desplazamiento vertical de 24px",
      "escalonado_ms": 80,
      "respeta_prefers_reduced_motion": true
    },
    "tres_d": {
      "nivel": "bajo",
      "niveles_posibles": ["bajo", "medio", "alto"],
      "regla": "Si el 3D no aporta informacion, se queda en bajo.",
      "desactivar_si": ["ancho menor de 900px", "hardwareConcurrency menor que 4", "el CDN no responde"]
    }
  },
  "rendimiento": {
    "objetivo_carga_segundos": 2,
    "peso_maximo_kb": {"html": 60, "js": 300, "imagenes_total": 400},
    "reglas": [
      "un unico archivo index.html autonomo",
      "sin npm,
```
