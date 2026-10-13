# Checklist de altas y bajas de empleados…

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Te genera la lista exacta de accesos que hay que dar el primer día y quitar el último día a cualquier persona que entra o sale.

## Qué es y qué hace

JSON prompt que crea el procedimiento de alta y baja de accesos del personal de una pyme con checklist marcable: qué dar el primer día y qué quitar el último. Entran puestos y quién administra las cuentas. Se usa en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Copia el JSON y rellena los [corchetes]
2. Pégalo en Claude, Codex, Gemini o una IA local
3. Usa el checklist en cada alta y baja
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando contratas, cambias de personal o se va alguien y no sabes bien a cuántos sitios tenía acceso.

## Cómo ganar dinero con ella

Evita el clásico exempleado que sigue entrando en el correo o la nube meses después, y ahorra licencias que pagas sin usar.


**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Crear el procedimiento de alta y baja de accesos para el personal de una pyme, con checklist marcable",
  "contexto": {
    "empresa": "[NOMBRE DE LA EMPRESA]",
    "puestos": "[LISTA DE PUESTOS: ADMINISTRACIÓN, COMERCIAL, TALLER, TIENDA, DIRECCIÓN]",
    "quien_administra_las_cuentas": "[PERSONA O EMPRESA EXTERNA]",
    "rotacion": "[ALTAS Y BAJAS APROXIMADAS AL AÑO, INCLUIDOS TEMPORALES Y BECARIOS]"
  },
  "entradas": {
    "servicios": "[CORREO, NUBE, PROGRAMA DE GESTIÓN, CRM, TIENDA, REDES SOCIALES, BANCO, VPN, FICHAJE]",
    "dispositivos_entregados": "[PORTÁTIL, MÓVIL, LLAVES, TARJETA, TPV]",
    "accesos_fisicos": "[ALARMA, LLAVES, CÓDIGOS DE PUERTA]"
  },
  "metodo": [
    "Definir para cada puesto el paquete mínimo de accesos, siguiendo la idea de dar solo lo necesario para trabajar",
    "Preparar el checklist de alta: crear cuentas, activar la verificación en dos pasos, entregar equipo, firmar normas de uso y explicar el protocolo de avisos",
    "Preparar el checklist de baja con plazos: bloquear el correo y la sesión el mismo día, redirigir mensajes, recuperar equipos y cambiar contraseñas compartidas",
    "Incluir los accesos que se olvidan siempre: redes sociales, dominios, hosting, banca, plataformas de reseñas, grupos de WhatsApp y accesos de proveedores",
    "Definir qué pasa con los ficheros y el correo de la persona que se va y quién los hereda",
    "Fijar una revisión trimestral que compare la lista de personal con la lista de cuentas activas"
  ],
  "restricciones": [
    "Los pasos de la baja se ordenan por urgencia: lo primero, todo lo que da acceso a dinero o a datos de clientes",
    "Cada línea tiene un responsable y un plazo en horas o días",
    "Respetar el derecho a la intimidad: acceder al correo del empleado que se va solo por motivos laborales y avisándolo",
    "Nada de herramientas de administración avanzada: pasos posibles desde el panel normal de cada servicio"
  ],
  "formato_salida": {
    "tipo": "dos checklists marcables más tabla de accesos por puesto",
    "columnas_checklist": ["Acción", "Servicio o equipo", "Responsable", "Plazo", "Hecho", "Fecha"],
    "anexos": ["Tabla de accesos por puesto", "Correo tipo de aviso al equipo cuando alguien se va", "Hoja de entrega y devolución de equipos para firmar"]
  },
  "criterios_calidad": [
    "Un exempleado no puede entrar a nada al día siguiente de su baja",
    "El checklist se puede rellenar en papel o en el móvil sin depender de una herramienta",
    "Contempla despidos rápidos y salidas conflictivas"
  ],
  "tono": "ordenado y operativo, tutean
```
