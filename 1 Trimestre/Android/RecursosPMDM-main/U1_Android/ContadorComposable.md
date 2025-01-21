# Contador Composable

## Clase MainActivity

- **Esta clase extiende ComponentActivity**, que es una de las clases base para actividades en Jetpack Compose.

## Método onCreate

- **Se llama cuando se crea la actividad**. Aquí se configura la interfaz de usuario y se establece el contenido de la actividad utilizando una función composable.

## Función ComptadorApp

- **Esta función composable define toda la interfaz de usuario**.
- **comptador**: Se utiliza `rememberSaveable` para mantener el valor del contador entre rotaciones de pantalla.

## Estructura de la Interfaz

- Se utiliza un `Scaffold` para definir la estructura básica de la interfaz.
- Un `Column` organiza el contenido verticalmente, alineando los elementos en el centro.

## Elementos de la Interfaz

- Creamos un `Row`  que contiene botones para incrementar, decrementar y resetear el contador.
