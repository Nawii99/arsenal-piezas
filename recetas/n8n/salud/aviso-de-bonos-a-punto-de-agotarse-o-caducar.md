# Aviso de bonos a punto de agotarse o caducar…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Controla los bonos de sesiones, avisa al paciente cuando le quedan dos y cuando el bono está a punto de caducar, y te dice a ti quién no renueva.

## Qué es y qué hace

Descuenta una sesión del bono cada vez que se celebra una cita, avisa por WhatsApp al paciente cuando le quedan dos sesiones y otra vez cuando le queda una, y avisa si el bono caduca en 15 días sin gastar. Cada lunes te envía la lista de bonos agotados sin renovar. Entrada: hoja Bonos y citas; salida: avisos y lista semanal. Se monta en n8n con Sheets, Calendar y WhatsApp.

## Cómo usarla

1. Crear la hoja Bonos con sus columnas
2. Conectar Calendar, Sheets y WhatsApp
3. Probar con un bono de prueba
4. Que lo revise un profesional

## Cuándo usarla

Cuando vendas bonos de 5 o 10 sesiones y lleves la cuenta en una libreta, con pacientes que desaparecen al acabar el bono sin que nadie les llame.

## Cómo ganar dinero con ella

Renovar 4 bonos al mes que se habrían perdido, a 200 € el bono de 5 sesiones, son 800 € de ingreso recurrente que hoy se cae solo.

- Controlar bonos de sesiones para fisioterapeutas y entrenadores personales, cobrando por instalación.
- Ofrecer recordatorios de renovación a centros de estética que venden paquetes.
- Montar la lista semanal de renovaciones para un logopeda o un psicólogo.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Descuenta una sesión del bono cada vez que se celebra una cita, avisa al paciente por WhatsApp cuando le quedan dos sesiones y otra vez cuando le queda una, avisa si el bono caduca en 15 días sin gastar, y te manda a ti cada lunes la lista de bonos agotados sin renovar para que llames.
Para fisioterapia, masaje, estética, entrenamiento personal, logopedia y cualquier centro que venda paquetes de sesiones.

## Lo que necesitas antes
- Google Sheets con la hoja Bonos y estas columnas: paciente, telefono, tipo_bono, sesiones_totales, sesiones_usadas, fecha_compra, fecha_caducidad, estado (activo, agotado, caducado, renovado), aviso_2, aviso_1, aviso_caduca.
- Google Calendar con las citas, con la norma de escribir en el título `Nombre Apellido - Profesional` y con el mismo nombre exacto que en la hoja Bonos.
- WhatsApp Cloud API con tres plantillas: bono_quedan (variables nombre, restantes), bono_ultima (nombre) y bono_caduca (nombre, fecha).
- n8n.

## Los nodos, en orden
1. **Schedule Trigger**: `0 22 * * *`, cada noche cuando la agenda del día ya está cerrada.
2. **Google Calendar** (Get Many Events): las citas de hoy, After = `{{ $now.startOf('day').toISO() }}`, Before = `{{ $now.endOf('day').toISO() }}`.
3. **Google Sheets** (Get Rows) sobre Bonos, Return All.
4. **Code**: cruza citas y bonos, descuenta sesiones y decide qué avisos tocan. Código completo abajo.
5. **Google Sheets** (Update Row): actualiza sesiones_usadas y estado, buscando por la columna paciente.
6. **Switch** por `{{ $json.aviso }}` con salidas: quedan_2, ultima, caduca, ninguno.
7. Salida quedan_2: **WhatsApp** con bono_quedan («Hola {{1}}, te quedan {{2}} sesiones de tu bono. Si quieres, te dejamos apalabradas las fechas ahora y no te quedas sin hueco.»). Después, **Google Sheets** Update poniendo SI en aviso_2, para no repetirlo.
8. Salida ultima: **WhatsApp** con bono_ultima, mencionando que en la próxima sesión se puede renovar. Update de aviso_1.
9. Salida caduca: **WhatsApp** con bono_caduca indicando la fecha límite. Update de aviso_caduca.
10. Flujo 2, el resumen para ti: **Schedule Trigger** `0 9 * * 1`, **Google Sheets** Get Rows, **Filter** con estado igual a agotado y sin renovar en 21 días, **Code** que monte una lista, y **Gmail** con asunto `{{ $json.total }} bonos agotados sin renovar` y los teléfonos, para que recepción llame. Aquí no automatices la llamada: renovar un bono se cierra hablando.

## El trozo de código del nodo 4
```javascript
const citas = $('Google Calendar').all().map(i => i.json);
const bonos = $('Google Sheets').all().map(i => i.json);
const hoy = new Date();
const salida = [];
for (const b of bonos) {
  if (b.estado !== 'activo') continue;
  const nombre = String(b.paciente || '').trim().toLowerCase();
  const usadasHoy = citas.filter(c => {
    const t = String(c.summary || '').toLowerCase();
    return t.includes(nombre) && !t.includes('no show') && c.status !== 'cancelled';
  }).length;
  const usadas = (parseInt(b.sesiones_usadas || 0, 10)) + usadasHoy;
  const totales = parseInt(b.sesiones_totales || 0, 10);
  const restantes = totales - usadas;
  const caduca = b.fecha_caducidad ? new Date(b.fecha_caducidad) : null;
  const diasCaduca = caduca ? Math.ceil((caduca - hoy) / 86400000) : 999;
  let estado = 'activo';
  if (restantes <= 0) estado = 'agotado';
  else if (diasCaduca <= 0) estado = 'caducado';
  let aviso = 'ninguno';
  if (restantes === 2 && b.aviso_2 !== 'SI') aviso = 'quedan_2';
  else if (restantes === 1 && b.aviso_1 !== 'SI') aviso = 'ultima';
  else if (restantes > 0 && diasCaduca <= 15 && b.aviso_caduca !== 'SI') aviso = 'caduca';
  let tel = String(b.telefono || '').replace(/\s|\+/g, '');
  if (tel.length === 9) tel = '34' + tel;
  salida.push({ json: {
    paciente: b.paciente, telefono: tel, sesiones_usadas: usadas, restantes, estado, aviso,
    fecha_caducidad: b.fecha_caducidad || '', fila: b.row_number
  } });
}
return salida;
```

## Cómo probarla
1. Crea un bono de prueba con tu nombre, 5 sesiones totales, 2 usadas y caducidad dentro de 10 días.
2. Ponte una cita hoy con el título `Tu Nombre - Marta` y ejecuta el flujo: sesiones_usadas debe pasar a 3 y no debe saltar aviso.
3. Cambia sesiones_usadas a 3 y añade otra cita: al llegar a 3 restantes 2, tiene que llegarte el WhatsApp de quedan_2.
4. Ejecuta dos veces seguidas y comprueba que el segundo pase no manda nada, gracias a la columna aviso_2.

## Qué puede salir mal
- **Doble descuento**: si ejecutas el flujo dos veces el mismo día, restarías dos sesiones. Añade una columna ultimo_descuento con la fecha y una condición al principio del código que salte si ya es de hoy.
- **Nombres que no cuadran**: si en Calendar pone «Ana Mª» y en la hoja «Ana Maria», el cruce falla. Lo más robusto es poner un código de paciente corto en el título de la cita, tipo `P0142 - Marta`, y cruzar por ese código.
- **Ausencias**: el código descarta los títulos con NO SHOW; decide tú si una ausencia sin avisar consume sesión, y si es que sí, quita ese filtro.
- **Presión comercial**: dos avisos por bono es el límite razonable. Más que eso molesta y hace justo lo contrario de lo que buscas.

## Cuánto cuesta
- Sheets, Calendar y n8n auto-alojado: gratis.
- WhatsApp: dos o tres mensajes por bono. Con 50 bonos activos, unos 3 € al mes.
- Total: menos de 10 € al mes.
