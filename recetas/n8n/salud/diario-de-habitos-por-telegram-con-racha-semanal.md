# Diario de hábitos por Telegram con racha semanal…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Un bot te pregunta cada noche por tus tres hábitos, lo apunta en una hoja y los domingos te manda el resumen con tu racha y tu porcentaje.

## Qué es y qué hace

Un bot de Telegram pregunta cada noche por tus hábitos con botones, guarda las respuestas en Google Sheets y los domingos calcula racha y porcentaje de cumplimiento. Entrada: respuestas diarias; salida: registro semanal y resumen. Se monta en n8n con el nodo de Telegram y puede darse como servicio a clientes de coaching.

## Cómo usarla

1. Crea el bot con @BotFather y guarda el token en n8n
2. Prepara la hoja Habitos
3. Programa el aviso nocturno y el resumen del domingo
4. Que lo revise un profesional

## Cuándo usarla

Cuando quieres seguir hábitos propios o los de tus clientes (agua, pasos, sueño, entrenamiento) sin pagar una app de suscripción ni depender de que nadie recuerde abrirla.

## Cómo ganar dinero con ella

Sustituye apps de seguimiento de 5 a 10 euros al mes. Si lo ofreces como servicio a tus clientes de coaching, justifica 20 euros más al mes por cliente.

- Configuración de un diario de hábitos por Telegram para clientes de coaching personal.
- Seguimiento semanal de hábitos y resumen automático para un programa de bienestar de ocho semanas.
- Plantilla de hábitos personalizable para nutricionistas que quieren seguimiento sin app de pago.

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada noche a las 21:30 el bot te escribe con botones para marcar tus hábitos del día, guarda la respuesta y los domingos calcula racha, porcentaje de cumplimiento y el hábito que peor llevas.
Es gestión de hábitos, no consejo médico: registra lo que tú declaras y te devuelve tus propios números.

## Lo que necesitas antes
- n8n instalado y accesible desde internet si quieres los botones (con n8n cloud ya lo es; auto-alojado necesita una URL pública, por ejemplo con un túnel de Cloudflare gratis).
- Bot de Telegram: escribe a @BotFather, /newbot, copia el token. Credencial «Telegram API» en n8n.
- Tu chat id: escribe a tu bot y abre https://api.telegram.org/bot TU_TOKEN /getUpdates.
- Hoja «Habitos» en Google Sheets con columnas: Fecha, Chat id, Agua, Pasos, Entreno, Sueno, Nota.

## Los nodos, en orden
1. **Schedule Trigger**: Cron 30 21 * * * , zona Europe/Madrid.
2. **Telegram** (Send Message): texto «¿Qué tal ha ido hoy? Responde con 4 letras: agua, pasos, entreno, sueño. Ejemplo: SNSS». Activa «Reply Markup» con teclado si prefieres botones.
3. **Telegram Trigger** (flujo aparte, evento «message»): recibe la respuesta.
4. **Code** (nombre: «Parsear respuesta»): convierte el texto en las cuatro columnas. Código abajo.
5. **IF**: si el texto no tiene 4 letras válidas, el bot responde «no te he entendido, escribe algo como SNSS» y termina.
6. **Google Sheets** (Append or Update Row): clave la Fecha, para que si contestas dos veces se sobrescriba en vez de duplicar.
7. **Telegram** (Send Message): confirmación corta con emoji de check.
8. En un tercer flujo, **Schedule Trigger** Cron 0 10 * * 0 (domingos a las 10:00).
9. **Google Sheets** (Get Rows) sobre «Habitos» de los últimos 7 días.
10. **Code** (nombre: «Resumen semanal»): calcula porcentaje por hábito, racha de días seguidos con al menos 3 síes y el peor hábito.
11. **Telegram** (Send Message): el resumen en texto plano, con la racha destacada.

## El código del nodo Code
```javascript
const texto = ($json.message?.text || '').trim().toUpperCase();
const chatId = $json.message?.chat?.id;
if (!/^[SN]{4}$/.test(texto)) {
  return [{ json: { valido: false, chatId } }];
}
const hoy = new Date().toLocaleDateString('sv-SE', { timeZone: 'Europe/Madrid' });
return [{ json: {
  valido: true,
  chatId,
  Fecha: hoy,
  Agua: texto[0] === 'S' ? 1 : 0,
  Pasos: texto[1] === 'S' ? 1 : 0,
  Entreno: texto[2] === 'S' ? 1 : 0,
  Sueno: texto[3] === 'S' ? 1 : 0
}}];
```

## Cómo probarla
- Ejecuta el flujo de envío a mano y responde al bot con SNSS. Mira que aparece una fila nueva en la hoja con 1,0,1,1.
- Responde con «hola» y comprueba que el bot te corrige en vez de guardar basura.
- Para el resumen, mete a mano 7 filas de días anteriores y ejecuta el flujo del domingo.

## Qué puede salir mal
- **El Telegram Trigger necesita el workflow activo**, no basta con «Execute Workflow». Actívalo con el interruptor de arriba a la derecha.
- **Fecha en formato sueco (sv-SE)**: se usa porque devuelve AAAA-MM-DD directamente, que es lo que ordena bien en Sheets.
- **Contestar de madrugada**: si respondes a la 1:00, la fecha ya es el día siguiente. Si te molesta, resta 4 horas antes de calcular la fecha.
- **Varios usuarios**: si lo usas con clientes, guarda el Chat id en cada fila y filtra por él, ya está previsto en la hoja.
- **Nada de interpretar los datos**: el bot solo devuelve porcentajes. No escribas mensajes que suenen a valoración clínica.

## Cuánto cuesta
- Telegram y Google Sheets: gratis, sin límites relevantes.
- n8n auto-alojado: 0 euros. En cloud gastarías unas 40 ejecuciones al mes.
