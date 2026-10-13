# Informe post-incidencia sin buscar culpables…

**Tipo:** JSON prompt · **Área:** Negocio · **Licencia:** CC BY 4.0

Saca el informe de lo que pasó: cronología, causa real, por qué se detectó tarde y qué hay que cambiar con fecha y responsable.

## Cómo usarla

1. Reconstruye la cronología con horas
2. Separa la causa de los apaños
3. Redacta la versión interna y la de cliente
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando ya has apagado el fuego y quieres que no se repita, o cuando un cliente grande te pide explicaciones por escrito.

## Cómo ganar dinero con ella

Convierte un mal día en mejoras concretas y te da un documento que sostiene la relación con clientes que se plantean irse.

- Informe post-incidencia para empresas que dan servicio a clientes con contrato.
- Plantilla de revisión de incidencias para equipos técnicos pequeños.
- Análisis de causa raíz para una tienda online con fallos de pedidos.

**Precio orientativo:** 60–150 € por informe. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Redactar el informe posterior a una incidencia, con cronología, causa raíz, impacto y plan de acciones, en versión interna y versión para cliente",
  "contexto": {
    "empresa": "[NOMBRE DE TU EMPRESA]",
    "incidencia": "[NOMBRE CORTO Y FECHA]",
    "equipo_implicado": "[ROLES, NO NOMBRES PROPIOS]",
    "cliente_destinatario": "[SI VA A UN CLIENTE CONCRETO, QUIÉN Y QUÉ CONTRATO TIENE]"
  },
  "entradas": {
    "cronologia": "[HORAS Y HECHOS: CUÁNDO EMPEZÓ, CUÁNDO SE DETECTÓ, QUÉ SE HIZO, CUÁNDO SE RESOLVIÓ]",
    "que_fallo": "[LO QUE SE SABE DE LA CAUSA]",
    "impacto": "[CLIENTES AFECTADOS, PEDIDOS, DINERO, TIEMPO SIN SERVICIO]",
    "como_se_detecto": "[LO VIO UN CLIENTE, UNA ALARMA, UN COMPAÑERO]",
    "apaños_aplicados": "[QUÉ SE HIZO PARA SALIR DEL PASO]"
  },
  "pasos": [
    "Reconstruye la cronología en tres tiempos: inicio real del fallo, momento de detección y momento de resolución",
    "Calcula el hueco entre inicio y detección y trátalo como un problema propio, no como un detalle",
    "Busca la causa raíz preguntando por qué cinco veces sobre el hecho, nunca sobre la persona",
    "Separa causa raíz, causas que la facilitaron y lo que solo agravó el impacto",
    "Lista lo que funcionó bien, para no romperlo al arreglar lo demás",
    "Propón acciones divididas en evitar que vuelva a pasar, detectarlo antes y reducir el daño si vuelve",
    "Pon a cada acción responsable, fecha y señal de que está hecha",
    "Genera la versión para cliente: más corta, sin trapos sucios internos y sin excusas"
  ],
  "restricciones": [
    "Prohibido escribir error humano como causa raíz: describe qué permitió que ese error llegara al cliente",
    "Sin nombres propios de empleados en ninguna de las dos versiones",
    "No inventes datos de impacto: si no los tienes, escribe pendiente de medir",
    "Máximo 5 acciones, priorizadas; más acciones es no hacer ninguna"
  ],
  "formato_salida": {
    "version_interna": ["Resumen en 5 líneas", "Cronología en tabla", "Impacto medido", "Causa raíz y causas facilitadoras", "Qué funcionó bien", "Tabla de acciones con responsable, fecha y señal de hecho"],
    "version_cliente": ["Qué pasó", "Cómo te afectó", "Qué hemos hecho", "Qué cambiamos para que no se repita", "Compensación o siguiente paso, si procede"],
    "limite": "Versión interna máx 2 páginas, versión cliente máx 350 palabras"
  },
  "criterios_calidad": [
    "La causa raíz explica también por qué no se detectó antes",
    "Cada acción se puede comprobar: alguien puede decir sí está hecha o no",
    "La versión al cliente no contiene n
```
