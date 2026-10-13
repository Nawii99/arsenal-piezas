# Plan de baterías para sensores que no dan la lata…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Diseña la alimentación de los sensores inalámbricos de una instalación para no estar cambiando pilas cada dos meses ni quedarte ciego sin saberlo.

## Qué es y qué hace

Prompt que diseña la alimentación de sensores inalámbricos para no cambiar pilas cada dos meses ni quedarte ciego sin saberlo. Considera protocolo, intervalo de reporte y temperatura, y da números aproximados. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con sensores y protocolo
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Aplica los ajustes y vigila el nivel de batería

## Cuándo usarla

Cuando vayas a instalar sensores a pilas, o cuando ya estés harto de cambiar pilas y de sensores que se apagan sin avisar.

## Cómo ganar dinero con ella

Cada cambio de pila en casa de un cliente es un desplazamiento que no cobras: alargar la vida de las pilas es margen directo.

- Plan de baterías para instalaciones con muchos sensores…
- Alertas de batería baja para clientes de mantenimiento…

**Precio orientativo:** 50–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico de instalaciones inalámbricas con experiencia en consumo de sensores a pilas. Sabes que la vida de una pila depende mucho más del protocolo, del intervalo de reporte y de la temperatura que de la marca de la pila. Hablas claro y das números aproximados con honestidad.

LA INSTALACIÓN
- Sensores previstos o instalados: [LISTA: PUERTA/VENTANA, MOVIMIENTO, TEMPERATURA Y HUMEDAD, FUGA DE AGUA, BOTÓN, VIBRACIÓN, PRESENCIA, ETC.] con marca y modelo si lo sé: [MODELOS]
- Protocolo de cada uno: [ZIGBEE / Z-WAVE / WIFI / BLUETOOTH / LORA / NO LO SÉ]
- Tipo de pila que llevan: [CR2032 / CR2450 / AA / AAA / 18650 / OTRO]
- Dónde están colocados: [INTERIOR / EXTERIOR / GARAJE / CÁMARA FRÍA / TEJADO / SITIO DE DIFÍCIL ACCESO]
- Temperatura mínima del sitio en invierno: [GRADOS]
- Cuántos sensores en total: [NÚMERO]
- Cada cuánto me estoy quedando sin pila ahora: [RESPUESTA O 'AÚN NO INSTALADO']
- ¿Alguno vigila algo crítico?: [FUGA DE AGUA, ALARMA, FRÍO, ETC.]

QUÉ QUIERO QUE ME DES
1. Una explicación breve de por qué unos sensores duran años y otros meses: diferencia de consumo entre protocolos, sensores que solo hablan cuando pasa algo frente a sensores que reportan cada X minutos, y por qué un sensor a pilas por WiFi es casi siempre mala idea.
2. Para cada sensor de mi lista, una estimación honesta de duración con la pila que lleva, en meses, marcada claramente como estimación, y los tres factores que más la van a acortar en mi caso concreto.
3. El efecto del frío: cuánto se penaliza una pila de botón en un garaje o en el exterior en invierno, y qué química de pila aguanta mejor. Explica la diferencia entre alcalina y litio en AA y cuándo compensa pagar más.
4. Los ajustes que alargan la vida sin perder utilidad: subir el intervalo de reporte donde no importa la inmediatez, aumentar el umbral de cambio para que no reporte por variaciones mínimas, subir el tiempo de bloqueo de los detectores de movimiento, y desactivar la iluminación o el led de confirmación. Dime para cada sensor de mi lista qué ajuste concreto tocaría y qué gano.
5. Cuáles de mis sensores deberían ir directamente a corriente en vez de a pilas, y cómo hacerlo de forma limpia y barata.
6. El sistema de aviso de batería baja bien hecho: por qué el porcentaje que reportan estos sensores es poco fiable, qué umbral usar como aviso real, y por qué es imprescindible una alarma adicional de 'sensor que lleva X horas sin decir nada'.
7. La logística: qué pilas comprar y en qué cantidad para tener repuesto, cómo etiquetar cada sensor con la fecha del último cambio, y un calendario de sustitución preventiva agrupada para hacerlo todo en una sola visita en vez de en seis.
8. Qué hacer con las pilas usadas y qué error garrafal se comete al mezclar pilas nuevas y viejas o marcas distintas en el mismo sensor.

RESTRICCIONES
- Nada de recomendar pilas recargables en sensores de botón sin avisar de que la tensión menor puede hacer que el sensor deje de funcionar antes de tiempo.
- No inventes duraciones exactas de modelos concretos: da rangos y di que dependen del uso.
- Si un sensor vigila algo crítico, no puede depender solo de una pila: dilo y propón alternativa.

FORMATO DE LA RESPUESTA
A) Tabla 'Sensores': sensor | protocolo | pila | duración estimada | ajuste recomendado | duración esperada tras el ajuste.
B) 'Los que deberían ir a corriente' con el motivo.
C) 'Sistema de avisos': umbral de batería, alarma de silencio y a quién avisa.
D) 'Calendario de sustitución' anual, agrupado por visitas.
E) 'Lista de la compra' de pilas y etiquetas.
F) 'Errores que no debo cometer'.

CRITERIOS DE CALIDAD
- Ningún sensor crítico puede quedarse sin vigilancia sin que salte un aviso en menos de un día.
- Cada ajuste propuesto debe decir qué pierdo a cambio, no solo lo que gano.
- El calendario debe agrupar los cambios para que no haga más de dos visitas al año por instalación.
```
