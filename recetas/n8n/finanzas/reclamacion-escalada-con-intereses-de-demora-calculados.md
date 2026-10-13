# Reclamación escalada con intereses de demora calculados…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Reclama las facturas vencidas con tres mensajes de tono creciente y, pasados 30 días, calcula los intereses de demora legales y genera una nota de cargo con el importe exacto.

## Qué es y qué hace

Revisa a diario tu hoja de facturas, detecta las vencidas y envía el mensaje que toca según el retraso: un recordatorio a los 3 días, un aviso firme a los 15 y un aviso formal a los 30 con nota de cargo de intereses de demora y la compensación fija por cobro que permite la ley. Se monta con n8n, Make o Zapier y necesita Gmail y una plantilla de Google Docs.

## Cómo usarla

1. Crea la hoja Facturas con los campos de aviso
2. Redacta los tres textos y la nota de cargo
3. Conecta Gmail y Docs
4. Revisa el tipo de demora vigente antes de enviar
5. Que lo revise un profesional

## Cuándo usarla

Cuando te da apuro reclamar y acabas dejándolo pasar. También si nunca has cobrado intereses de demora pese a tener derecho por ley.

## Cómo ganar dinero con ella

La Ley 3/2004 te permite reclamar intereses (tipo BCE + 8 puntos) y 40 € fijos de gastos de cobro por factura. Sobre 5.000 € vencidos a 90 días son unos 240 €.

- Reclamación de impagos como servicio para autónomos que nunca reclaman…
- Plantillas de aviso de cobro para agencias con clientes B2B…
- Gestión de cobro escalado con revisión legal externa como servicio premium…

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

**Qué hace y para quién**
Revisa a diario tu hoja de facturas, detecta las vencidas y manda el mensaje que toca según los días de retraso: recordatorio amable a los 3 días, firme a los 15, y aviso formal a los 30 con nota de cargo de intereses y los 40 € de compensación por gastos de cobro que permite la ley española.
Para autónomos y pymes B2B que sufren pagos a 60-90 días.

**Lo que necesitas antes**
- Hoja `Facturas` en Sheets: `numero`, `cliente`, `email`, `total`, `fecha_vencimiento`, `fecha_cobro`, `ultimo_aviso`, `nivel_aviso`.
- Gmail conectado (usa tu correo de empresa; los reclamos desde una dirección personal cuelan menos).
- Un Google Docs plantilla `Nota de cargo` con marcadores `{{cliente}}`, `{{numero}}`, `{{principal}}`, `{{dias}}`, `{{intereses}}`, `{{total_reclamado}}`.
- El tipo de interés de demora vigente (se publica cada semestre en el BOE; en 2026 ronda el 11 %). Guárdalo en una celda `Config!B1` para cambiarlo dos veces al año.

**Los nodos, en orden**
1. **Schedule Trigger** — todos los días laborables a las 10:00 (cron `0 10 * * 1-5`).
2. **Google Sheets** — `Get Row(s)` de `Facturas`.
3. **Filter** — deja solo filas con `fecha_cobro` vacía.
4. **Code** — calcula días de retraso, nivel de aviso e intereses (código abajo).
5. **Filter** — quédate con las que tengan `enviar` = true (evita repetir aviso el mismo nivel).
6. **Split In Batches** — tamaño 1, con un **Wait** de 20 segundos entre envíos para no parecer spam.
7. **Switch** — tres salidas según `nivel`: 1, 2 y 3.
8. **Gmail** (x3) — un nodo por nivel, con su asunto y su texto. El del nivel 3 lleva adjunta la nota de cargo.
9. **Google Docs** (solo nivel 3) — «Update a Document» sobre una copia de la plantilla sustituyendo los marcadores; luego **Google Drive** > «Download» como PDF y lo adjuntas en el Gmail.
10. **Google Sheets** — «Update» de `ultimo_aviso` y `nivel_aviso`.

**El trozo de código (nodo Code)**
```javascript
const TIPO_DEMORA = 0.11;
const hoy = new Date();
const out = [];
for (const item of $input.all()) {
  const f = item.json;
  const venc = new Date(String(f.fecha_vencimiento).slice(0, 10));
  const dias = Math.floor((hoy - venc) / 86400000);
  if (dias < 3) continue;
  let nivel = 1;
  if (dias >= 30) nivel = 3;
  else if (dias >= 15) nivel = 2;
  const yaEnviado = Number(f.nivel_aviso || 0);
  const enviar = nivel > yaEnviado;
  const principal = Number(String(f.total).replace(',', '.')) || 0;
  const intereses = principal * TIPO_DEMORA * (dias / 365);
  out.push({ json: {
    ...f,
    dias,
    nivel,
    enviar,
    principal: principal.toFixed(2),
    intereses: intereses.toFixed(2),
    gastos_cobro: nivel === 3 ? '40.00' : '0.00',
    total_reclamado: (principal + (nivel === 3 ? intereses + 40 : 0)).toFixed(2)
  } });
}
return out;
```

**Cómo probarla**
- Crea una factura de prueba con vencimiento hace 35 días y tu propio correo como cliente: debe llegarte el nivel 3 con la nota de cargo y los 40 €.
- Ejecuta dos veces seguidas: la segunda no debe enviar nada (porque `nivel_aviso` ya vale 3).
- Comprueba el cálculo a mano: 1.000 € al 11 % durante 60 días son 18,08 €.

**Qué puede salir mal**
- Enviar un aviso a alguien que ya pagó: por eso el filtro de `fecha_cobro` vacía es lo primero. Combínala con la receta de conciliación bancaria para que el estado esté siempre fresco.
- Gmail limita a 500 envíos diarios en cuentas gratuitas y 2.000 en Workspace. Con el Wait de 20 segundos no llegarás ni de lejos.
- Tono: el nivel 1 debe ser amable de verdad («igual se te ha pasado»). Un cliente perdido por un email seco cuesta más que la factura.
- El tipo de demora cambia cada semestre: pon un recordatorio el 1 de enero y el 1 de julio para actualizarlo.
- Ojo con consumidores particulares: los 40 € de la Ley 3/2004 aplican a operaciones entre empresas, no a clientes particulares.

**Cuánto cuesta**
Gratis con Gmail, Sheets y Docs. n8n auto-alojado. En n8n Cloud gratuito puedes quedarte corto de ejecuciones si lo lanzas a diario: bájalo a lunes y jueves.
