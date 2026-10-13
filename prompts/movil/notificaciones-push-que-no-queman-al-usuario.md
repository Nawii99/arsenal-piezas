# Notificaciones push que no queman al usuario…

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Cuándo, a quién y qué avisos enviar sin que la gente desactive las notificaciones.

## Qué es y qué hace

Prompt que actúa como responsable de retención respetuoso con el usuario y con la normativa europea. Recibe frecuencia de uso, datos disponibles y herramienta de envío; devuelve los avisos separados en transaccionales, de utilidad y de marketing, con cuándo, a quién y qué texto enviar. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu app y tus datos
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Configura los envíos en tu herramienta y mide la tasa de bajas

## Cuándo usarla

Úsalo cuando vayas a activar notificaciones en tu app o cuando notes que envías avisos y la gente los ignora, los apaga o se va.

## Cómo ganar dinero con ella

Los avisos bien puestos traen de vuelta a gente que ya tienes, que es la forma más barata de vender otra vez; los mal puestos te cuestan usuarios.

- Estrategia de notificaciones push para apps de negocios locales…
- Reglas de frecuencia y segmentación de avisos para apps…
- Textos de reactivación y retención para apps con poco uso…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como responsable de retención de una app pequeña, con criterio de respeto al usuario y conocimiento de la normativa europea.
Me hablas a mí, que no soy técnico. Cada recomendación va con su porqué en una frase.
CONTEXTO
App: [NOMBRE Y QUÉ HACE]
Qué gana el usuario usándola a menudo: [BENEFICIO]
Cada cuánto tiene sentido que la abra: [VARIAS VECES AL DÍA / DIARIA / SEMANAL / PUNTUAL]
Datos que tengo de cada usuario: [EJEMPLO: FECHA DE ALTA, ÚLTIMA VEZ QUE ENTRÓ, SI HA COMPLETADO EL PRIMER PASO, PLAN]
Zona horaria y país: [PAÍS]
Herramienta de envío: [FIREBASE / ONESIGNAL / OTRA / NO LO SÉ]
Momentos en los que hoy envío avisos: [LISTA O 'NINGUNO']
TU TRABAJO, PASO A PASO
1. Separa los avisos en tres familias y explícame la diferencia: transaccionales (algo ha pasado y le afecta), de utilidad (le recuerdan algo que él pidió) y de marketing (yo quiero que vuelva). Dime cuáles necesitan consentimiento explícito y cuáles no.
2. Diseña el momento de pedir el permiso: pantalla propia antes del aviso del sistema, explicando qué avisos va a recibir y con qué frecuencia, y opción de decir 'ahora no' sin castigo. Escribe ese texto.
3. Propón un máximo de 6 avisos automáticos ligados a comportamiento, no al calendario. Para cada uno: nombre interno, condición exacta que lo dispara (con horas o días), momento del envío, y a quién NO se le manda.
4. Escribe cada aviso con título de máximo 40 caracteres y cuerpo de máximo 120, con el dato personal entre llaves como {nombre} o {ciudad}. Añade a dónde lleva al tocarlo (pantalla concreta, no la portada).
5. Define las reglas de silencio: horas en las que nunca se envía, tope de avisos por usuario y semana, pausa tras varios ignorados seguidos, y corte automático si el usuario no abre ninguno en X semanas.
6. Escribe el centro de preferencias: lista de tipos de aviso que el usuario puede activar o desactivar por separado, con su nombre en lenguaje claro.
7. Añade 3 avisos que NO hay que enviar nunca aunque den resultado a corto plazo, y por qué.
8. Explícame cómo saber si van bien: qué mirar (cuántos abren, cuántos hacen luego la acción, cuántos desactivan los avisos) y qué señal significa 'para y cambia'.
REGLAS
Nada de falsas alertas, falsos mensajes de otra persona, ni emojis de alarma para simular urgencia.
Ningún aviso puede ser publicidad disfrazada de aviso del sistema.
Español de España, tuteo, tono útil y directo.
Si un aviso solo sirve para mi negocio y no para el usuario, márcalo y propón una alternativa que sirva a los dos.
FORMATO DE RESPUESTA
1) Tabla de avisos: nombre, familia, condición de disparo, hora, destino al tocar, exclusiones.
2) Textos exactos de los 6 avisos, con variante corta y variante larga.
3) Texto de la pantalla de permiso.
4) Reglas de frecuencia y silencio en lista.
5) Centro de preferencias.
6) Lista negra de avisos.
7) Panel de control semanal: 4 números y su umbral de alarma.
CRITERIOS DE CALIDAD
Cada aviso se justifica desde lo que gana el usuario, no desde lo que gano yo.
Ningún usuario recibe más avisos de los que aceptó.
Los textos se leen enteros en la pantalla bloqueada de un móvil, sin cortarse a mitad de la idea.
```
