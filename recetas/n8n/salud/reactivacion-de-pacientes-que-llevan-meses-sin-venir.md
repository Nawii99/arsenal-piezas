# Reactivación de pacientes que llevan meses sin venir…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Detecta cada semana quién no pisa la clínica desde hace 6 meses y le manda un email o WhatsApp con un motivo concreto para volver, en tandas pequeñas.

## Qué es y qué hace

Cada lunes revisa la hoja de pacientes, selecciona los que llevan entre 6 y 18 meses sin visita y prepara un email personalizado según el tratamiento que recibieron. Lo envía en tandas diarias pequeñas para proteger el dominio de correo. Entrada: hoja Pacientes; salida: correos enviados y registro. Se monta en n8n con Google Sheets y Gmail, con un modelo de texto como Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Preparar la hoja Pacientes con sus columnas
2. Conectar Sheets y Gmail en n8n
3. Revisar la plantilla de email con el equipo
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tengas un histórico de pacientes antiguos parado en una hoja o en tu software de gestión y dependas demasiado de captar gente nueva.

## Cómo ganar dinero con ella

Recuperar 5 pacientes dormidos al mes a 50 € de ticket son 250 € que no cuestan publicidad. La captación equivalente en Meta Ads costaría 100-150 €.

- Reactivar pacientes de clínicas de fisioterapia o estética con una campaña de recuperación.
- Ofrecer a clínicas dentales un envío mensual de recordatorios personalizados.
- Montar la base de pacientes inactivos y su seguimiento para una óptica.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Cada lunes revisa la hoja de pacientes, saca a los que llevan entre 6 y 18 meses sin ninguna visita, prepara un email personalizado según el tratamiento que hicieron y lo manda en tandas de 20 al día para no quemar el dominio.
Sirve a fisioterapias, clínicas dentales, centros de estética, ópticas o nutricionistas con una base de datos vieja que nadie toca.

## Lo que necesitas antes
- Una hoja de Google Sheets llamada Pacientes con estas columnas exactas: nombre, email, telefono, ultima_visita (formato AAAA-MM-DD), tratamiento, consentimiento_marketing (SI o NO), reactivado_el.
- Si usas un software de gestión, exporta a CSV una vez y súbelo a esa hoja; lo importante es tener las columnas.
- Cuenta de Gmail o Google Workspace de la clínica.
- Opcional pero recomendable: cuenta en platform.openai.com con 5 € de saldo y una API key, para que el email suene humano y no a plantilla.
- Aviso legal: solo puedes escribir a quien tenga consentimiento_marketing en SI. Sin eso, la comunicación comercial no es legal en España.

## Los nodos, en orden
1. **Schedule Trigger**: `0 8 * * 1-5`, de lunes a viernes a las 8:00, zona Europe/Madrid.
2. **Google Sheets** (Get Rows) sobre la hoja Pacientes, Return All activado.
3. **Code**: filtra y ordena a los candidatos. Código completo abajo.
4. **Limit**: Max Items 20. Es el freno que evita que Gmail te marque como spam por enviar 400 correos de golpe.
5. **OpenAI** (nodo Message a Model, modelo gpt-4o-mini): en el mensaje de sistema pon «Eres el recepcionista de una clínica de fisioterapia en Valencia. Escribes emails breves, cercanos y sin promesas médicas. Nunca hables de diagnóstico ni de resultados garantizados. Máximo 90 palabras, tuteando, y acaba invitando a responder a este email para pedir cita.» En el mensaje de usuario: `Paciente: {{ $json.nombre }}. Último tratamiento: {{ $json.tratamiento }}. Última visita: hace {{ $json.meses }} meses. Escribe el cuerpo del email.`
6. **Gmail** (Send): To `{{ $('Code').item.json.email }}`, Subject `{{ $('Code').item.json.nombre }}, ¿cómo vas de la espalda?` (ajusta al tratamiento), Message el texto que devuelve OpenAI, y en las opciones añade al pie: «Si no quieres recibir más mensajes, responde BAJA a este correo.»
7. **Google Sheets** (Update Row): escribe `{{ $now.toISO() }}` en la columna reactivado_el usando el email como columna de búsqueda.
8. **Wait**: 45 segundos entre envíos, para no disparar los límites de Gmail. Colócalo dentro del bucle si usas Split In Batches con lote 1.

## El trozo de código del nodo 3
```javascript
const hoy = new Date();
const salida = [];
for (const item of $input.all()) {
  const p = item.json;
  if (String(p.consentimiento_marketing).toUpperCase() !== 'SI') continue;
  if (!p.email || !p.ultima_visita) continue;
  if (p.reactivado_el) continue;
  const ultima = new Date(p.ultima_visita);
  if (isNaN(ultima)) continue;
  const meses = Math.floor((hoy - ultima) / (1000 * 60 * 60 * 24 * 30.4));
  if (meses < 6 || meses > 18) continue;
  salida.push({ json: { nombre: p.nombre, email: p.email, tratamiento: p.tratamiento || 'una sesión', meses } });
}
salida.sort((a, b) => a.meses - b.meses);
return salida;
```
Los ordena de menos a más meses porque el que se fue hace poco es el más fácil de recuperar.

## Cómo probarla
1. Pon dos filas de prueba con tu propio email: una con última visita de hace 8 meses y consentimiento SI, otra de hace 3 años.
2. Ejecuta a mano: en el nodo Code solo debe salir la primera.
3. Mira el texto que devuelve OpenAI antes de conectar Gmail. Si suena a robot, aprieta el mensaje de sistema.
4. Desactiva el nodo Gmail (clic derecho > Deactivate) las primeras veces y revisa 10 borradores usando la operación Create Draft en vez de Send.
5. Cuando te convenza, cambia a Send y activa el flujo.

## Qué puede salir mal
- **Gmail te corta**: una cuenta normal permite unos 500 envíos al día y Workspace 2.000, pero enviar de golpe huele a spam. El Limit de 20 al día es lo que mantiene la entregabilidad.
- **Fechas mal leídas**: si la hoja tiene las fechas como 12/03/2024, `new Date()` lo interpreta mal. Fuerza el formato AAAA-MM-DD en la columna con Formato > Fecha personalizada.
- **Escribir dos veces al mismo**: la columna reactivado_el es el freno. Si la borras, vuelves a empezar.
- **Bajas**: monta un segundo flujo con **Gmail Trigger** que busque correos cuyo asunto o cuerpo contenga BAJA y ponga consentimiento_marketing en NO. Es obligatorio atender la baja.
- **Nada de salud personal en el prompt**: no metas diagnósticos ni informes en el mensaje a OpenAI; con el tipo de tratamiento genérico sobra.

## Cuánto cuesta
- n8n auto-alojado: gratis.
- Google Sheets y Gmail: gratis con cuenta personal; Workspace desde 6 € al mes.
- OpenAI con gpt-4o-mini: unos 0,02 € por 100 emails. Con 5 € de saldo tienes para años.
- Total: prácticamente 0 € al mes.
