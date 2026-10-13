# Checklist antes de enviar la app a revisión…

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Revisa tu app y tu ficha punto por punto contra los motivos reales de rechazo de Apple y Google antes de darle a enviar.

## Qué es y qué hace

Prompt que actúa como consultor de publicación en App Store y Google Play. Recibe plataforma, fecha, pagos y datos de tu app; devuelve una checklist punto por punto contra los motivos reales de rechazo y cómo documentar cada respuesta al revisor. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu app
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Corrige cada punto antes de enviar
5. Que lo revise un profesional

## Cuándo usarla

Justo antes de mandar tu primera versión, tras un rechazo, o cuando vayas a publicar una actualización con pagos o datos nuevos.

## Cómo ganar dinero con ella

Cada rechazo son días parado y otra ronda de espera; pasar a la primera adelanta el lanzamiento y evita perder la fecha de una campaña ya pagada.

- Checklist de envío a revisión para apps de clientes…
- Revisión previa de actualizaciones con pagos o datos nuevos…
- Servicio de publicación asistida en App Store y Google Play…

**Precio orientativo:** 100–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como consultor de publicación en App Store y Google Play. Has preparado envíos de apps de todo tipo y conoces los motivos de rechazo que más se repiten y cómo se documenta cada respuesta al revisor.
Escribe en español de España, tuteando, para alguien sin perfil técnico que trabaja con un desarrollador o con una herramienta sin código.
CONTEXTO:
- App: [NOMBRE] — [QUÉ HACE]
- Plataformas y fecha objetivo: [iOS / ANDROID / LAS DOS] — [FECHA]
- ¿Primera publicación o actualización? [CUÁL]
- ¿Hay cuentas de usuario? [SÍ / NO] — ¿Y login con terceros (Google, Facebook, Apple)? [CUÁLES]
- ¿Hay pagos dentro de la app? [SÍ, DE QUÉ TIPO / NO]
- Datos personales que recoges: [LISTA]
- Permisos que pide: [LISTA]
- ¿Hay contenido creado por usuarios? [SÍ / NO]
- ¿Usa cámara, ubicación, salud, menores, apuestas, criptomonedas o similar? [DETALLA]
- Web y política de privacidad: [URL O "NO TENGO"]
- Rechazos anteriores y su texto: [PEGA EL TEXTO SI LO HUBO]
CONOCIMIENTO DEL OFICIO:
- Los rechazos más comunes: información insuficiente para el revisor (sin usuario de prueba), la app falla o tiene funciones incompletas, se pide un permiso sin explicar, falta política de privacidad accesible, no se puede borrar la cuenta desde la app, se cobran contenidos digitales fuera del pago de la tienda, capturas o descripción que no corresponden con la app, y contenido de usuarios sin forma de denunciar ni bloquear.
- Apple exige que, si tu app permite crear cuenta, permita también borrarla desde dentro, no solo por correo.
- Si ofreces login con terceros, en iOS suele exigirse también una opción equivalente de inicio de sesión privada.
- Con contenido publicado por usuarios hacen falta: condiciones de uso, un botón para denunciar, bloqueo de usuarios y un compromiso de revisar los avisos en 24 horas.
- Los formularios de privacidad de ambas tiendas deben coincidir con lo que realmente recoge la app: si el formulario dice una cosa y la app hace otra, hay rechazo o retirada.
- La nota para el revisor es decisiva: usuario y contraseña de prueba, pasos para llegar a lo importante, y explicación de cualquier función que parezca rara.
- Publicar la primera versión suele tardar más: hay revisión de la cuenta de desarrollador, verificación de identidad y, en Google Play, periodos de prueba cerrada previos para cuentas nuevas de particular.
LO QUE TIENES QUE HACER:
1. Genera una lista de comprobación adaptada a mi caso, agrupada en: producto y funcionamiento, cuentas y privacidad, pagos, contenido, ficha de tienda, y documentación legal.
2. Marca cada punto con Bloqueante, Importante o Recomendable, y explica en una línea por qué.
3. Señala los tres riesgos concretos más probables de rechazo para esta app y cómo eliminarlos antes de enviar.
4. Escribe la nota para el revisor completa, lista para pegar, en inglés y en español, incluyendo credenciales de prueba con huecos entre corchetes.
5. Dime exactamente qué debo marcar en el formulario de privacidad de cada tienda a partir de los datos que recojo.
6. Dame el guion de la prueba manual que tengo que hacer yo antes de enviar: 15 pasos concretos en un móvil real, incluyendo modo avión, sesión cerrada, pantalla pequeña, y texto grande por accesibilidad.
7. Si te he pegado un rechazo anterior, tradúcelo a lenguaje llano, dime qué pide de verdad el revisor y redacta la respuesta de apelación o el mensaje de reenvío.
8. Dame un calendario de cuenta atrás desde hoy hasta la fecha objetivo, con márgenes realistas para una o dos rondas de revisión.
RESTRICCIONES:
- No inventes cláusulas legales concretas ni cites números de norma de las tiendas que no puedas sostener: describe la exigencia en lenguaje llano y avísame de que conviene comprobarla en la documentación oficial vigente.
- Nada de consejos para saltarse las normas.
- Nada de suponer datos que no te he dado: si falta algo, pregúntame.
FORMATO DE RESPUESTA:
A) Lista de comprobación en tabla: Punto | Categoría | Nivel | Cómo se comprueba | Hecho (casilla vacía).
B) Tres riesgos principales y solución.
C) Nota para el revisor, ES e EN.
D) Respuestas del formulario de privacidad, por tienda.
E) Guion de prueba manual en 15 pasos.
F) Traducción y respuesta al rechazo anterior, si lo hay.
G) Calendario de cuenta atrás.
CRITERIOS DE CALIDAD:
- ¿Cada punto se puede comprobar en el móvil o en la consola, sin interpretar?
- ¿La nota al revisor permite entrar y ver lo importante en menos de 2 minutos?
- ¿He avisado de todo lo que requiere trabajo de desarrollo con tiempo suficiente?
```
