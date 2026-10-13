# API REST en Go lista para producción…

**Tipo:** JSON prompt · **Área:** Backend · **Licencia:** CC BY 4.0

Genera un servicio HTTP en Go completo: estructura de carpetas, rutas, validación, errores, logs, apagado limpio y tests.

## Qué es y qué hace

JSON prompt que genera un servicio HTTP en Go con net/http. Entra el nombre, las entidades, los endpoints, la base de datos y la autenticación; sale una estructura de carpetas, rutas, validación, errores, logs, apagado limpio y tests. Se usa en cualquier chat de IA: Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Copia el JSON
2. Rellena entidades, endpoints y base de datos
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Compila, ejecuta los tests y arranca el servicio

## Cuándo usarla

Úsalo cuando necesitas montar el backend de una app o un servicio interno en Go y quieres empezar con una base ordenada, no con un main.go de 800 líneas.

## Cómo ganar dinero con ella

Te ahorra días de montar el esqueleto y evita rehacer la estructura cuando el proyecto crece.

- Esqueleto de backend en Go para apps y servicios internos de clientes…
- API REST a medida para pequeñas empresas con pocos endpoints…
- Plantilla de proyecto Go ordenada para equipos que empiezan…

**Precio orientativo:** 200–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Generar un servicio HTTP en Go idiomático, con estructura de proyecto, código compilable y tests",
  "rol": "Ingeniero de backend en Go con servicios en producción",
  "entradas": {
    "nombre_servicio": "[NOMBRE DEL SERVICIO]",
    "que_hace": "[QUÉ RESUELVE EL SERVICIO, EN DOS FRASES]",
    "entidades": "[ENTIDAD PRINCIPAL Y SUS CAMPOS, POR EJEMPLO: pedido: id, cliente, importe, estado]",
    "endpoints": "[LISTA DE ENDPOINTS QUE NECESITAS, O 'CRUD COMPLETO']",
    "base_de_datos": "[POSTGRESQL, SQLITE, MYSQL O NINGUNA POR AHORA]",
    "autenticacion": "[NINGUNA, CLAVE DE API O JWT]",
    "version_go": "[VERSIÓN DE GO, POR EJEMPLO 1.23]"
  },
  "decisiones_tecnicas": ["usa la librería estándar net/http con el enrutador de go1.22 o superior; añade chi solo si hacen falta middlewares encadenados", "capas separadas: handler que traduce HTTP, servicio con la lógica, repositorio que habla con la base de datos", "inyecta dependencias por struct en el constructor, nada de variables globales", "context.Context como primer parámetro en todo lo que haga entrada y salida, con timeouts", "pgx o database/sql con consultas escritas a mano; nada de ORM pesado"],
  "requisitos_obligatorios": ["validación de la entrada antes de tocar la lógica, con mensajes de error claros para el cliente", "errores devueltos en JSON con la misma forma siempre: codigo, mensaje y detalles", "logs estructurados con log/slog incluyendo un identificador de petición", "apagado limpio con señales SIGINT y SIGTERM y http.Server.Shutdown", "endpoint /healthz que compruebe también la base de datos", "timeouts de lectura, escritura y ocio configurados en el servidor", "envuelve errores con fmt.Errorf y %w, y no ignores nunca un error devuelto"],
  "errores_tipicos_a_evitar": ["usar panic para errores esperables", "guardar el contexto dentro de un struct", "olvidar defer rows.Close() y defer resp.Body.Close()", "lanzar goroutines sin forma de cancelarlas ni de esperar a que terminen"],
  "formato_salida": {
    "orden": ["árbol de carpetas comentado", "go.mod con las dependencias exactas", "un bloque de código por fichero, con la ruta como título", "fichero de tests con httptest para al menos dos endpoints", "comandos para arrancar y probar el servicio", "lista de lo que falta antes de ponerlo en producción"],
    "estilo_codigo": "gofmt, nombres cortos idiomáticos, comentarios solo donde no sea obvio"
  },
  "criterios_calidad": ["el código compila tal cual con go build ./... sin editar nada", "ningún error se descarta silenciosamente", "los tests pasan con go test ./... sin neces
```
