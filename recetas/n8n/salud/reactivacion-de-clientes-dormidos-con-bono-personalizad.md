# Reactivación de clientes dormidos con bono personalizad…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Detecta cada semana quién no ha vuelto en más de 90 días, mira qué servicio compraba antes y le manda un email con una propuesta hecha a su medida.

## Qué es y qué hace

Flujo de n8n que cada lunes lee un historial de sesiones en Google Sheets, detecta a quien lleva más de 90 días sin volver y le envía por correo una propuesta según su último servicio. Registra cada envío en una pestaña para no repetirlo. Entran nombre, correo, servicio, fecha e importe; sale un correo personalizado y el registro. Requiere Gmail y Google Sheets conectados en n8n.

## Cómo usarla

1. 1. Exporta el historial de sesiones a la hoja Historial
2. 2. Crea la pestaña Reactivados y conecta Gmail
3. 3. Revisa el texto de la propuesta antes de activar el envío
4. Que lo revise un profesional

## Cuándo usarla

Cuando llevas más de un año abierto y tienes una base de clientes antiguos que se fueron apagando sin que nadie los llamara. Vale para gimnasios, nutrición, masajes u osteopatía.

## Cómo ganar dinero con ella

Recuperar 5 clientes al mes que gastan 60 euros son 300 euros mensuales de facturación que ya estaba muerta, sin gastar ni un euro en publicidad.

- Recuperación de clientes para gimnasios o estudios de masajes que tienen una base de clientes antiguos apagada.
- Campañas de reactivación para fisioterapeutas o nutricionistas que pierden pacientes sin seguimiento.
- Propuestas personalizadas de reactivación para centros de bienestar que quieren volver a llenar la agenda.

**Precio orientativo:** 150–350 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada lunes revisa tu histórico de sesiones, calcula quién lleva más de 90 días sin pasar por el centro y le manda un correo personalizado según el último servicio que compró.
Para cualquier negocio de salud y bienestar con clientes recurrentes y una hoja o export de sesiones realizadas.

## Lo que necesitas antes
- n8n instalado (auto-alojado gratis; n8n Cloud solo tiene una prueba gratuita temporal y después es de pago).
- Una hoja de Google Sheets «Historial» con columnas: Nombre, Email, Servicio, Fecha sesion, Importe. Puedes exportarla de tu software de citas una vez a la semana o volcarla a mano.
- Una segunda pestaña «Reactivados» que hará de registro para no repetir envíos.
- Cuenta de Gmail o Google Workspace. Credencial en n8n: «Gmail OAuth2».
- Opcional: un canal de Slack para el aviso interno. Credencial «Slack API» con un bot token de api.slack.com/apps.

## Los nodos, en orden
1. **Schedule Trigger**: modo «Cron», expresión 0 9 * * 1 (lunes a las 9:00). Zona horaria Europe/Madrid.
2. **Google Sheets** (Get Rows) sobre la pestaña «Historial»: trae todas las filas.
3. **Google Sheets** (Get Rows) sobre «Reactivados»: trae los emails ya contactados en los últimos 6 meses.
4. **Code** (nombre: «Calcular dormidos»): agrupa por email, se queda con la última fecha de cada persona, filtra los que pasan de 90 días y descarta los ya contactados. Código abajo.
5. **IF**: comprueba que hay al menos un item. Si no, termina.
6. **Split In Batches**: «Batch Size» = 1, para no disparar 80 correos de golpe y que Gmail te marque como spam.
7. **Gmail** (Send Message): asunto y cuerpo con expresiones de n8n, por ejemplo asunto «{{$json.nombre}}, te guardamos tu hueco» y cuerpo con el servicio que solía contratar y una oferta concreta.
8. **Google Sheets** (Append Row) sobre «Reactivados»: email, fecha de envío y servicio ofertado.
9. **Wait**: 90 segundos entre envíos. Con Batch Size 1 y este Wait quedas muy por debajo de cualquier límite.
10. **Slack** (Send Message) al final: resumen con cuántos correos han salido esa semana.

## El código del nodo Code
```javascript
const historial = $('Google Sheets').all();
const yaContactados = new Set($('Google Sheets1').all().map(i => (i.json.Email || '').toLowerCase()));
const ultimos = {};
for (const item of historial) {
  const f = item.json;
  const email = (f.Email || '').toLowerCase();
  if (!email) continue;
  const fecha = new Date(f['Fecha sesion']);
  if (!ultimos[email] || fecha > ultimos[email].fecha) {
    ultimos[email] = { fecha, nombre: f.Nombre, servicio: f.Servicio, importe: f.Importe };
  }
}
const hoy = new Date();
const salida = [];
for (const [email, d] of Object.entries(ultimos)) {
  const dias = Math.floor((hoy - d.fecha) / 86400000);
  if (dias >= 90 && dias <= 400 && !yaContactados.has(email)) {
    salida.push({ json: { email, nombre: d.nombre, servicio: d.servicio, dias } });
  }
}
return salida;
```

## Cómo probarla
- Mete tres filas de prueba en «Historial» con fechas de hace 30, 100 y 500 días. Solo debe salir la de 100.
- Ejecuta con «Execute Workflow» y revisa la salida del nodo Code antes de conectar Gmail.
- Manda el primer lote a tu propio correo cambiando el destinatario a mano.

## Qué puede salir mal
- **Correos duplicados** si te saltas la pestaña «Reactivados». Es el nodo más importante del flujo.
- **Formato de fecha**: si la hoja guarda 05/03/2026 en vez de 2026-03-05, JavaScript lo interpreta mal. Formatea la columna como AAAA-MM-DD en Sheets.
- **Gmail te limita** a unos 500 correos al día en cuenta gratuita y 2.000 en Workspace. Con el Wait de 90 segundos no llegarás.
- **RGPD**: solo escribe a quien te dio su consentimiento y mete siempre un enlace de baja en el pie del correo.
- **Tope de 400 días**: evita escribir a gente de hace tres años que ya ni te recuerda.

## Cuánto cuesta
- n8n auto-alojado y Google Sheets: 0 euros.
- Gmail personal: gratis. Google Workspace: desde 6 euros al mes por usuario.
- Slack: plan gratuito suficiente.
