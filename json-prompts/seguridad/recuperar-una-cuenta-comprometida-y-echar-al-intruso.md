# Recuperar una cuenta comprometida y echar al intruso…

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Plan ordenado para expulsar a quien ha entrado en tu correo, redes o banca: sesiones, reglas ocultas, accesos de apps y verificación en dos pasos.

## Qué es y qué hace

JSON prompt que guía la recuperación de una cuenta comprometida (correo, redes, nube, banca) y la expulsión del intruso: sesiones abiertas, reglas ocultas de reenvío, accesos de apps, recuperación y doble factor. Parte desde un dispositivo limpio. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el JSON en tu IA
2. Rellena cuenta, proveedor, señales, doble factor y servicios dependientes
3. Sigue los pasos desde un dispositivo limpio
4. Revisa reglas y apps conectadas
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando alguien ha entrado en una cuenta tuya o de un empleado y no basta con cambiar la contraseña porque sigue habiendo actividad rara.

## Cómo ganar dinero con ella

Corta el fraude en curso y evita recaídas que obligan a repetir todo el proceso y a explicar otra vez el problema a los clientes.

- Servicio de recuperación de cuentas hackeadas para autónomos y pymes…
- Guía de respuesta para cuentas de Instagram o correo de empresa…
- Revisión de seguridad de cuentas tras un incidente…

**Precio orientativo:** 50–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Guiarme para recuperar el control de una cuenta comprometida y asegurarme de que el atacante ya no puede volver a entrar",
  "rol": "Tecnico de respuesta a incidentes especializado en cuentas de correo, nube, redes sociales y banca de empresa",
  "entradas": {
    "cuenta_afectada": "[QUE CUENTA: CORREO, INSTAGRAM, GOOGLE, MICROSOFT 365, BANCA, HOSTING]",
    "proveedor": "[GMAIL, OUTLOOK, META, TU BANCO, TU HOSTING]",
    "senales_observadas": "[CORREOS ENVIADOS QUE NO SON TUYOS, PUBLICACIONES RARAS, AVISO DE INICIO DE SESION, CAMBIOS QUE NO HICISTE]",
    "tengo_acceso": "[SI / NO / SOLO A VECES]",
    "doble_factor": "[NO TENGO / SMS / APP DE CODIGOS / LLAVE FISICA]",
    "quien_mas_la_usa": "[PERSONAS Y PROVEEDORES CON ACCESO]",
    "conectado_a": "[QUE SERVICIOS DEPENDEN DE ESA CUENTA: FACTURACION, PUBLICIDAD, TIENDA, COPIAS]"
  },
  "instrucciones": [
    "Empieza siempre desde un dispositivo distinto y del que estes seguro, y explica por que",
    "Da la secuencia correcta: cerrar todas las sesiones abiertas, cambiar la contrasena, revisar el doble factor y solo entonces revisar el resto",
    "Incluye la busqueda de puertas traseras que casi nadie revisa: reglas de reenvio automatico, correos de recuperacion cambiados, telefonos anadidos, aplicaciones de terceros con permisos, contrasenas de aplicacion, delegaciones o usuarios administradores nuevos, claves de acceso o passkeys registradas",
    "Si no tengo acceso, detalla la via de recuperacion del proveedor y que documentacion suelen pedir",
    "Indica que revisar en los servicios conectados por si el atacante salto a ellos",
    "Antes de dar la cuenta por limpia, define 4 comprobaciones a las 24 y a las 72 horas",
    "Termina con la configuracion minima para que no se repita y quien debe tener acceso realmente"
  ],
  "restricciones": [
    "No me pidas nunca contrasenas, codigos ni datos de la cuenta",
    "Adapta los nombres de menu al proveedor indicado; si no lo conoces con certeza, describe donde buscar la opcion",
    "Un paso por linea, en orden, sin bloques teoricos"
  ],
  "formato_salida": {
    "tipo": "Checklist numerada con casillas",
    "secciones": ["Antes de empezar", "Recuperar el control", "Cerrar puertas traseras", "Servicios conectados", "Comprobaciones a 24 y 72 horas", "Configuracion para que no se repita"]
  },
  "criterios_calidad": [
    "El orden de los pasos impide que el atacante recupere la cuenta a mitad del proceso",
    "Incluye al menos cinco puntos de puerta trasera que un usuario normal no conoce",
    "Cada paso indica donde se hace"
  ],
```
