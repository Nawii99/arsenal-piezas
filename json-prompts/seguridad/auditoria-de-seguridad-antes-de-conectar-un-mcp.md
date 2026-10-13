# Auditoría de seguridad antes de conectar un MCP…

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Revisa un servidor MCP antes de instalarlo y te dice con semáforo qué datos vería, qué puede modificar y si es prudente conectarlo.

## Qué es y qué hace

JSON prompt que audita un servidor MCP antes de instalarlo: revisa permisos de cada herramienta (lectura, escritura, borrado, ejecución de código), alcance de las credenciales, recorrido de los datos y quién lo publica. Devuelve un semáforo, permisos a recortar y qué vigilar. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el JSON
2. Rellena los [corchetes] con servidor, autor y credenciales
3. Pégalo en la IA
4. Aplica los recortes de permisos
5. Que lo revise un profesional

## Cuándo usarla

Úsalo justo antes de instalar un conector MCP que va a tocar correo, clientes, facturación o tu tienda, sobre todo si no es oficial.

## Cómo ganar dinero con ella

Evita el disgusto de dar acceso de escritura a un conector desconocido y el coste de una fuga de datos o un borrado accidental.

- Auditoría previa de conectores MCP para empresas con datos de clientes…
- Informe de riesgos de integraciones de IA para asesorías…
- Servicio de revisión de seguridad de herramientas antes de su uso…

**Precio orientativo:** 150–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Audita este servidor MCP antes de que lo instale y dime con un semáforo si es prudente conectarlo, qué permisos recortar y qué vigilar después",
  "servidor_a_auditar": {
    "nombre": "[NOMBRE DEL SERVIDOR MCP]",
    "enlace_o_repositorio": "[URL]",
    "autor_o_empresa": "[QUIÉN LO PUBLICA]",
    "forma_de_ejecucion": "[EN MI ORDENADOR / EN UN SERVIDOR REMOTO]",
    "credenciales_que_pide": "[EJ: CLAVE API DE STRIPE, ACCESO A MI GMAIL]",
    "sistema_que_conecta": "[QUÉ SISTEMA Y QUÉ DATOS CONTIENE]",
    "hay_datos_personales": "[SÍ / NO / NO LO SÉ]"
  },
  "revisiones_obligatorias": [
    "Permisos: cada herramienta que expone, si solo lee o también crea, modifica o borra, y si alguna ejecuta comandos o código",
    "Alcance de las credenciales: si pide una clave de administrador cuando bastaría una de solo lectura",
    "Recorrido de los datos: si salen de mi equipo, hacia qué servicios y si quedan guardados en algún sitio",
    "Confianza del origen: quién lo mantiene, actividad reciente, licencia, si es el conector oficial del fabricante",
    "Dependencias y actualizaciones automáticas que podrían cambiar el comportamiento sin avisar",
    "Riesgo de instrucciones ocultas: si el agente lee contenido de fuera (correos, webs, tickets) que podría contener órdenes maliciosas",
    "Qué pasa si el agente se equivoca: acciones irreversibles, envíos a clientes, cobros, borrados"
  ],
  "escala": {
    "verde": "conectar con normalidad",
    "ambar": "conectar solo con permisos recortados y estas condiciones",
    "rojo": "no conectar hasta resolver esto"
  },
  "instrucciones": [
    "Recorre las revisiones obligatorias una a una y asigna color con una frase de justificación",
    "Propón la versión mínima de permisos con la que la tarea seguiría funcionando",
    "Indica qué debería probar primero en una cuenta de pruebas o con datos falsos",
    "Añade tres preguntas concretas para hacer al autor o al proveedor si algo no queda claro"
  ],
  "restricciones": [
    "No des por buena una afirmación del propio proyecto sin contrastarla",
    "Si falta información para juzgar un punto, márcalo en ámbar y di qué falta",
    "Explica cada riesgo con un ejemplo de qué podría pasar en un negocio como el mío"
  ],
  "formato_salida": {
    "tipo": "markdown",
    "secciones": [
      "Veredicto: verde, ámbar o rojo, en una frase",
      "Tabla: Revisión | Color | Qué he encontrado | Qué hacer",
      "Permisos mínimos recomendados",
      "Plan de prueba segura antes de usarlo con datos reales",
      "Qué revisar cada mes una vez conectado"
```
