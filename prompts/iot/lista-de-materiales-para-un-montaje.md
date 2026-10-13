# Lista de materiales para un montaje…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Convierte una idea de aparato conectado en la lista de compra exacta, el esquema de conexiones explicado y el orden de montaje para alguien sin electrónica.

## Qué es y qué hace

Prompt que convierte una idea de aparato conectado con placa tipo ESP32 en lista de compra, esquema de conexiones explicado y orden de montaje para alguien sin electrónica. Entra qué detecta, qué acciona y dónde va; sale el kit completo. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con función, lugar y presupuesto
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Compra y monta en el orden indicado

## Cuándo usarla

Úsalo cuando quieras montar un cacharro propio con una placa tipo ESP32 y no sepas qué comprar, cómo se conecta ni por dónde empezar.

## Cómo ganar dinero con ella

Evita comprar componentes incompatibles o que se queman al primer intento, y te permite ofrecer soluciones a medida en vez de revender aparatos de catálogo.

- Diseño de kits de sensores a medida para particulares…
- Montaje de prototipos conectados para pequeños negocios…
- Listas de materiales y guías de montaje para talleres…

**Precio orientativo:** 60–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico de electrónica que prepara kits para gente sin formación técnica. Escribes como si el que monta no supiera lo que es una resistencia, pero sin tratarle como a un tonto. Tu obsesión es que nada se queme y que se monte a la primera.
Lo que quiero construir:
- Qué debe hacer el aparato, en una frase: [FUNCIÓN]
- Qué tiene que detectar o medir: [MAGNITUD: TEMPERATURA, PRESENCIA, PUERTA ABIERTA, AGUA, CONSUMO, DISTANCIA, ETC.]
- Qué tiene que accionar, si acciona algo: [RELÉ, ZUMBADOR, LUZ, MOTOR, NADA]
- Dónde va instalado: [INTERIOR / EXTERIOR / HÚMEDO / NEVERA / CUADRO / A LA INTEMPERIE]
- Cómo se alimenta: [ENCHUFE / PILAS / BATERÍA / NO LO SÉ]
- A dónde tienen que llegar los datos: [MÓVIL / PANEL EN CASA / HOJA DE CÁLCULO / AVISO POR MENSAJE]
- Presupuesto por unidad: [EUROS] y cuántas unidades: [NÚMERO]
- Mi nivel: [NUNCA HE SOLDADO / HE SOLDADO ALGO / ME DEFIENDO]
Tu tarea: darme la lista de materiales cerrada, el esquema de conexión explicado con palabras y el orden de montaje probado.
Trabaja así:
PASO 1. Valida la idea. Dime si esto se resuelve mejor con un aparato ya fabricado y certificado; si es así, dímelo antes de que gaste tiempo. Si merece la pena hacerlo, sigue.
PASO 2. Elige el cerebro y justifícalo: placa con wifi integrado, placa de muy bajo consumo para pilas, o placa con conexión móvil. Explica en una frase por qué esa y no otra para mi caso.
PASO 3. Elige el sensor con criterio y explícame las diferencias que importan: rango de medida, precisión real frente a la que dice el anuncio, si necesita estar en contacto o no, si soporta humedad, cada cuánto puede medir, y si necesita algún componente extra obligatorio como una resistencia entre dos patas.
PASO 4. Lista de materiales completa en tabla: Componente | Para qué sirve | Cuántos | Qué debo mirar al comprarlo | Precio orientativo. Incluye lo que todo el mundo olvida: cable adecuado, conectores, caja con protección contra polvo y agua, prensaestopas, fusible, y fuente de alimentación con margen.
PASO 5. Avisos de tensión y compatibilidad, explicados sin jerga: que las patas de la placa trabajan a 3,3 voltios y no aguantan 5 voltios directos, que hay patas que no se pueden usar libremente porque la placa las mira al arrancar, que si mides con la placa mientras hay wifi encendido algunas entradas analógicas no funcionan, y que la corriente de un motor o un relé no debe salir de la placa sino de su propia fuente.
PASO 6. Esquema de conexión descrito en texto, pata por pata: «el cable rojo del sensor va a la pata de 3,3 V», etc. Añade una tabla de conexiones para imprimir y tachar.
PASO 7. Orden de montaje en pasos, con un punto de comprobación después de cada uno: qué debe pasar si va bien y qué significa si no pasa.
PASO 8. Pruebas antes de cerrar la caja: qué mido, con qué, y qué valores son normales.
PASO 9. Los cinco fallos que más se dan en este montaje concreto y cómo se reconocen.
Restricciones:
- Si hay 230 V de por medio, no me des instrucciones de cableado: dime que use un módulo enchufable certificado o que lo haga un electricista.
- Nada de código todavía: esto es la parte física.
- No supongas que tengo soldador; si hace falta soldar, dilo y ofrece alternativa sin soldadura.
- Precios orientativos, sin prometer nada.
Formato de la respuesta:
1) VEREDICTO: merece la pena hacerlo o cómpralo hecho, con el motivo.
2) LISTA DE MATERIALES en tabla.
3) TABLA DE CONEXIONES para imprimir.
4) ORDEN DE MONTAJE numerado con puntos de comprobación.
5) PRUEBAS FINALES con valores esperados.
6) FALLOS TÍPICOS: síntoma, causa y arreglo.
Criterios de calidad: está bien si puedo hacer la compra entera sin volver a preguntar, si sé qué pata va a qué sitio sin interpretar un dibujo, y si cada paso tiene una forma de saber si ha salido bien.
```
