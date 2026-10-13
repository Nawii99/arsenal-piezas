# Horas reales de máquina para facturar por uso…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cuenta las horas que ha estado funcionando de verdad cada equipo o herramienta alquilada y, a fin de mes, te da las líneas de factura por cliente.

## Qué es y qué hace

Cada 5 minutos mira la potencia de cada equipo con un Shelly. Si supera el umbral, suma 5 minutos al cliente asignado en ese momento. El día 1 agrupa las horas por cliente y equipo, aplica tu tarifa y envía por correo las líneas listas para la factura. Entran lecturas de potencia y la hoja de asignaciones, y salen horas facturables. Útil en alquiler de maquinaria y talleres compartidos, con n8n y Google Sheets.

## Cómo usarla

1. Asigna un Shelly con IP fija a cada equipo
2. Anota en la hoja el cliente activo y su tarifa
3. Programa el conteo cada 5 minutos
4. Que lo revise un profesional

## Cuándo usarla

Cuando alquiles maquinaria, cedas equipos a clientes, cobres por uso de una cabina, horno o taller compartido, o simplemente repartas costes entre proyectos.

## Cómo ganar dinero con ella

Facturar por horas reales en vez de por estimación recupera de media un 10-20 % de horas que hoy no cobras, y acaba con las discusiones con el cliente.

- Configuración de medición por uso para alquiladores de maquinaria, con hoja de tarifas y envío mensual de líneas.
- Cálculo mensual de horas facturables para talleres compartidos, cobrado por cliente o por mes.
- Plantilla para cabinas, hornos o salas por horas que cualquier negocio adapta a sus propias tarifas.

**Precio orientativo:** 200–500 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada 5 minutos mira la potencia de cada equipo. Si está por encima del umbral, suma 5 minutos de uso al cliente que tiene asignado ese equipo en ese momento. El día 1 agrupa las horas por cliente y por equipo, aplica tu tarifa y te manda por correo las líneas listas para meter en la factura.
Para alquiler de maquinaria, talleres compartidos, coworkings con equipos, obradores por horas.

## Lo que necesitas antes
- Un Shelly Plus 1PM (o un Plug S si es enchufable) por equipo, con IP fija. Apunta la lista: hormigonera 192.168.1.101, pulidora 192.168.1.102, etc.
- Si los equipos salen de tu red (obra del cliente), usa Shelly Cloud: en la app, Ajustes de usuario → Autorización en la nube, copia el `auth_key` y el servidor (por ejemplo `shelly-53-eu.shelly.cloud`).
- Hoja de Google Sheets con dos pestañas: «Equipos» (id, nombre, ip, umbral_w, tarifa_hora, cliente_actual) y «Uso» (fecha_iso, equipo, cliente, minutos).
- n8n y una credencial de Gmail.

## Los nodos, en orden (workflow 1: contar)
1. **Schedule Trigger**: cada 5 minutes.
2. **Google Sheets** (Read, pestaña «Equipos», Return All): saca la lista de equipos con su IP y su cliente asignado.
3. **Split In Batches** (Batch Size 1): recorre los equipos de uno en uno para no saturar la red.
4. **HTTP Request**: URL `=http://{{ $json.ip }}/rpc/Switch.GetStatus?id=0`, Timeout 4000, On Error «Continue».
5. **Code** «¿Está en marcha?»: compara `apower` con el umbral del equipo.
6. **IF**: `{{ $json.enMarcha }}` is true.
7. Rama true → **Google Sheets** (Append, pestaña «Uso»): fecha_iso, equipo, cliente, minutos = 5.
8. Vuelve al **Split In Batches** para el siguiente equipo.

## Los nodos (workflow 2: facturación mensual)
1. **Schedule Trigger**: Cron `0 9 1 * *`.
2. **Google Sheets** (Read, pestaña «Uso», Return All).
3. **Code** «Agrupar».
4. **Gmail** (Send): asunto `Horas de máquina del mes` y el cuerpo con la tabla.

## El trozo de código (nodo Code, «Agrupar»)
```js
const filas = $input.all().map(i => i.json);
const hoy = new Date();
const mes = new Date(hoy.getFullYear(), hoy.getMonth() - 1, 1);
const clave = d => `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}`;
const objetivo = clave(mes);
const tarifas = { hormigonera: 12, pulidora: 9, horno: 18 };
const acc = {};
for (const f of filas) {
  const d = new Date(f.fecha_iso);
  if (clave(d) !== objetivo) continue;
  const k = `${f.cliente}||${f.equipo}`;
  acc[k] = (acc[k] || 0) + Number(f.minutos);
}
const lineas = Object.entries(acc).map(([k, min]) => { const [cliente, equipo] = k.split('||'); const horas = Math.round((min / 60) * 100) / 100; const tarifa = tarifas[equipo] || 0; return `${cliente} — ${equipo}: ${horas} h x ${tarifa} €/h = ${(horas * tarifa).toFixed(2)} €`; });
return [{ json: { mes: objetivo, total: lineas.length, texto: lineas.join('\n') } }];
```

## Cómo probarla
- Enciende un equipo 20 minutos y comprueba que aparecen 4 filas de 5 minutos en la pestaña «Uso».
- Ajusta el umbral: mide el consumo en reposo del equipo (muchos tiran 2-8 W solo enchufados) y pon el umbral bien por encima, por ejemplo 80 W.
- Ejecuta el workflow 2 a mano cambiando el mes objetivo al actual para ver el resumen sin esperar al día 1.

## Qué puede salir mal
- **Resolución de 5 minutos**: si un equipo se usa a ráfagas de 1 minuto, contarás de más. Baja el intervalo a 1 minuto (más ejecuciones) o usa el contador de energía acumulada `aenergy.total` y resta lecturas, que es exacto.
- **Cambio de cliente a mitad de mes**: la columna `cliente_actual` de «Equipos» es la que manda en el momento de contar; actualízala el mismo día que entregas el equipo.
- **Equipo sin wifi en obra**: usa un Shelly con la red compartida del móvil del operario, o registra el `aenergy.total` al entregar y al recoger, que no necesita conexión continua.
- **Zona horaria en el corte de mes**: guarda siempre `fecha_iso` con `{{ $now.toISO() }}`.

## Cuánto cuesta
Software 0 €. Shelly Plus 1PM 25 € por equipo, Plug S 20 €. n8n autoalojado recomendado por el número de ejecuciones.
