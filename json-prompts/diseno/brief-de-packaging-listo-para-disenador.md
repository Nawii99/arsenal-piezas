# Brief de packaging listo para diseñador…

**Tipo:** JSON prompt · **Área:** Diseño · **Licencia:** CC BY 4.0

Convierte tu producto en un briefing de envase completo: público, posicionamiento, mensaje del frontal, materiales y lo que sí y no se puede tocar.

## Qué es y qué hace

JSON prompt con rol de director de arte que redacta el brief completo de un envase: público, posicionamiento, mensaje del frontal, materiales y qué se puede o no modificar, para que un diseñador o una IA trabaje sin preguntar más. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el JSON
2. Rellena empresa, producto y formato
3. Pégalo en la IA
4. Entrega el brief al diseñador

## Cuándo usarla

Úsalo cuando vayas a encargar el diseño de un envase (o a hacerlo con IA) y quieras evitar diez rondas de correcciones por falta de información.

## Cómo ganar dinero con ella

Un brief cerrado reduce las rondas de cambios que te cobra el diseñador y evita rediseñar el envase después de haberlo impreso.

- Briefs de packaging para productores artesanos…
- Preparación de encargos de envase para diseñadores freelance…
- Servicio de definición de producto previo al diseño de etiqueta…

**Precio orientativo:** 60–180 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "rol": "Director de arte especializado en packaging de gran consumo, con experiencia en marcas pequeñas y tiradas cortas",
  "tarea": "Redactar el brief completo de packaging de un producto para que un disenador o una IA pueda disenar el envase sin volver a preguntar nada",
  "contexto": {
    "empresa": "[NOMBRE DE TU EMPRESA]",
    "producto_y_formato": "[PRODUCTO Y FORMATO: p. ej. crema facial 50 ml en tarro de vidrio]",
    "categoria": "[CATEGORIA: alimentacion, bebida, cosmetica, suplemento, textil, artesania]",
    "pvp": "[PRECIO DE VENTA AL PUBLICO]",
    "canal_de_venta": "[DONDE SE VENDE: tienda propia, supermercado, herbolario, Amazon, ferias]",
    "publico": "[A QUIEN SE LO VENDES: edad, situacion y que le preocupa]",
    "competidores": ["[COMPETIDOR 1]", "[COMPETIDOR 2]", "[COMPETIDOR 3]"],
    "posicionamiento": "[EN UNA FRASE: por que te compran a ti y no a ellos]",
    "presupuesto_impresion": "[BAJO, MEDIO O ALTO]",
    "elementos_fijos": "[LOGO, COLORES O TIPOGRAFIA QUE YA TIENES Y NO SE TOCAN]"
  },
  "pasos": [
    "Resumir en una frase que tiene que sentir alguien al ver el envase en el lineal o en una foto de movil",
    "Definir la jerarquia del frontal: que se lee primero, segundo y tercero, y con cuantas palabras",
    "Proponer paleta de color con justificacion de categoria y de diferenciacion frente a los competidores citados",
    "Proponer dos rutas tipograficas distintas y decir cual encaja mejor con el precio y el canal",
    "Decidir material y acabado coherentes con el presupuesto indicado, sin proponer troqueles caros si el presupuesto es bajo",
    "Listar todos los textos e iconos que deben caber en el envase, separando obligatorios y opcionales"
  ],
  "formato_salida": {
    "tipo": "documento por secciones con titulos, sin parrafos de mas de cuatro lineas",
    "secciones": ["Resumen en una frase", "Publico y momento de compra", "Mensaje del frontal por jerarquia", "Color y tipografia con justificacion", "Material, formato y acabados", "Inventario de textos e iconos", "Tres cosas que el disenador NO debe hacer", "Como sabremos que esta bien"]
  },
  "restricciones": [
    "Nada de adjetivos vacios tipo innovador o disruptivo: describe decisiones concretas",
    "Toda propuesta de color o tipografia va acompanada de un porque en una linea",
    "Si falta un dato clave, marcalo como PENDIENTE en vez de inventarlo"
  ],
  "criterios_calidad": [
    "El frontal se entiende en menos de tres segundos y a 30 cm de distancia",
    "El brief distingue el envase del de los competidores citados por algo mas que el color
```
