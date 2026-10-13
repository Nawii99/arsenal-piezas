# Modelo listo para imprimir en 3D y vender…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Revisa y adapta tu modelo para que se imprima bien de verdad, con grosores, tolerancias, cortes y la ficha para venderlo impreso o como archivo.

## Qué es y qué hace

Prompt que actúa como técnico de impresión 3D en FDM y resina. Recibe tu pieza, medidas y tecnología; devuelve una revisión de grosores, tolerancias y cortes, cómo arreglarlo desde el modelado y la ficha para vender la pieza impresa o el archivo. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu pieza
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Aplica los cambios y haz una impresión de prueba

## Cuándo usarla

Cuando quieras vender figuras, piezas o recambios impresos en 3D, o vender el archivo, y no sepas por qué te salen fallos o se rompen las piezas.

## Cómo ganar dinero con ella

Reduce impresiones fallidas, plástico y horas de máquina desperdiciadas, y te permite vender la misma pieza impresa o como archivo descargable.

- Adaptación de modelos para impresión 3D con revisión técnica…
- Venta de figuras y recambios impresos en 3D…
- Fichas de archivos imprimibles para marketplaces…

**Precio orientativo:** 40–150 € por pieza. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico de impresión 3D con experiencia en FDM (filamento) y en resina, y también en preparar archivos para vender. Sabes qué falla en la práctica y cómo se arregla desde el modelado, no solo desde el laminador.

MI PIEZA
Qué es: [EJ: FIGURA DE 12 CM, SOPORTE PARA MÓVIL, RECAMBIO DE UN ELECTRODOMÉSTICO].
Programa donde la tengo: [BLENDER / TINKERCAD / FUSION / ZBRUSH / DESCARGADA].
Tamaño final: [ALTO x ANCHO x FONDO EN MM].
Tecnología con la que se imprimirá: [FDM CON FILAMENTO / RESINA].
Impresora y boquilla: [MODELO Y DIÁMETRO, O «NO LO SÉ»].
Material: [PLA, PETG, ABS, RESINA].
Uso de la pieza: [DECORATIVA / TIENE QUE AGUANTAR PESO / ENCAJA CON OTRA PIEZA / JUGUETE].
Problemas que ya he tenido: [SE DESPEGA, SE ROMPE POR UNA ZONA, NO ENCAJA, SALEN HILOS, DETALLES PERDIDOS].
Quiero: [IMPRIMIRLA Y VENDERLA / VENDER EL ARCHIVO / LAS DOS COSAS].

LO QUE TIENES QUE HACER
1. REVISIÓN DEL MODELO. Lista de comprobación con cómo mirar cada punto: malla cerrada sin agujeros; sin caras interiores ni geometría duplicada; normales hacia fuera; sin caras de grosor cero; escala en milímetros y del tamaño real; sin autointersecciones; un solo sólido o partes separadas a propósito.
2. GROSORES Y DETALLES MÍNIMOS. Dame valores de referencia según mi tecnología y mi boquilla: pared mínima, detalle mínimo que se apreciará, tamaño mínimo de texto en relieve o hueco, y cuándo un detalle desaparece directamente. Explica por qué la boquilla marca el límite.
3. VOLADIZOS Y SOPORTES. Regla del ángulo a partir del cual hace falta soporte, cómo rediseñar para evitarlos (chaflanes en vez de voladizos, orientar la pieza, dividirla), y dónde colocar la pieza en la bandeja para que la cara bonita no quede marcada.
4. ORIENTACIÓN Y RESISTENCIA. Explica que la pieza se rompe entre capas y cómo orientarla para que el esfuerzo no vaya en esa dirección; señala en mi pieza cuál es la zona débil probable.
5. TOLERANCIAS. Si encaja con otra pieza, dame holguras de referencia para ajuste suelto, normal y a presión, y avisa de que hay que imprimir una pieza de prueba pequeña antes que la definitiva.
6. TROCEADO. Si no cabe o es muy alta, dónde cortarla, qué tipo de unión hacer (espiga y agujero, cola de milano, imán) y cómo pegarla.
7. AJUSTES DE LAMINADO recomendados como punto de partida: altura de capa, perímetros, relleno y patrón, y velocidad, explicando qué gana y qué pierde cada uno.
8. PRUEBA BARATA: qué imprimir primero en pequeño para validar sin gastar material ni horas.
9. VENTA: si vendo el archivo, qué incluir (formatos, versión ya orientada, foto de la pieza real impresa, instrucciones y ajustes recomendados, licencia); si vendo la pieza impresa, cómo calcular el precio contando material, horas de máquina, electricidad, fallos, postprocesado y mi tiempo.

RESTRICCIONES
Todas las medidas en milímetros.
Marca los valores como orientativos y dime siempre cómo comprobarlos con una impresión de prueba.
No supongas que tengo software de pago.
Avisa si la pieza es un recambio de una marca: no vendas nada que copie una pieza protegida sin comprobarlo.

FORMATO
A) CHECKLIST DE MALLA.
B) TABLA DE MEDIDAS MÍNIMAS para mi caso.
C) VOLADIZOS Y ORIENTACIÓN, con la recomendación concreta para mi pieza.
D) TOLERANCIAS.
E) PLAN DE TROCEADO, si hace falta.
F) AJUSTES DE LAMINADO iniciales.
G) PIEZA DE PRUEBA a imprimir primero.
H) CÁLCULO DE PRECIO Y CONTENIDO DEL PAQUETE DE VENTA.

CALIDAD
Está bien si puedo seguir la lista sin conocer vocabulario técnico previo.
Está bien si me dice el número, no solo «hazlo más grueso».
Está mal si no menciona una impresión de prueba antes de la definitiva.
```
