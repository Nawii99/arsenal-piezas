# Purga y anonimizado de datos de clientes según RGPD…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Cada mes localiza fichas de clientes inactivos más allá del plazo que has fijado, las anonimiza y deja constancia escrita de la limpieza.

## Qué es y qué hace

Cada mes localiza en Google Sheets las fichas de clientes que superan tu plazo de conservación, sustituye sus datos identificativos por un código y mueve sus archivos de Drive a una carpeta de borrado con registro de la actuación. Entrada: hoja Fichas y carpetas de Drive; salida: fichas anonimizadas y log. Se monta en n8n y sirve para clínicas y consultas con datos de salud.

## Cómo usarla

1. Define por escrito tu plazo de conservación
2. Prepara la hoja Fichas y la carpeta de borrado
3. Programa la ejecución mensual en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando manejas datos de salud (fichas, anamnesis, fotos de evolución) y sabes que deberías tener una política de conservación pero nunca encuentras el momento de aplicarla.

## Cómo ganar dinero con ella

Evita sanciones que empiezan en 2.000 euros para pymes y te ahorra la consultoría anual de cumplimiento, que ronda los 400 a 800 euros.

- Política de conservación y purga de fichas RGPD para una clínica o consulta de fisioterapia.
- Auditoría anual de datos de clientes con registro de anonimizaciones para un centro de bienestar.
- Plantilla de registro de actuaciones RGPD para autónomos que manejan datos de salud.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
El día 1 de cada mes revisa las fichas de clientes, detecta las que superan el plazo de conservación que has definido, sustituye los datos identificativos por un código, mueve los archivos asociados a una carpeta de borrado y escribe un registro de la actuación.
Para clínicas, consultas y centros de bienestar que guardan datos de categoría especial.

## Lo que necesitas antes
- n8n instalado, preferiblemente auto-alojado si te preocupa que los datos pasen por un tercero.
- Hoja «Fichas» en Sheets: Id ficha, Nombre, Email, Telefono, DNI, Ultima sesion, Carpeta Drive, Estado, Base legal.
- Una carpeta en Google Drive por cliente, o al menos una carpeta «Pendiente de borrado».
- Definir por escrito tu plazo de conservación. Para historia clínica en España el criterio habitual es 5 años desde la última asistencia; para datos de marketing, 2 años sin interacción. Consúltalo con tu asesor y escribe el número en una hoja «Politica».
- Gmail para el aviso al responsable.

## Los nodos, en orden
1. **Schedule Trigger**: Cron 0 7 1 * * (día 1 de cada mes a las 7:00).
2. **Google Sheets** (Get Rows) sobre «Politica»: lee los años de conservación por tipo de dato.
3. **Google Sheets** (Get Rows) sobre «Fichas».
4. **Code** (nombre: «Detectar caducadas»): calcula los años transcurridos y separa en dos grupos, «avisar» (a 60 días de cumplir el plazo) y «purgar». Código abajo.
5. **IF**: si hay fichas a purgar, sigue; si no, manda un Gmail de «nada que purgar este mes» y termina.
6. **Gmail** (Send Message) al responsable con la lista de las que se van a purgar y un aviso de que tiene 7 días para objetar.
7. **Wait**: «After Time Interval», 7 días. Es la ventana de revisión humana, imprescindible: no borres nada sin que alguien pueda pararlo.
8. **Google Sheets** (Get Row): relee cada ficha por si el responsable la ha marcado como «conservar».
9. **IF**: descarta las marcadas como conservar.
10. **Google Sheets** (Update Row): sustituye Nombre por «ANONIMIZADO», Email, Telefono y DNI por cadena vacía, y pon Estado = «anonimizada».
11. **Google Drive** (Move File/Folder): mueve la carpeta del cliente a «Pendiente de borrado definitivo».
12. **Google Sheets** (Append Row) en «Registro RGPD»: fecha, id ficha (sin nombre), acción realizada, plazo aplicado y quién autorizó.
13. **Gmail** (Send Message): confirmación con el número de fichas tratadas.

## El código del nodo Code
```javascript
const politica = $('Google Sheets').first().json;
const aniosClinica = Number(politica['Anios clinica'] || 5);
const hoy = new Date();
const purgar = [];
const avisar = [];
for (const item of $input.all()) {
  const f = item.json;
  if ((f.Estado || '') === 'anonimizada') continue;
  if (!f['Ultima sesion']) continue;
  const dias = Math.floor((hoy - new Date(f['Ultima sesion'])) / 86400000);
  const limite = aniosClinica * 365;
  if (dias >= limite) {
    purgar.push({ id: f['Id ficha'], fila: f.row_number, carpeta: f['Carpeta Drive'], dias });
  } else if (dias >= limite - 60) {
    avisar.push({ id: f['Id ficha'], faltan: limite - dias });
  }
}
return [{ json: { purgar, avisar, totalPurgar: purgar.length, totalAvisar: avisar.length } }];
```

## Cómo probarla
- Crea tres fichas de prueba con fechas de última sesión de hace 1, 4 y 6 años. Solo la de 6 debe entrar en «purgar».
- La primera vez desactiva los nodos de Update Row y Drive y quédate solo con el correo. Comprueba la lista durante dos o tres meses antes de dejar que borre de verdad.
- Reduce el Wait a 5 minutos mientras pruebas.

## Qué puede salir mal
- **Borrar algo que había que conservar**: por eso están el correo previo, la ventana de 7 días y la columna «conservar». No quites ninguno de los tres.
- **Anonimizar no es borrar**: si dejas la fecha de nacimiento y el código postal, la ficha puede seguir siendo reidentificable. Vacía también esos campos.
- **Copias en otros sitios**: si tienes los mismos datos en tu software de citas, en el correo o en WhatsApp, este flujo solo limpia la hoja. Haz la lista de todos los sitios donde vive el dato.
- **Plazos**: no te inventes los años. Los plazos de historia clínica varían según comunidad autónoma; pregunta a tu asesor y anótalo en la hoja «Politica».
- **La papelera de Drive** conserva los archivos 30 días. Vacíala manualmente cuando toque.

## Cuánto cuesta
- Google Sheets, Drive (15 GB) y Gmail: gratis.
- n8n auto-alojado: 0 euros. Es la opción recomendable aquí para que los datos no salgan de tu servidor.
