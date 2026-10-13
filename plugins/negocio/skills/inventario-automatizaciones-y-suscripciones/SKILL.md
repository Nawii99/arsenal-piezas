---
name: inventario-automatizaciones-y-suscripciones
description: Hace un inventario de solo lectura de lo que tienes activo en tu carpeta de Claude Code (skills, comandos, subagentes, hooks y conectores MCP, explicados en llano) y de los pagos recurrentes de tu negocio, para saber qué sigue en marcha, qué cuesta y qué ya no usas. No abre archivos con claves. No cancela ni borra nada.
---

# Inventario de automatizaciones y suscripciones

## Qué hace
Dos listas, siempre de solo lectura.
- Parte A: lo que tienes montado en Claude Code. Skills, comandos «/», subagentes, hooks, conectores MCP y permisos.
- Parte B: lo que pagas cada mes o cada año. Herramientas, dominios, licencias, servidores... a partir de un extracto que le pases.
- Al final las cruza: qué pagas y no aparece en uso, y qué usas sin saber que cuesta.

## Palabras que vas a ver, en llano
- Skill: archivo con instrucciones que Claude sigue cuando le pides cierta tarea.
- Comando «/»: atajo que escribes tú, como /mcp, para lanzar unas instrucciones guardadas.
- Subagente: ayudante con instrucciones propias, al que Claude le reparte una tarea.
- Hook: acción que se dispara sola cuando pasa algo, por ejemplo al terminar Claude una respuesta.
- Conector MCP: enlace de Claude con un servicio externo, como tu correo o tu tienda online.
- Permiso: lo que Claude puede hacer sin preguntarte antes.
- Usa estas mismas explicaciones en la tabla A. La persona tiene que entender cada fila sin saber programar.

## Pregunta antes de empezar
1. ¿Quieres la parte A, la B o las dos?
2. Para la A: ¿revisamos solo esta carpeta o también tu carpeta personal de Claude Code? De las piezas solo se leen el nombre y la descripción. De los archivos de ajustes y de conectores solo se sacan nombres, nunca su contenido.
3. Para la A: ¿puede haber claves, tokens o contraseñas en los archivos de ajustes o de conectores? Si la persona dice que sí o no lo sabe, no abras esos archivos y pide que pegue ella solo los nombres.
4. Para la B: ¿tienes un extracto del banco o de la tarjeta en CSV o Excel, o una lista hecha a mano? Pide que quite IBAN, nombre y todo lo que no haga falta. Basta con fecha, concepto e importe. Mejor [12 MESES] para ver los pagos anuales.
5. ¿Eres autónomo o sociedad? ¿Qué parte de los gastos es del negocio y cuál es personal?
6. ¿Tienes automatizaciones fuera de Claude Code (n8n, Make, Zapier, tareas programadas del ordenador)? No entres en esos servicios. La persona tiene que pegar una lista o una exportación.

## Paso a paso: parte A
1. Busca las piezas del proyecto, leyendo solo las líneas name y description de su encabezado: .claude/skills/*/SKILL.md, .claude/commands/*.md y .claude/agents/*.md. Lee CLAUDE.md solo para ver qué piezas menciona.
2. Si la persona quiere revisar también su carpeta personal, haz lo mismo con ~/.claude/skills/*/SKILL.md, ~/.claude/commands/*.md y ~/.claude/agents/*.md. Nunca abras ~/.claude/settings.json ni ~/.claude.json: ahí pueden estar las claves.
3. Con .claude/settings.json, .claude/settings.local.json y .mcp.json, no los abras enteros. Saca solo los nombres con un comando que imprima únicamente claves, por ejemplo jq '.mcpServers | keys' .mcp.json para los conectores y jq '.hooks | keys' .claude/settings.json para los hooks. Nunca imprimas env, headers, args ni direcciones. Si jq no está instalado o la persona prefiere no ejecutarlo, pide que pegue ella los nombres.
4. Los permisos pueden llevar comandos con claves dentro. Pide a la persona que pegue la lista de permisos tras quitar cualquier clave, o que diga si hay alguno muy amplio.
5. Para los conectores de tu usuario, pide que escriba /mcp en Claude Code y pegue la lista.
6. Pide también que pegue la lista de plugins instalados (con /plugin), porque añaden piezas y hooks, y la de tareas programadas: las de Claude Code, si usa alguna, y las del ordenador (Programador de tareas en Windows, crontab en Mac y Linux). No puedes verlas por tu cuenta.
7. De cada pieza apunta: tipo con su explicación llana, nombre, para qué dice servir, fecha de última modificación si la ves, y si se ejecuta sola (hooks, tareas programadas) o solo cuando la llamas.
8. De cada conector apunta el nombre y el servicio. Nunca copies claves, tokens, contraseñas ni direcciones con claves. Si alguna aparece en lo que te pegan, no la repitas: escribe «[oculto]» y avisa de que conviene cambiarla en el servicio, porque ya ha pasado por la IA.
9. Marca como «vigilar» lo que se ejecuta solo. Trabaja sin que nadie mire.
10. Marca posibles problemas: piezas duplicadas, sin descripción clara, que mencionan servicios que ya no usas, o con permisos muy amplios (por ejemplo, que dejan ejecutar cualquier comando sin preguntar).

## Paso a paso: parte B
1. Lee el extracto y detecta cobros repetidos: mismo comercio e importe parecido cada mes, trimestre o año.
2. Para cada uno apunta: servicio (si el concepto no lo aclara, «no reconocido» y pregunta), importe, frecuencia, coste al mes y al año, último cobro y próximo cobro estimado.
3. Pregunta a la persona por cada uno si lo usa, para qué y cuándo fue la última vez. No decidas por ella.
4. Clasifica en Seguir, Revisar o Candidato a cancelar, con el motivo en una frase. Solo es candidato si la persona confirma que no lo usa o que está duplicado.
5. Suma el total mensual y anual, por categoría y en candidatos.
6. Lista las renovaciones anuales de los próximos [90 DÍAS], con la fecha en que conviene avisar.

## Cruce
- Servicios de pago que no aparecen en ninguna pieza ni conector: pregunta si se usan fuera de Claude Code.
- Conectores o piezas que usan un servicio que no sale en el extracto: puede ser gratuito o pagarlo otra persona. Pregunta.

## Qué devolver y con qué formato
- Tabla A: Tipo (con su explicación llana) | Nombre | Qué hace | ¿Se activa sola? | Observaciones.
- Tabla B: Servicio | Importe | Frecuencia | Coste anual | Próximo cobro | Uso (lo dice la persona) | Propuesta.
- Resumen de cinco líneas: piezas totales, piezas automáticas, gasto anual total y cuánto está en Revisar o Candidato.
- Tres pasos siguientes ordenados por fecha, empezando por el cobro más cercano.
- Solo si se pide, un archivo nuevo inventario.csv. No se sobrescribe nada.

## Qué revisa una persona antes de actuar
- Los importes salen del extracto. Un concepto bancario ambiguo puede ser otra cosa. Compruébalo en la factura o en la cuenta del servicio.
- Cancelar lo decide la persona y lo hace en la web del proveedor. Antes, mira permanencia, preaviso, renovación automática y reembolsos.
- Antes de cancelar algo que guarde facturas, datos de clientes o historial, descarga una copia. Conserva las facturas el tiempo que te indique tu gestoría.
- Qué gastos son deducibles y cómo va el IVA lo confirma tu gestoría. No lo decide la IA.
- Los datos bancarios son delicados. Usa las mínimas columnas y borra tú el extracto de la carpeta cuando termines, si no lo necesitas.
- Si una clave llegó a pegarse en el chat, cámbiala en el servicio de origen.

## Qué NO hacer
- No borres, desactives, edites ni muevas ninguna skill, comando, subagente, hook o ajuste. Solo lees.
- No abras enteros los archivos de ajustes ni de conectores, ni los de tu carpeta personal. Solo nombres.
- No canceles, pares ni modifiques suscripciones. No entres en cuentas de pago ni uses conectores para tocar nada.
- No muestres claves, tokens ni números completos de tarjeta o de cuenta.
- No supongas que algo «no se usa» solo porque no aparece en los archivos. Puede usarse fuera. Pregunta.
- No prometas cifras de ahorro antes de ver el extracto. El ahorro real es lo que la persona confirme que cancela.
- No ejecutes ninguna pieza para «probarla».
