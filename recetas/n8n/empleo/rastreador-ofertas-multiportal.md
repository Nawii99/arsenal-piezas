# Rastreador de ofertas multiportal con aviso por Telegram…

**Tipo:** Receta de automatización · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Cada mañana busca ofertas en varios portales, quita lo repetido y te manda solo lo nuevo por Telegram.

## Qué es y qué hace

Flujo de n8n que cada mañana consulta APIs públicas de empleo (Adzuna, con clave gratuita; Jooble, y RemoteOK), unifica las ofertas, quita las repetidas y las que ya viste, aplica tus filtros y te manda solo lo nuevo por Telegram. Entra tu lista de búsquedas y sale un aviso diario con enlaces. Se monta en n8n autoalojado con Docker o en n8n Cloud, con prueba de 14 días. Las ofertas siguen revisándose a mano.

## Cómo usarla

1. Regístrate en Adzuna y Jooble para obtener las claves
2. Define búsquedas y filtros en un nodo Set
3. Quita duplicados contra una hoja de ofertas vistas
4. Programa el disparador diario y el aviso en Telegram

## Cuándo usarla

Cuando pierdes una hora al dia repasando InfoJobs, Tecnoempleo y LinkedIn a mano y siempre ves las mismas ofertas.

## Cómo ganar dinero con ella

Montas el flujo para otro candidato por 120-180 euros, o 25 euros al mes si se lo alojas tu y le cambias los filtros cuando cambia de objetivo.

- Montaje de un rastreador de ofertas a medida para un candidato, con búsquedas y filtros ajustados a su perfil.
- Cuota mensual por mantener el rastreador: ajustar filtros cuando cambia el objetivo y revisar que las fuentes siguen funcionando.
- Panel de vigilancia de ofertas tech para agencias pequeñas que buscan perfiles junior en España.

**Precio orientativo:** 120–180 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

RASTREADOR DE OFERTAS EN VARIOS PORTALES CON AVISO POR TELEGRAM

Qué hace: cada mañana consulta varias fuentes de empleo, junta todo en una lista, elimina lo repetido y lo que ya viste ayer, filtra por lo que tú pides y te manda al móvil solo lo nuevo.
Tiempo de montaje la primera vez: unas dos horas. Después, cero.

CUENTAS QUE NECESITAS Y LÍMITES GRATUITOS
- n8n. Autoalojado con Docker es gratis y sin límite de ejecuciones. n8n Cloud da 14 días de prueba y luego es de pago (desde unos 20 euros al mes).
- Adzuna: registro gratis en developer.adzuna.com. Te da app_id y app_key. Plan gratis: 250 llamadas al día, hasta 50 resultados por llamada. Tiene país España.
- Jooble: pides clave gratis en jooble.org/api/about. Unas 500 peticiones al día. Es un agregador: ahí caen ofertas que vienen de InfoJobs, Tecnoempleo y webs de empresa.
- RemoteOK: API pública sin clave en https://remoteok.com/api. Piden espaciar las llamadas (una por minuto va sobrado) y no quitar la atribución.
- Arbeitnow: API gratis y sin clave en https://www.arbeitnow.com/api/job-board-api. Mucho remoto europeo.
- Telegram: un bot creado con @BotFather. Gratis. El límite real (30 mensajes por segundo) no lo vas a rozar.
- Google Sheets: gratis con tu cuenta de Google. Es tu histórico y lo consultas desde el móvil.

AVISO SERIO: LINKEDIN NO ENTRA AQUÍ
- Raspar LinkedIn va contra sus condiciones de uso y su sistema antibot es agresivo.
- Lo que pasa de verdad: primero restricción temporal, después te piden documento de identidad, y a la tercera te cierran la cuenta.
- Si estás buscando trabajo, tu perfil de LinkedIn es tu herramienta principal. Perderlo por ahorrar diez minutos al día es un mal cambio.
- LinkedIn se mira a mano. Usa sus propias alertas de empleo y que te lleguen por correo. Eso sí puedes leerlo con n8n desde Gmail.
- InfoJobs igual: su API abierta ya no se concede a particulares. Llegas a sus ofertas vía Jooble o entrando tú.

NODO 1 - Schedule Trigger
- Tipo: Schedule Trigger.
- Modo: Days. Hora 07:30. Zona horaria Europe/Madrid (ponla también en Settings del flujo).
- Todos los días. Los lunes es cuando más se publica, pero las ofertas buenas se llenan en 48 horas.

NODO 2 - Set, llámalo Mis criterios
- Añade estos campos de texto, así los cambias en un sitio y no en cinco:
  busqueda = "soporte informatico" (o "data entry", "QA junior", "automatizacion", lo tuyo)
  ciudad = "Madrid"
  radio_km = 30
  salario_minimo = 20000
  dias_max_antiguedad = 20

NODO 3 - HTTP Request, llámalo Adzuna
- Método GET.
- URL: https://api.adzuna.com/v1/api/jobs/es/search/1
- Query parameters: app_id (el tuyo), app_key (la tuya), results_per_page = 50, what = {{ $json.busqueda }}, where = {{ $json.ciudad }}, distance = {{ $json.radio_km }}, max_days_old = {{ $json.dias_max_antiguedad }}, content-type = application/json
- En Settings del nodo activa "Always Output Data" y "Continue On Fail": si un portal se cae, el resto sigue.

NODO 4 - HTTP Request, llámalo Jooble
- Método POST.
- URL: https://es.jooble.org/api/TU_CLAVE
- Body como JSON: {"keywords": "{{ $('Mis criterios').item.json.busqueda }}", "location": "{{ $('Mis criterios').item.json.ciudad }}", "page": "1"}
- Continue On Fail activado también.

NODO 5 - HTTP Request, llámalo RemoteOK
- Método GET. URL: https://remoteok.com/api
- Headers: User-Agent con tu nombre y tu correo. Lo piden y evita bloqueos.
- El primer elemento de la respuesta es un aviso legal, no una oferta. Se descarta en el nodo de normalizar.

NODO 6 - HTTP Request, llámalo Arbeitnow
- Método GET. URL: https://www.arbeitnow.com/api/job-board-api
- Sin cabeceras raras. Devuelve el campo data con las ofertas.

NODO 7 - Merge
- Tipo Merge, modo Append, Number of Inputs = 4.
- Conecta Adzuna, Jooble, RemoteOK y Arbeitnow a las cuatro entradas.

NODO 8 - Code, llámalo Normalizar
- Modo: Run Once for All Items. Pega este JavaScript:
  const salida = [];
  const norm = (t) => (t || '').toString().toLowerCase().replace(/\s+/g, ' ').trim();
  for (const item of $input.all()) {
    const d = item.json;
    const bloques = d.results || d.jobs || d.data || [d];
    for (const o of bloques) {
      if (!o || o.legal) continue;
      const titulo = o.title || o.position || '';
      const empresa = o.company?.display_name || o.company || o.company_name || 'sin nombre';
      const url = o.redirect_url || o.link || o.url || '';
      if (!titulo || !url) continue;
      salida.push({ json: {
        titulo,
        empresa,
        url,
        ubicacion: o.location?.display_name || o.location || o.candidate_required_location || 'no dice',
        salario_min: o.salary_min || null,
        salario_max: o.salary_max || null,
        fecha: o.created || o.updated || o.date || o.publication_date || new Date().toISOString(),
        descripcion: (o.description || o.snippet || '').replace(/<[^>]*>/g, ' ').slice(0, 1200),
        clave: norm(titulo) + '|' + norm(empresa)
      }});
    }
  }
  return salida;
- La clave junta título y empresa en minúsculas. Así la misma oferta publicada en dos portales cuenta como una.

NODO 9 - Remove Duplicates
- Operación: Remove Items Seen in Previous Executions.
- Keep Items Where: Value Is New.
- Value to Dedupe On: {{ $json.clave }}
- History Size: 10000.
- Esto es lo que evita que te llegue cinco veces la misma oferta cinco días seguidos.

NODO 10 - Filter, llámalo Mis filtros
- Condición 1: {{ $json.titulo.toLowerCase() }} contiene junior O contiene soporte O contiene trainee (usa modo OR con varias condiciones).
- Condición 2 (modo AND con la anterior): {{ $json.titulo.toLowerCase() }} no contiene senior.
- Condición 3: {{ $json.titulo.toLowerCase() }} no contiene lead, ni manager, ni arquitecto.
- Condición 4: {{ $json.salario_max || 99999 }} mayor o igual que {{ $('Mis criterios').first().json.salario_minimo }}. El 99999 deja pasar las que no publican salario, ya las cribas tú.

NODO 11 - Code, llámalo Puntuar rápido
- Da una nota de 0 a 10 para ordenar. No es la puntuación fina, eso lo hace el JSON prompt aparte.
  return $input.all().map(i => {
    const d = i.json; let n = 5;
    const t = d.titulo.toLowerCase();
    if (/junior|trainee|becari|practicas/.test(t)) n += 3;
    if (d.salario_min) n += 2;
    if (/remoto|remote|teletrabajo/i.test(d.ubicacion + d.descripcion)) n += 1;
    if (/5\+ years|10 años|10 years/i.test(d.descripcion)) n -= 3;
    d.nota = Math.max(0, Math.min(10, n));
    return { json: d };
  });

NODO 12 - Sort y NODO 13 - Limit
- Sort: campo nota, descendente.
- Limit: Max Items = 12. Doce ofertas al día son las que de verdad te vas a leer. Más es ruido.

NODO 14 - Google Sheets
- Operación: Append Row. Hoja "ofertas".
- Columnas: fecha_captura, titulo, empresa, ubicacion, salario_min, salario_max, url, clave, fecha_publicacion, nota, estado.
- Rellena estado con "nueva". Esa columna la vas cambiando tú a mano: postulada, respondida, descartada.
- Esta hoja es la que alimenta la receta del detector de anuncios fantasma.

NODO 15 - Telegram
- Credencial: el token que te da @BotFather.
- Tu chat id: escribe a @userinfobot y te lo dice. Habla primero tú con tu bot o no podrá escribirte.
- Operación: Send Message. Parse Mode: HTML.
- Texto: <b>{{ $json.titulo }}</b>\n{{ $json.empresa }} · {{ $json.ubicacion }}\nNota {{ $json.nota }}/10 · {{ $json.salario_min ? $json.salario_min + '-' + $json.salario_max + ' €' : 'sin salario publicado' }}\n{{ $json.url }}

NODO 16 - Wait
- Entre el Sort y el Telegram, si mandas muchas: Wait de 1 segundo, modo After Time Interval. Evita que Telegram te corte por ráfaga.

CÓMO PROBARLA SIN LIARLA
1. Desactiva el Schedule Trigger mientras montas. Ejecuta a mano con "Test workflow".
2. Empieza con un solo portal (Adzuna). Cuando veas datos correctos en Normalizar, añade el siguiente.
3. Usa Pin Data en el nodo Adzuna: congela una respuesta real y prueba los nodos de abajo sin gastar llamadas de tu cuota diaria.
4. Antes de conectar Telegram, pon un nodo NoOp y mira los 12 resultados en pantalla. Si te llegan ofertas de comercial o de camarero, arregla los filtros ahí, no en el móvil.
5. La primera ejecución real te mandará muchas ofertas de golpe porque el histórico está vacío. Es normal. A partir del segundo día llegan dos o tres.
6. Deja el Schedule activo solo cuando dos ejecuciones seguidas te den resultados que de verdad te interesan.

AVISOS HONESTOS
- Los agregadores llegan tarde: una oferta puede aparecerte 24 o 48 horas después de publicarse en el portal original. Para las empresas que te importan de verdad, sigue mirando su web de empleo a mano.
- Las URL de las APIs cambian. Si un día el flujo devuelve vacío, abre la URL en el navegador antes de tocar nada más.
- Esto te ahorra la búsqueda, no la candidatura. Postular en masa con el mismo currículum no funciona: sigue teniendo peor tasa de respuesta que diez candidaturas adaptadas.
