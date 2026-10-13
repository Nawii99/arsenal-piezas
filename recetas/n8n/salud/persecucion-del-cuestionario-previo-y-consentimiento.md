# Persecución del cuestionario previo y consentimiento…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Cuando entra una primera cita, envía el cuestionario de salud y el consentimiento RGPD, y sigue recordándolo hasta que lo rellenen o llegue el día.

## Qué es y qué hace

Automatiza el envío del cuestionario de salud y el consentimiento RGPD a cada primera cita. Entra un evento de Google Calendar marcado «1V» con el email del cliente; sale un Google Form enviado por Gmail y recordatorios a 72, 24 y 3 horas mientras no respondan. Se monta en n8n y sirve para fisios, nutricionistas o psicólogos.

## Cómo usarla

1. Crea el Form con la casilla RGPD y vincula la hoja de respuestas
2. Marca las primeras visitas con «1V» en Calendar
3. Monta el flujo en n8n con Gmail y recordatorios
4. Que lo revise un profesional

## Cuándo usarla

Cuando trabajas con primeras visitas (fisio, nutrición, psicología, entrenamiento personal) y pierdes 15 minutos de sesión rellenando papeles o descubres alergias y limitaciones cuando el cliente ya e…

## Cómo ganar dinero con ella

Recuperas 15 minutos por primera visita. Con 12 primeras visitas al mes son 3 horas facturables, unos 150 euros, más el papeleo del consentimiento resuelto solo.

- Configuración del cuestionario de anamnesis y consentimiento para consultas de fisioterapia o psicología.
- Mantenimiento mensual del flujo de recordatorios y revisión de formularios para una clínica pequeña.
- Paquete para centros de entrenamiento personal con formularios de primera visita y seguimiento de papeles pendientes.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Detecta las citas nuevas marcadas como primera visita, manda el formulario de anamnesis y el consentimiento, y persigue con recordatorios a 72, 24 y 3 horas si no lo han rellenado.
No es diagnóstico: solo recoge información que el profesional leerá antes de la sesión.

## Lo que necesitas antes
- n8n instalado.
- Google Calendar con las citas. Marca las primeras visitas escribiendo «1V» en el título del evento y el email del cliente en los invitados.
- Un Google Form con las preguntas que tú uses (motivo de consulta, antecedentes que quiera compartir, alergias, medicación, casilla de consentimiento RGPD). En «Configuración» activa «Recopilar direcciones de correo».
- La hoja de respuestas del formulario, vinculada desde el propio Form.
- Gmail conectado en n8n con credencial «Gmail OAuth2».

## Los nodos, en orden
1. **Schedule Trigger**: cada 2 horas («Hours», 2). Zona horaria Europe/Madrid.
2. **Google Calendar** (Get Many Events): Time Min = ahora, Time Max = ahora + 14 días.
3. **Code** (nombre: «Filtrar primeras visitas»): se queda con los eventos cuyo título contiene «1V», saca el email del invitado y calcula las horas que faltan. Código abajo.
4. **Google Sheets** (Get Rows) sobre la hoja de respuestas del formulario: trae los emails que ya han contestado.
5. **Code** (nombre: «Quién falta»): cruza ambas listas y devuelve solo los que no han rellenado.
6. **Switch** (modo Rules, campo horasRestantes): salida A si es mayor que 72, salida B entre 24 y 72, salida C entre 3 y 24. Así cambias el tono del recordatorio.
7. **Gmail** (Send Message) en cada salida: el primero explica qué es y por qué; el segundo recuerda amablemente; el tercero avisa de que si no llega, la sesión empezará con papeleo.
8. **Google Sheets** (Append Row) en una pestaña «Recordatorios enviados» con email, evento y nivel, para no repetir el mismo nivel dos veces.
9. **IF** delante del Gmail: comprueba en esa pestaña que ese nivel no se ha enviado ya a ese evento.

## El código del nodo Code
```javascript
const salida = [];
const ahora = new Date();
for (const item of $input.all()) {
  const ev = item.json;
  const titulo = ev.summary || '';
  if (!titulo.toUpperCase().includes('1V')) continue;
  const invitado = (ev.attendees || []).find(a => !a.organizer);
  if (!invitado || !invitado.email) continue;
  const inicio = new Date(ev.start.dateTime);
  const horasRestantes = Math.round((inicio - ahora) / 3600000);
  salida.push({ json: {
    eventoId: ev.id,
    email: invitado.email.toLowerCase(),
    nombre: (invitado.displayName || invitado.email.split('@')[0]),
    horasRestantes,
    fecha: inicio.toLocaleString('es-ES', { timeZone: 'Europe/Madrid' })
  }});
}
return salida;
```

## Cómo probarla
- Crea un evento de prueba dentro de 5 días con «1V» en el título e invítate con un correo tuyo secundario.
- Ejecuta el flujo y comprueba que llega el email con el enlace del formulario.
- Rellena el formulario y vuelve a ejecutar: no debe salir ningún recordatorio.

## Qué puede salir mal
- **El email del invitado no aparece** si creas la cita sin invitar a nadie. Acostúmbrate a meter siempre el correo del cliente en el evento.
- **Mayúsculas y acentos** al comparar emails: pasa todo a minúsculas, como en el código.
- **Datos de salud**: son categoría especial en RGPD. Guarda las respuestas en una hoja con acceso restringido, no las reenvíes por WhatsApp y ten un contrato de encargado del tratamiento con Google.
- **Recordatorios en bucle**: sin la pestaña de control, cada 2 horas mandarías otro correo. Es el fallo más típico.
- **Citas movidas**: si cambias la cita de día, el horasRestantes se recalcula solo, no hace falta tocar nada.

## Cuánto cuesta
- Google Forms, Sheets y Calendar: gratis.
- n8n auto-alojado: 0 euros; cloud desde 20 euros al mes.
- Gmail gratuito de sobra para este volumen.
