# Plan de notificaciones que no queman…

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Monta el calendario y los textos de las notificaciones push de tu app: cuáles enviar, cuándo y cuáles no enviar nunca.

## Qué es y qué hace

Prompt que actúa como especialista en ciclo de vida de apps y diseña tu plan de notificaciones push. Recibe los datos de tu app, la acción que quieres repetir y los canales disponibles; devuelve tipos de aviso, textos, momentos y límites. Sirve en cualquier chat de IA, por ejemplo para una app de reservas con avisos semanales.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con los datos de tu app
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Revisa el calendario antes de activarlo

## Cuándo usarla

Úsalo cuando vayas a activar las notificaciones de tu app, o cuando mucha gente las esté desactivando o directamente desinstalando por exceso de avisos.

## Cómo ganar dinero con ella

Un buen plan de avisos devuelve usuarios a la app sin pagar publicidad; uno malo hace que desinstalen y pierdas al cliente para siempre.

- Plan de notificaciones y textos push para apps de pequeños negocios locales…
- Auditoría de avisos de una app con mucha desinstalación y propuesta de recorte…
- Pack de mensajes de reactivación para apps de suscripción o reservas…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como especialista en ciclo de vida del usuario en apps móviles, experto en notificaciones push y en no quemar la base de usuarios.
Objetivo: darme un plan completo de notificaciones con sus textos, sus momentos y sus límites.
CONTEXTO:
- App: [NOMBRE] y qué hace: [DESCRIPCIÓN]
- Acción que quiero que el usuario repita: [ACCIÓN]
- Frecuencia natural de uso: [DIARIA / SEMANAL / MENSUAL / PUNTUAL]
- Público y horario en el que está disponible: [PERFIL Y HORARIOS]
- Datos que tengo de cada usuario para personalizar: [NOMBRE, ÚLTIMA VEZ QUE ENTRÓ, LO QUE HIZO, ETC.]
- Canales alternativos que tengo: [EMAIL / WHATSAPP / SMS / NINGUNO]
PASOS:
1. Clasifica las notificaciones en cuatro tipos y dime cuáles aplican a mi caso: transaccionales (algo que le ha pasado a él), de recordatorio útil, de reactivación, y promocionales.
2. Diseña el momento y el texto para pedir el permiso de notificaciones: nunca al abrir, siempre después de que el usuario haya recibido valor y con una pantalla propia que explique qué avisos va a recibir y con qué frecuencia. Escribe ese texto.
3. Monta el calendario de los primeros 30 días de un usuario nuevo: día, disparador, tipo, objetivo, canal recomendado y qué pasa si no reacciona.
4. Escribe cada notificación con título de menos de 40 caracteres y cuerpo de menos de 120, en español de España, personalizada con los datos disponibles, y con la pantalla exacta a la que debe llevar al tocarla (no vale abrir la portada).
5. Añade una serie de reactivación para quien lleva 7, 21 y 45 días sin entrar, con un motivo distinto en cada una, y define cuándo dejar de insistir para siempre.
6. Define las reglas de higiene: máximo de avisos por semana, franja horaria permitida, nunca de madrugada, no repetir mensaje, agrupar avisos, respetar el silencio si el usuario ya está dentro de la app, y qué avisos deben poder desactivarse por separado en ajustes.
7. Escribe la pantalla de ajustes de notificaciones: qué interruptores hay y cómo se llaman.
8. Define cómo mido si funcionan: porcentaje de permiso concedido, apertura por tipo de aviso, desactivaciones y desinstalaciones tras cada campaña. Dame el umbral a partir del cual hay que parar una serie.
RESTRICCIONES:
- Nada de mensajes engañosos disfrazados de mensaje personal o de alerta del sistema.
- Nada de avisos promocionales sin consentimiento claro ni sin manera fácil de desactivarlos.
- Máximo un aviso promocional por semana salvo que yo indique lo contrario.
- Ningún texto puede sonar a robot ni empezar por '¡No te pierdas...!'.
FORMATO DE SALIDA:
1) TIPOS DE AVISO QUE APLICAN A MI APP
2) PETICIÓN DE PERMISO: MOMENTO Y TEXTO
3) CALENDARIO DE 30 DÍAS (tabla: día o disparador, tipo, objetivo, canal, destino al tocar)
4) TEXTOS COMPLETOS (título y cuerpo, con recuento de caracteres)
5) SERIE DE REACTIVACIÓN Y CUÁNDO PARAR
6) REGLAS DE HIGIENE
7) PANTALLA DE AJUSTES
8) MÉTRICAS Y UMBRALES DE ALARMA
CRITERIOS DE CALIDAD:
- Cada notificación se justifica desde lo que gana el usuario, no desde lo que gano yo.
- Ninguna serie deja al usuario recibiendo avisos eternamente sin haber reaccionado.
- Todos los avisos llevan a una pantalla concreta y coherente con el texto.
- Un usuario podría explicar, leyendo la pantalla de ajustes, qué va a dejar de recibir.
```
