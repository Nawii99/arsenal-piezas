# preparar-modelo-impresion-3d…

**Tipo:** JSON prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Revisa y adapta un modelo 3D para que se imprima bien: grosores, tolerancias, orientacion, soportes y coste real por pieza.

## Qué es y qué hace

JSON prompt que revisa un modelo 3D para impresión y calcula su coste real. Entran modelo, impresora y material; sale un listado de grosores, tolerancias, orientación y soportes a corregir, más el coste por pieza. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el JSON en un chat de IA
2. Rellena los [corchetes] con tu modelo e impresora
3. Aplica los arreglos antes de laminar
4. Usa el coste calculado para fijar precio

## Cuándo usarla

Úsalo cuando vayas a imprimir un modelo propio o de un cliente, o cuando alguien te pida precio por imprimir una pieza y no sepas si va a salir bien.

## Cómo ganar dinero con ella

Cada impresion fallida son horas de maquina y material tirados; ademas te da el coste real por pieza para poder poner precio y no trabajar a perdida.

- Servicio de impresión 3D bajo pedido con presupuesto claro…
- Preparación de modelos de clientes para imprimir…
- Cálculo de coste real por pieza para vender impresiones…

**Precio orientativo:** 15–60 € por pieza. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Adaptar un modelo 3D para impresion y calcular el coste real de la pieza, indicando los arreglos necesarios antes de mandarla a imprimir",
  "contexto": {
    "quien_lo_usa": "Persona que imprime piezas para vender o para clientes y no viene del mundo tecnico",
    "momento": "Antes de laminar el modelo y darle a imprimir",
    "riesgo": "Una impresion larga fallida se descubre horas despues y se paga con material y tiempo"
  },
  "entradas": {
    "modelo": "[QUE ES Y DE DONDE SALE: DESCARGADO, HECHO POR TI, ESCANEADO, GENERADO CON IA]",
    "tecnologia": "[FDM FILAMENTO / RESINA SLA]",
    "material": "[PLA / PETG / ABS / RESINA ESTANDAR / OTRO]",
    "tamaño_final": "[ALTO x ANCHO x FONDO EN MILIMETROS]",
    "uso_de_la_pieza": "[DECORATIVA / FUNCIONAL CON CARGA / ENCAJA CON OTRA PIEZA / JUGUETE]",
    "impresora": "[MODELO Y VOLUMEN DE IMPRESION]",
    "precio_material": "[EUROS POR KILO O POR LITRO]"
  },
  "conocimiento_del_oficio": {
    "unidades": "Los laminadores trabajan en milimetros. Un modelo pensado en metros entra como una mota o como un edificio",
    "estanqueidad": "La malla tiene que ser cerrada y sin caras invertidas ni bordes sueltos; una malla abierta produce paredes fantasma o piezas huecas",
    "grosor_minimo": "En FDM no bajar de 1,2 mm en paredes que aguantan y 0,8 mm en detalles; en resina se puede bajar a 0,6 mm, pero por debajo se rompe al despegar",
    "tolerancias": "Para que dos piezas encajen deja de 0,2 a 0,4 mm de holgura en FDM y de 0,1 a 0,2 mm en resina. Sin holgura, no entran",
    "voladizos": "Por encima de 45 grados hacen falta soportes. Reorientar la pieza suele ahorrar mas soportes que cualquier ajuste",
    "orientacion_y_fuerza": "La pieza se parte por las capas: coloca el eje que va a sufrir tension en horizontal respecto a la mesa",
    "detalle_fino": "Textos y relieves por debajo de 0,5 mm de profundidad desaparecen en FDM",
    "coste_real": "Coste igual a gramos por precio del kilo, mas horas de impresora por un coste hora de amortizacion y luz, mas material de soporte, mas tiempo de postprocesado, mas un porcentaje de piezas fallidas"
  },
  "pasos": [
    "1. Comprobar unidades y escalar a milimetros con las medidas finales pedidas",
    "2. Revisar que la malla este cerrada y reparar agujeros y caras invertidas",
    "3. Medir grosores minimos y engordar lo que no llegue al minimo del material elegido",
    "4. Revisar encajes y aplicar la holgura correspondiente",
    "5. Elegir orientacion en la mesa segun voladizos, marcas de soporte y direccion de la fuerza",
    "6. Decidir si conviene cortar la pieza en partes y como se uniran",
    "7. Estimar gramos, tiempo y coste, y proponer precio de venta si aplica",
    "8. Listar los ajustes de laminado de partida: altura de capa, perimetros, relleno y soportes"
  ],
  "errores_tipicos": [
    "Escalar un modelo bonito sin revisar que los detalles finos ya no imprimen a ese tamaño",
    "Imprimir un encaje al milimetro exacto y que no entre",
    "Colocar la cara buena contra los soportes y arruinar el acabado",
    "Olvidar el tiempo de lijado y pintado al poner precio",
    "Mandar 14 horas de impresion sin haber hecho una prueba pequeña de la zona critica"
  ],
  "restricciones": [
    "No des recomendaciones de seguridad para piezas que soporten peso sobre personas",
    "Todas las medidas en milimetros y con numero concreto",
    "Si falta un dato para calcular coste, pidelo antes de estimar"
  ],
  "formato_salida": {
    "1_veredicto": "IMPRIMIBLE, IMPRIMIBLE CON ARREGLOS o NO IMPRIMIBLE ASI",
    "2_arreglos": "Tabla: problema | zona | arreglo | milimetros",
    "3_orientacion": "Como colocarla y por que, mas donde iran las marcas de soporte",
    "4_ajustes_laminado": "Altura de capa, perimetros, relleno, soportes y adherencia",
    "5_coste": "Gramos, horas, coste de material, coste de maquina y coste total por pieza",
    "6_prueba_rapida": "Que trozo imprimir primero y cuanto tarda"
  },
  "criterios_calidad": [
    "Cada arreglo lleva una medida concreta en milimetros",
    "La orientacion propuesta justifica el acabado y la resistencia",
    "El coste incluye fallos y postprocesado, no solo
```
