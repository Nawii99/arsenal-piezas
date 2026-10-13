# Prueba sintética diaria de tus formularios de contacto…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Cada día envía un formulario de prueba real a tu propia web con un código único y comprueba que el email llega al buzón; si no llega en 10 minutos, te avisa.

## Qué es y qué hace

Cada día envía a tu propia web un formulario de prueba con un código único, usando la misma petición POST que el navegador, y comprueba en la bandeja de Gmail que el correo llega. Si no aparece en diez minutos, avisa. Entrada: URL del formulario, campos esperados y cuenta de Gmail. Salida: resultado diario y aviso de fallo. Se monta en n8n y puede replicarse con Make o Zapier. Usa un nombre de prueba para no confundirlo con leads reales.

## Cómo usarla

1. Copia la petición POST desde F12
2. Crea la regla PRUEBA AUTOMATICA
3. Programa el envío diario
4. Desactiva la prueba si cambias el formulario

## Cuándo usarla

Cuando dependes de los formularios para conseguir clientes y quieres detectar el día que dejan de enviar, no el mes siguiente al ver que no entra nada.

## Cómo ganar dinero con ella

Un formulario roto dos semanas puede costar miles de euros en presupuestos perdidos. Esta comprobación cuesta 0 € y 45 minutos de montaje.

- Vigilancia de formularios para clínicas y consultoras que viven de los contactos web.
- Control de calidad de la web para agencias con formularios en varios clientes.
- Servicio mensual de comprobación de formularios con informe de fallos para pymes.

**Precio orientativo:** 80–150 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Simula un envío de formulario como si fuera un visitante y luego verifica en la bandeja de entrada que ese envío concreto ha llegado.
Es la única forma fiable de saber que la cadena entera (formulario, plugin, SMTP, filtros antispam) sigue funcionando.

## Lo que necesitas antes
- n8n.
- Saber a qué URL envía tu formulario: abre la web, pulsa F12, pestaña `Network`, envía el formulario a mano y mira la petición POST (su URL y los campos que manda). En WordPress con Contact Form 7 suele ser `/wp-json/contact-form-7/v1/contact-forms/ID/feedback`.
- Cuenta de Gmail (o el buzón donde caen los avisos) conectada en n8n.
- Un webhook de Slack o el nodo Gmail para el aviso.
- Una regla en tu CRM o en tu bandeja para no confundir estas pruebas con leads reales: usa siempre el nombre `PRUEBA AUTOMATICA`.

## Los nodos, en orden
1. **Schedule Trigger** — `Days`, cada 1 día, 08:15, timezone `Europe/Madrid`.
2. **Code** — genera el código único de la prueba (código abajo).
3. **HTTP Request** — POST a la URL del formulario. Body Content Type `Form-Data` (o `multipart/form-data` según el plugin), con los campos exactos que viste en F12: `your-name` = `PRUEBA AUTOMATICA`, `your-email` = tu email, `your-message` = `Comprobacion {{ $json.codigo }}`. Añade header `User-Agent: Mozilla/5.0`. `On Error: Continue`.
4. **IF** — la respuesta contiene `mail_sent` o el código HTTP es 200. Si no, salta directo al aviso `el formulario devolvió error`.
5. **Wait** — `Amount: 10`, `Unit: Minutes`. Con `Resume: After Time Interval`.
6. **Gmail** — `Get Many Messages`, filtro `Search: {{ $('Code').item.json.codigo }}`, límite 5.
7. **IF** — `{{ $items().length }}` mayor que `0`.
8. Rama NO: **Slack** `Send Message` con texto `El formulario de contacto de tudominio.com no ha entregado el correo de prueba de las {{ $now.format('HH:mm') }}`.
9. Rama SÍ: **Gmail** `Delete` o `Add Label` para archivar la prueba y no ensuciar la bandeja.

## El nodo Code
```js
const codigo = 'PRB-' + new Date().toISOString().slice(0,10).replace(/-/g,'') + '-' + Math.random().toString(36).slice(2,8).toUpperCase();
return [{ json: { codigo, nombre: 'PRUEBA AUTOMATICA', email: 'tucorreo+prueba@gmail.com' } }];
```

## Cómo probarla
- Ejecútala a mano y comprueba que te llega el email con el código en el cuerpo.
- Rompe el formulario a propósito (desactiva el plugin de envío 1 minuto) y vuelve a ejecutar: debe llegarte el aviso de Slack.
- Comprueba que el email de prueba no acaba en tu CRM como lead real; si tu CRM entra por el mismo formulario, añade una regla que descarte los que contengan `PRUEBA AUTOMATICA`.

## Qué puede salir mal
- **reCAPTCHA v3 o v2**: si el formulario lleva captcha, el envío automático fallará siempre. Solución: crea un formulario duplicado en una URL oculta (`/comprobacion-interna`) sin captcha y prueba ese; comparte el mismo canal de envío de correo, que es lo que quieres vigilar.
- **Honeypot**: si tu plugin usa campo trampa, deja ese campo vacío en el POST.
- **Retraso del correo**: 10 minutos es un margen razonable; si tu SMTP es lento, sube el Wait a 20.
- **Índice de Gmail**: la búsqueda de Gmail tarda unos segundos en indexar. Si te da falsos negativos, busca por `subject:` en lugar de por el cuerpo.
- **Zona horaria**: fija `Europe/Madrid` en Settings del workflow.

## Cuánto cuesta
0 €. Una ejecución diaria con un Wait de 10 minutos cabe en cualquier plan, incluido el gratuito de n8n auto-alojado.
