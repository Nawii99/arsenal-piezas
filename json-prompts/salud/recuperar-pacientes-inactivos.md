# recuperar-pacientes-inactivos…

**Tipo:** JSON prompt · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Crea la campaña para recuperar pacientes que no vuelven desde hace meses: a quién escribir, en qué orden y con qué mensaje según por qué se fueron.

## Qué es y qué hace

JSON prompt que diseña una campaña de reactivación de pacientes inactivos: segmenta por motivo de abandono, prepara el calendario de envíos y escribe los mensajes uno a uno. Se pega en cualquier chat de IA; por ejemplo, para quien lleva meses sin volver a una clínica.

## Cómo usarla

1. Copia el JSON
2. Rellena tipo de centro y listado
3. Pégalo en la IA
4. Envía por tandas y mide respuestas
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tienes una base de pacientes antiguos parada y quieres llenar agenda sin gastar en publicidad, o después de una temporada floja.

## Cómo ganar dinero con ella

Recuperar a alguien que ya te conoce cuesta mucho menos que captar nuevo, y una tanda de mensajes bien segmentada llena huecos de semanas flojas.

- Campañas de recuperación de pacientes para clínicas…
- Mensajes segmentados por WhatsApp para centros de estética…
- Servicio mensual de reactivación de clientes antiguos…

**Precio orientativo:** 120–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Disenar una campana de reactivacion de pacientes inactivos, con segmentacion por motivo de abandono, calendario de envios y mensajes escritos uno a uno",
  "contexto": {
    "tipo_de_centro": "[TIPO DE CENTRO Y SERVICIOS QUE OFRECE]",
    "ciudad_y_zona": "[CIUDAD Y BARRIO]",
    "base_de_datos": "[NUMERO APROXIMADO DE PACIENTES EN FICHA Y DESDE QUE ANO]",
    "inactivo_es": "[CUANTOS MESES SIN VENIR CONSIDERAS INACTIVO: 6, 9, 12]",
    "capacidad_libre": "[CUANTAS SESIONES LIBRES PUEDES ATENDER POR SEMANA]",
    "canal_principal": "[WHATSAPP BUSINESS, EMAIL, SMS O TELEFONO]",
    "consentimiento": "[TIENES CONSENTIMIENTO PARA COMUNICACIONES COMERCIALES: SI, NO, SOLO DE ALGUNOS]"
  },
  "entradas": {
    "servicios_gancho": "[UNO O DOS SERVICIOS CON LOS QUE QUIERES QUE VUELVAN]",
    "motivos_habituales_de_abandono": "[LO QUE SUELES OIR: PRECIO, YA ESTOY BIEN, FALTA DE TIEMPO, CAMBIO DE CENTRO]",
    "algo_nuevo": "[NOVEDAD REAL DEL CENTRO: NUEVO PROFESIONAL, NUEVO HORARIO, NUEVA TECNICA O 'NINGUNA']"
  },
  "pasos": [
    "1. Separa la base en cuatro segmentos: dejo el tratamiento a medias, termino y no volvio, vino una sola vez, y contacto que nunca llego a venir",
    "2. Descarta de la campana a quien pidio no ser contactado, a quien tuvo una mala experiencia sin resolver y a quien no tenga consentimiento valido",
    "3. Fija el objetivo en numero de citas que puedes absorber, no en numero de mensajes enviados, y calcula cuantos contactos vas a tocar por semana",
    "4. Para cada segmento escribe un mensaje distinto con esta estructura: reconocer el tiempo pasado, un motivo creible del contacto, una propuesta concreta y una pregunta cerrada",
    "5. Prohibe el gancho de miedo y sustituyelo por utilidad: revision de mantenimiento, retomar el plan pendiente o una franja horaria nueva",
    "6. Define la secuencia por contacto: mensaje 1, silencio de 4 dias, mensaje 2 mas corto, y cierre educado con puerta abierta; nunca mas de tres toques",
    "7. Escribe el guion de la llamada para los casos que merecen telefono: apertura, verificacion de con quien hablas, propuesta y despedida si dice que no",
    "8. Prepara la respuesta a las cinco objeciones mas probables: 'ya estoy bien', 'me pilla caro', 'ahora no tengo tiempo', 'voy a otro sitio', 'me lo pienso'",
    "9. Define como se mide: contactados, respuestas, citas agendadas, citas cumplidas y facturacion atribuida a la tanda"
  ],
  "restricciones": [
    "Nunca menciones en el mensaje el problema de salud, el diagnostico ni el tratamiento concreto de esa persona",
    "Nada de alarmar ni de sugerir que su salud empeorara si no vuelve",
    "Nada de descuentos agresivos por defecto; solo si el usuario lo indica y con condiciones claras y fecha limite",
    "Incluye siempre una forma facil de decir que no y de pedir la baja de comunicaciones",
    "Ajusta el volumen de envio a la capacidad real de la agenda"
  ],
  "errores_tipicos": [
    "Mandar el mismo mensaje a toda la base y quemar la lista entera de una tacada",
    "Escribir como si el paciente hubiese hecho algo mal por no volver",
    "Lanzar la campana sin tener huecos libres y acabar citando a tres semanas vista",
    "Olvidar marcar en la ficha quien ya fue contactado y repetirle el mensaje al mes siguiente",
    "Usar datos de salud como gancho comercial"
  ],
  "formato_salida": {
    "bloque_1": "Tabla de segmentos con criterio, numero estimado, gancho y canal",
    "bloque_2": "Los mensajes escritos, agrupados por segmento y numerados como toque 1 y toque 2",
    "bloque_3": "Guion de llamada de 60 segundos con las pausas marcadas",
    "bloque_4": "Tabla de objeciones con la respuesta y la salida elegante",
    "bloque_5": "Calendario de la campana por semanas con volumen de envio",
    "bloque_6": "Tabla de metricas a rellenar",
    "idioma": "Espanol de Espana, tuteando salvo que se indique lo contrario"
  },
  "criterios_calidad": [
    "Cada segmento tiene un mensaje que solo tiene sentido para ese segmento",
    "Ningun mensaje contiene informacion clinica ni promesas de resultado",
    "El volumen semanal cabe en la agenda declarada",
    "Todos los mensajes se leen en menos de 20
```
