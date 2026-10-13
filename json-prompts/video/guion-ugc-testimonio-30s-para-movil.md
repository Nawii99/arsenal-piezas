# Guion UGC testimonio 30s para móvil…

**Tipo:** JSON prompt · **Área:** Vídeo · **Licencia:** CC BY 4.0

Te da tres guiones de anuncio en formato testimonio, con lo que dice la persona y lo que se ve en cada plano, listos para grabar con el móvil.

## Qué es y qué hace

JSON prompt que escribe tres guiones UGC de 30 segundos en formato testimonio, con lo que dice la persona y lo que se ve en cada plano, pensados para grabar con móvil en vertical. Entra marca, producto y cliente; salen tres versiones listas. Úsalo en cualquier chat de IA.

## Cómo usarla

1. Copia el JSON
2. Rellena los [corchetes] con marca, producto y precio
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Elige un guion y grábalo con el móvil

## Cuándo usarla

Úsalo cuando quieras lanzar tu primer anuncio en TikTok o Reels y no tengas ni productora ni presupuesto, solo un móvil y alguien que hable a cámara.

## Cómo ganar dinero con ella

Sustituye a un guionista y evita grabar vídeos que no venden, porque el guion ya lleva gancho, prueba y llamada a la acción.

- Guiones UGC para tiendas online y marcas de producto…
- Servicio de contenido testimonial para anuncios de pymes…
- Packs de guiones para creadores que graban para marcas…

**Precio orientativo:** 50–150 € por pieza. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Escribir 3 guiones distintos de anuncio UGC en formato testimonio de 30 segundos, pensados para grabarse con un movil en vertical",
  "contexto": {
    "marca": "[NOMBRE DE TU MARCA]",
    "producto": "[PRODUCTO O SERVICIO Y QUE HACE, EN UNA FRASE]",
    "precio": "[PRECIO O RANGO DE PRECIO]",
    "cliente_ideal": "[EDAD, SITUACION Y QUE LE PREOCUPA]",
    "problema_principal": "[EL PROBLEMA QUE RESUELVE]",
    "prueba_real": "[RESULTADO, GARANTIA O DATO QUE PUEDES DEMOSTRAR]",
    "plataforma": "[TIKTOK / REELS / SHORTS]",
    "objetivo": "[VENTAS EN WEB / CONTACTOS / VISITAS A TIENDA]"
  },
  "reglas_de_oficio": [
    "El segundo 0 empieza con la persona hablando y el producto ya en pantalla: nada de logo, intro ni musica sola",
    "El gancho es una frase hablada, no un rotulo: se entiende aunque el movil este en silencio gracias al subtitulo",
    "Habla en primera persona y de una sola persona: yo, mi, me paso esto",
    "Cada plano dura entre 2 y 4 segundos y cambia el encuadre o la accion para que no canse",
    "El producto se ve en uso al menos en dos planos, no solo sobre la mesa",
    "La llamada a la accion es una sola y concreta, con el nombre de la marca dicho en voz alta"
  ],
  "estructura_por_guion": [
    "Gancho (0-3 s): frase que nombra el problema o un resultado sorprendente",
    "Contexto (3-8 s): quien soy y por que me importaba",
    "Giro (8-14 s): como encontre el producto y que dudaba",
    "Demostracion (14-24 s): que hago con el, paso a paso, en imagen",
    "Resultado y prueba (24-27 s): que cambio, con el dato concreto",
    "Llamada a la accion (27-30 s): que tiene que hacer quien mira"
  ],
  "variedad_obligatoria": "Guion 1 en tono cercano y de confesion, guion 2 comparando el antes y el despues, guion 3 respondiendo a una objecion tipica del cliente",
  "restricciones": [
    "Nada de promesas de resultados garantizados ni afirmaciones de salud sin respaldo",
    "Sin palabras de folleto: revolucionario, unico, lider del mercado",
    "Frases habladas de maximo 12 palabras para que se puedan decir de una tirada",
    "Espanol de Espana, tuteando, sin anglicismos innecesarios"
  ],
  "formato_salida": {
    "tipo": "Una tabla por guion",
    "columnas": ["Plano", "Segundos", "Que se ve (encuadre y accion)", "Que se dice (texto literal)", "Rotulo en pantalla"],
    "extras_por_guion": ["Titulo del guion", "Angulo que prueba", "Lista de material necesario para grabarlo", "3 variantes solo del gancho"]
  },
  "criterios_calidad": [
    "Se puede grabar en una tarde con un movil y luz natural",
    "Se entiend
```
