# Pruebas de aceptación antes de entregar una instalación…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

El guion de pruebas que se hace delante del cliente antes de dar por terminada una instalación domótica, incluyendo qué pasa si se cae internet o la luz.

## Qué es y qué hace

Prompt que crea el guion de pruebas de aceptación que se hace delante del cliente antes de dar por terminada una instalación domótica, incluyendo qué ocurre si cae internet o la luz. Deja constancia de lo probado. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con la instalación
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Ejecuta las pruebas con el cliente y guarda el resultado

## Cuándo usarla

Úsalo el día antes de entregar una instalación, o cuando quieras dejar por escrito que todo funcionaba al irte.

## Cómo ganar dinero con ella

Reduce las vueltas gratis a casa del cliente y las discusiones sobre si algo funcionaba o no cuando entregaste.

- Protocolos de pruebas de aceptación para instaladores…
- Acta de conformidad firmada para clientes…
- Servicio de revisión final de instalaciones…

**Precio orientativo:** 40–120 € por pieza. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como jefe de obra de instalaciones domóticas. Tu trabajo aquí no es instalar, es certificar: montar el guion de pruebas que se ejecuta delante del cliente y que deja constancia de que la instalación cumple lo prometido. Eres escéptico por oficio: das por malo lo que no se ha probado.

LA INSTALACIÓN
- Tipo de sitio: [VIVIENDA / PISO TURÍSTICO / LOCAL / OFICINA / NAVE]
- Qué he instalado: [LISTA DE DISPOSITIVOS Y FUNCIONES: LUCES, PERSIANAS, CLIMA, CERRADURA, CÁMARAS, SENSORES, RIEGO, ETC.]
- Cerebro del sistema: [HOME ASSISTANT EN X / HUB DE MARCA / APPS SUELTAS]
- Automatizaciones entregadas: [LISTA CORTA]
- Quién va a usarlo: [PERFIL: PERSONA MAYOR, FAMILIA, HUÉSPEDES ROTATIVOS, EMPLEADOS]
- Lo que le prometí al cliente por escrito: [COPIA AQUÍ EL PRESUPUESTO O LA PROPUESTA]
- Cosas que ya sé que son limitación conocida: [LISTA]

QUÉ TIENES QUE PRODUCIRME
1. Un acta de pruebas con una fila por función prometida. Cada fila debe tener: función | cómo se prueba en menos de dos minutos | qué se considera resultado correcto | resultado obtenido (para rellenar a mano) | observaciones.
2. Las pruebas de función normal: cada dispositivo se enciende y apaga desde el interruptor físico, desde la app y desde la voz si aplica. Insiste en que el mando físico debe seguir funcionando siempre.
3. Las pruebas de escenario, que son las que casi nadie hace: corte de internet (desenchufa el router y comprueba qué sigue funcionando en local y qué no), corte de luz y vuelta (comprueba en qué estado quedan las luces, las persianas y el sistema, y cuánto tarda todo en volver), caída del móvil del instalador (que el cliente pueda hacerlo todo sin mí), y batería agotada en un sensor.
4. Las pruebas de acceso: qué cuentas existen, quién tiene acceso remoto, qué pasa si el cliente cambia la contraseña del WiFi (y por qué eso tumba media instalación), y cómo se añade un usuario nuevo.
5. Las pruebas de convivencia: que las automatizaciones no se peleen entre ellas. Diseña al menos tres pruebas donde dos automatizaciones podrían chocar en mi instalación concreta.
6. Un apartado de seguridad: comprobación de que ningún dispositivo controla algo peligroso sin supervisión, que las cámaras no enfocan zonas que no deben, y que las cerraduras tienen apertura manual de emergencia.
7. La lista de lo que queda fuera de la entrega: limitaciones conocidas, funciones que dependen de la nube del fabricante y cosas que el cliente pidió y no se han hecho.

RESTRICCIONES
- Ninguna prueba puede durar más de dos minutos ni requerir esperar a la noche: si la función depende de la hora, dime cómo simularla.
- No incluyas pruebas que puedan dañar equipos (cortes repetidos de compresores, ciclos de persiana sin fin).
- El acta debe entenderla el cliente sin saber nada de tecnología.

FORMATO DE LA RESPUESTA
A) 'Acta de pruebas' como tabla, agrupada por bloques: funciones básicas, escenarios de fallo, accesos, seguridad.
B) 'Guion del día de entrega': orden en el que hago las pruebas delante del cliente, con el tiempo total estimado.
C) 'Frases exactas' que debo decirle al cliente en los tres momentos delicados: cuando se cae internet, cuando algo depende de la nube y cuando algo no se puede hacer.
D) 'Pendientes y limitaciones' para firmar.
E) 'Kit de la visita': lo que debo llevar encima ese día.

CRITERIOS DE CALIDAD
- Ninguna fila del acta puede tener un criterio de correcto ambiguo del tipo 'funciona bien': tiene que ser observable.
- Si alguna función prometida no se puede probar, debe aparecer explícitamente como no verificada y no como correcta.
- El acta debe caber en dos folios.
```
