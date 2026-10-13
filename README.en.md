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
/plugin install arsenal-marketing@arsenal
```

| Area | Plugin |
|---|---|
| Animated web | `arsenal-animacion` |
| Music & audio | `arsenal-audio` |
| Backend | `arsenal-backend` |
| Quality & testing | `arsenal-calidad` |
| Content | `arsenal-contenido` |
| Data | `arsenal-datos` |
| Data & AI | `arsenal-datos-ia` |
| Design | `arsenal-diseno` |
| Documents | `arsenal-documentos` |
| E-commerce | `arsenal-ecommerce` |
| Education | `arsenal-educacion` |
| Jobs & résumé | `arsenal-empleo` |
| Finance | `arsenal-finanzas` |
| Photo & image | `arsenal-foto` |
| Infrastructure | `arsenal-infraestructura` |
| IoT & hardware | `arsenal-iot` |
| Games & 3D | `arsenal-juegos` |
| Legal & contracts | `arsenal-legal` |
| Marketing | `arsenal-marketing` |
| Mobile | `arsenal-movil` |
| Business | `arsenal-negocio` |
| Productivity | `arsenal-productividad` |
| Programming | `arsenal-programacion` |
| Health & fitness | `arsenal-salud` |
| Cybersecurity | `arsenal-seguridad` |
| Sales | `arsenal-ventas` |
| Video | `arsenal-video` |
| Web | `arsenal-web` |

Single skill: `npx skills add https://github.com/Nawii99/arsenal-piezas --skill skill-name`. Manual: download the ZIP and copy the folders into
`~/.claude/skills/`, `~/.claude/commands/` or `~/.claude/agents/` (or run `scripts/instalar.sh marketing`).

## Prices

Some pieces include an indicative price. It is a made-up figure to give you an idea, not advice: research your own market.

## License and attribution

Content under [CC BY 4.0](LICENSE): use it, change it and charge your clients for your work, as long as you credit
*"Arsenal del Marketer (https://github.com/Nawii99/arsenal-piezas)"*. Code (plugin manifests and `scripts/`) under [MIT](LICENSE-CODE).
The name "Arsenal del Marketer" is not licensed as a trademark.
