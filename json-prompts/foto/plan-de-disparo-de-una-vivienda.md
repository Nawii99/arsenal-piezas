# Plan de disparo de una vivienda…

**Tipo:** JSON prompt · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Te devuelve la lista ordenada de fotos que hay que hacer en un piso, estancia por estancia, con el orden de la luz y el encuadre de cada toma.

## Qué es y qué hace

JSON prompt que diseña la lista completa de tomas (shot list) de una sesión de fotografía inmobiliaria, ordenada por estancias y luz del día. Entran tipo de inmueble, metros, estancias, orientación, hora, equipo y tiempo; salen orden de disparo y encuadre de cada toma. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el JSON
2. Rellena inmueble, estancias, hora y equipo
3. Pégalo en tu IA de texto
4. Imprime la lista y llévala a la visita

## Cuándo usarla

Úsalo cuando tengas una cita para fotografiar un inmueble y quieras entrar sabiendo exactamente qué disparar y en qué orden, sin dar vueltas ni olvidarte de estancias.

## Cómo ganar dinero con ella

Te evita volver a la vivienda por fotos que faltan y te permite cerrar la sesión en menos tiempo, así que cabes en más visitas al día.

- Reportajes fotográficos de viviendas para agencias inmobiliarias…
- Shot lists estandarizadas para equipos de captación…
- Formación a agentes para fotografiar con móvil…

**Precio orientativo:** 60–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Diseñar el plan de disparo (shot list) completo de una sesión de fotografía inmobiliaria, ordenado por estancias y por la luz del día",
  "contexto": "El fotógrafo tiene un tiempo limitado dentro de la vivienda y necesita salir con todas las tomas necesarias para publicar el inmueble sin volver",
  "entradas": {
    "tipo_inmueble": "[PISO / CHALET / ÁTICO / LOFT / LOCAL]",
    "superficie_m2": "[METROS CUADRADOS]",
    "estancias": "[LISTA: SALÓN, COCINA, 2 DORMITORIOS, BAÑO, TERRAZA...]",
    "orientacion_ventanas": "[NORTE / SUR / ESTE / OESTE / NO LO SÉ]",
    "hora_y_fecha_cita": "[HORA Y FECHA]",
    "equipo": "[CÁMARA Y OBJETIVO O MÓVIL] + [TRÍPODE SÍ/NO] + [FLASH SÍ/NO]",
    "tiempo_disponible_min": "[MINUTOS DENTRO DE LA VIVIENDA]",
    "destino": "[PORTAL INMOBILIARIO / WEB PROPIA / VIVIENDA DE ALTO STANDING]"
  },
  "procedimiento": [
    "Ordena las estancias para fotografiar primero las que reciben sol directo a la hora de la cita y dejar para el final las que tienen luz constante",
    "Asigna un número de tomas por estancia: 2-3 en salón y cocina, 1-2 en dormitorios, 1 en baños, 1-2 en exteriores; ajusta al tiempo disponible",
    "Para cada toma indica: punto exacto desde donde disparar (normalmente una esquina), qué queda en el encuadre, altura de cámara y objetivo o distancia focal",
    "Usa altura de cámara de 1,30-1,50 m y cámara nivelada para que las verticales salgan rectas; en baños pequeños puedes bajar a 1,20 m",
    "Recomienda focal equivalente entre 16 y 24 mm; prohíbe el ojo de pez y los ultra angulares que deforman los muebles",
    "Añade siempre una toma vertical de la estancia principal para redes y una foto de detalle que dé carácter (chimenea, suelo hidráulico, vistas)",
    "Cierra con las tomas de exterior, portal, zonas comunes y vistas desde las ventanas"
  ],
  "restricciones": [
    "Nada de fotos con espejos que reflejen al fotógrafo ni con el trípode visible",
    "No incluir tomas donde aparezcan personas, mascotas ni datos personales de los propietarios",
    "No prometer encuadres imposibles: si una estancia mide menos de 6 m2, indica la limitación y la alternativa"
  ],
  "formato_salida": {
    "tipo": "tabla en markdown",
    "columnas": ["Orden", "Estancia", "Toma", "Desde dónde disparo", "Altura y focal", "Qué debe salir", "Minutos"],
    "extras": ["Resumen final con el total de fotos y el total de minutos", "Lista de 5 avisos de última hora antes de guardar el equipo"]
  },
  "criterios_calidad": [
    "El plan cabe en el tiempo disponible indicado",
    "Cada estancia de la lista apare
```
