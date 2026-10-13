# Puesto de trabajo seguro: portátiles, móviles y wifi…

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Ajustes que deben tener todos los ordenadores, móviles y router desde el primer día.

## Qué es y qué hace

JSON prompt que crea la guía de configuración segura de ordenadores, móviles y red wifi de una pyme sin personal técnico: ajustes obligatorios desde el primer día. Entran equipos, sistemas y móviles. Se usa en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Copia el JSON y rellena los [corchetes]
2. Pégalo en Claude, Codex, Gemini o una IA local
3. Aplica los ajustes equipo a equipo
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando compras equipos nuevos, montas la oficina o sospechas que los ordenadores están tal cual salieron de la caja.

## Cómo ganar dinero con ella

Con ajustes gratuitos que ya trae el equipo reduces el daño de un robo, una pérdida o un virus, sin contratar nada.

- Guía de puesto de trabajo seguro para pymes…
- Checklist de configuración de portátiles y móviles nuevos…
- Revisión de wifi y router para oficinas pequeñas…

**Precio orientativo:** 100–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Crear la guía de configuración segura de los ordenadores, móviles y red wifi de una pyme sin personal técnico",
  "contexto": {
    "empresa": "[NOMBRE DE LA EMPRESA]",
    "equipos": "[CUÁNTOS ORDENADORES Y CON QUÉ SISTEMA: WINDOWS, MAC]",
    "moviles": "[CUÁNTOS Y SI SON DE EMPRESA O PERSONALES]",
    "salen_de_la_oficina": "[SÍ / NO / ALGUNOS]"
  },
  "entradas": {
    "red": "[ROUTER DEL OPERADOR O PROPIO, SI HAY WIFI DE INVITADOS, SI HAY CÁMARAS O IMPRESORAS CONECTADAS]",
    "programas_criticos": "[GESTIÓN, TPV, DISEÑO, CONTABILIDAD]",
    "usuarios_por_equipo": "[SI VARIAS PERSONAS COMPARTEN EL MISMO ORDENADOR Y LA MISMA SESIÓN]"
  },
  "metodo": [
    "Ordenador: cifrado del disco activado, usuario sin permisos de administrador para el trabajo diario, bloqueo automático de pantalla, antivirus del sistema activo y actualizaciones automáticas",
    "Móvil: código o huella, cifrado, buscar mi dispositivo y borrado remoto, apps solo de tiendas oficiales y separación del uso personal si el móvil es del trabajador",
    "Red: cambiar la contraseña de administración del router, cifrado moderno del wifi, red de invitados separada para clientes y equipos raros, y desactivar el acceso remoto que venga abierto de fábrica",
    "Impresoras y cámaras: cambiar contraseñas por defecto y no dejarlas accesibles desde internet",
    "Definir qué se revisa al recibir un equipo nuevo y qué se hace antes de tirar o vender uno viejo",
    "Para cada punto indicar los pasos exactos por sistema, cuánto se tarda y cómo comprobar que ha quedado activado"
  ],
  "restricciones": [
    "Solo ajustes que trae el propio equipo o el router: nada de comprar software salvo que se indique como opcional",
    "Antes de cifrar un disco, avisar de guardar la clave de recuperación y dónde",
    "Advertir de lo que puede dejar de funcionar tras cada cambio y cómo revertirlo",
    "Pasos numerados con el nombre literal de los menús, sin captura de pantalla necesaria"
  ],
  "formato_salida": {
    "tipo": "guía por dispositivo con checklist final",
    "bloques": ["Ordenadores Windows", "Ordenadores Mac", "Móviles Android e iPhone", "Router y wifi", "Impresoras, cámaras y otros aparatos", "Equipo nuevo y equipo que se retira"],
    "columnas_checklist": ["Ajuste", "Dispositivo", "Tiempo", "Cómo comprobar que está activo", "Hecho"]
  },
  "criterios_calidad": [
    "Cada ajuste se puede completar en menos de 10 minutos y sin ayuda externa",
    "Nadie pierde acceso a sus datos por seguir la guía",
    "Al final queda una hoja para marcar equipo por equipo"
  ],
  "tono":
```
