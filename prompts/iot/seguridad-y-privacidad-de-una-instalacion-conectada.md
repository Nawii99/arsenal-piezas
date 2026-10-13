# Seguridad y privacidad de una instalación conectada…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Prompt que revisa tu instalación de cámaras y sensores punto por punto: accesos, red, avisos, y qué debes informar a las personas que entran en el sitio.

## Qué es y qué hace

Prompt que revisa una instalación de cámaras y sensores: accesos, red y avisos, y qué informar a las personas que entran. Explica el riesgo real de cada agujero y propone medidas aplicables. Se usa en cualquier chat de IA para pequeños negocios y viviendas.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con sitio, aparatos y accesos
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Que lo revise un profesional

## Cuándo usarla

Úsalo antes o después de instalar cámaras, cerraduras o sensores en un negocio o en casa de un cliente, o si te preocupa que alguien acceda a tus dispositivos.

## Cómo ganar dinero con ella

Evita el disgusto y el coste de un acceso no autorizado o de una reclamación por grabar sin informar, y te permite ofrecer una revisión de seguridad como servicio aparte.

- Auditoría de seguridad de videovigilancia para negocios…
- Configuración segura de cámaras y accesos…
- Revisión anual de privacidad en instalaciones conectadas…

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como técnico especializado en asegurar instalaciones domóticas y de videovigilancia en pequeños negocios y viviendas en España. Eres práctico: propones medidas que la gente puede aplicar de verdad y explicas el riesgo real de cada agujero, sin alarmismo.

LA INSTALACIÓN A REVISAR
- Sitio: [VIVIENDA / LOCAL / ALOJAMIENTO TURÍSTICO / OFICINA / NAVE] en [CIUDAD]
- Dispositivos conectados, uno por línea: [TIPO | MARCA APROX | DÓNDE ESTÁ | GRABA IMAGEN O SONIDO SÍ/NO | ES DE MARCA CONOCIDA O GENÉRICO]
- Sistema central: [HOME ASSISTANT / NVR / APP DEL FABRICANTE / VARIAS APPS]
- Cómo accedo desde fuera: [APP DEL FABRICANTE / PUERTOS ABIERTOS EN EL ROUTER / VPN / TÚNEL / NO ACCEDO]
- Red: [UN SOLO WIFI PARA TODO / WIFI DE INVITADOS / VLAN], router: [DEL OPERADOR / PROPIO]
- Quién tiene acceso: [PERSONAS Y CON QUÉ CUENTA]
- Personas afectadas por las cámaras: [SOLO YO / EMPLEADOS / CLIENTES / HUÉSPEDES / VECINOS]
- Copias de seguridad: [NINGUNA / TARJETA SD / NUBE / DISCO]

LO QUE TIENES QUE HACER
1. Haz un mapa de riesgo en lenguaje llano: qué podría pasar de verdad en mi caso, quién lo haría y con qué consecuencia. Ordena de más probable a menos.
2. Revisa por capas y dime en cada una qué está mal o qué falta comprobar: cuentas y contraseñas (repetidas, de fábrica, sin verificación en dos pasos, compartidas por WhatsApp), acceso remoto (puertos abiertos al exterior, reenvío de puertos, uso de VPN o túnel), red (todo en la misma red que el ordenador de trabajo o el TPV, red separada para dispositivos, WiFi de invitados), dispositivos (firmware antiguo, aparatos genéricos que hablan con servidores desconocidos, aparatos sin actualizaciones), datos (dónde se guardan las grabaciones, cuánto tiempo, quién puede descargarlas, si se borran solas), y continuidad (qué pasa si se rompe el disco o cierra el fabricante).
3. Para cada punto flojo dame: riesgo en una frase, arreglo concreto paso a paso, tiempo aproximado y si necesita comprar algo.
4. Sobre las cámaras y micrófonos, cubre la parte de personas: dónde NO se debe grabar nunca, cartel informativo visible, informar a empleados y a huéspedes, qué se hace con las imágenes, cuánto tiempo se conservan y quién las puede ver. Dilo como buenas prácticas y recuérdame que confirme los requisitos legales concretos con un asesor, sin citar artículos.
5. Prioriza: dame las 5 acciones que hago HOY en menos de una hora, las 5 de esta semana y las 3 del mes que viene.
6. Escribe la POLÍTICA DE ACCESOS: quién tiene cuenta, con qué permisos, qué se hace cuando alguien deja el negocio, y cada cuánto se revisa la lista.
7. Añade una revisión periódica en 8 puntos que yo pueda repetir cada seis meses, en formato de lista para marcar.

RESTRICCIONES
- No propongas herramientas de ataque ni técnicas para vulnerar sistemas ajenos: esto es revisión defensiva de mi propia instalación.
- No cites leyes ni artículos concretos; habla de buenas prácticas y remite a un asesor para lo legal.
- Nada de "usa una contraseña segura" a secas: di cómo gestionarlas y qué hacer con las compartidas.
- Prioriza siempre lo que se arregla gratis antes que lo que se compra.

FORMATO DE RESPUESTA
A) MAPA DE RIESGO: 5 líneas ordenadas por probabilidad.
B) REVISIÓN POR CAPAS en tabla: Capa | Qué falla o hay que comprobar | Riesgo | Arreglo | Tiempo | ¿Hay que comprar algo?
C) PERSONAS Y CÁMARAS: dónde no grabar, cartel, información y conservación.
D) PLAN: hoy, esta semana, este mes.
E) POLÍTICA DE ACCESOS lista para copiar.
F) REVISIÓN SEMESTRAL en 8 puntos marcables.

CRITERIOS DE CALIDAD
- ¿Se ataca primero el acceso remoto mal hecho y las contraseñas, que es por donde entra casi todo?
- ¿Cada arreglo es ejecutable por alguien sin perfil técnico o dice claramente que necesita ayuda?
- ¿Se ha tratado la conservación y el borrado de grabaciones, no solo el acceso?
- ¿Existe una rutina repetible para que la revisión no sea de una sola vez?
```
