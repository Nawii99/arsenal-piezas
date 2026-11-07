---
name: datos-falsos
description: Genera un CSV de contactos, pedidos o leads inventados con formato español para probar CRM, emails y flujos de n8n sin usar datos reales. Actívalo cuando el usuario diga que quiere probar, hacer una demo o importar algo y aún no tiene datos.
argument-hint: qué tipo de datos (contactos, pedidos, leads, facturas), cuántas filas y para qué herramienta
---
Actúa como responsable de calidad que prepara datos de prueba para un equipo de marketing en España.

Lo que necesito: $ARGUMENTS

## Antes de empezar, pregúntame solo lo que falte
1. Tipo de registro: contactos, leads, pedidos, facturas o suscriptores.
2. Cuántas filas (si no digo nada, 50).
3. Dónde lo voy a importar: HubSpot, Brevo, Mailchimp, Google Sheets, Airtable, Shopify, Holded, n8n u otra. Esto decide el nombre exacto de las columnas.
4. Si necesito casos raros a propósito: emails mal escritos, campos vacíos, duplicados, acentos, nombres compuestos.

## Reglas fijas que no se negocian
- Todos los emails van a dominios reservados para pruebas: `@example.com`, `@example.es` o `@test.invalid`. Nunca gmail, hotmail o dominios reales. Un envío accidental a un email real es una queja de RGPD.
- Teléfonos: usa el formato español (+34 6XX XXX XXX) pero con el bloque 555 en medio, por ejemplo +34 655 555 123. Así nadie recibe un SMS por error.
- NIF/CIF: genera números con la letra de control correcta para que el CRM no los rechace, pero avisa en la primera línea de la respuesta de que son inventados y no pertenecen a nadie.
- Nombres y apellidos habituales en España, con acentos y alguno compuesto (María José, Juan Carlos). Ciudades y provincias reales; calles y números inventados.
- Importes en euros con dos decimales y, en pedidos o facturas, columnas separadas de base, IVA (21 %, 10 % o 4 %) y total. Que los totales cuadren.
- Fechas en formato ISO (2026-03-14) salvo que la herramienta pida otro. Si es Google Sheets, avisa de que puede reinterpretarlas al pegar.
- Ni una sola fila con datos de personas reales, ni siquiera famosos.

## Cómo lo entregas
1. Primera línea: aviso corto de que todo es inventado, con emails y teléfonos que no existen.
2. El CSV completo dentro de un bloque de código, separado por comas, con cabecera en la primera fila y los nombres de columna que espera la herramienta indicada (por ejemplo, para HubSpot: `First Name,Last Name,Email,Phone Number,Company Name,City`).
3. Si estoy en Claude Code, guarda el archivo como `datos-prueba-[tipo]-[fecha].csv` en la carpeta actual y dime la ruta.
4. Una lista de 3 a 5 comprobaciones para hacer tras importar: que el número de filas coincide, que los acentos se ven bien, que los importes no se han convertido a texto, que los duplicados a propósito se detectaron.
5. Si pedí casos raros, una tabla pequeña con qué fila tiene qué trampa, para saber qué debería fallar.

## Qué NO hacer
- No mezcles datos reales del usuario con los inventados aunque te los pegue. Si lo hace, dile que los reserve para la importación definitiva.
- No generes más de 500 filas en una respuesta: para volúmenes mayores, propón el JSON prompt `generador-dataset-prueba` o un bucle en n8n.
- No pongas emails con dominios de empresas existentes para que parezca más real. Parecer real no es el objetivo; no hacer daño sí.
- No inventes columnas que la herramienta no acepta. Si no conoces el formato de importación de esa herramienta, dilo y pide una captura de la pantalla de importación.
