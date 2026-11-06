# Alerta de clases con baja ocupación y llamada a llenarl…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Cada tarde mira las reservas de las clases de mañana y, si alguna está a menos de la mitad, avisa al equipo y lanza una invitación a los clientes que suelen ir a esa hora.

## Qué es y qué hace

Cada tarde lee en Google Sheets las reservas del día siguiente, calcula la ocupación de cada clase y, si baja de tu umbral, avisa al equipo por Slack o Telegram y envía una invitación a los clientes del histórico de esa franja por WhatsApp. Entrada: hojas Clases e histórico; salida: avisos y mensajes. Se monta en n8n.

## Cómo usarla

1. Prepara las hojas Clases e Historico asistencia
2. Fija el umbral de ocupación
3. Programa el cron de las 18:00 en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando das clases en grupo (yoga, pilates, funcional, espalda sana) y a veces se presentan tres personas para una sala de doce, con el mismo coste de profesor y de local.

## Cómo ganar dinero con ella

Cancelar a tiempo una clase de 3 personas te ahorra los 25 euros del profesor; llenarla con 4 más te suma 60 euros. Dos o tres veces por semana son 500 euros al mes.

- Automatización de ocupación para estudios de pilates o yoga con avisos al equipo.
- Campaña de invitaciones a clases con poca asistencia para un gimnasio boutique.
- Informe semanal de ocupación por franja horaria para una escuela de danza.

**Precio orientativo:** 150–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
A las 18:00 revisa el cuadro de reservas del día siguiente, calcula el porcentaje de ocupación de cada clase y actúa: avisa al equipo de las que están flojas y manda una invitación a los clientes que históricamente asisten a esa franja.
Para estudios de yoga, pilates, centros de espalda, gimnasios boutique y escuelas de danza.

## Lo que necesitas antes
- n8n instalado.
- Hoja «Clases» en Sheets: Fecha, Hora, Clase, Profesor, Plazas, Reservados, Umbral (porcentaje por debajo del cual salta el aviso).
- Hoja «Historico asistencia»: Cliente, Telefono, Clase, Franja (manana/mediodia/tarde), Ultima asistencia.
- WhatsApp Cloud API con plantilla «plazas_libres» (variables: nombre, clase, hora). Alternativa gratis: Gmail o un mensaje al grupo de Telegram del centro.
- Slack o Telegram para el aviso interno al equipo.

## Los nodos, en orden
1. **Schedule Trigger**: Cron 0 18 * * * , zona Europe/Madrid.
2. **Google Sheets** (Get Rows) sobre «Clases»: filtra Fecha = mañana con la expresión {{ new Date(Date.now()+86400000).toLocaleDateString('sv-SE') }}.
3. **Code** (nombre: «Calcular ocupacion»): saca el porcentaje y clasifica en «cancelar» (menos del 25 por ciento), «llenar» (entre 25 y el umbral) y «bien». Código abajo.
4. **Switch** (campo estado): tres salidas.
5. Salida «cancelar»: **Slack** (Send Message) al canal del equipo con la propuesta de fusionar o anular, y **Gmail** al profesor.
6. Salida «llenar»: **Google Sheets** (Get Rows) sobre «Historico asistencia» filtrando por la misma clase o franja.
7. **Code**: se queda con los que han asistido en los últimos 60 días y no están ya reservados en esa clase.
8. **Split In Batches**: tamaño 1.
9. **WhatsApp** (Send Template Message): «Quedan plazas mañana en {{clase}} a las {{hora}}, ¿te apuntas?».
10. **Wait**: 20 segundos entre mensajes.
11. **Google Sheets** (Append Row) en pestaña «Invitaciones»: para no invitar a la misma persona más de dos veces por semana.
12. **IF** delante del WhatsApp que consulte esa pestaña y descarte a quien ya lleve dos invitaciones esta semana.

## El código del nodo Code
```javascript
const salida = [];
for (const item of $input.all()) {
  const c = item.json;
  const plazas = Number(c.Plazas || 0);
  const reservados = Number(c.Reservados || 0);
  if (plazas === 0) continue;
  const ocupacion = Math.round((reservados / plazas) * 100);
  const umbral = Number(c.Umbral || 60);
  let estado = 'bien';
  if (ocupacion < 25) estado = 'cancelar';
  else if (ocupacion < umbral) estado = 'llenar';
  salida.push({ json: {
    clase: c.Clase,
    hora: c.Hora,
    profesor: c.Profesor,
    plazas,
    reservados,
    libres: plazas - reservados,
    ocupacion,
    estado
  }});
}
return salida;
```

## Cómo probarla
- Mete tres clases de mañana con 12 plazas y 2, 6 y 11 reservados. Deben clasificarse como cancelar, llenar y bien.
- Deja el nodo de WhatsApp desactivado la primera semana y comprueba solo los avisos internos por Slack.

## Qué puede salir mal
- **Spam a los clientes**: sin el límite de dos invitaciones por semana acabarás quemando a la gente. Es el control más importante.
- **Cancelar demasiado pronto**: a las 18:00 aún entran reservas. Si tu centro reserva mucho a última hora, mueve el trigger a las 21:00 y avisa solo al equipo.
- **Datos de reservas desactualizados**: si nadie actualiza la columna Reservados, todo el flujo miente. Si tu software de reservas tiene API o exporta a CSV, conéctalo con un **HTTP Request** en vez de la hoja.
- **Franja horaria mal asignada** en el histórico: revisa que «tarde» signifique lo mismo en las dos hojas.
- **Plantilla de WhatsApp**: Meta puede considerarla marketing. Solicítala en la categoría correcta o usarás conversaciones de pago.

## Cuánto cuesta
- Sheets, Slack y Calendar: gratis.
- WhatsApp Cloud API: las conversaciones de marketing sí se pagan, unos 0,05 a 0,08 euros cada una en España.
- n8n auto-alojado: 0 euros.
