import 'package:flutter/material.dart';
import '../../domain/entities/card_item.dart';

class CardTile extends StatelessWidget {
  final CardItem card;
  final int index;
  final VoidCallback? onTap;

  const CardTile({
    super.key,
    required this.card,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 5,
      color: Colors.blue.shade100,
      child: ListTile(
        title: Text(card.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward),
        leading: _buildLeadingAvatar(),
        subtitle: _buildSubtitle(),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLeadingAvatar() {
    return card.imageUrl != null
      ? CircleAvatar(backgroundImage: NetworkImage(card.imageUrl!))
      : const CircleAvatar(
          backgroundColor: Colors.lightBlue,
          child: Icon(Icons.image, color: Colors.white),
        );
  }

  Widget _buildSubtitle() {
    return Text(
      card.description.length > 100
          ? '${card.description.substring(0, 100)}...'
          : card.description,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
