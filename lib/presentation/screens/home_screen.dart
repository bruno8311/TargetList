
import 'package:flutter/material.dart';
import 'details_screen.dart';
import 'form_screen.dart';
import '../../models/card_item.dart';
import 'package:provider/provider.dart';
import '../providers/card_provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // Navega a la pantalla de detalles
  Future _navigateToDetails(CardItem card, int index) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(card: card, index: index)));
    final isResultValid = result != null && result is Map<String, dynamic>;
    if (isResultValid) {
      _handleDetailsResult(result);
    }
  }

  // Navega a la pantalla de formulario
  Future _navigateToForm() async {
    final nuevoItem = await Navigator.push<CardItem>(
      context,
      MaterialPageRoute(builder: (context) => const FormScreen()),
    );
    
    if (nuevoItem != null) {
      _addCard(nuevoItem);
    }
  }

  // Maneja el resultado de la pantalla de detalles, (editar o elimina la tarjeta).
  void _handleDetailsResult(Map<String, dynamic> result) {
    final provider = Provider.of<CardProvider>(context, listen: false);
    final isEditCard = result['accion'] == 'editar' && result['item'] != null && result['index'] != null;
    if (isEditCard) {
      provider.editCard(result['index'], result['item']);
    } else if (result['accion'] == 'eliminar' && result['index'] != null) {
      provider.removeCard(result['index']);
    }
  }

  // Maneja el resultado de la pantalla de formulario (agrega una nueva tarjeta).
  void _addCard(CardItem newCard) {
    final provider = Provider.of<CardProvider>(context, listen: false);
    provider.addCard(newCard);
  }


  //Metodo para construir la pantalla principal
  @override
  Widget build(BuildContext context) {
    final cards = context.watch<CardProvider>().listElements;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Tarjetas'),
        backgroundColor: Colors.blue.shade400,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: ListView.builder(
          itemCount: cards.length, //Total de elementos extraidos del provider
          itemBuilder: (BuildContext context, int index) {
            final card = cards[index];
            return _buildCardTile(card, index);
         }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToForm,
        tooltip: 'Agregar nueva tarjeta',
        child: const Icon(Icons.add),
      ),
    );
  }
  // Widgets
  Card _buildCardTile(CardItem card, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 5,
      color: Colors.blue.shade100,
      child: ListTile(
        title: Text(card.titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.arrow_forward),
        leading: _buildLeadingAvatar(card),
        subtitle: _buildSubtitle(card), 
        onTap: () => _navigateToDetails(card, index),
      ),
    );
  }

  Widget _buildLeadingAvatar(CardItem card) {
    return card.imageUrl != null 
      ? CircleAvatar(
          backgroundImage: NetworkImage(card.imageUrl!),
        )
      : const CircleAvatar(
          backgroundColor: Colors.lightBlue,
          child: Icon(Icons.image, color: Colors.white),
        );
  }

  Widget _buildSubtitle(CardItem card) {
    return Text(
      card.descripcion.length > 100 
        ? '${card.descripcion.substring(0, 100)}...'
        : card.descripcion,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

}