---
name: stl-impresion-3d
description: "Prepara un modelo 3D para imprimirlo y venderlo como archivo: geometría estanca, grosor de pared, escala en milímetros, orientación, división de piezas con pasadores, tolerancias, soportes y verificación en el slicer, además de cómo empaquetar y licenciar la publicación. Úsala cuando el usuario quiera vender archivos 3D imprimibles o las impresiones de un modelo fallen."
---

# Modelo listo para imprimir y para vender

## Qué hace

Deja un modelo apto para impresión 3D y empaquetado como producto digital: mallas sanas, grosores que aguantan, piezas partidas con encaje, y la ficha con las instrucciones que espera el comprador.

## Cuándo se activa

Cuando el usuario habla de imprimir en 3D, de STL, de resina o FDM, de vender miniaturas, de Cults, MyMiniFactory, Printables o de un Patreon de archivos.

## Qué preguntar

1. ¿Resina o filamento? Cambian los grosores mínimos y el detalle posible.
2. Tamaño final de la pieza en milímetros.
3. ¿Se vende el archivo o imprimes tú por encargo?
4. ¿La pieza es decorativa o funcional (encaja, gira, soporta peso)?
5. ¿Volumen de impresión de la máquina objetivo?

## Método

### 1. Salud de la malla

- La malla tiene que ser cerrada y sólida: sin agujeros, sin bordes sueltos, sin caras invertidas, sin geometría interna atrapada, sin caras que se cruzan entre sí.
- Une los trozos que deban ser un solo sólido con una operación booleana real, no dejándolos solapados sin más: hay laminadores que lo perdonan y otros que no.
- Elimina vértices dobles y caras de área cero.
- Comprueba la orientación de normales: todas hacia fuera.

### 2. Escala y unidades

El estándar en impresión es el milímetro. Un fallo clásico es exportar un modelo hecho en metros y que aparezca como una pieza de 0,05 mm. Fija el tamaño real y mide una referencia concreta (altura total, diámetro de una base) antes de exportar.

### 3. Grosores mínimos

- FDM: paredes de al menos 1,2 mm si tienen que aguantar algo; nunca por debajo de 0,8 mm.
- Resina: se puede bajar bastante más, pero por debajo de medio milímetro las piezas finas se rompen al despegar del soporte.
- Detalles en relieve (letras, texturas): que sobresalgan al menos dos o tres capas o no se verán.
- Piezas colgantes y antenas finas se rompen en el transporte y al limpiar: engórdalas o hazlas piezas aparte.

### 4. Orientación y voladizos

- Los voladizos por encima de unos 45 grados necesitan soporte en FDM.
- Orienta buscando que la cara más visible quede lo mejor posible y que las capas no corten la pieza por su punto más débil.
- En resina, evita ventosas y planos horizontales grandes contra la plataforma: hueca y añade agujeros de drenaje.

### 5. Partir en piezas

- Si la pieza no cabe en la máquina o tiene voladizos imposibles, córtala. Corta por líneas naturales del diseño (una junta, un cinturón, un cambio de material).
- Añade pines y agujeros para el encaje. Tolerancia habitual entre macho y hembra: alrededor de 0,2 mm de holgura; ajústala tras una prueba real.
- Numera las piezas y entrega un esquema de montaje.

### 6. Formatos y comprobación

- Exporta STL binario, y si puedes también 3MF, que guarda unidades y color.
- Pasa el archivo por un laminador y revisa: avisos de malla, capas huérfanas, islas flotantes, tiempo estimado.
- Imprime al menos una prueba antes de vender el archivo. Vender algo que no has impreso es la vía rápida a las reseñas malas.

### 7. Empaquetar como producto

- Incluye: versión sin soportes, versión presoportada si es resina, versión partida y versión entera, y las piezas por separado.
- Ficha con dimensiones en mm, número de piezas, ajustes recomendados (altura de capa, relleno), y fotos de la impresión real, no solo el render.
- Licencia clara: uso personal por defecto y licencia comercial aparte si permites que impriman para vender.

## Formato de la respuesta

1. Diagnóstico del modelo: errores de malla encontrados y cómo se arreglan.
2. Tabla de grosores por zona con el mínimo recomendado según tecnología.
3. Plan de corte de piezas y esquema de pines con tolerancias.
4. Orientación recomendada y dónde harán falta soportes.
5. Lista exacta de archivos a incluir en el paquete.
6. Texto de la ficha de venta con datos técnicos y licencia.

## Errores típicos

- Exportar en metros o en pulgadas por error.
- Paredes de 0,3 mm que en la pantalla se ven perfectas y en la mano se deshacen.
- Piezas con interior sólido: tardan horas y gastan material sin motivo.
- No dejar agujero de drenaje en una pieza hueca de resina.
- Vender un archivo que nunca se ha impreso.

## Avisos honestos

- No todos los modelos bonitos son imprimibles: a veces la corrección implica cambiar el diseño, no solo ajustes.
- Si el modelo se parece a un personaje con derechos, no lo puedes vender aunque lo hayas modelado tú.
