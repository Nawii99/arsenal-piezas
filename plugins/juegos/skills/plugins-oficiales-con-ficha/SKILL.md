---
name: plugins-oficiales-con-ficha
description: Antes de añadir skills de terceros, comprueba si un plugin oficial de Claude Code ya cubre la tarea, verifica que viene del sitio oficial, lista lo que instala (comandos, skills, subagentes, hooks, MCP) y deja una ficha de verificación. Se activa cuando pides instalar un plugin o preparar Claude Code para un cliente que exige origen verificado.
---

# Plugins oficiales primero, con ficha de verificación

## Qué hace
Antes de instalar nada de terceros, mira si lo que necesitas ya lo cubre un plugin oficial, es decir, mantenido por Anthropic. Si lo cubre, lo revisa y deja constancia por escrito. Si no lo cubre, lo dice.
Dónde ponerla: guarda este texto como SKILL.md dentro de .claude/skills/plugins-oficiales-con-ficha/ de tu proyecto.
Cómo pedirla: «Necesito que Claude Code revise mis pull requests. Mira si hay un plugin oficial y hazme la ficha antes de instalar nada».

## Qué es un plugin y por qué hay que mirar dentro
Un plugin es un paquete que puede traer varias cosas a la vez:
- Comandos «/»: atajos que escribes tú.
- Skills: instrucciones que Claude activa solo cuando encajan.
- Subagentes: ayudantes con su propio encargo.
- Hooks: órdenes que se ejecutan solas cuando pasa algo, por ejemplo al guardar un archivo. Son lo más delicado: ejecutan cosas en tu ordenador sin preguntarte cada vez.
- MCP: conexiones con servicios externos como correo, calendario o tienda. Pueden leer y escribir datos de verdad.

## Pregunta antes de empezar
1. ¿Qué necesitas que haga Claude Code? Una frase, sin nombrar ningún plugin.
2. ¿Es para ti o para un cliente? Si es para un cliente: ¿tiene normas de seguridad o una lista de programas permitidos? ¿Quién es la persona que aprueba?
3. ¿Qué datos va a tocar? Código, documentos, clientes, datos personales. Si el cliente es un estudio de videojuegos, el código y las versiones sin publicar son confidenciales.
4. ¿Lo instalamos solo en este proyecto o para todo tu usuario? Por defecto, solo en el proyecto.
5. ¿Qué versión de Claude Code hay instalada? Que Claude Code lo compruebe él mismo.

## Paso a paso
1. Comprueba si Claude Code ya lo hace sin plugin. Muchas veces basta con una instrucción bien escrita.
2. Busca primero en el repositorio oficial de Claude Code (anthropics/claude-code, carpeta plugins) y en el menú de plugins del programa, que se abre con el comando /plugin. Si tu versión lo ha cambiado, pregunta a Claude Code cuál es la ruta actual.
3. Verifica el origen. La dirección tiene que ser exactamente la oficial, letra por letra. Hay copias con nombres casi iguales. Si llegaste por un enlace de un tercero, no te fíes: escribe tú la dirección.
4. Antes de instalar, lee el archivo plugin.json (dentro de la carpeta .claude-plugin del plugin) y la lista de archivos. Haz el inventario: comandos, skills, subagentes, hooks y MCP.
5. Marca como alerta cada hook, cada MCP y todo lo que use internet o claves. Explica en una frase qué haría cada uno.
6. Comprueba términos y licencia. Que sea oficial no significa que puedas revenderlo ni meterlo en cualquier producto.
7. Rellena la ficha y pide el visto bueno de la persona responsable.
8. Instala solo después de un sí claro. Prueba primero en una carpeta de pruebas, sin datos reales.
9. Si no hay plugin oficial que cubra la necesidad, dilo claro. Una skill de terceros pasa por una revisión más estricta, con esta misma ficha.
10. Tras cada actualización importante del plugin, vuelve a mirar qué trae. Una versión nueva puede incluir hooks nuevos.

## Qué devolver
Una ficha por plugin, con estos campos, uno por línea:
- Necesidad que cubre:
- URL original:
- Fecha de comprobación: [FECHA]
- Versión:
- Licencia o términos:
- Gratis, de pago o freemium:
- Qué incluye (comandos, skills, subagentes, hooks, MCP):
- Qué datos toca y adónde los envía:
- Riesgos y cómo se limitan:
- Instalado en: proyecto o usuario
- Quién lo aprobó y cuándo: [NOMBRE Y FECHA]
Si hay varios plugins, añade una tabla resumen: | Plugin | Hooks | MCP | Datos que toca | Aprobado |

## Qué NO hacer
- No des algo por bueno solo porque se llame oficial. Sigue haciendo la ficha.
- No instales con el modo que se salta los permisos (`--dangerously-skip-permissions`) ni se lo recomiendes a un cliente.
- No inventes nombres de plugins ni funciones. Si no aparece en la lista oficial, no lo des por existente.
- No instales nada en el ordenador de un cliente sin su permiso por escrito.
- No uses claves reales ni datos de clientes para las pruebas.
- No digas al cliente «certificado» ni «seguro». Di «origen verificado el [FECHA] contra [URL]».

## Qué revisa una persona
Quien responda de la seguridad o la informática del cliente (o tú, si es tu proyecto) aprueba la ficha antes de instalar.
Si el plugin toca datos personales, se revisa además con quien lleve la protección de datos.
Si hay contrato, un abogado mira qué se promete sobre seguridad.

Pieza revisada en octubre de 2026. Los plugins y sus menús cambian con las versiones: comprueba la ruta actual en tu Claude Code.
