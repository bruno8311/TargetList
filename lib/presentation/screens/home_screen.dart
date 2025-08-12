
import 'package:flutter/material.dart';

import 'details_screen.dart';
import 'form_screen.dart';
import '../../models/tarjeta_item.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key}); //Constructor pasa la clave Key al widget Padre para identificar al widget.

  @override
  State<HomeScreen> createState() => _HomeScreenState(); //Manejar el estado con _HomeScreenState
}

class _HomeScreenState extends State<HomeScreen> {

  //Lista inicial con 5 elementos
  final List<TarjetaItem> listElements = List.generate(5,
    (index) => TarjetaItem(
      titulo: 'Tarjeta ${index + 1}',
      descripcion: 'Descripción de la tarjeta ${index + 1}',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold( //Estructura visual basica para una pantalla
      appBar: AppBar(
        title: const Text('Listado de Tarjetas'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: listElements.length,
        itemBuilder: (BuildContext context, int index) {
            final item = listElements[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.blue,
              child: ListTile(
                title: Text(item.titulo),
                subtitle: Text(item.descripcion),
                trailing: Icon(Icons.arrow_forward),
                onTap: () async {
                  final result = await Navigator.push(context, 
                                MaterialPageRoute(builder: (context) => DetailsScreen(item: item, index: index)),
                  );
                  // Procesa el resultado devuelto desde DetailsScreen:
                  // Si la acción es 'editar', actualiza el elemento en la lista usando el índice.
                  // Si la acción es 'eliminar', elimina el elemento de la lista usando el índice.
                  if (result != null && result is Map) {
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
                },
              )
            );
         })
      ,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nuevoItem = await Navigator.push<TarjetaItem>(
            context,
            MaterialPageRoute(
              builder: (context) => const FormScreen(),
            ),
          );
          if (nuevoItem != null) {
            setState(() {
              listElements.add(nuevoItem);
            });
          }
        },
        tooltip: 'Agregar nueva tarjeta',
        child: const Icon(Icons.add),
      ),
    );
  }
}