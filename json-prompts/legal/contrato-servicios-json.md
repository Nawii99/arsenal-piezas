# Contrato de prestación de servicios…

**Tipo:** JSON prompt · **Área:** Legal y contratos · **Licencia:** CC BY 4.0

Redacta un contrato de servicios completo: alcance, dinero, propiedad, RGPD, resolución. Base para negociar con un abogado.

## Qué es y qué hace

Es un prompt en JSON que redacta un contrato de servicios completo: alcance, dinero, propiedad, RGPD y resolución, con cláusulas cortas y numeradas. Entra las partes y las condiciones; sale un contrato base para negociar. Vale para Claude, Codex, Gemini o una IA local. No sustituye a un abogado.

## Cómo usarla

1. Rellena partes, alcance y precio
2. Pega el JSON en tu IA
3. Revisa penalizaciones y exclusividad con un abogado
4. Que lo revise un profesional

## Cuándo usarla

Cuando cierras un cliente nuevo o un proyecto de más de unas semanas. Rellena los corchetes, pégalo en Claude y te devuelve el contrato listo para firmar más la lista de lo que quedó sin rellenar.

## Cómo ganar dinero con ella

Tener contrato desde el primer cliente evita impagos y alcance infinito.

- Contratos base para agencias pequeñas que prestan servicios, por contrato…
- Plantilla de contrato con cláusula RGPD para autónomos, por licencia…
- Revisión de contratos de clientes antes de firmar, por contrato…

**Precio orientativo:** 40–100 € por contrato. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "rol": "Redactor de contratos de prestación de servicios para autónomos y agencias pequeñas en España. Escribes en castellano claro, sin latinajos, con cláusulas cortas y numeradas.",
  "aviso": "No eres abogado y lo dices en la primera línea del documento. El contrato es una base para negociar; si hay penalizaciones altas, exclusividad o un importe grande para el usuario, recomiendas que lo revise un abogado antes de firmar.",
  "tarea": "Redacta un contrato de prestación de servicios completo y listo para firmar con los datos de 'datos' y las condiciones de 'condiciones'. Si un dato sigue entre corchetes, pregúntalo antes de redactar. No inventes nada.",
  "datos": {
    "prestador": {
      "nombre": "[TU NOMBRE O EMPRESA]",
      "nif": "[TU NIF]",
      "domicilio": "[TU DIRECCIÓN FISCAL]",
      "forma_juridica": "[AUTÓNOMO / SL]"
    },
    "cliente": {
      "nombre": "[NOMBRE O RAZÓN SOCIAL DEL CLIENTE]",
      "nif": "[NIF DEL CLIENTE]",
      "domicilio": "[DIRECCIÓN DEL CLIENTE]",
      "representante": "[NOMBRE Y CARGO DE QUIEN FIRMA, SI ES EMPRESA]"
    },
    "servicio": {
      "descripcion": "[QUÉ VAS A HACER, EN UNA FRASE]",
      "entregables": ["[ENTREGABLE 1]", "[ENTREGABLE 2]", "[ENTREGABLE 3]"],
      "no_incluido": ["[LO QUE NO ENTRA, EJ: FOTOGRAFÍA, INVERSIÓN EN ANUNCIOS, TEXTOS LEGALES DE LA WEB]"],
      "revisiones_incluidas": "[NÚMERO DE RONDAS DE CAMBIOS]"
    },
    "plazos": {
      "inicio": "[FECHA DE INICIO]",
      "entrega_o_duracion": "[FECHA DE ENTREGA O DURACIÓN EN MESES]",
      "dependencias_del_cliente": "[QUÉ NECESITAS QUE EL CLIENTE TE DÉ Y CUÁNDO, EJ: ACCESOS Y MATERIALES EN 5 DÍAS LABORABLES]"
    }
  },
  "condiciones": {
    "precio": {
      "importe_sin_iva": "[IMPORTE] €",
      "iva": "21 %",
      "retencion_irpf": "[15 % / 7 % / NO APLICA]",
      "modalidad": "[PRECIO CERRADO / CUOTA MENSUAL]"
    },
    "pago": {
      "anticipo": "[PORCENTAJE, EJ: 50 %] a la firma, antes de empezar",
      "resto": "[CUÁNDO, EJ: A LA ENTREGA / EL DÍA 1 DE CADA MES]",
      "plazo_maximo_dias": 30,
      "metodo": "transferencia al IBAN que figure en cada factura",
      "demora": "interés de demora legal (Ley 3/2004) más 40 € por factura impagada en concepto de costes de cobro; el prestador puede parar el trabajo hasta que se cobre"
    },
    "propiedad_intelectual": {
      "cesion": "del resultado final entregado, solo una vez pagado el 100 % del precio",
      "conserva_el_prestador": "plantillas, métodos, herramientas, código base y conocimientos previos",
      "portfolio": "el prestador puede mostrar el trabajo como referencia, salvo que el cliente lo prohíba por escrito"
    },
    "confidencialidad": {
      "mutua": true,
      "duracion_tras_fin_contrato": "[AÑOS, EJ: 2]"
    },
    "proteccion_de_datos": {
      "si_el_prestador_maneja_datos_de_clientes_del_cliente": "añadir Anexo II de encargado del tratamiento según el artículo 28 del RGPD",
      "si_no": "cláusula breve de cumplimiento del RGPD y de la LOPDGDD por ambas partes"
    },
    "exclusividad": "ninguna, salvo pacto expreso por escrito y compensado económicamente",
    "responsabilidad": "limitada al importe total del contrato; sin responsabilidad por resultados de negocio del cliente (ventas, seguidores, posicionamiento) porque dependen de terceros",
    "cambios_de_alcance": "todo lo que no esté en los entregables se presupuesta aparte por escrito antes de hacerse",
    "resolucion": {
      "preaviso_dias": "[DÍAS, EJ: 15]",
      "por_impago": "el prestador puede resolver si el cliente no paga en plazo tras un requerimiento por escrito",
      "trabajo_hecho": "se factura lo realizado hasta la fecha de resolución y el anticipo no se devuelve"
    },
    "ley_y_jurisdiccion": {
      "ley": "española",
      "juzgados": "[CIUDAD DEL PRESTADOR]"
    }
  },
  "formato_salida": {
    "estructura": [
      "Aviso de que no es asesoramiento legal",
      "Título, lugar y fecha",
      "Reunidos: las dos partes con nombre, NIF y domicilio",
      "Exponen: contexto en dos frases",
      "Cláusulas numeradas: 1 Objeto y alcance, 2 Entregables y exclusiones, 3 Plazos y obligaciones del cliente, 4 Precio, imp
```
