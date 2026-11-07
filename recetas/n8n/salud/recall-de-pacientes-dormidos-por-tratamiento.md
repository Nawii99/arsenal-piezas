# Recall de pacientes dormidos por tratamiento…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Revisa tu histórico de citas y avisa por email o WhatsApp a los pacientes que llevan demasiado tiempo sin volver, con un plazo distinto según el tratamiento que se hicieron.

## Qué es y qué hace

Una vez por semana recorre la lista de pacientes, calcula los días desde la última cita y lo compara con el intervalo de recall de cada tratamiento. Los que toca revisar reciben un email o un WhatsApp según el plazo. Entrada: hoja Pacientes con columnas fijas; salida: mensajes de recall y registro. Se monta en n8n con Google Sheets y Gmail, con credenciales OAuth2 de Google.

## Cómo usarla

1. Preparar la hoja Pacientes con las columnas exactas
2. Fijar los intervalos de recall por tratamiento
3. Probar con diez pacientes
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tengas cientos de pacientes antiguos en una hoja o en tu software y nadie tenga tiempo de llamarlos uno a uno para que vuelvan a revisión.

## Cómo ganar dinero con ella

Recuperar 8 pacientes dormidos al mes a 45 € de media son 360 € que ya estaban en tu base; el sistema cuesta 0 € si lo montas en n8n autoalojado, que es gratis.

- Montar el recall de revisiones para clínicas dentales y de podología, cobrando la configuración.
- Ofrecer el mantenimiento mensual del recall a una clínica de fisioterapia.
- Vender un informe mensual de pacientes que toca revisar.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Recorre una vez por semana tu lista de pacientes, calcula cuántos días han pasado desde su última cita y compara ese número con el intervalo de recall propio de cada tratamiento (fisio 90 días, higiene dental 180, revisión podología 365, lo que tú decidas).
Para quien lleve una clínica pequeña (dental, fisio, podología, nutrición, estética) con la ficha de pacientes en Google Sheets o exportable a CSV desde su software.

## Lo que necesitas antes
Cuenta de n8n: gratis auto-alojado con Docker, o el plan Starter de n8n Cloud si no quieres servidor.
Cuenta de Google con un Sheet llamado `Pacientes` y estas columnas exactas en la fila 1: `id`, `nombre`, `email`, `telefono`, `tratamiento`, `ultima_cita`, `ultimo_recall`, `baja_comercial`.
Credencial `Google Sheets OAuth2` en n8n: en console.cloud.google.com creas un proyecto, activas Google Sheets API, creas credenciales OAuth de tipo Aplicación web y pegas como URI de redirección la que te muestra n8n.
Credencial `Gmail OAuth2` (misma consola, activa Gmail API) para el envío por correo.
Opcional para WhatsApp: cuenta de Twilio con el sandbox de WhatsApp activo; copia Account SID y Auth Token desde el panel de Twilio.
La columna `ultima_cita` en formato `AAAA-MM-DD`. Si tu software exporta `DD/MM/AAAA`, lo normaliza el nodo Code.

## Los nodos, en orden
1. **Schedule Trigger** — modo `Cron`, expresión `0 9 * * 2` (martes a las 9:00). En Settings del workflow pon Timezone `Europe/Madrid`.
2. **Google Sheets** — Resource `Sheet Within Document`, Operation `Get Row(s)`, tu documento, hoja `Pacientes`, opción `Return All` activada.
3. **Code** — Mode `Run Once for All Items`. Filtra y decide a quién toca escribir (código abajo).
4. **Split In Batches** — Batch Size `1`, para no disparar 200 emails de golpe.
5. **IF** — Condición String: `{{$json.canal}}` igual a `email`. Rama true al nodo Gmail, rama false al nodo Twilio.
6. **Gmail** — Operation `Send`, To `{{$json.email}}`, Subject `{{$json.nombre}}, toca revisión`, Message en HTML con tu texto y un enlace a tu página de reservas. Nunca menciones dolencias concretas en el asunto.
7. **Twilio** — Resource `SMS`, activa `To WhatsApp`, From tu número de Twilio, To `{{$json.telefono}}`, Message el texto corto de recordatorio.
8. **Google Sheets** (segundo) — Operation `Update Row`, Matching Column `id`, y escribe en `ultimo_recall` el valor `{{$now.format('yyyy-MM-dd')}}` para no repetir el aviso.
9. Conecta la salida de Gmail y la de Twilio de vuelta a la entrada del **Split In Batches** para que procese el siguiente paciente.

## El nodo Code
```js
const hoy = new Date();
const intervalos = { fisioterapia: 90, dental: 180, podologia: 365, nutricion: 120, estetica: 60 };
const salida = [];
for (const item of $input.all()) {
  const p = item.json;
  if (String(p.baja_comercial).toLowerCase() === 'si') continue;
  if (!p.email && !p.telefono) continue;
  const partes = String(p.ultima_cita).includes('/') ? String(p.ultima_cita).split('/') : null;
  const iso = partes ? `${partes[2]}-${partes[1]}-${partes[0]}` : String(p.ultima_cita);
  const ultima = new Date(iso);
  if (isNaN(ultima)) continue;
  const dias = Math.floor((hoy - ultima) / 86400000);
  const limite = intervalos[String(p.tratamiento).toLowerCase()] || 180;
  if (dias < limite) continue;
  if (p.ultimo_recall) {
    const diasRecall = Math.floor((hoy - new Date(p.ultimo_recall)) / 86400000);
    if (diasRecall < 120) continue;
  }
  salida.push({ json: { ...p, dias, canal: p.email ? 'email' : 'whatsapp' } });
}
return salida;
```

## Cómo probarla
Duplica el Sheet, deja 3 filas de prueba con tu propio email y una `ultima_cita` de hace un año, y ejecuta con `Execute Workflow`.
Antes de la primera tanda real, desconecta Gmail y mira la salida del Code: si te salen 300 pacientes, sube el intervalo o limita con `salida.slice(0, 30)`.

## Qué puede salir mal
Fechas raras o vacías: el `isNaN` las descarta, revisa el Sheet si te faltan pacientes esperados.
Gmail corta sobre los 400-500 envíos al día en cuentas normales; por eso el Split In Batches de 1 y el tope de 30 por tanda.
Zona horaria: si no fijas `Europe/Madrid` el cron dispara en UTC y en verano se va una hora.
Duplicados: si ejecutas dos veces el mismo día, la columna `ultimo_recall` con el corte de 120 días evita el segundo aviso.
Baja comercial: respeta siempre la columna, es obligación de RGPD y evita quejas.

## Cuánto cuesta
n8n auto-alojado: 0 €. n8n Cloud Starter: unos 20 €/mes.
Google Sheets y Gmail: gratis con tu cuenta.
Twilio WhatsApp: alrededor de 0,005-0,05 € por mensaje según plantilla y país; 200 avisos al mes rondan los 5 €.
