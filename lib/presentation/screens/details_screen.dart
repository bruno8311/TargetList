import 'package:flutter/material.dart';
import '../../models/tarjeta_item.dart';
import 'form_screen.dart';

class DetailsScreen extends StatelessWidget {
  final TarjetaItem item;
  final int index;
  const DetailsScreen({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.titulo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.titulo,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              item.descripcion,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      // Navegar a FormScreen para editar, pasando los valores actuales
                      final editado = await Navigator.push<TarjetaItem>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormScreen(
                            tituloInicial: item.titulo,
                            descripcionInicial: item.descripcion,
                          ),
                        ),
                      );
                      if (editado != null) {
                        // Devolver el item editado y el índice
                        Navigator.pop(context, {'accion': 'editar', 'item': editado, 'index': index});
                      }
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Devolver la acción de eliminar y el índice
                      Navigator.pop(context, {'accion': 'eliminar', 'index': index});
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Eliminar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
