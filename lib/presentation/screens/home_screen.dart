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
      await provider.loadCards();
    });
  }

  Future _navigateToDetails(CardItem card, int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(card: card, index: index)
      ),
    );
  }

  Future _navigateToForm() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FormScreen()
      ),
    );
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
