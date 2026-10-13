# Menú semanal y lista de la compra para tus clientes…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Genera cada domingo el menú de la semana de cada cliente a partir de su plan, saca la lista de la compra agrupada por pasillo y se la manda por email en PDF.

## Qué es y qué hace

Cada domingo lee en Google Sheets los planes de cada cliente y sus recetas, reparte comidas sin repetir, suma los ingredientes y envía por Gmail el menú diario con la lista de la compra agrupada por sección. Entrada: hojas Clientes, Recetas e Historial; salida: correo con menú y lista. Se monta en n8n. No usa IA: reparte menús que tú has diseñado.

## Cómo usarla

1. Define planes y recetas en la hoja
2. Carga los ingredientes con formato tomate|2 uds|verduras
3. Programa el envío de los domingos
4. Que lo revise un profesional

## Cuándo usarla

Cuando das planes de alimentación o entrenamiento con comidas y pierdes las tardes de los domingos copiando y pegando menús y listas para cada persona.

## Cómo ganar dinero con ella

Si tienes 20 clientes y tardabas 15 minutos con cada uno, son 5 horas semanales. A 30 €/hora son 600 € al mes de tu tiempo recuperado.

- Menús semanales y listas de la compra para nutricionistas con veinte o más clientes.
- Plantillas de planes de comida para entrenadores que incluyen pauta de alimentación.
- Listas de la compra agrupadas por pasillo para un servicio de dietas personalizadas.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Los domingos por la mañana coge la plantilla de menús de cada cliente (que tú has definido una vez), rota las comidas para que no repitan siempre lo mismo, suma los ingredientes de la semana y manda un email con el menú día a día y la lista de la compra agrupada por sección del supermercado.
Para nutricionistas, dietistas, coaches de salud y entrenadores que incluyen pauta de comidas. Ojo: esto reparte menús que TÚ has diseñado, no calcula ni recomienda nada por su cuenta.

## Lo que necesitas antes
- Google Sheet con tres pestañas.
- `Clientes`: nombre, email, plan (por ejemplo `equilibrado`, `vegetariano`, `sin_gluten`), activo.
- `Recetas`: plan, momento (desayuno/comida/cena), nombre_receta, ingredientes (separados por punto y coma, con formato `tomate|2 uds|verduras`).
- `Historial`: cliente, semana, recetas_usadas.
- Gmail conectado en n8n.
- Nada de IA ni claves de pago: todo sale de tus propias recetas.

## Los nodos, en orden
1. **Schedule Trigger** – Cron `0 10 * * 0` (domingos a las 10:00), Timezone Europe/Madrid.
2. **Google Sheets** – Read Rows de `Clientes`. **Filter**: `activo` igual a `si`.
3. **Google Sheets** – Read Rows de `Recetas`, Return All activado.
4. **Split In Batches** – Batch Size: 1. Procesas un cliente cada vez.
5. **Code** – elige 7 desayunos, 7 comidas y 7 cenas del plan de ese cliente evitando las de la semana pasada, y monta el menú y la lista agrupada. Código abajo.
6. **Gmail** – Send. To: el email del cliente. Subject: `Tu menú del {{ $json.semana }}`. Email Type: HTML, Message: `={{ $json.html }}`.
7. **Google Sheets** – Append en `Historial` con cliente, semana y las recetas usadas separadas por punto y coma.
8. Conecta la salida del paso 7 de vuelta al **Split In Batches** para pasar al siguiente cliente.
9. (Opcional) **Convert to File** con Operation: Convert to HTML no existe como PDF; si quieres PDF de verdad, añade un **HTTP Request** a un servicio de HTML a PDF, pero el email en HTML se imprime perfectamente desde el móvil y ahorra el paso.

## El código del nodo Code (paso 5)
```
const cliente = $json;
const recetas = $('Google Sheets1').all().map(i => i.json).filter(r => r.plan === cliente.plan);
const hist = $('Google Sheets2').all().map(i => i.json).filter(h => h.cliente === cliente.nombre);
const usadas = hist.length ? (hist[hist.length - 1].recetas_usadas || '').split(';') : [];
const dias = ['Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo'];
function elegir(momento) {
  let pool = recetas.filter(r => r.momento === momento && !usadas.includes(r.nombre_receta));
  if (pool.length < 7) pool = recetas.filter(r => r.momento === momento);
  const barajado = pool.sort(() => Math.random() - 0.5);
  const out = [];
  for (let i = 0; i < 7; i++) out.push(barajado[i % barajado.length]);
  return out;
}
const des = elegir('desayuno'), com = elegir('comida'), cen = elegir('cena');
let html = `<h2>Menú de ${cliente.nombre}</h2><table border=1 cellpadding=6 style='border-collapse:collapse'><tr><th>Día</th><th>Desayuno</th><th>Comida</th><th>Cena</th></tr>`;
const compra = {};
dias.forEach((d, i) => {
  html += `<tr><td>${d}</td><td>${des[i].nombre_receta}</td><td>${com[i].nombre_receta}</td><td>${cen[i].nombre_receta}</td></tr>`;
  [des[i], com[i], cen[i]].forEach(r => {
    (r.ingredientes || '').split(';').forEach(ing => {
      const p = ing.split('|');
      if (p.length < 3) return;
      const clave = p[2].trim() + '||' + p[0].trim();
      compra[clave] = (compra[clave] || 0) + 1;
    });
  });
});
html += '</table><h3>Lista de la compra</h3>';
const porSeccion = {};
Object.keys(compra).forEach(k => { const [sec, item] = k.split('||'); (porSeccion[sec] = porSeccion[sec] || []).push(`${item} (x${compra[k]})`); });
Object.keys(porSeccion).sort().forEach(sec => { html += `<p><b>${sec}</b><br>${porSeccion[sec].join('<br>')}</p>`; });
const usadasAhora = [...des, ...com, ...cen].map(r => r.nombre_receta).join(';');
return [{ json: { html, semana: new Date().toLocaleDateString('es-ES'), recetas_usadas: usadasAhora, cliente: cliente.nombre } }];
```

## Cómo probarla
- Rellena `Recetas` con al menos 10 recetas por momento para un plan, y un cliente de prueba con tu email.
- Ejecuta a mano y revisa el email: 21 comidas, sin huecos vacíos, y la lista agrupada por sección.
- Ejecútalo dos domingos seguidos (o borra el historial y repite) y comprueba que las recetas cambian.
- Prueba con un plan que tenga solo 4 recetas por momento: debe repetir sin romperse, gracias al `% barajado.length`.

## Qué puede salir mal
- **Recetas mal escritas**: si un ingrediente no tiene los tres trozos separados por `|`, se ignora en silencio. Revisa la hoja con una columna de comprobación.
- **Cantidades sumadas en bruto**: el código cuenta veces, no gramos. Si necesitas cantidades reales, cambia `compra[clave] + 1` por sumar el número que pongas en el segundo trozo y arrastra la unidad.
- **Nombres de nodos en el Code**: `$('Google Sheets1')` depende del nombre exacto del nodo en tu lienzo. Renómbralos a `Recetas` e `Historial` y usa esos nombres, es mucho más claro.
- **Alergias**: si un cliente tiene alergias, no lo dejes al azar. Crea un plan propio para él con solo recetas seguras. La automatización no filtra nada que tú no hayas separado antes.
- **Emails muy pesados**: si metes imágenes de cada plato, el correo se corta en Gmail a 102 KB. Sube las fotos a Drive y enlaza.

## Cuánto cuesta
- 0 €. Sheets, Gmail, Drive y n8n auto-alojado.
- Solo si generas PDF con un servicio externo tendrás un coste, y suelen tener capa gratuita de unos 100-500 documentos al mes.
