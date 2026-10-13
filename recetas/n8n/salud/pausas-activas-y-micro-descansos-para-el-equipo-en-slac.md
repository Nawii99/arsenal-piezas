# Pausas activas y micro-descansos para el equipo en Slac…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Lanza a horas variables un mensaje corto al canal del equipo con un ejercicio de 60 segundos y lleva la cuenta de quién participa.

## Qué es y qué hace

Publica tres veces al día en un canal de Slack una pausa de 60 segundos tomada de una hoja de ejercicios y registra las reacciones de cada pausa. Entrada: hoja Pausas y eventos de Slack; salida: mensaje en el canal y registro de participación. Se monta en n8n con el nodo Slack y sirve para equipos de oficina o remotos.

## Cómo usarla

1. Crea la app de Slack y añade los permisos necesarios
2. Carga el banco de ejercicios en la hoja Pausas
3. Programa las tres horas variables en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando tienes un equipo de oficina o remoto que pasa ocho horas sentado y quieres un programa de bienestar real, sin contratar una plataforma corporativa de 8 euros por empleado al mes.

## Cómo ganar dinero con ella

Sustituye plataformas de bienestar laboral que cuestan de 5 a 10 euros por empleado y mes. Con 15 personas son entre 900 y 1.800 euros al año.

- Programa de pausas activas para una agencia de diez a veinte personas con informe mensual.
- Configuración de micro-descansos en Slack para equipos remotos.
- Banco de ejercicios propio para empresas que quieren bienestar laboral sin plataforma.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Tres veces al día, a horas que varían para que no se vuelva rutina ignorada, publica en un canal de Slack una pausa activa de 60 segundos sacada de tu propio banco de ejercicios y registra las reacciones.
Para empresas pequeñas, agencias y equipos remotos. Son movimientos suaves generales, sin adaptación individual ni prescripción.

## Lo que necesitas antes
- n8n instalado.
- Slack: entra en api.slack.com/apps, «Create New App» desde cero, en «OAuth & Permissions» añade los scopes chat:write, reactions:read y channels:history, instala la app en tu espacio y copia el Bot User OAuth Token. Invita al bot al canal con /invite @tu-bot.
- Hoja «Pausas» en Sheets: Id, Titulo, Instrucciones, Duracion, Categoria (cuello, espalda, vista, respiracion, piernas).
- Hoja «Participacion»: Fecha, Id pausa, Reacciones, Usuarios.

## Los nodos, en orden
1. **Schedule Trigger**: Cron 0 10,13,17 * * 1-5 (tres veces al día, de lunes a viernes).
2. **Code** (nombre: «Ventana aleatoria»): decide si esta ejecución se pospone entre 0 y 45 minutos, para que no caiga siempre a la hora en punto. Código abajo.
3. **Wait**: «After Time Interval», con el valor en minutos tomado de la expresión {{$json.esperaMin}}.
4. **Google Sheets** (Get Rows) sobre «Pausas».
5. **Google Sheets** (Get Rows) sobre «Participacion»: para saber cuáles se han usado últimamente.
6. **Code** (nombre: «Elegir pausa»): escoge una que no se haya publicado en los últimos 10 días y que sea de categoría distinta a la anterior.
7. **Slack** (Send Message): al canal #bienestar, con el título en negrita, las instrucciones y una línea final tipo «reacciona con la mano si la has hecho».
8. **Google Sheets** (Append Row) en «Participacion» con la fecha, el id de la pausa y el timestamp del mensaje de Slack.
9. Flujo aparte, **Schedule Trigger** Cron 0 18 * * 5 (viernes a las 18:00): **Slack** (resource Message, operation Get Many) para leer las reacciones de la semana, un **Code** que cuenta y un **Slack** que publica el ranking amable de participación.

## El código del nodo Code
```javascript
const espera = Math.floor(Math.random() * 46);
return [{ json: { esperaMin: espera } }];
```

## Código del segundo Code (elegir pausa)
```javascript
const pausas = $('Google Sheets').all().map(i => i.json);
const historial = $('Google Sheets1').all().map(i => i.json);
const hace10 = new Date(Date.now() - 10 * 86400000);
const recientes = new Set(historial.filter(h => new Date(h.Fecha) > hace10).map(h => String(h['Id pausa'])));
const ultimaCat = historial.length ? (pausas.find(p => String(p.Id) === String(historial[historial.length - 1]['Id pausa'])) || {}).Categoria : null;
let candidatas = pausas.filter(p => !recientes.has(String(p.Id)) && p.Categoria !== ultimaCat);
if (candidatas.length === 0) candidatas = pausas;
const elegida = candidatas[Math.floor(Math.random() * candidatas.length)];
return [{ json: elegida }];
```

## Cómo probarla
- Mete 12 pausas en la hoja, con al menos tres categorías distintas.
- Ejecuta el flujo cinco veces seguidas y comprueba que no repite pausa ni categoría consecutiva.
- Publica primero en un canal privado de pruebas antes de soltarlo en el canal general.

## Qué puede salir mal
- **Cansancio del equipo**: tres veces al día es el máximo. Si ves que nadie reacciona, baja a una y pregunta al equipo qué prefieren.
- **Nada obligatorio**: deja claro en el primer mensaje que es voluntario y que nadie mira quién participa. Si publicas rankings, que sean del grupo, no de personas señaladas.
- **Ejercicios genéricos**: escribe las instrucciones de forma suave y añade siempre «si algo te molesta, párate». No adaptes ejercicios a dolencias concretas de nadie.
- **El bot no puede escribir**: si Slack devuelve not_in_channel, has olvidado invitar al bot al canal.
- **El Wait consume una ejecución** en n8n cloud; en auto-alojado da igual.

## Cuánto cuesta
- Slack: plan gratuito válido, aunque solo guarda 90 días de historial.
- Google Sheets: gratis. n8n auto-alojado: 0 euros.
