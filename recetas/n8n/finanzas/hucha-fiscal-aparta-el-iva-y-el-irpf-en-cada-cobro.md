# Hucha fiscal: aparta el IVA y el IRPF en cada cobro…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cada vez que entra un cobro, calcula qué parte es IVA e IRPF, lo apunta en una hoja «hucha» y te dice cuánto dinero de tu cuenta NO es tuyo. Aviso el día 15 de cada trimestre.

## Qué es y qué hace

Cada vez que entra un pago, lo recoge de Stripe o de una fila nueva de tu hoja de facturas, separa el IVA repercutido y una estimación de IRPF, y lo suma a un contador de dinero que pertenece a Hacienda. Avisa cinco días antes de cada plazo trimestral. Se monta con n8n, Make o Zapier y necesita Stripe o una hoja de facturas.

## Cómo usarla

1. Crea la hoja Hucha con sus columnas
2. Conecta Stripe o Google Sheets
3. Define tu porcentaje de IRPF a provisionar
4. Revisa el contador con tu gestor cada trimestre
5. Que lo revise un profesional

## Cuándo usarla

Cuando llega el día 20 de enero, abril, julio u octubre y no tienes el dinero del IVA porque te lo has ido gastando sin darte cuenta.

## Cómo ganar dinero con ella

Evita el recargo de Hacienda por presentar fuera de plazo (del 1 % al 15 %) y aplazamientos con intereses del 4,0625 %. Sobre 6.000 € de IVA son 300-900 € al año.

- Configuración de la hucha fiscal para autónomos que cobran de forma irregular…
- Control de provisiones de impuestos para microempresas en estimación directa…
- Calendario fiscal con avisos previos para negocios pequeños…

**Precio orientativo:** 60–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

**Qué hace y para quién**
Escucha cada pago cobrado (Stripe, o una fila nueva en tu hoja de facturas) y separa contablemente el 21 % de IVA repercutido y el porcentaje de IRPF que estimes. Lleva un contador vivo de «dinero que es de Hacienda» y te avisa cinco días antes del final del plazo trimestral.
Para autónomos y micro-SL en estimación directa que cobran de forma irregular.

**Lo que necesitas antes**
- Cuenta de Stripe (si cobras por tarjeta) y su clave secreta en Dashboard > Desarrolladores > Claves API. Si no usas Stripe, sustituye el disparador por un **Google Sheets Trigger** sobre tu hoja de facturas.
- Google Sheets con la hoja `Hucha` (columnas: fecha, concepto, base, iva, irpf_estimado, trimestre).
- Gmail conectado.
- Decidir tu porcentaje de provisión de IRPF: si no lo sabes, aparta un 15 % del beneficio estimado.

**Los nodos, en orden**
1. **Stripe Trigger** — evento `charge.succeeded`. Alternativa sin Stripe: **Google Sheets Trigger** con «Row Added» sobre tu hoja `Facturas`.
2. **Code** — desglosa base, IVA e IRPF a partir del importe total cobrado (código abajo).
3. **Google Sheets** — «Append» a `Hucha`.
4. **Google Sheets** (Leer trimestre) — lee toda la hoja `Hucha`.
5. **Code** (Acumular) — filtra por el trimestre en curso y suma la columna `iva` y la `irpf_estimado`.
6. **IF** — solo notifica si el acumulado cruza un múltiplo de 500 € (para no darte la brasa en cada cobro).
7. **Gmail** — «Ya tienes apartados X € para Hacienda este trimestre».
8. Workflow aparte: **Schedule Trigger** los días 15 de enero, abril, julio y octubre (cron `0 9 15 1,4,7,10 *`) + **Google Sheets** + **Code** de resumen + **Gmail** con el total del trimestre cerrado y el recordatorio del modelo 303.

**El trozo de código (nodo Code)**
```javascript
const totalCobrado = Number($json.amount ? $json.amount / 100 : $json.importe);
const tipoIVA = 0.21;
const pctIRPF = 0.15;
const base = totalCobrado / (1 + tipoIVA);
const iva = totalCobrado - base;
const irpf = base * pctIRPF;
const d = new Date();
const trimestre = `${d.getFullYear()}-T${Math.floor(d.getMonth() / 3) + 1}`;
return [{ json: {
  fecha: d.toISOString().slice(0, 10),
  concepto: $json.description || $json.concepto || 'Cobro',
  total: totalCobrado.toFixed(2),
  base: base.toFixed(2),
  iva: iva.toFixed(2),
  irpf_estimado: irpf.toFixed(2),
  guardar_total: (iva + irpf).toFixed(2),
  trimestre
} }];
```

**Cómo probarla**
- En Stripe activa el modo test y haz un pago de 121 € con la tarjeta 4242 4242 4242 4242. En la hoja debe aparecer base 100, IVA 21, IRPF 15.
- Comprueba el trimestre calculado: un cobro de abril debe salir como `T2`.
- Ejecuta a mano el workflow del día 15 cambiando el Schedule Trigger por «Execute Workflow».

**Qué puede salir mal**
- Tipos de IVA distintos (10 % o 4 %, o exento): añade una columna `tipo_iva` en tu hoja de productos y léela en vez del 0,21 fijo.
- Operaciones intracomunitarias o con inversión del sujeto pasivo llevan IVA 0: filtra por país del cliente con un nodo **IF** antes del Code.
- Si tus clientes son empresas y te retienen IRPF en factura, no debes provisionarlo otra vez: pon `pctIRPF = 0` para esos cobros.
- Stripe devuelve céntimos: por eso el `/100`. Si tu importe ya viene en euros, quita la división.
- Esto es una provisión orientativa, no una liquidación: el 303 real se calcula con el IVA soportado que te deduces.

**Cuánto cuesta**
Gratis. Stripe cobra su comisión por cobro (1,5 % + 0,25 € en tarjetas europeas), pero la automatización no añade coste. Con n8n auto-alojado, ilimitado.
