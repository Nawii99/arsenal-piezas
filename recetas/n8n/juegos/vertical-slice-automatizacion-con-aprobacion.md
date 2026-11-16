# Vertical slice · Automatización con aprobación

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Receta para automatizar acotar una demostración jugable que pruebe la idea con validación, aprobación humana, registro y ruta de error.

## Cuándo usarla

Cuando el proceso de vertical slice se repita y el resultado siga necesitando una decisión humana.

## Cómo ganar dinero con ella

Implántala y mantenla para clientes como automatización auditable, con soporte y límites acordados.


## La receta, paso a paso

# Receta: ciclo de vertical slice

Objetivo: acotar una demostración jugable que pruebe la idea para equipo indie, manteniendo aprobación humana.

1. Disparador manual o formulario con situación, objetivo, plazo y restricciones.
2. Nodo de validación: rechaza entradas vacías, secretos y datos personales innecesarios.
3. Nodo de preparación: normaliza campos y añade identificador, fecha y versión.
4. Nodo de IA: usa el JSON prompt de vertical slice y exige salida JSON válida.
5. Nodo de control: comprueba campos obligatorios, enlaces y afirmaciones sin evidencia.
6. Nodo de aprobación humana: presenta bucle, contenido, activos, métricas y corte; no continúa sin aceptación.
7. Nodo de archivo: guarda entrada, versión, decisión y resultado en una carpeta o tabla con acceso limitado.
8. Nodo de aviso: notifica éxito o error sin incluir información sensible.

Prueba con un único caso ficticio. Define reintentos limitados, ruta de error, responsable y forma de desactivar el flujo. Nunca guardes claves en nodos o mensajes; usa el almacén de credenciales de n8n o Activepieces.
