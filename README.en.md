# Arsenal del Marketer · pieces

**4.659 ready-to-use AI pieces written in Spanish**: 538 skills, 515 slash commands and
625 subagents for Claude Code, 366 prompts, 1852 JSON prompts and
763 automation recipes (n8n, Make, Zapier), aimed at freelancers and small businesses.

[Versión en español](README.md) · Content license: [CC BY 4.0](LICENSE) · Code: [MIT](LICENSE-CODE)

The pieces are written in Spanish; Claude understands them and can answer in English if you ask it to.
Every piece has an English one-line description in [`catalogo.json`](catalogo.json) (`description_en`).

## Install in Claude Code

One plugin per area, so you only install what you need:

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-ventas-embudo@arsenal
```

| Area | Plugin |
|---|---|
| Animated web | `arsenal-animacion` |
| Music & audio | `arsenal-audio` |
| Backend | `arsenal-backend` |
| Quality & testing | `arsenal-calidad` |
| Content | `arsenal-contenido` |
| Data | `arsenal-datos` |
| Data & AI | `arsenal-datos-ia-agentes` |
| Data & AI | `arsenal-datos-ia-datos` |
| Data & AI | `arsenal-datos-ia-varios` |
| Design | `arsenal-diseno-impresion` |
| Design | `arsenal-diseno-marca` |
| Design | `arsenal-diseno-varios` |
| Documents | `arsenal-documentos` |
| E-commerce | `arsenal-ecommerce` |
| Education | `arsenal-educacion-alumnos` |
| Education | `arsenal-educacion-cursos-1` |
| Education | `arsenal-educacion-cursos-2` |
| Education | `arsenal-educacion-evaluacion` |
| Education | `arsenal-educacion-negocio` |
| Education | `arsenal-educacion-varios` |
| Jobs & résumé | `arsenal-empleo-cv-1` |
| Jobs & résumé | `arsenal-empleo-cv-2` |
| Jobs & résumé | `arsenal-empleo-entrevistas` |
| Jobs & résumé | `arsenal-empleo-varios` |
| Finance | `arsenal-finanzas-cobros` |
| Finance | `arsenal-finanzas-gastos` |
| Finance | `arsenal-finanzas-impuestos` |
| Finance | `arsenal-finanzas-varios` |
| Photo & image | `arsenal-foto-archivos` |
| Photo & image | `arsenal-foto-ia-1` |
| Photo & image | `arsenal-foto-ia-2` |
| Photo & image | `arsenal-foto-producto` |
| Photo & image | `arsenal-foto-retrato` |
| Photo & image | `arsenal-foto-varios` |
| Infrastructure | `arsenal-infraestructura` |
| IoT & hardware | `arsenal-iot-domotica-1` |
| IoT & hardware | `arsenal-iot-domotica-2` |
| IoT & hardware | `arsenal-iot-instalaciones` |
| IoT & hardware | `arsenal-iot-sensores-1` |
| IoT & hardware | `arsenal-iot-sensores-2` |
| IoT & hardware | `arsenal-iot-varios` |
| Games & 3D | `arsenal-juegos-assets-1` |
| Games & 3D | `arsenal-juegos-assets-2` |
| Games & 3D | `arsenal-juegos-desarrollo` |
| Games & 3D | `arsenal-juegos-encargos` |
| Games & 3D | `arsenal-juegos-varios-1` |
| Games & 3D | `arsenal-juegos-varios-2` |
| Games & 3D | `arsenal-juegos-vender` |
| Legal & contracts | `arsenal-legal` |
| Marketing | `arsenal-marketing-campanas-1` |
| Marketing | `arsenal-marketing-campanas-2` |
| Marketing | `arsenal-marketing-clientes` |
| Marketing | `arsenal-marketing-contenido` |
| Marketing | `arsenal-marketing-medicion` |
| Marketing | `arsenal-marketing-mensajes` |
| Marketing | `arsenal-marketing-varios` |
| Mobile | `arsenal-movil-calidad` |
| Mobile | `arsenal-movil-experiencia` |
| Mobile | `arsenal-movil-instalable` |
| Mobile | `arsenal-movil-tiendas-1` |
| Mobile | `arsenal-movil-tiendas-2` |
| Mobile | `arsenal-movil-varios` |
| Business | `arsenal-negocio-clientes` |
| Business | `arsenal-negocio-cobros-1` |
| Business | `arsenal-negocio-cobros-2` |
| Business | `arsenal-negocio-estrategia-1` |
| Business | `arsenal-negocio-estrategia-2` |
| Business | `arsenal-negocio-estrategia-3` |
| Business | `arsenal-negocio-operaciones` |
| Business | `arsenal-negocio-precios` |
| Business | `arsenal-negocio-varios` |
| Productivity | `arsenal-productividad` |
| Programming | `arsenal-programacion` |
| Health & fitness | `arsenal-salud-agenda-1` |
| Health & fitness | `arsenal-salud-agenda-2` |
| Health & fitness | `arsenal-salud-centro-1` |
| Health & fitness | `arsenal-salud-centro-2` |
| Health & fitness | `arsenal-salud-comunicacion` |
| Health & fitness | `arsenal-salud-habitos` |
| Health & fitness | `arsenal-salud-varios` |
| Cybersecurity | `arsenal-seguridad` |
| Sales | `arsenal-ventas-captar-1` |
| Sales | `arsenal-ventas-captar-2` |
| Sales | `arsenal-ventas-captar-3` |
| Sales | `arsenal-ventas-cerrar-1` |
| Sales | `arsenal-ventas-cerrar-2` |
| Sales | `arsenal-ventas-embudo` |
| Sales | `arsenal-ventas-fidelizar` |
| Sales | `arsenal-ventas-tienda` |
| Sales | `arsenal-ventas-varios` |
| Video | `arsenal-video-grabar` |
| Video | `arsenal-video-guion-1` |
| Video | `arsenal-video-guion-2` |
| Video | `arsenal-video-montaje` |
| Video | `arsenal-video-subtitulos` |
| Video | `arsenal-video-varios` |
| Web | `arsenal-web-legal` |
| Web | `arsenal-web-mantenimiento` |
| Web | `arsenal-web-varios` |

Single skill: `npx skills add https://github.com/Nawii99/arsenal-piezas --skill skill-name`. Manual: download the ZIP and copy the folders into
`~/.claude/skills/`, `~/.claude/commands/` or `~/.claude/agents/` (or run `scripts/instalar.sh marketing`).

## Prices

Some pieces include an indicative price. It is a made-up figure to give you an idea, not advice: research your own market.

## License and attribution

Content under [CC BY 4.0](LICENSE): use it, change it and charge your clients for your work, as long as you credit
*"Arsenal del Marketer (https://github.com/Nawii99/arsenal-piezas)"*. Code (plugin manifests and `scripts/`) under [MIT](LICENSE-CODE).
The name "Arsenal del Marketer" is not licensed as a trademark.
