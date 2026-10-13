# Detector de anuncios fantasma…

**Tipo:** Receta de automatización · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Señala las ofertas abiertas meses sin contratar o que piden lo imposible: no gastes tiempo en ellas.

## Qué es y qué hace

Flujo semanal que lee tu hoja de ofertas, calcula cuántos días lleva abierta cada una, busca requisitos imposibles y republicaciones, y genera un informe con las que probablemente no contratan a nadie. Entra la hoja con fechas y textos de las ofertas, y sale un listado con señales y un nivel de riesgo. Son indicios, no pruebas: el informe da pistas sobre una oferta, no sentencias sobre una empresa.

## Cómo usarla

1. Exporta tu hoja de ofertas con fecha y texto
2. Define las reglas de señales (antigüedad, requisitos imposibles, republicación)
3. Pasa el texto a un modelo con salida en JSON
4. Revisa el informe antes de descartar nada

## Cuándo usarla

Cuando llevas semanas postulando y no te contesta nadie, y sospechas que la mitad de esas ofertas no existen.

## Cómo ganar dinero con ella

Es el gancho para vender el servicio: le pasas a un candidato el informe de cuales de sus 40 candidaturas eran humo. 40-60 euros el informe suelto.

- Informe de candidaturas descartables para un candidato: revisión de sus 40 ofertas con lista priorizada.
- Filtro previo de ofertas para orientadores laborales que atienden a muchos alumnos a la vez.
- Plantilla de revisión de ofertas para agencias de empleo que quieren ahorrar tiempo a sus candidatos.

**Precio orientativo:** 40–60 € por informe. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

DETECTOR DE ANUNCIOS FANTASMA

Qué hace: una vez por semana lee tu hoja de ofertas, mide cuánto lleva cada una abierta, busca requisitos imposibles y republicaciones, y te manda un informe con las que probablemente no van a contratar a nadie.
Por qué importa: un anuncio fantasma se lleva tu carta de presentación y tu semana de espera. Detectarlos no te da entrevistas, pero te devuelve horas.

QUÉ ES UN ANUNCIO FANTASMA
- Vacante que sigue publicada aunque ya esté cubierta o congelada.
- Vacante abierta para hacer cantera: recogen currículums por si acaso.
- Consultora que publica un puesto que aún no ha ganado, para enseñar candidatos a su cliente.
- Anuncio que existe solo para que la empresa parezca que crece.
Ninguna de estas cosas se puede demostrar desde fuera. Lo que hace esta receta es dar señales, no sentencias.

CUENTAS Y LÍMITES GRATUITOS
- n8n autoalojado: gratis, sin límite de ejecuciones.
- Google Sheets: gratis. Necesitas la hoja "ofertas" que rellena el rastreador multiportal.
- Telegram Bot: gratis.
- Nada más. Esta receta no llama a ninguna API de pago.

AVISO SOBRE LINKEDIN
- No compruebes ofertas de LinkedIn con peticiones automáticas. Ni con HTTP Request, ni con un navegador sin cabeza.
- Detectan el patrón (muchas peticiones sin sesión de navegación normal) y la consecuencia es restricción o cierre de cuenta.
- Para LinkedIn hazlo a mano: mira la fecha de publicación que muestra el propio anuncio y si aparece "republicada".
- Con InfoJobs y Tecnoempleo, comprobar si la URL sigue viva una vez por semana es tráfico razonable. No lo pongas cada hora.

NODO 1 - Schedule Trigger
- Modo: Weeks. Día: viernes. Hora: 10:00. Zona Europe/Madrid.
- Los viernes ya sabes qué ha pasado con lo que mandaste el lunes.

NODO 2 - Google Sheets
- Operación: Get Row(s). Hoja "ofertas".
- Filtro: columna estado igual a "nueva" o "postulada". Las descartadas no las revises.

NODO 3 - Code, llámalo Días abierta
- Modo: Run Once for All Items.
  const hoy = new Date();
  return $input.all().map(i => {
    const d = i.json;
    const pub = new Date(d.fecha_publicacion || d.fecha_captura);
    d.dias_abierta = Math.round((hoy - pub) / 86400000);
    return { json: d };
  });

NODO 4 - Code, llámalo Republicaciones
- Busca la misma oferta apareciendo varias veces en tu histórico con fechas distintas.
  const todas = $input.all().map(i => i.json);
  const cuenta = {};
  for (const o of todas) { cuenta[o.clave] = (cuenta[o.clave] || 0) + 1; }
  return todas.map(o => { o.veces_publicada = cuenta[o.clave]; return { json: o }; });

NODO 5 - Code, llámalo Requisitos imposibles
- Aquí está el truco: comparar los años que piden con la edad real de la tecnología.
  const nacimiento = { react: 2013, angular: 2016, vue: 2014, svelte: 2016, next: 2016, nuxt: 2016, astro: 2021, tailwind: 2017, typescript: 2012, kubernetes: 2014, docker: 2013, terraform: 2014, rust: 2015, go: 2009, swift: 2014, kotlin: 2016, flutter: 2018, langchain: 2022, node: 2009, django: 2005, laravel: 2011, spring: 2003, python: 1991, java: 1995, sql: 1974 };
  const anio = new Date().getFullYear();
  return $input.all().map(i => {
    const d = i.json;
    const texto = (d.titulo + ' ' + (d.descripcion || '')).toLowerCase();
    d.imposibles = [];
    for (const [tec, nace] of Object.entries(nacimiento)) {
      if (!texto.includes(tec)) continue;
      const re = new RegExp('(\\d{1,2})\\s*(\\+)?\\s*(años|anos|years)[^.]{0,60}' + tec, 'i');
      const m = texto.match(re) || texto.match(new RegExp(tec + '[^.]{0,60}(\\d{1,2})\\s*(\\+)?\\s*(años|anos|years)', 'i'));
      if (!m) continue;
      const piden = parseInt(m[1], 10);
      const maximo = anio - nace;
      if (piden > maximo) d.imposibles.push(tec + ': piden ' + piden + ' años y la tecnología tiene ' + maximo);
    }
    return { json: d };
  });
- Ajusta la tabla de años a tu sector. Si te mueves en datos, añade dbt 2016, Snowflake 2014, Airflow 2015.

NODO 6 - HTTP Request, llámalo Sigue viva
- Método GET a {{ $json.url }}.
- En Settings: "Continue On Fail" activado y "Never Error" en la respuesta. Response: Include Response Headers and Status.
- Batching: 1 petición cada 2000 milisegundos. Vas a lo educado, no a machacar el servidor.
- Salta este nodo para las URL de LinkedIn: añade antes un If con {{ $json.url.includes('linkedin') }} y manda esa rama directa al siguiente paso.

NODO 7 - Code, llámalo Puntuar fantasma
- Nota de 0 a 100. Cuanto más alta, más humo.
  return $input.all().map(i => {
    const d = i.json; let p = 0; const motivos = [];
    if (d.dias_abierta > 90) { p += 30; motivos.push('Lleva ' + d.dias_abierta + ' días publicada'); }
    else if (d.dias_abierta > 45) { p += 18; motivos.push('Más de 45 días abierta'); }
    if (d.veces_publicada > 2) { p += 25; motivos.push('Republicada ' + d.veces_publicada + ' veces'); }
    if ((d.imposibles || []).length) { p += 25; motivos.push('Requisitos imposibles: ' + d.imposibles.join('; ')); }
    if (!d.salario_min && !d.salario_max) { p += 10; motivos.push('Sin salario publicado'); }
    const t = (d.descripcion || '').toLowerCase();
    if (/banco de talento|base de datos de candidatos|futuras vacantes|proceso abierto de forma continua/.test(t)) { p += 20; motivos.push('Dice abiertamente que es cantera'); }
    if (/gran familia|ambiente familiar|pasión por|disponibilidad total/.test(t)) { p += 5; motivos.push('Lenguaje de humo'); }
    if ((d.empresa || '').toLowerCase().includes('confidencial')) { p += 10; motivos.push('Empresa confidencial'); }
    d.fantasma = Math.min(100, p);
    d.motivos = motivos.join(' · ');
    return { json: d };
  });

NODO 8 - Filter
- Deja pasar solo {{ $json.fantasma }} mayor o igual que 45.

NODO 9 - Google Sheets
- Operación: Update Row. Busca por la columna url.
- Escribe fantasma y motivos. Así tu hoja se va marcando sola y ves los patrones por empresa.

NODO 10 - Code, llámalo Informe
- Junta todo en un solo mensaje. Un mensaje por oferta te satura el móvil.
  const l = $input.all().map(i => i.json).sort((a,b) => b.fantasma - a.fantasma);
  const txt = l.map(d => '• ' + d.titulo + ' (' + d.empresa + ') — ' + d.fantasma + '/100\\n  ' + d.motivos).join('\\n');
  return [{ json: { mensaje: 'Ofertas sospechosas esta semana: ' + l.length + '\\n\\n' + txt + '\\n\\nNo son mentira segura. Son señales. Baja la prioridad, no las descartes del todo.' } }];

NODO 11 - Telegram
- Send Message con {{ $json.mensaje }}. Sin parse mode, para que los guiones no te rompan el formato.

CÓMO PROBARLA SIN LIARLA
1. Duplica tu hoja de Google Sheets y trabaja sobre la copia hasta que el nodo de Update Row escriba donde debe.
2. Ejecuta a mano con el Schedule desactivado.
3. Pon un NoOp después de Puntuar fantasma y revisa a ojo diez ofertas: ¿estás de acuerdo con la nota? Si te marca fantasma algo a lo que te llamaron, baja los pesos.
4. Comprueba el nodo Sigue viva con una URL que sepas que está muerta y otra que sepas que está viva. Muchos portales devuelven 200 con una página de "oferta no disponible": si te pasa, en vez de mirar el código de estado, busca ese texto en el cuerpo con un If.
5. Activa el Schedule solo cuando una semana entera de resultados te parezca sensata.

AVISOS HONESTOS
- Una oferta con 60 días no siempre es humo. Administración pública, empresas grandes y puestos muy específicos tardan de verdad.
- Un anuncio republicado puede significar que el primer candidato les falló. Eso te conviene.
- Nota alta significa: no le dediques una carta de presentación de una hora. Postula en dos minutos y olvídate.
- No escribas a la empresa diciendo que su oferta es fantasma. No te va a llevar a ningún sitio bueno.
