  import 'package:flutter/material.dart';
  import 'details_screen.dart';
  import 'form_screen.dart';
  import '../../domain/entities/card_item.dart';
  import 'package:provider/provider.dart';
  import '../providers/card_provider.dart';
  import '../widgets/card_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<CardProvider>(context, listen: false);
      await provider.loadCards(); // Carga inicial de tarjetas
    });
  }

  Future _navigateToDetails(CardItem card, int index) async {
    final result = await Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(card: card, index: index)
      ));
    final isResultValid = result != null;
    if (isResultValid) {
      _handleDetailsResult(result);
    }
  }

  Future _navigateToForm() async {
    final nuevoItem = await Navigator.push<CardItem>(context,
      MaterialPageRoute(
        builder: (context) => const FormScreen()
      ));
    final isItemValid = nuevoItem != null;
    if (isItemValid) {
      _addCard(nuevoItem);
    }
  }

  void _handleDetailsResult(Map<String, dynamic> result) {
    final provider = Provider.of<CardProvider>(context, listen: false);
    final isEditCard = result['accion'] == 'editar';
    if (isEditCard) {
      provider.editCard(result['index'], result['item']);
    } else if (result['accion'] == 'eliminar') {
      provider.removeCard(result['index']);
    }
  }

  void _addCard(CardItem newCard) {
    final provider = Provider.of<CardProvider>(context, listen: false);
    provider.addCard(newCard);
  }

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
          itemCount: cards.length,
          itemBuilder: (context, int index) {
            final card = cards[index];
            return CardTile(
              card: card,
              index: index,
              onTap: () => _navigateToDetails(card, index),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToForm,
        tooltip: 'Agregar nueva tarjeta',
        child: const Icon(Icons.add),
      ),
    );
  }
}
