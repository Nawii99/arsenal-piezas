# Mapa de riesgos digitales de tu pyme…

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Te saca un informe con los puntos flacos de tu negocio en internet, ordenados por gravedad, y las 10 cosas que deberías arreglar primero.

## Qué es y qué hace

JSON prompt que hace el mapa de riesgos digitales de una pyme sin informático, ordenado por gravedad, y prioriza las 10 medidas más urgentes. Entran sector, plantilla y quién gestiona la informática. Se usa en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Copia el JSON y rellena los [corchetes]
2. Pégalo en Claude, Codex, Gemini o una IA local
3. Aplica las 10 medidas por orden
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando nunca te has parado a mirar la seguridad de tu empresa y no sabes por dónde empezar ni qué es urgente y qué puede esperar.

## Cómo ganar dinero con ella

Evita que gastes dinero en soluciones que no necesitas y te enfoca en lo que de verdad puede pararte el negocio o costarte una transferencia.

- Informe de ciberseguridad básico para dirección…
- Diagnóstico inicial como puerta de entrada a servicios de TI…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Hacer el mapa de riesgos digitales de una pyme sin informático y priorizar las 10 medidas más urgentes",
  "contexto": {
    "empresa": "[NOMBRE DE LA EMPRESA]",
    "sector": "[SECTOR]",
    "plantilla": "[NÚMERO DE PERSONAS]",
    "quien_gestiona_la_informatica": "[NADIE / EL DUEÑO / UNA EMPRESA EXTERNA]",
    "presupuesto_anual_seguridad": "[EUROS AL AÑO]"
  },
  "entradas": {
    "servicios_en_uso": "[CORREO, BANCA, FACTURACIÓN, TIENDA ONLINE, NUBE, CRM, REDES SOCIALES]",
    "dispositivos": "[ORDENADORES, MÓVILES, TPV, ROUTER, CÁMARAS, DISCO EN RED]",
    "datos_que_guardas": "[CLIENTES, NÓMINAS, DATOS DE SALUD, TARJETAS, PROYECTOS]",
    "quien_accede_a_que": "[PERSONAS Y ACCESOS QUE TIENEN, INCLUIDOS PROVEEDORES EXTERNOS]",
    "sustos_previos": "[INCIDENTES O INTENTOS DE FRAUDE YA VIVIDOS]"
  },
  "metodo": [
    "Inventariar activos: datos, cuentas, dispositivos, servicios en la nube y proveedores con acceso",
    "Plantear para cada activo las cuatro amenazas típicas de pyme: robo de credenciales, secuestro de ficheros, fraude por correo y pérdida o avería del equipo",
    "Valorar cada riesgo con probabilidad de 1 a 5 e impacto de 1 a 5 medido en euros y en días de negocio parado, y calcular criticidad como probabilidad por impacto",
    "Anotar si hoy existe alguna medida y si está comprobada en los últimos 6 meses",
    "Ordenar por criticidad y quedarse con los 10 primeros riesgos",
    "Proponer para cada uno la medida más barata que reduzca el riesgo, con coste estimado y tiempo de implantación"
  ],
  "restricciones": [
    "Nada de jerga: si aparece un término técnico, explicarlo en la misma frase con palabras normales",
    "Solo medidas que pueda aplicar una persona no técnica o un proveedor local en menos de un día",
    "Priorizar lo gratuito o lo que ya viene incluido en las herramientas que la empresa paga",
    "No recomendar un producto concreto como única salida: dar siempre dos alternativas",
    "No inventar datos: lo que falte se marca como [PENDIENTE DE COMPROBAR]"
  ],
  "formato_salida": {
    "tipo": "informe breve en markdown",
    "secciones": ["Resumen en 5 frases para el dueño", "Tabla de riesgos", "Las 10 acciones priorizadas", "Qué hacer este mes, este trimestre y este año", "Qué me falta saber para afinar"],
    "columnas_tabla": ["Activo", "Qué puede pasar", "Probabilidad", "Impacto", "Criticidad", "Medida actual", "Medida propuesta", "Coste aprox.", "Responsable"]
  },
  "criterios_calidad": [
    "Cada acción cabe en una frase y empieza por un verbo",
    "Ninguna acción exige saber programar ni c
```
