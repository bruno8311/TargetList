
import 'package:flutter/material.dart';

import 'details_screen.dart';
import 'form_screen.dart';
import '../../models/tarjeta_item.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //Lista inicial con 3 elementos
  final List<TarjetaItem> listElements = List.generate(3,
    (index) => TarjetaItem(
      titulo: 'Tarjeta ${index + 1}',
      descripcion: 'Esta es una breve descripcion de la tarjeta ${index + 1} que se mostrara en la pantalla principal, que sea menor de 100 caracteres para que no se corte.',
      detalle: 'Aquí puedes encontrar información más específica sobre la tarjeta ${index + 1}. Este es el contenido que se mostrará en la pantalla de detalles cuando el usuario toque la tarjeta. Puedes incluir información técnica, características especiales, o cualquier otro dato relevante que consideres importante para el usuario.',
      imageUrl: 'https://picsum.photos/200/200?random=${index + 1}',
    ),
  );

  // Navega a la pantalla de detalles
  Future _navigateToDetails(TarjetaItem item, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsScreen(item: item, index: index)),
    );
    
    if (result != null && result is Map<String, dynamic>) {
      _handleDetailsResult(result);
    }
  }

  // Navega a la pantalla de formulario
  Future _navigateToForm() async {
    final nuevoItem = await Navigator.push<TarjetaItem>(
      context,
      MaterialPageRoute(builder: (context) => const FormScreen()),
    );
    
    if (nuevoItem != null) {
      _addCard(nuevoItem);
    }
  }

  // Maneja el resultado de la pantalla de detalles, (editar o elimina la tarjeta).
  void _handleDetailsResult(Map<String, dynamic> result) {
    if (result['accion'] == 'editar' && result['item'] != null && result['index'] != null) {
      setState(() {
        listElements[result['index']] = result['item'];
      });
    } else if (result['accion'] == 'eliminar' && result['index'] != null) {
      setState(() {
        listElements.removeAt(result['index']);
      });
    }
  }

  // Maneja el resultado de la pantalla de formulario (agrega una nueva tarjeta).
  void _addCard(TarjetaItem newCard) {
    setState(() {
      listElements.add(newCard);
    });
  }

  // Widgets
  Widget _buildCardTile(TarjetaItem item, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 5,
      color: Colors.blue.shade100,
      child: ListTile(
        title: Text(item.titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.arrow_forward),
        leading: _buildLeadingAvatar(item),
        subtitle: _buildSubtitle(item),
        onTap: () => _navigateToDetails(item, index),
      ),
    );
  }

  Widget _buildLeadingAvatar(TarjetaItem item) {
    return item.imageUrl != null 
      ? CircleAvatar(
          backgroundImage: NetworkImage(item.imageUrl!),
        )
      : const CircleAvatar(
          backgroundColor: Colors.lightBlue,
          child: Icon(Icons.image, color: Colors.white),
        );
  }

  Widget _buildSubtitle(TarjetaItem item) {
    return Text(
      item.descripcion.length > 100 
        ? '${item.descripcion.substring(0, 100)}...'
        : item.descripcion,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  //Metodo para construir la pantalla principal
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Tarjetas'),
        backgroundColor: Colors.blue.shade400,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: ListView.builder(
          itemCount: listElements.length,
          itemBuilder: (BuildContext context, int index) {
            final item = listElements[index];
            return _buildCardTile(item, index);
         }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToForm,
        tooltip: 'Agregar nueva tarjeta',
        child: const Icon(Icons.add),
      ),
    );
  }
}