# configurador-3d-para-negocio…

**Tipo:** JSON prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Define y presupuesta un visor o configurador 3D para un negocio: que producto, que opciones, peso del modelo y como se integra en su web.

## Qué es y qué hace

JSON prompt que define y deja listo para presupuestar un visor o configurador 3D de producto. Entran producto, opciones y web del cliente; sale el alcance, el peso del modelo, la integración web y los datos que pedir al negocio. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el JSON en un chat de IA
2. Rellena los [corchetes] tras la reunión con el negocio
3. Revisa el alcance resultante
4. Presenta el presupuesto al cliente

## Cuándo usarla

Úsalo cuando quieras vender 3D a negocios reales (muebles, cocinas, joyeria, rotulacion, reformas) y necesites concretar el servicio antes de dar precio.

## Cómo ganar dinero con ella

Es un servicio que un negocio local entiende y paga, porque reduce dudas y devoluciones; se cobra por producto configurado y admite mantenimiento mensual.

- Visores 3D de producto para carpinterías y tiendas de muebles…
- Configuradores para joyería y rotulación…
- Propuesta de 3D en la web de negocios locales…

**Precio orientativo:** 300–1200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Definir el alcance tecnico y comercial de un visor o configurador 3D para el producto de un negocio, y dejarlo listo para presupuestar",
  "contexto": {
    "quien_lo_usa": "Persona sin perfil tecnico que sabe modelar o generar 3D y quiere venderlo como servicio a comercios",
    "cliente_tipo": "Mueble a medida, cocinas, joyeria, rotulacion, mobiliario urbano, reformas, productos personalizables",
    "momento": "Tras la primera reunion con el negocio y antes de dar un precio"
  },
  "entradas": {
    "negocio": "[TIPO Y QUE VENDE]",
    "producto_a_configurar": "[PIEZA CONCRETA]",
    "opciones_que_pide": "[MEDIDAS, ACABADOS, COLORES, MODULOS, GRABADOS]",
    "donde_va": "[SU WEB EN WORDPRESS / SHOPIFY / PAGINA SUELTA / TABLET EN TIENDA]",
    "material_de_partida": "[FOTOS / PLANOS / MEDIDAS / NADA]",
    "objetivo_del_cliente": "[VENDER MAS / REDUCIR DUDAS Y LLAMADAS / DEJAR DE HACER PRESUPUESTOS A MANO]"
  },
  "conocimiento_del_oficio": {
    "la_trampa_del_alcance": "Configurar todo es un proyecto imposible. Se empieza por un producto y de tres a cinco opciones, las que mas dudas generan en la tienda",
    "peso": "El modelo web debe ir en formato GLB comprimido y, como referencia, por debajo de 5 MB para que cargue en movil con datos",
    "como_se_hacen_las_variantes": "Una sola malla y cambio de material o de textura, no un modelo distinto por color: multiplica el peso y el trabajo",
    "medidas": "Si el producto cambia de tamaño, se hace con escalado por partes y no deformando toda la pieza, o los detalles se estiran",
    "luz": "En web se usa un HDRI ligero y sombra de contacto falsa; sombras dinamicas completas matan el rendimiento en movil",
    "lo_que_convierte": "Que al final del configurador haya una accion: pedir presupuesto con la configuracion escrita, no un boton bonito sin salida",
    "integracion": "Se entrega como bloque incrustado en su web; hay que saber quien la mantiene y quien tiene las claves antes de prometer nada",
    "modelo_de_cobro": "Precio por producto configurado, mas alta unica de la integracion, mas cuota opcional de mantenimiento y de nuevas variantes"
  },
  "pasos": [
    "1. Averiguar que tres preguntas hacen mas los clientes del negocio antes de comprar",
    "2. Elegir un solo producto piloto y limitar las opciones a esas dudas",
    "3. Definir la lista de variantes concreta: materiales, colores y medidas exactas",
    "4. Comprobar el material de partida y decidir si hay que modelar, escanear o partir de fotos",
    "5. Fijar el presupuesto tecnico: peso del archivo, resolucion de texturas y tiempo de carga objetivo",
    "6. Definir el flujo de pantalla y la accion final con los datos que se envian al negocio",
    "7. Preparar el plan de integracion segun la plataforma web del cliente",
    "8. Montar el presupuesto por fases y una prueba pequeña de bajo riesgo"
  ],
  "errores_tipicos": [
    "Aceptar configurar el catalogo entero por un precio cerrado",
    "Entregar un modelo de 60 MB que en movil no carga",
    "Hacer un modelo por cada color y multiplicar el mantenimiento",
    "No pactar quien toca la web del cliente y quedarse bloqueado semanas",
    "Olvidar que el configurador tiene que terminar en una peticion de presupuesto"
  ],
  "restricciones": [
    "Nada de tecnologia que el cliente no pueda mantener",
    "Todo dato tecnico con numero: megas, segundos de carga, numero de variantes",
    "No prometas aumento de ventas: habla de dudas resueltas y de tiempo ahorrado"
  ],
  "formato_salida": {
    "1_producto_piloto": "Que se configura y por que ese",
    "2_matriz_de_variantes": "Opcion | valores | como se resuelve tecnicamente",
    "3_presupuesto_tecnico": "Peso, texturas, triangulos y tiempo de carga objetivo",
    "4_flujo": "Pantallas y accion final con los campos que se envian",
    "5_plan_de_integracion": "Pasos y quien hace cada cosa",
    "6_presupuesto": "Fases, precios, plazo y opcion de mantenimiento"
  },
  "criterios_calidad": [
    "El alcance cabe en una prueba de un solo producto",
    "Cada variante tiene una solucion tecnica concreta y no multiplica archivos",
    "Hay un objetivo de peso y de segundos de carga en movil
```
