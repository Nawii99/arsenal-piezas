# Análisis de un email sospechoso de phishing…

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Analiza un correo dudoso y te dice si es fraude, en qué señales se ve, qué hacer si alguien ya picó y cómo bloquear los siguientes.

## Qué es y qué hace

JSON prompt que analiza un correo sospechoso a partir del remitente, cuerpo, cabeceras, enlaces y adjuntos. Da un veredicto en la primera línea, las señales que lo respaldan, qué hacer si alguien ya hizo clic o pagó y cómo bloquear los siguientes. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el JSON en tu IA
2. Rellena remitente, asunto y pega cuerpo, cabeceras y enlaces sin pulsarlos
3. Indica si alguien ya actuó
4. Sigue las acciones y reporta el fraude
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando recibes o te reenvían un correo raro (factura, aviso del banco, cambio de cuenta de un proveedor) y hay que decidir en minutos.

## Cómo ganar dinero con ella

Evita transferencias a cuentas falsas y contraseñas entregadas al atacante, que es el fraude más caro y más común en pymes.

- Servicio de revisión de correos sospechosos para pymes…
- Formación práctica en fraude del CEO y suplantación de proveedores…
- Protocolo de verificación de facturas y cambios de cuenta…

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Analizar un correo sospechoso, dictaminar si es phishing o fraude y decir que hacer a continuacion",
  "rol": "Analista de seguridad del correo especializado en fraude al CEO y en suplantacion de proveedores",
  "entradas": {
    "remitente_visible": "[NOMBRE Y DIRECCION QUE SE VE EN EL CORREO]",
    "asunto": "[ASUNTO DEL CORREO]",
    "cuerpo": "[PEGA AQUI EL TEXTO COMPLETO DEL CORREO]",
    "cabeceras": "[PEGA AQUI LAS CABECERAS SI SABES SACARLAS: MENU DEL CORREO, MOSTRAR ORIGINAL]",
    "enlaces": "[COPIA LAS DIRECCIONES DE LOS ENLACES SIN PULSARLOS]",
    "adjuntos": "[NOMBRE Y EXTENSION DE LOS ADJUNTOS, NO LOS ABRAS]",
    "contexto": "[ESPERABAS ESTE CORREO? CONOCES AL REMITENTE? HAY UNA FACTURA REAL PENDIENTE?]",
    "ya_ha_pasado_algo": "[NADIE HA HECHO NADA / ALGUIEN HIZO CLIC / ALGUIEN PUSO SU CONTRASENA / SE HA PAGADO]"
  },
  "instrucciones": [
    "Da un veredicto en la primera linea: fraude casi seguro, sospechoso o probablemente legitimo, con un porcentaje de confianza",
    "Enumera las senales encontradas y explicalas: dominio parecido al real, respuesta que va a otra direccion, urgencia, cambio de numero de cuenta, saludo generico, errores de idioma, enlace que no coincide con el texto",
    "Si hay cabeceras, revisa SPF, DKIM y DMARC y traduce el resultado a lenguaje llano",
    "Detecta el patron concreto: suplantacion de banco, de la Agencia Tributaria, de un directivo, de un proveedor pidiendo cambio de cuenta, o entrega de malware",
    "Da instrucciones distintas segun lo que ya haya pasado, empezando por el caso mas grave que aplique",
    "Si se ha pagado, indica la secuencia: llamar al banco para intentar retrocesion, denunciar y avisar al proveedor real por telefono conocido",
    "Cierra con dos medidas preventivas concretas para que no vuelva a colar"
  ],
  "restricciones": [
    "No abras, no resumas ni recomiendes abrir adjuntos o enlaces",
    "No afirmes que es legitimo si faltan las cabeceras: dilo como probabilidad y explica que falta",
    "Nada de listas genericas de consejos: todo referido a este correo concreto"
  ],
  "formato_salida": {
    "tipo": "Ficha de analisis en markdown",
    "secciones": ["Veredicto y confianza", "Senales detectadas", "Que tipo de fraude es", "Que hacer ahora segun tu caso", "Que guardar como prueba", "Como evitar el siguiente"]
  },
  "criterios_calidad": [
    "Cada senal cita el trozo concreto del correo que la demuestra",
    "Las acciones estan ordenadas por urgencia real",
    "Se entiende sin saber nada de correo electronico"
  ],
  "tono": "Tajante cuando hay evi
```
