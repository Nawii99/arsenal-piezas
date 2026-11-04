# arsenal-datos-ia-agentes · Datos e IA · Agentes y chatbots

Datos e IA · Agentes y chatbots: 14 comandos /, 7 subagentes, 1 skill en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-datos-ia-agentes@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| auditar-inyeccion | Comando / | Revisa tu bot o agente frente a los trucos con los que un desconocido le hace saltarse las reglas o soltar información que no debe. | `/auditar-inyeccion` |
| banco-de-pruebas | Comando / | Monta un banco de 12 casos difíciles para tu prompt, lo pasa, puntúa cada respuesta y te devuelve el prompt corregido. | `/banco-de-pruebas` |
| banco-pruebas | Comando / | Monta un banco de casos de prueba para tu prompt o tu agente y lo puntúa, para saber si un cambio mejora o empeora. | `/banco-pruebas` |
| clientes-dificiles | Comando / | Pone a tu chatbot delante de 10 clientes simulados complicados, mantiene la conversación y te lista los fallos con su arreglo. | `/clientes-dificiles` |
| coste-por-conversacion | Comando / | Calcula cuánto te cuesta cada conversación o tarea de tu agente y te da las palancas concretas para bajar la factura. | `/coste-por-conversacion` |
| diagnostico-agente | Comando / | Analiza una conversación concreta en la que tu bot o agente respondió mal y te dice dónde está la causa y qué línea cambiar. | `/diagnostico-agente` |
| encargo-agente | Comando / | Te hace las preguntas correctas y convierte un «quiero un bot con IA» en un encargo cerrado: alcance, datos, límites y criterio de aceptación. | `/encargo-agente` |
| limites-del-bot | Comando / | Escribe los límites de tu agente: qué no puede prometer ni decir, con qué frases exactas se escaquea y cómo se comprueba que aguanta. | `/limites-del-bot` |
| memoria-del-agente | Comando / | Decide qué debe recordar tu agente de cada cliente entre conversaciones, en qué formato guardarlo y qué no guardar nunca. | `/memoria-del-agente` |
| panel-agente | Comando / | Define qué registrar de tu agente en marcha y monta la revisión semanal de 20 minutos que detecta los problemas antes que el cliente. | `/panel-agente` |
| pasar-a-humano | Comando / | Diseña el traspaso del bot a una persona: cuándo salta, qué mensaje da al cliente y qué resumen le llega a quien atiende. | `/pasar-a-humano` |
| plan-b-si-falla-la-ia | Comando / | Prepara qué pasa cuando la IA se cae, tarda o responde mal: mensajes al cliente, reintentos, aviso a ti y cola manual. | `/plan-b-si-falla-la-ia` |
| revisar-conversaciones | Comando / | Analiza las conversaciones reales de tu bot, saca los motivos por los que falla y te da los cambios exactos que hay que hacer. | `/revisar-conversaciones` |
| traspaso-agente | Comando / | Prepara la entrega de un sistema de IA al cliente: manual corto, qué hacer si falla y qué es mantenimiento y qué no. | `/traspaso-agente` |
| rag-que-no-se-inventa | Skill | Skill para montar y arreglar una IA que responde sobre tus documentos, evitando los fallos tipicos de troceado, buscador y evaluacion. | se activa sola cuando hace falta |
| analista-de-conversaciones-del-bot | Subagente | Extrae de tus conversaciones reales qué preguntan los clientes y dónde se te pierden. | pídele a Claude «usa el subagente analista-de-conversaciones-del-bot» |
| auditor-de-prompts | Subagente | Coge un prompt que da resultados irregulares: desmonta, encuentra por qué falla, versión reescrita. | pídele a Claude «usa el subagente auditor-de-prompts» |
| auditor-rag-documentos | Subagente | Revisa un sistema de preguntas y respuestas sobre documentos de un cliente y dice, con pruebas, si responde bien o se inventa cosas. | pídele a Claude «usa el subagente auditor-rag-documentos» |
| banco-de-pruebas-de-asistentes | Subagente | Subagente que crea un banco de casos de prueba y una rúbrica para saber, con datos, si tu asistente de IA responde bien o mal. | pídele a Claude «usa el subagente banco-de-pruebas-de-asistentes» |
| guionista-de-bot-de-whatsapp | Subagente | Subagente que escribe el guion completo de un bot de atención por WhatsApp: qué contesta, qué no toca y cuándo pasa la conversación a una persona. | pídele a Claude «usa el subagente guionista-de-bot-de-whatsapp» |
| preparador-de-base-de-conocimiento | Subagente | Ordena tus PDFs, emails y notas para que un chatbot responda bien desde ellas sin fallar. | pídele a Claude «usa el subagente preparador-de-base-de-conocimiento» |
| red-team-de-tu-bot | Subagente | Subagente que ataca tu propio chatbot público para encontrar por dónde se le saca información, se le hace prometer cosas o se le cambia el papel. | pídele a Claude «usa el subagente red-team-de-tu-bot» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
