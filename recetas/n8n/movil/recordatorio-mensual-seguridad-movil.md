# Recordatorio mensual de seguridad del móvil…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Automatización de n8n que manda un recordatorio mensual por Telegram o email con la checklist básica de copia de seguridad y permisos del móvil.

## Qué es y qué hace

Receta de n8n que lanza un recordatorio mensual por Telegram o email con la checklist básica del móvil: copia de seguridad, permisos de apps nuevas y bloqueo de pantalla. Entra un disparador Cron y un nodo Set con el texto editable; sale un mensaje automático cada mes sin intervención. Se monta con la versión self-hosted gratuita de n8n o con la nube, sin escribir código, y no sustituye a una revisión real.

## Cómo usarla

1. Crea el Cron mensual
2. Escribe la checklist en un nodo Set
3. Conecta Telegram o Gmail para el envío
4. Que lo revise un profesional

## Cuándo usarla

Sabes que deberías revisar la copia de seguridad y los permisos, pero se te pasa mes tras mes.

## Cómo ganar dinero con ella

Ofrécelo como suscripción de mantenimiento de seguridad móvil para autónomos o familias: recordatorio mensual más una revisión corta, con cuota [TU PRECIO]. La revisión de seguridad la hace una persona; el recordatorio solo avisa.

- Mantenimiento mensual de seguridad móvil para autónomos, con recordatorio y revisión corta.
- Recordatorio para familias con personas mayores cuyo móvil no se revisa desde hace años.
- Plantilla de recordatorios para una pyme que quiere que su equipo revise los móviles.

**Precio orientativo:** 15–30 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace
Manda un recordatorio automático una vez al mes por Telegram (o email) con la checklist básica de seguridad del móvil: revisar copia de seguridad, revisar permisos nuevos, comprobar bloqueo de pantalla.
## Cuentas necesarias
- Cuenta de n8n (la versión cloud gratuita tiene un límite de ejecuciones al mes, revisa el plan actual antes de montarlo).
- Un bot de Telegram gratis (se crea hablando con @BotFather, tarda dos minutos) o una cuenta de email tipo Gmail si prefieres recibirlo por correo.
## Nodos, en orden
1. Cron (disparador): configúralo para 'Every month', día 1, a la hora que prefieras. Es el nodo que arranca todo.
2. Set (opcional): crea un campo de texto con la checklist completa, así la tienes editable en un solo sitio sin tocar el nodo final. Ejemplo de contenido: '1. ¿Tienes copia de seguridad de menos de un mes? 2. ¿Has revisado permisos de apps nuevas? 3. ¿Tu móvil tiene PIN de 6 dígitos o más? 4. ¿Alguna app pide ya permisos raros?'.
3. Telegram (acción 'Send Message'): conecta tu bot, pon tu chat ID como destinatario, y en el mensaje mete el texto del nodo Set (o escríbelo directo aquí si te saltas el paso 2).
4. Alternativa al nodo Telegram: nodo Email (Send Email) con tu cuenta Gmail conectada, mismo contenido, si prefieres recibirlo en el correo en vez de Telegram.
## Cómo probarla sin liarla
Antes de dejarla en automático, cambia el Cron a ejecución manual o pulsa 'Test workflow' para que se dispare ya, así compruebas que el mensaje te llega bien formateado y al chat correcto. Cuando lo confirmes, vuelve a poner el Cron en mensual y actívala.
## Qué NO hacer
No conectes esta automatización a ninguna app que pida permisos de administrador de dispositivo o de accesibilidad para 'revisar' el móvil automáticamente: eso es justo el tipo de permiso que hay que vigilar, no dar. No pongas datos bancarios ni contraseñas dentro del mensaje de la checklist, es solo un recordatorio de texto.
