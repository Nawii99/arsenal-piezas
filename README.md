# Arsenal del Marketer · piezas

**4.659 piezas en español para trabajar con IA**: 538 skills, 515 comandos «/» y
625 subagentes para Claude Code, 366 prompts, 1852 JSON prompts y
763 recetas de automatización (n8n, Make y Zapier). Escritas para autónomos, pequeños negocios y
quien empieza, con qué hace cada una, cómo se usa, cuándo conviene y cómo ganar dinero con ella.

[English version](README.en.md) · Licencia del contenido: [CC BY 4.0](LICENSE) · Código: [MIT](LICENSE-CODE)

**Ya en inglés:** 147 de las mejores piezas, en [en/](en/README.md) y en el plugin `arsenal-en`.

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
/plugin install arsenal-ventas-embudo@arsenal
```

Cambia `arsenal-ventas-embudo` por el que quieras:

| Área y tema | Plugin | Qué trae |
|---|---|---|
| Webs animadas | `arsenal-animacion` | 1 skill, 1 subagente |
| Música y audio | `arsenal-audio` | 10 skills, 9 comandos /, 7 subagentes |
| Backend | `arsenal-backend` | 24 comandos /, 4 skills, 3 subagentes |
| Calidad y tests | `arsenal-calidad` | 4 skills, 2 comandos /, 1 subagente |
| Contenido | `arsenal-contenido` | 13 subagentes, 4 skills, 1 comando / |
| Datos | `arsenal-datos` | 5 skills, 5 subagentes |
| Datos e IA · Agentes y chatbots | `arsenal-datos-ia-agentes` | 14 comandos /, 7 subagentes, 1 skill |
| Datos e IA · Datos y documentos | `arsenal-datos-ia-datos` | 11 comandos /, 6 subagentes, 6 skills |
| Datos e IA · Más de datos e ia | `arsenal-datos-ia-varios` | 5 subagentes, 5 comandos /, 1 skill |
| Diseño · Impresión y producto | `arsenal-diseno-impresion` | 3 subagentes, 3 comandos /, 1 skill |
| Diseño · Marca y sistema visual | `arsenal-diseno-marca` | 12 subagentes, 9 comandos /, 4 skills |
| Diseño · Más de diseño | `arsenal-diseno-varios` | 8 subagentes, 3 comandos /, 2 skills |
| Documentos | `arsenal-documentos` | 25 subagentes, 4 skills |
| Tienda por internet | `arsenal-ecommerce` | 8 skills, 7 comandos /, 5 subagentes |
| Formación · Alumnos y seguimiento | `arsenal-educacion-alumnos` | 10 skills, 8 comandos /, 7 subagentes |
| Formación · Cursos y materiales (1) | `arsenal-educacion-cursos-1` | 19 comandos /, 13 skills |
| Formación · Cursos y materiales (2) | `arsenal-educacion-cursos-2` | 18 subagentes, 4 skills |
| Formación · Evaluación y corrección | `arsenal-educacion-evaluacion` | 10 comandos /, 9 skills, 9 subagentes |
| Formación · Vender formación | `arsenal-educacion-negocio` | 3 skills, 1 comando / |
| Formación · Más de formación | `arsenal-educacion-varios` | 5 skills, 4 subagentes |
| Empleo y currículum · Currículum y candidaturas (1) | `arsenal-empleo-cv-1` | 22 comandos /, 5 skills |
| Empleo y currículum · Currículum y candidaturas (2) | `arsenal-empleo-cv-2` | 14 skills, 9 subagentes |
| Empleo y currículum · Entrevistas y sueldo | `arsenal-empleo-entrevistas` | 4 comandos /, 3 subagentes, 2 skills |
| Empleo y currículum · Más de empleo y currículum | `arsenal-empleo-varios` | 3 comandos /, 2 skills |
| Finanzas · Facturas y cobros | `arsenal-finanzas-cobros` | 18 comandos /, 7 subagentes, 3 skills |
| Finanzas · Gastos y precios | `arsenal-finanzas-gastos` | 12 comandos /, 11 subagentes, 1 skill |
| Finanzas · Impuestos | `arsenal-finanzas-impuestos` | 7 subagentes, 5 skills, 4 comandos / |
| Finanzas · Más de finanzas | `arsenal-finanzas-varios` | 10 subagentes, 7 comandos / |
| Foto e imagen · Archivos y publicación | `arsenal-foto-archivos` | 6 comandos /, 4 subagentes, 1 skill |
| Foto e imagen · Imágenes con IA (1) | `arsenal-foto-ia-1` | 21 comandos /, 9 skills |
| Foto e imagen · Imágenes con IA (2) | `arsenal-foto-ia-2` | 14 subagentes, 3 skills |
| Foto e imagen · Fotos de producto | `arsenal-foto-producto` | 10 subagentes, 9 comandos /, 4 skills |
| Foto e imagen · Retrato y marca | `arsenal-foto-retrato` | 7 comandos /, 2 skills, 2 subagentes |
| Foto e imagen · Más de foto e imagen | `arsenal-foto-varios` | 9 subagentes, 5 skills, 3 comandos / |
| Infraestructura | `arsenal-infraestructura` | 2 skills, 1 subagente |
| IoT y hardware · Domótica (1) | `arsenal-iot-domotica-1` | 15 skills, 9 comandos / |
| IoT y hardware · Domótica (2) | `arsenal-iot-domotica-2` | 16 subagentes, 3 skills |
| IoT y hardware · Instalaciones para clientes | `arsenal-iot-instalaciones` | 12 comandos /, 6 subagentes, 3 skills |
| IoT y hardware · Sensores y cámaras (1) | `arsenal-iot-sensores-1` | 11 skills, 8 comandos / |
| IoT y hardware · Sensores y cámaras (2) | `arsenal-iot-sensores-2` | 10 subagentes, 3 skills |
| IoT y hardware · Más de iot y hardware | `arsenal-iot-varios` | 5 subagentes, 4 comandos /, 3 skills |
| Videojuegos y 3D · Modelos, texturas y assets (1) | `arsenal-juegos-assets-1` | 13 comandos /, 11 skills |
| Videojuegos y 3D · Modelos, texturas y assets (2) | `arsenal-juegos-assets-2` | 10 subagentes, 7 skills |
| Videojuegos y 3D · Desarrollo y pruebas | `arsenal-juegos-desarrollo` | 7 comandos /, 4 skills, 2 subagentes |
| Videojuegos y 3D · Encargos para clientes | `arsenal-juegos-encargos` | 3 subagentes, 3 comandos /, 2 skills |
| Videojuegos y 3D · Más de videojuegos y 3d (1) | `arsenal-juegos-varios-1` | 16 skills, 3 comandos / |
| Videojuegos y 3D · Más de videojuegos y 3d (2) | `arsenal-juegos-varios-2` | 17 subagentes, 1 skill |
| Videojuegos y 3D · Publicar y vender juegos | `arsenal-juegos-vender` | 14 comandos /, 8 subagentes, 3 skills |
| Legal y contratos | `arsenal-legal` | 9 skills, 7 comandos /, 6 subagentes |
| Marketing · Campañas y anuncios (1) | `arsenal-marketing-campanas-1` | 13 skills, 4 comandos / |
| Marketing · Campañas y anuncios (2) | `arsenal-marketing-campanas-2` | 9 subagentes, 6 skills |
| Marketing · Clientes y reseñas | `arsenal-marketing-clientes` | 11 subagentes, 6 skills |
| Marketing · Contenido y redes | `arsenal-marketing-contenido` | 10 subagentes, 5 skills, 2 comandos / |
| Marketing · Medir y mejorar | `arsenal-marketing-medicion` | 7 subagentes, 5 skills |
| Marketing · Email y mensajes | `arsenal-marketing-mensajes` | 18 skills, 7 subagentes, 2 comandos / |
| Marketing · Más de marketing | `arsenal-marketing-varios` | 3 skills, 2 comandos / |
| Móvil · Pruebas, permisos y privacidad | `arsenal-movil-calidad` | 6 skills, 6 subagentes, 4 comandos / |
| Móvil · Pantallas y experiencia | `arsenal-movil-experiencia` | 11 comandos /, 10 skills, 9 subagentes |
| Móvil · Apps web instalables | `arsenal-movil-instalable` | 5 comandos /, 3 skills, 3 subagentes |
| Móvil · Publicar en las tiendas (1) | `arsenal-movil-tiendas-1` | 13 skills, 13 comandos /, 2 subagentes |
| Móvil · Publicar en las tiendas (2) | `arsenal-movil-tiendas-2` | 20 subagentes |
| Móvil · Más de móvil | `arsenal-movil-varios` | 7 comandos /, 3 skills, 2 subagentes |
| Negocio · Clientes y atención | `arsenal-negocio-clientes` | 3 subagentes, 3 skills |
| Negocio · Cobros y facturas (1) | `arsenal-negocio-cobros-1` | 20 skills |
| Negocio · Cobros y facturas (2) | `arsenal-negocio-cobros-2` | 19 subagentes, 2 skills |
| Negocio · Plan y estrategia (1) | `arsenal-negocio-estrategia-1` | 19 skills, 3 comandos / |
| Negocio · Plan y estrategia (2) | `arsenal-negocio-estrategia-2` | 17 subagentes, 4 skills |
| Negocio · Plan y estrategia (3) | `arsenal-negocio-estrategia-3` | 22 subagentes |
| Negocio · Operaciones y equipo | `arsenal-negocio-operaciones` | 4 subagentes, 2 skills |
| Negocio · Precios y oferta | `arsenal-negocio-precios` | 10 subagentes, 4 skills, 1 comando / |
| Negocio · Más de negocio | `arsenal-negocio-varios` | 5 subagentes, 2 skills |
| Productividad | `arsenal-productividad` | 1 skill, 1 subagente |
| Programación | `arsenal-programacion` | 1 skill, 1 subagente |
| Salud y deporte · Agenda y pacientes (1) | `arsenal-salud-agenda-1` | 14 comandos /, 8 skills |
| Salud y deporte · Agenda y pacientes (2) | `arsenal-salud-agenda-2` | 10 subagentes, 3 skills |
| Salud y deporte · Gestión del centro (1) | `arsenal-salud-centro-1` | 12 comandos /, 7 skills, 1 subagente |
| Salud y deporte · Gestión del centro (2) | `arsenal-salud-centro-2` | 13 subagentes |
| Salud y deporte · Comunicación con pacientes | `arsenal-salud-comunicacion` | 6 comandos /, 1 subagente |
| Salud y deporte · Hábitos y entrenamiento | `arsenal-salud-habitos` | 8 subagentes, 7 skills, 6 comandos / |
| Salud y deporte · Más de salud y deporte | `arsenal-salud-varios` | 9 subagentes, 7 skills, 2 comandos / |
| Ciberseguridad | `arsenal-seguridad` | 5 comandos /, 3 skills, 3 subagentes |
| Ventas · Captar clientes (1) | `arsenal-ventas-captar-1` | 18 skills, 3 comandos / |
| Ventas · Captar clientes (2) | `arsenal-ventas-captar-2` | 19 skills |
| Ventas · Captar clientes (3) | `arsenal-ventas-captar-3` | 14 subagentes, 5 skills |
| Ventas · Cerrar ventas (1) | `arsenal-ventas-cerrar-1` | 16 skills, 9 comandos / |
| Ventas · Cerrar ventas (2) | `arsenal-ventas-cerrar-2` | 17 subagentes, 2 skills |
| Ventas · Embudo y seguimiento | `arsenal-ventas-embudo` | 9 skills, 4 comandos /, 3 subagentes |
| Ventas · Fidelizar y vender más | `arsenal-ventas-fidelizar` | 7 subagentes, 7 comandos /, 4 skills |
| Ventas · Venta por internet | `arsenal-ventas-tienda` | 17 skills, 5 subagentes, 1 comando / |
| Ventas · Más de ventas | `arsenal-ventas-varios` | 3 skills, 1 comando / |
| Vídeo · Grabar | `arsenal-video-grabar` | 9 comandos /, 4 subagentes, 2 skills |
| Vídeo · Guion e ideas (1) | `arsenal-video-guion-1` | 20 comandos /, 3 subagentes, 2 skills |
| Vídeo · Guion e ideas (2) | `arsenal-video-guion-2` | 15 subagentes |
| Vídeo · Montaje | `arsenal-video-montaje` | 6 subagentes, 6 comandos /, 3 skills |
| Vídeo · Subtítulos y transcripción | `arsenal-video-subtitulos` | 4 subagentes, 2 comandos / |
| Vídeo · Más de vídeo | `arsenal-video-varios` | 11 subagentes, 4 comandos / |
| Web · Legal, privacidad y accesibilidad | `arsenal-web-legal` | 11 comandos /, 4 subagentes, 4 skills |
| Web · Mantenimiento de la web | `arsenal-web-mantenimiento` | 9 comandos /, 3 subagentes, 1 skill |
| Web · Más de web | `arsenal-web-varios` | 8 comandos /, 7 subagentes, 1 skill |

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
