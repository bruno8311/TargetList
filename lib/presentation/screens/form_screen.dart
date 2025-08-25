
import 'package:flutter/material.dart';
import '../../domain/entities/card_item.dart';
import 'package:provider/provider.dart';
import '../providers/card_provider.dart';

class FormScreen extends StatefulWidget {
  final String? initialTitle;
  final String? initialDescription;
  final String? initialDetail;
  final String? initialImageUrl;
  final int? index;
  const FormScreen({
    super.key,
    this.initialTitle,
    this.initialDescription,
    this.initialDetail,
    this.initialImageUrl,
    this.index,
  });

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
        const SnackBar(content: Text('Para guardar, completa el título, la descripción y el detalle.')),
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

  void _handleSubmit({required bool isEdit}) {
    if (!_validateFields()) return;
    final nuevoItem = _createCardItem();
    final provider = Provider.of<CardProvider>(context, listen: false);
    if (isEdit) {
      provider.editCard(widget.index!, nuevoItem);
    } else {
      provider.addCard(nuevoItem);
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear/Editar Tarjeta'),
        backgroundColor: Colors.blue.shade400,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(_titleController, 'Título'),
            const SizedBox(height: 16),
            _buildTextField(_descriptionController, 'Descripción breve', hint: 'Resumen que aparecerá en la lista', maxLines: 2),
            const SizedBox(height: 16),
            _buildTextField(_detailController, 'Detalle completo', hint: 'Información detallada que aparecerá en la pantalla de detalle', maxLines: 5),
            const SizedBox(height: 16),
            _buildTextField(_imageUrlController, 'URL de imagen (opcional)', hint: 'https://ejemplo.com/imagen.jpg', icon: Icons.image),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _handleSubmit(isEdit: widget.index != null),
              icon: widget.index != null ? const Icon(Icons.save) : const Icon(Icons.add),
              label: widget.index != null ? const Text('Guardar cambios') : const Text('Crear nueva tarjeta'),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.index != null ? Colors.blue.shade100 : Colors.green.shade100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {String? hint, int maxLines = 1, IconData? icon}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
      maxLines: maxLines,
      keyboardType: icon == Icons.image ? TextInputType.url : TextInputType.text,
    );
  } 
}
