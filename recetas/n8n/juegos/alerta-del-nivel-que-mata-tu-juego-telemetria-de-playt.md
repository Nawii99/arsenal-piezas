# Alerta del nivel que mata tu juego (telemetría de playt…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Tu juego envía eventos a un webhook, se acumulan en una hoja y cada día recibes un aviso si un nivel dispara los abandonos o las muertes. Para desarrolladores con playtest sin presupuesto.

## Qué es y qué hace

Recibe eventos de tu juego por webhook (nivel empezado, nivel terminado, muerte, salida), los guarda en una hoja y cada mañana calcula por nivel los abandonos, las muertes medias y el tiempo medio. Si un nivel baja de un porcentaje de finalización o supera un número de muertes, avisa por Telegram. Entrada: eventos JSON; salida: resumen diario y alertas. Se monta en n8n con Sheets y Telegram.

## Cómo usarla

1. Crear el webhook y la hoja con las pestañas eventos y resumen
2. Enviar eventos de prueba desde el juego
3. Fijar los umbrales de aviso
4. Activar el resumen diario

## Cuándo usarla

Cuando tengas una demo o early access con jugadores reales y no sepas en qué punto exacto se aburren o se atascan, pero no quieras pagar una herramienta de analítica.

## Cómo ganar dinero con ella

Sustituye una suscripción de analítica de juego de 50-200 €/mes y te ahorra rehacer niveles a ciegas.

- Montar telemetría básica para estudios indie que hacen playtest sin pagar analítica.
- Ofrecer informes de dificultad por nivel antes de un acceso anticipado.
- Vender un tablero de alertas por nivel a pequeñas editoras de juegos móviles.

**Precio orientativo:** 200–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recibe eventos sencillos que manda tu juego (nivel_empezado, nivel_terminado, muerte, salida_del_juego) en una dirección web, los guarda en una hoja de cálculo y cada mañana calcula por nivel: cuántos entran, cuántos lo terminan, muertes medias y tiempo medio.
Si un nivel baja de cierto porcentaje de finalización o supera cierta media de muertes, te llega un aviso por Telegram con los números. Para desarrolladores indie en playtest, demo de Steam Next Fest o acceso anticipado.

## Lo que necesitas antes
n8n con una URL accesible desde internet (auto-alojado con dominio y HTTPS, o n8n Cloud). Si pruebas en local, usa la URL de test que da el nodo Webhook mientras el editor está abierto.
Cuenta de Google con Sheets API y una hoja «Telemetría» con dos pestañas: «eventos» (columnas: ts, sesion, evento, nivel, valor, version, plataforma) y «resumen».
Bot de Telegram con su token y tu chat_id.
Un identificador de sesión anónimo en tu juego: genera un GUID al arrancar y guárdalo; no mandes nunca nombres, correos ni IP, así te ahorras problemas de RGPD.
Un secreto compartido: inventa una cadena larga y ponla en el juego y en n8n para que nadie te llene la hoja de basura.

## El código en tu juego (Unity, C#)
```csharp
using UnityEngine; using UnityEngine.Networking; using System.Collections;
public class Telemetria : MonoBehaviour {
  const string URL = "https://tu-n8n.com/webhook/telemetria";
  const string SECRETO = "pon-aqui-una-cadena-larga";
  public static string sesion = System.Guid.NewGuid().ToString();
  public static void Enviar(string evento, string nivel, float valor) {
    var json = JsonUtility.ToJson(new Datos { sesion = sesion, evento = evento, nivel = nivel, valor = valor, version = Application.version, plataforma = Application.platform.ToString() });
    var req = new UnityWebRequest(URL, "POST");
    req.uploadHandler = new UploadHandlerRaw(System.Text.Encoding.UTF8.GetBytes(json));
    req.SetRequestHeader("Content-Type", "application/json");
    req.SetRequestHeader("X-Secreto", SECRETO);
    req.SendWebRequest();
  }
  [System.Serializable] class Datos { public string sesion, evento, nivel, version, plataforma; public float valor; }
}
```

## Los nodos, en orden (flujo 1: recogida)
**Webhook** — HTTP Method: POST, Path: `telemetria`, Respond: Immediately, Response Code: 200. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
**IF** — `{{$json.headers['x-secreto']}}` igual a tu secreto. La rama false no hace nada.
**Code** — normaliza y añade la marca de tiempo: `return {json:{ts:new Date().toISOString(), sesion:$json.body.sesion, evento:$json.body.evento, nivel:$json.body.nivel, valor:$json.body.valor, version:$json.body.version, plataforma:$json.body.plataforma}};`
**Google Sheets** — Append Row en la pestaña «eventos», mapeo manual columna a columna.

## Los nodos, en orden (flujo 2: informe diario)
**Schedule Trigger** — Cron: `0 8 * * *` con Timezone Europe/Madrid en los ajustes del workflow.
**Google Sheets** — Get Row(s) de «eventos», Options: Return All activado.
**Code** — agrupa por nivel y calcula (código abajo).
**Google Sheets** — Append Row en «resumen» con la foto del día.
**Filter** — `{{$json.alarma}}` es true.
**Telegram** — Send Message: `🚨 Nivel {{$json.nivel}}: solo termina el {{$json.pct_completado}}% de {{$json.entradas}} jugadores, con {{$json.muertes_medias}} muertes de media.`

## El nodo Code del informe
```javascript
const filas = $input.all().map(i => i.json);
const ayer = new Date(Date.now() - 7*86400000).toISOString();
const recientes = filas.filter(f => f.ts > ayer);
const niveles = {};
for (const f of recientes) {
  const n = f.nivel || 'sin_nivel';
  niveles[n] = niveles[n] || { entradas: new Set(), fines: new Set(), muertes: 0 };
  if (f.evento === 'nivel_empezado') niveles[n].entradas.add(f.sesion);
  if (f.evento === 'nivel_terminado') niveles[n].fines.add(f.sesion);
  if (f.evento === 'muerte') niveles[n].muertes++;
}
return Object.entries(niveles).map(([nivel, d]) => {
  const entradas = d.entradas.size;
  const pct = entradas ? Math.round(d.fines.size / entradas * 100) : 0;
  const muertes_medias = entradas ? +(d.muertes / entradas).toFixed(1) : 0;
  return { json: { fecha: new Date().toISOString().slice(0,10), nivel, entradas, pct_completado: pct, muertes_medias, alarma: entradas >= 10 && (pct < 60 || muertes_medias > 8) } };
});
```

## Cómo probarla
Con el Webhook en modo test, manda un evento desde la terminal: `curl -X POST -H "Content-Type: application/json" -H "X-Secreto: tu-secreto" -d '{"sesion":"1","evento":"muerte","nivel":"3","valor":0}' URL_DE_TEST`.
Simula 12 sesiones falsas con un bucle para ver que el informe calcula bien los porcentajes.
Juega tú una partida completa con el build real y comprueba que llegan los eventos en el orden esperado.

## Qué puede salir mal
Google Sheets limita a 60 escrituras por minuto y por usuario: si tienes muchos jugadores a la vez te dará error 429. Solución: en vez de escribir fila a fila, acumula en un **Redis** o escribe en lotes con **Split In Batches** y espera 1 segundo entre lotes; a partir de 200 jugadores concurrentes, cámbialo a una base de datos (Supabase gratis).
Si la hoja pasa de 40.000 filas el informe irá lento: archiva por meses en pestañas distintas.
Zonas horarias: guarda siempre en UTC (`toISOString`) y convierte solo al mostrar; si mezclas, los informes diarios cortan mal.
Jugadores que cierran el juego de golpe no mandan «salida_del_juego»: no cuentes con ese evento para nada crítico, deduce el abandono por ausencia de «nivel_terminado».

## Cuánto cuesta
Todo gratis: n8n auto-alojado, Google Sheets, Telegram. Solo el servidor (5-6 €/mes) si no lo tienes ya.
En n8n Cloud vigila las ejecuciones: cada evento del juego es una ejecución y con muchos jugadores te comes el plan. Con volumen alto, auto-alojado es la única opción sensata.
