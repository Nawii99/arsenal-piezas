# Parte de asistencia y horas para justificar formación b…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Junta las conexiones de tus alumnos, calcula las horas reales de cada uno y genera cada mes el listado de asistencia listo para presentar, avisándote de quién no llega al mínimo.

## Qué es y qué hace

Cada noche llama a la API de Zoom, trae los informes de participantes del día y acumula minutos por alumno y curso en una hoja. El día 1 de cada mes genera un CSV con nombre, DNI, curso, sesiones y horas, lo envía por correo y marca a quien esté por debajo del 75 % de asistencia. Entran informes de Zoom y salen listados de asistencia. Para formación bonificada o subvencionada, con n8n.

## Cómo usarla

1. Crea la app Server-to-Server en Zoom con permiso de informes
2. Prepara la hoja de alumnos con DNI
3. Programa el cierre mensual en n8n
4. Que lo revise un profesional

## Cuándo usarla

Úsalo si impartes formación para empresas, bonificada por FUNDAE o subvencionada, donde tienes que demostrar horas y asistencia y te lo juegas todo en la justificación.

## Cómo ganar dinero con ella

Una justificación mal hecha te obliga a devolver el crédito entero del curso. Esto convierte 4 horas de Excel al mes en cero y te avisa a tiempo de quien no llega al 75%.

- Implantación de control de asistencia y listados mensuales para entidades que imparten formación bonificada, por curso.
- Cierre mensual de horas y revisión de justificaciones para academias con subvenciones, por cuota.
- Plantilla de parte de asistencia vendida a gestorías y consultoras de formación.

**Precio orientativo:** 300–600 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada noche llama a la API de Zoom, se trae los informes de participantes de las sesiones del día (entrada, salida, minutos) y los acumula por alumno y por curso en una hoja. El día 1 de cada mes genera un CSV con nombre, DNI, curso, sesiones y horas totales, te lo manda por email y marca en rojo a quien esté por debajo del 75% de asistencia.

## Lo que necesitas antes
- n8n instalado.
- Cuenta de Zoom de pago (los informes de participantes requieren plan Pro o superior) o Google Meet con Workspace, que tiene informe de asistencia equivalente.
- App Server-to-Server OAuth en marketplace.zoom.us: crea la app, apunta Account ID, Client ID y Client Secret, y añade el scope `report:read:admin`.
- Google Sheet `Asistencia` con: `fecha`, `curso`, `nombre`, `email`, `minutos`, `meeting_id`.
- Google Sheet `Alumnos` con: `email`, `nombre`, `dni`, `curso`, `horas_totales_curso`.

## Los nodos, en orden
1. **Schedule Trigger** — `30 23 * * *`, timezone `Europe/Madrid`.
2. **HTTP Request** (token) — POST a `https://zoom.us/oauth/token?grant_type=account_credentials&account_id=TU_ACCOUNT_ID`, autenticación `Basic Auth` con Client ID y Client Secret. Devuelve `access_token`.
3. **HTTP Request** (reuniones) — GET `https://api.zoom.us/v2/report/users/me/meetings?from={{ $today.format('yyyy-MM-dd') }}&to={{ $today.format('yyyy-MM-dd') }}`, header `Authorization: Bearer {{ $json.access_token }}`.
4. **Split Out** — campo `meetings`.
5. **HTTP Request** (participantes) — GET `https://api.zoom.us/v2/report/meetings/{{ $json.uuid }}/participants?page_size=300`, mismo header.
6. **Split Out** — campo `participants`.
7. **Code** — agrupa por email y suma minutos de todas las entradas y salidas. Código abajo.
8. **Google Sheets** (`Append Row`) sobre `Asistencia`.
9. Flujo B mensual: **Schedule Trigger** `0 8 1 * *`, **Google Sheets** (`Get Row(s)`) de `Asistencia` y de `Alumnos`, **Code** que calcula el porcentaje, **Convert to File** (operación `Convert to CSV`) y **Gmail** con el CSV adjunto y la lista de los que no llegan al 75%.

## El código del nodo Code (paso 7)
```javascript
const acc = {};
for (const item of $input.all()) {
  const p = item.json;
  const email = (p.user_email || p.name || '').toLowerCase().trim();
  if (!email) continue;
  const min = Math.round((Number(p.duration) || 0) / 60);
  if (!acc[email]) acc[email] = { email, nombre: p.name, minutos: 0 };
  acc[email].minutos += min;
}
const fecha = $now.format('yyyy-MM-dd');
const meeting = $('Split Out').first().json.topic || '';
return Object.values(acc).map(a => ({ json: { ...a, fecha, curso: meeting, meeting_id: $('Split Out').first().json.id } }));
```

## Cómo probarla
- Haz una reunión de Zoom de 5 minutos contigo y una segunda cuenta, y sal y entra una vez para generar dos tramos.
- Ejecuta el flujo a mano el mismo día: deben salir dos filas y los minutos sumados, no duplicados.
- Genera el informe mensual con datos de prueba y ábrelo en Excel: comprueba que el CSV usa coma o punto y coma según lo que espere quien lo recibe.

## Qué puede salir mal
- **Los informes de Zoom tardan**: la API puede tardar hasta 30 minutos en tener los datos. Por eso el cron es a las 23:30, no al terminar.
- **Un alumno con dos nombres**: si entra por móvil como `iPhone de Ana` no tiene email. Obliga a registro en la reunión (`Registration required`) y el email siempre viene.
- **Retención**: Zoom guarda informes de reuniones recientes; no dejes pasar meses sin ejecutar.
- **CSV con tildes**: exporta en UTF-8 con BOM si quien lo abre usa Excel antiguo.
- Esto te prepara el dato: la presentación formal ante FUNDAE sigue siendo cosa tuya o de tu gestoría.

## Cuánto cuesta
- Zoom Pro: unos 14 euros/mes (necesario para los informes). Con Google Workspace Business, incluido.
- n8n auto-alojado, Sheets y Gmail: 0 euros.
