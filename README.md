# Arsenal del Marketer · piezas

**4.659 piezas en español para trabajar con IA**: 538 skills, 515 comandos «/» y
625 subagentes para Claude Code, 366 prompts, 1852 JSON prompts y
763 recetas de automatización (n8n, Make y Zapier). Escritas para autónomos, pequeños negocios y
quien empieza, con qué hace cada una, cómo se usa, cuándo conviene y cómo ganar dinero con ella.

[English version](README.en.md) · Licencia del contenido: [CC BY 4.0](LICENSE) · Código: [MIT](LICENSE-CODE)

**Ya en inglés:** 147 de las mejores piezas, en [en/](en/README.md) y en los plugins `arsenal-en-…`.

## Qué es cada cosa

| Tipo | Qué es | Dónde se usa |
|---|---|---|
| **Skill** | Una habilidad que Claude aprende y usa sola cuando la tarea lo pide. | Claude Code |
| **Comando «/»** | Una orden que lanzas tú escribiendo `/nombre` y tu caso. | Claude Code |
| **Subagente** | Un asistente especialista al que Claude le pasa una parte del trabajo. | Claude Code |
| **Prompt** | Un texto listo para pegar en cualquier IA, con `[corchetes]` para rellenar. | Claude, ChatGPT, Gemini o una IA local |
| **JSON prompt** | Un esquema para que la IA devuelva siempre el mismo formato. | Cualquier IA |
| **Receta de automatización** | Los pasos, nodo a nodo, para montar un flujo que trabaja solo. | n8n, Make o Zapier |

## Instalar en Claude Code (lo más rápido)

Las skills, comandos y subagentes van en **plugins pequeños, uno por área o, en las áreas grandes, uno por tema**:
instalas solo lo que necesitas. Cada pieza instalada ocupa un poco de memoria de Claude en todas tus conversaciones
(su nombre y su descripción), así que cada plugin se queda en unos 2.000 tokens como mucho.

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-ventas-alternativas@arsenal
```

Cambia `arsenal-ventas-alternativas` por el que quieras:

| Área y tema | Plugin | Qué trae |
|---|---|---|
| Webs animadas | `arsenal-animacion` | 1 skill, 1 subagente |
| Música y audio | `arsenal-audio` | 8 skills, 7 subagentes, 6 comandos / |
| Música y audio · Alternativas | `arsenal-audio-alternativas` | 3 comandos /, 2 skills |
| Backend | `arsenal-backend` | 20 comandos /, 4 skills, 2 subagentes |
| Backend · Alternativas | `arsenal-backend-alternativas` | 4 comandos /, 4 skills |
| Calidad y tests | `arsenal-calidad` | 4 skills, 1 subagente |
| Contenido | `arsenal-contenido` | 10 subagentes, 3 skills, 1 comando / |
| Datos | `arsenal-datos` | 5 skills, 5 subagentes |
| Datos e IA · Agentes y chatbots | `arsenal-datos-ia-agentes` | 6 comandos /, 4 skills, 3 subagentes |
| Datos e IA · Alternativas | `arsenal-datos-ia-alternativas` | 10 comandos /, 4 subagentes, 4 skills |
| Datos e IA · Automatizar con IA | `arsenal-datos-ia-automatizacion` | 4 comandos /, 2 subagentes |
| Datos e IA · Calidad y seguridad de la IA | `arsenal-datos-ia-calidad-ia` | 3 subagentes, 3 comandos / |
| Datos e IA · Extraer datos de currículums | `arsenal-datos-ia-extraer-cv` | 3 comandos /, 3 subagentes |
| Datos e IA · Pruebas y evaluación de la IA | `arsenal-datos-ia-pruebas-ia` | 3 subagentes, 1 comando /, 1 skill |
| Datos e IA · Más de datos e ia | `arsenal-datos-ia-varios` | 5 skills, 3 comandos /, 1 subagente |
| Diseño · Alternativas | `arsenal-diseno-alternativas` | 3 comandos /, 2 skills |
| Diseño · Impresión y producto | `arsenal-diseno-impresion` | 3 subagentes, 2 comandos / |
| Diseño · Interfaces de web y app | `arsenal-diseno-interfaz` | 4 subagentes, 1 skill |
| Diseño · Marca y sistema visual | `arsenal-diseno-marca` | 9 subagentes, 8 comandos /, 1 skill |
| Diseño · Más de diseño | `arsenal-diseno-varios` | 3 comandos /, 1 subagente, 1 skill |
| Documentos · Datos, facturas y hojas de cálculo | `arsenal-documentos-datos-hojas` | 6 subagentes |
| Documentos · Informes, plantillas y presentaciones | `arsenal-documentos-informes` | 4 subagentes, 1 skill |
| Documentos · Escaneos, PDF y archivo | `arsenal-documentos-pdf-archivo` | 6 subagentes |
| Documentos · Revisar y comparar documentos | `arsenal-documentos-revision-docs` | 5 subagentes |
| Documentos · Más de documentos | `arsenal-documentos-varios` | 5 skills, 1 subagente |
| Tienda por internet · Alternativas | `arsenal-ecommerce-alternativas` | 3 skills, 2 comandos /, 1 subagente |
| Tienda por internet · Textos legales y devoluciones | `arsenal-ecommerce-legal` | 4 skills, 1 comando / |
| Tienda por internet · Optimizar y vender más en la tienda | `arsenal-ecommerce-optimizacion` | 6 skills, 2 subagentes, 1 comando / |
| Tienda por internet · Plataformas y herramientas de tienda | `arsenal-ecommerce-plataformas` | 6 skills, 1 subagente |
| Tienda por internet · Tienda sin cuota mensual | `arsenal-ecommerce-sin-cuota` | 3 subagentes, 2 comandos /, 1 skill |
| Tienda por internet · Más de tienda por internet | `arsenal-ecommerce-varios` | 5 skills, 1 comando / |
| Formación · Alternativas (1) | `arsenal-educacion-alternativas-1` | 23 comandos /, 7 skills |
| Formación · Alternativas (2) | `arsenal-educacion-alternativas-2` | 13 skills, 3 subagentes |
| Formación · Alternativas (3) | `arsenal-educacion-alternativas-3` | 17 subagentes |
| Formación · Alumnos y seguimiento | `arsenal-educacion-alumnos` | 4 subagentes, 3 skills |
| Formación · Cursos y materiales | `arsenal-educacion-cursos` | 9 subagentes, 7 skills, 7 comandos / |
| Formación · Evaluación y corrección | `arsenal-educacion-evaluacion` | 4 subagentes, 4 comandos /, 3 skills |
| Formación · Vender formación | `arsenal-educacion-negocio` | 4 skills, 3 comandos /, 1 subagente |
| Formación · Más de formación | `arsenal-educacion-varios` | 7 skills, 3 subagentes, 1 comando / |
| Empleo y currículum · Alternativas | `arsenal-empleo-alternativas` | 11 comandos /, 6 skills, 3 subagentes |
| Empleo y currículum · Búsqueda y candidaturas | `arsenal-empleo-busqueda` | 5 comandos /, 4 skills, 3 subagentes |
| Empleo y currículum · Currículum y candidaturas | `arsenal-empleo-cv` | 6 skills, 3 subagentes, 3 comandos / |
| Empleo y currículum · Entrevistas y sueldo | `arsenal-empleo-entrevistas` | 3 comandos /, 2 subagentes, 1 skill |
| Empleo y currículum · Portfolio, web y perfiles online | `arsenal-empleo-portfolio` | 4 comandos /, 4 skills, 1 subagente |
| Empleo y currículum · Más de empleo y currículum | `arsenal-empleo-varios` | 5 subagentes, 3 comandos /, 2 skills |
| Finanzas · Alternativas (1) | `arsenal-finanzas-alternativas-1` | 19 comandos /, 6 skills, 4 subagentes |
| Finanzas · Alternativas (2) | `arsenal-finanzas-alternativas-2` | 16 subagentes |
| Finanzas · Facturas y cobros | `arsenal-finanzas-cobros` | 4 subagentes, 3 comandos /, 3 skills |
| Finanzas · Impuestos | `arsenal-finanzas-impuestos` | 4 comandos /, 2 subagentes |
| Finanzas · Finanzas personales e inversión | `arsenal-finanzas-personales` | 5 subagentes, 1 skill |
| Finanzas · Rentabilidad y costes | `arsenal-finanzas-rentabilidad` | 3 subagentes, 3 comandos / |
| Finanzas · Más de finanzas | `arsenal-finanzas-varios` | 4 subagentes, 4 comandos /, 1 skill |
| Foto e imagen · Alternativas (1) | `arsenal-foto-alternativas-1` | 16 comandos /, 7 skills, 1 subagente |
| Foto e imagen · Alternativas (2) | `arsenal-foto-alternativas-2` | 12 subagentes |
| Foto e imagen · Archivos y publicación | `arsenal-foto-archivos` | 7 subagentes, 1 comando / |
| Foto e imagen · Estilo visual de marca | `arsenal-foto-estilo` | 3 subagentes, 1 skill, 1 comando / |
| Foto e imagen · Imágenes con IA | `arsenal-foto-ia` | 5 comandos /, 2 skills, 2 subagentes |
| Foto e imagen · Fotos para marketplaces | `arsenal-foto-marketplace` | 3 comandos /, 2 subagentes, 1 skill |
| Foto e imagen · Fotos de producto | `arsenal-foto-producto` | 3 comandos /, 2 skills, 2 subagentes |
| Foto e imagen · Retrato y marca | `arsenal-foto-retrato` | 5 comandos /, 1 skill |
| Foto e imagen · Revisar calidad antes de publicar | `arsenal-foto-revision` | 2 subagentes, 2 comandos /, 1 skill |
| Foto e imagen · Más de foto e imagen | `arsenal-foto-varios` | 7 skills, 7 comandos /, 6 subagentes |
| Foto e imagen · Imágenes para la web y SEO | `arsenal-foto-web-imagenes` | 3 subagentes, 3 comandos /, 2 skills |
| Infraestructura | `arsenal-infraestructura` | 2 skills, 1 subagente |
| IoT y hardware · Alternativas (1) | `arsenal-iot-alternativas-1` | 16 comandos /, 9 skills |
| IoT y hardware · Alternativas (2) | `arsenal-iot-alternativas-2` | 9 subagentes, 6 skills |
| IoT y hardware · Alternativas (3) | `arsenal-iot-alternativas-3` | 14 subagentes |
| IoT y hardware · Domótica | `arsenal-iot-domotica` | 3 skills, 2 subagentes, 2 comandos / |
| IoT y hardware · Electrónica, firmware y montaje | `arsenal-iot-electronica` | 6 subagentes, 3 comandos /, 2 skills |
| IoT y hardware · Energía, baterías y consumo | `arsenal-iot-energia` | 3 skills, 2 comandos / |
| IoT y hardware · Instalaciones para clientes | `arsenal-iot-instalaciones` | 5 comandos /, 2 skills, 2 subagentes |
| IoT y hardware · Proyectos caseros con ESP32 | `arsenal-iot-proyectos` | 4 skills, 2 subagentes |
| IoT y hardware · Redes y conectividad IoT | `arsenal-iot-red` | 4 skills, 3 comandos /, 1 subagente |
| IoT y hardware · Sensores y cámaras | `arsenal-iot-sensores` | 5 skills, 2 comandos /, 1 subagente |
| Videojuegos y 3D · Alternativas (1) | `arsenal-juegos-alternativas-1` | 28 comandos /, 5 skills |
| Videojuegos y 3D · Alternativas (2) | `arsenal-juegos-alternativas-2` | 14 skills, 6 subagentes |
| Videojuegos y 3D · Alternativas (3) | `arsenal-juegos-alternativas-3` | 19 subagentes |
| Videojuegos y 3D · Modelos, texturas y assets | `arsenal-juegos-assets` | 9 skills, 3 subagentes, 2 comandos / |
| Videojuegos y 3D · Desarrollo y pruebas | `arsenal-juegos-desarrollo` | 6 subagentes, 5 skills, 4 comandos / |
| Videojuegos y 3D · Más de videojuegos y 3d | `arsenal-juegos-varios` | 5 skills, 2 comandos /, 1 subagente |
| Videojuegos y 3D · Publicar y vender juegos | `arsenal-juegos-vender` | 3 skills, 3 subagentes, 3 comandos / |
| Videojuegos y 3D · Visores y configuradores 3D | `arsenal-juegos-visores-3d` | 2 skills, 2 subagentes, 1 comando / |
| Legal y contratos | `arsenal-legal` | 9 skills, 7 subagentes, 6 comandos / |
| Legal y contratos · Alternativas | `arsenal-legal-alternativas` | 4 skills, 1 comando /, 1 subagente |
| Marketing · Alternativas | `arsenal-marketing-alternativas` | 7 subagentes, 3 comandos /, 2 skills |
| Marketing · Campañas y anuncios | `arsenal-marketing-campanas` | 13 skills, 4 subagentes, 2 comandos / |
| Marketing · Clientes y reseñas | `arsenal-marketing-clientes` | 8 subagentes, 2 skills |
| Marketing · Contenido y redes | `arsenal-marketing-contenido` | 7 subagentes, 5 skills, 2 comandos / |
| Marketing · Formularios y encuestas | `arsenal-marketing-formularios` | 6 skills |
| Marketing · Marca y propuesta de valor | `arsenal-marketing-marca` | 12 subagentes, 1 skill |
| Marketing · Medir y mejorar | `arsenal-marketing-medicion` | 5 skills, 3 subagentes |
| Marketing · Email y mensajes | `arsenal-marketing-mensajes` | 18 skills, 1 comando /, 1 subagente |
| Marketing · SEO y visibilidad en Google | `arsenal-marketing-seo` | 4 skills, 2 comandos / |
| Móvil · Alternativas (1) | `arsenal-movil-alternativas-1` | 25 comandos /, 5 skills |
| Móvil · Alternativas (2) | `arsenal-movil-alternativas-2` | 8 subagentes, 7 skills |
| Móvil · Alternativas (3) | `arsenal-movil-alternativas-3` | 15 subagentes |
| Móvil · Pruebas, permisos y privacidad | `arsenal-movil-calidad` | 3 skills, 2 subagentes, 2 comandos / |
| Móvil · Desarrollo de apps | `arsenal-movil-desarrollo` | 4 skills, 2 comandos /, 1 subagente |
| Móvil · Pantallas y experiencia | `arsenal-movil-experiencia` | 3 subagentes, 1 comando /, 1 skill |
| Móvil · Mini-apps y juegos de un archivo | `arsenal-movil-mini-apps` | 3 skills, 2 comandos /, 1 subagente |
| Móvil · Publicar en las tiendas | `arsenal-movil-tiendas` | 4 subagentes, 3 skills, 1 comando / |
| Móvil · Más de móvil | `arsenal-movil-varios` | 6 skills, 5 subagentes, 2 comandos / |
| Móvil · Web y formularios en el móvil | `arsenal-movil-web-movil` | 2 subagentes, 2 comandos /, 1 skill |
| Negocio · Alcance y especificación de proyectos | `arsenal-negocio-alcance` | 5 subagentes, 1 comando / |
| Negocio · Alternativas | `arsenal-negocio-alternativas` | 7 subagentes, 6 comandos /, 3 skills |
| Negocio · Clientes y atención | `arsenal-negocio-clientes` | 10 skills, 8 subagentes, 3 comandos / |
| Negocio · Cobros y facturas | `arsenal-negocio-cobros` | 8 skills, 2 subagentes |
| Negocio · Plan y estrategia | `arsenal-negocio-estrategia` | 8 subagentes, 2 skills |
| Negocio · Operaciones y equipo | `arsenal-negocio-operaciones` | 7 subagentes, 6 skills |
| Negocio · Pasarelas y medios de pago | `arsenal-negocio-pasarelas` | 4 subagentes, 4 skills |
| Negocio · Precios y oferta | `arsenal-negocio-precios` | 6 subagentes, 6 skills, 5 comandos / |
| Negocio · Revisar un plan y decidir mejor | `arsenal-negocio-revisar-plan` | 9 skills, 3 subagentes |
| Negocio · Vender software y SaaS | `arsenal-negocio-software` | 12 subagentes, 1 skill |
| Negocio · Validar ideas y mercado | `arsenal-negocio-validacion` | 3 skills, 3 subagentes |
| Negocio · Más de negocio | `arsenal-negocio-varios` | 3 skills, 1 comando / |
| Negocio · Vida personal, trabajo y comunidad | `arsenal-negocio-vida-personal` | 10 subagentes |
| Productividad | `arsenal-productividad` | 7 skills |
| Programación | `arsenal-programacion` | 3 skills, 1 subagente |
| Salud y deporte · Agenda y pacientes | `arsenal-salud-agenda` | 7 skills, 5 comandos /, 3 subagentes |
| Salud y deporte · Alternativas (1) | `arsenal-salud-alternativas-1` | 22 comandos /, 12 skills |
| Salud y deporte · Alternativas (2) | `arsenal-salud-alternativas-2` | 20 subagentes |
| Salud y deporte · Gestión del centro | `arsenal-salud-centro` | 3 subagentes, 2 skills, 2 comandos / |
| Salud y deporte · Comunicación con pacientes | `arsenal-salud-comunicacion` | 4 subagentes, 3 skills, 2 comandos / |
| Salud y deporte · Datos, consentimientos y RGPD | `arsenal-salud-datos` | 2 skills, 2 comandos /, 1 subagente |
| Salud y deporte · Entrenamiento físico | `arsenal-salud-entrenamiento` | 3 skills, 3 subagentes, 1 comando / |
| Salud y deporte · Hábitos y entrenamiento | `arsenal-salud-habitos` | 6 subagentes, 2 skills |
| Salud y deporte · Precios, bonos y cobros | `arsenal-salud-precios` | 2 skills, 2 subagentes, 1 comando / |
| Salud y deporte · Más de salud y deporte | `arsenal-salud-varios` | 5 comandos /, 2 subagentes, 1 skill |
| Ciberseguridad | `arsenal-seguridad` | 7 comandos /, 5 skills, 4 subagentes |
| Alternativas de varias áreas | `arsenal-varias-alternativas` | 6 subagentes, 3 comandos /, 2 skills |
| Ventas · Alternativas | `arsenal-ventas-alternativas` | 8 subagentes, 6 comandos /, 2 skills |
| Ventas · Captar clientes | `arsenal-ventas-captar` | 10 subagentes, 3 skills, 2 comandos / |
| Ventas · Cerrar ventas | `arsenal-ventas-cerrar` | 13 subagentes, 4 comandos /, 1 skill |
| Ventas · CRM y herramientas comerciales | `arsenal-ventas-crm` | 19 skills, 1 comando / |
| Ventas · Embudo y seguimiento | `arsenal-ventas-embudo` | 5 subagentes, 5 skills, 3 comandos / |
| Ventas · Fidelizar y vender más | `arsenal-ventas-fidelizar` | 3 subagentes, 3 comandos /, 2 skills |
| Ventas · Prospección y listas B2B | `arsenal-ventas-prospeccion` | 19 skills, 1 subagente, 1 comando / |
| Vídeo · Alternativas | `arsenal-video-alternativas` | 13 comandos /, 11 subagentes |
| Vídeo · Servicios de vídeo para clientes | `arsenal-video-clientes` | 3 subagentes, 3 comandos /, 1 skill |
| Vídeo · Grabar | `arsenal-video-grabar` | 3 comandos /, 2 subagentes |
| Vídeo · Guion e ideas | `arsenal-video-guion` | 5 comandos /, 2 subagentes, 2 skills |
| Vídeo · Vídeo con IA | `arsenal-video-ia-video` | 3 subagentes, 2 comandos /, 1 skill |
| Vídeo · Montaje | `arsenal-video-montaje` | 8 subagentes, 2 comandos /, 2 skills |
| Vídeo · Revisar y publicar | `arsenal-video-publicar` | 4 comandos /, 3 subagentes |
| Vídeo · Subtítulos y transcripción | `arsenal-video-subtitulos` | 4 subagentes, 2 comandos / |
| Vídeo · Más de vídeo | `arsenal-video-varios` | 6 subagentes, 5 comandos / |
| Vídeo · Vídeo currículum | `arsenal-video-videocv` | 3 subagentes, 2 skills, 2 comandos / |
| Web | `arsenal-web` | 13 subagentes, 11 comandos /, 2 skills |
| Web · Alternativas | `arsenal-web-alternativas` | 17 comandos /, 3 skills, 1 subagente |

No instales todos a la vez: cada skill ocupa un poco de memoria en cada conversación. Mejor dos o tres áreas.

**Otras formas:**

- **Solo una skill:** `npx skills add https://github.com/Nawii99/arsenal-piezas --skill nombre-de-la-skill`
- **A mano:** descarga el ZIP (botón verde «Code» → «Download ZIP») y copia la carpeta de la skill en `~/.claude/skills/`,
  el comando en `~/.claude/commands/` o el subagente en `~/.claude/agents/`. O usa `scripts/instalar.sh marketing`.
- **Prompts y JSON prompts:** abre el archivo, copia el texto y pégalo en tu IA. Índice en [prompts/](prompts/README.md)
  y [json-prompts/](json-prompts/README.md).
- **Recetas:** en [recetas/](recetas/README.md), por herramienta. Cada una dice qué necesitas, los nodos en orden y cómo probarla.

## Buscar lo que necesitas

Todo está en [`catalogo.json`](catalogo.json) con nombre, tipo, área, qué hace, cómo usarla, cuándo, cómo ganar dinero,
ideas de negocio y un precio orientativo. Por áreas: Formación (319), Negocio (299), Finanzas (298), Móvil (294), Ventas (277), Videojuegos y 3D (263), Salud y deporte (249), IoT y hardware (238), Foto e imagen (225), Web (221), Vídeo (220), Marketing (190), Backend (162), Diseño (154), Ciberseguridad (149), Datos (144), Datos e IA (137), Documentos (130), Empleo y currículum (126), Calidad y tests (124), Contenido (91), Programación (81), Productividad (68), Infraestructura (53), Legal y contratos (51), Música y audio (47), Tienda por internet (43), Webs animadas (6).

## Sobre los precios

Algunas piezas traen un **precio orientativo** de lo que se podría cobrar por el servicio. Es una cifra inventada para
hacerte una idea, no una recomendación ni una promesa de ingresos: investiga tu mercado y pon el precio que quieras.
Si una pieza no sirve para cobrar (solo ahorra tiempo o sirve para aprender), no lleva precio.

## Avisos

Las piezas de salud, legal, finanzas y ciberseguridad ayudan a preparar el trabajo, pero el resultado lo debe revisar
un profesional antes de entregarlo. Las de ciberseguridad son solo para sistemas propios o con permiso por escrito.

## Licencia y cómo citarnos

- **Contenido** (skills, comandos, subagentes, prompts, JSON prompts, recetas y textos): [CC BY 4.0](LICENSE).
  Puedes usarlo, cambiarlo y cobrar a tus clientes por lo que hagas con él, siempre que cites la fuente.
- **Código** (manifiestos de plugins y `scripts/`): [MIT](LICENSE-CODE).
- El nombre «Arsenal del Marketer» no se licencia: puedes citarlo, no usarlo como marca propia.

Cita sugerida: *«Basado en Arsenal del Marketer (https://github.com/Nawii99/arsenal-piezas), CC BY 4.0»*. Más en [ATRIBUCION.md](ATRIBUCION.md).
