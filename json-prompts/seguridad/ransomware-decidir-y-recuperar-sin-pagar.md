# Ransomware: decidir y recuperar sin pagar…

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Recuperar de un cifrado de ficheros sin pagar rescate ni empeorar la situación.

## Qué es y qué hace

JSON prompt para decidir y ejecutar la recuperación tras un ransomware: evalúa alcance, nota de rescate, copias disponibles y urgencia. Ordena contención, restauración y decisiones (incluida la de no pagar). Se usa en cualquier chat de IA como guía de apoyo.

## Cómo usarla

1. Copia el JSON en tu IA
2. Rellena alcance, nota de rescate y copias disponibles
3. Sigue contención y restauración en orden
4. No apagues ni borres antes de preservar pruebas
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando aparece una nota de rescate o tus archivos no se abren y tienes que decidir en caliente entre pagar, restaurar o parar.

## Cómo ganar dinero con ella

Prioriza lo que hace facturar y evita pagos a delincuentes que muchas veces no devuelven todo y marcan a la empresa como pagadora.

- Guía de recuperación ante ransomware para pymes sin informático…
- Plan de contingencia por ransomware personalizado por sector…
- Simulacro de ransomware para equipos directivos…

**Precio orientativo:** 200–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Ayudarme a decidir y a ejecutar la recuperacion tras un cifrado de ficheros por ransomware",
  "rol": "Coordinador de recuperacion ante ransomware en pymes, con criterio operativo y no comercial",
  "entradas": {
    "alcance": "[QUE EQUIPOS, SERVIDORES, NAS O CARPETAS DE NUBE ESTAN AFECTADOS]",
    "nota_de_rescate": "[PEGA EL TEXTO DE LA NOTA SIN ENLACES PULSADOS]",
    "extension_de_los_ficheros": "[LA EXTENSION QUE SE HA ANADIDO A LOS ARCHIVOS]",
    "copias_de_seguridad": "[DONDE ESTAN, DE QUE FECHA SON, ESTABAN CONECTADAS AL EQUIPO AFECTADO, LAS HAS PROBADO ALGUNA VEZ]",
    "sistemas_criticos": "[QUE NECESITAS SI O SI PARA SEGUIR FACTURANDO: TPV, FACTURACION, PEDIDOS, AGENDA]",
    "tienes_seguro": "[SI CON POLIZA DE CIBERRIESGO / NO / NO LO SE]",
    "tolerancia_de_parada": "[CUANTAS HORAS O DIAS PUEDES ESTAR PARADO]"
  },
  "instrucciones": [
    "Primero da las acciones de contencion: aislar de la red los equipos afectados sin apagarlos, desconectar discos de copia, revisar si la nube esta sincronizando el cifrado y detener la sincronizacion",
    "Explica por que apagar puede perder informacion util y cuando aun asi hay que hacerlo",
    "Evalua las copias de seguridad segun la regla 3-2-1 y di cuales son de fiar y cuales pueden estar cifradas tambien",
    "Plantea la decision con tres opciones (restaurar, reconstruir desde cero, negociar) con pros, contras, tiempo estimado y riesgos de cada una",
    "Explica sin moralinas por que pagar es la peor opcion: no garantiza la recuperacion, financia el delito, deja el acceso abierto y marca a la empresa; y di quien deberia decidirlo si aun asi se plantea",
    "Define el orden de restauracion por prioridad de negocio, con la regla de no restaurar sobre el original y de restaurar primero en un equipo aislado",
    "Incluye las comprobaciones antes de reconectar: contrasenas cambiadas, usuarios revisados, actualizaciones aplicadas, acceso remoto cerrado",
    "Anade los avisos: seguro, denuncia ante Policia o Guardia Civil, INCIBE 017, clientes si hay datos afectados",
    "Termina con un plan de continuidad manual para poder seguir vendiendo mientras se recupera"
  ],
  "restricciones": [
    "No recomiendes descifradores descargados de sitios cualquiera ni contactar con los atacantes por tu cuenta",
    "No prometas que se recuperara todo",
    "Marca de forma visible los pasos irreversibles"
  ],
  "formato_salida": {
    "tipo": "Plan operativo en markdown",
    "secciones": ["Contencion inmediata", "Estado real de tus copias", "Opciones y recomendacion", "Orden de restauracion", "
```
