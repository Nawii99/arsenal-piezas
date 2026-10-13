# Avisos de seguimiento a 7 y 15 dias…

**Tipo:** Receta de automatización · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Recordatorio automático a los 7 y 15 días sin respuesta, con el mensaje de seguimiento redactado.

## Qué es y qué hace

Receta de n8n que revisa cada mañana, de lunes a viernes, la hoja de candidaturas y, si una lleva 7 días sin movimiento, te avisa por Telegram con un mensaje de seguimiento ya redactado. A los 15 días propone cerrarla. Entra la hoja con estado y fechas, y sale un aviso y una marca para no repetirlo. Requiere el panel de candidaturas previo. El texto puede redactarlo Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Ten listo el panel de candidaturas
2. Crea el bot con BotFather y saca tu chat id
3. Programa el flujo diario de lunes a viernes
4. Revisa los dos avisos de prueba

## Cuándo usarla

Cuando envias y luego nunca haces seguimiento, o lo haces a destiempo y quedas pesado.

## Cómo ganar dinero con ella

Se vende junto al panel como pack de seguimiento: 90 EUR los dos flujos montados y probados en la cuenta del candidato.

- Pack de seguimiento para candidatos: dos flujos montados y probados en su propia cuenta.
- Recordatorios de seguimiento para autónomos que envían presupuestos y no quieren perder clientes.
- Servicio de avisos automáticos para bolsas de empleo que llevan decenas de procesos abiertos.

**Precio orientativo:** 90–100 € por pack montado. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Avisos de seguimiento a 7 y 15 dias (n8n)

## Que hace
Cada manana de lunes a viernes revisa la hoja Candidaturas. Si una candidatura lleva 7 dias sin moverse, te manda un aviso por Telegram con el mensaje de seguimiento ya redactado. A los 15 dias te manda el segundo aviso y te propone cerrarla. Marca en la hoja lo que ya te ha avisado para no repetirse.

## Requisito previo
Necesitas la hoja de la receta Panel de candidaturas en Google Sheets, con las columnas Estado, Fecha ultimo movimiento, Seguimiento 7 y Seguimiento 15, y las cabeceras sin tildes.

## Cuentas y limites gratuitos
- Telegram: gratis y sin limite practico. Abre @BotFather en Telegram, manda /newbot, copia el token. Luego escribe a tu bot un hola y saca tu chat id con @userinfobot.
- Google: gratis.
- n8n: 14 dias de prueba en la nube oficial, o autoalojado gratis. Un flujo diario no consume casi nada.
- Alternativa al bot: nodo Gmail y que se mande el aviso a tu correo. Funciona igual, se lee peor en el movil.

## Nodo 1: Schedule Trigger
- Modo: Custom (Cron).
- Expresion: 30 8 * * 1-5 (lunes a viernes a las 8:30).
- Zona horaria del workflow: Europe/Madrid. Compruebala en Settings del workflow, no en el nodo.

## Nodo 2: Google Sheets
- Operacion: Get Row(s).
- Documento Candidaturas, hoja Registro. Sin filtros: filtramos despues.

## Nodo 3: Code (JavaScript)
Pega esto tal cual:
const hoy = new Date();
const salida = [];
for (const item of $input.all()) {
  const f = item.json;
  const estado = (f['Estado'] || '').trim().toLowerCase();
  if (estado !== 'enviada' && estado !== 'leida' && estado !== 'respuesta automatica') continue;
  const ref = new Date(f['Fecha ultimo movimiento'] || f['Fecha envio']);
  if (isNaN(ref)) continue;
  const dias = Math.floor((hoy - ref) / 86400000);
  if (dias >= 7 && dias < 15 && (f['Seguimiento 7'] || '').toLowerCase() !== 'si') {
    salida.push({ json: { ...f, dias, aviso: '7' } });
  }
  if (dias >= 15 && (f['Seguimiento 15'] || '').toLowerCase() !== 'si') {
    salida.push({ json: { ...f, dias, aviso: '15' } });
  }
}
return salida;

## Nodo 4: Switch
- Campo a evaluar: {{ $json.aviso }}.
- Salida 1 cuando vale 7. Salida 2 cuando vale 15.

## Nodo 5a: Telegram (rama de 7 dias)
- Operacion: Send Message. Chat ID: el tuyo.
- Texto (modo expresion):
7 dias sin respuesta: {{ $json.Empresa }} - {{ $json.Puesto }}
Enviada el {{ $json['Fecha envio'] }} por {{ $json.Portal }}
Mensaje para copiar:
Hola {{ $json.Contacto || 'buenos dias' }}, escribo por la vacante de {{ $json.Puesto }}. Envie mi candidatura el {{ $json['Fecha envio'] }} y sigo muy interesado. Si el proceso continua abierto, quedo a vuestra disposicion. Gracias.

## Nodo 5b: Telegram (rama de 15 dias)
- Texto (modo expresion):
15 dias sin respuesta: {{ $json.Empresa }} - {{ $json.Puesto }}
Ultimo intento y la cierras. Si hoy tampoco contestan, pon Estado = Sin respuesta.
Mensaje para copiar:
Hola, vuelvo a escribir por la vacante de {{ $json.Puesto }}. Si ya habeis cubierto el puesto no hay problema: agradeceria que me lo digais para dejar de estar pendiente, y si podeis contarme que me ha faltado, mejor todavia. Gracias por el tiempo.

## Nodo 6: Google Sheets (marcar el aviso)
- Operacion: Append or Update Row. Columna de busqueda: ID.
- Si la rama es de 7 dias, escribe si en la columna Seguimiento 7.
- Si es de 15 dias, escribe si en Seguimiento 15 y pon Proximo paso = Cerrar si no contestan.
- Conecta las dos ramas de Telegram a este nodo.

## Como probarla sin liarla
1. En la hoja de pruebas mete dos filas: una con Fecha ultimo movimiento de hace 8 dias y otra de hace 20, ambas con Estado Enviada y Seguimiento 7 y 15 en no.
2. Ejecuta el flujo a mano con Execute Workflow. Deben llegarte dos mensajes de Telegram.
3. Vuelve a ejecutarlo: no debe llegarte nada. Si llega otra vez, el nodo 6 no esta escribiendo bien el si.
4. Borra las filas de prueba y activa el workflow.

## Avisos honestos
- Un seguimiento a los 7 dias y otro a los 15. Se acabo. Escribir cada tres dias no acelera nada y te quema con esa empresa.
- Si la oferta dice expresamente que no contactes, no contactes: apuntala y espera.
- El flujo no manda nada solo: te avisa a ti y tu decides y copias. Automatizar el envio de mensajes a reclutadores desde LinkedIn se detecta y te pueden restringir la cuenta.
