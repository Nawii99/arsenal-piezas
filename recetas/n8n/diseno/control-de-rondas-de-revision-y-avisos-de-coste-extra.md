# Control de rondas de revisión y avisos de coste extra…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Cuenta las rondas de cambios de cada proyecto a partir de los correos del cliente y te avisa cuando se pasa de las incluidas en el presupuesto.

## Qué es y qué hace

Vigila una etiqueta de Gmail donde metes los correos de cambios, suma una ronda al proyecto correspondiente en una hoja y, al superar las incluidas, prepara un borrador que avisa de que cada ronda extra se factura. Entrada: correos etiquetados; salida: contador y borrador. Se monta en n8n con Gmail y Sheets.

## Cómo usarla

1. Crea la etiqueta Cambios
2. Rellena la hoja Rondas con el precio extra
3. Prueba con un correo de ensayo
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando los proyectos se alargan con cambios infinitos y nunca sabes en qué ronda vas ni te atreves a cobrar los extras porque no lo tienes anotado.

## Cómo ganar dinero con ella

Recuperar dos rondas extra al año a 150 € cada una son 300 € directos, además de acabar los proyectos antes.

- Control de alcance para estudios que cobran rondas de revisión extra.
- Seguimiento de presupuestos cerrados para freelances con clientes exigentes.
- Gestión de cambios para agencias que quieren facturar cada revisión.

**Precio orientativo:** 40–120 € por puesta en marcha. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una etiqueta de Gmail donde metes los correos de cambios, suma una ronda al proyecto correspondiente y, al superar el número pactado, te prepara un borrador de email avisando de que a partir de ahí se factura. Para freelances y estudios que trabajan por presupuesto cerrado.

## Lo que necesitas antes
- n8n.
- Gmail conectado por OAuth (Gmail API activada en console.cloud.google.com).
- Una etiqueta en Gmail llamada `Cambios`. Puedes crear un filtro que la aplique sola a los correos de tus clientes.
- Hoja «Rondas» con columnas: `proyecto`, `email_cliente`, `rondas_incluidas`, `rondas_usadas`, `precio_ronda_extra`.
- Que el asunto de los correos incluya el nombre del proyecto, o al menos que el cliente esté en la hoja.

## Los nodos, en orden
1. **Gmail Trigger** — Poll Times: Every 15 Minutes. Filters > Label Names: `Cambios`. Options > Download Attachments: off.
2. **Google Sheets** — Operation: Get Row(s), hoja «Rondas», sin filtro (traemos todo para cruzar).
3. **Code** — Mode: Run Once for All Items. Cruza el remitente del correo con la fila de proyecto y calcula la ronda nueva. Código abajo.
4. **Google Sheets** — Operation: Update Row. Matching Column `proyecto`. Campo `rondas_usadas` = `={{ $json.rondas_usadas }}`.
5. **IF** — Number condition: `{{ $json.rondas_usadas }}` larger than `{{ $json.rondas_incluidas }}`.
6. Rama true: **Gmail** — Operation: Draft (borrador, no envío directo, así lo revisas tú). To: `={{ $json.email_cliente }}`. Subject: `Rondas de revisión de {{ $json.proyecto }}`. Message: `Hola, esta es la ronda {{ $json.rondas_usadas }} y el presupuesto incluía {{ $json.rondas_incluidas }}. Puedo aplicar los cambios sin problema; a partir de aquí cada ronda son {{ $json.precio_ronda_extra }} € + IVA. ¿Te lo confirmo y sigo?`
7. Rama true: **Slack** (o Gmail a ti mismo) — Send Message: `Ojo: {{ $json.proyecto }} va por la ronda {{ $json.rondas_usadas }} de {{ $json.rondas_incluidas }}. Tienes un borrador listo en Gmail.`
8. Rama false: **NoOp** para cerrar el flujo limpio.

## El nodo Code
```javascript
const filas = $('Google Sheets').all().map(i => i.json);
const salida = [];
for (const correo of $('Gmail Trigger').all()) {
  const de = (correo.json.from?.value?.[0]?.address || correo.json.From || '').toLowerCase();
  const asunto = (correo.json.subject || '').toLowerCase();
  const fila = filas.find(f =>
    (f.email_cliente || '').toLowerCase() === de ||
    asunto.includes((f.proyecto || '').toLowerCase())
  );
  if (!fila) continue;
  salida.push({ json: {
    ...fila,
    rondas_usadas: Number(fila.rondas_usadas || 0) + 1,
    rondas_incluidas: Number(fila.rondas_incluidas || 2),
  }});
}
return salida;
```

## Cómo probarla
Crea una fila de prueba con `rondas_incluidas` = 1 y `rondas_usadas` = 0. Mándate un correo a ti mismo con el nombre del proyecto en el asunto y ponle la etiqueta `Cambios` a mano. Ejecuta en test: la hoja debe pasar a 1 y, al repetir, a 2 y generarse el borrador.

## Qué puede salir mal
- **Cuenta correos que no son cambios**: sé estricto con el filtro de la etiqueta; mejor etiquetar a mano que contar de más.
- **Hilos largos**: cada respuesta del cliente en el mismo hilo suma una ronda. Si te molesta, añade en el Code un descarte si el asunto empieza por `Re:` más de dos veces, o cuenta por día con `new Date()`.
- **Cliente con varios proyectos**: obliga a que el nombre del proyecto vaya en el asunto y quita el cruce por email del Code.
- **Envío accidental**: usa siempre Draft, nunca Send, en el aviso de dinero.

## Cuánto cuesta
Gratis. n8n auto-alojado, Gmail y Sheets con cuenta normal. Slack tiene plan gratuito de sobra para avisos.
