
import 'package:flutter/material.dart';
import '../../models/tarjeta_item.dart';


// Un formulario necesita ser StatefulWidget para manejar el estado de los campos de texto
// y poder reaccionar a los cambios del usuario.
class FormScreen extends StatefulWidget {
  final String? tituloInicial;
  final String? descripcionInicial;
  const FormScreen({super.key, this.tituloInicial, this.descripcionInicial});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

// La clase State almacena el estado mutable del widget
class _FormScreenState extends State<FormScreen> {
  // Controladores para leer y modificar el texto de los campos
  late final TextEditingController _tituloController;
  late final TextEditingController _descripcionController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.tituloInicial ?? '');
    _descripcionController = TextEditingController(text: widget.descripcionInicial ?? '');
  }

  @override
  void dispose() {
    // Es importante liberar los recursos de los controladores cuando el widget se destruye
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // El método build se llama cada vez que se actualiza el estado
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar/Editar Tarjeta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de texto para el título
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Campo de texto para la descripción
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(
                labelText: 'Ingrese descripción',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            // Botón para guardar el formulario
            ElevatedButton.icon(
              onPressed: () {
                // Validar que los campos no estén vacíos
                final titulo = _tituloController.text.trim();
                final descripcion = _descripcionController.text.trim();
                if (titulo.isEmpty || descripcion.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Completa todos los campos')),
                  );
                  return;
                }
                // Crear el nuevo elemento y devolverlo a la pantalla anterior
                final nuevoItem = TarjetaItem(titulo: titulo, descripcion: descripcion);
                Navigator.pop(context, nuevoItem);
              },
              icon: const Icon(Icons.save),
              label: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
