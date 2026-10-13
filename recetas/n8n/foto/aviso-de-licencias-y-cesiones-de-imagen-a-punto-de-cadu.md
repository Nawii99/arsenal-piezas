# Aviso de licencias y cesiones de imagen a punto de cadu…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Vigila las fechas de vencimiento de tus licencias, cesiones y contratos de uso de imagen, y te avisa con antelación para renovar o retirar las fotos.

## Qué es y qué hace

Lleva un registro de cada licencia o cesión de imagen con su fecha de fin y, a 60, 30 y 7 días antes, avisa por email con el listado de fotos afectadas y dónde están publicadas. Además crea un evento en Google Calendar. Usa una hoja con columnas fijas y Sheets, Calendar y Gmail en n8n.

## Cómo usarla

1. Crea la hoja Licencias con las columnas exactas
2. Conecta Sheets, Calendar y Gmail y carga las licencias activas
3. Revisa los avisos del primer mes
4. Que lo revise un profesional

## Cuándo usarla

Cuando licencias fotos a marcas por tiempo limitado, usas imágenes de stock con caducidad o tienes cesiones de modelo que expiran y no puedes seguir publicando.

## Cómo ganar dinero con ella

Una renovación olvidada puede costar una reclamación de 1.000 € o la retirada urgente de una campaña; avisar a tiempo también te da la excusa para volver a facturar.

- Instalación del aviso de vencimiento de licencias para fotógrafos que trabajan con marcas.
- Seguimiento mensual de cesiones y stock para una agencia con muchos contratos de uso.
- Plantilla de control de licencias vendida a tiendas que compran imagen con caducidad.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Para fotógrafos que licencian su trabajo y para tiendas o agencias que compran uso de imagen: mantiene un registro de cada licencia con su fecha de fin y avisa a 60, 30 y 7 días, generando además un evento en el calendario y un correo con el listado de fotos afectadas y dónde están publicadas.

## Lo que necesitas antes
- n8n (Cloud o auto-alojado).
- Una hoja «Licencias» con estas columnas exactas: id, tipo (cesion/stock/encargo), contraparte, descripcion, fotos_url, fecha_inicio, fecha_fin, territorio, medios, renovable (sí/no), importe, publicado_en, avisos_enviados, estado.
- Credenciales de Google Sheets, Google Calendar y Gmail en n8n.
- Opcional: bot de Telegram (token de @BotFather y tu chat_id) para los avisos urgentes de 7 días.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: Days, Trigger at Hour: 8, Trigger at Minute: 30.
2. **Google Sheets** — Operation: Get Row(s), hoja «Licencias», Return All. En Options activa «Output Row Number» para poder actualizar después la fila exacta.
3. **Code «Calcular vencimientos»** — con el código de abajo. Devuelve solo las que toca avisar hoy.
4. **IF** — Number, `{{ $items().length }}` Larger than 0. Si no hay nada, el flujo termina en un **No Operation**.
5. **Loop Over Items** — Batch Size: 1.
6. **Switch** — Mode: Rules, sobre `{{ $json.hito }}`: salida 0 si equals `60`, salida 1 si equals `30`, salida 2 si equals `7`.
7. Salidas 0 y 1: **Gmail** — Send a ti mismo. Subject: `Licencia de {{ $json.contraparte }} vence en {{ $json.dias }} días`. Message HTML con descripción, territorio, medios, dónde está publicado y el enlace a las fotos.
8. Salida 2: **Telegram** — Send Message con texto corto y urgente, más el mismo Gmail.
9. Todas las salidas: **Google Calendar** — Operation: Create Event. Calendar: el tuyo. Start `={{ $json.fecha_fin }}T09:00:00`, End `={{ $json.fecha_fin }}T09:30:00`, Summary `=FIN LICENCIA: {{ $json.contraparte }} - {{ $json.descripcion }}`, Description con el detalle. En Options añade Reminders: popup 1440 minutos antes. Importante: pon el Timezone en `Europe/Madrid`.
10. **Google Sheets** — Operation: Update Row. Row Number: el que trae el item. Columna `avisos_enviados`: `={{ $json.avisos_enviados_nuevo }}`.
11. Rama aparte al final: **Code** que busque licencias con `fecha_fin` ya pasada y `estado` distinto de `caducada`, y un **Google Sheets** Update que ponga `estado` = `caducada`, más un Gmail de resumen mensual.

## El trozo de código (nodo Code «Calcular vencimientos»)
```javascript
const HITOS = [60, 30, 7];
const hoy = new Date(); hoy.setHours(0, 0, 0, 0);
const salida = [];
for (const item of $input.all()) {
  const f = item.json;
  if (!f.fecha_fin || String(f.estado).toLowerCase() === 'caducada') continue;
  const fin = new Date(f.fecha_fin + 'T00:00:00');
  if (isNaN(fin)) continue;
  const dias = Math.round((fin - hoy) / 86400000);
  const ya = String(f.avisos_enviados || '').split(',').map(s => s.trim()).filter(Boolean);
  const hito = HITOS.find(h => dias <= h && !ya.includes(String(h)));
  if (hito === undefined) continue;
  if (dias < 0) continue;
  salida.push({ json: { ...f, dias, hito, avisos_enviados_nuevo: [...ya, String(hito)].join(',') }, pairedItem: item.pairedItem });
}
return salida;
```

## Cómo probarla
- Crea tres filas de prueba con fecha_fin a 5, 29 y 59 días desde hoy, y `avisos_enviados` vacío.
- Ejecuta a mano: deben dispararse los avisos de 7, 30 y 60 respectivamente, y la columna `avisos_enviados` debe quedar rellena.
- Vuelve a ejecutar sin cambiar nada: no debe enviarse ningún correo. Si se repiten, el nodo de Update no está guardando en la fila correcta (revisa que tienes activado «Output Row Number»).

## Qué puede salir mal
- **Formato de fecha**: en la hoja escribe siempre `AAAA-MM-DD` y formatea la columna como Texto sin formato, o Google te la convertirá a otro formato y el `new Date()` fallará.
- **Zona horaria**: el servidor de n8n suele ir en UTC. En Settings del workflow pon Timezone `Europe/Madrid`, y también en el nodo de Calendar; si no, los eventos aparecen dos horas antes en verano.
- **Avisos repetidos**: la columna `avisos_enviados` es el seguro. Si la borras, se reenvían.
- **Licencias sin fecha de fin**: las perpetuas déjalas con fecha_fin vacía; el código ya las salta.
- **Correo a spam**: si te mandas muchos avisos, crea un filtro en Gmail que los marque como importantes y nunca los mande a spam.

## Cuánto cuesta
0 € completo. n8n auto-alojado en tu ordenador o en un VPS de 5 €/mes, y Sheets, Calendar, Gmail y Telegram gratis con cuentas normales.
