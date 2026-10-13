# Control de licencias de música y stock de tus vídeos…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Lleva el registro de cada pista, imagen o clip de stock que usas, en qué vídeo va y cuándo caduca la licencia, y te avisa un mes antes.

## Qué es y qué hace

Lleva un inventario de pistas, clips y fotos de stock: para cada uno anota proveedor, fecha de caducidad y en qué vídeos se usan. Cada día revisa cuáles caducan en menos de 30 días y te envía un email y un evento de calendario. Entrada: hoja Licencias; salida: avisos y eventos. Funciona en n8n con Gmail y Google Calendar. Es un control operativo, no un asesoramiento jurídico sobre los contratos.

## Cómo usarla

1. Crea la hoja Licencias con sus columnas
2. Conecta Gmail y Google Calendar
3. Carga tus licencias actuales
4. Que lo revise un profesional

## Cuándo usarla

Cuando usas música de suscripción (Epidemic, Artlist, Envato) o clips de stock y no sabes qué pasa con tus vídeos publicados si te das de baja.

## Cómo ganar dinero con ella

Evita reclamaciones de copyright y desmonetizaciones sobre vídeos que ya generan ingresos, y te ahorra pagar suscripciones que ya no necesitas.

- Auditoría de licencias para canales y agencias que publican vídeo con música de suscripción.
- Control de activos de stock para equipos de marketing con varios vídeos publicados.
- Plantilla de inventario de licencias para productoras pequeñas que entregan a clientes.

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Mantiene un inventario de licencias vinculado a los vídeos donde las usas y cada día revisa cuáles caducan en menos de 30 días para avisarte por email y crear un evento en el calendario. Es para creadores y agencias que publican vídeo con música o material de terceros.

## Lo que necesitas antes
- n8n con credenciales de Google Sheets, Gmail y Google Calendar.
- Hoja «Licencias» con columnas: id, tipo (musica/clip/foto/fuente), titulo, proveedor, url_licencia, fecha_alta, caduca (formato yyyy-mm-dd), cobertura (perpetua/mientras suscrito), videos, avisado.
- Un detalle importante: en Epidemic Sound y similares la cobertura suele ser «mientras estés suscrito», así que en `caduca` pon la fecha de renovación de tu suscripción, no la del vídeo.
- Un segundo formulario opcional para dar de alta licencias sin abrir la hoja.

## Los nodos, en orden
1. **n8n Form Trigger** («Alta de licencia») — campos: Tipo, Título de la pista o clip, Proveedor, URL del certificado, Cobertura, Fecha de caducidad (date), Vídeo donde se usa. Al enviarlo, un nodo **Google Sheets** hace Append a «Licencias» con `avisado` = no.
2. **Schedule Trigger** — Cron `0 8 * * *`, diario a las 8:00, Europe/Madrid.
3. **Google Sheets** — Get Row(s) de «Licencias».
4. **Code** («Cuánto queda») — calcula los días restantes y decide a quién hay que avisar.
5. **IF** — `{{ $json.avisar }}` is true.
6. **Google Calendar** — Create Event: título `Caduca licencia: {{ $json.titulo }}`, fecha `{{ $json.caduca }}`, todo el día, descripción con proveedor, vídeos afectados y URL del certificado.
7. **Gmail** — Send Message: asunto `⏳ {{ $json.dias }} días para que caduque {{ $json.titulo }}`, cuerpo con los vídeos afectados y qué hacer (renovar, sustituir la música o poner el vídeo en privado).
8. **Google Sheets** — Update: `avisado` = sí (evita el email diario).
9. Rama extra: **IF** con `{{ $json.dias < 0 }}` → Gmail con asunto `🔴 CADUCADA` y prioridad, más una fila en una pestaña «Riesgo».

## El código de «Cuánto queda»
```js
const HOY = new Date(new Date().toISOString().slice(0, 10));
return items.map(i => {
  const f = i.json;
  const caduca = f.caduca ? new Date(f.caduca) : null;
  const dias = caduca ? Math.round((caduca - HOY) / 86400000) : 9999;
  const yaAvisado = String(f.avisado || '').toLowerCase() === 'sí';
  return { json: {
    ...f,
    dias,
    avisar: caduca !== null && dias <= 30 && !yaAvisado
  }};
}).filter(x => x.json.dias !== 9999);
```

## Cómo probarla
- Añade una licencia de prueba con fecha de caducidad dentro de 10 días y ejecuta el Schedule a mano: deben llegar el email y el evento de calendario.
- Ejecútalo otra vez: no debe llegar nada, porque `avisado` ya está en sí. Si vuelve a avisar, revisa que el nodo Update escribe en la fila correcta (usa la columna `id` como clave).
- Prueba con una fecha ya pasada para ver la rama roja.

## Qué puede salir mal
- **Fechas en formato español**: si escribes 12/03/2027, el `new Date()` lo interpreta como 3 de diciembre. Fuerza el formato yyyy-mm-dd en la hoja (Formato > Número > Fecha personalizada) y en el formulario usa un campo de tipo date.
- **Filas vacías al final de la hoja**: el filtro `dias !== 9999` las descarta.
- **Avisos repetidos**: la columna `avisado` es la que lo corta; si renuevas la licencia, cambia la fecha y pon `avisado` a no.
- **Zona horaria**: fija Europe/Madrid en Settings del workflow o el aviso saldrá a las 10:00 en verano.
- Esto no comprueba nada en el proveedor: es un registro tuyo. Guarda siempre la URL o el PDF del certificado de licencia, que es lo que te pedirán en una reclamación.

## Cuánto cuesta
Gratis del todo: Sheets, Gmail y Calendar entran en cualquier cuenta de Google, y n8n auto-alojado no cuesta nada. Lo que te ahorra son los 20-50 €/mes de suscripciones que mantienes «por si acaso» sin saber si te hacen falta.
