# Publicar binarios de Go o Rust con GitHub Actions…

**Tipo:** JSON prompt · **Área:** Infraestructura · **Licencia:** CC BY 4.0

Genera el flujo de integración continua y publicación: compila para Windows, Mac y Linux, saca la imagen Docker mínima y publica la release automáticamente.

## Qué es y qué hace

JSON prompt que crea el flujo de GitHub Actions para un proyecto en Go o Rust. Entra el lenguaje y la versión; sale un workflow de integración continua que compila para Windows, Mac y Linux, genera una imagen Docker mínima y publica la release automáticamente. Se usa en cualquier chat de IA: Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Copia el JSON
2. Indica lenguaje, versión y destinos
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Guarda el YAML en .github/workflows y haz una release de prueba

## Cuándo usarla

Úsalo cuando tienes un programa en Go o Rust funcionando en tu máquina y quieres que cada versión se compile, se pruebe y se publique sola.

## Cómo ganar dinero con ella

Quita el trabajo manual de cada publicación y los fallos de 'en mi máquina funcionaba' que retrasan entregas a clientes.

- Configuración de CI/CD para proyectos open source o internos de clientes…
- Automatización de releases multiplataforma para herramientas CLI…
- Puesta en marcha de integración continua para equipos pequeños…

**Precio orientativo:** 100–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Crear el flujo de integración continua y de publicación de un proyecto en Go o Rust con GitHub Actions",
  "rol": "Ingeniero de plataforma que automatiza compilación y publicación de binarios",
  "entradas": {
    "lenguaje": "[GO O RUST, CON LA VERSIÓN]",
    "repositorio": "[USUARIO/REPOSITORIO EN GITHUB]",
    "nombre_binario": "[NOMBRE DEL EJECUTABLE]",
    "plataformas": "[POR EJEMPLO: linux amd64, linux arm64, macos arm64, windows amd64]",
    "quiero_docker": "[SÍ O NO]",
    "registro_docker": "[GHCR, DOCKER HUB O NINGUNO]"
  },
  "flujos_a_generar": ["ci.yml: se lanza en cada push y pull request; formato, análisis estático, tests con detector de carreras en Go o clippy en Rust, y compilación", "release.yml: se lanza al publicar una etiqueta con formato vX.Y.Z; compila para todas las plataformas, genera los binarios comprimidos con sus sumas de verificación y crea la release de GitHub", "docker.yml o pasos dentro de release: construye y publica la imagen con etiquetas de versión y latest, solo si el usuario ha pedido Docker"],
  "buenas_practicas_obligatorias": ["fija las acciones a una versión concreta, no uses siempre la rama principal", "cachea módulos y compilación: actions/setup-go con cache o Swatinem/rust-cache", "compila estático en Go con CGO_ENABLED=0 y mete la versión y el commit en el binario con -ldflags", "en Rust, compila en release y usa el target adecuado; explica cuándo hace falta cross o un contenedor para arm64", "imagen Docker en dos etapas terminando en scratch o distroless para Go, y en debian slim para Rust si necesita glibc", "usuario no root en el contenedor y HEALTHCHECK si es un servicio", "permisos mínimos con el bloque permissions y uso del token que da GitHub, sin secretos escritos a mano", "genera y sube los ficheros de sumas de verificación con los binarios"],
  "formato_salida": {
    "orden": ["ficheros .github/workflows completos, uno por bloque de código con su ruta", "Dockerfile si procede, comentado línea a línea", ".dockerignore", "pasos manuales que el usuario tiene que hacer una vez, como activar permisos del repositorio", "cómo probarlo: crear una etiqueta de prueba y qué mirar si falla"]
  },
  "errores_tipicos_a_evitar": ["compilar sin tests previos", "publicar imágenes que pesan cientos de megas por copiar todo el repositorio", "guardar credenciales en el fichero del flujo", "olvidar el binario para arm64 y que no funcione en un Mac moderno o en un servidor barato"],
  "criterios_calidad": ["los ficheros YAML son válidos y no llevan pasos inventados", "la publicación funciona sin tocar n
```
