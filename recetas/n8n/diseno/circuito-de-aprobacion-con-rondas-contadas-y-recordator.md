# Circuito de aprobación con rondas contadas y recordator…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Manda la propuesta al cliente con un enlace de aprobar o pedir cambios, le persigue solo si no contesta y te avisa cuando se pasa de las rondas incluidas.

## Qué es y qué hace

Envía la propuesta al cliente con dos botones, Aprobar o Pedir cambios, recoge su respuesta por webhook, lleva el recuento de rondas en Airtable y avisa cuando se supera el número de rondas incluido en el presupuesto. Si no contesta, le recuerda a los 3 y 7 días. Se monta con n8n, Make o Zapier y necesita una URL accesible desde internet.

## Cómo usarla

1. Crea la base Propuestas en Airtable
2. Configura Airtable y Gmail en n8n
3. Publica el webhook con dominio o en n8n Cloud
4. Prueba el flujo con una propuesta ficticia

## Cuándo usarla

Cuando los clientes tardan semanas en responder a una propuesta y luego piden la quinta ronda de cambios como si fuera gratis.

## Cómo ganar dinero con ella

Acorta el ciclo de aprobación en días y te da la prueba escrita para facturar las rondas extra: entre 150 y 400 € por proyecto que hoy regalas.

- Circuito de aprobación para estudios freelance con rondas pactadas…
- Seguimiento de propuestas como servicio mensual para agencias…
- Control de rondas extra con prueba escrita para facturar los cambios…

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Envía al cliente un correo con dos botones (Aprobar / Pedir cambios), recoge la respuesta por webhook, lleva la cuenta de rondas en una base y te avisa cuando el cliente supera las incluidas en el presupuesto. Si no responde, le recuerda a los 3 y a los 7 días.
Es para diseñadores freelance que trabajan por proyecto cerrado con un número de revisiones pactado.
## Lo que necesitas antes
Una base Airtable `Propuestas` con campos: `id_publico` (texto), `cliente`, `email`, `proyecto`, `enlace_propuesta`, `rondas_incluidas` (número), `rondas_usadas` (número), `estado` (Pendiente/Aprobada/Cambios), `fecha_envio`, `comentarios` (texto largo).
n8n accesible desde internet: en n8n Cloud ya lo es; auto-alojado necesitas un dominio o un túnel (`n8n start --tunnel` solo para pruebas).
Credenciales «Airtable Personal Access Token API» y «Gmail OAuth2» en n8n.
## Los nodos, en orden — Flujo A: enviar
**1. «Airtable Trigger»** o «Schedule Trigger» cada hora — busca registros con `estado` = `Nueva`.
**2. «Code»** — genera un `id_publico` aleatorio: `return $input.all().map(i => ({ json: { ...i.json, id_publico: Math.random().toString(36).slice(2,10) } }));`
**3. «Airtable»** — Update, guarda el `id_publico`, pone `estado` = `Pendiente` y `fecha_envio` = ahora.
**4. «Gmail»** — Send, Email Type HTML. En el cuerpo pon dos enlaces: `https://TU-N8N/webhook/aprobacion?id={{ $json.id_publico }}&r=ok` y `...&r=cambios`. Explica en el texto cuántas rondas quedan: `Te quedan {{ $json.rondas_incluidas - $json.rondas_usadas }} rondas de cambios incluidas.`
## Flujo B: recibir la respuesta
**5. «Webhook»** — HTTP Method GET, Path `aprobacion`, Respond: Using Respond to Webhook node. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
**6. «Airtable»** — Search, Filter By Formula `{id_publico}='{{ $json.query.id }}'`.
**7. «IF»** — String: `{{ $('Webhook').first().json.query.r }}` equals `ok`.
**8a.** Rama true: «Airtable» Update con `estado` = `Aprobada`. Luego «Gmail» a ti: `{{ $json.cliente }} ha aprobado {{ $json.proyecto }}`.
**8b.** Rama false: «Code» que suma una ronda (abajo), «Airtable» Update con `estado` = `Cambios` y `rondas_usadas` nueva, y un «IF» que compara rondas usadas con incluidas.
**9. «Gmail»** — si se pasa del límite, correo a ti y al cliente: `Esta es la ronda {{ $json.rondas_usadas }}; las incluidas eran {{ $json.rondas_incluidas }}. Las siguientes se facturan a XX €/hora.`
**10. «Respond to Webhook»** — Respond With: Text, con un HTML sencillo de agradecimiento para que el cliente no vea una pantalla en blanco.
## Flujo C: recordatorios
**11. «Schedule Trigger»** diario a las 9:00 → **«Airtable»** Search con fórmula `AND({estado}='Pendiente', DATETIME_DIFF(NOW(), {fecha_envio}, 'days') >= 3)` → **«Gmail»** recordatorio amable. Añade un campo `recordatorios` que sumes para no pasar de dos.
## El trozo de código (sumar ronda)
```javascript
const reg = $input.first().json;
const usadas = Number(reg.rondas_usadas || 0) + 1;
const incluidas = Number(reg.rondas_incluidas || 2);
return [{ json: { ...reg, rondas_usadas: usadas, excedida: usadas > incluidas, restantes: Math.max(0, incluidas - usadas) } }];
```
## Cómo probarla
Crea un registro con tu propio correo y `rondas_incluidas` = 1. Pulsa «Pedir cambios» dos veces y comprueba que la segunda dispara el aviso de ronda extra.
Prueba el enlace desde el móvil: los clientes abren el correo ahí y el webhook debe responder algo legible.
## Qué puede salir mal
Los clientes reenvían el correo: cualquiera con el enlace puede aprobar. Si el proyecto es delicado, añade un segundo parámetro secreto y compáralo en un IF.
Los antivirus corporativos «pinchan» los enlaces de los correos para escanearlos y disparan la aprobación sola. Solución: que el enlace lleve a una página con un botón que hace un POST, en vez de aprobar directamente en el GET.
Si el webhook devuelve nada, el navegador del cliente muestra un error y creerá que no funcionó: el nodo «Respond to Webhook» no es opcional.
Recuerda activar el workflow: en modo test la URL del webhook es distinta (`/webhook-test/`) y solo escucha una vez.
## Cuánto cuesta
Gratis con n8n auto-alojado, Airtable gratuito y Gmail. En n8n Cloud (prueba gratuita temporal y después de pago) ojo con las ejecuciones del recordatorio diario: cuentan contra el cupo de tu plan si tienes muchos proyectos abiertos.
