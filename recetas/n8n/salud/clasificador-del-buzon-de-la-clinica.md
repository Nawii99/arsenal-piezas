# Clasificador del buzón de la clínica…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Lee el correo que entra, lo etiqueta por tipo (cita, factura, proveedor, urgencia) y contesta al momento lo rutinario, dejando lo demás para una persona.

## Qué es y qué hace

Cada 10 minutos lee los correos nuevos del buzón compartido, los clasifica en seis categorías con un modelo de lenguaje y les pone la etiqueta de Gmail correspondiente. Las consultas rutinarias reciben respuesta con horarios, precios o cómo pedir cita; las quejas y urgencias se destacan y avisan al responsable. Entrada: correos entrantes; salida: etiquetas y respuestas. Se monta en n8n con Gmail y una IA como Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Crear las etiquetas en Gmail
2. Conectar Gmail y el modelo de texto en n8n
3. Probar con correos de ejemplo
4. Que lo revise un profesional

## Cuándo usarla

Cuando el buzón de info@ mezcle peticiones de cita, facturas, comerciales y dudas, y tardes horas en contestar cosas que se responden solas.

## Cómo ganar dinero con ella

Ahorra entre 45 y 90 minutos diarios de recepción y hace que nadie se quede sin respuesta el mismo día, que es donde se pierden pacientes nuevos.

- Ordenar el buzón de clínicas y centros de estética para que nadie se quede sin respuesta.
- Ofrecer el clasificador a gestorías y despachos con buzón compartido.
- Vender el mantenimiento de las respuestas automáticas cuando cambian horarios o tarifas.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Cada 10 minutos revisa el buzón de la clínica, clasifica cada correo nuevo en una de seis categorías con un modelo de lenguaje, le pone la etiqueta de Gmail correspondiente y, en los casos rutinarios, manda una respuesta con la información de siempre (horarios, precios, cómo llegar, cómo pedir cita).
Lo que huele a urgencia o a queja no se contesta solo: se marca como destacado y salta un aviso al móvil del responsable. Sirve a cualquier clínica o centro de bienestar con un buzón compartido.

## Lo que necesitas antes
- Gmail o Google Workspace de la clínica, con las etiquetas ya creadas: Cita, Factura, Proveedor, Info, Urgente, Otros.
- Cuenta en platform.openai.com con saldo y una API key. Con gpt-4o-mini el gasto es ridículo.
- Una hoja de Google Sheets llamada Respuestas-tipo con las columnas: categoria, texto. Ahí escribes tú, en tus palabras, la respuesta estándar de cada tipo.
- n8n.

## Los nodos, en orden
1. **Gmail Trigger**: Poll Times cada 10 minutos, filtro Label IDs = INBOX y la opción Simplify activada para no arrastrar el HTML entero.
2. **Code**: recorta el cuerpo a los primeros 1.200 caracteres, que es de sobra para clasificar y abarata la llamada. Código abajo.
3. **OpenAI** (Message a Model, gpt-4o-mini, Response Format JSON): mensaje de sistema exactamente este: «Eres el clasificador del buzón de una clínica de fisioterapia. Clasifica el correo en una sola categoría: cita, factura, proveedor, info, urgente, otros. Marca urgente si el remitente expresa dolor fuerte, empeoramiento, una queja seria o pide anular algo de hoy. Nunca des consejo médico ni interpretes síntomas: solo clasificas. Responde solo con JSON: {"categoria":"...","resumen":"...","puede_responderse_solo":true|false}.» En el mensaje de usuario pon `Asunto: {{ $json.asunto }} | Cuerpo: {{ $json.cuerpo }}`.
4. **Code**: parsea el JSON con un try/catch para que un JSON mal formado no rompa el flujo.
5. **Gmail** (operación Add Label to Message): etiqueta según la categoría. Necesitas los Label IDs, que ves en el desplegable del propio nodo.
6. **Google Sheets** (Get Rows) sobre Respuestas-tipo.
7. **IF**: `{{ $json.puede_responderse_solo }}` Is True AND `{{ $json.categoria }}` no es `urgente`.
8. Rama verdadera: **Gmail** (Reply to Message) con el texto de la hoja para esa categoría, y un pie que diga «este mensaje es automático; si necesitas algo más, responde y te atiende una persona».
9. Rama falsa: **Gmail** (Add Label) con Importante y **Telegram** (Send Message) o **Gmail** a tu móvil con `{{ $json.categoria }}: {{ $json.resumen }}` y el remitente.
10. **Google Sheets** (Append) sobre una hoja Registro-buzon con fecha, remitente, categoria, respondido. Esto te sirve para ver, al mes, qué preguntan de verdad tus pacientes.

## El trozo de código del nodo 2
```javascript
const salida = [];
for (const item of $input.all()) {
  const m = item.json;
  const cuerpo = String(m.text || m.snippet || '').replace(/\s+/g, ' ').slice(0, 1200);
  salida.push({ json: {
    id: m.id,
    threadId: m.threadId,
    remitente: m.from || (m.headers && m.headers.from) || '',
    asunto: m.subject || '',
    cuerpo
  } });
}
return salida;
```
Y el del nodo 4:
```javascript
let datos = { categoria: 'otros', resumen: '', puede_responderse_solo: false };
try {
  const bruto = $json.message?.content || $json.text || '{}';
  datos = JSON.parse(bruto);
} catch (e) {
  datos.resumen = 'No se pudo clasificar, revisar a mano';
}
return [{ json: { ...$('Code').item.json, ...datos } }];
```

## Cómo probarla
1. Mándate a ti mismo cinco correos de prueba: uno pidiendo cita, uno con una factura de un proveedor, uno preguntando el precio, uno de un comercial y uno diciendo que le duele mucho desde ayer.
2. Ejecuta a mano y mira la clasificación de cada uno antes de conectar nada más. El de dolor debe salir urgente y sin respuesta automática.
3. Desactiva el nodo de responder durante la primera semana y limítate a etiquetar: así ves si acierta antes de dejar que hable con nadie.
4. Cuando lleves 50 correos bien clasificados, activa la respuesta automática solo para la categoría info.

## Qué puede salir mal
- **Responder algo clínico**: es el riesgo principal. Las respuestas tipo salen de tu hoja, escritas por ti, y nunca las genera el modelo. No cambies eso.
- **Falsos negativos en urgente**: revisa el buzón igual una vez al día. La automatización ordena, no sustituye a mirar.
- **Bucles de respuesta**: si contestas a un autorrespondedor, os podéis mandar correos infinitos. Añade un Filter que descarte remitentes que contengan noreply, no-reply o mailer-daemon, y que descarte los correos cuyo asunto ya empiece por Re: dos veces.
- **Límites de Gmail API**: el trigger consume cuota, pero con 10 minutos de intervalo estás lejísimos del tope.
- **Privacidad**: si un paciente cuenta su historial en el correo, ese texto pasa por OpenAI. Recorta a 1.200 caracteres, no mandes adjuntos y, si tu asesoría lo exige, cambia el nodo OpenAI por un modelo local con Ollama en tu propio servidor.

## Cuánto cuesta
- gpt-4o-mini: sobre 0,15 € por cada 1.000 correos clasificados.
- n8n auto-alojado y Gmail: gratis o ya lo pagas.
- Total: menos de 2 € al mes.
