import 'package:flutter/material.dart';
import '../../models/card_item.dart';
import 'form_screen.dart';

class DetailsScreen extends StatelessWidget {

  //Propiedades requeridas para el widget
  final CardItem card;
  final int index;
  const DetailsScreen({super.key, required this.card, required this.index});

  // Metodos privados para manejar la navegación y acciones
  Future<void> _navigateToEditForm(BuildContext context) async {
    final editedItem = await Navigator.push<CardItem>(
      context,
      MaterialPageRoute(
        builder: (context) => FormScreen(
          tituloInicial: card.titulo,
          descripcionInicial: card.descripcion,
          detalleInicial: card.detalle,
          imageUrlInicial: card.imageUrl,
        ),
      ),
    );
    
    if (editedItem != null && context.mounted) {
      _returnEditResult(context, editedItem);
    }
  }

  void _returnEditResult(BuildContext context, CardItem editedItem) {
    Navigator.pop(context, {
      'accion': 'editar', 
      'item': editedItem, 
      'index': index
    });
  }

  void _returnDeleteResult(BuildContext context) {
    Navigator.pop(context, {
      'accion': 'eliminar', 
      'index': index
    });
  }

  //Metodo para construir la pantalla de detalles
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.titulo),
        backgroundColor: Colors.blue.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildImageSection(),
            const SizedBox(height: 16),
            _buildSectionTitle(context, 'Descripción:'),
            const SizedBox(height: 8),
            _buildSectionContent(context, card.descripcion),
            const SizedBox(height: 8),
            _buildSectionTitle(context, 'Detalle:'),
            const SizedBox(height: 8),
            _buildSectionContent(context, card.detalle),
            const SizedBox(height: 16),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  //Widgets:
  Widget _buildImageSection() {
    return Column(
      children: [
        Center(
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: card.imageUrl != null ? Image.network(
                card.imageUrl!
              ) : Icon(Icons.image, color: Colors.white)
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSectionContent(BuildContext context, String description) {
    return Text(
      description,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _navigateToEditForm(context),
            icon: const Icon(Icons.edit),
            label: const Text('Editar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade100,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _returnDeleteResult(context),
            icon: const Icon(Icons.delete),
            label: const Text('Eliminar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

}
