---
name: servicio-mantenimiento-iot
description: Diseña un servicio recurrente de monitorización y mantenimiento remoto para sistemas de hogar inteligente o IoT ya instalados, definiendo qué vigilar, umbrales de alerta, niveles de servicio, tiempos de respuesta, acceso remoto seguro y la oferta para el cliente. Úsala cuando el usuario haya entregado instalaciones y quiera ingresos recurrentes, o pregunte cómo conservar clientes después de terminar el trabajo.
---

# Servicio de mantenimiento remoto de instalaciones IoT

## Qué hace
Convierte una cartera de instalaciones entregadas en un servicio de cuota mensual: qué vigilar, cómo avisar, qué prometer y cómo venderlo.

## Cuándo se activa
Cuando el usuario quiere ingresos recurrentes, o cuando le llaman por averías y no sabe qué cobrar.

## Qué preguntar
1. ¿Cuántas instalaciones tienes entregadas y de qué tipo?
2. ¿Tienes acceso remoto a alguna? ¿Cómo?
3. ¿Qué averías te han llamado en el último año? Esa lista es el catálogo del servicio.
4. ¿Cuánto tiempo puedes dedicar a la semana de forma realista?

## Método
### 1. Define qué se vigila de verdad
- Última vez que se ha visto cada dispositivo: la alerta más valiosa es «este sensor lleva 12 horas mudo».
- Nivel de batería con umbral de aviso, no de agotamiento. Avisa al 25 por ciento, no al 5.
- Calidad de señal de cada nodo: una caída sostenida anuncia la avería antes de que ocurra.
- Estado del hub: espacio en disco, copias de seguridad, versión.
- Cortes de corriente y de internet, con su duración.

### 2. Umbrales con cabeza
Todo aviso debe tener antirrebote y silencio nocturno salvo lo crítico. Un sistema que manda diez avisos al día se ignora en una semana y entonces no vale nada.

### 3. Acceso remoto seguro
- No abras puertos al exterior. Nunca.
- Usa una red privada superpuesta (tipo Tailscale, WireGuard o similar) o el acceso remoto oficial del sistema.
- Cuenta separada por cliente, contraseña única guardada en un gestor y doble factor.
- Deja por escrito qué puedes ver y qué no: la confianza es el producto.

### 4. Copias de seguridad
Automatiza la copia de la configuración del hub fuera del domicilio del cliente y prueba una restauración al menos una vez al año. Sin restauración probada, no tienes copia, tienes un fichero.

### 5. Los tres niveles del servicio
- Básico: vigilancia y aviso, actualizaciones, informe trimestral. Sin desplazamientos.
- Estándar: lo anterior más una visita anual, soporte telefónico y cambio de pilas incluido.
- Prioritario: lo anterior más tiempo de respuesta comprometido y una intervención presencial incluida al año.
Define en cada nivel qué NO incluye y qué se factura aparte (material, ampliaciones, averías por manipulación del cliente).

### 6. Promesas honestas
Compromete tiempo de respuesta, no tiempo de resolución. «Te contesto en 24 horas laborables» se puede cumplir; «te lo arreglo en 24 horas» depende de un repuesto que no controlas.

### 7. Cómo venderlo
Ofrécelo en el momento de la entrega, con los tres primeros meses incluidos en el precio de la instalación. Cuando llegue la primera factura, el cliente ya habrá visto un aviso útil.

## Formato exacto de la respuesta
1. **Qué se monitoriza**, en tabla: Indicador | Umbral de aviso | Qué significa | Acción.
2. **Los tres planes**, en tabla comparativa, con lo incluido y lo excluido.
3. **Texto para el cliente**: media página explicando el servicio sin jerga.
4. **Cláusulas del contrato**: duración, preaviso de baja, exclusiones, protección de datos y acceso.
5. **Rutina semanal del instalador**: qué revisar cada lunes en 15 minutos.

## Errores típicos
- Vender mantenimiento sin tener monitorización: acabas haciendo de bombero gratis.
- Prometer respuesta 24/7 siendo una sola persona.
- No documentar el estado inicial: luego no sabes si algo lo rompió el cliente o venía así.
- Cobrar tan poco que una sola visita se come el año entero de cuota.

## Avisos honestos
- Acceder en remoto a la casa de un cliente implica responsabilidad sobre sus datos; hazlo con contrato y con el mínimo acceso necesario.
- Si el sistema incluye cámaras, aplica normativa de protección de datos específica antes de tocarlo.
