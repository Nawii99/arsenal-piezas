# Calendario de caducidades: certificados, claves y token…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Lleva la cuenta de todo lo que caduca en tu app (certificados, perfiles, claves push, keystore) y te avisa con 60, 30 y 7 días de margen.

## Qué es y qué hace

Receta de n8n que lleva el control de lo que caduca en tu app: certificados de Apple, perfiles de aprovisionamiento, claves push, keystore de Android y la cuenta de desarrollador. Lee una hoja de Google Sheets con las fechas, avisa por correo y Telegram a 60, 30 y 7 días y crea el evento en el calendario. Entrada: hoja con elemento, plataforma, fecha de caducidad y responsable. Salida: avisos programados y eventos de calendario.

## Cómo usarla

1. Rellena la hoja con las fechas reales
2. Conecta Calendar, correo y Telegram
3. Revisa la hoja cada mes

## Cuándo usarla

Cuando has tenido, o temes tener, el susto de que la app deje de compilar o dejen de llegar los push por una caducidad que nadie apuntó.

## Cómo ganar dinero con ella

Un certificado caducado puede tumbar los avisos push o bloquear una entrega dos días. Este aviso evita ese parón y el pico de estrés.

- Control de renovaciones para un desarrollador que mantiene varias apps…
- Vigilancia de certificados para una empresa con app en producción…
- Plantilla de mantenimiento para un equipo pequeño que publica apps…

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Guardas en una hoja todas las fechas de caducidad de tu ecosistema móvil y el flujo revisa cada semana cuánto queda, avisando por correo y Telegram a los 60, 30 y 7 días, además de crear el evento en tu calendario. Para el que mantiene una app en producción, solo o en equipo pequeño, y no tiene a nadie vigilando esto.

## Lo que necesitas antes
- Hoja de Google Sheets `caducidades` con columnas: elemento, plataforma, caduca (formato AAAA-MM-DD), responsable, donde_se_renueva, notas, ultimo_aviso.
- Rellénala una vez con, como mínimo: certificado de distribución iOS (1 año), perfiles de aprovisionamiento (1 año), clave APNs .p8 (no caduca, pero anota dónde está), certificado de push antiguo si aún lo usas, keystore de Android (mira la fecha con `keytool -list -v -keystore mi.keystore`), clave de firma de Play App Signing, la cuenta de desarrollador de Apple (99 €/año), la de Google Play, el dominio de tus enlaces universales, el certificado SSL de tu API y las claves de API de servicios de terceros.
- Credenciales en n8n de Google Sheets, Gmail (o SMTP), Google Calendar y Telegram.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Weeks, Trigger on Weekdays: Monday, Trigger at Hour: 9.
2. **Google Sheets** — Get Row(s) de `caducidades`.
3. **Code** (nombre: Calcular días) — calcula los días que faltan y decide si hoy toca avisar. Código abajo.
4. **IF** — Boolean `{{ $json.avisar }}` «is true».
5. **Gmail** — Send. To: `{{ $json.responsable }}`. Subject: `⏳ {{$json.elemento}} caduca en {{$json.dias}} días`. Message: incluye `donde_se_renueva` y las notas, que es lo que de verdad ahorra tiempo cuando llega el momento.
6. **Telegram** — Send Message al canal del equipo con el mismo resumen, solo si `{{ $json.dias }}` es menor o igual a 30.
7. **Google Calendar** — Operation: Create Event. Calendar: el tuyo. Summary: `Renovar {{$json.elemento}}`. Start: la fecha de caducidad menos 14 días, All Day: activado. Description: los pasos de renovación.
8. **Google Sheets** — Update Row (Matching Column: elemento) guardando en `ultimo_aviso` el umbral ya notificado, para no repetir el mismo aviso cada lunes.
9. Opcional, **IF** con `{{ $json.dias }}` «is smaller than» 0 → **Telegram** con `🚨 CADUCADO: {{$json.elemento}}` y prioridad alta.

## El trozo de código (nodo Code «Calcular días»)
```javascript
const HITOS = [60, 30, 7, 1];
const hoy = new Date(); hoy.setHours(0,0,0,0);
const salida = [];
for (const item of $input.all()) {
  const f = item.json;
  if (!f.caduca) continue;
  const fin = new Date(f.caduca + 'T00:00:00');
  const dias = Math.round((fin - hoy) / 86400000);
  const ultimo = Number(f.ultimo_aviso || 999);
  const hito = HITOS.find(h => dias <= h && ultimo > h);
  salida.push({ json: {
    ...f,
    dias,
    avisar: dias < 0 ? true : Boolean(hito),
    hito: hito || (dias < 0 ? 0 : null),
    urgencia: dias < 0 ? 'caducado' : dias <= 7 ? 'alta' : dias <= 30 ? 'media' : 'baja'
  }});
}
return salida;
```

## Cómo probarla
- Añade una fila falsa con caduca dentro de 6 días y ejecuta a mano: debe saltar el aviso del hito 7.
- Ejecuta otra vez sin cambiar nada: no debe volver a avisar (porque ultimo_aviso ya es 7).
- Pon una fila con fecha pasada y comprueba que sale el aviso de caducado.

## Qué puede salir mal
- **Formato de fecha**: si la columna está como texto con dd/mm/aaaa, el `new Date` falla. Fuerza el formato AAAA-MM-DD en Sheets (Formato → Número → Fecha personalizada) o convierte en el código.
- **Zona horaria**: en Settings del workflow pon `Europe/Madrid`; con UTC un aviso de «hoy» puede salir con un día de desfase.
- **Nadie actualiza la hoja tras renovar**: mete en el correo un enlace directo a la hoja y la costumbre de cambiar la fecha ese mismo día. Sin eso, el sistema muere en seis meses.
- **Google Calendar duplica eventos** si el flujo se ejecuta dos veces: el control de `ultimo_aviso` lo evita, pero también puedes buscar antes el evento por título.
- **Elemento sin responsable**: pon un valor por defecto con tu correo en el código para que nunca se quede huérfano.

## Cuánto cuesta
Todo gratis: Sheets, Gmail, Calendar y Telegram entran en cuentas normales. n8n auto-alojado 0 € (n8n Cloud no tiene plan gratuito permanente: tiene una prueba temporal y luego es de pago). Coste con n8n auto-alojado: 0 €.
