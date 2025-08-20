
import 'package:flutter/material.dart';
import '../../models/card_item.dart';

class FormScreen extends StatefulWidget {
  final String? tituloInicial;
  final String? descripcionInicial;
  final String? detalleInicial;
  final String? imageUrlInicial;
  const FormScreen({super.key, this.tituloInicial, this.descripcionInicial, this.detalleInicial, this.imageUrlInicial});

  @override
  State<FormScreen> createState() => _FormScreenState();
}
class _FormScreenState extends State<FormScreen> {
  late final TextEditingController _tituloController;
  late final TextEditingController _descripcionController;
  late final TextEditingController _detalleController;
  late final TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.tituloInicial ?? '');
    _descripcionController = TextEditingController(text: widget.descripcionInicial ?? '');
    _detalleController = TextEditingController(text: widget.detalleInicial ?? '');
    _imageUrlController = TextEditingController(text: widget.imageUrlInicial ?? '');
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _detalleController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  // Métodos privados para validación y guardado
  bool _validateFields() {
    final titulo = _tituloController.text.trim();
    final descripcion = _descripcionController.text.trim();
    final detalle = _detalleController.text.trim();
    
    if (titulo.isEmpty || descripcion.isEmpty || detalle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Para guardar, completa título, descripción y detalle')),
      );
      return false;
    }
    return true;
  }

  CardItem _createCardItem() {
    final titulo = _tituloController.text.trim();
    final descripcion = _descripcionController.text.trim();
    final detalle = _detalleController.text.trim();
    final imageUrl = _imageUrlController.text.trim();
    
    return CardItem(
      titulo: titulo, 
      descripcion: descripcion,
      detalle: detalle,
      imageUrl: imageUrl.isEmpty ? null : imageUrl,
    );
  }

  void _saveAndReturn() {
    if (!_validateFields()) return;
    
    final nuevoItem = _createCardItem();
    Navigator.pop(context, nuevoItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar/Editar Tarjeta'),
        backgroundColor: Colors.blue.shade400,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción breve',
                hintText: 'Resumen que aparecerá en la lista',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _detalleController,
              decoration: const InputDecoration(
                labelText: 'Detalle completo',
                hintText: 'Información detallada que aparecerá en la pantalla de detalles',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _imageUrlController,
              decoration: const InputDecoration(
                labelText: 'URL de imagen (opcional)',
                hintText: 'https://ejemplo.com/imagen.jpg',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.image),
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _saveAndReturn,
              icon: const Icon(Icons.save),
              label: const Text('Guardar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
