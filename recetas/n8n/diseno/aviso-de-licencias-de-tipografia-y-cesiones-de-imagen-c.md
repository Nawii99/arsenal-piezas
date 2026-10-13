# Aviso de licencias de tipografía y cesiones de imagen c…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Lleva el control de las licencias de fuentes, fotos e ilustraciones de cada proyecto y te avisa 60, 30 y 7 días antes de que caduquen o se pasen de uso.

## Qué es y qué hace

Guarda en Airtable cada licencia de fuente, foto, icono o música con su tipo, su límite de uso y su fecha de caducidad, y cada mañana avisa por correo cuando faltan 60, 30 o 7 días. Sirve para no usar un activo fuera de licencia y planificar las renovaciones. Se monta con n8n, Make o Zapier y no necesita programar.

## Cómo usarla

1. Crea la base Licencias con sus campos
2. Conecta Airtable y Gmail en n8n
3. Carga las licencias activas con sus límites
4. Revisa el aviso del primer día
5. Que lo revise un profesional

## Cuándo usarla

Cuando usas fuentes de pago o bancos de imágenes con licencias limitadas por tiempo, tirada o número de visitas y no quieres una reclamación por sorpresa.

## Cómo ganar dinero con ella

Una reclamación por uso de tipografía fuera de licencia va de 500 a varios miles de euros. Esto la evita y además te permite refacturar renovaciones al cliente.

- Control de licencias de tipografía como servicio para estudios con muchos clientes…
- Refacturación de renovaciones de licencias a clientes con aviso previo…
- Auditoría inicial de licencias de activos de marca antes de una entrega…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Guarda en una base cada licencia comprada (fuente, foto, icono, música), con su tipo, límites y fecha de caducidad, y revisa a diario cuáles se acercan al vencimiento, avisándote por correo y creando el aviso en el calendario.
Es para estudios y freelance que compran fuentes con licencia web por visitas o licencias anuales, y para quien gestiona activos de varios clientes.
## Lo que necesitas antes
Una base Airtable `Licencias` con campos: `activo` (texto: nombre de la fuente o imagen), `tipo` (selección: Tipografía / Imagen / Icono / Música / Plantilla), `proveedor`, `cliente`, `proyecto`, `licencia` (selección: Escritorio / Web / App / Ilimitada), `limite` (texto: por ejemplo «250.000 visitas/mes» o «tirada 5.000»), `fecha_compra`, `fecha_caducidad` (fecha), `coste_renovacion` (número), `factura_url`, `avisado_60` `avisado_30` `avisado_7` (checkboxes).
En n8n: credenciales «Airtable Personal Access Token API», «Gmail OAuth2» y «Google Calendar OAuth2».
## Los nodos, en orden
**1. «Schedule Trigger»** — Interval: Days, Trigger at Hour 8, timezone `Europe/Madrid`.
**2. «Airtable»** — Operation: Search, Table `Licencias`, Filter By Formula `AND({fecha_caducidad}, DATETIME_DIFF({fecha_caducidad}, TODAY(), 'days') <= 60, DATETIME_DIFF({fecha_caducidad}, TODAY(), 'days') >= -1)`, Return All.
**3. «Code»** — calcula los días que faltan y decide si toca avisar según los checkboxes ya marcados (código abajo).
**4. «Filter»** — Boolean `{{ $json.hay_que_avisar }}` is true.
**5. «Gmail»** — Send, asunto `Licencia de {{ $json.activo }}: caduca en {{ $json.dias }} días`, cuerpo con proveedor, cliente, límites, coste de renovación y el enlace a la factura.
**6. «Google Calendar»** — Resource: Event, Operation: Create, Start `{{ $json.fecha_caducidad }}`, End igual, Summary `Renovar licencia: {{ $json.activo }} ({{ $json.cliente }})`, Description con los detalles. Solo cuando `{{ $json.hito }}` sea `60`, para no llenar el calendario.
**7. «Airtable»** — Operation: Update, marca el checkbox correspondiente (`avisado_60`, `avisado_30` o `avisado_7`) según `{{ $json.campo_aviso }}`.
**8. «IF»** extra — si `dias` es menor que 0, manda un correo distinto con asunto `CADUCADA: retira {{ $json.activo }} de las piezas vivas` y lista de proyectos afectados.
## El trozo de código (nodo «Code»)
```javascript
const hoy = new Date(); hoy.setHours(0,0,0,0);
const salida = [];
for (const item of $input.all()) {
  const r = item.json;
  const f = new Date(r.fecha_caducidad);
  const dias = Math.round((f - hoy) / 86400000);
  let hito = null;
  if (dias <= 7 && !r.avisado_7) hito = 7;
  else if (dias <= 30 && dias > 7 && !r.avisado_30) hito = 30;
  else if (dias <= 60 && dias > 30 && !r.avisado_60) hito = 60;
  salida.push({ json: {
    ...r,
    dias,
    hito,
    hay_que_avisar: hito !== null || dias < 0,
    campo_aviso: hito ? 'avisado_' + hito : null,
    urgencia: dias < 0 ? 'CADUCADA' : dias <= 7 ? 'URGENTE' : dias <= 30 ? 'Pronto' : 'Aviso'
  } });
}
return salida;
```
## Cómo probarla
Mete una licencia con `fecha_caducidad` dentro de 5 días y ejecuta a mano: debe llegarte el aviso de 7 días y marcarse `avisado_7`.
Ejecuta otra vez sin cambiar nada: no debe llegarte nada. Si te llega dos veces, el paso 7 no está actualizando el checkbox correcto.
Prueba con una fecha ya pasada para ver el correo de caducada.
## Qué puede salir mal
Airtable guarda fechas en UTC: si pones la hora del trigger a las 8 y la zona a Madrid, el cálculo de días puede desviarse un día en verano. Trabaja siempre con fechas sin hora y normaliza con `setHours(0,0,0,0)`.
Las licencias por volumen (visitas al mes, tirada) no caducan por fecha: añade un campo `revisar_cada_meses` y una segunda rama que avise periódicamente para que compruebes los números en Analytics.
Si el cliente no renueva, tienes que retirar la fuente de la web: deja escrito en el correo qué proyectos la usan, por eso el campo `proyecto` es obligatorio.
Guarda siempre el PDF de la licencia en Drive y pon el enlace en `factura_url`: sin justificante, la reclamación la pierdes igual.
## Cuánto cuesta
Todo gratis: Airtable plan gratuito, Gmail, Google Calendar y n8n auto-alojado. Una ejecución diaria son 30 al mes, dentro incluso del plan gratuito de n8n Cloud.
