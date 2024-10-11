# Contador

## MainActivity

- **comptador**: un contador inicializado en 0.
- **textViewContador**: una variable para el TextView que mostrará el valor del contador, inicializada más tarde.

## Método onCreate

- **Se llama cuando la actividad oncreate**. Configura la vista de la actividad y los listeners de los botones.
- **Referencias a Vistas**: Se obtienen referencias a los elementos de la interfaz (TextView y botones) a través de `findViewById`.

## Inicialización del Contador

- Se establece el valor inicial del TextView con el valor del contador.

## Listeners para Botones

- Se añaden listeners para los botones de sumar, restar y resetear el contador, actualizando el TextView cada vez que se modifica el contador.
- Habiendo creado los layouts y enlazandolos con su respectivo ID.

## Abrir Nueva Actividad

- Al hacer clic en el botón `btOpen`, se inicia una nueva actividad (`MostraComptadorActivity`), pasando el valor del contador.

## Manejo del Estado

- Se manejan los estados de la actividad para restaurar el contador al rotar el dispositivo o al recrear la actividad. Esto se hace mediante los métodos `onSaveInstanceState` y `onRestoreInstanceState`.

## Método actualizarContador

- Actualiza el TextView con el valor actual del contador
