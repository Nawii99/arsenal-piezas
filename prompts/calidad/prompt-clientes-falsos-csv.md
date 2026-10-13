# Tabla de clientes falsos para probar sin tocar datos reales…

**Tipo:** Prompt · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Pega este prompt en Claude y te devuelve una tabla de clientes inventados, con formato español, lista para cargar en una hoja de cálculo o un CRM de prueba.

## Qué es y qué hace

Es un prompt que genera una tabla de clientes inventados en CSV con separador de punto y coma, para probar un CRM, un flujo de n8n o una plantilla de correo sin tocar datos reales. Entra el número de filas y lo que vas a probar; sale datos ficticios listos para cargar en una hoja. Se usa en cualquier IA.

## Cómo usarla

1. Indica número de filas y para qué las usas
2. Pega el prompt en tu IA
3. Carga el CSV en tu hoja o CRM de prueba

## Cuándo usarla

Necesitas probar un CRM, un flujo de n8n o una plantilla de email y no quieres usar clientes reales. Pegas el prompt y tienes la tabla.

## Cómo ganar dinero con ella

Prepara datos de prueba para pymes y freelancers que estrenan un CRM o una automatización, y cobra por juego de datos o por entorno de pruebas a [TU PRECIO]. Los datos son inventados, así que el cliente puede enseñarlos sin riesgo.

- Datos de prueba para flujos de n8n de autónomos que los van a vender, por lote…
- Juegos de datos de ejemplo para demos de software, por demo…
- Plantillas de datos ficticios para formar a equipos, por sesión…

## El prompt (cópialo entero)

```text
Necesito datos de prueba. No son personas reales y no deben parecerlo: los voy a usar para probar [QUÉ VAS A PROBAR: UN CRM, UN FLUJO DE N8N, UNA PLANTILLA DE EMAIL].
Genera [NÚMERO, POR EJEMPLO 25] filas de clientes inventados en formato CSV, separados por punto y coma (;), que es lo que abre bien Excel en español.
Columnas, en este orden: id, nombre, apellidos, email, telefono, ciudad, provincia, codigo_postal, empresa, sector, fecha_alta, importe_ultimo_pedido_eur, estado.
Reglas para que sea obviamente falso pero útil:
- Emails siempre con dominio example.com o example.es. Nunca gmail, hotmail ni dominios de empresas reales.
- Teléfonos con el formato 600 000 0XX, cambiando solo las dos últimas cifras. No inventes números que puedan pertenecer a alguien.
- Nombres y apellidos habituales en España, mezclando también algunos de origen latinoamericano y europeo. No uses nombres de personajes famosos.
- Ciudades y provincias reales de España, con su código postal correcto (5 cifras, Madrid empieza por 28, Barcelona por 08, etc.).
- Empresas inventadas con nombres que no existan: añade la palabra Pruebas o Demo al nombre, por ejemplo "Talleres Demo Norte SL".
- Importes en euros con dos decimales y coma decimal (1250,50), entre 20 y 5000. Que haya variedad: algunos pequeños, algunos grandes, ninguno redondo siempre.
- Fechas en formato DD/MM/AAAA, repartidas entre [FECHA INICIO] y [FECHA FIN].
- Estado: uno de estos valores exactos: activo, inactivo, moroso, baja. Que aproximadamente el 60% sean activo.
Incluye a propósito 3 filas con problemas típicos para probar que mi sistema los detecta: una con el email sin arroba, una con el teléfono vacío y una con el código postal de 4 cifras. Marca cuáles son al final, fuera del CSV.
Devuelve primero el CSV dentro de un bloque de código, sin texto antes. Después, en 3 líneas, dime qué filas son las defectuosas y por qué.
No añadas columnas que no te he pedido. No inventes DNI ni números de cuenta bancaria aunque parezcan falsos.
```
