# arsenal-empleo · Empleo y currículum

Empleo y currículum: 29 comandos /, 23 skills, 12 subagentes en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-empleo@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| adaptar-curriculum | Comando / | Coge el anuncio que pegas y reescribe tu curriculum para esa oferta concreta: reordena, prioriza y usa sus palabras. Sin inventar nada. | `/adaptar-curriculum` |
| candidatura-guiada-con-paradas | Comando / | Comando de Claude Code que lleva una oferta de empleo por seis etapas con parada en cada una: filtrar, investigar, adaptar el currículum, escribir la carta, preparar el envío y seguimiento. | `/candidatura-guiada-con-paradas` |
| carta-con-tu-voz | Comando / | Genera una carta de presentación desde la oferta y tu perfil, y la reescribe con tu forma de escribir, sin inventar nada. | `/carta-con-tu-voz` |
| carta-oferta | Comando / | Pegas la oferta, sueltas tu experiencia y salen tres versiones de carta: larga, corta y mensaje de portal. | `/carta-oferta` |
| carta-presentacion | Comando / | Comando que genera una carta de presentación corta a partir del CV del usuario y una oferta de trabajo concreta. | `/carta-presentacion` |
| carta-presentacion-2 | Comando / | Comando que genera una carta de presentación corta adaptada a una oferta de trabajo concreta a partir del CV del usuario, para no escribirla desde cero en cada postulación. | `/carta-presentacion-2` |
| comando-buscar-ofertas | Comando / | Las búsquedas exactas para pegar en cada portal sin volver a ver lo que ya rechazaste. | `/comando-buscar-ofertas` |
| corregir-errores-cv-ats | Comando / | Revisa un CV ya escrito, señala los fallos de formato y contenido que hacen que un ATS lo descarte, y entrega la versión corregida lista para enviar. | `/corregir-errores-cv-ats` |
| curriculum-tech | Comando / | Escribe tu currículum para un puesto de tecnología en texto plano y formato ATS, lo adapta a la oferta con sus palabras clave, añade versión para LinkedIn y te dice qué reforzar. | `/curriculum-tech` |
| cv-typst | Comando / | Genera el PDF de tu CV con una plantilla Typst de licencia libre. Cambias los datos una vez y a partir de ahí regenerar el PDF cuesta segundos, sin pelearte con Word. | `/cv-typst` |
| cv-una-pagina-html | Comando / | Comando para Claude Code que genera tu currículum de una página en un solo archivo HTML, listo para abrir en el navegador e imprimir a PDF. Sin instalar nada. | `/cv-una-pagina-html` |
| estado-busqueda | Comando / | Comando que resume tu busqueda de empleo: que se ha movido esta semana, que tienes que hacer hoy y que candidaturas hay que dar por muertas y cerrar. | `/estado-busqueda` |
| mi-busqueda-empleo | Comando / | Comando de Claude Code (un archivo .md en .claude/commands) con cinco modos: nueva, estado, semana, entrevista y sueldo. | `/mi-busqueda-empleo` |
| negociar-sueldo | Comando / | Pegas la oferta y te devuelve la contrapropuesta lista: cifra, frase para decirla, email de respuesta y hasta dónde aguantar. | `/negociar-sueldo` |
| perfil-github | Comando / | Ordena tus repositorios de GitHub y escribe los README que un reclutador lee de verdad, para que tu perfil sostenga lo que dice tu LinkedIn. | `/perfil-github` |
| portfolio-3d | Comando / | Genera tu portfolio en una sola pagina con secciones que se animan al bajar, en 3D ligero o solo CSS, y en un unico archivo listo para publicar. | `/portfolio-3d` |
| portfolio-web | Comando / | Elige y ordena tus proyectos, redacta los textos y te da el index.html completo, con los pasos para publicarlo gratis en GitHub Pages y los README. | `/portfolio-web` |
| preparar-candidatura | Comando / | Comando que, pegando una oferta entera, te devuelve el curriculum adaptado, la carta, el asunto del correo y la lista de revision antes de enviar. | `/preparar-candidatura` |
| preparar-entrevista | Comando / | Te prepara para una entrevista técnica y de recursos humanos: 30 preguntas con respuesta, la pregunta del sueldo, qué preguntar tú y un ensayo simulado. | `/preparar-entrevista` |
| presupuesto-candidato | Comando / | Presupuesto cerrado en minutos: paquete, extras, precio, plazo y válido hasta cuándo. | `/presupuesto-candidato` |
| presupuesto-cv-web | Comando / | Comando que, a partir de dos o tres respuestas del cliente, genera un presupuesto listo para copiar y enviar por email o WhatsApp. | `/presupuesto-cv-web` |
| presupuesto-servicio-cv | Comando / | Comando de Claude Code que redacta un presupuesto formal para un encargo de currículum o carta de presentación, listo para pegar en un email. | `/presupuesto-servicio-cv` |
| primer-curriculum | Comando / | Escribe de cero tu primer curriculum de tecnologia cuando aun no has trabajado en el sector, con el orden y el formato que pasan los filtros. | `/primer-curriculum` |
| propuesta-precio-cv | Comando / | Genera al momento un mensaje de propuesta de precio y alcance para un cliente potencial del servicio de CV, listo para enviar. | `/propuesta-precio-cv` |
| revisar-ats | Comando / | Pega tu currículum y la oferta y te devuelve el veredicto del filtro automático, los fallos con la línea exacta y las correcciones ya escritas. | `/revisar-ats` |
| revisar-cv-ats | Comando / | Revisa un CV en texto y señala qué elementos pueden hacer que un sistema ATS lo descarte antes de que lo vea una persona. | `/revisar-cv-ats` |
| simulacro-entrevista | Comando / | Lanza un simulacro de entrevista completo, cronometrado y con informe final, para el puesto que le digas. | `/simulacro-entrevista` |
| taller-entrevista-logros | Comando / | Un solo comando que guarda ofertas, adapta tu CV a cada una sin inventar datos, prepara y ensaya la entrevista y te saca cinco historias de logros listas para contar. | `/taller-entrevista-logros` |
| triaje-ofertas-empleo | Comando / | Puntúa una oferta de trabajo frente a tu currículum y te dice si merece la pena aplicar, antes de que gastes una tarde adaptando nada. | `/triaje-ofertas-empleo` |
| adaptar-curriculum-oferta | Skill | Adapta un CV en texto plano a una oferta de trabajo concreta, resaltando palabras clave y logros relevantes sin inventar experiencia. | se activa sola cuando hace falta |
| adaptar-cv-a-oferta | Skill | Adapta un CV a una oferta de trabajo concreta, priorizando las palabras clave que buscan los filtros ATS, sin inventar experiencia. | se activa sola cuando hace falta |
| adaptar-cv-a-oferta-2 | Skill | Coge tu CV base y una oferta concreta y devuelve una versión ajustada a esa oferta, sin inventar nada. Es el paso que más tiempo come cuando estás en búsqueda activa. | se activa sola cuando hace falta |
| analizar-embudo-candidaturas | Skill | Skill que lee tus candidaturas, calcula en que fase se te cae el proceso y dice que arreglar primero: curriculum, punteria, prueba tecnica o entrevista. | se activa sola cuando hace falta |
| auditor-ats-cv | Skill | Analiza un CV en busca de los fallos de formato y estructura que hacen que un sistema ATS lo rechace antes de que lo vea una persona, con una lista de arreglos concretos. | se activa sola cuando hace falta |
| auditoria-ats | Skill | Revisa tu currículum contra una oferta y te dice, línea a línea, qué le impide pasar el filtro automático y cómo arreglarlo. | se activa sola cuando hace falta |
| auditoria-ats-cv | Skill | Audita un CV contra una oferta concreta, detecta lo que falta para el ATS y devuelve el CV reescrito con puntuación de encaje. | se activa sola cuando hace falta |
| candidatura-adaptada-skill-guiada | Skill | Cada candidatura sale con la misma estructura: encaje claro, CV ordenado, carta enfocada, portfolio visible. | se activa sola cuando hace falta |
| carta-con-investigacion | Skill | Investiga la empresa antes de escribir la carta de presentación y la redacta con datos reales, no con adjetivos vacíos. | se activa sola cuando hace falta |
| crear-cv-web-basico | Skill | Guía a una persona sin conocimientos de programación para montar una página web sencilla con su currículum. | se activa sola cuando hace falta |
| cv-desde-plantilla | Skill | Skill para Claude Code que convierte los datos de un cliente en un CV terminado sobre una plantilla de LaTeX, Typst, HTML o Word. | se activa sola cuando hace falta |
| cv-web-desde-pdf | Skill | Convierte un currículum en PDF, Word o texto plano en una página web de una sola pantalla, lista para compartir por enlace, sin maquetar nada a mano. | se activa sola cuando hace falta |
| elegir-proyectos-portfolio | Skill | Decide que proyectos ensenas en el portfolio y en que orden, segun la oferta concreta a la que postulas. Y cuales conviene esconder. | se activa sola cuando hace falta |
| experiencia-transferible | Skill | Convierte anos de barra, tienda, atencion al cliente o autonomo en experiencia que un seleccionador de tecnologia entiende y valora. | se activa sola cuando hace falta |
| generador-curriculum-web | Skill | Convierte los datos de una persona en una página de currículum y portfolio de una sola pantalla, lista para publicar gratis en GitHub Pages o Netlify. | se activa sola cuando hace falta |
| linkedin-titular-acerca-de | Skill | Reescribe el titular y el apartado "acerca de" de LinkedIn para que un reclutador entienda en seis segundos que puesto buscas y por que vales. | se activa sola cuando hace falta |
| montar-servicio-candidatos | Skill | Convierte tu ayuda a candidatos en un servicio de verdad: paquetes, precios, alcance cerrado, condiciones y alta de autonomo en Espana. | se activa sola cuando hace falta |
| plan-busqueda-semanal | Skill | Convierte la busqueda de trabajo en una semana con horarios, cuotas y revision del viernes, para dejar de postular a bulto y saber que esta fallando. | se activa sola cuando hace falta |
| plantillas-cv-basico | Skill | Skill para Claude Code que te ayuda a elegir plantilla de currículum (Word, Notion, HTML, Typst o LaTeX) según lo que sepas manejar, y comprueba que la licencia te deja modificarla. | se activa sola cuando hace falta |
| preparar-negociacion-sueldo | Skill | Convierte una oferta en un rango de sueldo defendible: números de mercado, argumentos, guion de la conversación y línea de abandono. | se activa sola cuando hace falta |
| registro-de-envios | Skill | Skill que lleva el control de cada candidatura: que version del curriculum mando a cada empresa, cuando, con que carta y que respondieron. | se activa sola cuando hace falta |
| requisitos-de-verdad | Skill | Lee una oferta y separa lo que de verdad te descarta de lo que es lista de deseos y relleno. Te dice si merece la pena postular. | se activa sola cuando hace falta |
| respuestas-star | Skill | Convierte tus proyectos reales en respuestas STAR para las preguntas de comportamiento, sin inventarte nada. | se activa sola cuando hace falta |
| auditor-cv-web | Subagente | Revisa un currículum web o portfolio ya publicado y devuelve un informe de mejoras concreto, pensado como paso previo a vender una reforma del sitio. | pídele a Claude «usa el subagente auditor-cv-web» |
| candidatura-adaptada-subagente-revisor | Subagente | Dale tu perfil, CV y la oferta; te devuelve encaje analizado, CV adaptado, carta y preguntas para la entrevista. | pídele a Claude «usa el subagente candidatura-adaptada-subagente-revisor» |
| critico-carta-presentacion | Subagente | Revisa una carta de presentación ya escrita y señala sin suavizarlo qué frases son relleno, qué suena genérico y qué la hace indistinguible de las de cualquier otro candidato. | pídele a Claude «usa el subagente critico-carta-presentacion» |
| entrenador-candidaturas-entrevistas | Subagente | Subagente que ordena tu búsqueda de empleo. | pídele a Claude «usa el subagente entrenador-candidaturas-entrevistas» |
| entrevistador-tecnico-exigente | Subagente | Un subagente que te entrevista de verdad: repregunta, te pide ejemplos concretos y no se traga las respuestas de manual. | pídele a Claude «usa el subagente entrevistador-tecnico-exigente» |
| filtro-ats-rechazo | Subagente | Hace de ATS de una empresa: lee tu currículum, lo descarta y te manda el motivo del descarte por escrito, con la línea culpable. | pídele a Claude «usa el subagente filtro-ats-rechazo» |
| gestor-servicio-cv | Subagente | Coordina un encargo de pago de CV y carta de presentación de principio a fin, desde los datos del cliente hasta el paquete final listo para entregar. | pídele a Claude «usa el subagente gestor-servicio-cv» |
| hueco-curriculum-oferta | Subagente | Compara tu curriculum con una oferta y te dice, requisito a requisito, que cumples, que no se ve y que te falta de verdad. | pídele a Claude «usa el subagente hueco-curriculum-oferta» |
| mentor-siguiente-paso | Subagente | Subagente que mira donde estas de verdad y te dice una sola cosa que hacer hoy, con hora de entrega y criterio de terminado. | pídele a Claude «usa el subagente mentor-siguiente-paso» |
| preparador-caso-de-producto | Subagente | Entreno para casos de producto: conviertes necesidades vagas en requisitos e historias usuario. | pídele a Claude «usa el subagente preparador-caso-de-producto» |
| revisor-cv-web | Subagente | Subagente que audita una página de currículum o portfolio ya hecha, por URL o código, y devuelve una lista de mejoras priorizada por impacto, sin esperar a que otra persona dé su opinión. | pídele a Claude «usa el subagente revisor-cv-web» |
| revisor-portfolio-cv | Subagente | Revisa una web de currículum o portfolio ya publicada y devuelve mejoras concretas, ordenadas por impacto. | pídele a Claude «usa el subagente revisor-portfolio-cv» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
