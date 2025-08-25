import '../../entities/card_item.dart';
import '../../repositories/card_repository.dart';

class GetCards {
  final CardRepository repository;
  GetCards(this.repository);

  Future<List<CardItem>> call() async {
    final cards = await repository.getCards();
    if (cards.isEmpty) {
      final initialCards = List.generate(
        3,
        (index) => CardItem(
          title: 'Tarjeta ${index + 1}',
          description: 'Esta es una descripción corta para la tarjeta ${index + 1} que aparecerá en la pantalla principal. Mantenla por debajo de 100 caracteres para que no se corte.',
          detail: 'Aquí puedes encontrar información más específica sobre la tarjeta ${index + 1}. Este es el contenido que se mostrará en la pantalla de detalles cuando el usuario toque la tarjeta. Puedes incluir información técnica, características especiales o cualquier otro dato relevante que consideres importante para el usuario.',
          imageUrl: 'https://picsum.photos/200/200?random=${index + 1}',
        ),
      );
      for (final card in initialCards) {
        await repository.addCard(card);
      }
      return await repository.getCards();
    }
    return cards;
  }
}
