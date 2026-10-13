# Agenda propia de cada profesional sincronizada…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Sincroniza la agenda de la clínica con el calendario personal de cada profesional, bloquea sus horas no disponibles y detecta solapes antes de que ocurran.

## Qué es y qué hace

Copia en la agenda maestra de la clínica los bloques de ocupado de los calendarios personales de cada colaborador, sin ver el detalle, y revisa cada media hora si dos citas se pisan con el mismo profesional o en la misma sala. Avisa por Telegram al instante. Entrada: calendarios compartidos en modo solo ocupado; salida: agenda unificada y alertas de solape. Se monta en n8n con Google Calendar y Telegram.

## Cómo usarla

1. Pedir a cada colaborador que comparta su calendario en modo solo ocupado
2. Crear la agenda maestra y la hoja Profesionales
3. Probar con un solape ficticio
4. Que lo revise un profesional

## Cuándo usarla

Cuando trabajes con colaboradores que reparten su tiempo entre varios sitios y te encuentres con dobles reservas o con huecos que nadie sabía que estaban libres.

## Cómo ganar dinero con ella

Un solape al mes obliga a mover un paciente y a veces a perderlo: entre 50 y 150 €. Y ahorra la ronda diaria de mensajes preguntando disponibilidad.

- Coordinar las agendas de fisioterapeutas y psicólogos que trabajan en varias clínicas.
- Ofrecer el control de solapes a centros con colaboradores externos.
- Montar la agenda compartida y formar al equipo para usarla.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Copia en la agenda maestra de la clínica los bloques de ocupado del calendario personal de cada colaborador (sin ver el detalle, solo la franja) y revisa cada media hora si hay dos citas pisándose en la misma sala o con el mismo profesional, avisando por Telegram al instante.
Es para clínicas con fisioterapeutas, psicólogos o entrenadores autónomos que solo vienen ciertos días y también trabajan en otro sitio.

## Lo que necesitas antes
- Una agenda maestra de la clínica en Google Calendar y una agenda por profesional.
- Que cada colaborador comparta contigo su calendario personal con permiso Ver solo disponible/ocupado: en Google Calendar, Configuración del calendario > Compartir con determinadas personas > añadir tu correo con ese nivel. Así no ves qué hace, solo cuándo está ocupado.
- Una hoja de Google Sheets llamada Profesionales con: nombre, email_calendario, salas_asignadas, horas_contrato.
- Bot de Telegram con un grupo de la clínica (crea el bot con @BotFather, mételo en el grupo y saca el chat ID con getUpdates; los grupos tienen ID negativo).
- Convención en la agenda maestra: título `Paciente - Profesional - Sala`.
- n8n.

## Los nodos, en orden
1. **Schedule Trigger**: `*/30 6-22 * * *`, cada media hora en horario de apertura.
2. **Google Sheets** (Get Rows) sobre Profesionales.
3. **Loop Over Items** (Split In Batches, lote 1): recorre a cada profesional.
4. **Google Calendar** (Get Many Events) sobre `{{ $json.email_calendario }}`, próximos 14 días. Como el permiso es solo disponible/ocupado, los eventos llegan con el título vacío o como Busy; eso es justo lo que quieres.
5. **Google Calendar** (Get Many Events) sobre la agenda maestra, mismos 14 días.
6. **Code**: crea los bloqueos que faltan y detecta solapes. Código abajo.
7. **Split Out** sobre el campo `crear`, y luego **Google Calendar** (Create Event) en la agenda maestra con título `BLOQUEO - {{ $json.profesional }}` y la opción Transparency en Opaque.
8. **IF**: `{{ $json.solapes.length }}` mayor que 0.
9. **Telegram** (Send Message) al grupo: `⚠️ Solape detectado: {{ $json.texto_solapes }}`. Con el prefijo de aviso al principio para que se vea en la notificación.
10. **Google Sheets** (Append) sobre una hoja Incidencias, para llevar el histórico y saber si el problema es de una persona concreta.

## El trozo de código del nodo 6
```javascript
const prof = $('Loop Over Items').first().json;
const personales = $('Cal Personal').all().map(i => i.json);
const maestra = $('Cal Maestra').all().map(i => i.json);
const yaBloqueado = new Set(maestra.filter(e => String(e.summary || '').startsWith('BLOQUEO')).map(e => (e.start.dateTime || '') + '|' + (e.summary || '')));
const crear = [];
for (const ev of personales) {
  if (!ev.start || !ev.start.dateTime) continue;
  if (ev.transparency === 'transparent') continue;
  const clave = ev.start.dateTime + '|BLOQUEO - ' + prof.nombre;
  if (yaBloqueado.has(clave)) continue;
  crear.push({ profesional: prof.nombre, inicio: ev.start.dateTime, fin: ev.end.dateTime });
}
const citas = maestra.filter(e => e.start && e.start.dateTime && e.status !== 'cancelled').map(e => ({
  titulo: e.summary || '',
  ini: new Date(e.start.dateTime).getTime(),
  fin: new Date(e.end.dateTime).getTime(),
  profesional: (e.summary || '').split(' - ')[1] || '',
  sala: (e.summary || '').split(' - ')[2] || ''
}));
const solapes = [];
for (let i = 0; i < citas.length; i++) {
  for (let j = i + 1; j < citas.length; j++) {
    const a = citas[i], b = citas[j];
    if (a.ini < b.fin && b.ini < a.fin) {
      if (a.profesional && a.profesional === b.profesional) solapes.push(`${a.profesional}: ${a.titulo} vs ${b.titulo}`);
      else if (a.sala && a.sala === b.sala) solapes.push(`Sala ${a.sala}: ${a.titulo} vs ${b.titulo}`);
    }
  }
}
return [{ json: { crear, solapes, texto_solapes: [...new Set(solapes)].join(' | ') } }];
```
Renombra los nodos de calendario a `Cal Personal` y `Cal Maestra` para que el código los encuentre.

## Cómo probarla
1. Comparte contigo mismo un calendario secundario y mete un evento de mañana a las 12:00.
2. Ejecuta el flujo: debe aparecer un BLOQUEO en la agenda maestra a esa hora.
3. Vuelve a ejecutar: no debe crear un segundo bloqueo, gracias al Set de claves.
4. Crea a mano dos citas pisándose con el mismo profesional y comprueba que llega el aviso de Telegram con las dos.
5. Prueba también dos citas de profesionales distintos en la misma sala.

## Qué puede salir mal
- **Bloqueos duplicados**: si un colaborador mueve un evento, el bloqueo viejo se queda. Añade un paso que borre los BLOQUEO de ese profesional que ya no tengan correspondencia en su calendario personal, comparando por hora de inicio.
- **Privacidad del colaborador**: pídele el permiso de solo disponible/ocupado, nunca el de ver todos los detalles. Es su vida privada y además te evita problemas.
- **Solapes intencionados**: a veces se solapa a propósito (una sesión de valoración corta encima de otra). Añade la palabra SOLAPE_OK en el título y descártalos en el código.
- **Límites de la API de Calendar**: un millón de peticiones al día, ni te acercas. Pero si tienes 15 profesionales y ejecutas cada 30 minutos, sube el intervalo a 1 hora para no acumular ejecuciones.
- **Zona horaria**: si un colaborador tiene su calendario en otra zona, los bloqueos salen desplazados. Trabaja siempre con dateTime en ISO, que ya lleva el desfase, como hace el código.

## Cuánto cuesta
- Google Calendar, Sheets y Telegram: gratis.
- n8n auto-alojado: gratis más el VPS.
- Total: 0 € al mes de licencias.
