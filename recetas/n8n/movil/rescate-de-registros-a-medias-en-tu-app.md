# Rescate de registros a medias en tu app…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Detecta a quien empieza a registrarse o a comprar en la app y no termina, espera un rato prudencial y le manda un email o una push con un empujón.

## Qué es y qué hace

Flujo de n8n que recibe por webhook los eventos de tu app (registro iniciado o completado, pago iniciado o completado), los guarda en Airtable y, a las dos horas, envía un correo o una push a quien se quedó a medias. Entran los eventos en JSON con identificador de usuario y correo; sale un correo de rescate y el registro del contacto. Requiere un webhook POST con clave secreta, Brevo y, si quieres push, OneSignal.

## Cómo usarla

1. 1. Añade a la app la llamada POST con los eventos
2. 2. Crea la tabla Eventos en Airtable
3. 3. Prueba con un usuario de pruebas antes de enviar a usuarios reales
4. Que lo revise un profesional

## Cuándo usarla

Cuando ves muchas instalaciones pero pocos usuarios activos, o carritos y suscripciones que se quedan a medio camino y nadie hace nada.

## Cómo ganar dinero con ella

Recuperar entre un 10% y un 20% de los registros abandonados. Con 500 registros a medias al mes y 15 € de valor por usuario, son cientos de euros recuperados.

- Recuperación de registros abandonados para apps con registro o compra que pierden usuarios en el embudo.
- Embudo de conversión con correos de rescate para tiendas de apps que quieren menos procesos a medias.
- Campañas de reactivación para agencias que cuidan el registro de apps de clientes.

**Precio orientativo:** 200–500 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recibe eventos de tu app (`registro_iniciado`, `registro_completado`, `pago_iniciado`, `pago_completado`), y a las 2 horas contacta a quien se quedó a medias.
Para apps con registro, prueba gratuita o compra dentro que pierden usuarios en el embudo sin saber por qué.

## Lo que necesitas antes
- Que tu app envíe eventos a un webhook. Es una llamada POST de tres líneas en el código de la app: `{ evento, user_id, email, plataforma, fecha }`.
- Airtable (gratis) o una base Postgres para guardar los eventos. Tabla `Eventos` con: `user_id`, `email`, `evento`, `plataforma`, `fecha`, `contactado`.
- Brevo para el email y OneSignal si quieres push.
- n8n con URL pública.

## Los nodos, en orden — flujo 1: recoger eventos
1. **Webhook** — POST, ruta `evento-app`. Añade un header secreto `x-app-key` y un **IF** que lo valide. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2. **Set** — normaliza los campos.
3. **Airtable** — `Create Record` en `Eventos`.
4. **Respond to Webhook** — devuelve `{"ok":true}` cuanto antes.

## Los nodos, en orden — flujo 2: el rescate
1. **Schedule Trigger** — cada 30 minutos.
2. **Airtable** — `Search Records` con fórmula: eventos `registro_iniciado` de hace entre 2 y 24 horas y `contactado` vacío.
3. **Code** («Sin completar») — descarta a los que sí tienen el evento de completado.
4. **Split In Batches** — Batch Size 10.
5. **IF** — ¿tenemos email?
6. **Brevo** (rama true) — envía la plantilla `rescate-registro`: asunto «Te falta un paso para entrar», con un enlace profundo que le devuelve justo a la pantalla donde lo dejó.
7. **OneSignal** (rama false) — push al `player_id` guardado: «Solo te queda un paso 👀».
8. **Airtable** — `Update Record` marcando `contactado` con la fecha.
9. **Wait** — 48 horas, y un segundo intento solo para quienes sigan sin completar (usa un **Airtable** de comprobación antes).

## El código del nodo «Sin completar»
```javascript
const registros = $input.all().map(i => i.json.fields || i.json);
const porUsuario = {};
for (const r of registros) {
  const id = r.user_id;
  if (!porUsuario[id]) porUsuario[id] = { eventos: [], datos: r };
  porUsuario[id].eventos.push(r.evento);
}
const salida = [];
for (const id in porUsuario) {
  const e = porUsuario[id].eventos;
  const inicio = e.includes('registro_iniciado') || e.includes('pago_iniciado');
  const fin = e.includes('registro_completado') || e.includes('pago_completado');
  if (inicio && !fin) salida.push({ json: porUsuario[id].datos });
}
return salida;
```

## Cómo probarla
- Manda tú los eventos con curl: primero `registro_iniciado` con tu email, y no mandes el de completado. A las 2 horas debe llegarte el email.
- Repite mandando los dos eventos: no debe llegarte nada.
- Comprueba que el enlace del email abre la app en la pantalla correcta, en iOS y en Android.

## Qué puede salir mal
- **Legalidad**: para mandar un email a alguien que no ha terminado el registro necesitas base legal. Pon el aviso de privacidad y el consentimiento en la primera pantalla del registro, y un enlace de baja en cada correo. Sin eso, no lo hagas.
- No bajes de 2 horas de espera: alguien puede estar completando el registro mientras le escribes, y queda fatal.
- Evita duplicados: la marca `contactado` es obligatoria, y filtra siempre por ella en la búsqueda de Airtable.
- El nodo **Wait** de 48 horas mantiene la ejecución viva; en n8n auto-alojado necesita el modo `queue` o cola de ejecución activada para sobrevivir a un reinicio. Alternativa: una segunda ejecución programada que busque a los de hace 48 horas.
- Airtable gratis limita a 1.000 registros por base: purga los eventos con más de 60 días con un flujo mensual de borrado.

## Cuánto cuesta
Airtable gratis hasta 1.000 registros (o Postgres gratis en tu servidor). Brevo gratis hasta 300 emails al día. OneSignal gratis para push móvil. n8n auto-alojado gratis. Coste típico: 0 €.
