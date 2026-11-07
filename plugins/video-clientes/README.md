# arsenal-video-clientes · Vídeo · Servicios de vídeo para clientes

Vídeo · Servicios de vídeo para clientes: 3 subagentes, 3 comandos /, 1 skill en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-video-clientes@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| guion-testimonio-cliente | Comando / | Te prepara la entrevista para grabar el testimonio de un cliente: qué preguntar, en qué orden, cómo montarlo y qué permisos pedirle. | `/guion-testimonio-cliente` o `/arsenal-video-clientes:guion-testimonio-cliente` |
| presupuesto-video | Comando / | Calcula y redacta el presupuesto de un vídeo para un cliente: partidas, horas reales, precio, qué incluye, qué no, y las condiciones que evitan problemas. | `/presupuesto-video` o `/arsenal-video-clientes:presupuesto-video` |
| testimonio-cliente | Comando / | Prepara la entrevista para grabar el testimonio de un cliente: las preguntas exactas, el orden, cómo sacarle frases usables y cómo montarlo después. | `/testimonio-cliente` o `/arsenal-video-clientes:testimonio-cliente` |
| montaje-video-como-servicio | Skill | Estructura un servicio de pago de edición de vídeo con DaVinci Resolve, CapCut o Kdenlive: paquetes, precios, plazos y entregables. | se activa sola cuando hace falta |
| presupuestador-de-videos-para-clientes | Subagente | Convierte el encargo en presupuesto desglosado: partidas, horas, revisiones, derechos de uso sin quedarte corto. | pídele a Claude «usa el subagente presupuestador-de-videos-para-clientes» |
| revisor-entregas-video | Subagente | Revisa un vídeo editado antes de entregarlo a un cliente de pago: checklist técnico y de contrato para DaVinci Resolve, CapCut o Kdenlive. | pídele a Claude «usa el subagente revisor-entregas-video» |
| testimonial-de-cliente | Subagente | Subagente que dirige un vídeo testimonial de cliente: las preguntas, cómo guiar a quien no sabe hablar a cámara y el permiso por escrito. | pídele a Claude «usa el subagente testimonial-de-cliente» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
