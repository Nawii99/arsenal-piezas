# Aviso de clientes que están dejando de venir al centro…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Compara la asistencia de cada socio con su costumbre y te avisa de quién está bajando el ritmo antes de que se dé de baja, con un email de reenganche.

## Qué es y qué hace

Cada lunes lee el registro de accesos de Google Sheets, compara las visitas de las últimas dos semanas con la media de los tres meses anteriores y clasifica a cada socio en verde, ámbar o rojo. Los ámbar reciben un email de reenganche por Gmail y los rojos se listan para llamarlos. Entrada: accesos y hoja Socios; salida: correos y lista de riesgo. Se monta en n8n.

## Cómo usarla

1. Exporta los accesos a una hoja cada noche
2. Prepara la hoja Socios y define los umbrales de verde, ámbar y rojo
3. Que lo revise un profesional

## Cuándo usarla

Cuando tienes cuotas mensuales (gimnasio, pilates, yoga, box) y las bajas te llegan por sorpresa, cuando ya es tarde para hacer nada.

## Cómo ganar dinero con ella

Retener 5 socios de 45 €/mes que se iban a ir son 225 €/mes recurrentes, 2.700 € al año. Captar uno nuevo te cuesta entre 30 y 80 € de publicidad.

- Detección de bajas para un gimnasio o estudio de pilates con cuotas mensuales.
- Email de reenganche automático para un box de crossfit que pierde socios en verano.
- Informe semanal de riesgo de baja para un centro de yoga con cien socios.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada lunes lee el registro de accesos de tu centro, calcula cuántas veces vino cada socio en las últimas 2 semanas frente a su media de los 3 meses anteriores, y clasifica en verde, ámbar y rojo. A los ámbar les manda un email cercano; los rojos te salen en una lista para que los llames tú.
Para gimnasios, centros de pilates o yoga, boxes de crossfit y cualquier negocio de bienestar con cuota mensual.

## Lo que necesitas antes
- Un registro de accesos en Google Sheets: fecha, socio_id, nombre, email. Si tu torno o software exporta CSV, prográmalo para que suba el fichero a una carpeta de Drive cada noche y léelo con un nodo **Google Drive** + **Extract From File**.
- Hoja `Socios`: socio_id, nombre, email, alta, cuota, estado_riesgo, ultimo_aviso.
- Gmail conectado.
- n8n.

## Los nodos, en orden
1. **Schedule Trigger** – Cron `0 9 * * 1`, Timezone Europe/Madrid.
2. **Google Sheets** – Read Rows de `Accesos`, Return All activado.
3. **Google Sheets** – Read Rows de `Socios`, Return All activado.
4. **Code** – calcula frecuencia reciente contra frecuencia histórica y asigna el semáforo. Código abajo.
5. **Google Sheets** – Update en `Socios` con la columna `estado_riesgo`, Matching Column `socio_id`.
6. **Switch** – Mode: Rules sobre `={{ $json.riesgo }}`: salida `ambar`, salida `rojo`, resto por defecto sin acción.
7. **IF** (dentro de la rama ámbar) – solo si `ultimo_aviso` está vacío o es de hace más de 30 días, para no agobiar.
8. **Gmail** (ámbar) – asunto «Te echamos de menos por aquí». Texto corto, sin culpa: recuérdale cuántas veces vino el mes pasado, ofrécele una sesión con monitor para replantear su rutina y dos horarios concretos.
9. **Google Sheets** – Update `ultimo_aviso` con la fecha.
10. **Aggregate** (rama roja) – Aggregate All Item Data. Junta a todos los rojos en un solo item.
11. **Gmail** – te manda a ti la lista de rojos con nombre, teléfono, cuota y días sin venir, ordenada por cuota descendente: llama primero a quien más pagas de perder.
12. (Opcional) **Google Sheets** – Append en una pestaña `Historico_riesgo` con la foto de cada semana, para conectarla luego a Looker Studio y ver la tendencia del centro.

## El código del nodo Code (paso 4)
```
const accesos = $('Google Sheets').all().map(i => i.json);
const socios = $('Google Sheets1').all().map(i => i.json);
const hoy = Date.now();
const dias = f => (hoy - new Date(f).getTime()) / 86400000;
const salida = [];
for (const s of socios) {
  const mios = accesos.filter(a => String(a.socio_id) === String(s.socio_id));
  if (!mios.length) continue;
  const recientes = mios.filter(a => dias(a.fecha) <= 14).length;
  const previos = mios.filter(a => dias(a.fecha) > 14 && dias(a.fecha) <= 104).length;
  const mediaQuincenal = previos / 6.4;
  const ultimoAcceso = Math.min(...mios.map(a => dias(a.fecha)));
  let riesgo = 'verde';
  if (ultimoAcceso > 21) riesgo = 'rojo';
  else if (mediaQuincenal >= 2 && recientes <= mediaQuincenal * 0.4) riesgo = 'ambar';
  salida.push({ json: { ...s, recientes, media: Math.round(mediaQuincenal * 10) / 10, dias_sin_venir: Math.round(ultimoAcceso), riesgo } });
}
return salida;
```

## Cómo probarla
- Monta una hoja de accesos falsa con tres socios: uno que viene 3 veces por semana siempre, uno que venía 3 y lleva 2 semanas viniendo 1, y uno que no aparece desde hace un mes.
- Ejecuta y comprueba que salen verde, ámbar y rojo respectivamente.
- Pon tu email en el socio ámbar y mira que el correo llega y suena bien, no a reproche.
- Ejecútalo dos lunes seguidos: al ámbar no debe llegarle otra vez el email por el IF de los 30 días.

## Qué puede salir mal
- **Socios nuevos marcados como rojo**: alguien que se apuntó hace 10 días no tiene histórico. Añade al filtro `dias(s.alta) > 45`.
- **Vacaciones de agosto**: en agosto todo el centro se pone ámbar. Añade un IF que desactive el envío si el mes es 8, o sube el umbral en verano.
- **Fechas duplicadas**: si el torno registra entrada y salida, contarás doble. Quédate con un acceso por socio y día haciendo un `Set` con `socio_id + fecha`.
- **Tono equivocado**: no escribas «hemos visto que no vienes». Suena a vigilancia. Escribe «te guardamos sitio» y ofrece algo concreto.
- **Esto no valora la salud de nadie**: es asistencia comercial, no seguimiento médico. No comentes nada sobre su forma física ni su peso.

## Cuánto cuesta
- 0 € con Sheets, Gmail y n8n auto-alojado.
- Looker Studio, si quieres el panel bonito, también es gratis.
- El único gasto sería si tu software de gestión cobra por la exportación automática, cosa poco habitual.
