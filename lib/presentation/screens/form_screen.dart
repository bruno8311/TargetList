
import 'package:flutter/material.dart';
import '../../domain/entities/card_item.dart';

class FormScreen extends StatefulWidget {
  final String? initialTitle;
  final String? initialDescription;
  final String? initialDetail;
  final String? initialImageUrl;
  const FormScreen({super.key, this.initialTitle, this.initialDescription, this.initialDetail, this.initialImageUrl});

  @override
  State<FormScreen> createState() => _FormScreenState();
}
class _FormScreenState extends State<FormScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _detailController;
  late final TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
  _titleController = TextEditingController(text: widget.initialTitle ?? '');
  _descriptionController = TextEditingController(text: widget.initialDescription ?? '');
  _detailController = TextEditingController(text: widget.initialDetail ?? '');
  _imageUrlController = TextEditingController(text: widget.initialImageUrl ?? '');
  }

  @override
  void dispose() {
  _titleController.dispose();
  _descriptionController.dispose();
  _detailController.dispose();
  _imageUrlController.dispose();
    super.dispose();
  }

  // Métodos privados para validación y guardado
  bool _validateFields() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final detail = _detailController.text.trim();
    
    if (title.isEmpty || description.isEmpty || detail.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('To save, complete title, description and detail')),
      );
      return false;
    }
    return true;
  }

  CardItem _createCardItem() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final detail = _detailController.text.trim();
    final imageUrl = _imageUrlController.text.trim();
    
    return CardItem(
      title: title,
      description: description,
      detail: detail,
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
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción breve',
                hintText: 'Resumen que aparecerá en la lista',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _detailController,
              decoration: const InputDecoration(
                labelText: 'Detalle completo',
                hintText: 'Información detallada que aparecerá en la pantalla de detalle',
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
