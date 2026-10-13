# Política automática de depósito para no-shows repetidos…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Cuenta las ausencias sin avisar de cada cliente y, a la tercera, exige pagar la señal por adelantado antes de darle la siguiente cita.

## Qué es y qué hace

Cuenta las ausencias sin avisar de cada cliente en una hoja de asistencia y, al tercer no-show, marca «señal obligatoria» y envía un enlace de pago de Stripe por Gmail. Entrada: registro diario de asistencia; salida: contadores actualizados y correos. Se monta en n8n con un Schedule Trigger nocturno y sirve para consultas con cita individual.

## Cómo usarla

1. Crea las hojas Asistencia y Clientes
2. Crea el Payment Link de la señal en Stripe
3. Programa el cron nocturno en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando las ausencias sin avisar te comen un 10 o 15 por ciento de la agenda y no te apetece tener la conversación incómoda cliente por cliente.

## Cómo ganar dinero con ella

Con 8 no-shows al mes a 45 euros la sesión son 360 euros perdidos. Aplicar señal automática recupera la mitad y reduce las ausencias a la mitad otra vez.

- Política de señal y avisos de no-show para estudios de fisioterapia o estética.
- Configuración de depósitos y recordatorios para centros de bienestar con agenda individual.
- Revisión trimestral de ausencias con informe de cancelaciones para una clínica.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Lleva un contador de ausencias por cliente, aplica una escala de avisos y, al tercer no-show, marca al cliente como «señal obligatoria» y le manda un enlace de pago antes de reservar.
Sirve para cualquier consulta o centro de bienestar con agenda de citas individuales.

## Lo que necesitas antes
- n8n instalado.
- Hoja «Asistencia» en Sheets: Fecha, Cliente, Email, Estado (asistio / no_show / cancelo_a_tiempo).
- Hoja «Clientes»: Cliente, Email, No shows, Requiere senal (SI/NO), Fecha ultimo aviso.
- Stripe con un Payment Link de 20 euros llamado «Señal de reserva».
- Gmail conectado en n8n.
- Que alguien marque cada día en «Asistencia» quién ha venido y quién no. Es el único paso manual.

## Los nodos, en orden
1. **Schedule Trigger**: Cron 0 21 * * * (todas las noches a las 21:00).
2. **Google Sheets** (Get Rows) sobre «Asistencia»: filtra por Fecha igual a hoy.
3. **IF**: hay filas con Estado = «no_show». Si no, termina.
4. **Google Sheets** (Get Rows) sobre «Clientes».
5. **Code** (nombre: «Escalar política»): suma el no-show de hoy al contador y decide el nivel: 1 aviso amable, 2 aviso firme, 3 o más señal obligatoria. Código abajo.
6. **Google Sheets** (Update Row): actualiza No shows y Requiere senal.
7. **Switch** (campo nivel): tres salidas.
8. **Gmail** (Send Message) en cada salida, con textos distintos. En la salida de nivel 3 incluye el enlace de Stripe.
9. **Google Calendar** (Get Many Events) al final: busca citas futuras de ese cliente.
10. **IF**: si tiene cita futura y Requiere senal = SI, un **Gmail** avisa a recepción para que no confirme esa cita hasta ver el pago.
11. **Google Sheets** (Append Row) en «Registro avisos» para tener el histórico por si el cliente reclama.

## El código del nodo Code
```javascript
const clientes = $('Google Sheets1').all();
const noShows = $input.all().filter(i => (i.json.Estado || '') === 'no_show');
const salida = [];
for (const ns of noShows) {
  const email = (ns.json.Email || '').toLowerCase();
  const ficha = clientes.find(c => (c.json.Email || '').toLowerCase() === email);
  const previos = ficha ? Number(ficha.json['No shows'] || 0) : 0;
  const total = previos + 1;
  let nivel = 1;
  if (total === 2) nivel = 2;
  if (total >= 3) nivel = 3;
  salida.push({ json: {
    fila: ficha ? ficha.json.row_number : null,
    cliente: ns.json.Cliente,
    email,
    total,
    nivel,
    requiereSenal: total >= 3 ? 'SI' : 'NO'
  }});
}
return salida;
```

## Cómo probarla
- Añade tres filas de no_show con tu propio email en fechas distintas y ejecuta el flujo tres veces cambiando la fecha a hoy. Comprueba que el tercer correo es el de señal.
- Verifica que la columna No shows se incrementa y no se resetea.

## Qué puede salir mal
- **Tono agresivo**: escribe los correos con cabeza. El primero debe ser «te echamos de menos, ¿todo bien?», no una multa. Pierdes clientes si el nivel 1 suena a bronca.
- **Ausencias justificadas**: deja el estado «cancelo_a_tiempo» para quien avisa con 24 horas y no lo cuentes.
- **Contador que nunca baja**: añade una regla que reste un no-show si el cliente encadena 6 asistencias seguidas. Es justo y evita marcar de por vida.
- **Doble ejecución el mismo día**: filtra por fecha de hoy y guarda en «Registro avisos» para no sumar dos veces.
- **Aviso legal**: la política de señal debe estar por escrito y aceptada al reservar; si no, no la puedes cobrar.

## Cuánto cuesta
- Sheets, Gmail y Calendar: gratis. Stripe: 1,5 por ciento más 0,25 euros por cobro.
- n8n auto-alojado: 0 euros.
