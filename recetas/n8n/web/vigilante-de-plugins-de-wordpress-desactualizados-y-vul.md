# Vigilante de plugins de WordPress desactualizados y vul…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Consulta cada semana los plugins y temas instalados en tus WordPress, compara versiones con el repositorio oficial y cruza con la base de vulnerabilidades de WPScan y avisa de lo urgente.

## Qué es y qué hace

Cada semana pide a cada WordPress la lista de plugins y temas con sus versiones, la compara con la última publicada y consulta vulnerabilidades conocidas en la base de WPScan. Genera un informe priorizado, primero lo vulnerable y después lo desactualizado, y lo envía por email los lunes. Entrada: URLs, usuario con contraseña de aplicación y token de WPScan. Salida: hoja de informe y correo. Se monta en n8n.

## Cómo usarla

1. Crea contraseñas de aplicación en cada WordPress
2. Obtén el token gratuito de WPScan
3. Guarda las credenciales en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando mantienes varios WordPress de clientes y quieres saber qué actualizar primero, sin entrar uno por uno al escritorio de cada web.

## Cómo ganar dinero con ella

Ahorra 1-2 horas semanales de revisión manual y evita el hackeo típico por plugin sin parchear, cuya limpieza cuesta de 300 a 1.500 €.

- Auditoría de plugins vulnerables para agencias que mantienen WordPress de clientes.
- Informe mensual de seguridad de plugins para tiendas WooCommerce.
- Parcheo priorizado para pymes con web propia y sin equipo técnico.

**Precio orientativo:** 150–300 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Pide a cada WordPress la lista de plugins instalados con su versión, la compara con la última publicada y consulta si esa versión tiene vulnerabilidades conocidas.
Genera un informe priorizado: primero lo vulnerable, después lo desactualizado, y te lo manda por email los lunes.

## Lo que necesitas antes
- n8n.
- En cada WordPress: un usuario administrador con **Contraseña de aplicación** (Usuarios > Perfil > Contraseñas de aplicación). Guárdala; se usa como Basic Auth en n8n.
- Cuenta gratuita en wpscan.com para obtener un token de API: 25 consultas al día en el plan gratuito.
- Hoja `WordPress` con columnas `sitio`, `url`, `usuario`, `password_app` (mejor guarda las credenciales en n8n y en la hoja solo `sitio` y `url`).
- Hoja `Informe plugins` con `fecha`, `sitio`, `plugin`, `version`, `ultima`, `estado`, `vulnerabilidades`.

## Los nodos, en orden
1. **Schedule Trigger** — `Weeks`, lunes, 07:30, timezone `Europe/Madrid`.
2. **Google Sheets** — `Get Row(s)` de la hoja `WordPress`.
3. **Split In Batches** — Batch Size `1`.
4. **HTTP Request (plugins instalados)** — GET a `{{ $json.url }}/wp-json/wp/v2/plugins`, Authentication `Generic Credential Type > Basic Auth` con el usuario y la contraseña de aplicación. `On Error: Continue`.
5. **Code** — normaliza: saca `slug` (la parte antes de la barra de `plugin`), `version` y `name`.
6. **Split In Batches (plugins)** — Batch Size `1`.
7. **HTTP Request (repositorio)** — GET a `https://api.wordpress.org/plugins/info/1.0/{{ $json.slug }}.json`. Devuelve `version` (la última publicada). `On Error: Continue` porque los plugins de pago no están en el repositorio.
8. **HTTP Request (WPScan)** — GET a `https://wpscan.com/api/v3/plugins/{{ $json.slug }}` con header `Authorization: Token token=TU_TOKEN`. `On Error: Continue`.
9. **Code** — compara versiones y filtra las vulnerabilidades que afectan a la versión instalada (código abajo).
10. **Google Sheets** — `Append Row` en `Informe plugins`.
11. Al terminar el bucle, **Code** monta el resumen en HTML y **Gmail** lo envía con asunto `Estado de plugins - semana {{ $now.weekNumber }}`.

## El nodo Code de comparación
```js
function comparar(a, b) {
  const pa = String(a).split('.').map(Number), pb = String(b).split('.').map(Number);
  for (let i = 0; i < Math.max(pa.length, pb.length); i++) {
    const x = pa[i] || 0, y = pb[i] || 0;
    if (x > y) return 1; if (x < y) return -1;
  }
  return 0;
}
const salida = [];
for (const item of $input.all()) {
  const d = item.json;
  const instalada = d.version;
  const ultima = d.ultima || '';
  const vulns = (d.vulns || []).filter(v => !v.fixed_in || comparar(instalada, v.fixed_in) < 0);
  let estado = 'al dia';
  if (vulns.length > 0) estado = 'VULNERABLE';
  else if (ultima && comparar(instalada, ultima) < 0) estado = 'desactualizado';
  else if (!ultima) estado = 'no esta en el repositorio (plugin de pago)';
  salida.push({ json: { fecha: new Date().toISOString().slice(0,10), sitio: d.sitio, plugin: d.name, version: instalada, ultima, estado, vulnerabilidades: vulns.map(v => v.title).join(' | ') } });
}
return salida;
```

## Cómo probarla
- Prueba primero con un solo sitio y comprueba que el endpoint `/wp-json/wp/v2/plugins` responde: si da 401, la contraseña de aplicación está mal; si da 404, el usuario no es administrador.
- Instala en un WordPress de pruebas un plugin viejo a propósito y confirma que sale como `desactualizado`.
- Consulta a mano `https://wpscan.com/api/v3/plugins/contact-form-7` con tu token para validar el formato de la respuesta.

## Qué puede salir mal
- **Límite de WPScan**: 25 consultas al día en el plan gratuito. Con 5 webs y 20 plugins cada una te pasas. Solución: guarda en una hoja `cache_wpscan` la respuesta por slug con la fecha, y consulta la API solo si el dato tiene más de 7 días.
- **Endpoint de plugins bloqueado**: algunos plugins de seguridad (Wordfence, iThemes) cortan la REST API. Añade una excepción para tu IP o usa el plugin `WP REST API Authentication`.
- **Plugins de pago**: no aparecen en api.wordpress.org y siempre saldrán como `no esta en el repositorio`. Marca esos slugs en una lista para no ver ruido.
- **No actualices en automático**: este flujo solo avisa. Actualizar sin mirar rompe webs; deja la decisión en tus manos.

## Cuánto cuesta
n8n auto-alojado 0 €, WPScan gratis hasta 25 consultas al día (con la caché, suficiente), Sheets y Gmail gratis. Si gestionas más de 15 webs, WPScan cobra desde unos 25 $/mes.
