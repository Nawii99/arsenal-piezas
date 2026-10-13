---
name: elegir-y-revisar-graficos
description: Elige el tipo de gráfico o tabla que mejor cuenta unos datos concretos según el mensaje y el público, y revisa gráficos ya hechos (ejes, colores, títulos, lectura en móvil). Úsala cuando el usuario tenga números que presentar o un gráfico que no se entiende.
---

<!-- Instalación: guarda este archivo como .claude/skills/elegir-y-revisar-graficos/SKILL.md dentro de tu carpeta de trabajo. -->

# Elige el gráfico y revisa el que ya tienes

## Qué hace
Dos trabajos. Primero, decidir qué gráfico o tabla cuenta mejor unos datos. Segundo, revisar un gráfico que ya existe y decir qué confunde, qué engaña y cómo arreglarlo.
El usuario no programa. No le des código. Dale los pasos, con clics, en la herramienta que use (Excel, Google Sheets, Looker Studio, Power BI, Canva o PowerPoint).

## Qué preguntar antes de empezar
Pregunta lo que falte, en bloques cortos.
1. Qué quiere que piense o haga la persona que lo vea. Una frase.
2. Quién lo verá (cliente, inversor, equipo, jefe) y qué sabe ya del tema.
3. Dónde se verá. Diapositiva, PDF, correo, pantalla del móvil o impreso en blanco y negro.
4. Qué datos hay. Que los pegue, que indique el archivo o que diga dónde están (con un conector a Google Sheets o Drive puedes leerlos). De cada columna, qué es, en qué unidad y de qué periodo.
5. Con qué herramienta lo va a montar.
6. Si ya hay un gráfico, que pase la imagen o una captura. Tú puedes mirar imágenes.
7. Si entre los datos hay algo que no debe salir de la empresa (clientes con nombre, sueldos, salud). Si lo hay, trabaja con cifras agregadas o anonimizadas.

## Paso a paso
1. Escribe el mensaje en una frase que sea una conclusión, por ejemplo «Las ventas online superan a las de la tienda desde mayo». Si no hay conclusión clara, dilo y propón qué mirar.
2. Revisa los datos antes de dibujar. Valores vacíos, periodos incompletos (el último mes a medias), unidades mezcladas (euros con y sin IVA), duplicados. Avisa de lo que veas. No lo arregles en silencio.
3. Clasifica la pregunta y elige gráfico.
- Cómo cambia algo con el tiempo. Líneas.
- Comparar categorías. Barras, horizontales si los nombres son largos, ordenadas de mayor a menor.
- Qué parte del total es cada cosa. Una sola barra dividida o una tabla. El gráfico circular, solo con dos o tres trozos.
- Cómo se reparten unos valores, por ejemplo los importes de los pedidos. Histograma.
- Si dos cosas suben o bajan juntas. Puntos (dispersión), sin decir que una causa la otra.
- Valores exactos o muchos datos con pocas cifras. Tabla, con la cifra importante resaltada.
- Un solo dato clave. Número grande con su comparación (mes pasado u objetivo).
4. Propón una opción principal y una alternativa. En una frase, por qué, y qué descartas y por qué.
5. Aplica reglas de diseño. Título que diga la conclusión y no solo el tema. Barras con el eje en cero. Un color de destaque y el resto en gris. Etiquetas pegadas a los datos mejor que una leyenda lejos. Unidades (euros, %) siempre. Fuente y fecha al pie. Si hay más de cuatro líneas, resalta una y deja el resto en gris.
6. Piensa en accesibilidad. No dependas solo del color (rojo y verde los confunde mucha gente), usa letra legible en móvil y buen contraste, y añade una frase que resuma el gráfico para quien no lo vea.
7. Si ya hay un gráfico, haz la revisión. Ordena los problemas por gravedad. Primero los que engañan (eje cortado en barras, 3D, dos ejes que sugieren una relación falsa, periodo elegido a conveniencia, porcentajes sin base). Después los que cuestan de leer (demasiados colores, leyenda lejos, decimales de más). Al final los estéticos. De cada uno, qué pasa, por qué importa y cómo se arregla en su herramienta.
8. Revisa las palabras. Si los datos solo muestran que dos cosas coinciden, no uses «causa», «gracias a» ni «provoca». Si la muestra es pequeña, dilo en el pie.

## Qué devolver y con qué formato
Markdown, con estos apartados y en este orden.
- El mensaje en una frase.
- Gráfico recomendado, alternativa y por qué.
- Pasos para montarlo en su herramienta.
- Título y pie sugeridos, con fuente y periodo.
- Si había un gráfico, la lista de problemas ordenada por gravedad, cada uno con su arreglo.
- Avisos sobre los datos.
- Lo que debe revisar una persona. Ver el apartado siguiente.

## Qué revisa una persona antes de enseñarlo
- Que las cifras coinciden con la contabilidad o con la fuente original. Si es para inversores, clientes o bancos, que las compruebe quien lleva las cuentas (gestoría o responsable financiero).
- Que el gráfico no exagera. Enseñar solo los datos que favorecen para conseguir una venta o una financiación puede acabar siendo engañoso, con consecuencias legales.
- Que no se ven nombres de clientes ni otros datos personales sin permiso.

## Qué NO hacer
- No inventes, estimes ni rellenes datos que faltan. Marca [FALTA].
- No cambies el gráfico para que el resultado parezca mejor. No cortes ejes, no cambies el periodo, no quites valores extremos sin decirlo.
- No uses 3D, ni gráficos circulares con muchos trozos, ni dos ejes salvo que no haya otra salida.
- No elijas un gráfico solo porque quede vistoso.
- No pegues en herramientas externas datos de clientes con nombre o datos personales sin permiso.
- No des código si el usuario no programa. Dale los pasos en su herramienta.
- No tomes decisiones de negocio. El gráfico enseña, la persona decide.
