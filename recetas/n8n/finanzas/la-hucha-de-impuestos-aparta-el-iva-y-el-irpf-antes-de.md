# La hucha de impuestos: aparta el IVA y el IRPF antes de…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cada vez que registras una factura emitida, calcula qué parte no es tuya (IVA e IRPF) y lleva la cuenta de lo que deberías tener apartado para el próximo trimestre. Te avisa si vas corto.

## Qué es y qué hace

Calcula con tus facturas emitidas y tus gastos del trimestre en curso cuánto IVA y cuánto IRPF a cuenta vas a tener que ingresar, compara esa cifra con lo que tienes apartado en una hoja y avisa por Telegram si la hucha se queda corta. Es una estimación de gestión, no una liquidación. Se monta con n8n, Make o Zapier.

## Cómo usarla

1. Crea las hojas Facturas emitidas, Gastos y Hucha
2. Define el porcentaje de IRPF a provisionar
3. Conecta Sheets y Telegram
4. Revisa la estimación con tu gestor
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando llega el día 20 de enero, abril, julio u octubre y te llevas un susto con lo que hay que pagar a Hacienda.

## Cómo ganar dinero con ella

Evita recargos por aplazamiento (que empiezan en un 5% y llegan al 20%) y el clásico agujero de tesorería del trimestre.

- Previsión fiscal trimestral como servicio para autónomos en estimación directa…
- Control de la hucha de impuestos para microempresas que facturan con IVA…
- Calendario fiscal con avisos previos para negocios pequeños…

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Todos los días calcula, con tus facturas emitidas y tus gastos del trimestre en curso, cuánto IVA vas a tener que ingresar (modelo 303) y cuánto IRPF a cuenta (modelo 130, si estás en estimación directa).
Compara esa cifra con lo que dices tener apartado y te avisa por Telegram si la hucha se queda corta. El primer día de cada trimestre te manda el resumen del trimestre que cierra.
Para autónomos y microempresas en España que facturan con IVA y no tienen la disciplina de apartar.

## Lo que necesitas antes
Hoja «Facturas emitidas» con columnas: FechaFactura, Cliente, Base, TipoIVA, IVA, RetencionIRPF, Total.
Hoja «Gastos» con FechaFactura, Proveedor, Base, IVA, Total, Deducible (`si` o `no`).
Una pestaña `Hucha` con dos celdas: Fecha y SaldoApartado, que actualizas cuando muevas dinero a la cuenta de ahorro.
Ojo: esto es una estimación de gestión, no sustituye a tu asesor ni al modelo oficial. El IRPF real depende de tu situación personal.
Bot de Telegram con su token y tu chat ID (habla con @BotFather).

## Los nodos, en orden
**Schedule Trigger**: cada día a las 20:00, timezone Europe/Madrid.
**Google Sheets** (renombra a `Emitidas`): Get Row(s), hoja Facturas emitidas, Return All.
**Google Sheets** (renombra a `Gastos`): Get Row(s), hoja Gastos, Return All.
**Google Sheets** (renombra a `Hucha`): Get Row(s), pestaña Hucha, Return All.
**Code**: modo «Run Once for All Items».
```javascript
const num = (v) => Number(String(v ?? '0').replace(/\./g, '').replace(',', '.')) || 0;
const hoy = new Date();
const q = Math.floor(hoy.getMonth() / 3);
const inicio = new Date(hoy.getFullYear(), q * 3, 1);
const fin = new Date(hoy.getFullYear(), q * 3 + 3, 1);
const dentro = (f) => { const d = new Date(f); return d >= inicio && d < fin; };
const em = $('Emitidas').all().map(i => i.json).filter(f => dentro(f.FechaFactura));
const ga = $('Gastos').all().map(i => i.json).filter(g => dentro(g.FechaFactura) && String(g.Deducible).toLowerCase() === 'si');
const ivaRep = em.reduce((s, f) => s + num(f.IVA), 0);
const ivaSop = ga.reduce((s, g) => s + num(g.IVA), 0);
const ivaPagar = ivaRep - ivaSop;
const baseIng = em.reduce((s, f) => s + num(f.Base), 0);
const baseGas = ga.reduce((s, g) => s + num(g.Base), 0);
const retenido = em.reduce((s, f) => s + num(f.RetencionIRPF), 0);
const beneficio = baseIng - baseGas;
const irpf = Math.max(0, beneficio * 0.20 - retenido);
const deber = ivaPagar + irpf;
const apartado = num($('Hucha').first().json.SaldoApartado);
const falta = deber - apartado;
const finTexto = new Date(fin.getTime() - 86400000).toISOString().slice(0,10);
const texto = `HUCHA DE IMPUESTOS — Trimestre ${q+1} (hasta ${finTexto})\n\nIVA repercutido: ${ivaRep.toFixed(2)} €\nIVA soportado deducible: ${ivaSop.toFixed(2)} €\nIVA a ingresar (mod. 303): ${ivaPagar.toFixed(2)} €\n\nBeneficio del trimestre: ${beneficio.toFixed(2)} €\nRetenciones ya practicadas: ${retenido.toFixed(2)} €\nPago a cuenta IRPF estimado (mod. 130, 20%): ${irpf.toFixed(2)} €\n\nTOTAL A APARTAR: ${deber.toFixed(2)} €\nTienes apartado: ${apartado.toFixed(2)} €\n${falta > 0 ? 'TE FALTAN ' + falta.toFixed(2) + ' €' : 'Vas sobrado, te sobran ' + Math.abs(falta).toFixed(2) + ' €'}`;
return [{ json: { texto, falta, deber } }];
```
**IF**: condición Number `={{ $json.falta }}` mayor que `50`. Solo te molesta si de verdad vas corto.
**Telegram** (rama true): Send Message con `={{ $json.texto }}`.
**Gmail** (rama false, opcional): puedes dejarla vacía o mandarte el resumen solo los viernes añadiendo un IF con `={{ $now.weekday === 5 }}`.

## Cómo probarla
Carga las facturas y gastos de un trimestre ya presentado y compara el IVA a ingresar que calcula con el del modelo 303 que presentaste. Deben coincidir al céntimo si el IVA está bien apuntado.
El IRPF no coincidirá exactamente: es una estimación al 20%, ajústala al porcentaje que te diga tu asesor cambiando el `0.20`.

## Qué puede salir mal
Gastos sin IVA deducible (dietas, gasolina sin justificar, compras a particulares): márcalos como Deducible = `no`, si no te inflas el IVA soportado y luego pagas de más.
Facturas intracomunitarias o con inversión del sujeto pasivo: no encajan en este cálculo simple. Sepáralas y consúltalas con tu asesor.
Recargo de equivalencia o módulos: esta receta no aplica, tu régimen es otro.
Cambio de trimestre: el código usa el trimestre en curso; los últimos días de marzo, junio, septiembre y diciembre revisa que hayas metido todas las facturas antes de que cambie.
Zona horaria: fija Europe/Madrid o el 31 de marzo a las 23:00 verás ya el trimestre siguiente.

## Cuánto cuesta
Gratis. Sheets, Telegram y Gmail no cobran, y n8n autoalojado tampoco.
