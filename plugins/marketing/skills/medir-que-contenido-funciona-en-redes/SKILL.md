---
name: medir-que-contenido-funciona-en-redes
description: Analiza los datos de tus publicaciones en redes (exportaciones oficiales o datos recogidos con Apify) para decir qué formatos, temas y horas funcionan, qué repetir y qué probar, y calcula el retorno de una campaña solo si hay ingresos medibles. Úsala cuando publiques con regularidad y no sepas qué está funcionando.
---
# Analista de qué contenido funciona en redes
Qué hace: lee los datos de tus publicaciones, calcula las métricas con fórmulas a la vista y te dice qué patrones hay, cuánto te puedes fiar de ellos y qué probar el mes siguiente.
Qué no hace: no predice virales ni promete alcance. Cuenta lo que ha pasado en tus datos y con qué grado de confianza.
## De dónde salen los datos
- Primera opción: la exportación oficial de tu propia cuenta (estadísticas de Instagram, TikTok, LinkedIn, YouTube, Facebook...). Es tuya y es gratis.
- Segunda opción: datos públicos recogidos con Apify, una plataforma de pago por uso con un plan gratuito limitado (mira en su web el límite actual). Si la tienes conectada a Claude con un conector (MCP), puede lanzar la recogida; si no, la lanzas tú y le pasas el archivo.
- Cuentas de otros (la competencia): solo cifras agregadas de publicaciones públicas. Mira antes las condiciones de la red.
## Pregunta esto antes de empezar
1. ¿Qué cuentas y qué redes? ¿Son tuyas o de otros?
2. ¿Qué periodo y cuántas publicaciones hay? Con pocas (por ejemplo menos de 20) lo que salga es una pista, no una prueba.
3. ¿Qué objetivo tienes: alcance, interacción, visitas a la web, contactos o ventas?
4. ¿Cómo sabes qué ventas vienen de las redes? Enlaces con UTM, códigos de descuento, la pregunta «¿cómo nos conociste?». Si no hay nada de eso, no hay retorno que calcular.
5. ¿Hubo gasto en anuncios? Pide el gasto por campaña.
6. Si hay que recoger datos con Apify: ¿cuál es el gasto máximo que aceptas? Ponlo como límite en tu cuenta si tu plan lo permite, antes de lanzar nada.
## Paso a paso
1. Revisa el archivo: columnas, fechas, duplicados y publicaciones sin datos. Unifica el formato y clasifica cada pieza (vídeo, carrusel, imagen, texto).
2. Calcula con la fórmula escrita al lado de cada métrica:
  - Tasa de interacción = (me gusta + comentarios + compartidos + guardados) / alcance. Si la red no da alcance, usa seguidores y dilo.
  - Tasa de clics = clics / impresiones.
  - Coste por clic = gasto / clics. Coste por contacto = gasto / contactos conseguidos.
  - Retorno = (ingresos atribuidos - gasto) / gasto. Solo si los ingresos son medibles.
3. Compara con tu propia mediana, no con «medias del sector». Si no tienes datos de referencia, no te los inventes.
4. Agrupa por formato, tema, día y hora, longitud y primera frase (el gancho). Indica cuántas publicaciones hay en cada grupo. Con tres o menos por grupo, no saques conclusión.
5. Separa las excepciones. Un éxito aislado no es una estrategia: mira qué tuvo de distinto y si se puede repetir.
6. Conclusiones: tres cosas para repetir, tres para dejar y tres pruebas de 30 días (qué cambias, qué mides y cuándo decides).
7. A cada conclusión ponle confianza alta, media o baja, con el motivo.
8. Si el archivo es muy grande, procésalo con un script o con un subagente y enséñame solo el resumen.
## Qué devolver, en este orden
1. Resumen de cinco líneas.
2. Tabla de métricas por publicación y por grupo, con las fórmulas.
3. Patrones con su nivel de confianza.
4. Plan de pruebas a 30 días.
5. «Límites de estos datos»: qué falta, qué no se puede afirmar.
## Qué NO hacer
- No inventes métricas que no estén en los datos.
- No mezcles redes sin avisar: cada una mide a su manera.
- No digas «esto funciona porque...». Di «en tus datos coincide con...». Que algo coincida no prueba que sea la causa.
- No uses cifras del sector inventadas.
- No recojas datos de cuentas privadas ni te saltes inicios de sesión, límites o bloqueos. Las redes prohíben recoger datos en sus condiciones y puede acabar en un bloqueo de IP o de cuenta.
- No guardes nombres, fotos ni comentarios de personas. Con cuentas ajenas, solo cifras agregadas (RGPD).
- No lances recogidas grandes sin probar antes con una muestra pequeña y mirar lo que cuesta. Una recogida mal configurada puede gastar más de lo que esperas.
- No cambies presupuestos de anuncios ni publiques nada. Solo recomiendas.
## Qué revisa una persona antes de usar el resultado
- Tú o quien lleve la marca decide qué se hace con las conclusiones.
- Si el informe va a un cliente, compara las cifras con el panel original de cada red.
- Si hay datos de personas o decisiones con dinero, que lo vea la persona responsable de datos o de presupuesto.
## Instalación (una sola vez)
Guarda este texto en un archivo llamado SKILL.md dentro de la carpeta .claude/skills/medir-que-contenido-funciona-en-redes/ de tu proyecto, o en ~/.claude/skills/medir-que-contenido-funciona-en-redes/ para tenerla en todos tus proyectos. Normalmente también puedes lanzarla escribiendo / y ese nombre.
