# Aviso de bonos a punto de agotarse…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Controla las sesiones que le quedan a cada cliente de bono y le avisa cuando le quedan dos, con el enlace para renovar antes de que se despiste.

## Qué es y qué hace

Lleva en Google Sheets el saldo de sesiones de cada bono y, al quedar dos o una, envía un aviso por WhatsApp Cloud API con plantilla aprobada y enlace de pago. Entrada: registro de sesiones realizadas; salida: avisos y estado del bono actualizado. Se monta en n8n y sirve para vender paquetes en centros de pilates, fisioterapia o entrenamiento.

## Cómo usarla

1. Crea las hojas Bonos y Sesiones
2. Aprueba la plantilla en WhatsApp Cloud API
3. Enlaza el Payment Link de Stripe
4. Que lo revise un profesional

## Cuándo usarla

Cuando vendes bonos de 5 o 10 sesiones y notas que la gente desaparece justo al terminarlos porque nadie les dijo que se acababa.

## Cómo ganar dinero con ella

Renovar el 30 por ciento de los bonos que hoy se pierden, con bonos de 200 euros y 20 bonos al mes, son unos 1.200 euros mensuales recuperados.

- Configuración de control de bonos y avisos de renovación para centros de pilates o fisioterapia.
- Mantenimiento mensual del flujo y de las plantillas de WhatsApp para un estudio de entrenamiento.
- Informe mensual de bonos vendidos, consumidos y pendientes de renovar para un centro pequeño.

**Precio orientativo:** 200–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Lleva la cuenta de sesiones consumidas por bono y dispara un aviso automático cuando quedan 2 sesiones y otro cuando queda la última, con enlace de pago para renovar.
Para fisios, entrenadores personales, centros de pilates, masajistas y cualquiera que venda paquetes de sesiones.

## Lo que necesitas antes
- n8n instalado.
- Hoja «Bonos» en Google Sheets: Cliente, Telefono, Tipo bono, Sesiones totales, Sesiones usadas, Fecha compra, Estado, Aviso2 (SI/NO), Aviso1 (SI/NO).
- Otra pestaña «Sesiones» donde apuntas cada sesión realizada: Fecha, Cliente, Profesional. Puede rellenarla el recepcionista o un formulario.
- WhatsApp Cloud API de Meta con una plantilla aprobada «bono_agotandose» con variables nombre y sesiones restantes.
- Stripe (opcional pero recomendable): crea un «Payment Link» por cada tipo de bono en dashboard.stripe.com. Copia la URL, no hace falta ni API.

## Los nodos, en orden
1. **Schedule Trigger**: Cron 0 20 * * * (cada día a las 20:00, cuando ya ha terminado la jornada).
2. **Google Sheets** (Get Rows) sobre «Sesiones».
3. **Google Sheets** (Get Rows) sobre «Bonos», filtro Estado = «activo».
4. **Code** (nombre: «Contar consumo»): cuenta sesiones por cliente, actualiza usadas y calcula restantes y el aviso que toca. Código abajo.
5. **Google Sheets** (Update Row): escribe las Sesiones usadas actualizadas en «Bonos».
6. **Switch** (campo aviso): salida «dos» cuando quedan 2, salida «una» cuando queda 1, salida «cero» cuando se ha agotado.
7. **WhatsApp** (Send Template Message) en cada salida, con el enlace de pago de Stripe correspondiente al tipo de bono en la variable del botón.
8. **Google Sheets** (Update Row): marca Aviso2 o Aviso1 como SI para no repetir.
9. **IF** delante de cada WhatsApp: solo envía si la columna del aviso está en NO.
10. En la salida «cero»: **Google Sheets** (Update Row) pon Estado = «agotado» y añade la fila a una pestaña «Pendientes de renovar».

## El código del nodo Code
```javascript
const sesiones = $('Google Sheets').all().map(i => i.json);
const bonos = $('Google Sheets1').all();
const salida = [];
for (const b of bonos) {
  const f = b.json;
  const usadas = sesiones.filter(s => (s.Cliente || '').trim().toLowerCase() === (f.Cliente || '').trim().toLowerCase() && new Date(s.Fecha) >= new Date(f['Fecha compra'])).length;
  const totales = Number(f['Sesiones totales'] || 0);
  const restantes = totales - usadas;
  let aviso = 'ninguno';
  if (restantes === 2 && f.Aviso2 !== 'SI') aviso = 'dos';
  if (restantes === 1 && f.Aviso1 !== 'SI') aviso = 'una';
  if (restantes <= 0) aviso = 'cero';
  salida.push({ json: { fila: b.json.row_number, cliente: f.Cliente, telefono: f.Telefono, tipo: f['Tipo bono'], usadas, restantes, aviso } });
}
return salida;
```

## Cómo probarla
- Crea un bono de prueba de 5 sesiones a tu nombre y apunta 3 sesiones en la pestaña «Sesiones». Debe salir aviso «dos».
- Ejecuta otra vez sin cambiar nada: no debe volver a avisar, porque Aviso2 ya está en SI.

## Qué puede salir mal
- **Nombres escritos distinto** («Ana Pérez» y «ana perez») rompen el conteo. El código ya normaliza espacios y mayúsculas, pero lo ideal es usar el teléfono como identificador único.
- **Sesiones anteriores a la compra del bono**: el filtro por fecha de compra evita que se cuenten sesiones antiguas.
- **Dos bonos activos a la vez** del mismo cliente: deja solo uno en Estado activo y el otro en «en cola».
- **Plantilla de WhatsApp rechazada**: Meta no aprueba mensajes que parezcan pura publicidad. Redáctala como aviso de servicio.

## Cuánto cuesta
- Google Sheets: gratis. Stripe Payment Links: gratis, cobra 1,5 por ciento más 0,25 euros por pago con tarjeta europea.
- WhatsApp Cloud API: 1.000 conversaciones al mes gratis.
- n8n auto-alojado: 0 euros.
