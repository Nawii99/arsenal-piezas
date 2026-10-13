# rotacion-de-claves-y-secretos…

**Tipo:** JSON prompt · **Área:** Infraestructura · **Licencia:** CC BY 4.0

Inventaria todas tus claves de API y contraseñas de servicios, detecta las expuestas y te da el orden exacto para cambiarlas sin romper nada.

## Qué es y qué hace

Inventaría todas tus claves de API, tokens y contraseñas de servicio, detecta las expuestas y da el orden exacto para cambiarlas sin dejar nada caído. Entran tus sistemas, los servicios con clave, el motivo (revisión periódica, salida de alguien, sospecha de filtración), dónde están hoy, quién tiene acceso y cuántos minutos puede estar caído cada servicio. Salen un inventario con clasificación, la lista de claves expuestas, el procedimiento de rotación por servicio con el panel exacto y la comprobación final. Que lo revise un profesional de seguridad antes de rotar claves en producción.

## Cómo usarla

1. Inventaría cada clave por servicio
2. Localiza las expuestas
3. Rota en el orden indicado
4. Que lo revise un profesional antes de producción

## Cuándo usarla

Úsalo cuando hayas pegado claves en chats, capturas o repositorios, cuando se vaya un colaborador, o cuando lleves meses sin cambiar ninguna clave.

## Cómo ganar dinero con ella

Evita el consumo fraudulento de tus APIs de pago y el robo de datos de clientes, que además de la factura te cuesta la confianza del cliente.

- Rotación de claves para una tienda con varias integraciones de pago y de IA…
- Auditoría de secretos para equipos que han pegado claves en chats o repositorios…
- Plan de rotación periódica para negocios con colaboradores que entran y salen…

**Precio orientativo:** 100–300 € por rotación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Inventariar, clasificar y rotar las claves de API, tokens y contraseñas de servicio del negocio sin dejar el sistema caído",
  "contexto": {
    "sistemas": "[QUÉ TIENES MONTADO: WEB, AUTOMATIZACIONES, TIENDA, BOT, HOJAS DE CÁLCULO CONECTADAS]",
    "servicios_con_clave": "[LISTA: OPENAI, STRIPE, RESEND, SUPABASE, WHATSAPP, GOOGLE, ETC.]",
    "motivo": "[REVISIÓN PERIÓDICA / SE HA IDO ALGUIEN / SOSPECHO FILTRACIÓN / ANTES DE ABRIR AL PÚBLICO]",
    "perfil": "sin perfil técnico: hay que decir en qué panel se cambia cada cosa y dónde se pega la nueva"
  },
  "entradas": {
    "donde_estan_hoy": "[GESTOR DE CONTRASEÑAS / ARCHIVO EN EL ORDENADOR / CORREOS / NOTAS DEL MÓVIL / NO LO SÉ]",
    "quien_tiene_acceso": "[PERSONAS Y HERRAMIENTAS QUE HOY PUEDEN VER O USAR ESAS CLAVES]",
    "tolerancia_a_corte": "[CUÁNTOS MINUTOS PUEDE ESTAR CAÍDO CADA SERVICIO]"
  },
  "procedimiento": [
    "1. Inventario: por cada servicio apunta clave o token, para qué se usa, dónde está pegada (web, automatización, hoja, móvil), quién la conoce y desde cuándo existe",
    "2. Clasifica por daño si se filtra: mueve dinero, envía en mi nombre, lee datos de clientes, solo lectura sin datos",
    "3. Busca exposiciones: capturas compartidas, mensajes en chats, repositorios públicos, archivos en la nube compartidos por enlace, correos antiguos, historiales de chats con IA",
    "4. Comprueba si el servicio permite claves separadas por uso y permisos limitados: una clave por automatización, con el mínimo permiso posible",
    "5. Orden de rotación: primero las que mueven dinero, luego las que envían en tu nombre, luego el resto",
    "6. Rota con solape cuando el servicio lo permita: crea la nueva clave, pégala en todos los sitios, comprueba que funciona y solo entonces revoca la antigua",
    "7. Cuando no haya solape posible, elige una franja de bajo tráfico y ten a mano la lista exacta de sitios donde hay que pegarla",
    "8. Prueba después de cada rotación: una operación real de principio a fin por cada servicio (un cobro de prueba, un correo, una consulta)",
    "9. Guarda todo en un gestor de contraseñas con acceso compartido controlado y borra las copias sueltas",
    "10. Revisa el registro de uso del servicio en los últimos 30 días buscando llamadas desde países o horas raras"
  ],
  "que_mirar": [
    "Claves en el código de la web visible desde el navegador: cualquiera puede leerlas",
    "Diferencia entre clave pública o publicable y clave secreta: solo la secreta se rota con urgencia",
    "Claves de prueba mezcladas con las de producción",
    "Integraciones que siguen activas de herramientas que ya no usas",
    "Cuentas de servicio compartidas con tu contraseña personal en vez de accesos independientes"
  ],
  "errores_tipicos": [
    "Revocar la clave vieja antes de comprobar que la nueva funciona en todos los sitios",
    "Olvidar un sitio donde estaba pegada y descubrirlo tres días después porque no llegan los correos",
    "Guardar las claves nuevas en el mismo sitio inseguro de siempre",
    "Cambiar la clave y no cerrar las sesiones abiertas ni quitar los accesos de la persona que se ha ido"
  ],
  "restricciones": [
    "No pidas ni escribas el valor real de ninguna clave en el resultado: solo nombres, ubicaciones y pasos",
    "Marca claramente los pasos irreversibles antes de ejecutarlos",
    "Español llano, con el nombre exacto del menú de cada panel cuando se conozca"
  ],
  "formato_salida": {
    "1_inventario": "tabla: servicio | para qué | nivel de daño | dónde está pegada | quién la conoce | antigüedad",
    "2_exposiciones": "lista de sitios donde puede haberse filtrado y qué hacer con cada uno",
    "3_plan_de_rotacion": "orden numerado con: crear nueva, sitios a actualizar, prueba a realizar, revocar antigua",
    "4_checklist_de_prueba": "una comprobación concreta por servicio para confirmar que sigue funcionando",
    "5_reglas_de_higiene": "5 reglas cortas para no volver al desorden, con fecha de próxima revisión"
  },
  "criterios_calidad": [
    "Ningún servicio queda sin responsable ni sin fecha de rotación",
    "El plan permite volver atrás si algo falla a mitad",
    "Las claves de dinero y d
```
