import 'package:flutter/material.dart';
import '../../domain/entities/card_item.dart';
import 'form_screen.dart';
import '../widgets/action_buttons_widget.dart';
import '../widgets/image_section_widget.dart';
import 'package:provider/provider.dart';
import '../providers/card_provider.dart';

class DetailsScreen extends StatelessWidget {

  //Propiedades requeridas para el widget
  final CardItem card;
  final int index;
  const DetailsScreen({super.key, required this.card, required this.index});

  // Metodos privados para manejar la navegación y acciones
  Future<void> _navigateToEditForm(BuildContext context) async {
    await Navigator.push<CardItem>(
      context,
      MaterialPageRoute(
        builder: (context) => FormScreen(
          initialTitle: card.title,
          initialDescription: card.description,
          initialDetail: card.detail,
          initialImageUrl: card.imageUrl,
          index: index,
        ),
      ),
    );
  }

  void _returnDeleteResult(BuildContext context) {
      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.removeCard(index); //Elimina tarjeta
      Navigator.of(context).popUntil((route) => route.isFirst);
  }

  //Metodo para construir la pantalla de detalles
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.title),
        backgroundColor: Colors.blue.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            ImageSectionWidget(imageUrl: card.imageUrl),
            const SizedBox(height: 16),
            _buildSectionTitle(context, 'Descripción:'),
            const SizedBox(height: 8),
            _buildSectionContent(context, card.description),
            const SizedBox(height: 8),
            _buildSectionTitle(context, 'Detalle:'),
            const SizedBox(height: 8),
            _buildSectionContent(context, card.detail),
            const SizedBox(height: 16),
            ActionButtonsWidget(
              onEdit: () => _navigateToEditForm(context),
              onDelete: () => _returnDeleteResult(context),
            ),
          ],
        ),
      ),
    );
  }

  //Widgets:
  // ...existing code...

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
}
