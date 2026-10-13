---
name: rutinas-con-supervision
description: Diseña rutinas automáticas para un negocio con control: inventario de tareas repetidas, niveles de riesgo, fichas con límites, informe semanal de salud y lista de avisos de seguridad. Se activa con «automatiza mis tareas», «que esto corra solo» o «rutinas del negocio».
---

# Rutinas del negocio con supervisión

## Qué hace
Te ayuda a decidir qué tareas repetidas se pueden dejar a una máquina, cuáles necesitan que una persona apruebe y cuáles no se automatizan. Deja cada rutina escrita en una ficha con sus límites.
Aviso importante: Claude Code puede ofrecer tareas programadas, pero sus límites y su disponibilidad cambian. Compruébalo en la documentación oficial y en tu plan.
Para algo importante o desatendido, lo habitual es un programador externo: n8n (un programa para encadenar tareas entre aplicaciones, con un nodo que las lanza a una hora fija), el programador de tareas de tu ordenador o GitHub Actions.
Esta skill diseña y documenta la rutina y su vigilancia. Montarla en n8n u otra herramienta es otro paso, y se prueba antes en modo «solo informa».

## Palabras que se usan
- API: el servicio de pago por uso que conecta la IA con tus herramientas.
- Con clientes y datos reales: cuando la rutina ya toca información de verdad, no pruebas.
- Bucle: la rutina repite una tarea sin parar porque algo falla.
- Credenciales de n8n: el apartado donde se guardan las claves sin que se vean.
- Inyección de instrucciones: un texto malicioso escondido en un correo, una web o un mensaje que da órdenes a la IA sin que lo sepas.

## Antes de empezar, pregunta
1. Qué tareas repites cada día o cada semana, cuánto tiempo te llevan y quién las hace.
2. Qué pasa si una sale mal: nada, un susto, dinero perdido, un cliente enfadado o un problema legal.
3. Qué herramientas usas (n8n, Gmail, Google Sheets, Shopify, redes sociales) y qué accesos hay.
4. Cuánto estás dispuesto a gastar al mes en APIs y herramientas: [IMPORTE EN EUROS].
5. Quién vigilará las rutinas y con qué frecuencia, y a quién se avisa si algo falla.
6. Si alguna rutina leerá correos, webs o mensajes de otras personas.

## Paso a paso
1. Haz el inventario en una tabla: tarea, frecuencia, minutos que lleva, quién la hace, riesgo si falla.
2. Clasifica cada tarea en un nivel de riesgo. Nivel 1, solo informa: solo lee y avisa (resumen de métricas, informe semanal). Nivel 2, borrador con aprobación: prepara un borrador (email, post, factura) que una persona aprueba antes de que salga. Nivel 3, solo manual: gasta dinero, escribe a terceros sin revisión, publica, borra, cobra, cambia precios o toca datos de clientes.
3. El Nivel 3 no se automatiza: lo hace una persona cada vez.
4. Elige 2 o 3 para empezar: las que más tiempo quitan y menos riesgo tienen.
5. Haz una ficha por rutina: nombre, cuándo corre, qué lee, qué hace, qué produce y dónde lo deja, quién aprueba, límite de gasto, qué hace si falla (avisar y parar, nunca reintentar en bucle), cómo se para y dónde queda el registro.
6. Define el semáforo de salud semanal por rutina con cinco preguntas: ¿corrió cuando tocaba?, ¿terminó sin error?, ¿la salida tiene sentido en una muestra?, ¿gastó dentro del límite?, ¿alguien tuvo que arreglar algo a mano? Los colores se usan solo aquí. Todo sí es verde. Un no es amarillo. Dos noes o gasto fuera de límite es rojo y se para.
7. Revisa la lista de seguridad: claves con los permisos mínimos y guardadas en las credenciales de n8n, límite mensual de gasto puesto en la cuenta de la API, registro de lo que se hizo, interruptor de parada probado y una cuenta o hoja de pruebas.
8. Añade a esa lista: una rutina que lee contenido de terceros (correos, webs, mensajes) no tiene permiso para enviar, borrar, pagar ni publicar.
9. La persona (o quien lleve la tecnología) activa cada rutina en n8n en modo «solo informa» durante 1 o 2 semanas y compara la salida con lo que habría hecho una persona. Claude no puede ejecutarla ni agendarla por su cuenta.
10. Solo si la salida coincide, la persona decide pasar una rutina de Nivel 2 de «solo informa» a borrador con aprobación.
11. La persona pone en su calendario una revisión semanal de 10 minutos con el informe de salud. Claude prepara la plantilla del informe, pero no la agenda.

## Qué devolver, con este formato
- Tabla de inventario con el nivel de riesgo de cada tarea.
- Una ficha por cada rutina elegida.
- Plantilla del informe semanal de salud, con las cinco preguntas.
- Lista de avisos de seguridad pendientes de resolver.
- Cómo medir el ahorro de tiempo: minutos antes y después, apuntados por la persona. No lo des por hecho.

## Qué NO hacer
- No dejes correr sin supervisión nada que gaste dinero, escriba a terceros, publique, borre o use datos personales de clientes.
- No des permiso de enviar, borrar, pagar ni publicar a una rutina que lee contenido de terceros: un texto malicioso podría darle órdenes a la IA.
- No prometas funcionamiento 24/7 ni «ahorra X horas». Se mide, no se promete.
- No automatices LinkedIn, Instagram ni WhatsApp con herramientas no oficiales: sus condiciones lo prohíben y te pueden limitar o cerrar la cuenta.
- No guardes claves ni contraseñas en archivos, en el chat ni en hojas de cálculo.
- No permitas reintentos sin límite: un bucle puede gastar mucho dinero en la API en pocas horas.
- No toques ni borres datos del negocio de la persona. Si algo hay que quitar, se pasa a una carpeta o estado de archivo.
- No montes nada con clientes y datos reales sin prueba previa.

## Qué revisa una persona antes de usar el resultado
- El dueño: aprueba cada ficha, mira el informe semanal y decide cuándo una rutina pasa de Nivel 1 a Nivel 2.
- Un gestor o responsable de protección de datos: si la rutina toca datos personales de clientes, facturas o impuestos.
- Un abogado: si las rutinas acceden a datos de clientes de otra empresa, para el contrato de encargado de tratamiento (RGPD, art. 28).
- Quien lleva la tecnología: que el interruptor de parada funciona de verdad antes de dejar correr nada.

## Instalación (para ti, no para Claude)
Guarda este archivo como SKILL.md dentro de la carpeta .claude/skills/rutinas-con-supervision/ de tu proyecto.
