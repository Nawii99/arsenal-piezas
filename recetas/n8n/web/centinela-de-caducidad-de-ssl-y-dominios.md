# Centinela de caducidad de SSL y dominios…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Revisa cada día los certificados SSL y las fechas de renovación de todos los dominios que gestionas, y te avisa por email con 30 y 45 días de margen antes de que caduquen.

## Qué es y qué hace

Cada mañana consulta, para cada dominio de una lista, los días que le quedan al certificado SSL en ssl-checker.io y la fecha de caducidad del dominio vía RDAP en rdap.org, ambos gratuitos. Entrada: hoja con dominio, cliente y email de aviso. Salida: email de alerta con 30 y 45 días de margen. Se monta en n8n y el mismo cálculo puede lanzarse desde Make o Zapier. No accede al contenido de la web.

## Cómo usarla

1. Crea la hoja Dominios
2. Conecta Gmail
3. Fija el horario a las 07:00
4. Prueba con un dominio que caduque pronto

## Cuándo usarla

Úsalo cuando llevas la web de varios clientes y no quieres que un certificado caducado o un dominio sin renovar te pille por sorpresa un domingo.

## Cómo ganar dinero con ella

Evita el incidente clásico: web caída con aviso rojo del navegador. Una sola caída evitada vale más que las 2 horas de montaje. 0 € al mes.

- Vigilancia de certificados y dominios para freelancers con cinco a cien webs de clientes.
- Servicio mensual de control de caducidades para agencias que gestionan dominios ajenos.
- Configuración de avisos de renovación para tiendas online que no quieren caídas por descuido.

**Precio orientativo:** 80–150 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada mañana comprueba, para cada dominio de una lista, cuántos días le quedan al certificado SSL y cuántos a la renovación del dominio.
Está pensado para freelance o pequeña agencia que mantiene entre 5 y 100 webs de clientes.

## Lo que necesitas antes
- n8n (gratis, auto-alojado con Docker, o el plan Starter de n8n Cloud).
- Una hoja de Google Sheets llamada `Dominios` con las columnas: `dominio`, `cliente`, `email_aviso`.
- Cuenta de Google conectada en n8n (credencial OAuth de Google Sheets y de Gmail: se crean en console.cloud.google.com creando un proyecto, activando las APIs Sheets y Gmail y generando un ID de cliente OAuth).
- No hace falta ninguna API de pago: se usa `ssl-checker.io` (gratis) y RDAP (`rdap.org`, gratis y oficial).

## Los nodos, en orden
1. **Schedule Trigger** — Modo `Days`, cada 1 día, hora 07:00. En Settings del workflow pon Timezone `Europe/Madrid`.
2. **Google Sheets** — Operación `Get Row(s)`, documento `Dominios`, hoja `Hoja 1`. Devuelve una fila por dominio.
3. **Split In Batches** — Batch Size `1`. Así no saturas las APIs públicas.
4. **HTTP Request (SSL)** — Método GET, URL: `https://ssl-checker.io/api/v1/check/{{ $json.dominio }}`. En Settings activa `Always Output Data` y `On Error: Continue (using error output)`.
5. **HTTP Request (dominio)** — Método GET, URL: `https://rdap.org/domain/{{ $('Split In Batches').item.json.dominio }}`. Mismo tratamiento de errores.
6. **Code** — Modo `Run Once for All Items`. Calcula los días que faltan y marca la alerta (código abajo).
7. **IF** — Condición Boolean: `{{ $json.alerta }}` es `true`.
8. **Gmail** — Operación `Send`, para `{{ $json.email_aviso }}`, asunto `Aviso de caducidad: {{ $json.dominio }}`, cuerpo `{{ $json.texto }}`.
9. Vuelve a conectar la salida del IF (rama falsa y verdadera) al **Split In Batches** para que siga con el siguiente dominio.

## El nodo Code
```js
const hoy = new Date();
const salida = [];
for (const item of $input.all()) {
  const d = item.json;
  const fSsl = d.ssl_expira ? new Date(d.ssl_expira) : null;
  const fDom = d.dominio_expira ? new Date(d.dominio_expira) : null;
  const dias = (f) => f ? Math.floor((f - hoy) / 86400000) : null;
  const diasSsl = dias(fSsl);
  const diasDom = dias(fDom);
  const avisos = [];
  if (diasSsl !== null && diasSsl <= 30) avisos.push('El SSL caduca en ' + diasSsl + ' dias');
  if (diasDom !== null && diasDom <= 45) avisos.push('El dominio caduca en ' + diasDom + ' dias');
  salida.push({ json: { dominio: d.dominio, cliente: d.cliente, email_aviso: d.email_aviso, diasSsl, diasDom, alerta: avisos.length > 0, texto: avisos.join(' | ') } });
}
return salida;
```
Antes del Code, en un **Set** o dentro del propio Code, mapea `ssl_expira` desde `result.valid_till` de ssl-checker y `dominio_expira` desde el evento `expiration` del array `events` de la respuesta RDAP.

## Cómo probarla
- Añade a la hoja un dominio tuyo y uno de prueba con `expired.badssl.com`: debe salir alerta inmediata.
- Ejecuta con `Execute Workflow` y revisa la salida del Code: los días deben ser números, no `null`.
- Baja temporalmente los umbrales a 3650 días para forzar que salte el email y comprobar que Gmail envía bien.

## Qué puede salir mal
- **RDAP no cubre bien `.es`**: para dominios `.es` deja la columna `dominio_expira` a mano en la hoja o usa la API gratuita de `whoisjson.com` (500 consultas/mes).
- **Dominio caído**: si el sitio no responde, el nodo SSL da error; por eso está `On Error: Continue`, si no se te para todo el workflow.
- **Zona horaria**: si no fijas `Europe/Madrid` en Settings, en verano se ejecutará a las 09:00.
- **Emails repetidos**: añade una columna `ultimo_aviso` en Sheets y en el IF exige también que la fecha de hoy sea distinta a la del último aviso.

## Cuánto cuesta
n8n auto-alojado: 0 €. ssl-checker y RDAP: gratis. Google Sheets y Gmail: gratis con tu cuenta. Si usas n8n Cloud, el plan Starter (unos 20 €/mes) cubre de sobra 30 ejecuciones diarias.
