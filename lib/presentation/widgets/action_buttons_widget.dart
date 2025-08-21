import 'package:flutter/material.dart';

class ActionButtonsWidget extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ActionButtonsWidget({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onEdit,
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
            onPressed: onDelete,
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
