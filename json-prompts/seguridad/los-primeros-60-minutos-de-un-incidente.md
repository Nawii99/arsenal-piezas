# Los primeros 60 minutos de un incidente…

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Pasos los primeros 60 minutos tras detectar un ataque, sin borrar pruebas ni empeorar.

## Qué es y qué hace

JSON prompt que guía los primeros 60 minutos tras detectar un ataque: clasifica la gravedad, ordena qué contener y qué no tocar para no destruir pruebas, y a quién avisar. Entrada: qué has visto, cuándo y qué sistemas. Sirve en cualquier chat de IA, también como guía de apoyo.

## Cómo usarla

1. Copia el JSON en tu IA
2. Rellena qué ha pasado, cuándo y sistemas afectados
3. Sigue los pasos en el orden indicado sin borrar nada
4. Avisa a tu informático o proveedor
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando acabas de detectar algo raro (ficheros cifrados, correos enviados sin tu permiso, web modificada) y no sabes qué tocar primero.

## Cómo ganar dinero con ella

Reduce las horas de parón y evita decisiones precipitadas que luego multiplican el coste de la recuperación y del peritaje.

- Guía de primeros auxilios ante incidentes para pymes sin equipo técnico…
- Plan de respuesta a incidentes impreso para clínicas, tiendas y asesorías…
- Servicio de preparación de incidentes con plantillas por sector…

**Precio orientativo:** 150–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Guiarme paso a paso durante los primeros 60 minutos de un incidente de seguridad para contener el dano sin destruir pruebas",
  "rol": "Responsable de respuesta a incidentes con experiencia en pymes espanolas sin equipo tecnico interno",
  "contexto": {
    "empresa": "[NOMBRE DE TU EMPRESA]",
    "sector": "[SECTOR: TIENDA ONLINE, CLINICA, ASESORIA, TALLER...]",
    "que_ha_pasado": "[DESCRIBE LO QUE HAS VISTO: FICHEROS CIFRADOS, CORREOS RAROS ENVIADOS DESDE TU CUENTA, WEB MODIFICADA, COBRO NO RECONOCIDO]",
    "cuando_lo_detectaste": "[FECHA Y HORA APROXIMADA]",
    "sistemas_afectados": "[ORDENADORES, MOVILES, WEB, CORREO, TPV O NUBE QUE CREES AFECTADOS]",
    "quien_esta_disponible": "[QUIEN PUEDE AYUDAR AHORA: TU, INFORMATICO EXTERNO, PROVEEDOR DE HOSTING]",
    "el_negocio_puede_parar": "[SI / NO / SOLO UNAS HORAS]"
  },
  "instrucciones": [
    "Clasifica la gravedad en alta, media o baja en la primera linea y justificalo en una frase",
    "Organiza las acciones en tres bloques: 0-15 minutos, 15-30 minutos y 30-60 minutos, numeradas y concretas",
    "En cada accion di quien la hace, cuanto tarda y que se consigue con ella",
    "Separa contener de investigar: nada de reinstalar, formatear ni borrar antes de preservar pruebas",
    "Indica cuando conviene desconectar el equipo de la red (cable y wifi) dejandolo encendido, y cuando no",
    "Recuerda cambiar contrasenas desde un dispositivo limpio, nunca desde el equipo sospechoso",
    "Incluye los avisos externos con plazo: banco, hosting, asesoria, aseguradora de ciberriesgo y linea 017 de INCIBE"
  ],
  "restricciones": [
    "Sin jerga: si usas un termino tecnico, explicalo entre parentesis en lenguaje llano",
    "No propongas herramientas de linea de comandos ni pasos que exijan ser administrador de sistemas",
    "No inventes datos del incidente: si falta informacion, hazme como maximo 5 preguntas antes de continuar",
    "Nunca recomiendes pagar un rescate como primera opcion"
  ],
  "formato_salida": {
    "tipo": "Checklist accionable en markdown, imprimible en una pagina",
    "secciones": ["Gravedad y resumen en una linea", "Acciones 0-15 min", "Acciones 15-30 min", "Acciones 30-60 min", "Que NO hacer", "A quien avisar y cuando", "Que anotar para la investigacion posterior"]
  },
  "criterios_calidad": [
    "Cada accion se puede ejecutar sin conocimientos tecnicos o con una llamada a un proveedor",
    "Ninguna accion destruye evidencias que hagan falta despues",
    "Las tres primeras acciones son las que mas dano evitan"
  ],
  "tono": "Directo, calmado, tuteando, sin
```
