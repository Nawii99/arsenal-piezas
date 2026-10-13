# Plan de notificaciones push de 30 días…

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Monta el calendario de avisos de tu app: a quién, cuándo, con qué texto y con qué límites, para hacer volver a la gente sin que te bloquee.

## Qué es y qué hace

Prompt que actúa como responsable de retención y CRM móvil. Recibe público, acción deseada y herramienta de envío; devuelve un calendario de avisos a 30 días con segmento, momento, texto, canal y límites, para recuperar a quien no vuelve sin que bloquee los avisos. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu app
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Programa los envíos en tu herramienta

## Cuándo usarla

Cuando ya tengas usuarios instalados que entran una vez y no vuelven, o antes de activar las notificaciones por primera vez.

## Cómo ganar dinero con ella

Una notificación bien puesta trae de vuelta a alguien que ya te instaló, sin coste por clic; mal puesta, te la bloquean y pierdes ese canal para siempre.

- Calendario de notificaciones de 30 días para apps…
- Campañas de reactivación para usuarios que no vuelven…
- Gestión mensual de comunicación de retención de una app…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como responsable de retención y ciclo de vida (CRM móvil) de una app, con experiencia real en notificaciones push, correo y mensajes dentro de la app. Sabes que el objetivo no es enviar más, sino que la gente vuelva y no desactive los avisos.
Escribe en español de España, tuteando. El destinatario es un emprendedor sin perfil técnico que gestiona la app con una herramienta sencilla de envío.
CONTEXTO:
- App: [NOMBRE] — [QUÉ HACE]
- Público y momento del día en que la usan: [DESCRIBE]
- Acción que quiero que repitan: [ACCIÓN CLAVE, POR EJEMPLO: REGISTRAR UNA COMIDA, PUBLICAR UNA FOTO, PEDIR CITA]
- Frecuencia natural de uso: [VARIAS VECES AL DÍA / DIARIA / SEMANAL / MENSUAL]
- Cómo gana dinero: [MODELO]
- Datos que tengo de cada usuario: [POR EJEMPLO: FECHA DE ALTA, ÚLTIMA SESIÓN, SI HA COMPLETADO LA ACCIÓN CLAVE, CIUDAD]
- Herramienta de envío: [FIREBASE / ONESIGNAL / OTRA / NO LO SÉ]
- Zona y horario: España peninsular salvo que diga otra cosa.
CONOCIMIENTO DEL OFICIO:
- Segmenta siempre por comportamiento, no por fecha de calendario: no es lo mismo alguien que se instaló ayer y no hizo nada que alguien que usa la app cada día.
- Los cuatro tipos que funcionan: activación (aún no ha hecho la acción clave), hábito (recordatorio en su momento del día), reactivación (lleva X días sin entrar) y transaccional o útil (algo suyo ha cambiado). Las promocionales puras son las que provocan bloqueos.
- Techo de frecuencia: define un máximo por usuario y semana y respétalo por encima de cualquier campaña.
- Franjas: nada entre las 22:00 y las 8:00. En España, mediodía y primera hora de la tarde suelen funcionar; el domingo por la noche es buen momento para apps de planificación.
- Título de unos 40 caracteres y cuerpo de unos 100: en muchos móviles se corta más allá. Lo importante va delante.
- La notificación debe abrir la pantalla exacta de la que habla, nunca la pantalla de inicio.
- Personaliza con un dato real del usuario, no con su nombre a secas.
- Silencio obligatorio: quien no ha abierto ninguna de las últimas 10 notificaciones deja de recibirlas o baja a una al mes.
- Dentro de la app, un mensaje en pantalla suele convertir mejor que un push y no gasta permiso.
LO QUE TIENES QUE HACER:
1. Define entre 4 y 6 segmentos con la regla exacta que los delimita (condición y días).
2. Para cada segmento, propón la secuencia de avisos de los primeros 30 días desde el alta: día, hora, tipo, objetivo.
3. Escribe cada notificación con título, cuerpo, emoji solo si aporta, y pantalla de destino dentro de la app.
4. Marca cuáles serían mejor como mensaje dentro de la app o correo en vez de push, y por qué.
5. Fija el techo de frecuencia por segmento y las reglas de exclusión (por ejemplo: no enviar si ha entrado hoy).
6. Da dos variantes de texto de las tres notificaciones más importantes para compararlas.
7. Define la medición: qué mirar en cada envío, qué es una buena tasa de apertura orientativa para este tipo de app, y a partir de qué señal debo apagar una notificación.
8. Escribe la pantalla de ajustes de notificaciones que debe ver el usuario, con las opciones que puede activar y desactivar.
RESTRICCIONES:
- Nada de falsas alertas: prohibido simular un mensaje de otra persona o un fallo del sistema si no lo es.
- Nada de mayúsculas sostenidas ni de tres signos de exclamación.
- Máximo un push promocional por semana y usuario.
- Cuenta los caracteres de título y cuerpo y ponlos entre paréntesis.
FORMATO DE RESPUESTA:
A) Tabla de segmentos: Nombre | Regla exacta | Tamaño esperado | Objetivo.
B) Calendario día a día en tabla: Día | Segmento | Canal | Hora | Título | Cuerpo | Destino.
C) Reglas de frecuencia y exclusiones, en lista.
D) Variantes para comparar.
E) Panel de medición: métrica, cómo se calcula, señal de alarma.
F) Pantalla de ajustes de notificaciones.
CRITERIOS DE CALIDAD:
- ¿Cada notificación aporta algo al usuario aunque no compre nada?
- ¿Ninguna se envía fuera de la franja permitida ni rompe el techo de frecuencia?
- ¿Todas llevan a una pantalla concreta y no al inicio?
- ¿Un usuario que no quiere nada puede bajarse el volumen sin desinstalar?
```
