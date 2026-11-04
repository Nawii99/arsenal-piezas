---
name: plan-entrenamiento-vendible
description: Genera un plan de entrenamiento personalizado y listo para entregar a un cliente de pago, a partir de sus datos y su objetivo. Se activa cuando pides crear un plan nuevo o renovar uno existente.
---

## Que hace
Convierte los datos de un cliente (objetivo, nivel, dias disponibles, material, lesiones) en un plan de entrenamiento de 4 a 12 semanas, en un documento limpio que puedes entregar tal cual como producto de pago.

## Antes de empezar, pregunta
- Objetivo: perder grasa, ganar musculo, rendimiento, salud general.
- Nivel: principiante, intermedio, avanzado, y desde cuando entrena.
- Dias y minutos disponibles por semana.
- Material: gimnasio completo, casa con mancuernas, o sin material.
- Lesiones o limitaciones medicas actuales.
- Cuantas semanas quieres que dure el plan.

## Paso a paso
1. Con esos datos, elige una estructura de reparto semanal (full body, torso-pierna, push-pull-legs) segun los dias disponibles.
2. Elige ejercicios que se puedan hacer con el material que tiene el cliente. Si hay lesion, evita el gesto que la agrava y anotalo.
3. Define series, repeticiones e intensidad por bloque de semanas, con progresion de carga cada 1-2 semanas.
4. Anade una semana de descarga (menos volumen) cada 4-6 semanas si el plan es largo.
5. Redacta el plan en un documento con: portada con el nombre del cliente y las fechas, tabla semanal por dia, notas de ejecucion de cada ejercicio, y una pagina de seguimiento donde el cliente apunta lo que levanta.

## Que devolver
Un documento en Markdown listo para pasar a PDF, con el nombre '[CLIENTE] - Plan de entrenamiento'. Incluye siempre una nota final: 'Este plan no sustituye la valoracion de un medico o fisioterapeuta si hay lesion o dolor.'

## Que NO hacer
- No inventes patologias ni des diagnosticos medicos.
- No prescribas cargas exactas en kilos sin que el cliente las haya probado antes: da un rango o pide que empiece ligero la primera semana.
- No copies el mismo plan para clientes distintos: cambia algo real (ejercicios, orden, volumen) o no vale como producto de pago.
- No reutilices un plan con lesion sin marcar claramente que ejercicios se sustituyen.
