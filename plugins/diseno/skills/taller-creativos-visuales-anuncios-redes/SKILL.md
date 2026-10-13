---
name: taller-creativos-visuales-anuncios-redes
description: Prepara y refina creativos visuales (posts, stories, banners, anuncios, miniaturas) a partir de un brief, con varias direcciones, formatos listos y aviso de lo legal que debe revisar una persona. Úsala cuando necesites piezas gráficas para una campaña o para redes.
---

# Taller de creativos visuales para anuncios y redes

## Qué hace
Convierte un brief en unas pocas piezas visuales distintas y bien pensadas, en los formatos que necesites, y las mejora por rondas. También sirve para retocar una pieza que ya tienes.

## Qué puede y qué no puede hacer Claude Code aquí
- Salvo que tengas conectado un generador de imágenes, no dibuja fotos ni ilustraciones realistas.
- Sí maqueta piezas con texto, formas, colores y logo (en HTML o SVG) y las exporta a PNG o JPG.
- Sí escribe briefs y prompts precisos para el generador de imágenes que uses tú.
- Sí mejora una pieza existente: jerarquía, contraste, longitud de los textos, variantes.
- Si hay un generador conectado (por MCP), lo usará solo con tu permiso.
- Para exportar a imagen puede hacer falta instalar un navegador sin pantalla. Claude Code te pedirá permiso. Acepta solo si entiendes qué instala.

## Antes de empezar, pregunta
1. ¿Cuál es el objetivo único? Vender algo, captar contactos, anunciar un evento, ganar seguidores.
2. ¿Dónde se verá? Instagram, Facebook, LinkedIn, TikTok, anuncios de Google, web, email, impreso. Los tamaños y las zonas libres cambian: confírmalos en la guía actual de cada plataforma.
3. ¿A quién va dirigido y qué debe pensar o hacer al verlo?
4. ¿Cuál es el mensaje principal, en una frase, y cuál es la llamada a la acción?
5. ¿Qué marca hay? Logo, colores en código HEX, tipografías, ejemplos de lo que te gusta y de lo que no.
6. ¿Qué textos son obligatorios? Precio, condiciones de la oferta, fechas, avisos legales, bases de un sorteo.
7. ¿Qué material propio hay? Fotos de producto, fotos de personas y permiso de quienes salen en ellas.
8. Si son anuncios de pago: ¿quién los lanza y con qué presupuesto? Esta skill no los lanza.

## Paso a paso
1. Resume el brief en 5 líneas y espera tu visto bueno.
2. Propón 3 direcciones creativas realmente distintas, no 3 versiones de lo mismo. De cada una: idea, tono, composición y por qué encaja con el público. Elige tú una o dos.
3. Haz una primera versión de cada dirección elegida en todos los formatos acordados. Nombra los archivos así: marca_campaña_formato_v1.
4. Revisa cada pieza con esta lista:
  - ¿Se entiende en 2 segundos y en la pantalla de un móvil?
  - ¿Hay un solo mensaje y una sola acción?
  - ¿El texto contrasta bien con el fondo? Como referencia, una relación de contraste de 4,5 a 1.
  - ¿Quedan márgenes para que la interfaz de la app no tape el texto?
  - ¿Se ve el logo? ¿Falta algún aviso legal?
5. Refina por rondas. Pide cambios concretos («título más corto», «botón más visible»), uno o dos por ronda. Guarda cada versión como v2, v3. No sobrescribas.
6. Si quieres probar qué funciona, prepara 3 o 4 variantes que cambien una sola cosa: el titular, la imagen o la llamada a la acción. Si cambias todo a la vez, no sabrás qué ha pesado. Cuánto tiempo y dinero hace falta para sacar conclusiones lo decides tú con los datos de la plataforma.
7. Entrega una carpeta con las piezas finales y una ficha con textos, colores, tipografías y el origen y la licencia de cada imagen y fuente.

## Qué devolver, con este formato
- Carpeta con las piezas finales en PNG o JPG, más el archivo editable (HTML o SVG).
- Tabla con: pieza, formato, texto usado, imágenes y su licencia.
- Si se piden prompts para un generador de imágenes: un prompt por pieza, con la advertencia de que el resultado no es predecible y hay que revisarlo.
- Lista de lo que debe revisar una persona (ver más abajo).

## Qué NO hacer
- No prometer resultados («subirá las ventas») ni dar cifras de conversión.
- No inventar ofertas, precios, descuentos, premios, opiniones ni logotipos de terceros.
- No copiar el estilo reconocible de una marca, un artista o una campaña concreta, ni sus textos.
- No usar el rostro de personas reales (clientes, famosos, empleados) sin permiso por escrito.
- No mostrar con imágenes hechas con IA un producto o un resultado que no es real: sería publicidad engañosa.
- No usar imágenes de internet sin licencia ni tipografías de pago sin licencia.
- No generar decenas de variantes. Pocas, distintas y pensadas.
- No lanzar ni pagar anuncios, ni publicar en redes. Eso lo haces tú.

## Qué revisa una persona antes de publicar
- Precios: al consumidor se le muestran con IVA incluido.
- Rebajas: si tachas un precio anterior, la norma europea pide que sea el más bajo de los últimos 30 días. Confírmalo con tu asesor.
- Publicidad con influencers: debe indicarse que es publicidad.
- Imágenes generadas o retocadas con IA que parezcan reales: puede haber obligación de indicarlo, y las plataformas tienen sus propias reglas. Comprueba las vigentes.
- Sorteos: tienen que tener bases.
- Promesas sobre salud, dinero o resultados: solo con prueba que tengas tú.
- La persona titular de la marca da el visto bueno final.

## Cómo activarla
Guarda este texto como SKILL.md dentro de una carpeta con el nombre de la skill, en .claude/skills/ de tu proyecto. Luego escribe en Claude Code: «Preparemos creativos para [CAMPAÑA] en [FORMATOS]».
