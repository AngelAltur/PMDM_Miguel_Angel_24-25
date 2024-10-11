# ContadorMVVN

## Clase MainActivity

## ViewModel

- **comptadorViewModel**: Se utiliza para obtener una instancia del `ComptadorViewModel`. Este patrón permite gestionar datos de forma que sobrevivan a cambios de configuración (como la rotación de pantalla).

## Método onCreate

- **Este método se llama cuando se crea la actividad**. Aquí se configura la interfaz de usuario.

## Enlace de Vista

- `setContentView(R.layout.activity_main)`: Asigna el diseño XML a la actividad.
- Se ajustan los márgenes para tener en cuenta las barras del sistema.

## Referencias a Vistas

- Se obtienen referencias a los elementos de la interfaz (TextView y botones) mediante `findViewById`.

## Observadores de LiveData

- Se establece un observador en `comptador`, el LiveData del ViewModel. Cada vez que cambie el valor, se actualizará el TextView correspondiente.

## Listeners para Botones

- Los botones de sumar, restar y resetear están configurados para llamar a métodos del ViewModel que gestionan el contador.

## Abrir Nueva Actividad

- Al hacer clic en el botón `btOpen`, se inicia `MostraComptadorActivity`, pasando el valor actual del contador como extra.

Este enfoque utiliza el patrón de arquitectura **MVVM (Modelo-Vista-ViewModel)** .
