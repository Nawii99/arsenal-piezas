# Política de copias 3-2-1 de tu base de datos…

**Tipo:** JSON prompt · **Área:** Datos · **Licencia:** CC BY 4.0

Te deja por escrito qué se copia, dónde, cada cuánto y cuánto se guarda, con el espacio y el coste estimado al año.

## Qué es y qué hace

JSON prompt para cualquier chat de IA que recibe los datos de tu base de datos (motor, tamaño, crecimiento, datos críticos, presupuesto) y devuelve una política de copias 3-2-1 por escrito: qué se copia, dónde, cada cuánto, retención y coste anual estimado. Ejemplo: una tienda con MySQL de 8 GB.

## Cómo usarla

1. Copia el JSON
2. Rellena los [corchetes] con tus datos
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Revisa el documento y guárdalo

## Cuándo usarla

Úsalo cuando tu negocio ya depende de una base de datos (pedidos, clientes, citas) y no tienes una política de copias escrita, solo lo que hace el hosting por defecto.

## Cómo ganar dinero con ella

Evita el gasto y el parón de reconstruir datos perdidos a mano, y te dice cuánto almacenamiento necesitas de verdad sin pagar de más.

- Redactar la política de copias de seguridad de pymes con tienda online o base de datos propia…
- Paquete de auditoría y documentación de backups para clínicas, gestorías o academias…
- Mantenimiento mensual que incluye revisar y actualizar la política de copias del cliente…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Diseñar la política de copias de seguridad de una base de datos aplicando la regla 3-2-1 y dejarla escrita como documento que cualquiera del equipo pueda seguir",
  "contexto": {
    "negocio": "[A QUÉ SE DEDICA TU NEGOCIO]",
    "base_de_datos": "[MySQL, PostgreSQL, SQL Server, MongoDB, SQLite O EL QUE USES]",
    "alojamiento": "[DÓNDE ESTÁ: hosting compartido, VPS, AWS RDS, servidor de la oficina...]",
    "tamano_actual_gb": "[TAMAÑO APROXIMADO EN GB]",
    "crecimiento_mensual": "[CUÁNTO CRECE AL MES EN GB O EN %]",
    "datos_que_no_puedes_perder": "[TABLAS O INFORMACIÓN CRÍTICA: pedidos, clientes, facturas...]",
    "quien_administra": "[TÚ, UNA PERSONA TÉCNICA O UNA EMPRESA EXTERNA]",
    "presupuesto_mensual": "[EUROS AL MES QUE PUEDES DEDICAR A ALMACENAMIENTO]"
  },
  "instrucciones": [
    "Explica la regla 3-2-1 en dos frases sin tecnicismos: 3 copias, 2 soportes distintos, 1 fuera de donde vive la base de datos",
    "Propón una política concreta con frecuencias: copia completa, copias diarias e histórico de transacciones si el motor indicado lo permite",
    "Para cada copia indica qué se copia, dónde se guarda, cada cuánto, cuánto tiempo se conserva y quién comprueba que se hizo",
    "Incluye al menos una copia en otro proveedor o inmutable, para que un ransomware o un borrado no se lleve también las copias",
    "Calcula el espacio total necesario a 12 meses con el tamaño y el crecimiento dados y estima el coste mensual aproximado",
    "Avisa de los fallos típicos: copias en el mismo servidor, copias que nunca se han restaurado, copias sin cifrar y contraseñas guardadas junto a la copia"
  ],
  "restricciones": [
    "No propongas herramientas de pago sin decir antes la alternativa gratuita equivalente",
    "Cada paso debe poder ejecutarlo alguien sin perfil técnico o encargarse con instrucciones claras",
    "No inventes funciones que el motor de base de datos indicado no tenga"
  ],
  "formato_salida": {
    "tipo": "documento en Markdown",
    "secciones": ["Resumen en 5 líneas", "Tabla de copias: qué, dónde, cuándo, retención y responsable", "Espacio y coste estimado a 12 meses", "Comprobación semanal", "Errores a evitar", "Primeros 3 pasos para ponerlo en marcha hoy"]
  },
  "criterios_calidad": [
    "La tabla cubre las tres copias de la regla 3-2-1 sin huecos",
    "Toda copia tiene responsable y periodo de conservación concretos",
    "El coste aparece en euros al mes y se explica de dónde sale",
    "Se indica cómo comprobar que una copia se puede restaurar de verdad"
  ],
  "tono": "directo, de compañero técnico
```
