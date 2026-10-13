# Alarma de cadena de frío para hostelería…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Prompt que diseña el aviso de temperatura para tus neveras y cámaras: dónde va cada sonda, qué umbrales, a quién avisa y qué registro queda guardado.

## Qué es y qué hace

Prompt que diseña el aviso de temperatura de neveras y cámaras de hostelería: colocación de sondas, umbrales, destinatarios del aviso y registro guardado, con foco en evitar falsas alarmas. Se usa en cualquier chat de IA para bares, tiendas u obradores.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con negocio y equipos de frío
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Que lo revise un profesional

## Cuándo usarla

Úsalo si tienes bar, restaurante, tienda de alimentación, farmacia o laboratorio y quieres enterarte de que una cámara sube de temperatura antes de perder el género.

## Cómo ganar dinero con ella

Una sola noche de cámara averiada detectada a tiempo evita tirar producto; además deja el registro de temperaturas que te piden en los controles de higiene.

- Alarma de cadena de frío para bares y restaurantes…
- Registro digital de temperaturas para autocontrol…
- Mantenimiento mensual de sondas y avisos…

**Precio orientativo:** 150–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico de instalaciones de frío y sensórica para hostelería y comercio de alimentación en España, con experiencia en autocontrol de temperaturas y en montar avisos que la gente no acaba silenciando por pesados.

MI SITUACIÓN
- Negocio: [BAR / RESTAURANTE / TIENDA / FARMACIA / OBRADOR / OTRO] en [CIUDAD]
- Equipos de frío a vigilar, uno por línea: [NOMBRE | TIPO (nevera positiva, congelador, cámara, expositor, vitrina) | TEMPERATURA DE TRABAJO | CONTENIDO Y VALOR APROXIMADO DEL GÉNERO]
- Horario en que hay alguien en el local: [DATO] y quién responde fuera de horario: [NOMBRE Y TELÉFONO]
- Qué tengo ya: [NADA / TERMÓMETROS MANUALES / SENSORES WIFI / HOME ASSISTANT / OTRO]
- Internet en el local: [FIBRA ESTABLE / COMPARTIDO / REGULAR], y si tengo SAI: [SÍ/NO]
- Presupuesto orientativo: [DATO]

LO QUE TIENES QUE HACER
1. Define para cada equipo el punto de medición correcto y explica por qué ahí: sonda en el aire de la zona más caliente, sonda dentro de un frasco con glicol o agua para imitar la inercia del producto, nunca pegada al evaporador ni en la puerta, y nunca solo el display del propio equipo.
2. Fija umbrales de dos niveles: aviso previo y alarma, con TIEMPO MÍNIMO por encima del umbral para no saltar en cada desescarche ni cada vez que se abre la puerta. Justifica el retardo que propones para cada tipo de equipo.
3. Añade las alarmas que la gente olvida: puerta abierta más de X minutos, sensor sin dar señal desde hace X minutos (fallo de red o pila), batería baja, corte de luz, y subida lenta y sostenida que indica que el equipo empieza a fallar aunque aún esté en rango.
4. Diseña la cadena de avisos: quién recibe qué, por qué vía, en qué orden y a los cuántos minutos escala al siguiente si nadie confirma. Incluye qué hacer de madrugada y cómo se silencia una alarma sin desactivarla para siempre.
5. Escribe el PROTOCOLO DE ACTUACIÓN que se cuelga en la cocina: primeros 5 minutos, qué comprobar (puerta, corte de luz, evaporador con hielo, ventilador parado), cuándo trasladar el género y a partir de qué temperatura y tiempo hay que desechar o consultar.
6. Define el registro: qué se guarda, cada cuánto, cuánto tiempo se conserva y cómo sacar un informe mensual legible con máximos, mínimos y las incidencias con su hora y su resolución.
7. Propón dos montajes posibles, uno barato y uno más robusto, indicando para cada uno: tipo de sensor y rango necesario, autonomía, si necesita pasarela, si funciona sin internet, y qué pasa si se corta la luz.

RESTRICCIONES
- No cites normativa concreta ni artículos legales; habla de buenas prácticas y di que confirme los requisitos con su técnico de higiene alimentaria o su gestor.
- No inventes precios ni modelos con especificaciones falsas. Si mencionas un tipo de producto, describe la característica que debe cumplir.
- Prioriza que el sistema avise poco y bien: una alarma que salta a diario acaba ignorada.
- Nada de decisiones sobre si un alimento es apto o no: el sistema informa, la decisión es del responsable.

FORMATO DE RESPUESTA
A) TABLA DE SENSORES: Equipo | Dónde va la sonda | Umbral aviso | Umbral alarma | Retardo | Motivo.
B) LISTA DE ALARMAS ADICIONALES, una por línea.
C) CADENA DE AVISOS en escalones con minutos.
D) PROTOCOLO DE ACTUACIÓN en 8 pasos, redactado para colgar en la pared.
E) REGISTRO: qué se guarda y cómo se saca el informe.
F) DOS MONTAJES comparados en tabla: Coste relativo | Qué necesita | Aguanta sin internet | Aguanta sin luz | Mantenimiento.
G) PRUEBA DE PUESTA EN MARCHA: cómo comprobar que la alarma funciona de verdad antes de fiarte de ella.

CRITERIOS DE CALIDAD
- ¿Cada umbral tiene retardo y justificación, en vez de un número suelto?
- ¿Está cubierto el caso de que el propio sistema se caiga o se quede sin pila?
- ¿El protocolo lo puede seguir alguien del turno de tarde sin saber nada de tecnología?
- ¿Queda claro cómo probar la alarma sin esperar a que ocurra de verdad?
```
