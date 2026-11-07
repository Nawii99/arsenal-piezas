# Embudo de playtest: dónde abandonan tus jugadores…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Tu juego manda eventos sencillos a una dirección web y cada mañana recibes un informe con qué porcentaje de jugadores llega a cada nivel y dónde se atascan.

## Qué es y qué hace

Flujo de n8n que expone una dirección web para recibir eventos sencillos del juego (nivel_iniciado, nivel_superado, muerte, salida) con un identificador anónimo de sesión. Cada mañana calcula qué porcentaje de jugadores llega a cada nivel y dónde se atascan, y envía el informe por correo. Entran los eventos en JSON sin nombres ni correos; sale una hoja con el embudo. Necesita n8n con URL pública y un secreto compartido.

## Cómo usarla

1. 1. Publica n8n con una URL accesible y crea el secreto
2. 2. Envía los eventos desde el juego sin nombres ni correos
3. 3. Revisa el embudo del día en el correo

## Cuándo usarla

Úsalo cuando tienes una demo o un acceso anticipado y quieres saber con datos en qué punto la gente se aburre o se atasca, sin montar un sistema de analíticas de pago.

## Cómo ganar dinero con ella

Sustituye a herramientas de telemetría de 50-200 € al mes y te dice qué nivel arreglar antes de gastar meses en contenido que nadie ve.

- Analítica de embudo para estudios que hacen una demo y quieren saber en qué nivel abandona la gente.
- Informe diario de retención para desarrolladores en acceso anticipado sin pagar herramientas de telemetría.
- Configuración de eventos anónimos para estudios que necesitan datos sin tratar datos personales.

**Precio orientativo:** 200–500 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Montas una dirección web que recibe eventos del juego (`nivel_iniciado`, `nivel_superado`, `muerte`, `salida`) y los guarda. Cada mañana un segundo flujo calcula el embudo y te lo manda por correo.
Para el desarrollador que está en fase de pruebas y necesita datos reales, pero no quiere meter SDKs de terceros ni líos de privacidad.

## Lo que necesitas antes
n8n accesible desde internet: auto-alojado con dominio, o n8n Cloud, o auto-alojado con un túnel. Necesitas una URL pública para el webhook.
Credenciales de Google Sheets OAuth2 y Gmail OAuth2.
Una hoja `eventos` con columnas: `momento`, `sesion`, `evento`, `nivel`, `segundos`, `version`.
Un identificador de sesión anónimo en el juego (un número aleatorio por partida). **No mandes nombres, correos ni IPs**: así te evitas casi todo el papeleo del RGPD.
Un secreto compartido: inventa una cadena tipo `mi-secreto-2026` y ponla en el juego y en el flujo.

## Los nodos, en orden (flujo 1: recogida)
1) **Webhook** — método POST, ruta `telemetria`, respuesta `Immediately` con código 200. Copia la URL de producción. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2) **IF** — comprueba que `{{ $json.body.token }}` es igual a tu secreto. Si no, no guardes nada.
3) **Code** — valida y limpia los campos.
4) **Google Sheets** (`Append Row`) — pestaña `eventos`.

## Los nodos, en orden (flujo 2: informe)
5) **Schedule Trigger** — `0 9 * * *`.
6) **Google Sheets** (`Get Row(s)`) — `Return All` activado.
7) **Code** — calcula el embudo por nivel.
8) **Gmail** (`Send`) — asunto `Embudo de playtest {{ $now.format('dd/MM') }}` con la tabla en el cuerpo.

## El trozo de código (nodo Code del flujo 1)
```javascript
const b = $json.body || {};
const permitidos = ['nivel_iniciado', 'nivel_superado', 'muerte', 'salida', 'partida_iniciada'];
if (!permitidos.includes(b.evento)) return [];
return [{ json: {
  momento: new Date().toISOString(),
  sesion: String(b.sesion || 'sin_id').slice(0, 40),
  evento: b.evento,
  nivel: Number(b.nivel) || 0,
  segundos: Math.min(Number(b.segundos) || 0, 86400),
  version: String(b.version || 'desconocida').slice(0, 20)
} }];
```

## El trozo de código (nodo Code del flujo 2)
```javascript
const hoy = new Date(Date.now() - 7 * 86400000).toISOString();
const filas = $input.all().map(i => i.json).filter(f => f.momento > hoy);
const niveles = {};
for (const f of filas) {
  const n = f.nivel;
  niveles[n] = niveles[n] || { iniciado: new Set(), superado: new Set(), muertes: 0, tiempo: [] };
  if (f.evento === 'nivel_iniciado') niveles[n].iniciado.add(f.sesion);
  if (f.evento === 'nivel_superado') { niveles[n].superado.add(f.sesion); niveles[n].tiempo.push(Number(f.segundos) || 0); }
  if (f.evento === 'muerte') niveles[n].muertes++;
}
const claves = Object.keys(niveles).map(Number).sort((a, b) => a - b);
const base = claves.length ? niveles[claves[0]].iniciado.size : 0;
const lineas = claves.map(n => {
  const d = niveles[n];
  const llegan = base ? Math.round(d.iniciado.size * 100 / base) : 0;
  const pasan = d.iniciado.size ? Math.round(d.superado.size * 100 / d.iniciado.size) : 0;
  const medio = d.tiempo.length ? Math.round(d.tiempo.reduce((a, b) => a + b, 0) / d.tiempo.length) : 0;
  return 'Nivel ' + n + ': llegan ' + llegan + '% | lo superan ' + pasan + '% | ' + d.muertes + ' muertes | ' + medio + ' s de media';
});
return [{ json: { informe: lineas.join('\n') || 'Sin datos esta semana', jugadores: base } }];
```

## Lo que manda el juego
El juego solo tiene que hacer un POST con este JSON: `{"token":"mi-secreto-2026","sesion":"a7f3c","evento":"nivel_iniciado","nivel":3,"segundos":0,"version":"0.4.2"}`
En Unity se hace con `UnityWebRequest.Post`; en Godot con `HTTPRequest.request` y método POST. Mándalo sin esperar respuesta para no frenar el juego.

## Cómo probarla
Antes de tocar el juego, prueba el webhook desde la consola: `curl -X POST TU_URL -H "Content-Type: application/json" -d '{"token":"mi-secreto-2026","sesion":"test1","evento":"nivel_iniciado","nivel":1}'`
Mete a mano media docena de eventos de dos sesiones distintas y lanza el flujo 2: los porcentajes tienen que cuadrar con lo que has metido.
Juega tú una partida completa con la build de pruebas y comprueba que aparecen las filas en la hoja.

## Qué puede salir mal
Google Sheets se atraganta si recibes miles de eventos por minuto: para un playtest pequeño va bien; si crece, cambia el destino a una base de datos como Postgres o Baserow.
Si el juego se cierra de golpe, el evento `salida` no llega. Manda un `latido` cada 60 segundos y así deduces el abandono por ausencia.
No guardes IP ni nombre de usuario. Y avisa en el juego de que recoges datos anónimos de partida: es lo correcto y lo legal.
Si dejas el webhook sin el token, cualquiera puede llenarte la hoja de basura.

## Cuánto cuesta
Gratis con n8n auto-alojado y Google Sheets. Una hoja aguanta millones de celdas, de sobra para un playtest.
Si necesitas n8n Cloud, vigila el contador de ejecuciones: cada evento es una ejecución. Agrupa varios eventos en un solo envío si el volumen sube.
