# Notas de parche automáticas desde tus commits…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Recoge los commits de tu repositorio desde la última versión, los ordena por tipo y redacta unas notas de parche legibles que publica en Discord y te deja en borrador.

## Qué es y qué hace

Flujo de n8n que pide a GitHub los commits desde una fecha, los agrupa por prefijo (feat, fix, balance, art, perf) y redacta unas notas de parche en lenguaje de jugador con una IA de texto (Claude, Codex, Gemini o una IA local). Entra el repositorio con un token de solo lectura; sale un borrador que se publica en el canal de Discord del juego. Funciona en n8n Cloud o auto-alojado.

## Cómo usarla

1. 1. Escribe los commits con prefijo feat, fix o balance
2. 2. Conecta GitHub con un token de solo lectura
3. 3. Repasa el borrador antes de que salga en Discord

## Cuándo usarla

Úsalo cuando publicas actualizaciones a menudo, tus commits son legibles pero tus notas de parche llegan tarde, mal o directamente no llegan.

## Cómo ganar dinero con ella

Convierte 90 minutos de escribir notas de parche en 5 de repasarlas, y la comunidad se entera de lo que arreglas en vez de pensar que no haces nada.

- Notas de parche para estudios indie con acceso anticipado que publican actualizaciones cada semana o cada dos.
- Changelog para comunidades de juegos en Discord que se quejan de que no se enteran de lo que se arregla.
- Configuración de notas de versión para equipos que quieren ahorrar la hora de escribir cada parche.

**Precio orientativo:** 120–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Pide a GitHub los commits desde una fecha, los agrupa en «Novedades», «Arreglos» y «Ajustes de equilibrio» y redacta el texto en lenguaje de jugador, no de programador.
Para el estudio pequeño que trabaja en acceso anticipado y publica un parche cada semana o dos.

## Lo que necesitas antes
Un repositorio en GitHub (privado vale) y un token: `github.com/settings/tokens` > Fine-grained token > acceso de solo lectura al repo > permiso `Contents: Read`.
En n8n crea la credencial `GitHub API` con ese token.
Clave de la API de Anthropic (`console.anthropic.com`).
Un webhook de Discord del canal donde anuncias las actualizaciones.
Acostúmbrate a escribir los commits con prefijo: `feat:`, `fix:`, `balance:`, `art:`, `perf:`. Sin eso el agrupado sale peor, aunque el flujo lo aguanta.

## Los nodos, en orden
1) **Schedule Trigger** — `0 10 * * 4` (los jueves a las 10:00), o cámbialo a tu ritmo de parcheo.
2) **Code** — calcula la fecha de hace 7 días en formato ISO para pedírsela a GitHub.
3) **HTTP Request** — GET a `https://api.github.com/repos/TU_USUARIO/TU_REPO/commits?since={{ $json.desde }}&per_page=100`. Autenticación: `Predefined Credential Type > GitHub API`. Añade la cabecera `Accept: application/vnd.github+json`.
4) **Code** — agrupa los commits por prefijo y descarta los de mantenimiento.
5) **HTTP Request** — POST a `https://api.anthropic.com/v1/messages` con el listado agrupado, pidiendo las notas de parche en español de España.
6) **Discord** — publica el texto en el canal de anuncios.
7) **Gmail** (`Create Draft`) — te deja el mismo texto en borrador para que lo pegues en la sección de novedades de Steam tras repasarlo.

## El trozo de código (nodo Code, el primero)
```javascript
const d = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000);
return [{ json: { desde: d.toISOString() } }];
```

## El trozo de código (nodo Code, el segundo)
```javascript
const grupos = { feat: [], fix: [], balance: [], art: [], perf: [], otros: [] };
const ignorar = /^(chore|merge|wip|bump|ci|docs|refactor)/i;
for (const it of $input.all()) {
  const linea = (it.json.commit?.message || '').split('\n')[0].trim();
  if (!linea || ignorar.test(linea)) continue;
  const m = linea.match(/^(feat|fix|balance|art|perf)\s*[:\(]/i);
  const clave = m ? m[1].toLowerCase() : 'otros';
  grupos[clave].push(linea.replace(/^[a-z]+\s*(\([^)]*\))?\s*:\s*/i, ''));
}
const resumen = Object.entries(grupos)
  .filter(([, v]) => v.length)
  .map(([k, v]) => k.toUpperCase() + ':\n- ' + v.join('\n- '))
  .join('\n\n');
if (!resumen) return [];
return [{ json: { resumen, total: $input.all().length } }];
```

## Cómo probarla
Ejecuta el flujo a mano un día que hayas hecho commits y mira la salida del segundo Code: debe salir una lista limpia, sin `Merge branch`.
Compara las notas generadas con lo que habrías escrito tú. Si suenan a robot, añade en el prompt: «tono cercano, tuteando, sin palabras de programador, máximo 250 palabras».
Deja el borrador de Gmail sin enviar la primera semana y revisa a mano antes de publicar en Steam.

## Qué puede salir mal
Si esa semana no hay commits, el segundo Code devuelve lista vacía y el flujo se para solo: eso es lo correcto, no publiques un parche vacío.
La API de GitHub sin token limita a 60 peticiones por hora; con token subes a 5.000, así que usa siempre credencial.
Con más de 100 commits necesitas paginar: añade `&page=2` en un segundo HTTP Request o reduce la ventana a 3 días.
Ojo con filtrar nombres de ramas o rutas internas en las notas públicas: revisa el borrador antes de publicar.

## Cuánto cuesta
GitHub, Discord y n8n auto-alojado: gratis.
La API de Anthropic: unos 2-3 céntimos por parche. Un año entero de notas semanales no llega a 2 €.
