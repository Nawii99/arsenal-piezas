# Aviso de caducidades: certificados, claves y contraseña…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Lleva la cuenta de todo lo que caduca en tu vida de app (certificados, perfiles, claves de API) y te avisa con 30, 14 y 3 días de margen.

## Qué es y qué hace

Flujo de n8n que revisa cada día una hoja de Google Sheets con las fechas de caducidad de certificados, perfiles, claves de API y dominios, y envía un correo con 30, 14 y 3 días de margen. La primera vez crea el evento en Google Calendar. Entran las fechas en formato AAAA-MM-DD; sale un correo de aviso y el evento en el calendario. Requiere Google Sheets, Gmail y Google Calendar conectados en n8n.

## Cómo usarla

1. 1. Rellena la hoja Caducidades con cada elemento y su fecha
2. 2. Conecta Google y activa el flujo
3. 3. Renueva con antelación y marca la fila como renovada

## Cuándo usarla

Úsalo cuando ya te haya pasado (o quieras que no te pase) que un certificado caducado te bloquee una publicación urgente.

## Cómo ganar dinero con ella

Un certificado caducado en el peor momento son días de retraso en un lanzamiento. Esto cuesta cero y lo evita.

- Calendario de vencimientos para desarrolladores independientes que llevan varias apps y cuentas de tienda.
- Aviso de caducidades para agencias que gestionan dominios, certificados y claves de decenas de clientes.
- Control de renovaciones para equipos pequeños que han sufrido un lanzamiento bloqueado por un certificado caducado.

**Precio orientativo:** 80–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Revisa a diario una hoja con todas tus fechas de caducidad y te manda un correo con lo que vence pronto, además de crear el evento en el calendario la primera vez.
Para desarrolladores independientes y agencias que llevan varias apps y pierden la pista de qué caduca en cada cuenta.

## Lo que necesitas antes
n8n con Google Sheets, Gmail y Google Calendar conectados (los tres con OAuth2 desde Credentials, misma cuenta de Google).
Una hoja `Caducidades` con columnas: elemento, plataforma, fecha_caducidad (formato AAAA-MM-DD), donde_se_renueva, avisado_30, avisado_14, avisado_3, evento_creado.
Rellena la hoja una vez con lo que tengas: certificado de distribución iOS (1 año), perfiles de aprovisionamiento (1 año), certificado de notificaciones push, clave de API de App Store Connect, clave de firma de Android (esa dura 25 años pero anótala igual), dominio, SSL, y las claves de terceros que uses.

## Los nodos, en orden
1. **Schedule Trigger**: Cron `0 8 * * *`.
2. **Google Sheets** (Get Row(s)): hoja `Caducidades`, Return All.
3. **Code**: calcula días que faltan y decide si toca avisar. Código abajo.
4. **IF**: Boolean `{{ $json.toca_avisar }}` es true.
5. **Gmail** (Send): asunto `Caduca en {{ $json.dias }} días: {{ $json.elemento }}`, cuerpo con `{{ $json.donde_se_renueva }}`.
6. **IF** segundo: `{{ $json.evento_creado }}` está vacío.
7. **Google Calendar** (Create Event): título `Renovar {{ $json.elemento }}`, fecha = la de caducidad menos 7 días, todo el día.
8. **Google Sheets** (Update): marca la columna del aviso correspondiente con SI y `evento_creado` con SI.

## El nodo Code
```javascript
const hoy = new Date();
const salida = [];
for (const item of $input.all()) {
  const f = item.json;
  if (!f.fecha_caducidad) { continue; }
  const cad = new Date(f.fecha_caducidad + 'T12:00:00Z');
  const dias = Math.round((cad - hoy) / 86400000);
  let hito = '';
  if (dias <= 3 && String(f.avisado_3).toUpperCase() !== 'SI') { hito = 'avisado_3'; }
  else if (dias <= 14 && dias > 3 && String(f.avisado_14).toUpperCase() !== 'SI') { hito = 'avisado_14'; }
  else if (dias <= 30 && dias > 14 && String(f.avisado_30).toUpperCase() !== 'SI') { hito = 'avisado_30'; }
  salida.push({ json: Object.assign({}, f, { dias, hito, toca_avisar: hito !== '' && dias >= -30 }) });
}
return salida;
```

## Cómo probarla
Añade una fila falsa con fecha de caducidad dentro de 10 días y ejecuta: debe llegarte el correo del hito de 14 días y marcarse `avisado_14` = SI.
Vuelve a ejecutar: no debe repetir el correo. Eso confirma que el antiduplicados funciona.

## Qué puede salir mal
El campo fecha tiene que ir en formato AAAA-MM-DD y como texto, no como fecha de Sheets, o al leerlo te llegará un número raro. Formatea la columna como «Texto sin formato».
Zonas horarias: por eso el código añade `T12:00:00Z`, para que no baile un día arriba o abajo.
Si renuevas algo, actualiza la fecha y borra los SI de las columnas de avisado, si no, no te volverá a avisar el año que viene.

## Cuánto cuesta
Gratis. Todo con cuentas que ya tienes.
