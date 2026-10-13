# Evaluar si un aparato importado se puede vender o insta…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Revisa el marcado, la documentación y los riesgos de un dispositivo IoT comprado fuera antes de instalarlo en casa de un cliente o revenderlo.

## Qué es y qué hace

Prompt que revisa marcado CE, documentación y riesgos de un dispositivo IoT comprado fuera antes de instalarlo o revenderlo. Señala sellos dudosos y obligaciones de quien revende; no sustituye a un abogado. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con producto y documentación
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Que lo revise un profesional

## Cuándo usarla

Antes de comprar un lote de dispositivos baratos por internet para revender, o antes de instalar en un cliente algo que llegó sin manual en condiciones.

## Cómo ganar dinero con ella

Evita comprar lotes que no puedes vender legalmente, devoluciones y responsabilidades por instalar algo que no debía instalarse.

- Revisión de conformidad de productos importados…
- Checklist de documentación para pequeños importadores…
- Asesoría previa a instalar equipos de origen dudoso…

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como asesor de producto para pequeños importadores y para instaladores en España. Conoces el marcado CE y las declaraciones de conformidad, los sellos falsos, la seguridad eléctrica y las obligaciones que caen sobre quien revende. No eres abogado y lo dices, pero sabes exactamente qué hay que mirar y qué hay que pedir al proveedor.

EL PRODUCTO
- Qué es: [ENCHUFE INTELIGENTE / CÁMARA / SENSOR / CERRADURA / RELÉ / FUENTE DE ALIMENTACIÓN / TIRA LED / OTRO]
- Marca y modelo: [NOMBRE], vendedor: [MARKETPLACE O PROVEEDOR]
- Precio unitario y cantidad que pienso comprar: [PRECIO Y UNIDADES]
- Uso previsto: [PARA MÍ / PARA INSTALARLO EN CLIENTES / PARA REVENDERLO EN MI TIENDA]
- ¿Va conectado a 230 V o a bajo voltaje?: [RESPUESTA]
- Documentación que trae: [MANUAL EN QUÉ IDIOMAS, DECLARACIÓN DE CONFORMIDAD, FICHA TÉCNICA, NADA]
- Marcas impresas en el aparato y en la caja: [COPIA LO QUE PONE, INCLUIDOS SÍMBOLOS]
- Enlace o texto de la ficha del vendedor: [PEGA AQUÍ EL TEXTO]

QUÉ TIENES QUE ANALIZAR
1. Marcado y documentación: qué símbolos deberían aparecer en un producto así vendido en la Unión Europea, qué significa cada uno en cristiano, y qué papeles debo exigirle al proveedor antes de pagar. Explícame qué es una declaración de conformidad y por qué una foto de un sello en la caja no es lo mismo.
2. Señales de alarma en la ficha del vendedor: potencias imposibles para el tamaño del aparato, capacidades de batería exageradas, enchufe de otro país, ausencia de nombre y dirección del fabricante o del importador, manual solo en inglés o en chino, y fotos reutilizadas de otro producto.
3. Riesgo eléctrico concreto de este tipo de producto: dónde suelen recortar los fabricantes baratos (separación entre la parte de 230 V y la de baja tensión, calidad del relé frente a la corriente que dice soportar, fuentes sin aislamiento) y cómo detectarlo sin laboratorio: peso, calidad del plástico, olor, holgura, tornillos, si la carcasa se abre.
4. Riesgo de dependencia y de datos: si el aparato exige una app concreta, dónde acaban los datos, si la cámara sube vídeo a servidores fuera, y qué le tengo que contar al cliente si instalo esto en su casa.
5. Qué obligaciones me caen encima según lo que vaya a hacer con él: usarlo yo, instalarlo en clientes o revenderlo. Explícame de forma sencilla la diferencia entre ser usuario, instalador o distribuidor, y menciona la garantía legal al consumidor en España y las obligaciones de residuos de aparatos eléctricos.
6. Alternativas: si el análisis sale mal, dime qué buscar en su lugar y con qué criterios de compra, sin nombrarme marcas caras por defecto.
7. Un veredicto claro: comprar, comprar solo para uso propio, pedir documentación antes, o no comprar.

RESTRICCIONES
- Deja claro en una línea que esto es orientación práctica y no asesoramiento legal, y recomiéndame confirmar con mi gestor o con un organismo oficial antes de importar en cantidad.
- No afirmes que un producto concreto es ilegal: analiza señales y di qué habría que verificar.
- No inventes normativas ni números de directiva si no estás seguro: es mejor describir la obligación en palabras.
- Sé especialmente duro con todo lo que se enchufa a 230 V y con las cámaras.

FORMATO DE LA RESPUESTA
A) 'Veredicto' en una línea, con nivel de riesgo bajo, medio o alto.
B) Tabla 'Qué debe llevar': elemento a comprobar | ¿lo tiene? | cómo se comprueba | qué pasa si falta.
C) 'Señales de alarma detectadas' en la ficha que te he pasado.
D) 'Preguntas exactas al proveedor', listas para copiar y pegar en el chat del marketplace, en inglés y en castellano.
E) 'Si lo instalo en un cliente': qué le tengo que decir y qué debería quedar por escrito.
F) 'Alternativas y criterios de compra'.

CRITERIOS DE CALIDAD
- Las preguntas al proveedor deben ser tan concretas que un vendedor serio pueda contestarlas con un documento adjunto y uno malo se escaquee.
- Cada señal de alarma debe explicar la consecuencia práctica, no solo decir que es sospechosa.
- Si el producto va enchufado a la red y no hay documentación, el veredicto no puede ser 'comprar'.
```
