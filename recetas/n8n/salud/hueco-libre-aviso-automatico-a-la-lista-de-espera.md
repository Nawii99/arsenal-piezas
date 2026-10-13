# Hueco libre: aviso automático a la lista de espera…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Cuando alguien cancela o borra su cita, el sistema ofrece ese hueco por WhatsApp o email a la lista de espera y se lo queda el primero que responda.

## Qué es y qué hace

Vigila el calendario cada 15 minutos y, si una cita de los próximos 7 días desaparece o se cancela, ofrece el hueco por WhatsApp a la lista de espera en orden, con 20 minutos para responder. Entrada: eventos de Calendar y hojas Espera y Snapshot; salida: mensajes de oferta y estado actualizado. Se monta en n8n con la plantilla hueco_libre.

## Cómo usarla

1. Prepara las hojas Espera y Snapshot
2. Aprueba la plantilla hueco_libre en WhatsApp
3. Programa el cron de 15 minutos en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando tu agenda va llena, tienes gente esperando y cada cancelación de última hora te deja una hora muerta que no rellenas a tiempo.

## Cómo ganar dinero con ella

Rellenar 2 huecos cancelados a la semana a 45 € son 360 € al mes. Y te ahorras la media hora de llamadas que hacías para cubrirlos.

- Lista de espera automática para una clínica de fisioterapia con agenda saturada.
- Gestión de huecos cancelados para un psicólogo o nutricionista que cobra por sesión.
- Configuración de ofertas de último minuto para un centro de estética con lista de clientes.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Vigila tu calendario cada 15 minutos: si una cita de los próximos 7 días desaparece o se marca como cancelada, coge tu lista de espera y ofrece el hueco por orden, de uno en uno, con 20 minutos para responder.
Sirve para clínicas de fisioterapia, psicólogos, nutricionistas, centros de estética y entrenadores con agenda saturada.

## Lo que necesitas antes
- Google Calendar con las citas.
- Google Sheets con dos pestañas: `Espera` (nombre, telefono, preferencia_horaria, activo, ultima_oferta) y `Snapshot` (event_id, inicio, titulo, visto_en).
- WhatsApp Cloud API con una plantilla aprobada `hueco_libre` con variables {{1}} nombre y {{2}} día y hora, y botón «Lo quiero».
- n8n.

## Los nodos, en orden
1. **Schedule Trigger** – Cron `*/15 * * * *`, Timezone Europe/Madrid.
2. **Google Calendar** – Get Many. Time Min `={{ $now.plus({hours: 3}).toISO() }}`, Time Max `={{ $now.plus({days: 7}).toISO() }}`, Return All activado, Single Events activado.
3. **Google Sheets** – Read Rows de la pestaña `Snapshot`.
4. **Code** – compara lo que hay ahora en el calendario con lo que había en el snapshot y devuelve los eventos que han desaparecido. Código abajo.
5. **IF** – `={{ $json.hay_hueco }}` is true.
6. **Google Sheets** – Read Rows de `Espera` con filtro: columna `activo` igual a `si`.
7. **Sort** – Field: `ultima_oferta`, Order: ascending. Así ofreces primero a quien lleva más tiempo sin recibir oferta.
8. **Limit** – Max Items: 1. Se lo ofreces a una sola persona; si no contesta, en la siguiente vuelta le toca a otra.
9. **HTTP Request** – POST a `https://graph.facebook.com/v20.0/TU_PHONE_ID/messages` con la plantilla `hueco_libre` (mismo formato de body que en cualquier envío de plantilla, con el nombre y la fecha del hueco).
10. **Google Sheets** – Update en `Espera`: pon `ultima_oferta` = `={{ $now.toISO() }}` para esa persona.
11. **Google Sheets** – Update en `Snapshot`: guarda el estado actual del calendario para la próxima comparación (Append or Update con `event_id` como llave, y borra las filas que ya no existan con un Delete Rows si quieres afinar).
12. **Webhook** aparte para las respuestas: cuando alguien pulse «Lo quiero», crea el evento con un nodo **Google Calendar** (Operation: Create) y avísale con un segundo **HTTP Request**.

## El código del nodo Code (paso 4)
```
const ahora = $('Google Calendar').all().map(i => i.json.id);
const previos = $('Google Sheets').all().map(i => i.json);
const desaparecidos = previos.filter(p => p.event_id && !ahora.includes(p.event_id));
if (desaparecidos.length === 0) return [{ json: { hay_hueco: false } }];
const h = desaparecidos[0];
const f = new Date(h.inicio);
const texto = f.toLocaleString('es-ES', { timeZone: 'Europe/Madrid', weekday: 'long', day: 'numeric', month: 'long', hour: '2-digit', minute: '2-digit' });
return [{ json: { hay_hueco: true, event_id: h.event_id, inicio: h.inicio, fecha_texto: texto } }];
```

## Cómo probarla
- Mete tres citas de prueba en el calendario para dentro de 2 días y ejecuta el flujo una vez para que se guarde el snapshot.
- Borra una de esas citas y vuelve a ejecutar: el Code debe devolver `hay_hueco: true` con esa cita.
- Comprueba que solo se manda un mensaje, no tres.
- Prueba con la lista de espera vacía: no debe dar error, simplemente no hace nada.

## Qué puede salir mal
- **Falsos huecos el primer día**: si el snapshot está vacío, todo parece nuevo. Ejecuta una vez el flujo con el paso 9 desactivado para poblar el snapshot antes de dejarlo suelto.
- **Citas movidas, no canceladas**: si arrastras una cita a otra hora, el id no cambia, así que no se detecta como hueco. Perfecto, es lo que quieres.
- **Dos personas dicen que sí a la vez**: por eso ofreces de uno en uno. Si aun así pasa, comprueba en el webhook con un nodo Google Calendar (Get Many) si el hueco sigue libre antes de crear el evento.
- **Cancelaciones a 30 minutos vista**: pon el Time Min en +3 horas para no molestar a nadie con huecos imposibles de cubrir.
- **Límite de la API de Google**: 15 minutos de frecuencia está muy lejos de cualquier límite; no bajes de 5 minutos igualmente.

## Cuánto cuesta
- n8n auto-alojado: 0 €.
- WhatsApp: unos 0,03-0,04 € por mensaje de utilidad. Ofrecer 30 huecos al mes es un euro largo.
- Si no quieres WhatsApp, cambia el HTTP Request por un nodo **Gmail** y sale a coste cero, aunque la gente responde bastante peor por email.
