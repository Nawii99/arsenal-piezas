# Arsenal del Marketer · piezas

**4.659 piezas en español para trabajar con IA**: 538 skills, 515 comandos «/» y
625 subagentes para Claude Code, 366 prompts, 1852 JSON prompts y
763 recetas de automatización (n8n, Make y Zapier). Escritas para autónomos, pequeños negocios y
quien empieza, con qué hace cada una, cómo se usa, cuándo conviene y cómo ganar dinero con ella.

[English version](README.en.md) · Licencia del contenido: [CC BY 4.0](LICENSE) · Código: [MIT](LICENSE-CODE)

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

Las skills, comandos y subagentes van en **un plugin por área**: instalas solo lo que necesitas.

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-marketing@arsenal
```

Cambia `arsenal-marketing` por el área que quieras:

| Área | Plugin | Qué trae |
|---|---|---|
| Webs animadas | `arsenal-animacion` | 1 skill, 1 subagente |
| Música y audio | `arsenal-audio` | 10 skills, 9 comandos /, 7 subagentes |
| Backend | `arsenal-backend` | 24 comandos /, 4 skills, 3 subagentes |
| Calidad y tests | `arsenal-calidad` | 4 skills, 2 comandos /, 1 subagente |
| Contenido | `arsenal-contenido` | 13 subagentes, 4 skills, 1 comando / |
| Datos | `arsenal-datos` | 5 skills, 5 subagentes |
| Datos e IA | `arsenal-datos-ia` | 30 comandos /, 18 subagentes, 8 skills |
| Diseño | `arsenal-diseno` | 23 subagentes, 15 comandos /, 7 skills |
| Documentos | `arsenal-documentos` | 25 subagentes, 4 skills |
| Tienda por internet | `arsenal-ecommerce` | 8 skills, 7 comandos /, 5 subagentes |
| Formación | `arsenal-educacion` | 44 skills, 38 subagentes, 38 comandos / |
| Empleo y currículum | `arsenal-empleo` | 29 comandos /, 23 skills, 12 subagentes |
| Finanzas | `arsenal-finanzas` | 41 comandos /, 35 subagentes, 9 skills |
| Foto e imagen | `arsenal-foto` | 46 comandos /, 39 subagentes, 24 skills |
| Infraestructura | `arsenal-infraestructura` | 2 skills, 1 subagente |
| IoT y hardware | `arsenal-iot` | 38 skills, 37 subagentes, 33 comandos / |
| Videojuegos y 3D | `arsenal-juegos` | 44 skills, 40 subagentes, 40 comandos / |
| Legal y contratos | `arsenal-legal` | 9 skills, 7 comandos /, 6 subagentes |
| Marketing | `arsenal-marketing` | 56 skills, 44 subagentes, 10 comandos / |
| Móvil | `arsenal-movil` | 42 subagentes, 40 comandos /, 35 skills |
| Negocio | `arsenal-negocio` | 80 subagentes, 56 skills, 4 comandos / |
| Productividad | `arsenal-productividad` | 1 skill, 1 subagente |
| Programación | `arsenal-programacion` | 1 skill, 1 subagente |
| Salud y deporte | `arsenal-salud` | 42 subagentes, 40 comandos /, 32 skills |
| Ciberseguridad | `arsenal-seguridad` | 5 comandos /, 3 skills, 3 subagentes |
| Ventas | `arsenal-ventas` | 93 skills, 46 subagentes, 25 comandos / |
| Vídeo | `arsenal-video` | 43 subagentes, 41 comandos /, 7 skills |
| Web | `arsenal-web` | 28 comandos /, 14 subagentes, 6 skills |

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
