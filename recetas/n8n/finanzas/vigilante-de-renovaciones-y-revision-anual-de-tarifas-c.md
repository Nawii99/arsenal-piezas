# Vigilante de renovaciones y revisión anual de tarifas c…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Te avisa con 45 días de antelación de cada contrato, seguro, alquiler o suscripción anual que se renueva, y te calcula con el IPC oficial del INE cuánto deberías subir tus propios precios.

## Qué es y qué hace

Cada semana revisa una hoja de Google Sheets con contratos, fechas de renovación y días de preaviso, y te envía un correo cuando falta poco para cancelar o renegociar. Además consulta el IPC interanual en la API pública del INE y calcula cuánto deberían subir tus tarifas para no perder poder adquisitivo, servicio a servicio.

## Cómo usarla

1. Preparar las hojas Contratos y Tarifas
2. Probar la API del INE con la URL indicada
3. Montar el flujo semanal con Gmail en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando llevas dos años con las mismas tarifas y tus contratos se renuevan solos sin que te enteres.

## Cómo ganar dinero con ella

Renegociar un seguro o un alquiler antes del plazo de preaviso ahorra cientos de euros. Y subir tus tarifas con el IPC evita perder margen en silencio cada año.

- Control de renovaciones de seguros y alquileres para pymes con muchos contratos anuales.
- Revisión anual de tarifas con IPC para consultores que llevan años sin subir precios.
- Informe de contratos próximos a renovar que el gestor entrega a sus clientes cada trimestre.

**Precio orientativo:** 100–250 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada semana revisa una hoja con tus contratos y sus fechas de renovación y preaviso, y te manda un email cuando falta poco para poder cancelar o renegociar.
Además consulta el IPC interanual real en la API abierta del INE y te dice cuánto tendrían que subir tus tarifas de venta para no perder poder adquisitivo, con el importe nuevo ya calculado por servicio.

## Lo que necesitas antes
Hoja de Google Sheets `Contratos` con pestaña `Contratos`: `concepto`, `proveedor`, `importe_anual`, `fecha_renovacion` (texto `yyyy-mm-dd`), `dias_preaviso`, `notas`. Y pestaña `Tarifas`: `servicio`, `precio_actual`, `fecha_ultima_subida`.
No necesitas clave para el INE: la API pública es `https://servicios.ine.es/wstempus/js/ES/DATOS_SERIE/IPC251856?nult=13` y devuelve la serie del índice general.
Gmail conectado a n8n con OAuth2.

## Los nodos, en orden
**1. Schedule Trigger** — `Weeks`, lunes, 08:00, zona horaria `Europe/Madrid`.
**2. Google Sheets** (`Contratos`) — `Get Row(s)`, pestaña `Contratos`.
**3. Google Sheets** (`Tarifas`) — `Get Row(s)`, pestaña `Tarifas`.
**4. HTTP Request** (`IPC`) — `GET` a `https://servicios.ine.es/wstempus/js/ES/DATOS_SERIE/IPC251856?nult=13`, sin autenticación. En Options activa `Response > Format: JSON`.
**5. Code** (`Avisos y subida`) — `Run Once for All Items`. Código abajo.
**6. IF** — `{{ $json.hay_avisos }}` `is true`.
**7. Gmail** — `Send`, a tu correo, asunto `Renovaciones y tarifas — semana {{ $now.weekNumber }}`, mensaje HTML `={{ $json.html }}`.

## El código del nodo Avisos y subida
```javascript
const contratos = $('Contratos').all().map(i => i.json);
const tarifas = $('Tarifas').all().map(i => i.json);
const serie = $('IPC').first().json;
const datos = (Array.isArray(serie) ? serie[0].Data : serie.Data) || [];
const ordenados = datos.slice().sort((a, b) => a.Anyo - b.Anyo || a.FK_Periodo - b.FK_Periodo);
const ult = ordenados[ordenados.length - 1];
const hace12 = ordenados[ordenados.length - 13] || ordenados[0];
const ipc = ((ult.Valor / hace12.Valor) - 1) * 100;
const hoy = new Date(); hoy.setHours(0, 0, 0, 0);
const lineas = [];
for (const c of contratos) {
  const ren = new Date(c.fecha_renovacion);
  const preaviso = Number(c.dias_preaviso || 30);
  const limite = new Date(ren.getTime() - preaviso * 86400000);
  const dias = Math.ceil((limite - hoy) / 86400000);
  if (dias <= 45 && dias >= -5) {
    lineas.push(`<li><b>${c.concepto}</b> (${c.proveedor}, ${c.importe_anual} €/año): tienes hasta el <b>${limite.toISOString().slice(0,10)}</b> para avisar (${dias} días). Renueva el ${c.fecha_renovacion}. ${c.notas || ''}</li>`);
  }
}
const subidas = tarifas.map(t => {
  const nuevo = Number(t.precio_actual) * (1 + ipc / 100);
  return `<li>${t.servicio}: ${Number(t.precio_actual).toFixed(2)} € → <b>${nuevo.toFixed(2)} €</b> (última subida ${t.fecha_ultima_subida || 'nunca'})</li>`;
});
const html = `<p>IPC interanual oficial (INE): <b>${ipc.toFixed(2)} %</b></p>` + (lineas.length ? `<h3>Contratos que hay que decidir ya</h3><ul>${lineas.join('')}</ul>` : '<p>Ningún contrato en plazo de preaviso esta semana.</p>') + `<h3>Tus tarifas actualizadas al IPC</h3><ul>${subidas.join('')}</ul>`;
return [{ json: { hay_avisos: lineas.length > 0 || hoy.getDate() <= 7, ipc: Number(ipc.toFixed(2)), html } }];
```

## Cómo probarla
Ejecuta a mano y mira la salida del nodo IPC: debe traerte 13 valores mensuales del índice general. Contrasta el porcentaje con la nota de prensa del INE de ese mes.
Mete un contrato con fecha de renovación dentro de 60 días y preaviso de 30: debe salir en el email.

## Qué puede salir mal
El INE cambia a veces el código de serie. Si `IPC251856` deja de responder, busca la serie del índice general en `https://www.ine.es/dyngs/DataLab/es/manual.html?cid=45` y cambia el código en la URL.
El IPC del mes se publica hacia el día 13-15; hasta entonces el último dato es el del mes anterior. No es problema para una revisión anual de tarifas.
Fechas mal escritas en la hoja rompen el cálculo de días: formatea la columna como texto y usa `yyyy-mm-dd`.
No subas tarifas a clientes de forma automática: este flujo te da el número, la conversación la tienes tú. Avisa siempre con un mes de antelación y por escrito.

## Cuánto cuesta
API del INE: pública y gratuita, sin registro. Sheets, Gmail y n8n auto-alojado: gratis.
