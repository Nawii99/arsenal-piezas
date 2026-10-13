# Detector de fichas duplicadas y datos rotos…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Peina tu base de pacientes buscando la misma persona repetida con teléfonos, emails o nombres escritos de forma distinta, y te propone las fusiones junto con los datos mal formados.

## Qué es y qué hace

Una vez al mes recorre la hoja de pacientes, normaliza nombres y teléfonos, calcula parecidos y agrupa los posibles duplicados. Marca datos imposibles: teléfonos de menos de nueve cifras, emails sin arroba, fechas futuras o campos vacíos. Entrega un informe y una hoja Fusiones donde decides qué se fusiona. Entrada: hoja Pacientes; salida: candidatos y avisos de datos. Se monta en n8n con Google Sheets y Gmail.

## Cómo usarla

1. Preparar la hoja Pacientes y la hoja Fusiones
2. Hacer una copia de seguridad antes
3. Revisar a mano las primeras fusiones
4. Que lo revise un profesional

## Cuándo usarla

Cuando llevas años acumulando fichas y ya no sabes si Ana Gómez y Ana Gomez son la misma, ni por qué a algunos les llegan dos recordatorios.

## Cómo ganar dinero con ella

Una base sucia arruina cualquier automatización posterior; limpiarla evita mensajes duplicados que molestan y recupera historiales partidos en dos.

- Limpiar bases de pacientes antiguas de clínicas y centros de estética, cobrando por tramo.
- Ofrecer una revisión periódica de calidad de datos a gestorías y clínicas.
- Montar un informe de datos incompletos para mejorar el alta de pacientes.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Una vez al mes recorre tu hoja de pacientes, normaliza nombres y teléfonos, calcula parecidos y agrupa los candidatos a ser la misma persona; además marca los datos imposibles: teléfonos de menos de 9 cifras, emails sin arroba, fechas futuras, campos obligatorios vacíos.
Te manda un informe con las parejas sospechosas ordenadas por confianza y una hoja `Fusiones` donde tú decides cuál se queda; luego un segundo workflow aplica lo aprobado.
Para cualquier clínica con más de 300 fichas acumuladas y varias personas dando de alta pacientes.

## Lo que necesitas antes
Google Sheet `Pacientes` con `id`, `nombre`, `apellidos`, `telefono`, `email`, `fecha_nacimiento`, `fecha_alta`.
Google Sheet `Fusiones` con `id_a`, `id_b`, `motivo`, `confianza`, `decision` (vacío, `fusionar` o `distintos`), `id_ganador`.
Credenciales `Google Sheets OAuth2` y `Gmail OAuth2`.
Una copia de seguridad del Sheet antes de tocar nada: Archivo, Hacer una copia. Esto no es opcional.

## Los nodos, en orden
1. **Schedule Trigger** — `0 7 1 * *`.
2. **Google Sheets** — `Get Row(s)` de `Pacientes`, `Return All`.
3. **Code** — normaliza, detecta duplicados y errores (código abajo).
4. **Split Out** — campo `duplicados` para convertir cada pareja en un item.
5. **Google Sheets** — `Append Row` en `Fusiones`, solo si la pareja no estaba ya (usa un **Google Sheets** previo con `Get Row(s)` y un **Filter** comparando `id_a` + `id_b`).
6. **Gmail** — `Send` con el informe: cuántas fichas hay, cuántas parejas nuevas, cuántos errores de formato y el enlace a la hoja `Fusiones`.
7. Workflow 2, **Schedule Trigger** `0 7 * * 5` — **Google Sheets** lee `Fusiones` filtrando `decision` = `fusionar`.
8. **Code** — construye la ficha combinada quedándose con el valor no vacío más reciente de cada campo y sumando historial.
9. **Google Sheets** — `Update Row` sobre el `id_ganador` y marca la otra ficha con `estado` = `fusionada_en:{{$json.id_ganador}}` en lugar de borrarla, para no perder trazabilidad.

## El nodo Code
```js
const norm = s => String(s || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/[^a-z0-9 ]/g, '').trim();
const normTel = t => String(t || '').replace(/\D/g, '').slice(-9);
const filas = $input.all().map(i => i.json);
const errores = [];
const duplicados = [];
for (const p of filas) {
  const tel = normTel(p.telefono);
  if (p.telefono && tel.length !== 9) errores.push({ id: p.id, campo: 'telefono', valor: p.telefono });
  if (p.email && !/^[^@\s]+@[^@\s]+\.[a-z]{2,}$/i.test(p.email)) errores.push({ id: p.id, campo: 'email', valor: p.email });
  if (p.fecha_nacimiento && new Date(p.fecha_nacimiento) > new Date()) errores.push({ id: p.id, campo: 'fecha_nacimiento', valor: p.fecha_nacimiento });
  if (!p.nombre || !p.apellidos) errores.push({ id: p.id, campo: 'nombre', valor: 'vacío' });
}
for (let i = 0; i < filas.length; i++) {
  for (let j = i + 1; j < filas.length; j++) {
    const a = filas[i], b = filas[j];
    const ta = normTel(a.telefono), tb = normTel(b.telefono);
    const ea = norm(a.email), eb = norm(b.email);
    const na = norm(a.nombre + ' ' + a.apellidos), nb = norm(b.nombre + ' ' + b.apellidos);
    let confianza = 0;
    const motivos = [];
    if (ta && ta === tb) { confianza += 60; motivos.push('mismo teléfono'); }
    if (ea && ea === eb) { confianza += 50; motivos.push('mismo email'); }
    if (na && na === nb) { confianza += 40; motivos.push('mismo nombre'); }
    else if (na && nb && na.slice(0, 6) === nb.slice(0, 6) && na.split(' ').pop() === nb.split(' ').pop()) { confianza += 20; motivos.push('nombre parecido'); }
    if (a.fecha_nacimiento && a.fecha_nacimiento === b.fecha_nacimiento) { confianza += 25; motivos.push('misma fecha nacimiento'); }
    if (confianza >= 60) duplicados.push({ id_a: a.id, id_b: b.id, motivo: motivos.join(' + '), confianza: Math.min(confianza, 100) });
  }
}
duplicados.sort((x, y) => y.confianza - x.confianza);
return [{ json: { total: filas.length, errores, duplicados } }];
```

## Cómo probarla
Duplica tres fichas a propósito cambiando tildes, espacios en el teléfono y el email, y comprueba que las tres salen con confianza alta.
Mete dos hermanos con el mismo teléfono fijo y apellidos iguales: deben salir como sospechosos, y tú los marcas `distintos` para que no vuelvan a proponerse.

## Qué puede salir mal
Con más de 3.000 fichas la comparación de todos contra todos se hace lenta: agrupa primero por las tres primeras letras del apellido y compara solo dentro de cada grupo.
Familias que comparten teléfono y email dan falsos positivos: por eso la decisión es siempre humana y se guarda `distintos` para no repetir la propuesta.
No borres nunca la ficha perdedora, márcala; si te equivocas de fusión, poder deshacer vale oro.
Google Sheets tiene un límite de 10 millones de celdas y las escrituras van a unas 60 por minuto; usa `Append` en tandas si tienes muchas parejas.

## Cuánto cuesta
Gratis entero: n8n auto-alojado, Google Sheets y Gmail.
Solo cuesta tiempo la primera revisión manual de las parejas, entre una y tres horas según lo sucia que esté la base.
