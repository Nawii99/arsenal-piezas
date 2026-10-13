# Formulario de incidencias de clientes que crea la issue…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Es una automatización en n8n que recibe un formulario público de incidencias (Tally, Typeform o Google Forms) mediante webhook.

## Qué es y qué hace

Es una automatización en n8n que recibe un formulario público de incidencias (Tally, Typeform o Google Forms) mediante webhook. Crea una issue en GitHub con los campos ordenados en una plantilla, aplica una etiqueta según la gravedad, avisa por Telegram si es crítica y envía al cliente un email con el número de seguimiento. Se usa en n8n auto-alojado o en la nube.

## Cómo usarla

1. Crea el formulario con los campos
2. Conecta el webhook en n8n y el token de GitHub
3. Prueba con una incidencia de ejemplo
4. Que lo revise un profesional

## Cuándo usarla

Cuando recibes bugs por WhatsApp, email y llamadas, sin capturas ni pasos, y luego no sabes qué te habían contado.

## Cómo ganar dinero con ella

Elimina el ir y venir de correos pidiendo datos (15-20 min por incidencia) y da imagen de empresa seria con seguimiento numerado.

- Soporte técnico para agencias que mantienen webs de varios clientes…
- Gestión de incidencias para equipos de desarrollo pequeños con clientes externos…
- Implantación de seguimiento numerado de incidencias para software a medida…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recoge un formulario público de incidencias, lo convierte en una issue bien formateada en tu repo privado, avisa por Telegram si es crítica y manda al cliente un email de confirmación con la referencia.
Para el desarrollador o la agencia que mantiene webs y aplicaciones de varios clientes.

## Lo que necesitas antes
- Un formulario en Tally.so (gratis, sin límite de respuestas) con los campos: `Tu nombre`, `Tu email`, `Proyecto` (desplegable con tus clientes), `Qué querías hacer`, `Qué ha pasado`, `Pasos para reproducirlo`, `Gravedad` (Baja/Media/Crítica), `Captura` (subida de archivo), `Navegador o dispositivo`.
- En Tally: Integrations > Webhooks > la URL de tu n8n. (Con Typeform o Google Forms el flujo es el mismo cambiando el nodo 1.)
- Token de GitHub con `Issues: Read and write`.
- Credencial de Gmail y bot de Telegram.

## Los nodos, en orden
**1. Webhook** — `POST`, Path `incidencia`, Respond `Immediately`.
**2. Code** («Normalizar el formulario») — Tally envía los campos como array; los convierte en objeto.
**3. Switch** («Repo según proyecto») — Mode `Rules`, Value `={{ $json.proyecto }}`, una regla por cliente que asigne el repo. Alternativa más corta: un mapa dentro del Code del nodo 2.
**4. HTTP Request** («Crear issue») — `POST` `https://api.github.com/repos/{{ $json.repo }}/issues`, Header Auth `Authorization: Bearer TU_TOKEN` y `User-Agent: n8n`, Body Content Type `JSON`, Specify Body `Using JSON`: `={{ JSON.stringify({ title: $json.titulo, body: $json.cuerpo, labels: $json.etiquetas }) }}`.
**5. IF** («¿Es crítica?») — String `{{ $('Normalizar el formulario').item.json.gravedad }}` igual a `Crítica`.
**6. Telegram** — `INCIDENCIA CRÍTICA de {{ ... }}: {{ $json.html_url }}`.
**7. Gmail** — Send al cliente: To `={{ $('Normalizar el formulario').item.json.email }}`, Subject `Hemos recibido tu incidencia (ref. #{{ $json.number }})`, mensaje explicando plazos.

## El código del nodo 2
```javascript
const campos = $input.first().json.body.data.fields || [];
const v = {};
for (const c of campos) {
  let valor = c.value;
  if (Array.isArray(valor)) {
    if (valor.length && valor[0] && valor[0].url) valor = valor.map(f => f.url).join(' ');
    else if (c.options) valor = valor.map(id => (c.options.find(o => o.id === id) || {}).text).join(', ');
    else valor = valor.join(', ');
  }
  v[c.label] = valor;
}
const mapaRepos = { 'Tienda Pepe': 'miusuario/tienda-pepe', 'Clínica Sol': 'miusuario/clinica-sol' };
const proyecto = v['Proyecto'] || 'Sin proyecto';
const gravedad = v['Gravedad'] || 'Media';
const capt = v['Captura'] ? '\n\n### Captura\n' + v['Captura'].split(' ').map(u => '![captura](' + u + ')').join('\n') : '';
const cuerpo = '**Reportado por:** ' + (v['Tu nombre'] || '?') + ' (' + (v['Tu email'] || '?') + ')\n**Gravedad:** ' + gravedad + '\n**Entorno:** ' + (v['Navegador o dispositivo'] || 'no indicado') + '\n\n### Qué quería hacer\n' + (v['Qué querías hacer'] || '-') + '\n\n### Qué ha pasado\n' + (v['Qué ha pasado'] || '-') + '\n\n### Pasos\n' + (v['Pasos para reproducirlo'] || '-') + capt;
const etiquetas = ['bug', 'cliente', gravedad === 'Crítica' ? 'p1' : gravedad === 'Media' ? 'p2' : 'p3'];
return [{ json: { repo: mapaRepos[proyecto] || 'miusuario/soporte', titulo: '[' + proyecto + '] ' + String(v['Qué ha pasado'] || 'Incidencia').slice(0, 70), cuerpo, etiquetas, email: v['Tu email'], nombre: v['Tu nombre'], gravedad } }];
```

## Cómo probarla
1. Rellena el formulario tú mismo con datos falsos y una captura, y mira el JSON crudo que llega al Webhook: los `label` deben coincidir exactamente con los que usas en el Code (tildes incluidas).
2. Comprueba que la issue se crea con la captura visible. Ojo: las URLs de archivos de Tally pueden caducar; si necesitas permanencia, añade un nodo que descargue la imagen y la suba a Google Drive con enlace público.
3. Manda una crítica y comprueba el Telegram.

## Qué puede salir mal
- **Spam en el formulario**: activa el captcha de Tally y añade un IF que descarte emails sin `@` o dominios desechables.
- **Repo equivocado**: si el desplegable de proyecto no coincide con las claves del mapa, todo va al repo `soporte`. Es la red de seguridad, revísalo de vez en cuando.
- **Cliente que ve la issue**: los repos privados no son visibles para él, por eso el email de confirmación solo lleva el número, no el enlace.
- **404 al crear la issue**: si el repo tiene las issues desactivadas (Settings > Features), la API responde 410. Actívalas.
- **Duplicados**: si el cliente pulsa enviar dos veces, tendrás dos issues. Añade un `Google Sheets` con el ID de respuesta de Tally si te preocupa.

## Cuánto cuesta
Tally gratis (formularios y respuestas ilimitadas; la subida de archivos está en el plan gratuito con límites de tamaño). GitHub, Gmail, Telegram y n8n auto-alojado, gratis.
